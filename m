From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: [REBASE PATCH v5 9/9] xen/privcmd-buf.c: Convert to use
 vm_map_pages_zero()
Date: Tue, 16 Apr 2019 17:19:50 +0530
Message-ID: <acf678e81d554d01a9b590716ac0ccbdcdf71c25.1552921225.git.jrdr.linux__49764.0866016567$1555415336$gmane$org@gmail.com>
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

Q29udmVydCB0byB1c2Ugdm1fbWFwX3BhZ2VzX3plcm8oKSB0byBtYXAgcmFuZ2Ugb2Yga2VybmVs
Cm1lbW9yeSB0byB1c2VyIHZtYS4KClRoaXMgZHJpdmVyIGhhcyBpZ25vcmVkIHZtX3Bnb2ZmLiBX
ZSBjb3VsZCBsYXRlciAiZml4IiB0aGVzZSBkcml2ZXJzCnRvIGJlaGF2ZSBhY2NvcmRpbmcgdG8g
dGhlIG5vcm1hbCB2bV9wZ29mZiBvZmZzZXR0aW5nIHNpbXBseSBieQpyZW1vdmluZyB0aGUgX3pl
cm8gc3VmZml4IG9uIHRoZSBmdW5jdGlvbiBuYW1lIGFuZCBpZiB0aGF0IGNhdXNlcwpyZWdyZXNz
aW9ucywgaXQgZ2l2ZXMgdXMgYW4gZWFzeSB3YXkgdG8gcmV2ZXJ0LgoKU2lnbmVkLW9mZi1ieTog
U291cHRpY2sgSm9hcmRlciA8anJkci5saW51eEBnbWFpbC5jb20+ClJldmlld2VkLWJ5OiBCb3Jp
cyBPc3Ryb3Zza3kgPGJvcmlzLm9zdHJvdnNreUBvcmFjbGUuY29tPgotLS0KIGRyaXZlcnMveGVu
L3ByaXZjbWQtYnVmLmMgfCA4ICsrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL3ByaXZjbWQtYnVm
LmMgYi9kcml2ZXJzL3hlbi9wcml2Y21kLWJ1Zi5jCmluZGV4IGRlMDFhNmQuLmQwMmRjNDMgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMveGVuL3ByaXZjbWQtYnVmLmMKKysrIGIvZHJpdmVycy94ZW4vcHJp
dmNtZC1idWYuYwpAQCAtMTY2LDEyICsxNjYsOCBAQCBzdGF0aWMgaW50IHByaXZjbWRfYnVmX21t
YXAoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQogCWlmICh2
bWFfcHJpdi0+bl9wYWdlcyAhPSBjb3VudCkKIAkJcmV0ID0gLUVOT01FTTsKIAllbHNlCi0JCWZv
ciAoaSA9IDA7IGkgPCB2bWFfcHJpdi0+bl9wYWdlczsgaSsrKSB7Ci0JCQlyZXQgPSB2bV9pbnNl
cnRfcGFnZSh2bWEsIHZtYS0+dm1fc3RhcnQgKyBpICogUEFHRV9TSVpFLAotCQkJCQkgICAgIHZt
YV9wcml2LT5wYWdlc1tpXSk7Ci0JCQlpZiAocmV0KQotCQkJCWJyZWFrOwotCQl9CisJCXJldCA9
IHZtX21hcF9wYWdlc196ZXJvKHZtYSwgdm1hX3ByaXYtPnBhZ2VzLAorCQkJCQkJdm1hX3ByaXYt
Pm5fcGFnZXMpOwogCiAJaWYgKHJldCkKIAkJcHJpdmNtZF9idWZfdm1hcHJpdl9mcmVlKHZtYV9w
cml2KTsKLS0gCjEuOS4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KWGVuLWRldmVsIG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVucHJvamVj
dC5vcmcKaHR0cHM6Ly9saXN0cy54ZW5wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3hlbi1k
ZXZlbA==
