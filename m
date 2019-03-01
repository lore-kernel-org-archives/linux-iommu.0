From: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [RFC PATCH v1 04/15] iommu: Add DOMAIN_ATTR_PTBASE
Date: Fri,  1 Mar 2019 12:38:26 -0700
Message-ID: <1551469117-3404-5-git-send-email-jcrouse@codeaurora.org>
References: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1551469117-3404-1-git-send-email-jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dianders-uWgjrcJnOmJ4cg9Nei1l7Q@public.gmane.org, hoegsberg-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

QWRkIGFuIGF0dHJpYnV0ZSB0byByZXR1cm4gdGhlIGJhc2UgYWRkcmVzcyBvZiB0aGUgcGFnZXRh
YmxlLiBUaGlzIGlzIHVzZWQKYnkgYXV4aWxpYXJ5IGRvbWFpbnMgZnJvbSBhcm0tc21tdSB0byBy
ZXR1cm4gdGhlIGFkZHJlc3Mgb2YgdGhlIHBhZ2V0YWJsZQp0byB0aGUgbGVhZiBkcml2ZXIgc28g
dGhhdCBpdCBjYW4gc2V0IHRoZSBhcHByb3ByaWF0ZSBwYWdldGFibGUgdGhyb3VnaAppdCdzIG93
biBtZWFucy4KClNpZ25lZC1vZmYtYnk6IEpvcmRhbiBDcm91c2UgPGpjcm91c2VAY29kZWF1cm9y
YS5vcmc+Ci0tLQoKIGluY2x1ZGUvbGludXgvaW9tbXUuaCB8IDEgKwogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pb21tdS5oIGIvaW5j
bHVkZS9saW51eC9pb21tdS5oCmluZGV4IDNmMjI1MGIuLmRjNjBhNzEgMTAwNjQ0Ci0tLSBhL2lu
Y2x1ZGUvbGludXgvaW9tbXUuaAorKysgYi9pbmNsdWRlL2xpbnV4L2lvbW11LmgKQEAgLTEyNiw2
ICsxMjYsNyBAQCBlbnVtIGlvbW11X2F0dHIgewogCURPTUFJTl9BVFRSX05FU1RJTkcsCS8qIHR3
byBzdGFnZXMgb2YgdHJhbnNsYXRpb24gKi8KIAlET01BSU5fQVRUUl9ETUFfVVNFX0ZMVVNIX1FV
RVVFLAogCURPTUFJTl9BVFRSX1NQTElUX1RBQkxFUywKKwlET01BSU5fQVRUUl9QVEJBU0UsCiAJ
RE9NQUlOX0FUVFJfTUFYLAogfTsKIAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkZyZWVkcmVubyBtYWlsaW5nIGxpc3QKRnJlZWRyZW5v
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2ZyZWVkcmVubw==
