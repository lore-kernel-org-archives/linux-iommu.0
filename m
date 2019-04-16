From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: [REBASE PATCH v5 2/9] arm: mm: dma-mapping: Convert to
 use vm_map_pages()
Date: Tue, 16 Apr 2019 17:19:43 +0530
Message-ID: <936e5e107c746a7310e3a3c471188ca3ac8f9754.1552921225.git.jrdr.linux__37381.7054017977$1555415269$gmane$org@gmail.com>
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
bnV4QGdtYWlsLmNvbT4KLS0tCiBhcmNoL2FybS9tbS9kbWEtbWFwcGluZy5jIHwgMjIgKysrKysr
LS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMTYgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbW0vZG1hLW1hcHBpbmcuYyBiL2FyY2gv
YXJtL21tL2RtYS1tYXBwaW5nLmMKaW5kZXggZjFlMjkyMi4uZGU3Yzc2ZSAxMDA2NDQKLS0tIGEv
YXJjaC9hcm0vbW0vZG1hLW1hcHBpbmcuYworKysgYi9hcmNoL2FybS9tbS9kbWEtbWFwcGluZy5j
CkBAIC0xNTc1LDMxICsxNTc1LDIxIEBAIHN0YXRpYyBpbnQgX19hcm1faW9tbXVfbW1hcF9hdHRy
cyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hCiAJCSAgICB2
b2lkICpjcHVfYWRkciwgZG1hX2FkZHJfdCBkbWFfYWRkciwgc2l6ZV90IHNpemUsCiAJCSAgICB1
bnNpZ25lZCBsb25nIGF0dHJzKQogewotCXVuc2lnbmVkIGxvbmcgdWFkZHIgPSB2bWEtPnZtX3N0
YXJ0OwotCXVuc2lnbmVkIGxvbmcgdXNpemUgPSB2bWEtPnZtX2VuZCAtIHZtYS0+dm1fc3RhcnQ7
CiAJc3RydWN0IHBhZ2UgKipwYWdlcyA9IF9faW9tbXVfZ2V0X3BhZ2VzKGNwdV9hZGRyLCBhdHRy
cyk7CiAJdW5zaWduZWQgbG9uZyBucl9wYWdlcyA9IFBBR0VfQUxJR04oc2l6ZSkgPj4gUEFHRV9T
SElGVDsKLQl1bnNpZ25lZCBsb25nIG9mZiA9IHZtYS0+dm1fcGdvZmY7CisJaW50IGVycjsKIAog
CWlmICghcGFnZXMpCiAJCXJldHVybiAtRU5YSU87CiAKLQlpZiAob2ZmID49IG5yX3BhZ2VzIHx8
ICh1c2l6ZSA+PiBQQUdFX1NISUZUKSA+IG5yX3BhZ2VzIC0gb2ZmKQorCWlmICh2bWEtPnZtX3Bn
b2ZmID49IG5yX3BhZ2VzKQogCQlyZXR1cm4gLUVOWElPOwogCi0JcGFnZXMgKz0gb2ZmOwotCi0J
ZG8gewotCQlpbnQgcmV0ID0gdm1faW5zZXJ0X3BhZ2Uodm1hLCB1YWRkciwgKnBhZ2VzKyspOwot
CQlpZiAocmV0KSB7Ci0JCQlwcl9lcnIoIlJlbWFwcGluZyBtZW1vcnkgZmFpbGVkOiAlZFxuIiwg
cmV0KTsKLQkJCXJldHVybiByZXQ7Ci0JCX0KLQkJdWFkZHIgKz0gUEFHRV9TSVpFOwotCQl1c2l6
ZSAtPSBQQUdFX1NJWkU7Ci0JfSB3aGlsZSAodXNpemUgPiAwKTsKKwllcnIgPSB2bV9tYXBfcGFn
ZXModm1hLCBwYWdlcywgbnJfcGFnZXMpOworCWlmIChlcnIpCisJCXByX2VycigiUmVtYXBwaW5n
IG1lbW9yeSBmYWlsZWQ6ICVkXG4iLCBlcnIpOwogCi0JcmV0dXJuIDA7CisJcmV0dXJuIGVycjsK
IH0KIHN0YXRpYyBpbnQgYXJtX2lvbW11X21tYXBfYXR0cnMoc3RydWN0IGRldmljZSAqZGV2LAog
CQlzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwgdm9pZCAqY3B1X2FkZHIsCi0tIAoxLjkuMQoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClhlbi1kZXZl
bCBtYWlsaW5nIGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbnByb2plY3Qub3JnCmh0dHBzOi8vbGlz
dHMueGVucHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby94ZW4tZGV2ZWw=
