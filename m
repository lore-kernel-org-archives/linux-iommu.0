From: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: IOAT DMA w/IOMMU
Date: Fri, 10 Aug 2018 10:01:56 -0700
Message-ID: <6525fa4d-7d9b-0136-7206-f8351230af46@intel.com>
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
	<0f653f8f-c7ae-831d-e238-2742590d9ea1@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <0f653f8f-c7ae-831d-e238-2742590d9ea1-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
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

CgpPbiAwOC8xMC8yMDE4IDA5OjMzIEFNLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6Cj4gCj4gCj4g
T24gMTAvMDgvMTggMTA6MzEgQU0sIERhdmUgSmlhbmcgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDA4LzEw
LzIwMTggMDk6MjQgQU0sIExvZ2FuIEd1bnRob3JwZSB3cm90ZToKPj4+Cj4+Pgo+Pj4gT24gMTAv
MDgvMTggMTA6MDIgQU0sIEtpdCBDaG93IHdyb3RlOgo+Pj4+IFR1cm5zIG91dCB0aGVyZSBpcyBu
byBkbWFfbWFwX3Jlc291cmNlIHJvdXRpbmUgb24geDg2LiBnZXRfZG1hX29wcyAKPj4+PiByZXR1
cm5zIGludGVsX2RtYV9vcHMgd2hpY2ggaGFzIG1hcF9yZXNvdXJjZSBwb2ludGluZyB0byBOVUxM
Lgo+Pj4KPj4+IE9oLCB5dXAuIEkgd2Fzbid0IGF3YXJlIG9mIHRoYXQuIEZyb20gYSBjdXJzb3J5
IHZpZXcsIGl0IGxvb2tzIGxpa2UgaXQKPj4+IHNob3VsZG4ndCBiZSB0b28gaGFyZCB0byBpbXBs
ZW1lbnQgdGhvdWdoLgo+Pj4KPj4+PiBXaWxsIHBva2UgYXJvdW5kIHNvbWUgaW4gdGhlIGludGVs
X21hcF9wYWdlIGNvZGUgYnV0IGNhbiB5b3UgYWN0dWFsbHkgCj4+Pj4gZ2V0IGEgdmFsaWQgc3Ry
dWN0IHBhZ2UgZm9yIGEgcGNpIGJhciBhZGRyZXNzIChkbWFfbWFwX3NpbmdsZSBjYWxscyAKPj4+
PiB2aXJ0X3RvX3BhZ2UpP8KgIElmIG5vdCwgZG9lcyBhIG1hcF9yZXNvdXJjZSByb3V0aW5lIHRo
YXQgY2FuIHByb3Blcmx5IAo+Pj4+IG1hcCBhIHBjaSBiYXIgYWRkcmVzcyBuZWVkIHRvIGJlIGlt
cGxlbWVudGVkPwo+Pj4KPj4+IFllcywgeW91IGNhbiBub3QgZ2V0IGEgc3RydWN0IHBhZ2UgZm9y
IGEgUENJIGJhciBhZGRyZXNzIHVubGVzcyBpdCdzCj4+PiBtYXBwZWQgd2l0aCBaT05FX0RFVklD
RSBsaWtlIGluIG15IHAycCB3b3JrLiBTbyB0aGF0IHdvdWxkIGV4cGxhaW4gd2h5Cj4+PiBkbWFf
bWFwX3NpbmdsZSgpIGRpZG4ndCB3b3JrLgo+Pj4KPj4+IFRoaXMgYWxsIGltcGxpZXMgdGhhdCBu
dGJfdHJhbnNwb3J0IGRvZXNuJ3Qgd29yayB3aXRoIERNQSBhbmQgdGhlIElPTU1VCj4+PiB0dXJu
ZWQgb24uIEknbSBub3Qgc3VyZSBJJ3ZlIGV2ZXIgdHJpZWQgdGhhdCBjb25maWd1cmF0aW9uIG15
c2VsZiBidXQgaXQKPj4+IGlzIGEgYml0IHN1cnByaXNpbmcuCj4+Cj4+IEhtbS4uLi50aGF0J3Mg
c3VycHJpc2luZyBiZWNhdXNlIGl0IHNlZW1zIHRvIHdvcmsgb24gU2t5bGFrZSBwbGF0Zm9ybQo+
PiB3aGVuIEkgdGVzdGVkIGl0IHllc3RlcmRheSB3aXRoIEludGVsIE5UQi4gS2l0IGlzIHVzaW5n
IGEgSGFzd2VsbAo+PiBwbGF0Zm9ybSBhdCB0aGUgbW9tZW50IEkgdGhpbmsuIEFsdGhvdWdoIEkn
bSBjdXJpb3VzIGlmIGl0IHdvcmtzIHdpdGgKPj4gdGhlIFBMWCBOVEIgaGUncyB1c2luZyBvbiBT
a3lsYWtlLgo+IAo+IERvZXMgdGhhdCBtZWFuIG9uIFNreWxha2UgdGhlIElPQVQgY2FuIGJ5cGFz
cyB0aGUgSU9NTVU/IEJlY2F1c2UgaXQKPiBsb29rcyBsaWtlIHRoZSBudGJfdHJhbnNwb3J0IGNv
ZGUgZG9lc24ndCBtYXAgdGhlIHBoeXNpY2FsIGFkZHJlc3Mgb2YKPiB0aGUgTlRCIE1XIGludG8g
dGhlIElPTU1VIHdoZW4gZG9pbmcgRE1BLi4uCgpPciBpZiB0aGUgQklPUyBoYXMgcHJvdmlkZWQg
bWFwcGluZyBmb3IgdGhlIEludGVsIE5UQiBkZXZpY2UKc3BlY2lmaWNhbGx5PyBJcyB0aGF0IGEg
cG9zc2liaWxpdHk/IE5UQiBkb2VzIGdvIHRocm91Z2ggdGhlIElPTU1VLgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
