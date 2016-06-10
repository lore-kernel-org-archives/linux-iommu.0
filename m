From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v2 1/7] iommu/rockchip: fix devm_{request,
 free}_irq parameter
Date: Fri, 10 Jun 2016 14:30:14 +0900
Message-ID: <CAAFQd5BOZBqieA3xCi00jRCrYpZSAZmncAK2Qg69AuQGT5FQGA@mail.gmail.com>
References: <1465392392-2003-1-git-send-email-zhengsq@rock-chips.com>
 <1465392392-2003-2-git-send-email-zhengsq@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1465392392-2003-2-git-send-email-zhengsq@rock-chips.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Shunqian Zheng <zhengsq@rock-chips.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux@armlinux.org.uk, dri-devel <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Rob Herring <robh+dt@kernel.org>, simon xue <xxm@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

SGksCgpPbiBXZWQsIEp1biA4LCAyMDE2IGF0IDEwOjI2IFBNLCBTaHVucWlhbiBaaGVuZyA8emhl
bmdzcUByb2NrLWNoaXBzLmNvbT4gd3JvdGU6Cj4gRnJvbTogU2ltb24gWHVlIDx4eG1Acm9jay1j
aGlwcy5jb20+Cj4KPiBFdmVuIHRob3VnaCB0aGUgaW9tbXUgc2hhcmVzIGlycSB3aXRoIGl0cyBt
YXN0ZXIsIHVzaW5nIHRoZSAqZGV2IG9mIGlvbW11Cj4gaW5zdGVhZCBvZiBtYXN0ZXIncyAqZGV2
IGZvciBkZXZtX3tyZXF1ZXN0LGZyZWV9X2lycSBtYWtlcyB0aGluZ3MgY2xlYXIuCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBTaW1vbiBYdWUgPHh4bUByb2NrLWNoaXBzLmNvbT4KPiBTaWduZWQtb2ZmLWJ5
OiBTaHVucWlhbiBaaGVuZyA8emhlbmdzcUByb2NrLWNoaXBzLmNvbT4KPiAtLS0KPiAgZHJpdmVy
cy9pb21tdS9yb2NrY2hpcC1pb21tdS5jIHwgNCArKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KClJldmlld2VkLWJ5OiBUb21hc3ogRmlnYSA8
dGZpZ2FAY2hyb21pdW0ub3JnPgoKQmVzdCByZWdhcmRzLApUb21hc3oKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApk
cmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
