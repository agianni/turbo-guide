# Provider or Tenant
# INGRESS_HOST=czviyamt.zero.sas.com
# INGRESS_HOST=chiefs.czviyamt.zero.sas.com
INGRESS_HOST=bengals.czviyamt.zero.sas.com

echo "Running apiMeta check against $INGRESS_HOST (FAILURES ONLY)"
for context in $(kubectl -n czviyamt get ingress  -o json | jq -r '.items[].spec.rules[0].http.paths[].path' | cut -d\( -f1); do
    curl -k -o /dev/null -s --fail https://${INGRESS_HOST}${context}/apiMeta || echo "Failed for $context"
done

echo "Running apiMeta check against $INGRESS_HOST (ALL)"
for context in $(kubectl -n czviyamt get ingress  -o json | jq -r '.items[].spec.rules[0].http.paths[].path' | cut -d\( -f1); do
    curl -k -s https://${INGRESS_HOST}${context}/apiMeta | jq '.' || echo "Failed for $context"
done
