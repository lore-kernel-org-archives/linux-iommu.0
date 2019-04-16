From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: [REBASE PATCH v5 4/9] drm/rockchip/rockchip_drm_gem.c:
 Convert to use vm_map_pages()
Date: Tue, 16 Apr 2019 17:19:45 +0530
Message-ID: <7ba359eb1aceac388d05983c1f29b915bdf291f9.1552921225.git.jrdr.linux__22961.1119999149$1555415286$gmane$org@gmail.com>
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
cnkgdG8gdXNlciB2bWEuCgpUZXN0ZWQgb24gUm9ja2NoaXAgaGFyZHdhcmUgYW5kIGRpc3BsYXkg
aXMgd29ya2luZywKaW5jbHVkaW5nIHRhbGtpbmcgdG8gTGltYSB2aWEgcHJpbWUuCgpTaWduZWQt
b2ZmLWJ5OiBTb3VwdGljayBKb2FyZGVyIDxqcmRyLmxpbnV4QGdtYWlsLmNvbT4KVGVzdGVkLWJ5
OiBIZWlrbyBTdHVlYm5lciA8aGVpa29Ac250ZWNoLmRlPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9y
b2NrY2hpcC9yb2NrY2hpcF9kcm1fZ2VtLmMgfCAxNyArKy0tLS0tLS0tLS0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL3JvY2tjaGlwX2RybV9nZW0uYyBiL2RyaXZlcnMvZ3B1
L2RybS9yb2NrY2hpcC9yb2NrY2hpcF9kcm1fZ2VtLmMKaW5kZXggYThkYjc1OC4uYTJlYmIwOCAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL3JvY2tjaGlwX2RybV9nZW0uYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX2dlbS5jCkBAIC0yMjEs
MjYgKzIyMSwxMyBAQCBzdGF0aWMgaW50IHJvY2tjaGlwX2RybV9nZW1fb2JqZWN0X21tYXBfaW9t
bXUoc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmosCiAJCQkJCSAgICAgIHN0cnVjdCB2bV9hcmVh
X3N0cnVjdCAqdm1hKQogewogCXN0cnVjdCByb2NrY2hpcF9nZW1fb2JqZWN0ICpya19vYmogPSB0
b19yb2NrY2hpcF9vYmoob2JqKTsKLQl1bnNpZ25lZCBpbnQgaSwgY291bnQgPSBvYmotPnNpemUg
Pj4gUEFHRV9TSElGVDsKKwl1bnNpZ25lZCBpbnQgY291bnQgPSBvYmotPnNpemUgPj4gUEFHRV9T
SElGVDsKIAl1bnNpZ25lZCBsb25nIHVzZXJfY291bnQgPSB2bWFfcGFnZXModm1hKTsKLQl1bnNp
Z25lZCBsb25nIHVhZGRyID0gdm1hLT52bV9zdGFydDsKLQl1bnNpZ25lZCBsb25nIG9mZnNldCA9
IHZtYS0+dm1fcGdvZmY7Ci0JdW5zaWduZWQgbG9uZyBlbmQgPSB1c2VyX2NvdW50ICsgb2Zmc2V0
OwotCWludCByZXQ7CiAKIAlpZiAodXNlcl9jb3VudCA9PSAwKQogCQlyZXR1cm4gLUVOWElPOwot
CWlmIChlbmQgPiBjb3VudCkKLQkJcmV0dXJuIC1FTlhJTzsKIAotCWZvciAoaSA9IG9mZnNldDsg
aSA8IGVuZDsgaSsrKSB7Ci0JCXJldCA9IHZtX2luc2VydF9wYWdlKHZtYSwgdWFkZHIsIHJrX29i
ai0+cGFnZXNbaV0pOwotCQlpZiAocmV0KQotCQkJcmV0dXJuIHJldDsKLQkJdWFkZHIgKz0gUEFH
RV9TSVpFOwotCX0KLQotCXJldHVybiAwOworCXJldHVybiB2bV9tYXBfcGFnZXModm1hLCBya19v
YmotPnBhZ2VzLCBjb3VudCk7CiB9CiAKIHN0YXRpYyBpbnQgcm9ja2NoaXBfZHJtX2dlbV9vYmpl
Y3RfbW1hcF9kbWEoc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmosCi0tIAoxLjkuMQoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClhlbi1kZXZlbCBtYWls
aW5nIGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbnByb2plY3Qub3JnCmh0dHBzOi8vbGlzdHMueGVu
cHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby94ZW4tZGV2ZWw=
