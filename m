From: Christoph Hellwig <hch@lst.de>
Subject: Re: amdgpu/TTM oopses since merging swiotlb_dma_ops into the
 dma_direct code
Date: Mon, 14 Jan 2019 19:13:14 +0100
Message-ID: <20190114181314.GC8897@lst.de>
References: <61f8f660-005c-190c-c08f-b563de2eae18@daenzer.net>
 <20190110135741.GA9255@lst.de>
 <CAF=iVctGGs1OzHBg6MgpxrFbT_19T4YvH8muBZtsLJBDwGhrvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CAF=iVctGGs1OzHBg6MgpxrFbT_19T4YvH8muBZtsLJBDwGhrvQ@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sibren Vasse <sibren@sibrenvasse.nl>
Cc: Sibren Vasse <freedesktop@sibrenvasse.nl>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, x86@kernel.org, dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org, amd-gfx@lists.freedesktop.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

SG1tLCBJIHdvbmRlciBpZiB3ZSBhcmUgbm90IGFjdHVhbGx5IHVzaW5nIHN3aW90bGIgaW4gdGhl
IGVuZCwKY2FuIHlvdSBjaGVjayBpZiB5b3VyIGRtZXNnIGNvbnRhaW5zIHRoaXMgbGluZSBvciBu
b3Q/CgpQQ0ktRE1BOiBVc2luZyBzb2Z0d2FyZSBib3VuY2UgYnVmZmVyaW5nIGZvciBJTyAoU1dJ
T1RMQikKCklmIG5vdCBJIGd1ZXNzIHdlIGZvdW5kIGEgYnVnIGluIHN3aW90bGIgZXhpdCB2cyBp
c19zd2lvdGxiX2J1ZmZlciwKYW5kIHlvdSBjYW4gdHJ5IHRoaXMgcGF0Y2g6CgpkaWZmIC0tZ2l0
IGEva2VybmVsL2RtYS9zd2lvdGxiLmMgYi9rZXJuZWwvZG1hL3N3aW90bGIuYwppbmRleCBkNjM2
MTc3NmRjNWMuLjFmYjZmZDY4YjljNyAxMDA2NDQKLS0tIGEva2VybmVsL2RtYS9zd2lvdGxiLmMK
KysrIGIva2VybmVsL2RtYS9zd2lvdGxiLmMKQEAgLTM3OCw2ICszNzgsOCBAQCB2b2lkIF9faW5p
dCBzd2lvdGxiX2V4aXQodm9pZCkKIAkJbWVtYmxvY2tfZnJlZV9sYXRlKGlvX3RsYl9zdGFydCwK
IAkJCQkgICBQQUdFX0FMSUdOKGlvX3RsYl9uc2xhYnMgPDwgSU9fVExCX1NISUZUKSk7CiAJfQor
CWlvX3RsYl9zdGFydCA9IDA7CisJaW9fdGxiX2VuZCA9IDA7CiAJaW9fdGxiX25zbGFicyA9IDA7
CiAJbWF4X3NlZ21lbnQgPSAwOwogfQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9kcmktZGV2ZWwK
