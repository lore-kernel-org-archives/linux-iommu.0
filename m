From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: [REBASE PATCH v5 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_map_pages_zero()
Date: Tue, 16 Apr 2019 17:19:44 +0530
Message-ID: <88645f5ea8202784a8baaf389e592aeb8c505e8e.1552921225.git.jrdr.linux__18527.7674392395$1555484686$gmane$org@gmail.com>
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

Q29udmVydCB0byB1c2Ugdm1fbWFwX3BhZ2VzX3plcm8oKSB0byBtYXAgcmFuZ2Ugb2Yga2VybmVs
IG1lbW9yeQp0byB1c2VyIHZtYS4KClRoaXMgZHJpdmVyIGhhcyBpZ25vcmVkIHZtX3Bnb2ZmIGFu
ZCBtYXBwZWQgdGhlIGVudGlyZSBwYWdlcy4gV2UKY291bGQgbGF0ZXIgImZpeCIgdGhlc2UgZHJp
dmVycyB0byBiZWhhdmUgYWNjb3JkaW5nIHRvIHRoZSBub3JtYWwKdm1fcGdvZmYgb2Zmc2V0dGlu
ZyBzaW1wbHkgYnkgcmVtb3ZpbmcgdGhlIF96ZXJvIHN1ZmZpeCBvbiB0aGUKZnVuY3Rpb24gbmFt
ZSBhbmQgaWYgdGhhdCBjYXVzZXMgcmVncmVzc2lvbnMsIGl0IGdpdmVzIHVzIGFuIGVhc3kKd2F5
IHRvIHJldmVydC4KClNpZ25lZC1vZmYtYnk6IFNvdXB0aWNrIEpvYXJkZXIgPGpyZHIubGludXhA
Z21haWwuY29tPgotLS0KIGRyaXZlcnMvZmlyZXdpcmUvY29yZS1pc28uYyB8IDE1ICsrLS0tLS0t
LS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJld2lyZS9jb3JlLWlzby5jIGIvZHJpdmVycy9maXJl
d2lyZS9jb3JlLWlzby5jCmluZGV4IDM1ZTc4NGMuLjU0MTRlYjEgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZmlyZXdpcmUvY29yZS1pc28uYworKysgYi9kcml2ZXJzL2ZpcmV3aXJlL2NvcmUtaXNvLmMK
QEAgLTEwNywxOSArMTA3LDggQEAgaW50IGZ3X2lzb19idWZmZXJfaW5pdChzdHJ1Y3QgZndfaXNv
X2J1ZmZlciAqYnVmZmVyLCBzdHJ1Y3QgZndfY2FyZCAqY2FyZCwKIGludCBmd19pc29fYnVmZmVy
X21hcF92bWEoc3RydWN0IGZ3X2lzb19idWZmZXIgKmJ1ZmZlciwKIAkJCSAgc3RydWN0IHZtX2Fy
ZWFfc3RydWN0ICp2bWEpCiB7Ci0JdW5zaWduZWQgbG9uZyB1YWRkcjsKLQlpbnQgaSwgZXJyOwot
Ci0JdWFkZHIgPSB2bWEtPnZtX3N0YXJ0OwotCWZvciAoaSA9IDA7IGkgPCBidWZmZXItPnBhZ2Vf
Y291bnQ7IGkrKykgewotCQllcnIgPSB2bV9pbnNlcnRfcGFnZSh2bWEsIHVhZGRyLCBidWZmZXIt
PnBhZ2VzW2ldKTsKLQkJaWYgKGVycikKLQkJCXJldHVybiBlcnI7Ci0KLQkJdWFkZHIgKz0gUEFH
RV9TSVpFOwotCX0KLQotCXJldHVybiAwOworCXJldHVybiB2bV9tYXBfcGFnZXNfemVybyh2bWEs
IGJ1ZmZlci0+cGFnZXMsCisJCQkJCWJ1ZmZlci0+cGFnZV9jb3VudCk7CiB9CiAKIHZvaWQgZndf
aXNvX2J1ZmZlcl9kZXN0cm95KHN0cnVjdCBmd19pc29fYnVmZmVyICpidWZmZXIsCi0tIAoxLjku
MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRl
dmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
