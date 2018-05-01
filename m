From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
Subject: [PATCH] swiotlb: Fix inversed DMA_ATTR_NO_WARN test
Date: Tue,  1 May 2018 15:24:11 +0200
Message-ID: <20180501132411.2311-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: iommu@lists.linux-foundation.org

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpUaGUgcmVzdWx0
IHdhcyBwcmludGluZyB0aGUgd2FybmluZyBvbmx5IHdoZW4gd2Ugd2VyZSBleHBsaWNpdGx5IGFz
a2VkCm5vdCB0by4KCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCkZpeGVzOiAwMTc2YWRiMDA0
MDY1ZDY4MTVhOGU2Nzk0Njc1MmRmNGNkOTQ3YzViICJzd2lvdGxiOiByZWZhY3RvcgogY29oZXJl
bnQgYnVmZmVyIGFsbG9jYXRpb24iClNpZ25lZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNo
ZWwuZGFlbnplckBhbWQuY29tPgotLS0KIGxpYi9zd2lvdGxiLmMgfCAyICstCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9saWIvc3dp
b3RsYi5jIGIvbGliL3N3aW90bGIuYwppbmRleCBjNDNlYzIyNzE0NjkuLmU5YWMyMTU0MDYyOCAx
MDA2NDQKLS0tIGEvbGliL3N3aW90bGIuYworKysgYi9saWIvc3dpb3RsYi5jCkBAIC03NTAsNyAr
NzUwLDcgQEAgc3dpb3RsYl9hbGxvY19idWZmZXIoc3RydWN0IGRldmljZSAqZGV2LCBzaXplX3Qg
c2l6ZSwgZG1hX2FkZHJfdCAqZG1hX2hhbmRsZSwKIAlzd2lvdGxiX3RibF91bm1hcF9zaW5nbGUo
ZGV2LCBwaHlzX2FkZHIsIHNpemUsIERNQV9UT19ERVZJQ0UsCiAJCQlETUFfQVRUUl9TS0lQX0NQ
VV9TWU5DKTsKIG91dF93YXJuOgotCWlmICgoYXR0cnMgJiBETUFfQVRUUl9OT19XQVJOKSAmJiBw
cmludGtfcmF0ZWxpbWl0KCkpIHsKKwlpZiAoIShhdHRycyAmIERNQV9BVFRSX05PX1dBUk4pICYm
IHByaW50a19yYXRlbGltaXQoKSkgewogCQlkZXZfd2FybihkZXYsCiAJCQkic3dpb3RsYjogY29o
ZXJlbnQgYWxsb2NhdGlvbiBmYWlsZWQsIHNpemU9JXp1XG4iLAogCQkJc2l6ZSk7Ci0tIAoyLjE3
LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1k
ZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
