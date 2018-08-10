From: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
Subject: Re: IOAT DMA w/IOMMU
Date: Fri, 10 Aug 2018 10:33:41 -0600
Message-ID: <0f653f8f-c7ae-831d-e238-2742590d9ea1@deltatee.com>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
	<20180809184331.GB113140@bhelgaas-glaptop.roam.corp.google.com>
	<CAOQPn8uPYKai49WYPqZp2wNd5of=0hUvPOHEtqP56RZu-hcjuw@mail.gmail.com>
	<b54899a8-a144-e8e0-9880-1800c4657b95@deltatee.com>
	<95e53520-b05f-4be4-e694-463d717453a8@gigaio.com>
	<cdd9245f-eb23-9e10-1755-8f396a2cd255@deltatee.com>
	<b278c1e5-6f08-c879-a27d-7fc172645fd5@gigaio.com>
	<f04fae39-645e-3c6e-07c0-b194260bf5de@deltatee.com>
	<3f503940-db6a-ec75-ed15-1db99d5d48ef@gigaio.com>
	<112A412BB11A1242B37129D931BCE5348382CFB2@fmsmsx117.amr.corp.intel.com>
	<b8af340c-d40b-cb8c-987f-b394f1d6ec3e@gigaio.com>
	<adf51c74-36fa-b61d-8497-27bd75178ba4@deltatee.com>
	<aa9c3f41-efc9-8c68-a517-2736c8986621@gigaio.com>
	<1170c096-a749-6ee3-32d4-ebba1d12adff@gigaio.com>
	<929f3dfa-fbff-c582-3be5-c368f11feb7e@deltatee.com>
	<460cc47f-6a8e-67b0-01a0-02f0c51df258@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <460cc47f-6a8e-67b0-01a0-02f0c51df258-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
To: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kit Chow <kchow-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>, Eric Pilmore <epilmore-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

CgpPbiAxMC8wOC8xOCAxMDozMSBBTSwgRGF2ZSBKaWFuZyB3cm90ZToKPiAKPiAKPiBPbiAwOC8x
MC8yMDE4IDA5OjI0IEFNLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDEwLzA4
LzE4IDEwOjAyIEFNLCBLaXQgQ2hvdyB3cm90ZToKPj4+IFR1cm5zIG91dCB0aGVyZSBpcyBubyBk
bWFfbWFwX3Jlc291cmNlIHJvdXRpbmUgb24geDg2LiBnZXRfZG1hX29wcyAKPj4+IHJldHVybnMg
aW50ZWxfZG1hX29wcyB3aGljaCBoYXMgbWFwX3Jlc291cmNlIHBvaW50aW5nIHRvIE5VTEwuCj4+
Cj4+IE9oLCB5dXAuIEkgd2Fzbid0IGF3YXJlIG9mIHRoYXQuIEZyb20gYSBjdXJzb3J5IHZpZXcs
IGl0IGxvb2tzIGxpa2UgaXQKPj4gc2hvdWxkbid0IGJlIHRvbyBoYXJkIHRvIGltcGxlbWVudCB0
aG91Z2guCj4+Cj4+PiBXaWxsIHBva2UgYXJvdW5kIHNvbWUgaW4gdGhlIGludGVsX21hcF9wYWdl
IGNvZGUgYnV0IGNhbiB5b3UgYWN0dWFsbHkgCj4+PiBnZXQgYSB2YWxpZCBzdHJ1Y3QgcGFnZSBm
b3IgYSBwY2kgYmFyIGFkZHJlc3MgKGRtYV9tYXBfc2luZ2xlIGNhbGxzIAo+Pj4gdmlydF90b19w
YWdlKT/CoCBJZiBub3QsIGRvZXMgYSBtYXBfcmVzb3VyY2Ugcm91dGluZSB0aGF0IGNhbiBwcm9w
ZXJseSAKPj4+IG1hcCBhIHBjaSBiYXIgYWRkcmVzcyBuZWVkIHRvIGJlIGltcGxlbWVudGVkPwo+
Pgo+PiBZZXMsIHlvdSBjYW4gbm90IGdldCBhIHN0cnVjdCBwYWdlIGZvciBhIFBDSSBiYXIgYWRk
cmVzcyB1bmxlc3MgaXQncwo+PiBtYXBwZWQgd2l0aCBaT05FX0RFVklDRSBsaWtlIGluIG15IHAy
cCB3b3JrLiBTbyB0aGF0IHdvdWxkIGV4cGxhaW4gd2h5Cj4+IGRtYV9tYXBfc2luZ2xlKCkgZGlk
bid0IHdvcmsuCj4+Cj4+IFRoaXMgYWxsIGltcGxpZXMgdGhhdCBudGJfdHJhbnNwb3J0IGRvZXNu
J3Qgd29yayB3aXRoIERNQSBhbmQgdGhlIElPTU1VCj4+IHR1cm5lZCBvbi4gSSdtIG5vdCBzdXJl
IEkndmUgZXZlciB0cmllZCB0aGF0IGNvbmZpZ3VyYXRpb24gbXlzZWxmIGJ1dCBpdAo+PiBpcyBh
IGJpdCBzdXJwcmlzaW5nLgo+IAo+IEhtbS4uLi50aGF0J3Mgc3VycHJpc2luZyBiZWNhdXNlIGl0
IHNlZW1zIHRvIHdvcmsgb24gU2t5bGFrZSBwbGF0Zm9ybQo+IHdoZW4gSSB0ZXN0ZWQgaXQgeWVz
dGVyZGF5IHdpdGggSW50ZWwgTlRCLiBLaXQgaXMgdXNpbmcgYSBIYXN3ZWxsCj4gcGxhdGZvcm0g
YXQgdGhlIG1vbWVudCBJIHRoaW5rLiBBbHRob3VnaCBJJ20gY3VyaW91cyBpZiBpdCB3b3JrcyB3
aXRoCj4gdGhlIFBMWCBOVEIgaGUncyB1c2luZyBvbiBTa3lsYWtlLgoKRG9lcyB0aGF0IG1lYW4g
b24gU2t5bGFrZSB0aGUgSU9BVCBjYW4gYnlwYXNzIHRoZSBJT01NVT8gQmVjYXVzZSBpdApsb29r
cyBsaWtlIHRoZSBudGJfdHJhbnNwb3J0IGNvZGUgZG9lc24ndCBtYXAgdGhlIHBoeXNpY2FsIGFk
ZHJlc3Mgb2YKdGhlIE5UQiBNVyBpbnRvIHRoZSBJT01NVSB3aGVuIGRvaW5nIERNQS4uLgoKTG9n
YW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUg
bWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
