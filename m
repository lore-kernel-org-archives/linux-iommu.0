From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: [REBASE PATCH v5 8/9] xen/gntdev.c: Convert to use vm_map_pages()
Date: Tue, 16 Apr 2019 17:19:49 +0530
Message-ID: <88e56e82d2db98705c2d842e9c9806c00b366d67.1552921225.git.jrdr.linux__28344.8513293237$1555484636$gmane$org@gmail.com>
References: <cover.1552921225.git.jrdr.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <cover.1552921225.git.jrdr.linux@gmail.com>
In-Reply-To: <cover.1552921225.git.jrdr.linux@gmail.com>
References: <cover.1552921225.git.jrdr.linux@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com, kirill.shutemov@linux.intel.com, vbabka@suse.cz, riel@surriel.com, sfr@canb.auug.org.au, rppt@linux.vnet.ibm.com, peterz@infradead.org, linux@armlinux.org.uk, robin.murphy@arm.com, iamjoonsoo.kim@lge.com, treding@nvidia.com, keescook@chromium.org, m.szyprowski@samsung.com, stefanr@s5r6.in-berlin.de, hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie, oleksandr_andrushchenko@epam.com, joro@8bytes.org, pawel@osciak.com, kyungmin.park@samsung.com, mchehab@kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Souptick Joarder <jrdr.linux@gmail.com>, linux1394-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Q29udmVydCB0byB1c2Ugdm1fbWFwX3BhZ2VzKCkgdG8gbWFwIHJhbmdlIG9mIGtlcm5lbAptZW1v
cnkgdG8gdXNlciB2bWEuCgptYXAtPmNvdW50IGlzIHBhc3NlZCB0byB2bV9tYXBfcGFnZXMoKSBh
bmQgaW50ZXJuYWwgQVBJCnZlcmlmeSBtYXAtPmNvdW50IGFnYWluc3QgY291bnQgKCBjb3VudCA9
IHZtYV9wYWdlcyh2bWEpKQpmb3IgcGFnZSBhcnJheSBib3VuZGFyeSBvdmVycnVuIGNvbmRpdGlv
bi4KClNpZ25lZC1vZmYtYnk6IFNvdXB0aWNrIEpvYXJkZXIgPGpyZHIubGludXhAZ21haWwuY29t
PgpSZXZpZXdlZC1ieTogQm9yaXMgT3N0cm92c2t5IDxib3Jpcy5vc3Ryb3Zza3lAb3JhY2xlLmNv
bT4KLS0tCiBkcml2ZXJzL3hlbi9nbnRkZXYuYyB8IDExICsrKystLS0tLS0tCiAxIGZpbGUgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMveGVuL2dudGRldi5jIGIvZHJpdmVycy94ZW4vZ250ZGV2LmMKaW5kZXggNWVmYzVlZS4uNWQ2
NDI2MiAxMDA2NDQKLS0tIGEvZHJpdmVycy94ZW4vZ250ZGV2LmMKKysrIGIvZHJpdmVycy94ZW4v
Z250ZGV2LmMKQEAgLTEwODQsNyArMTA4NCw3IEBAIHN0YXRpYyBpbnQgZ250ZGV2X21tYXAoc3Ry
dWN0IGZpbGUgKmZsaXAsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQogCWludCBpbmRleCA9
IHZtYS0+dm1fcGdvZmY7CiAJaW50IGNvdW50ID0gdm1hX3BhZ2VzKHZtYSk7CiAJc3RydWN0IGdu
dGRldl9ncmFudF9tYXAgKm1hcDsKLQlpbnQgaSwgZXJyID0gLUVJTlZBTDsKKwlpbnQgZXJyID0g
LUVJTlZBTDsKIAogCWlmICgodm1hLT52bV9mbGFncyAmIFZNX1dSSVRFKSAmJiAhKHZtYS0+dm1f
ZmxhZ3MgJiBWTV9TSEFSRUQpKQogCQlyZXR1cm4gLUVJTlZBTDsKQEAgLTExNDUsMTIgKzExNDUs
OSBAQCBzdGF0aWMgaW50IGdudGRldl9tbWFwKHN0cnVjdCBmaWxlICpmbGlwLCBzdHJ1Y3Qgdm1f
YXJlYV9zdHJ1Y3QgKnZtYSkKIAkJZ290byBvdXRfcHV0X21hcDsKIAogCWlmICghdXNlX3B0ZW1v
ZCkgewotCQlmb3IgKGkgPSAwOyBpIDwgY291bnQ7IGkrKykgewotCQkJZXJyID0gdm1faW5zZXJ0
X3BhZ2Uodm1hLCB2bWEtPnZtX3N0YXJ0ICsgaSpQQUdFX1NJWkUsCi0JCQkJbWFwLT5wYWdlc1tp
XSk7Ci0JCQlpZiAoZXJyKQotCQkJCWdvdG8gb3V0X3B1dF9tYXA7Ci0JCX0KKwkJZXJyID0gdm1f
bWFwX3BhZ2VzKHZtYSwgbWFwLT5wYWdlcywgbWFwLT5jb3VudCk7CisJCWlmIChlcnIpCisJCQln
b3RvIG91dF9wdXRfbWFwOwogCX0gZWxzZSB7CiAjaWZkZWYgQ09ORklHX1g4NgogCQkvKgotLSAK
MS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRy
aS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
