From: Mark yao <mark.yao@rock-chips.com>
Subject: Re: [RFC 2/3] iommu: dma-iommu: move IOMMU/DMA-mapping code from
 ARM64 arch to drivers
Date: Mon, 18 Apr 2016 10:20:27 +0800
Message-ID: <5714446B.6040203@rock-chips.com>
References: <1455870164-25337-1-git-send-email-m.szyprowski@samsung.com>
 <1455870164-25337-3-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1455870164-25337-3-git-send-email-m.szyprowski@samsung.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org, Tomasz Figa <tfiga@chromium.org>, linaro-mm-sig@lists.linaro.org, Sakari Ailus <sakari.ailus@iki.fi>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Robin Murphy <robin.murphy@arm.com>
List-Id: iommu@lists.linux-foundation.org

T24gMjAxNuW5tDAy5pyIMTnml6UgMTY6MjIsIE1hcmVrIFN6eXByb3dza2kgd3JvdGU6Cj4gVGhp
cyBwYXRjaCBtb3ZlcyBhbGwgdGhlIElPTU1VLWJhc2VkIERNQS1tYXBwaW5nIGNvZGUgZnJvbSBh
cmNoL2FybTY0L21tCj4gdG8gZHJpdmVycy9pb21tdS9kbWEtaW9tbXUtb3BzLmMuIFRoaXMgd2F5
IGl0IGNhbiBiZSBlYXNpbHkgc2hhcmVkIHdpdGgKPiBBUk0gYXJjaGl0ZWN0dXJlLCB3aGljaCB3
aWxsIGFsc28gdXNlIHRoZW0uCj4KPiBTaWduZWQtb2ZmLWJ5OiBNYXJlayBTenlwcm93c2tpPG0u
c3p5cHJvd3NraUBzYW1zdW5nLmNvbT4KSU9NTVUgd29ya3MgZ29vZCBvbiBkcm0vcm9ja2NoaXAg
QVJNNjQgcGxhdGZvcm0gd2l0aCB0aGlzIHBhdGNoLiBTbwoKVGVzdGVkLWJ5OiBNYXJrIFlhbyA8
bWFyay55YW9Acm9jay1jaGlwcy5jb20+CgpUaGFua3MuCgotLSAK77ytYXJrIFlhbwoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWls
aW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
