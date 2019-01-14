From: Sibren Vasse <sibren-DLwv2wemLo05ZU0pBKPMFg@public.gmane.org>
Subject: Re: amdgpu/TTM oopses since merging swiotlb_dma_ops into the
 dma_direct code
Date: Mon, 14 Jan 2019 20:32:18 +0100
Message-ID: <CAF=iVcsG0N++=kTrBpQk=-6mJqLHrj2o6aRt1Opezthw01zQYw@mail.gmail.com>
References: <61f8f660-005c-190c-c08f-b563de2eae18@daenzer.net>
 <20190110135741.GA9255@lst.de>
 <CAF=iVctGGs1OzHBg6MgpxrFbT_19T4YvH8muBZtsLJBDwGhrvQ@mail.gmail.com>
 <20190114181314.GC8897@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190114181314.GC8897-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Sibren Vasse <sibren-DLwv2wemLo05ZU0pBKPMFg@public.gmane.org>, Sibren Vasse <freedesktop-DLwv2wemLo05ZU0pBKPMFg@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gTW9uLCAxNCBKYW4gMjAxOSBhdCAxOToxMywgQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3Qu
ZGU+IHdyb3RlOgo+Cj4gSG1tLCBJIHdvbmRlciBpZiB3ZSBhcmUgbm90IGFjdHVhbGx5IHVzaW5n
IHN3aW90bGIgaW4gdGhlIGVuZCwKPiBjYW4geW91IGNoZWNrIGlmIHlvdXIgZG1lc2cgY29udGFp
bnMgdGhpcyBsaW5lIG9yIG5vdD8KPgo+IFBDSS1ETUE6IFVzaW5nIHNvZnR3YXJlIGJvdW5jZSBi
dWZmZXJpbmcgZm9yIElPIChTV0lPVExCKQpUaGlzIGxpbmUgZG9lcyBub3QgYXBwZWFyIGluIG15
IGRtZXNnLgoKPgo+IElmIG5vdCBJIGd1ZXNzIHdlIGZvdW5kIGEgYnVnIGluIHN3aW90bGIgZXhp
dCB2cyBpc19zd2lvdGxiX2J1ZmZlciwKPiBhbmQgeW91IGNhbiB0cnkgdGhpcyBwYXRjaDoKPgo+
IGRpZmYgLS1naXQgYS9rZXJuZWwvZG1hL3N3aW90bGIuYyBiL2tlcm5lbC9kbWEvc3dpb3RsYi5j
Cj4gaW5kZXggZDYzNjE3NzZkYzVjLi4xZmI2ZmQ2OGI5YzcgMTAwNjQ0Cj4gLS0tIGEva2VybmVs
L2RtYS9zd2lvdGxiLmMKPiArKysgYi9rZXJuZWwvZG1hL3N3aW90bGIuYwo+IEBAIC0zNzgsNiAr
Mzc4LDggQEAgdm9pZCBfX2luaXQgc3dpb3RsYl9leGl0KHZvaWQpCj4gICAgICAgICAgICAgICAg
IG1lbWJsb2NrX2ZyZWVfbGF0ZShpb190bGJfc3RhcnQsCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBQQUdFX0FMSUdOKGlvX3RsYl9uc2xhYnMgPDwgSU9fVExCX1NISUZUKSk7
Cj4gICAgICAgICB9Cj4gKyAgICAgICBpb190bGJfc3RhcnQgPSAwOwo+ICsgICAgICAgaW9fdGxi
X2VuZCA9IDA7Cj4gICAgICAgICBpb190bGJfbnNsYWJzID0gMDsKPiAgICAgICAgIG1heF9zZWdt
ZW50ID0gMDsKPiAgfQpXaXRoIHRoZSBwYXRjaCBhcHBsaWVkIHRvIHY1LjAtcmMyIEkgY2FuIG5v
IGxvbmdlciByZXByb2R1Y2UgdGhlIGlzc3VlLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
