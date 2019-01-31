From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCHv2 1/9] mm: Introduce new vm_insert_range and
 vm_insert_range_buggy API
Date: Thu, 31 Jan 2019 13:06:49 +0100
Message-ID: <1701923.z6LKAITQJA@phil>
References: <20190131030812.GA2174@jordon-HP-15-Notebook-PC>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190131030812.GA2174@jordon-HP-15-Notebook-PC>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: mhocko@suse.com, peterz@infradead.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux1394-devel@lists.sourceforge.net, m.szyprowski@samsung.com, sfr@canb.auug.org.au, oleksandr_andrushchenko@epam.com, linux@armlinux.org.uk, willy@infradead.org, airlied@linux.ie, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, treding@nvidia.com, linux-media@vger.kernel.org, keescook@chromium.org, pawel@osciak.com, riel@surriel.com, iommu@lists.linux-foundation.org, rppt@linux.vnet.ibm.com, boris.ostrovsky@oracle.com, mchehab@kernel.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz, jgross@suse.com, xen-devel@lists.xen.org, kyungmin.park@samsung.com, stefanr@s5r6.in-berlin.de, akpm@linux-foundation.org, robin.murphy@arm.com, kirill.shutemov@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

QW0gRG9ubmVyc3RhZywgMzEuIEphbnVhciAyMDE5LCAwNDowODoxMiBDRVQgc2NocmllYiBTb3Vw
dGljayBKb2FyZGVyOgo+IFByZXZpb3VseSBkcml2ZXJzIGhhdmUgdGhlaXIgb3duIHdheSBvZiBt
YXBwaW5nIHJhbmdlIG9mCj4ga2VybmVsIHBhZ2VzL21lbW9yeSBpbnRvIHVzZXIgdm1hIGFuZCB0
aGlzIHdhcyBkb25lIGJ5Cj4gaW52b2tpbmcgdm1faW5zZXJ0X3BhZ2UoKSB3aXRoaW4gYSBsb29w
Lgo+IAo+IEFzIHRoaXMgcGF0dGVybiBpcyBjb21tb24gYWNyb3NzIGRpZmZlcmVudCBkcml2ZXJz
LCBpdCBjYW4KPiBiZSBnZW5lcmFsaXplZCBieSBjcmVhdGluZyBuZXcgZnVuY3Rpb25zIGFuZCB1
c2UgaXQgYWNyb3NzCj4gdGhlIGRyaXZlcnMuCj4gCj4gdm1faW5zZXJ0X3JhbmdlKCkgaXMgdGhl
IEFQSSB3aGljaCBjb3VsZCBiZSB1c2VkIHRvIG1hcHBlZAo+IGtlcm5lbCBtZW1vcnkvcGFnZXMg
aW4gZHJpdmVycyB3aGljaCBoYXMgY29uc2lkZXJlZCB2bV9wZ29mZgo+IAo+IHZtX2luc2VydF9y
YW5nZV9idWdneSgpIGlzIHRoZSBBUEkgd2hpY2ggY291bGQgYmUgdXNlZCB0byBtYXAKPiByYW5n
ZSBvZiBrZXJuZWwgbWVtb3J5L3BhZ2VzIGluIGRyaXZlcnMgd2hpY2ggaGFzIG5vdCBjb25zaWRl
cmVkCj4gdm1fcGdvZmYuIHZtX3Bnb2ZmIGlzIHBhc3NlZCBkZWZhdWx0IGFzIDAgZm9yIHRob3Nl
IGRyaXZlcnMuCj4gCj4gV2UgX2NvdWxkXyB0aGVuIGF0IGEgbGF0ZXIgImZpeCIgdGhlc2UgZHJp
dmVycyB3aGljaCBhcmUgdXNpbmcKPiB2bV9pbnNlcnRfcmFuZ2VfYnVnZ3koKSB0byBiZWhhdmUg
YWNjb3JkaW5nIHRvIHRoZSBub3JtYWwgdm1fcGdvZmYKPiBvZmZzZXR0aW5nIHNpbXBseSBieSBy
ZW1vdmluZyB0aGUgX2J1Z2d5IHN1ZmZpeCBvbiB0aGUgZnVuY3Rpb24KPiBuYW1lIGFuZCBpZiB0
aGF0IGNhdXNlcyByZWdyZXNzaW9ucywgaXQgZ2l2ZXMgdXMgYW4gZWFzeSB3YXkgdG8gcmV2ZXJ0
Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IFNvdXB0aWNrIEpvYXJkZXIgPGpyZHIubGludXhAZ21haWwu
Y29tPgo+IFN1Z2dlc3RlZC1ieTogUnVzc2VsbCBLaW5nIDxsaW51eEBhcm1saW51eC5vcmcudWs+
Cj4gU3VnZ2VzdGVkLWJ5OiBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFkZWFkLm9yZz4KCmht
bSwgSSdtIG1pc3NpbmcgYSBjaGFuZ2Vsb2cgaGVyZSBiZXR3ZWVuIHYxIGFuZCB2Mi4KTmV2ZXJ0
aGVsZXNzIEkgbWFuYWdlZCB0byB0ZXN0IHYxIG9uIFJvY2tjaGlwIGhhcmR3YXJlCmFuZCBkaXNw
bGF5IGlzIHN0aWxsIHdvcmtpbmcsIGluY2x1ZGluZyB0YWxraW5nIHRvIExpbWEgdmlhIHByaW1l
LgoKU28gaWYgdGhlcmUgYXJlbid0IGFueSBiaWcgY2hhbmdlcyBmb3IgdjIsIG9uIFJvY2tjaGlw
ClRlc3RlZC1ieTogSGVpa28gU3R1ZWJuZXIgPGhlaWtvQHNudGVjaC5kZT4KCkhlaWtvCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1h
aWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
