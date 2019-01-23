From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: Re: [PATCH] iommu/intel: quirk to disable DMAR for QM57 igfx
Date: Wed, 23 Jan 2019 17:02:38 +0200
Message-ID: <154825575844.19121.1110495981060533179@jlahtine-desk.ger.corp.intel.com>
References: <20181227114948.ev4b3jte3ubsc5us@dcvr>
 <154642214920.6261.102817444136744919@jlahtine-desk.ger.corp.intel.com>
 <20190104010626.e6yqdqkmdcqjepke@dcvr>
 <154659116310.4596.13613897418163029789@jlahtine-desk.ger.corp.intel.com>
 <20190118121705.a4usvhnskyblooja@dcvr>
 <20190122103914.msboylvkor5sb5lq@8bytes.org>
 <CAKMK7uEX1T6_yXoq_d4Fs2LiWC_tDaEEXv-hTL=S-_4HEeya7A@mail.gmail.com>
 <20190122110109.x3zoynemdl3ysbsn@8bytes.org>
 <154816850584.8871.13562920355478587539@jlahtine-desk.ger.corp.intel.com>
 <20190122165135.6rkdsxqepvmaoatn@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190122165135.6rkdsxqepvmaoatn@8bytes.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Cc: Eric Wong <e@80x24.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>, dri-devel <dri-devel@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: iommu@lists.linux-foundation.org

UXVvdGluZyBKb2VyZyBSb2VkZWwgKDIwMTktMDEtMjIgMTg6NTE6MzUpCj4gT24gVHVlLCBKYW4g
MjIsIDIwMTkgYXQgMDQ6NDg6MjZQTSArMDIwMCwgSm9vbmFzIExhaHRpbmVuIHdyb3RlOgo+ID4g
QWNjb3JkaW5nIHRvIG91ciBJT01NVSBmb2xrcyB0aGVyZSBleGlzdHMgc29tZSBkZXNpcmUgdG8g
YmUgYWJsZSB0byBhc3NpZ24KPiA+IHRoZSBpR0ZYIGRldmljZSBha2EgaGF2ZSBpbnRlbF9pb21t
dT1vbiBpbnN0ZWFkIG9mIGludGVsX2lvbW11PWlnZnhfb2ZmCj4gPiBkdWUgdG8gaG93IHRoZSBk
ZXZpY2VzIG1pZ2h0IGJlIGdyb3VwZWQgaW4gSU9NTVUgZ3JvdXBzLiBFdmVuIHdoZW4geW91Cj4g
PiB3b3VsZCBub3QgYmUgdXNpbmcgdGhlIGlHRlggZGV2aWNlLgo+IAo+IFlvdSBjYW4gZm9yY2Ug
dGhlIGlnZnggZGV2aWNlIGludG8gYSBTSSBkb21haW4sIG9yIGRvZXMgdGhhdCBhbHNvCj4gdHJp
Z2dlciB0aGUgaW9tbXUgaXNzdWVzIG9uIHRoZSBjaGlwc2V0PwoKVG8gYmUgaG9uZXN0LCB3ZSd2
ZSBoYWQgYSBtaXh0dXJlIGRpZmZlcmVudCBpc3N1ZXMgb24gZGlmZmVyZW50IFNLVXMKdGhhdCBo
YXZlIG5vdCBiZWVuIGhpdCBpbiB0aGUgcGFzdCB3aGVuIGludGVsX2lvbW11IHdhcyBqdXN0IGRp
c2FibGVkIGJ5CmRlZmF1bHQuCgpJIGtub3cgdGhhdCBpbiBvbmUgZ3JvdXAgb2YgdGhlIHByb2Js
ZW1zLCB0aGUgaXNzdWUgaGFzIGJlZW4gZGVidWdnZWQKaW50byB0aGUgR1BVIGhhdmluZyBpdHMg
b3duIHNldCBvZiB2aXJ0dWFsaXphdGlvbiBtYXBwaW5nIHRyYW5zbGF0aW9uCmhhcmR3YXJlIHdp
dGggY2FjaGluZyBhbmQgaXQgZmFpbHMgdG8gdHJhY2sgY2hhbmdlcyB0byB0aGUgbWFwcGluZy4g
U28KaWYgYSBpZGVudGl0eSBtYXBwaW5nIHdhcyBlc3RhYmxpc2hlZCBhbmQgbmV2ZXIgY2hhbmdl
ZCwgSSdkIGFzc3VtZSB0aGF0CnRvIGZpeCBhdCBsZWFzdCB0aGF0IGNsYXNzIG9mIHByb2JsZW1z
LgoKV291bGQganVzdCBwYXNzaW5nIGludGVsX2lvbW11PW9uIGFscmVhZHkgY2F1c2UgYSBub24t
aWRlbnRpdHkgbWFwcGluZyB0bwpwb3NzaWJseSBiZSB1c2VkIGZvciB0aGUgaW50ZWdyYXRlZCBH
UFU/IElmIGl0IGRpZCwgdGhlbiBpdCB3b3VsZApleHBsYWluIHF1aXRlIGZldyBvZiB0aGUgaXNz
dWVzLgoKV2UgaGF2ZSBtYW55IHJlcG9ydHMgd2hlcmUganVzdCBoYXZpbmcgaW50ZWxfaW9tbXU9
b24gKGFuZCB1c2luZyB0aGUKc3lzdGVtIG5vcm1hbGx5LCB3aXRob3V0IGFueSB2aXJ0dWFsaXph
dGlvbiBzdHVmZiBnb2luZyBvbikgd2lsbCBjYXVzZQp1bmV4cGxhaW5lZCBHUFUgaGFuZ3MuIEZv
ciB0aG9zZSB1c2Vycywgc2ltcGx5IHN3aXRjaGluZyB0bwppbnRlbF9pb21tdT1pZ2Z4X29mZiBz
b2x2ZXMgdGhlIHByb2JsZW1zLCBhbmQgdGhlIGRlYnVnIG9mdGVuIGVuZHMKdGhlcmUuCgpSZWdh
cmRzLCBKb29uYXMKCj4gSW4gYW55IGNhc2UsIGlmIGlvbW11PW9uIGJyZWFrcyB0aGVzZSBzeXN0
ZW1zIEkgd2FudCB0byBtYWtlIHRoZW0gd29yawo+IGFnYWluIHdpdGggb3B0LW91dCwgZXZlbiBh
dCB0aGUgY29zdCBvZiBicmVha2luZyBhc3NpZ25hYmlsaXR5Lgo+IAo+IFJlZ2FyZHMsCj4gCj4g
ICAgICAgICBKb2VyZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2
ZWwK
