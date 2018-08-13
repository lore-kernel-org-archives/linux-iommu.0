From: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
Subject: Re: IOAT DMA w/IOMMU
Date: Mon, 13 Aug 2018 17:39:29 -0600
Message-ID: <0e839acf-5948-42aa-2ad6-72ca0d84a8c3@deltatee.com>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
	<112A412BB11A1242B37129D931BCE5348382CFB2@fmsmsx117.amr.corp.intel.com>
	<b8af340c-d40b-cb8c-987f-b394f1d6ec3e@gigaio.com>
	<adf51c74-36fa-b61d-8497-27bd75178ba4@deltatee.com>
	<aa9c3f41-efc9-8c68-a517-2736c8986621@gigaio.com>
	<1170c096-a749-6ee3-32d4-ebba1d12adff@gigaio.com>
	<929f3dfa-fbff-c582-3be5-c368f11feb7e@deltatee.com>
	<460cc47f-6a8e-67b0-01a0-02f0c51df258@intel.com>
	<0f653f8f-c7ae-831d-e238-2742590d9ea1@deltatee.com>
	<6525fa4d-7d9b-0136-7206-f8351230af46@intel.com>
	<f22c565e-ba49-c83d-3e51-7967664c7136@deltatee.com>
	<499934e7-3734-1aee-37dd-b42a5d2a2608@intel.com>
	<9d135f61-20c2-e966-4d7d-3e154384ea08@gigaio.com>
	<0a9fa9c3-dbe4-6451-9c1a-06b662702f61@deltatee.com>
	<a2391f6c-d73b-c140-edad-8cd6584dd437@gigaio.com>
	<c8d69f9b-b3a6-76ee-1a90-b3dbaaa9b82b@arm.com>
	<3772d88a-e9ad-465a-c91f-df8f9c6219be@gigaio.com>
	<dd18cf79-aa10-9801-bf95-192f0b86b6d9@gigaio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <dd18cf79-aa10-9801-bf95-192f0b86b6d9-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>
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
To: Kit Chow <kchow-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eric Pilmore <epilmore-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

CgpPbiAxMy8wOC8xOCAwNTozMCBQTSwgS2l0IENob3cgd3JvdGU6Cj4gSW4gYXJjaC94ODYvaW5j
bHVkZS9hc20vcGFnZS5oLCB0aGVyZSBpcyB0aGUgZm9sbG93aW5nIGNvbW1lbnQgaW4KPiByZWdh
cmRzIHRvIHZhbGlkYXRpbmcgdGhlIHZpcnR1YWwgYWRkcmVzcy4KPiAKPiAvKgo+IMKgKiB2aXJ0
X3RvX3BhZ2Uoa2FkZHIpIHJldHVybnMgYSB2YWxpZCBwb2ludGVyIGlmIGFuZCBvbmx5IGlmCj4g
wqAqIHZpcnRfYWRkcl92YWxpZChrYWRkcikgcmV0dXJucyB0cnVlLgo+IMKgKi8KPiAjZGVmaW5l
IHZpcnRfdG9fcGFnZShrYWRkcinCoMKgwqDCoCBwZm5fdG9fcGFnZShfX3BhKGthZGRyKSA+PiBQ
QUdFX1NISUZUKQo+IAo+IFNvIGl0IGxvb2tzIGxpa2UgdGhlIHZhbGlkYXRpb24gYnkgdmlydF9h
ZGRyX3ZhbGlkIHdhcyBzb21laG93IGRyb3BwZWQKPiBmcm9tIHRoZSB2aXJ0X3RvX3BhZ2UgY29k
ZSBwYXRoLiBEb2VzIGFueW9uZSBoYXZlIGFueSBpZGVhcyB3aGF0Cj4gaGFwcGVuZGVkIHRvIGl0
PwoKSSBkb24ndCB0aGluayBpdCB3YXMgZXZlciB2YWxpZGF0ZWQgKHRob3VnaCBJIGhhdmVuJ3Qg
YmVlbiBhcm91bmQgbG9uZwplbm91Z2ggdG8gc2F5IGZvciBjZXJ0YWluKS4gV2hhdCB0aGUgY29t
bWVudCBpcyBzYXlpbmcgaXMgdGhhdCB5b3UKc2hvdWxkbid0IHJlbHkgb24gdmlydF90b19wYWdl
KCkgdW5sZXNzIHlvdSBrbm93IHZpcnRfYWRkcl92YWxpZCgpIGlzCnRydWUgKHdoaWNoIGluIG1v
c3QgY2FzZXMgeW91IGNhbiB3aXRob3V0IHRoZSBleHRyYSBjaGVjaykuIHZpcnRfdG9fcGFnZQpp
cyBtZWFudCB0byBiZSByZWFsbHkgZmFzdCBzbyBhZGRpbmcgYW4gZXh0cmEgdmFsaWRhdGlvbiB3
b3VsZCBwcm9iYWJseQpiZSBhIHNpZ25pZmljYW50IHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24gZm9y
IHRoZSBlbnRpcmUga2VybmVsLgoKVGhlIGZhY3QgdGhhdCB0aGlzIGNhbiBoYXBwZW4gdGhyb3Vn
aCBkbWFfbWFwX3NpbmdsZSgpIGlzIG5vbi1pZGVhbCBhdApiZXN0LiBJdCBhc3N1bWVzIHRoZSBj
YWxsZXIgaXMgbWFwcGluZyByZWd1bGFyIG1lbW9yeSBhbmQgZG9lc24ndCBjaGVjawp0aGlzIGF0
IGFsbC4gSXQgbWF5IG1ha2Ugc2Vuc2UgdG8gZml4IHRoYXQgYnV0IEkgdGhpbmsgcGVvcGxlIGV4
cGVjdApkbWFfbWFwX3NpbmdsZSgpIHRvIGJlIGFzIGZhc3QgYXMgcG9zc2libGUgYXMgd2VsbC4u
LgoKTG9nYW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
