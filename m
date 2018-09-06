From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 01/40] iommu: Introduce Shared Virtual Addressing API
Date: Thu, 6 Sep 2018 13:45:36 +0100
Message-ID: <f0b317d5-e2e9-5478-952c-05e8b97bd68b@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
	<20180511190641.23008-2-jean-philippe.brucker@arm.com>
	<bf42affd-e9d0-e4fc-6d28-f3c3f7795348@redhat.com>
	<03d31ba5-1eda-ea86-8c0c-91d14c86fe83@arm.com>
	<ed39159c-087e-7e56-7d29-d1de9fa1677f@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <ed39159c-087e-7e56-7d29-d1de9fa1677f-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org
Cc: xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

T24gMDYvMDkvMjAxOCAxMjoxMiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAwNi4wOS4y
MDE4IHVtIDEzOjA5IHNjaHJpZWIgSmVhbi1QaGlsaXBwZSBCcnVja2VyOgo+PiBIaSBFcmljLAo+
Pgo+PiBUaGFua3MgZm9yIHJldmlld2luZwo+Pgo+PiBPbiAwNS8wOS8yMDE4IDEyOjI5LCBBdWdl
ciBFcmljIHdyb3RlOgo+Pj4+ICtpbnQgaW9tbXVfc3ZhX2RldmljZV9pbml0KHN0cnVjdCBkZXZp
Y2UgKmRldiwgdW5zaWduZWQgbG9uZyBmZWF0dXJlcywKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdW5zaWduZWQgaW50IG1heF9wYXNpZCkKPj4+IHdoYXQgYWJvdXQgbWluX3Bhc2lk
Pwo+PiBObyBvbmUgYXNrZWQgZm9yIGl0Li4uIFRoZSBtYXhfcGFzaWQgcGFyYW1ldGVyIGlzIGhl
cmUgZm9yIGRyaXZlcnMgdGhhdAo+PiBoYXZlIHZlbmRvci1zcGVjaWZpYyBQQVNJRCBzaXplIGxp
bWl0cywgc3VjaCBhcyBBTUQgS0ZEIChzZWUKPj4ga2ZkX2lvbW11X2RldmljZV9pbml0IGFuZAo+
PiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzk5ODkzMDcvIzIxMzg5NTcxKS4g
QnV0IGluIG1vc3QgY2FzZXMKPj4gdGhlIFBBU0lEIHNpemUgd2lsbCBvbmx5IGRlcGVuZCBvbiB0
aGUgUENJIFBBU0lEIGNhcGFiaWxpdHkgYW5kIHRoZQo+PiBJT01NVSBsaW1pdHMsIGJvdGgga25v
d24gYnkgdGhlIElPTU1VIGRyaXZlciwgc28gZGV2aWNlIGRyaXZlcnMgd29uJ3QKPj4gaGF2ZSB0
byBzZXQgbWF4X3Bhc2lkLgo+Pgo+PiBJT01NVSBkcml2ZXJzIG5lZWQgdG8gc2V0IG1pbl9wYXNp
ZCBpbiB0aGUgc3ZhX2RldmljZV9pbml0IGNhbGxiYWNrCj4+IGJlY2F1c2UgaXQgbWF5IGJlIGVp
dGhlciAxIChlLmcuIEFybSB3aGVyZSBQQVNJRCAjMCBpcyByZXNlcnZlZCkgb3IgMAo+PiAoSW50
ZWwgVnQtZCByZXYyKSwgYnV0IGF0IHRoZSBtb21lbnQgSSBjYW4ndCBzZWUgYSByZWFzb24gZm9y
IGRldmljZQo+PiBkcml2ZXJzIHRvIG92ZXJyaWRlIG1pbl9wYXNpZAo+IAo+IFNvcnJ5IHRvIHJ1
aW4geW91ciBkYXksIGJ1dCBpZiBJJ20gbm90IGNvbXBsZXRlbHkgbWlzdGFrZW4gUEFTSUQgemVy
byBpcwo+IHJlc2VydmVkIGluIHRoZSBBTUQgS0ZEIGFzIHdlbGwuCgpIZWgsIGZhaXIgZW5vdWdo
LiBJJ2xsIGFkZCB0aGUgbWluX3Bhc2lkIHBhcmFtZXRlcgoKVGhhbmtzLApKZWFuCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
