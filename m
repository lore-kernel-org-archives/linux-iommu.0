From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v4 0/8] iommu/rockchip: Fix bugs and enable on ARM64
Date: Tue, 21 Jun 2016 14:54:35 +0200
Message-ID: <20160621125435.GE11432@8bytes.org>
References: <1466483681-36110-1-git-send-email-tfiga@chromium.org>
 <20160621091732.GB28248@8bytes.org>
 <CAAFQd5B8sxbZ6MymwDKL4vZkfQ-ej_bNh7tS1OhRC=X7-eie+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CAAFQd5B8sxbZ6MymwDKL4vZkfQ-ej_bNh7tS1OhRC=X7-eie+Q@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomasz Figa <tfiga@chromium.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Shunqian Zheng <zhengsq@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

SGkgVG9tYXN6LAoKT24gVHVlLCBKdW4gMjEsIDIwMTYgYXQgMDk6NDI6MTZQTSArMDkwMCwgVG9t
YXN6IEZpZ2Egd3JvdGU6Cj4gSW4gc2ltcGxlIHdvcmRzLCBEUk0gcGF0Y2hlcyBkZXBlbmQgb24g
SU9NTVUgcGF0Y2hlcy4KPiAKPiBNb3JlIHByZWNpc2VseTogVGhlIElPTU1VIHBhdGNoZXMgYWxv
bmUgYXJlIHN1cHBvc2VkIHRvIG5vdCBicmVhawo+IGFueXRoaW5nLiBTYW1lIGdvZXMgZm9yIHRo
ZSBmaXJzdCBEUk0gcGF0Y2ggKDcvOCkuIE9ubHkgc2Vjb25kIERSTQo+IHBhdGNoICg4LzgpIGRl
cGVuZHMgb24gY2hhbmdlcyBpbnRyb2R1Y2VkIGJ5IGl0cyBwcmVkZWNlc3NvcnMuCgpUaGUgZmly
c3QgRFJNIHBhdGNoIGlzIDYvNywgc28gaXQgaXMgNy84IHdpdGggdGhlIGlvbW11IGRlcGVuZGVu
Y3ksCnJpZ2h0PyBBbnl3YXksIEkgdGhpbmsgdGhlIGJlc3QgaXMgSSB0YWtlIHRoZSBpb21tdSBw
YXRjaGVzIHdoZW4gSGVpa28KaXMgb2sgd2l0aCB0aGVtIGFuZCB0aGVuIHRoZSBEUk0gdHJlZSBj
YW4gbWVyZ2UgdGhhdCBicmFuY2ggaW4gdG8gYXBwbHkKdGhlIERSTSBwYXRjaGVzLgoKQnV0IGZp
cnN0IEhlaWtvIHNob3VsZCBoYXZlIGEgbG9vayBhdCB0aGUgcGF0Y2hlcy4KCgpUaGFua3MsCgoJ
Sm9lcmcKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRy
aS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
