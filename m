From: Caesar Wang <sasukewxt@163.com>
Subject: Re: iommu/rockchip: Fix bugs and enable on ARM64
Date: Wed, 8 Mar 2017 13:50:04 +0800
Message-ID: <fd2e0b00-bb7f-6383-7f79-f17713cbf244@163.com>
References: <1466734413-7453-1-git-send-email-zhengsq@rock-chips.com>
 <20160627125751.GN11432@8bytes.org> <577EFB86.1060502@rock-chips.com>
 <575f6cd7-6e03-e701-78ed-ea2fe9f7573c@suse.com>
 <20160715161651.GS12639@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160715161651.GS12639@8bytes.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shunqian Zheng <zhengsq@rock-chips.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>, heiko@sntech.de, linux-rockchip@lists.infradead.org, airlied@linux.ie, Joerg Roedel <joro@8bytes.org>, linux@armlinux.org.uk, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, tfiga@google.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org, Mark yao <mark.yao@rock-chips.com>, linux-arm-kernel@lists.infradead.org, xxm@rock-chips.com
List-Id: iommu@lists.linux-foundation.org

U2h1bnFpYW4sCnNvbWV0aGluZyBpcyBkZXBlbmRpbmcgb24gdGhlc2UgcGF0Y2hlcywgY2FuIHlv
dSByZXNlbmQgdGhlc2UgcGF0Y2hlcyB0byAKc29sdmUgdGhlCmNvbXBpbGUgZXJyb3JzPwoKLUNh
ZXNhcgrlnKggMjAxNuW5tDA35pyIMTbml6UgMDA6MTYsIEpvZXJnIFJvZWRlbCDlhpnpgZM6Cj4g
T24gRnJpLCBKdWwgMTUsIDIwMTYgYXQgMDU6MzI6MDJQTSArMDIwMCwgTWF0dGhpYXMgQnJ1Z2dl
ciB3cm90ZToKPj4+IFRoZSBkcm0gcm9ja2NoaXAgcGF0Y2hlcyBhcmUgZGVwZW5kZW50IG9uIGlv
bW11L3JvY2tjaGlwIHBhdGNoZXMsIGNhbgo+Pj4geW91IGFsc28gYXBwbHkgdGhlc2UgcGF0Y2hl
cyB0b2dldGhlcj8gU28gdGhhdCBjYW4gYXZvaWQgY29tcGlsZSBwcm9ibGVtLgo+Pj4KPj4gV2hp
bGUgYXQgaXQuIEkgZG9uJ3Qgc2VlIHBhdGNoIDggKGlvbW11L0tjb25maWcpIGluIGxpbnV4LW5l
eHQuCj4+IEkgc3VwcG9zZSB5b3UgZm9yZ290IHRvIHBpY2sgdGhhdCBvbmUuCj4gSSBwaWNrZWQg
aXQgdXAgZmlyc3QsIGJ1dCBpdCBjYXVzZXMgY29tcGlsZSBlcnJvcnMsIHNvIEkgcmVtb3ZlZCBp
dCBmb3IKPiBub3cuCj4KPgo+IAlKb2VyZwo+Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+IExpbnV4LXJvY2tjaGlwIG1haWxpbmcgbGlzdAo+IExp
bnV4LXJvY2tjaGlwQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJvY2tjaGlwCgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
