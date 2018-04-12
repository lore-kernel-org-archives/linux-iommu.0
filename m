From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V2] drm/amdgpu: limit DMA size to PAGE_SIZE for
	scatter-gather buffers
Date: Thu, 12 Apr 2018 14:51:00 +0100
Message-ID: <7a3e7459-2965-54c8-ff0c-6edb3a6aecb5@arm.com>
References: <1523394001-4615-1-git-send-email-okaya@codeaurora.org>
	<32b82296-bba5-b5f1-266b-45c1ed66da94@arm.com>
	<20180412062600.GB30499@lst.de>
	<6802bd0c-7da6-659a-7e34-8f05d7c6422c@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6802bd0c-7da6-659a-7e34-8f05d7c6422c-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, sulrich-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, David Panariti <David.Panariti-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>, "open list:DRM DRIVERS" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Feifei Xu <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Jim Qu <Jim.Qu-5C7GfCeVMHo@public.gmane.org>, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

T24gMTIvMDQvMTggMTA6NDIsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTIuMDQuMjAx
OCB1bSAwODoyNiBzY2hyaWViIENocmlzdG9waCBIZWxsd2lnOgo+PiBPbiBXZWQsIEFwciAxMSwg
MjAxOCBhdCAwMTowMzo1OVBNICswMTAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+PiBPbiAxMC8w
NC8xOCAyMTo1OSwgU2luYW4gS2F5YSB3cm90ZToKPj4+PiBDb2RlIGlzIGV4cGVjaW5nIHRvIG9i
c2VydmUgdGhlIHNhbWUgbnVtYmVyIG9mIGJ1ZmZlcnMgcmV0dXJuZWQgZnJvbQo+Pj4+IGRtYV9t
YXBfc2coKSBmdW5jdGlvbiBjb21wYXJlZCB0byBzZ19hbGxvY190YWJsZV9mcm9tX3BhZ2VzKCku
IFRoaXMKPj4+PiBkb2Vzbid0IGhvbGQgdHJ1ZSB1bml2ZXJzYWxseSBlc3BlY2lhbGx5IGZvciBz
eXN0ZW1zIHdpdGggSU9NTVUuCj4+PiBTbyB3aHkgbm90IGZpeCBzYWlkIGNvZGU/IEl0J3MgY2xl
YXJseSBub3QgYSByZWFsIGhhcmR3YXJlIAo+Pj4gbGltaXRhdGlvbiwgYW5kCj4+PiB0aGUgbWFw
X3NnKCkgQVBJcyBoYXZlIHBvdGVudGlhbGx5IHJldHVybmVkIGZld2VyIHRoYW4gbmVudHMgc2lu
Y2UgCj4+PiBmb3JldmVyLAo+Pj4gc28gdGhlcmUncyByZWFsbHkgbm8gZXhjdXNlLgo+PiBZZXMs
IHJlbHlpbmcgb24gZG1hX21hcF9zZyByZXR1cm5pbmcgdGhlIHNhbWUgbnVtYmVyIG9mIGVudHJp
ZXMgYXMgcGFzc2VkCj4+IGl0IGlzIGNvbXBsZXRlbHkgYm9ndXMuCj4gCj4gSSBhZ3JlZSB0aGF0
IHRoZSBjb21tb24gRFJNIGZ1bmN0aW9ucyBzaG91bGQgYmUgYWJsZSB0byBkZWFsIHdpdGggYm90
aCwgCj4gYnV0IHdlIHNob3VsZCBsZXQgdGhlIGRyaXZlciBzaWRlIGRlY2lkZSBpZiBpdCB3YW50
cyBtdWx0aXBsZSBhZGRyZXNzZXMgCj4gY29tYmluZWQgb3Igbm90Lgo+IAo+Pgo+Pj4+IElPTU1V
IGRyaXZlciB0cmllcyB0byBjb21iaW5lIGJ1ZmZlcnMgaW50byBhIHNpbmdsZSBETUEgYWRkcmVz
cyBhcyBtdWNoCj4+Pj4gYXMgaXQgY2FuLiBUaGUgcmlnaHQgdGhpbmcgaXMgdG8gdGVsbCB0aGUg
RE1BIGxheWVyIGhvdyBtdWNoIGNvbWJpbmluZwo+Pj4+IElPTU1VIGNhbiBkby4KPj4+IERpc2Fn
cmVlOyB0aGlzIGlzIGEgZG9kZ3kgaGFjaywgc2luY2UgeW91J2xsIG5vdyBlbmQgdXAgcGFzc2lu
Zwo+Pj4gc2NhdHRlcmxpc3RzIGludG8gZG1hX21hcF9zZygpIHdoaWNoIGFscmVhZHkgdmlvbGF0
ZSBtYXhfc2VnX3NpemUgdG8gCj4+PiBiZWdpbgo+Pj4gd2l0aCwgYW5kIEkgdGhpbmsgYSBjb25z
Y2llbnRpb3VzIERNQSBBUEkgaW1wbGVtZW50YXRpb24gd291bGQgYmUgYXQgCj4+PiByaWdodHMK
Pj4+IHRvIGZhaWwgdGhlIG1hcHBpbmcgZm9yIHRoYXQgcmVhc29uIChJIGtub3cgYXJtNjQgaGFw
cGVucyBub3QgdG8sIGJ1dCAKPj4+IHRoYXQKPj4+IHdhcyBhIGRlbGliZXJhdGUgZGVzaWduIGRl
Y2lzaW9uIHRvIG1ha2UgbXkgbGlmZSBlYXNpZXIgYXQgdGhlIHRpbWUpLgo+PiBBZ3JlZWQuCj4g
Cj4gU291bmRzIGxpa2UgbXkgdW5kZXJzdGFuZGluZyBvZiBtYXhfc2VnX3NpemUgaXMgaW5jb3Jy
ZWN0LCB3aGF0IGV4YWN0bHkgCj4gc2hvdWxkIHRoYXQgZGVzY3JpYmU/CgpUaGUgc2VnbWVudCBz
aXplIGFuZCBib3VuZGFyeSBtYXNrIGFyZSB0aGVyZSB0byByZXByZXNlbnQgYSBkZXZpY2UncyAK
aGFyZHdhcmUgc2NhdHRlci1nYXRoZXIgY2FwYWJpbGl0aWVzIC0gYSBsb3Qgb2YgdGhpbmdzIGhh
dmUgbGltaXRzIG9uIAp0aGUgc2l6ZSBhbmQgYWxpZ25tZW50IG9mIHRoZSBkYXRhIHBvaW50ZWQg
dG8gYnkgYSBzaW5nbGUgZGVzY3JpcHRvciAKKGUuZy4gYW4geEhDSSBUUkIsIHdoZXJlIHRoZSBk
YXRhIGJ1ZmZlciBtdXN0IG5vdCBjcm9zcyBhIDY0S0IgYm91bmRhcnkpIAotIGFsdGhvdWdoIHRo
ZXkgY2FuIGFsc28gYmUgcmVsZXZhbnQgdG8gbm9uLXNjYXR0ZXItZ2F0aGVyIGRldmljZXMgaWYg
CnRoZXkganVzdCBoYXZlIGxpbWl0cyBvbiBob3cgYmlnL2FsaWduZWQgYSBzaW5nbGUgRE1BIHRy
YW5zZmVyIGNhbiBiZS4KClJvYmluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
