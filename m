From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 13/40] vfio: Add support for Shared Virtual Addressing
Date: Thu, 24 May 2018 12:44:47 +0100
Message-ID: <cd13f60d-b282-3804-4ca7-2d34476c597f@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
	<20180511190641.23008-14-jean-philippe.brucker@arm.com>
	<5B0536A3.1000304@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5B0536A3.1000304-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
To: Xu Zaibo <xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org
Cc: bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, liguozhu <liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

SGksCgpPbiAyMy8wNS8xOCAxMDozOCwgWHUgWmFpYm8gd3JvdGU6Cj4+ICtzdGF0aWMgaW50IHZm
aW9faW9tbXVfYmluZF9ncm91cChzdHJ1Y3QgdmZpb19pb21tdSAqaW9tbXUsCj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdmZpb19ncm91cCAqZ3JvdXAsCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdmZpb19tbSAqdmZpb19tbSkK
Pj4gK3sKPj4gK8KgwqDCoCBpbnQgcmV0Owo+PiArwqDCoMKgIGJvb2wgZW5hYmxlZF9zdmEgPSBm
YWxzZTsKPj4gK8KgwqDCoCBzdHJ1Y3QgdmZpb19pb21tdV9zdmFfYmluZF9kYXRhIGRhdGEgPSB7
Cj4+ICvCoMKgwqDCoMKgwqDCoCAudmZpb19tbcKgwqDCoCA9IHZmaW9fbW0sCj4+ICvCoMKgwqDC
oMKgwqDCoCAuaW9tbXXCoMKgwqDCoMKgwqDCoCA9IGlvbW11LAo+PiArwqDCoMKgwqDCoMKgwqAg
LmNvdW50wqDCoMKgwqDCoMKgwqAgPSAwLAo+PiArwqDCoMKgIH07Cj4+ICsKPj4gK8KgwqDCoCBp
ZiAoIWdyb3VwLT5zdmFfZW5hYmxlZCkgewo+PiArwqDCoMKgwqDCoMKgwqAgcmV0ID0gaW9tbXVf
Z3JvdXBfZm9yX2VhY2hfZGV2KGdyb3VwLT5pb21tdV9ncm91cCwgTlVMTCwKPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmZpb19pb21tdV9z
dmFfaW5pdCk7Cj4gRG8gd2UgbmVlZCB0byBkbyAqc3ZhX2luaXQgaGVyZSBvciBkbyBhbnl0aGlu
ZyB0byBhdm9pZCByZXBlYXRlZAo+IGluaXRpYXRpb24/Cj4gd2hpbGUgYW5vdGhlciBwcm9jZXNz
IGFscmVhZHkgZGlkIGluaXRpYXRpb24gYXQgdGhpcyBkZXZpY2UsIEkgdGhpbmsKPiB0aGF0IGN1
cnJlbnQgcHJvY2VzcyB3aWxsIGdldCBhbiBFRVhJU1QuCgpSaWdodCwgc3ZhX2luaXQoKSBtdXN0
IGJlIGNhbGxlZCBvbmNlIGZvciBhbnkgZGV2aWNlIHRoYXQgaW50ZW5kcyB0byB1c2UKYmluZCgp
LiBGb3IgdGhlIHNlY29uZCBwcm9jZXNzIHRob3VnaCwgZ3JvdXAtPnN2YV9lbmFibGVkIHdpbGwg
YmUgdHJ1ZQpzbyB3ZSB3b24ndCBjYWxsIHN2YV9pbml0KCkgYWdhaW4sIG9ubHkgYmluZCgpLgoK
VGhhbmtzLApKZWFuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
