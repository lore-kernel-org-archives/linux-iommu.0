From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 1/2] iommu - Enable debugfs exposure of the IOMMU
Date: Tue, 17 Apr 2018 18:55:49 +0100
Message-ID: <80b1e9e5-3048-391a-6d7d-adeeece1bf46@arm.com>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
	<152302066417.47565.4017200105445420643.stgit@sosxen2.amd.com>
	<1523663790.2747.4.camel@intel.com>
	<10e422dd-a3ca-8ecb-50fa-e7f131a55a12@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <10e422dd-a3ca-8ecb-50fa-e7f131a55a12-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Hook, Gary" <ghook-5C7GfCeVMHo@public.gmane.org>, "Mehta, Sohil" <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "gary.hook-5C7GfCeVMHo@public.gmane.org" <gary.hook-5C7GfCeVMHo@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gMTcvMDQvMTggMTg6MzYsIEhvb2ssIEdhcnkgd3JvdGU6Cj4gT24gNC8xMy8yMDE4IDc6NTUg
UE0sIE1laHRhLCBTb2hpbCB3cm90ZToKPj4gT24gRnJpLCAyMDE4LTA0LTA2IGF0IDA4OjE3IC0w
NTAwLCBHYXJ5IFIgSG9vayB3cm90ZToKPj4+ICtzdHJ1Y3QgZGVudHJ5ICppb21tdV9kZWJ1Z2Zz
X3NldHVwKHZvaWQpCj4+PiArewo+Pj4gK8KgwqDCoCBpZiAoIWRlYnVnZnNfaW5pdGlhbGl6ZWQo
KSkKPj4KPj4gVGhpcyBjaGVjayBpcyBwcm9iYWJseSBub3QgbmVlZGVkLgo+IAo+IEFoLCBzbyBp
dCBpc24ndC4gVGhhbmsgeW91Lgo+IAo+Pgo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBOVUxM
Owo+Pj4gKwo+Pj4gK8KgwqDCoCBpZiAoIWlvbW11X2RlYnVnZnNfZGlyKQo+Pj4gK8KgwqDCoMKg
wqDCoMKgIGlvbW11X2RlYnVnZnNfZGlyID0gZGVidWdmc19jcmVhdGVfZGlyKCJpb21tdSIsCj4+
PiBOVUxMKTsKPj4+ICsKPj4+ICvCoMKgwqAgaWYgKGlvbW11X2RlYnVnZnNfZGlyKQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgIHByX3dhcm4oIldBUk5JTkc6IElPTU1VIERFQlVHRlMgU1VQUE9SVCBIQVMg
QkVFTgo+Pj4gRU5BQkxFRCBJTiBUSElTIEtFUk5FTFxuIik7Cj4+PiArCj4+Cj4+IEFzIHRoaXMg
Z2V0cyBjYWxsZWQgZm9yIGVhY2ggSU9NTVUsIGRvIHlvdSB3YW50IHRvIHVzZSBwcl93YXJuX29u
Y2U/Cj4gCj4gVGhhdCB3b3JrcywgeWVzLgoKT3IgSSBndWVzcyB5b3UgY291bGQganVzdCByb2xs
IHRoZSBwcl93YXJuKCkgaW50byB0aGUgcHJldmlvdXMgaWYoKSAKY29uZGl0aW9uLCBpLmUuIG9u
bHkgd2FybiB3aGVuIHRoZSBzaW5nbGV0b24gZGVidWdmc19kaXIgaXMgYWN0dWFsbHkgCmNyZWF0
ZWQuCgpSb2Jpbi4KCj4gCj4+Cj4+PiArwqDCoMKgIHJldHVybiBpb21tdV9kZWJ1Z2ZzX2RpcjsK
Pj4+ICt9Cj4+PiArRVhQT1JUX1NZTUJPTF9HUEwoaW9tbXVfZGVidWdmc19zZXR1cCk7Cj4+Cj4+
IC1Tb2hpbAo+Pgo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCj4gaW9tbXUgbWFpbGluZyBsaXN0Cj4gaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKPiBodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
