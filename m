From: Kit Chow <kchow-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>
Subject: Re: IOAT DMA w/IOMMU
Date: Tue, 14 Aug 2018 06:47:56 -0700
Message-ID: <55bbbf43-8665-47a3-c290-1d31dca0ba1a@gigaio.com>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
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
	<0e839acf-5948-42aa-2ad6-72ca0d84a8c3@deltatee.com>
	<bcfc8738-cbf6-7124-3d79-a1bdfe161d36@gigaio.com>
	<712ecb24-8919-05a5-f64c-6a1faa971edc@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <712ecb24-8919-05a5-f64c-6a1faa971edc-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
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
To: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eric Pilmore <epilmore-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

CgpPbiAwOC8xMy8yMDE4IDA0OjUwIFBNLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6Cj4KPiBPbiAx
My8wOC8xOCAwNTo0OCBQTSwgS2l0IENob3cgd3JvdGU6Cj4+IE9uIDA4LzEzLzIwMTggMDQ6Mzkg
UE0sIExvZ2FuIEd1bnRob3JwZSB3cm90ZToKPj4+IE9uIDEzLzA4LzE4IDA1OjMwIFBNLCBLaXQg
Q2hvdyB3cm90ZToKPj4+PiBJbiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wYWdlLmgsIHRoZXJlIGlz
IHRoZSBmb2xsb3dpbmcgY29tbWVudCBpbgo+Pj4+IHJlZ2FyZHMgdG8gdmFsaWRhdGluZyB0aGUg
dmlydHVhbCBhZGRyZXNzLgo+Pj4+Cj4+Pj4gLyoKPj4+PiAgwqDCoCogdmlydF90b19wYWdlKGth
ZGRyKSByZXR1cm5zIGEgdmFsaWQgcG9pbnRlciBpZiBhbmQgb25seSBpZgo+Pj4+ICDCoMKgKiB2
aXJ0X2FkZHJfdmFsaWQoa2FkZHIpIHJldHVybnMgdHJ1ZS4KPj4+PiAgwqDCoCovCj4+Pj4gI2Rl
ZmluZSB2aXJ0X3RvX3BhZ2Uoa2FkZHIpwqDCoMKgwqAgcGZuX3RvX3BhZ2UoX19wYShrYWRkcikg
Pj4gUEFHRV9TSElGVCkKPj4+Pgo+Pj4+IFNvIGl0IGxvb2tzIGxpa2UgdGhlIHZhbGlkYXRpb24g
YnkgdmlydF9hZGRyX3ZhbGlkIHdhcyBzb21laG93IGRyb3BwZWQKPj4+PiBmcm9tIHRoZSB2aXJ0
X3RvX3BhZ2UgY29kZSBwYXRoLiBEb2VzIGFueW9uZSBoYXZlIGFueSBpZGVhcyB3aGF0Cj4+Pj4g
aGFwcGVuZGVkIHRvIGl0Pwo+Pj4gSSBkb24ndCB0aGluayBpdCB3YXMgZXZlciB2YWxpZGF0ZWQg
KHRob3VnaCBJIGhhdmVuJ3QgYmVlbiBhcm91bmQgbG9uZwo+Pj4gZW5vdWdoIHRvIHNheSBmb3Ig
Y2VydGFpbikuIFdoYXQgdGhlIGNvbW1lbnQgaXMgc2F5aW5nIGlzIHRoYXQgeW91Cj4+PiBzaG91
bGRuJ3QgcmVseSBvbiB2aXJ0X3RvX3BhZ2UoKSB1bmxlc3MgeW91IGtub3cgdmlydF9hZGRyX3Zh
bGlkKCkgaXMKPj4+IHRydWUgKHdoaWNoIGluIG1vc3QgY2FzZXMgeW91IGNhbiB3aXRob3V0IHRo
ZSBleHRyYSBjaGVjaykuIHZpcnRfdG9fcGFnZQo+Pj4gaXMgbWVhbnQgdG8gYmUgcmVhbGx5IGZh
c3Qgc28gYWRkaW5nIGFuIGV4dHJhIHZhbGlkYXRpb24gd291bGQgcHJvYmFibHkKPj4+IGJlIGEg
c2lnbmlmaWNhbnQgcGVyZm9ybWFuY2UgcmVncmVzc2lvbiBmb3IgdGhlIGVudGlyZSBrZXJuZWwu
Cj4+Pgo+Pj4gVGhlIGZhY3QgdGhhdCB0aGlzIGNhbiBoYXBwZW4gdGhyb3VnaCBkbWFfbWFwX3Np
bmdsZSgpIGlzIG5vbi1pZGVhbCBhdAo+Pj4gYmVzdC4gSXQgYXNzdW1lcyB0aGUgY2FsbGVyIGlz
IG1hcHBpbmcgcmVndWxhciBtZW1vcnkgYW5kIGRvZXNuJ3QgY2hlY2sKPj4+IHRoaXMgYXQgYWxs
LiBJdCBtYXkgbWFrZSBzZW5zZSB0byBmaXggdGhhdCBidXQgSSB0aGluayBwZW9wbGUgZXhwZWN0
Cj4+PiBkbWFfbWFwX3NpbmdsZSgpIHRvIGJlIGFzIGZhc3QgYXMgcG9zc2libGUgYXMgd2VsbC4u
Lgo+Pj4KPj4gUGVyaGFwcyBpbmNsdWRlIHRoZSB2YWxpZGF0aW9uIHdpdGggc29tZSBkZWJ1ZyB0
dXJuZWQgb24/Cj4gVGhlIHByb2JsZW0gaXMgaG93IG9mdGVuIGRvIHlvdSBkZXZlbG9wIGNvZGUg
d2l0aCBhbnkgb2YgdGhlIGRlYnVnCj4gY29uZmlnIG9wdGlvbnMgdHVybmVkIG9uPwo+Cj4gVGhl
cmUncyBhbHJlYWR5IGEgY291cGxlIG9mIEJVR19PTnMgaW4gZG1hX21hcF9zaW5nbGUgc28gbWF5
YmUgYW5vdGhlcgo+IG9uZSB3aXRoIHZpcnRfYWRkcl92YWxpZCB3b3VsZG4ndCBiZSBzbyBiYWQu
CkhhZCBteSB2ZXJ5IGZpcnN0IExpbnV4IGNyYXNoIG9uIHRoZSBkbWEgZGlyZWN0aW9uIEJVR19P
TiB3aGVuIEkgdHJpZWQgCkRNQV9OT05FIDopLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2lvbW11
