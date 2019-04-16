From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: [REBASE PATCH v5 5/9] drm/xen/xen_drm_front_gem.c:
 Convert to use vm_map_pages()
Date: Tue, 16 Apr 2019 17:19:46 +0530
Message-ID: <ff8e10ba778d79419c66ee8215bccf01560540fd.1552921225.git.jrdr.linux__46925.6199941569$1555415301$gmane$org@gmail.com>
References: <cover.1552921225.git.jrdr.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <cover.1552921225.git.jrdr.linux@gmail.com>
In-Reply-To: <cover.1552921225.git.jrdr.linux@gmail.com>
References: <cover.1552921225.git.jrdr.linux@gmail.com>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com, kirill.shutemov@linux.intel.com, vbabka@suse.cz, riel@surriel.com, sfr@canb.auug.org.au, rppt@linux.vnet.ibm.com, peterz@infradead.org, linux@armlinux.org.uk, robin.murphy@arm.com, iamjoonsoo.kim@lge.com, treding@nvidia.com, keescook@chromium.org, m.szyprowski@samsung.com, stefanr@s5r6.in-berlin.de, hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie, oleksandr_andrushchenko@epam.com, joro@8bytes.org, pawel@osciak.com, kyungmin.park@samsung.com, mchehab@kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Souptick Joarder <jrdr.linux@gmail.com>, linux1394-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Q29udmVydCB0byB1c2Ugdm1fbWFwX3BhZ2VzKCkgdG8gbWFwIHJhbmdlIG9mIGtlcm5lbAptZW1v
cnkgdG8gdXNlciB2bWEuCgpTaWduZWQtb2ZmLWJ5OiBTb3VwdGljayBKb2FyZGVyIDxqcmRyLmxp
bnV4QGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IE9sZWtzYW5kciBBbmRydXNoY2hlbmtvIDxvbGVr
c2FuZHJfYW5kcnVzaGNoZW5rb0BlcGFtLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0veGVuL3hl
bl9kcm1fZnJvbnRfZ2VtLmMgfCAxOCArKysrKy0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS94ZW4veGVuX2RybV9mcm9udF9nZW0uYyBiL2RyaXZlcnMvZ3B1L2RybS94ZW4veGVu
X2RybV9mcm9udF9nZW0uYwppbmRleCAyOGJjNTAxLi5kZDA2MDJkIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0veGVuL3hlbl9kcm1fZnJvbnRfZ2VtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L3hlbi94ZW5fZHJtX2Zyb250X2dlbS5jCkBAIC0yMjQsOCArMjI0LDcgQEAgc3RydWN0IGRybV9n
ZW1fb2JqZWN0ICoKIHN0YXRpYyBpbnQgZ2VtX21tYXBfb2JqKHN0cnVjdCB4ZW5fZ2VtX29iamVj
dCAqeGVuX29iaiwKIAkJCXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQogewotCXVuc2lnbmVk
IGxvbmcgYWRkciA9IHZtYS0+dm1fc3RhcnQ7Ci0JaW50IGk7CisJaW50IHJldDsKIAogCS8qCiAJ
ICogY2xlYXIgdGhlIFZNX1BGTk1BUCBmbGFnIHRoYXQgd2FzIHNldCBieSBkcm1fZ2VtX21tYXAo
KSwgYW5kIHNldCB0aGUKQEAgLTI0NiwxOCArMjQ1LDExIEBAIHN0YXRpYyBpbnQgZ2VtX21tYXBf
b2JqKHN0cnVjdCB4ZW5fZ2VtX29iamVjdCAqeGVuX29iaiwKIAkgKiBGSVhNRTogYXMgd2UgaW5z
ZXJ0IGFsbCB0aGUgcGFnZXMgbm93IHRoZW4gbm8gLmZhdWx0IGhhbmRsZXIgbXVzdAogCSAqIGJl
IGNhbGxlZCwgc28gZG9uJ3QgcHJvdmlkZSBvbmUKIAkgKi8KLQlmb3IgKGkgPSAwOyBpIDwgeGVu
X29iai0+bnVtX3BhZ2VzOyBpKyspIHsKLQkJaW50IHJldDsKLQotCQlyZXQgPSB2bV9pbnNlcnRf
cGFnZSh2bWEsIGFkZHIsIHhlbl9vYmotPnBhZ2VzW2ldKTsKLQkJaWYgKHJldCA8IDApIHsKLQkJ
CURSTV9FUlJPUigiRmFpbGVkIHRvIGluc2VydCBwYWdlcyBpbnRvIHZtYTogJWRcbiIsIHJldCk7
Ci0JCQlyZXR1cm4gcmV0OwotCQl9CisJcmV0ID0gdm1fbWFwX3BhZ2VzKHZtYSwgeGVuX29iai0+
cGFnZXMsIHhlbl9vYmotPm51bV9wYWdlcyk7CisJaWYgKHJldCA8IDApCisJCURSTV9FUlJPUigi
RmFpbGVkIHRvIG1hcCBwYWdlcyBpbnRvIHZtYTogJWRcbiIsIHJldCk7CiAKLQkJYWRkciArPSBQ
QUdFX1NJWkU7Ci0JfQotCXJldHVybiAwOworCXJldHVybiByZXQ7CiB9CiAKIGludCB4ZW5fZHJt
X2Zyb250X2dlbV9tbWFwKHN0cnVjdCBmaWxlICpmaWxwLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3Qg
KnZtYSkKLS0gCjEuOS4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KWGVuLWRldmVsIG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVucHJvamVj
dC5vcmcKaHR0cHM6Ly9saXN0cy54ZW5wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3hlbi1k
ZXZlbA==
