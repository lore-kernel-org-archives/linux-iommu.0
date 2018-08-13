From: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
Subject: Re: IOAT DMA w/IOMMU
Date: Mon, 13 Aug 2018 17:50:50 -0600
Message-ID: <712ecb24-8919-05a5-f64c-6a1faa971edc@deltatee.com>
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
	<bcfc8738-cbf6-7124-3d79-a1bdfe161d36@gigaio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <bcfc8738-cbf6-7124-3d79-a1bdfe161d36-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>
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

CgpPbiAxMy8wOC8xOCAwNTo0OCBQTSwgS2l0IENob3cgd3JvdGU6Cj4gT24gMDgvMTMvMjAxOCAw
NDozOSBQTSwgTG9nYW4gR3VudGhvcnBlIHdyb3RlOgo+Pgo+PiBPbiAxMy8wOC8xOCAwNTozMCBQ
TSwgS2l0IENob3cgd3JvdGU6Cj4+PiBJbiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wYWdlLmgsIHRo
ZXJlIGlzIHRoZSBmb2xsb3dpbmcgY29tbWVudCBpbgo+Pj4gcmVnYXJkcyB0byB2YWxpZGF0aW5n
IHRoZSB2aXJ0dWFsIGFkZHJlc3MuCj4+Pgo+Pj4gLyoKPj4+IMKgwqAqIHZpcnRfdG9fcGFnZShr
YWRkcikgcmV0dXJucyBhIHZhbGlkIHBvaW50ZXIgaWYgYW5kIG9ubHkgaWYKPj4+IMKgwqAqIHZp
cnRfYWRkcl92YWxpZChrYWRkcikgcmV0dXJucyB0cnVlLgo+Pj4gwqDCoCovCj4+PiAjZGVmaW5l
IHZpcnRfdG9fcGFnZShrYWRkcinCoMKgwqDCoCBwZm5fdG9fcGFnZShfX3BhKGthZGRyKSA+PiBQ
QUdFX1NISUZUKQo+Pj4KPj4+IFNvIGl0IGxvb2tzIGxpa2UgdGhlIHZhbGlkYXRpb24gYnkgdmly
dF9hZGRyX3ZhbGlkIHdhcyBzb21laG93IGRyb3BwZWQKPj4+IGZyb20gdGhlIHZpcnRfdG9fcGFn
ZSBjb2RlIHBhdGguIERvZXMgYW55b25lIGhhdmUgYW55IGlkZWFzIHdoYXQKPj4+IGhhcHBlbmRl
ZCB0byBpdD8KPj4gSSBkb24ndCB0aGluayBpdCB3YXMgZXZlciB2YWxpZGF0ZWQgKHRob3VnaCBJ
IGhhdmVuJ3QgYmVlbiBhcm91bmQgbG9uZwo+PiBlbm91Z2ggdG8gc2F5IGZvciBjZXJ0YWluKS4g
V2hhdCB0aGUgY29tbWVudCBpcyBzYXlpbmcgaXMgdGhhdCB5b3UKPj4gc2hvdWxkbid0IHJlbHkg
b24gdmlydF90b19wYWdlKCkgdW5sZXNzIHlvdSBrbm93IHZpcnRfYWRkcl92YWxpZCgpIGlzCj4+
IHRydWUgKHdoaWNoIGluIG1vc3QgY2FzZXMgeW91IGNhbiB3aXRob3V0IHRoZSBleHRyYSBjaGVj
aykuIHZpcnRfdG9fcGFnZQo+PiBpcyBtZWFudCB0byBiZSByZWFsbHkgZmFzdCBzbyBhZGRpbmcg
YW4gZXh0cmEgdmFsaWRhdGlvbiB3b3VsZCBwcm9iYWJseQo+PiBiZSBhIHNpZ25pZmljYW50IHBl
cmZvcm1hbmNlIHJlZ3Jlc3Npb24gZm9yIHRoZSBlbnRpcmUga2VybmVsLgo+Pgo+PiBUaGUgZmFj
dCB0aGF0IHRoaXMgY2FuIGhhcHBlbiB0aHJvdWdoIGRtYV9tYXBfc2luZ2xlKCkgaXMgbm9uLWlk
ZWFsIGF0Cj4+IGJlc3QuIEl0IGFzc3VtZXMgdGhlIGNhbGxlciBpcyBtYXBwaW5nIHJlZ3VsYXIg
bWVtb3J5IGFuZCBkb2Vzbid0IGNoZWNrCj4+IHRoaXMgYXQgYWxsLiBJdCBtYXkgbWFrZSBzZW5z
ZSB0byBmaXggdGhhdCBidXQgSSB0aGluayBwZW9wbGUgZXhwZWN0Cj4+IGRtYV9tYXBfc2luZ2xl
KCkgdG8gYmUgYXMgZmFzdCBhcyBwb3NzaWJsZSBhcyB3ZWxsLi4uCj4+Cj4gUGVyaGFwcyBpbmNs
dWRlIHRoZSB2YWxpZGF0aW9uIHdpdGggc29tZSBkZWJ1ZyB0dXJuZWQgb24/CgpUaGUgcHJvYmxl
bSBpcyBob3cgb2Z0ZW4gZG8geW91IGRldmVsb3AgY29kZSB3aXRoIGFueSBvZiB0aGUgZGVidWcK
Y29uZmlnIG9wdGlvbnMgdHVybmVkIG9uPwoKVGhlcmUncyBhbHJlYWR5IGEgY291cGxlIG9mIEJV
R19PTnMgaW4gZG1hX21hcF9zaW5nbGUgc28gbWF5YmUgYW5vdGhlcgpvbmUgd2l0aCB2aXJ0X2Fk
ZHJfdmFsaWQgd291bGRuJ3QgYmUgc28gYmFkLgoKTG9nYW4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2lvbW11
