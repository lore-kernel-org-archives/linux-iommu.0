From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH 1/9] iommu/dma-iommu: Add iommu_map_atomic
Date: Sun, 14 Apr 2019 23:30:58 -0700
Message-ID: <20190415063058.GA1377@infradead.org>
References: <20190411184741.27540-1-tmurphy@arista.com>
 <20190411184741.27540-2-tmurphy@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190411184741.27540-2-tmurphy-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Tom Murphy <tmurphy-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, dima-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Brown <david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, murphyt7-/Zw1syy4LHg@public.gmane.org, Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gVGh1LCBBcHIgMTEsIDIwMTkgYXQgMDc6NDc6MzBQTSArMDEwMCwgVG9tIE11cnBoeSB2aWEg
aW9tbXUgd3JvdGU6Cj4gVGhlIGlvbW11IG9wcyAubWFwIGZ1bmN0aW9uIChvciB0aGUgaW9tbXVf
bWFwIGZ1bmN0aW9uIHdoaWNoIGNhbGxzIGl0KQo+IHdhcyBhbHdheXMgc3VwcG9zZWQgdG8gYmUg
c2xlZXBhYmxlIChhY2NvcmRpbmcgdG8gSm9lcmcncyBjb21tZW50IGluCj4gdGhpcyB0aHJlYWQ6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC85Nzc1MjAvICkgYW5kIHNv
Cj4gc2hvdWxkIHByb2JhYmx5IGhhdmUgaGFkIGEgIm1pZ2h0X3NsZWVwKCkiIHNpbmNlIGl0IHdh
cyB3cml0dGVuLiBIb3dldmVyCj4gY3VycmVudGx5IHRoZSBkbWEtaW9tbXUgYXBpIGNhbiBjYWxs
IGlvbW11X21hcCBpbiBhbiBhdG9taWMgY29udGV4dCwKPiB3aGljaCBpdCBzaG91bGRuJ3QgZG8u
IFRoaXMgZG9lc24ndCBjYXVzZSBhbnkgcHJvYmxlbXMgYmVjYXVzZSBhbnkgaW9tbXUKPiBkcml2
ZXIgd2hpY2ggdXNlcyB0aGUgZG1hLWlvbW11IGFwaSB1c2VzIGdmcF9hdG9taWMgaW4gaXQncyBp
b21tdV9vcHMKPiAubWFwIGZ1bmN0aW9uLiBCdXQgZG9pbmcgdGhpcyB3YXN0ZXMgdGhlIG1lbW9y
eSBhbGxvY2F0b3JzIGF0b21pYyBwb29scy4KPiAKPiBBZGQgYSBuZXcgZnVuY3Rpb24gaW9tbXVf
bWFwX2F0b21pYywgdXNlIGl0IGluIHRoZSBkbWEtaW9tbXUgYXBpIGFuZCBhZGQKPiDigJxtaWdo
dF9zbGVlcCgp4oCdIHRvIHRoZSBpb21tdV9tYXAgZnVuY3Rpb24uCj4gCj4gQWZ0ZXIgdGhpcyBj
aGFuZ2UgYWxsIGRyaXZlcnMgd2hpY2ggdXNlIHRoZSBkbWEtaW9tbXUgYXBpIG5lZWQgdG8KPiBp
bXBsZW1lbnQgdGhlIG5ldyBpb21tdSBvcHMgLm1hcF9hdG9taWMgZnVuY3Rpb24uIEZvciB0aGUg
bW9tZW50IGp1c3QKPiByZXVzZSB0aGUgZHJpdmVyJ3MgaW9tbXVzIG9wcyAubWFwIGZ1bmN0aW9u
IGZvciAubWFwX2F0b21pYy4KCkluc3RlYWQgb2YgZHVwbGljYXRpbmcgdGhlIGNhbGxjaGFpbiBz
aG91bGRuJ3Qgd2UganVzdCBwYXNzIGRvd24gYSBmbGFnCnRvIGluZGljYXRlIGlmIHRoZSBjb250
ZXh0IGNhbiBzbGVlcCBvciBub3Q/ICBFc3BlY2lhbGx5IGFzIGFsbCB0aGUKZXhpc3RpbmcgYXJt
IGRyaXZlcnMgYWxyZWFkeSBpbXBsZW1lbnQgdGhlIGF0b21pYyBiZWhhdmlvciwgd2hpY2ggaXMK
YSBtYWpvcml0eSBvZiBzdHJ1Y3QgaW9tbXVfb3BzIGJhc2VkIGlvbW11IGRyaXZlcnMuCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1yb2NrY2hp
cCBtYWlsaW5nIGxpc3QKTGludXgtcm9ja2NoaXBAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJvY2tjaGlwCg==
