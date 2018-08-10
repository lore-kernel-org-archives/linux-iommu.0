From: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: IOAT DMA w/IOMMU
Date: Fri, 10 Aug 2018 09:31:42 -0700
Message-ID: <460cc47f-6a8e-67b0-01a0-02f0c51df258@intel.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <929f3dfa-fbff-c582-3be5-c368f11feb7e-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
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
To: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>, Kit Chow <kchow-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>, Eric Pilmore <epilmore-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

CgpPbiAwOC8xMC8yMDE4IDA5OjI0IEFNLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6Cj4gCj4gCj4g
T24gMTAvMDgvMTggMTA6MDIgQU0sIEtpdCBDaG93IHdyb3RlOgo+PiBUdXJucyBvdXQgdGhlcmUg
aXMgbm8gZG1hX21hcF9yZXNvdXJjZSByb3V0aW5lIG9uIHg4Ni4gZ2V0X2RtYV9vcHMgCj4+IHJl
dHVybnMgaW50ZWxfZG1hX29wcyB3aGljaCBoYXMgbWFwX3Jlc291cmNlIHBvaW50aW5nIHRvIE5V
TEwuCj4gCj4gT2gsIHl1cC4gSSB3YXNuJ3QgYXdhcmUgb2YgdGhhdC4gRnJvbSBhIGN1cnNvcnkg
dmlldywgaXQgbG9va3MgbGlrZSBpdAo+IHNob3VsZG4ndCBiZSB0b28gaGFyZCB0byBpbXBsZW1l
bnQgdGhvdWdoLgo+IAo+PiBXaWxsIHBva2UgYXJvdW5kIHNvbWUgaW4gdGhlIGludGVsX21hcF9w
YWdlIGNvZGUgYnV0IGNhbiB5b3UgYWN0dWFsbHkgCj4+IGdldCBhIHZhbGlkIHN0cnVjdCBwYWdl
IGZvciBhIHBjaSBiYXIgYWRkcmVzcyAoZG1hX21hcF9zaW5nbGUgY2FsbHMgCj4+IHZpcnRfdG9f
cGFnZSk/wqAgSWYgbm90LCBkb2VzIGEgbWFwX3Jlc291cmNlIHJvdXRpbmUgdGhhdCBjYW4gcHJv
cGVybHkgCj4+IG1hcCBhIHBjaSBiYXIgYWRkcmVzcyBuZWVkIHRvIGJlIGltcGxlbWVudGVkPwo+
IAo+IFllcywgeW91IGNhbiBub3QgZ2V0IGEgc3RydWN0IHBhZ2UgZm9yIGEgUENJIGJhciBhZGRy
ZXNzIHVubGVzcyBpdCdzCj4gbWFwcGVkIHdpdGggWk9ORV9ERVZJQ0UgbGlrZSBpbiBteSBwMnAg
d29yay4gU28gdGhhdCB3b3VsZCBleHBsYWluIHdoeQo+IGRtYV9tYXBfc2luZ2xlKCkgZGlkbid0
IHdvcmsuCj4gCj4gVGhpcyBhbGwgaW1wbGllcyB0aGF0IG50Yl90cmFuc3BvcnQgZG9lc24ndCB3
b3JrIHdpdGggRE1BIGFuZCB0aGUgSU9NTVUKPiB0dXJuZWQgb24uIEknbSBub3Qgc3VyZSBJJ3Zl
IGV2ZXIgdHJpZWQgdGhhdCBjb25maWd1cmF0aW9uIG15c2VsZiBidXQgaXQKPiBpcyBhIGJpdCBz
dXJwcmlzaW5nLgoKSG1tLi4uLnRoYXQncyBzdXJwcmlzaW5nIGJlY2F1c2UgaXQgc2VlbXMgdG8g
d29yayBvbiBTa3lsYWtlIHBsYXRmb3JtCndoZW4gSSB0ZXN0ZWQgaXQgeWVzdGVyZGF5IHdpdGgg
SW50ZWwgTlRCLiBLaXQgaXMgdXNpbmcgYSBIYXN3ZWxsCnBsYXRmb3JtIGF0IHRoZSBtb21lbnQg
SSB0aGluay4gQWx0aG91Z2ggSSdtIGN1cmlvdXMgaWYgaXQgd29ya3Mgd2l0aAp0aGUgUExYIE5U
QiBoZSdzIHVzaW5nIG9uIFNreWxha2UuCgo+IAo+IExvZ2FuCj4gCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
