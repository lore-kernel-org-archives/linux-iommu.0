From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/6] sparc: remove not required includes from dma-mapping.h
Date: Sat,  8 Dec 2018 09:41:13 -0800
Message-ID: <20181208174115.16237-5-hch@lst.de>
References: <20181208174115.16237-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181208174115.16237-1-hch@lst.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: iommu@lists.linux-foundation.org
Cc: linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org, "Matwey V. Kornilov" <matwey@sai.msu.ru>, openrisc@lists.librecores.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org, Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

VGhlIG9ubHkgdGhpbmcgd2UgbmVlZCB0byBleHBsaWNpdGx5IHB1bGwgaW4gaXMgdGhlIGRlZmlu
ZXMgZm9yIHRoZQpDUFUgdHlwZS4KClNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxo
Y2hAbHN0LmRlPgotLS0KIGFyY2gvc3BhcmMvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaCB8IDQg
Ky0tLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2FyY2gvc3BhcmMvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaCBiL2FyY2gvc3Bh
cmMvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaAppbmRleCBiMGJiMmZjYWYxYzkuLjU1YTQ0ZjA4
YTlhNCAxMDA2NDQKLS0tIGEvYXJjaC9zcGFyYy9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oCisr
KyBiL2FyY2gvc3BhcmMvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaApAQCAtMiw5ICsyLDcgQEAK
ICNpZm5kZWYgX19fQVNNX1NQQVJDX0RNQV9NQVBQSU5HX0gKICNkZWZpbmUgX19fQVNNX1NQQVJD
X0RNQV9NQVBQSU5HX0gKIAotI2luY2x1ZGUgPGxpbnV4L3NjYXR0ZXJsaXN0Lmg+Ci0jaW5jbHVk
ZSA8bGludXgvbW0uaD4KLSNpbmNsdWRlIDxsaW51eC9kbWEtZGVidWcuaD4KKyNpbmNsdWRlIDxh
c20vY3B1X3R5cGUuaD4KIAogZXh0ZXJuIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqZG1hX29w
czsKIAotLSAKMi4xOS4yCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmkt
ZGV2ZWwK
