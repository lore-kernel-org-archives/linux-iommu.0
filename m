From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH v1 2/6] of/device: Don't back devices DMA with
 IOMMU if that's undesired by driver
Date: Fri, 27 Jul 2018 02:16:20 +0300
Message-ID: <20180726231624.21084-3-digetx@gmail.com>
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

UmVzcGVjdCBkZXZpY2UgZHJpdmVyIHJlcXVpcmVtZW50IGZvciBkZXZpY2UgRE1BIG5vdCB0byBi
ZSBpbXBsaWNpdGx5CmJhY2tlZCB3aXRoIElPTU1VIGJ5IHNraXBwaW5nIHRoZSBiYWNraW5nIHNl
dHVwIGZvciBkcml2ZXJzIHRoYXQgZG8gbm90CndhbnQgdGhhdC4KClNpZ25lZC1vZmYtYnk6IERt
aXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL29mL2RldmljZS5j
IHwgNyArKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9vZi9kZXZpY2UuYyBiL2RyaXZlcnMvb2YvZGV2aWNlLmMKaW5kZXggMzNkODU1
MTFkNzkwLi5lNzBiN2E4ODY4NzUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvb2YvZGV2aWNlLmMKKysr
IGIvZHJpdmVycy9vZi9kZXZpY2UuYwpAQCAtMTYzLDYgKzE2MywxMyBAQCBpbnQgb2ZfZG1hX2Nv
bmZpZ3VyZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsIGJvb2wg
Zm9yY2VfZG1hKQogCWRldl9kYmcoZGV2LCAiZGV2aWNlIGlzJXNiZWhpbmQgYW4gaW9tbXVcbiIs
CiAJCWlvbW11ID8gIiAiIDogIiBub3QgIik7CiAKKwkvKgorCSAqIFJlc3BlY3QgZGV2aWNlIGRy
aXZlciByZXF1aXJlbWVudCBmb3IgZGV2aWNlIERNQSBub3QgdG8gYmUKKwkgKiBpbXBsaWNpdGx5
IGJhY2tlZCB3aXRoIElPTU1VLgorCSAqLworCWlmIChpb21tdSAmJiBkZXYtPmRyaXZlci0+bm9f
aW1wbGljaXRfaW9tbXUpCisJCWlvbW11ID0gTlVMTDsKKwogCWFyY2hfc2V0dXBfZG1hX29wcyhk
ZXYsIGRtYV9hZGRyLCBzaXplLCBpb21tdSwgY29oZXJlbnQpOwogCiAJcmV0dXJuIDA7Ci0tIAoy
LjE4LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCk5v
dXZlYXUgbWFpbGluZyBsaXN0Ck5vdXZlYXVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vbm91dmVhdQo=
