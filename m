From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/intel: quirk to disable DMAR for QM57
 igfx
Date: Tue, 22 Jan 2019 12:01:09 +0100
Message-ID: <20190122110109.x3zoynemdl3ysbsn@8bytes.org>
References: <20181227114948.ev4b3jte3ubsc5us@dcvr>
 <154642214920.6261.102817444136744919@jlahtine-desk.ger.corp.intel.com>
 <20190104010626.e6yqdqkmdcqjepke@dcvr>
 <154659116310.4596.13613897418163029789@jlahtine-desk.ger.corp.intel.com>
 <20190118121705.a4usvhnskyblooja@dcvr>
 <20190122103914.msboylvkor5sb5lq@8bytes.org>
 <CAKMK7uEX1T6_yXoq_d4Fs2LiWC_tDaEEXv-hTL=S-_4HEeya7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CAKMK7uEX1T6_yXoq_d4Fs2LiWC_tDaEEXv-hTL=S-_4HEeya7A@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Eric Wong <e@80x24.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>, dri-devel <dri-devel@lists.freedesktop.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: iommu@lists.linux-foundation.org

SGkgRGFuaWVsLAoKT24gVHVlLCBKYW4gMjIsIDIwMTkgYXQgMTE6NDY6MzlBTSArMDEwMCwgRGFu
aWVsIFZldHRlciB3cm90ZToKPiBOb3RlIHRoYXQgdGhlIHN0cmluZyBvZiBwbGF0Zm9ybXMgd2hp
Y2ggaGF2ZSB2YXJpb3VzIGlzc3VlcyB3aXRoIGlvbW11Cj4gYW5kIGlnZnggaXMgdmVyeSBsb25n
LCB0aHVzIGZhciB3ZSBvbmx5IGRpc2FibGVkIGl0IHdoZXJlIHRoZXJlJ3Mgbm8KPiB3b3JrYXJv
dW5kIHRvIHN0b3AgaXQgZnJvbSBoYW5naW5nIHRoZSBib3gsIGJ1dCBvdGhlcndpc2UgbGVmdCBp
dAo+IGVuYWJsZWQuIFNvIGlmIHdlIG1ha2UgYSBwb2xpY3kgY2hhbmdlIHRvIGFsc28gZGlzYWJs
ZSBpdCBhbnl3aGVyZQo+IHdoZXJlIGl0IGRvZXNuJ3Qgd29yayB3ZWxsIChpbnN0ZWFkIG9mIG5v
dCBhdCBhbGwpLCB0aGVyZSdzIGEgcGlsZQo+IG1vcmUgcGxhdGZvcm1zIHRvIHN3aXRjaC4KCkkg
dGhpbmsgaXRzIGJlc3QgdG8ganVzdCBkaXNhYmxlIGlvbW11IGZvciB0aGUgaWdmeCBkZXZpY2Vz
IG9uIHRoZXNlCnBsYXRmb3Jtcy4gQ2FuIHlvdSBwaWNrIHVwIEVyaWMncyBwYXRjaCBhbmQgZXh0
ZW5kIGl0IHdpdGggdGhlIGxpc3Qgb2YKYWZmZWN0ZWQgcGxhdGZvcm1zPwoKVGhhbmtzLAoKCUpv
ZXJnCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVs
LWdmeCBtYWlsaW5nIGxpc3QKSW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
