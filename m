From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v4 0/8] iommu/rockchip: Fix bugs and enable on ARM64
Date: Tue, 21 Jun 2016 21:42:16 +0900
Message-ID: <CAAFQd5B8sxbZ6MymwDKL4vZkfQ-ej_bNh7tS1OhRC=X7-eie+Q@mail.gmail.com>
References: <1466483681-36110-1-git-send-email-tfiga@chromium.org>
 <20160621091732.GB28248@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20160621091732.GB28248@8bytes.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Shunqian Zheng <zhengsq@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

SGkgSm9lcmcsCgpPbiBUdWUsIEp1biAyMSwgMjAxNiBhdCA2OjE3IFBNLCBKb2VyZyBSb2VkZWwg
PGpvcm9AOGJ5dGVzLm9yZz4gd3JvdGU6Cj4KPiBPbiBUdWUsIEp1biAyMSwgMjAxNiBhdCAwMToz
NDozM1BNICswOTAwLCBUb21hc3ogRmlnYSB3cm90ZToKPiA+IFRoaXMgc2VyaWVzIGludGVuZHMg
bW9zdGx5IHRvIGVuYWJsZSBzdXBwb3J0IGZvciBBUk02NCBhcmNoaXRlY3R1cmUKPiA+IGluIHRo
ZSByb2NrY2hpcC1pb21tdSBkcml2ZXIuIE9uIHRoZSB3YXkgdG8gZG8gc28sIHNvbWUgYnVncyBh
cmUgYWxzbwo+ID4gZml4ZWQuCj4gPgo+ID4gVGhlIG1vc3QgaW1wb3J0YW50IGNoYW5nZXMgaGVy
ZSBhcmU6Cj4gPiAgLSBtYWtpbmcgdGhlIFJvY2tjaGlwIElPTU1VIGRyaXZlciB1c2UgRE1BIEFQ
SSBmb3IgbWFuYWdpbmcgY2FjaGUKPiA+ICAgIGNvaGVyZW5jeSBvZiBwYWdlIHRhYmxlcywKPiA+
ICAtIG1ha2luZyB0aGUgUm9ja2NoaXAgRFJNIGRyaXZlciBub3QgdXNlIERNQSBBUEkgb24gYmVo
YWxmIG9mIGEgdmlydHVhbAo+ID4gICAgZGV2aWNlIChiZWhpbmQgYSB2aXJ0dWFsIElPTU1VKSB0
byBhbGxvY2F0ZSBhbmQgbWFwIGJ1ZmZlcnMsIGJ1dAo+ID4gICAgaW5zdGVhZCBwcm9wZXIgRFJN
IGhlbHBlcnMgYW5kIElPTU1VIEFQSSBkaXJlY3RseS4KPgo+IEFyZSB0aGVzZSB0d28gcGFydHMg
ZGVwZW5kZW50IG9uIGVhY2ggb3RoZXIgb3IgY2FuIHRoZSBJT01NVSBhbmQgdGhlIERSTQo+IHBh
cnQgbWVyZ2VkIGluZGVwZW5kZW50bHk/CgpJbiBzaW1wbGUgd29yZHMsIERSTSBwYXRjaGVzIGRl
cGVuZCBvbiBJT01NVSBwYXRjaGVzLgoKTW9yZSBwcmVjaXNlbHk6IFRoZSBJT01NVSBwYXRjaGVz
IGFsb25lIGFyZSBzdXBwb3NlZCB0byBub3QgYnJlYWsKYW55dGhpbmcuIFNhbWUgZ29lcyBmb3Ig
dGhlIGZpcnN0IERSTSBwYXRjaCAoNy84KS4gT25seSBzZWNvbmQgRFJNCnBhdGNoICg4LzgpIGRl
cGVuZHMgb24gY2hhbmdlcyBpbnRyb2R1Y2VkIGJ5IGl0cyBwcmVkZWNlc3NvcnMuCgpCZXN0IHJl
Z2FyZHMsClRvbWFzegpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2
ZWwK
