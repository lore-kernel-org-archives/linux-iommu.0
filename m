From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCHv2 1/9] mm: Introduce new vm_insert_range and
 vm_insert_range_buggy API
Date: Thu, 31 Jan 2019 13:34:10 +0100
Message-ID: <1572595.mVW1PIlZyR@phil>
References: <20190131030812.GA2174@jordon-HP-15-Notebook-PC>
 <1701923.z6LKAITQJA@phil>
 <CAFqt6zbxyMB3VCzbWo1rPdfKXLVTNx+RY0=guD5CRxD37gJzsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAFqt6zbxyMB3VCzbWo1rPdfKXLVTNx+RY0=guD5CRxD37gJzsA@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Souptick Joarder <jrdr.linux@gmail.com>, hjc@rock-chips.com
Cc: Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>, dri-devel@lists.freedesktop.org, Linux-MM <linux-mm@kvack.org>, linux1394-devel@lists.sourceforge.net, Stephen Rothwell <sfr@canb.auug.org.au>, oleksandr_andrushchenko@epam.com, Russell King - ARM Linux <linux@armlinux.org.uk>, Matthew Wilcox <willy@infradead.org>, airlied@linux.ie, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org, pawel@osciak.com, Rik van Riel <riel@surriel.com>, iommu@lists.linux-foundation.org, rppt@linux.vnet.ibm.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>, mchehab@kernel.org, vbabka@suse.cz, Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, Kyungmin Park <kyungmin.park@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, robin.murphy@arm.com, "Kirill A. Shutemov" <kirill.shutemov>
List-Id: iommu@lists.linux-foundation.org

QW0gRG9ubmVyc3RhZywgMzEuIEphbnVhciAyMDE5LCAxMzozMTo1MiBDRVQgc2NocmllYiBTb3Vw
dGljayBKb2FyZGVyOgo+IE9uIFRodSwgSmFuIDMxLCAyMDE5IGF0IDU6MzcgUE0gSGVpa28gU3R1
ZWJuZXIgPGhlaWtvQHNudGVjaC5kZT4gd3JvdGU6Cj4gPgo+ID4gQW0gRG9ubmVyc3RhZywgMzEu
IEphbnVhciAyMDE5LCAwNDowODoxMiBDRVQgc2NocmllYiBTb3VwdGljayBKb2FyZGVyOgo+ID4g
PiBQcmV2aW91bHkgZHJpdmVycyBoYXZlIHRoZWlyIG93biB3YXkgb2YgbWFwcGluZyByYW5nZSBv
Zgo+ID4gPiBrZXJuZWwgcGFnZXMvbWVtb3J5IGludG8gdXNlciB2bWEgYW5kIHRoaXMgd2FzIGRv
bmUgYnkKPiA+ID4gaW52b2tpbmcgdm1faW5zZXJ0X3BhZ2UoKSB3aXRoaW4gYSBsb29wLgo+ID4g
Pgo+ID4gPiBBcyB0aGlzIHBhdHRlcm4gaXMgY29tbW9uIGFjcm9zcyBkaWZmZXJlbnQgZHJpdmVy
cywgaXQgY2FuCj4gPiA+IGJlIGdlbmVyYWxpemVkIGJ5IGNyZWF0aW5nIG5ldyBmdW5jdGlvbnMg
YW5kIHVzZSBpdCBhY3Jvc3MKPiA+ID4gdGhlIGRyaXZlcnMuCj4gPiA+Cj4gPiA+IHZtX2luc2Vy
dF9yYW5nZSgpIGlzIHRoZSBBUEkgd2hpY2ggY291bGQgYmUgdXNlZCB0byBtYXBwZWQKPiA+ID4g
a2VybmVsIG1lbW9yeS9wYWdlcyBpbiBkcml2ZXJzIHdoaWNoIGhhcyBjb25zaWRlcmVkIHZtX3Bn
b2ZmCj4gPiA+Cj4gPiA+IHZtX2luc2VydF9yYW5nZV9idWdneSgpIGlzIHRoZSBBUEkgd2hpY2gg
Y291bGQgYmUgdXNlZCB0byBtYXAKPiA+ID4gcmFuZ2Ugb2Yga2VybmVsIG1lbW9yeS9wYWdlcyBp
biBkcml2ZXJzIHdoaWNoIGhhcyBub3QgY29uc2lkZXJlZAo+ID4gPiB2bV9wZ29mZi4gdm1fcGdv
ZmYgaXMgcGFzc2VkIGRlZmF1bHQgYXMgMCBmb3IgdGhvc2UgZHJpdmVycy4KPiA+ID4KPiA+ID4g
V2UgX2NvdWxkXyB0aGVuIGF0IGEgbGF0ZXIgImZpeCIgdGhlc2UgZHJpdmVycyB3aGljaCBhcmUg
dXNpbmcKPiA+ID4gdm1faW5zZXJ0X3JhbmdlX2J1Z2d5KCkgdG8gYmVoYXZlIGFjY29yZGluZyB0
byB0aGUgbm9ybWFsIHZtX3Bnb2ZmCj4gPiA+IG9mZnNldHRpbmcgc2ltcGx5IGJ5IHJlbW92aW5n
IHRoZSBfYnVnZ3kgc3VmZml4IG9uIHRoZSBmdW5jdGlvbgo+ID4gPiBuYW1lIGFuZCBpZiB0aGF0
IGNhdXNlcyByZWdyZXNzaW9ucywgaXQgZ2l2ZXMgdXMgYW4gZWFzeSB3YXkgdG8gcmV2ZXJ0Lgo+
ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTb3VwdGljayBKb2FyZGVyIDxqcmRyLmxpbnV4QGdt
YWlsLmNvbT4KPiA+ID4gU3VnZ2VzdGVkLWJ5OiBSdXNzZWxsIEtpbmcgPGxpbnV4QGFybWxpbnV4
Lm9yZy51az4KPiA+ID4gU3VnZ2VzdGVkLWJ5OiBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFk
ZWFkLm9yZz4KPiA+Cj4gPiBobW0sIEknbSBtaXNzaW5nIGEgY2hhbmdlbG9nIGhlcmUgYmV0d2Vl
biB2MSBhbmQgdjIuCj4gPiBOZXZlcnRoZWxlc3MgSSBtYW5hZ2VkIHRvIHRlc3QgdjEgb24gUm9j
a2NoaXAgaGFyZHdhcmUKPiA+IGFuZCBkaXNwbGF5IGlzIHN0aWxsIHdvcmtpbmcsIGluY2x1ZGlu
ZyB0YWxraW5nIHRvIExpbWEgdmlhIHByaW1lLgo+ID4KPiA+IFNvIGlmIHRoZXJlIGFyZW4ndCBh
bnkgYmlnIGNoYW5nZXMgZm9yIHYyLCBvbiBSb2NrY2hpcAo+ID4gVGVzdGVkLWJ5OiBIZWlrbyBT
dHVlYm5lciA8aGVpa29Ac250ZWNoLmRlPgo+IAo+IENoYW5nZSBsb2cgaXMgYXZhaWxhYmxlIGlu
IFswLzldLgo+IFBhdGNoIFsxLzldICYgWzQvOV0gaGF2ZSBubyBjaGFuZ2VzIGJldHdlZW4gdjEg
LT4gdjIuCgpJIG5ldmVyIHNlZW0gdG8gZ2V0IHlvdXIgY292ZXItbGV0dGVycywgc28gZGlkbid0
IHNlZSB0aGF0LCBzb3JyeS4KCkJ1dCBncmVhdCB0aGF0IHRoZXJlIHdlcmVuJ3QgY2hhbmdlcyB0
aGVuIDotKQoKSGVpa28KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmkt
ZGV2ZWwK
