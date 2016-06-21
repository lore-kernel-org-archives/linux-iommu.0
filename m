From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v4 0/8] iommu/rockchip: Fix bugs and enable on ARM64
Date: Tue, 21 Jun 2016 15:52:02 +0200
Message-ID: <20160621135202.GK28248@8bytes.org>
References: <1466483681-36110-1-git-send-email-tfiga@chromium.org>
 <CAAFQd5B8sxbZ6MymwDKL4vZkfQ-ej_bNh7tS1OhRC=X7-eie+Q@mail.gmail.com>
 <20160621125435.GE11432@8bytes.org> <2015742.xhx642kbrC@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <2015742.xhx642kbrC@diego>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Tomasz Figa <tfiga@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Shunqian Zheng <zhengsq@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

T24gVHVlLCBKdW4gMjEsIDIwMTYgYXQgMDM6MTg6NDlQTSArMDIwMCwgSGVpa28gU3TDvGJuZXIg
d3JvdGU6Cj4gQW0gRGllbnN0YWcsIDIxLiBKdW5pIDIwMTYsIDE0OjU0OjM1IHNjaHJpZWIgSm9l
cmcgUm9lZGVsOgo+ID4gSGkgVG9tYXN6LAo+ID4gCj4gPiBPbiBUdWUsIEp1biAyMSwgMjAxNiBh
dCAwOTo0MjoxNlBNICswOTAwLCBUb21hc3ogRmlnYSB3cm90ZToKPiA+ID4gSW4gc2ltcGxlIHdv
cmRzLCBEUk0gcGF0Y2hlcyBkZXBlbmQgb24gSU9NTVUgcGF0Y2hlcy4KPiA+ID4gCj4gPiA+IE1v
cmUgcHJlY2lzZWx5OiBUaGUgSU9NTVUgcGF0Y2hlcyBhbG9uZSBhcmUgc3VwcG9zZWQgdG8gbm90
IGJyZWFrCj4gPiA+IGFueXRoaW5nLiBTYW1lIGdvZXMgZm9yIHRoZSBmaXJzdCBEUk0gcGF0Y2gg
KDcvOCkuIE9ubHkgc2Vjb25kIERSTQo+ID4gPiBwYXRjaCAoOC84KSBkZXBlbmRzIG9uIGNoYW5n
ZXMgaW50cm9kdWNlZCBieSBpdHMgcHJlZGVjZXNzb3JzLgo+ID4gCj4gPiBUaGUgZmlyc3QgRFJN
IHBhdGNoIGlzIDYvNywgc28gaXQgaXMgNy84IHdpdGggdGhlIGlvbW11IGRlcGVuZGVuY3ksCj4g
PiByaWdodD8gQW55d2F5LCBJIHRoaW5rIHRoZSBiZXN0IGlzIEkgdGFrZSB0aGUgaW9tbXUgcGF0
Y2hlcyB3aGVuIEhlaWtvCj4gPiBpcyBvayB3aXRoIHRoZW0gYW5kIHRoZW4gdGhlIERSTSB0cmVl
IGNhbiBtZXJnZSB0aGF0IGJyYW5jaCBpbiB0byBhcHBseQo+ID4gdGhlIERSTSBwYXRjaGVzLgo+
ID4gCj4gPiBCdXQgZmlyc3QgSGVpa28gc2hvdWxkIGhhdmUgYSBsb29rIGF0IHRoZSBwYXRjaGVz
Lgo+IAo+IEkgdGhpbmsgZnJvbSBhbGwgaGlzIHByZXZpb3VzIHdvcmsgb24gdGhlIHJvY2tjaGlw
IGlvbW11cyBUb21hc3ogaXMgYSBsb3QgbW9yZSAKPiBxdWFsaWZpZWQgdG8ganVkZ2UgdGhlbSAt
IHdoaWNoIEkgZ3Vlc3MgaGUgZGlkIHdoZW4gcGlja2luZyB1cCB0aGUgb25lcyBmcm9tIAo+IFJv
Y2tjaGlwIGRldnMgOi0pIC4KCkluIHRoYXQgY2FzZSB5b3UgZ3V5cyBzaG91bGQgcHJvYmFibHkg
Y28tbWFpbnRhaW4gdGhhdCBkcml2ZXI/Cj4gCj4gPkZyb20gYSBzdHlsZS1zaWRlLCBwbGVhc2Ug
ZG9uJ3QgY2FycnkgdGhlIFJldmlld2VkLW9uIGdlcnJpdCB0YWdzIG92ZXIgdG8gCj4gbWFpbmxp
bmUgcGF0Y2hlcyAocGF0Y2hlcyAxIGFuZCAyKS4KCk9rYXkuCgoKCglKb2VyZwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcg
bGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
