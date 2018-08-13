From: Kit Chow <kchow-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>
Subject: Re: IOAT DMA w/IOMMU
Date: Mon, 13 Aug 2018 16:48:34 -0700
Message-ID: <bcfc8738-cbf6-7124-3d79-a1bdfe161d36@gigaio.com>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
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
	<0e839acf-5948-42aa-2ad6-72ca0d84a8c3@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <0e839acf-5948-42aa-2ad6-72ca0d84a8c3-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
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

CgpPbiAwOC8xMy8yMDE4IDA0OjM5IFBNLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6Cj4KPiBPbiAx
My8wOC8xOCAwNTozMCBQTSwgS2l0IENob3cgd3JvdGU6Cj4+IEluIGFyY2gveDg2L2luY2x1ZGUv
YXNtL3BhZ2UuaCwgdGhlcmUgaXMgdGhlIGZvbGxvd2luZyBjb21tZW50IGluCj4+IHJlZ2FyZHMg
dG8gdmFsaWRhdGluZyB0aGUgdmlydHVhbCBhZGRyZXNzLgo+Pgo+PiAvKgo+PiAgwqAqIHZpcnRf
dG9fcGFnZShrYWRkcikgcmV0dXJucyBhIHZhbGlkIHBvaW50ZXIgaWYgYW5kIG9ubHkgaWYKPj4g
IMKgKiB2aXJ0X2FkZHJfdmFsaWQoa2FkZHIpIHJldHVybnMgdHJ1ZS4KPj4gIMKgKi8KPj4gI2Rl
ZmluZSB2aXJ0X3RvX3BhZ2Uoa2FkZHIpwqDCoMKgwqAgcGZuX3RvX3BhZ2UoX19wYShrYWRkcikg
Pj4gUEFHRV9TSElGVCkKPj4KPj4gU28gaXQgbG9va3MgbGlrZSB0aGUgdmFsaWRhdGlvbiBieSB2
aXJ0X2FkZHJfdmFsaWQgd2FzIHNvbWVob3cgZHJvcHBlZAo+PiBmcm9tIHRoZSB2aXJ0X3RvX3Bh
Z2UgY29kZSBwYXRoLiBEb2VzIGFueW9uZSBoYXZlIGFueSBpZGVhcyB3aGF0Cj4+IGhhcHBlbmRl
ZCB0byBpdD8KPiBJIGRvbid0IHRoaW5rIGl0IHdhcyBldmVyIHZhbGlkYXRlZCAodGhvdWdoIEkg
aGF2ZW4ndCBiZWVuIGFyb3VuZCBsb25nCj4gZW5vdWdoIHRvIHNheSBmb3IgY2VydGFpbikuIFdo
YXQgdGhlIGNvbW1lbnQgaXMgc2F5aW5nIGlzIHRoYXQgeW91Cj4gc2hvdWxkbid0IHJlbHkgb24g
dmlydF90b19wYWdlKCkgdW5sZXNzIHlvdSBrbm93IHZpcnRfYWRkcl92YWxpZCgpIGlzCj4gdHJ1
ZSAod2hpY2ggaW4gbW9zdCBjYXNlcyB5b3UgY2FuIHdpdGhvdXQgdGhlIGV4dHJhIGNoZWNrKS4g
dmlydF90b19wYWdlCj4gaXMgbWVhbnQgdG8gYmUgcmVhbGx5IGZhc3Qgc28gYWRkaW5nIGFuIGV4
dHJhIHZhbGlkYXRpb24gd291bGQgcHJvYmFibHkKPiBiZSBhIHNpZ25pZmljYW50IHBlcmZvcm1h
bmNlIHJlZ3Jlc3Npb24gZm9yIHRoZSBlbnRpcmUga2VybmVsLgo+Cj4gVGhlIGZhY3QgdGhhdCB0
aGlzIGNhbiBoYXBwZW4gdGhyb3VnaCBkbWFfbWFwX3NpbmdsZSgpIGlzIG5vbi1pZGVhbCBhdAo+
IGJlc3QuIEl0IGFzc3VtZXMgdGhlIGNhbGxlciBpcyBtYXBwaW5nIHJlZ3VsYXIgbWVtb3J5IGFu
ZCBkb2Vzbid0IGNoZWNrCj4gdGhpcyBhdCBhbGwuIEl0IG1heSBtYWtlIHNlbnNlIHRvIGZpeCB0
aGF0IGJ1dCBJIHRoaW5rIHBlb3BsZSBleHBlY3QKPiBkbWFfbWFwX3NpbmdsZSgpIHRvIGJlIGFz
IGZhc3QgYXMgcG9zc2libGUgYXMgd2VsbC4uLgo+ClBlcmhhcHMgaW5jbHVkZSB0aGUgdmFsaWRh
dGlvbiB3aXRoIHNvbWUgZGVidWcgdHVybmVkIG9uPwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
