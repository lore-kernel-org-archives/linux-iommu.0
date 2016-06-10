From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v2 2/7] iommu/rockchip: add map_sg callback for
 rk_iommu_ops
Date: Fri, 10 Jun 2016 14:31:08 +0900
Message-ID: <CAAFQd5DNM518hk_RwF+af5Z881o9aEFSC237CvgfB8EAPM8s_g@mail.gmail.com>
References: <1465392392-2003-1-git-send-email-zhengsq@rock-chips.com>
 <1465392392-2003-3-git-send-email-zhengsq@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1465392392-2003-3-git-send-email-zhengsq@rock-chips.com>
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
aGlwcy5jb20+Cj4KPiBUaGUgaW9tbXVfZG1hX2FsbG9jKCkgaW4gaW9tbXUvZG1hLWlvbW11LmMg
Y2FsbHMgaW9tbXVfbWFwX3NnKCkKPiB0aGF0IHJlcXVpcmVzIHRoZSBjYWxsYmFjayBpb21tdV9v
cHMgLm1hcF9zZygpLiBBZGRpbmcgdGhlCj4gZGVmYXVsdF9pb21tdV9tYXBfc2coKSB0byByb2Nr
Y2hpcCBpb21tdSBhY2NvcmRpbmdseS4KPgo+IFNpZ25lZC1vZmYtYnk6IFNpbW9uIFh1ZSA8eHht
QHJvY2stY2hpcHMuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFNodW5xaWFuIFpoZW5nIDx4eG1Acm9j
ay1jaGlwcy5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvaW9tbXUvcm9ja2NoaXAtaW9tbXUuYyB8IDEg
Kwo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKClJldmlld2VkLWJ5OiBUb21hc3og
RmlnYSA8dGZpZ2FAY2hyb21pdW0ub3JnPgoKQmVzdCByZWdhcmRzLApUb21hc3oKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcg
bGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
