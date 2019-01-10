From: Christoph Hellwig <hch@lst.de>
Subject: Re: amdgpu/TTM oopses since merging swiotlb_dma_ops into the
 dma_direct code
Date: Thu, 10 Jan 2019 14:57:41 +0100
Message-ID: <20190110135741.GA9255@lst.de>
References: <61f8f660-005c-190c-c08f-b563de2eae18@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <61f8f660-005c-190c-c08f-b563de2eae18@daenzer.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Sibren Vasse <freedesktop@sibrenvasse.nl>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org, dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org, amd-gfx@lists.freedesktop.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

T24gVGh1LCBKYW4gMTAsIDIwMTkgYXQgMTA6NTk6MDJBTSArMDEwMCwgTWljaGVsIETDpG56ZXIg
d3JvdGU6Cj4gCj4gSGkgQ2hyaXN0b3BoLAo+IAo+IAo+IGh0dHBzOi8vYnVncy5mcmVlZGVza3Rv
cC5vcmcvMTA5MjM0IChwbGVhc2UgaWdub3JlIGNvbW1lbnRzICM2LSM5KSB3YXMKPiBiaXNlY3Rl
ZCB0byB5b3VyIGNvbW1pdCA1NTg5N2FmNjMwOTEgImRtYS1kaXJlY3Q6IG1lcmdlIHN3aW90bGJf
ZG1hX29wcwo+IGludG8gdGhlIGRtYV9kaXJlY3QgY29kZSIuIEFueSBpZGVhcz8KCkZyb20gdGhl
IHRyYWNlIGl0IGxvb2tzIGxpa2Ugd2UgZ2l0IHRoZSBjYXNlIHdoZXJlIHN3aW90bGIgdHJpZXMK
dG8gY29weSBiYWNrIGRhdGEgZnJvbSBhIGJvdW5jZSBidWZmZXIsIGJ1dCBoaXRzIGEgZGFuZ2xp
bmcgb3IgTlVMTApwb2ludGVyLiAgU28gYSBjb3VwbGUgcXVlc3Rpb25zIGZvciB0aGUgc3VibWl0
dGVyOgoKIC0gZG9lcyB0aGUgc3lzdGVtIGhhdmUgbW9yZSB0aGFuIDRHQiBtZW1vcnkgYW5kIHRo
dXMgdXNlIHN3aW90bGI/CiAgIChjaGVjayAvcHJvYy9tZW1pbmZvLCBhbmQgaWYgc29tZXRoaW5n
IFNXSU9UTEIgYXBwZWFycyBpbiBkbWVzZykKIC0gZG9lcyB0aGUgZGV2aWNlIHRoaXMgaGFwcGVu
cyBvbiBoYXZlIGEgRE1BIG1hc2sgc21hbGxlciB0aGFuCiAgIHRoZSBhdmFpbGFibGUgbWVtb3J5
LCB0aGF0IGlzIHNob3VsZCBzd2lvdGxiIGJlIHVzZWQgaGVyZSB0byBzdGFydAogICB3aXRoPwpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwg
bWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
