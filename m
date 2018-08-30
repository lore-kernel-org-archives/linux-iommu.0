From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] dma-mapping: fix return type of dma_set_max_seg_size()
Date: Thu, 30 Aug 2018 10:31:26 +0200
Message-ID: <CAMuHMdX2nUXG9Ue8fip4mW=to62OAtKeXPpgF1G2=xUP5uHDpQ@mail.gmail.com>
References: <20180829212921.10665-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180829212921.10665-1-niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
Cc: Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gV2VkLCBBdWcgMjksIDIwMTggYXQgMTE6MzAgUE0gTmlrbGFzIFPDtmRlcmx1bmQKPG5pa2xh
cy5zb2Rlcmx1bmQrcmVuZXNhc0ByYWduYXRlY2guc2U+IHdyb3RlOgo+IFRoZSBmdW5jdGlvbiBk
bWFfc2V0X21heF9zZWdfc2l6ZSgpIGNhbiByZXR1cm4gZWl0aGVyIDAgb24gc3VjY2VzcyBvcgo+
IC1FSU8gb24gZXJyb3IuIENoYW5nZSBpdHMgcmV0dXJuIHR5cGUgZnJvbSB1bnNpZ25lZCBpbnQg
dG8gaW50IHRvCj4gY2FwdHVyZSB0aGlzLgo+Cj4gU2lnbmVkLW9mZi1ieTogTmlrbGFzIFPDtmRl
cmx1bmQgPG5pa2xhcy5zb2Rlcmx1bmQrcmVuZXNhc0ByYWduYXRlY2guc2U+CgpSZXZpZXdlZC1i
eTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4KCkdye29ldGpl
LGVldGluZ31zLAoKICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQKCi0tIApHZWVydCBVeXR0
ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxp
bnV4LW02OGsub3JnCgpJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBl
b3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtpbmcgdG8gam91
cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
