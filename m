From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCHv9 1/6] dma-mapping: add {map,unmap}_resource to dma_map_ops
Date: Wed, 10 Aug 2016 13:22:14 +0200
Message-ID: <20160810112219.17964-2-niklas.soderlund+renesas@ragnatech.se>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, linux@armlinux.org.uk
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, arnd@arndb.de, vinod.koul@intel.com, linus.walleij@linaro.org, hch@infradead.org, laurent.pinchart@ideasonboard.com, dan.j.williams@intel.com, robin.murphy@arm.com
List-Id: iommu@lists.linux-foundation.org

QWRkIG1ldGhvZHMgdG8gaGFuZGxlIG1hcHBpbmcgb2YgZGV2aWNlIHJlc291cmNlcyBmcm9tIGEg
cGh5c2ljYWwKYWRkcmVzcy4gVGhpcyBpcyBuZWVkZWQgZm9yIGV4YW1wbGUgdG8gYmUgYWJsZSB0
byBtYXAgTU1JTyBGSUZPCnJlZ2lzdGVycyB0byBhIElPTU1VLgoKU2lnbmVkLW9mZi1ieTogTmlr
bGFzIFPDtmRlcmx1bmQgPG5pa2xhcy5zb2Rlcmx1bmQrcmVuZXNhc0ByYWduYXRlY2guc2U+ClJl
dmlld2VkLWJ5OiBMYXVyZW50IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0QGlkZWFzb25ib2Fy
ZC5jb20+Ci0tLQogaW5jbHVkZS9saW51eC9kbWEtbWFwcGluZy5oIHwgNiArKysrKysKIDEgZmls
ZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Rt
YS1tYXBwaW5nLmggYi9pbmNsdWRlL2xpbnV4L2RtYS1tYXBwaW5nLmgKaW5kZXggYzQ0ZjhlZS4u
ZTNiZDI3ZiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9kbWEtbWFwcGluZy5oCisrKyBiL2lu
Y2x1ZGUvbGludXgvZG1hLW1hcHBpbmcuaApAQCAtOTUsNiArOTUsMTIgQEAgc3RydWN0IGRtYV9t
YXBfb3BzIHsKIAkJCSBzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnLCBpbnQgbmVudHMsCiAJCQkgZW51
bSBkbWFfZGF0YV9kaXJlY3Rpb24gZGlyLAogCQkJIHVuc2lnbmVkIGxvbmcgYXR0cnMpOworCWRt
YV9hZGRyX3QgKCptYXBfcmVzb3VyY2UpKHN0cnVjdCBkZXZpY2UgKmRldiwgcGh5c19hZGRyX3Qg
cGh5c19hZGRyLAorCQkJICAgICAgIHNpemVfdCBzaXplLCBlbnVtIGRtYV9kYXRhX2RpcmVjdGlv
biBkaXIsCisJCQkgICAgICAgdW5zaWduZWQgbG9uZyBhdHRycyk7CisJdm9pZCAoKnVubWFwX3Jl
c291cmNlKShzdHJ1Y3QgZGV2aWNlICpkZXYsIGRtYV9hZGRyX3QgZG1hX2hhbmRsZSwKKwkJCSAg
IHNpemVfdCBzaXplLCBlbnVtIGRtYV9kYXRhX2RpcmVjdGlvbiBkaXIsCisJCQkgICB1bnNpZ25l
ZCBsb25nIGF0dHJzKTsKIAl2b2lkICgqc3luY19zaW5nbGVfZm9yX2NwdSkoc3RydWN0IGRldmlj
ZSAqZGV2LAogCQkJCSAgICBkbWFfYWRkcl90IGRtYV9oYW5kbGUsIHNpemVfdCBzaXplLAogCQkJ
CSAgICBlbnVtIGRtYV9kYXRhX2RpcmVjdGlvbiBkaXIpOwotLSAKMi45LjIKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
