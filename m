From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 03/14] iommu: Create a base struct for io_mm
Date: Fri, 2 Mar 2018 12:25:48 +0000
Message-ID: <fddafdae-4384-4826-ef63-9075e9866ae9@arm.com>
References: <20180221225924.30737-1-jcrouse@codeaurora.org>
 <20180221225924.30737-4-jcrouse@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180221225924.30737-4-jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Yisheng Xie <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bob Liu <liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

SGkgSm9yZGFuLAoKVGhhbmsgeW91IGZvciB0aGlzLCBTTU1VdjMgYW5kIHZpcnRpby1pb21tdSBu
ZWVkIHRoZXNlIFNWQSBwYXRjaGVzIGFzIHdlbGwuCgpPbiAyMS8wMi8xOCAyMjo1OSwgSm9yZGFu
IENyb3VzZSB3cm90ZToKWy4uLl0+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lvbW11Lmgg
Yi9pbmNsdWRlL2xpbnV4L2lvbW11LmgKPiBpbmRleCBlMmM0OWU1ODNkOGQuLmU5OTgzODljZjE5
NSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2lvbW11LmgKPiArKysgYi9pbmNsdWRlL2xp
bnV4L2lvbW11LmgKPiBAQCAtMTEwLDggKzExMCwxNyBAQCBzdHJ1Y3QgaW9tbXVfZG9tYWluIHsK
PiAgCXN0cnVjdCBsaXN0X2hlYWQgbW1fbGlzdDsKPiAgfTsKPiAgCj4gK2VudW0gaW9tbXVfaW9f
dHlwZSB7Cj4gKwlJT19UWVBFX01NLAo+ICt9Owo+ICsKPiArc3RydWN0IGlvX2Jhc2Ugewo+ICsJ
aW50IHR5cGU7Cj4gKwlpbnQgcGFzaWQ7Cj4gK307CgoiaW9fYmFzZSIgaXMgYSBiaXQgdmFndWUu
IEknbSBiYWQgYXQgbmFtaW5nIHNvIG15IG9waW5pb24gZG9lc24ndCBob2xkCm11Y2ggd2F0ZXIs
IGJ1dCBJJ2QgcmF0aGVyIHRoaXMgYmUgc29tZXRoaW5nIGxpa2UgImlvX21tX2Jhc2UiLiBXaGVu
IEkKaW5pdGlhbGx5IHRveWVkIHdpdGggdGhlIGlkZWEgSSBpbnRlbmRlZCB0byBrZWVwIGlvX21t
IGFzIHBhcmVudCBzdHJ1Y3R1cmUKYW5kIGhhdmUgInByaXZhdGUiIGFuZCAic2hhcmVkIiBzdWIt
c3RydWN0dXJlcy4gRXZlbiBpZiBwcml2YXRlIFBBU0lEcwpkb24ndCByZWx5IG9uIHRoZSBrZXJu
ZWwgbW0gc3Vic3lzdGVtLCB0aGlzIHN0cnVjdHVyZSB3b3VsZCBzdGlsbApyZXByZXNlbnQgYW4g
SS9PIG1tIG9mIHNvcnRzLCB3aXRoIGEgcGdkIGFuZCBwZ3RhYmxlIGluZm8uCgpUaGFua3MsCkpl
YW4KCj4gKwo+ICBzdHJ1Y3QgaW9fbW0gewo+IC0JaW50CQkJcGFzaWQ7Cj4gKwlzdHJ1Y3QgaW9f
YmFzZQkJYmFzZTsKPiAgCXN0cnVjdCBsaXN0X2hlYWQJZGV2aWNlczsKPiAgCXN0cnVjdCBrcmVm
CQlrcmVmOwo+ICAjaWYgZGVmaW5lZChDT05GSUdfTU1VX05PVElGSUVSKQo+IAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KRnJlZWRyZW5vIG1haWxpbmcg
bGlzdApGcmVlZHJlbm9AbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZnJlZWRyZW5vCg==
