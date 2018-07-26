From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH v1 6/6] Revert "drm/nouveau: tegra: Detach
 from ARM DMA/IOMMU mapping"
Date: Fri, 27 Jul 2018 02:16:24 +0300
Message-ID: <20180726231624.21084-7-digetx@gmail.com>
References: <20180726231624.21084-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180726231624.21084-1-digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/nouveau>
List-Post: <mailto:nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Nouveau" <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <cyndis-/1wQRMveznE@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

SW1wcm9wZXIgRE1BIGJhY2tpbmcgd2l0aCBJT01NVSBoYXMgYmVlbiByZXNvbHZlZCBub3cgdXNp
bmcgdGhlIG5ldwpkcml2ZXJzIGNvcmUgb3B0aW9uIHRoYXQgYWxsb3dzIHRvIGF2b2lkIHRoZSBp
bXBsaWNpdCBiYWNraW5nLCBoZW5jZQpkZXRhY2hpbmcgaXNuJ3QgbmVjZXNzYXJ5IGFueW1vcmUu
CgpUaGlzIHJldmVydHMgY29tbWl0IGI1OWZiNDgyYjUyMjY5OTc3ZWU1ZGUyMDUzMDhlNWIyMzZh
MDM5MTcuCgpTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgT3NpcGVua28gPGRpZ2V0eEBnbWFpbC5jb20+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvbnZrbS9lbmdpbmUvZGV2aWNlL3RlZ3JhLmMg
fCAxMyAtLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTMgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvbnZrbS9lbmdpbmUvZGV2aWNlL3RlZ3Jh
LmMgYi9kcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9udmttL2VuZ2luZS9kZXZpY2UvdGVncmEuYwpp
bmRleCAwZTM3MmExOTBkM2YuLjc4NTk3ZGE2MzEzYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL25vdXZlYXUvbnZrbS9lbmdpbmUvZGV2aWNlL3RlZ3JhLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL25vdXZlYXUvbnZrbS9lbmdpbmUvZGV2aWNlL3RlZ3JhLmMKQEAgLTIzLDEwICsyMyw2IEBA
CiAjaWZkZWYgQ09ORklHX05PVVZFQVVfUExBVEZPUk1fRFJJVkVSCiAjaW5jbHVkZSAicHJpdi5o
IgogCi0jaWYgSVNfRU5BQkxFRChDT05GSUdfQVJNX0RNQV9VU0VfSU9NTVUpCi0jaW5jbHVkZSA8
YXNtL2RtYS1pb21tdS5oPgotI2VuZGlmCi0KIHN0YXRpYyBpbnQKIG52a21fZGV2aWNlX3RlZ3Jh
X3Bvd2VyX3VwKHN0cnVjdCBudmttX2RldmljZV90ZWdyYSAqdGRldikKIHsKQEAgLTEwOSwxNSAr
MTA1LDYgQEAgbnZrbV9kZXZpY2VfdGVncmFfcHJvYmVfaW9tbXUoc3RydWN0IG52a21fZGV2aWNl
X3RlZ3JhICp0ZGV2KQogCXVuc2lnbmVkIGxvbmcgcGdzaXplX2JpdG1hcDsKIAlpbnQgcmV0Owog
Ci0jaWYgSVNfRU5BQkxFRChDT05GSUdfQVJNX0RNQV9VU0VfSU9NTVUpCi0JaWYgKGRldi0+YXJj
aGRhdGEubWFwcGluZykgewotCQlzdHJ1Y3QgZG1hX2lvbW11X21hcHBpbmcgKm1hcHBpbmcgPSB0
b19kbWFfaW9tbXVfbWFwcGluZyhkZXYpOwotCi0JCWFybV9pb21tdV9kZXRhY2hfZGV2aWNlKGRl
dik7Ci0JCWFybV9pb21tdV9yZWxlYXNlX21hcHBpbmcobWFwcGluZyk7Ci0JfQotI2VuZGlmCi0K
IAlpZiAoIXRkZXYtPmZ1bmMtPmlvbW11X2JpdCkKIAkJcmV0dXJuOwogCi0tIAoyLjE4LjAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCk5vdXZlYXUgbWFp
bGluZyBsaXN0Ck5vdXZlYXVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vbm91dmVhdQo=
