From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/10] arm64/iommu: don't remap contiguous allocations
 for coherent devices
Date: Mon, 10 Dec 2018 20:25:08 +0100
Message-ID: <20181210192508.GA31318@lst.de>
References: <20181208173702.15158-1-hch@lst.de>
 <20181208173702.15158-3-hch@lst.de>
 <eaf8ce49-ab5e-7c02-a028-74671172b684@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <eaf8ce49-ab5e-7c02-a028-74671172b684@arm.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org, "Matwey V. Kornilov" <matwey@sai.msu.ru>, iommu@lists.linux-foundation.org, openrisc@lists.librecores.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org, Ezequiel Garcia <ezequiel@collabora.com>, Christoph Hellwig <hch@lst.de>, linux-arm-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

T24gTW9uLCBEZWMgMTAsIDIwMTggYXQgMDc6MTk6MzBQTSArMDAwMCwgUm9iaW4gTXVycGh5IHdy
b3RlOgo+IE9uIDA4LzEyLzIwMTggMTc6MzYsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+PiBU
aGVyZSBpcyBubyBuZWVkIHRvIGhhdmUgYW4gYWRkaXRpb25hbCBrZXJuZWwgbWFwcGluZyBmb3Ig
YSBjb250aWd1b3VzCj4+IGFsbG9jYXRpb24gaWYgdGhlIGRldmljZSBhbHJlYWR5IGlzIERNQSBj
b2hlcmVudCwgc28gc2tpcCBpdC4KPgo+IEZXSVcsIHRoZSAibmVlZCIgd2FzIHRoYXQgaXQga2Vw
dCB0aGUgY29kZSBpbiB0aGlzIHBhdGggc2ltcGxlIGFuZCB0aGUgCj4gbWFwcGluZyBiZWhhdmlv
dXIgY29uc2lzdGVudCB3aXRoIHRoZSByZWd1bGFyIGlvbW11X2RtYV9hbGxvYygpIGNhc2UuIE9u
ZSAKPiBjb3VsZCBxdWl0ZSBlYXNpbHkgcmV0b3J0IHRoYXQgdGhlcmUgaXMgbm8gbmVlZCBmb3Ig
dGhlIGV4dHJhIGNvbXBsZXhpdHkgb2YgCj4gdGhpcyBwYXRjaCwgc2luY2Ugdm1hbGxvYyBpcyBj
aGVhcCBvbiBhIDY0LWJpdCBhcmNoaXRlY3R1cmUgOykKCkhlaC4gIFdlbGwsIHdpdGhvdXQgdGhl
IHJlbWFwIHdlIGRvIGxlc3Mgd29yaywgd2UgcHJlcGFyZSBmb3IgYSBzaW1wbGUKaW1wbGVtZW50
YXRpb24gb2YgRE1BX0FUVFJfTk9OX0NPTlNJU1RFTlQsIGFuZCBhbHNvIHByZXBhcHJlIHRoZSBj
b2RlCnRvIGJlIGJldHRlciByZXVzYWJsZSBmb3IgYXJjaGl0ZWN0dXJlcyB0aGF0IGRvbid0IGRv
IHJlbWFwcGluZyBvZgpETUEgYWxsb2NhdGlvbnMgYXQgYWxsLgoKPj4gICAJCWlmIChhZGRyKSB7
Cj4+ICAgCQkJbWVtc2V0KGFkZHIsIDAsIHNpemUpOwo+PiAtCQkJaWYgKCFjb2hlcmVudCkKPj4g
LQkJCQlfX2RtYV9mbHVzaF9hcmVhKHBhZ2VfdG9fdmlydChwYWdlKSwgaW9zaXplKTsKPj4gKwkJ
CV9fZG1hX2ZsdXNoX2FyZWEocGFnZV90b192aXJ0KHBhZ2UpLCBpb3NpemUpOwo+Cj4gT2ggcG9v
IC0gc2VlbXMgSSBtaXNzZWQgaXQgYXQgdGhlIHRpbWUgYnV0IHRoZSBleGlzdGluZyBsb2dpYyBo
ZXJlIGlzIAo+IHdyb25nLiBMZXQgbWUgc2VuZCBhIHNlcGFyYXRlIGZpeCB0byBmbGlwIHRob3Nl
IHN0YXRlbWVudHMgaW50byB0aGUgY29ycmVjdCAKPiBvcmRlci4uLgoKWWVzLCBmbHVzaGluZyB0
aGUgcmVtYXBwZWQgYWxpYXMgb25seSBhZnRlciB6ZXJvaW5nIGl0IGxvb2tzIG9kZC4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxp
bmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
