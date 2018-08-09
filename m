From: Kit Chow <kchow-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>
Subject: Re: IOAT DMA w/IOMMU
Date: Thu, 9 Aug 2018 13:57:18 -0700
Message-ID: <b278c1e5-6f08-c879-a27d-7fc172645fd5@gigaio.com>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
	<20180809184331.GB113140@bhelgaas-glaptop.roam.corp.google.com>
	<CAOQPn8uPYKai49WYPqZp2wNd5of=0hUvPOHEtqP56RZu-hcjuw@mail.gmail.com>
	<b54899a8-a144-e8e0-9880-1800c4657b95@deltatee.com>
	<95e53520-b05f-4be4-e694-463d717453a8@gigaio.com>
	<cdd9245f-eb23-9e10-1755-8f396a2cd255@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cdd9245f-eb23-9e10-1755-8f396a2cd255-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
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
To: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>, Eric Pilmore <epilmore-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

CgpPbiAwOC8wOS8yMDE4IDAxOjExIFBNLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6Cj4KPiBPbiAw
OS8wOC8xOCAwMTo0NyBQTSwgS2l0IENob3cgd3JvdGU6Cj4+PiBJIGhhdmVuJ3QgdGVzdGVkIHRo
aXMgc2NlbmFyaW8gYnV0IG15IGd1ZXNzIHdvdWxkIGJlIHRoYXQgSU9BVCB3b3VsZAo+Pj4gaW5k
ZWVkIGdvIHRocm91Z2ggdGhlIElPTU1VIGFuZCB0aGUgUENJIEJBUiBhZGRyZXNzIHdvdWxkIG5l
ZWQgdG8gYmUKPj4+IHByb3Blcmx5IG1hcHBlZCBpbnRvIHRoZSBJT0FUJ3MgSU9WQS4gVGhlIGZh
Y3QgdGhhdCB5b3Ugc2VlIERNQVIgZXJyb3JzCj4+PiBpcyBwcm9iYWJseSBhIGdvb2QgaW5kaWNh
dGlvbiB0aGF0IHRoaXMgaXMgdGhlIGNhc2UuIEkgcmVhbGx5IGRvbid0IGtub3cKPj4+IHdoeSB5
b3UnZCB3YW50IHRvIERNQSBzb21ldGhpbmcgd2l0aG91dCBtYXBwaW5nIGl0Lgo+PiBJIGhhdmUg
ZXhwZXJpbWVudGVkIHdpdGggY2hhbmdpbmcgbnRiX2FzeW5jX3R4X3N1Ym1pdCB0byBkbWFfbWFw
IHRoZSBQQ0kKPj4gQkFSCj4+IGFkZHJlc3MuIFdpdGggdGhpcywgSSBnZXQgYSBkaWZmZXJlbnQg
RE1BUiBlcnJvcjoKPiBXaGF0IGNvZGUgZGlkIHlvdSB1c2UgdG8gZG8gdGhpcz8KSWYgeW91IG1l
YW4gdmVyc2lvbiBvZiBsaW51eCwgaXQgaXMgNC4xNS43LsKgIE9yIHNwZWNpZmljIGRtYV9tYXAg
Y2FsbCwgSSAKYmVsaWV2ZSBpdCB3YXMgZG1hX21hcF9zaW5nbGUuCgo+Cj4+IERNQVI6IFtETUEg
V3JpdGVdIFJlcXVlc3QgZGV2aWNlIFswNzowMC40XSBmYXVsdCBhZGRyIGZmZDAwMDAwCj4+IFtm
YXVsdCByZWFzb24gMTJdIG5vbi16ZXJvIHJlc2VydmVkIGZpZWxkcyBpbiBQVEUKPiBBbHNvLCB3
aGF0IGRldmljZSBjb3JyZXNwb25kcyB0byAwNzowMC40IG9uIHlvdXIgc3lzdGVtPwpJIGJlbGll
dmUgMDcuMDAuNCB3YXMgdGhlIFBMWCBkbWEgZGV2aWNlLiBJIGdldCB0aGUgc2FtZSBlcnJvciB3
aXRoIGlvYXQuCgpLaXQKCgo+IExvZ2FuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
