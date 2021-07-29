Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB84C4338F
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 02:55:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5235B60EBC
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 02:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5235B60EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A1D44035C;
	Thu, 29 Jul 2021 02:55:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tRz2rf2s57TE; Thu, 29 Jul 2021 02:55:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CFC1F402D2;
	Thu, 29 Jul 2021 02:55:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2E47C0010;
	Thu, 29 Jul 2021 02:55:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8646DC000E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 02:55:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60CD840220
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 02:55:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T_K2r30XE1cI for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 02:55:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D1884015F
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 02:55:25 +0000 (UTC)
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GZw3S1PjKz1CNwc;
 Thu, 29 Jul 2021 10:49:24 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by dggeme756-chm.china.huawei.com
 (10.3.19.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 29
 Jul 2021 10:55:20 +0800
Subject: Re: [PATCH v2 00/24] iommu: Refactor DMA domain strictness
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
References: <cover.1627468308.git.robin.murphy@arm.com>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <49c7ca2c-11a3-ff93-05bc-feb482a79980@hisilicon.com>
Date: Thu, 29 Jul 2021 10:55:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <cover.1627468308.git.robin.murphy@arm.com>
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>, linux-kernel@vger.kernel.org,
 Chunyan Zhang <chunyan.zhang@unisoc.com>, dianders@chromium.org,
 iommu@lists.linux-foundation.org, Maxime Ripard <mripard@kernel.org>,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgUm9iaW4sCgoK5ZyoIDIwMjEvNy8yOCAyMzo1OCwgUm9iaW4gTXVycGh5IOWGmemBkzoKPiBI
aSBhbGwsCj4KPiBIZXJlJ3MgdjIgd2hlcmUgdGhpbmdzIHN0YXJ0IHRvIGxvb2sgbW9yZSByZWFs
aXN0aWMsIGhlbmNlIHRoZSBleHBhbmRlZAo+IENDIGxpc3QuIFRoZSBwYXRjaGVzIGFyZSBub3cg
YmFzZWQgb24gdGhlIGN1cnJlbnQgaW9tbXUvY29yZSBicmFuY2ggdG8KPiB0YWtlIEpvaG4ncyBp
b21tdV9zZXRfZG1hX3N0cmljdCgpIGNsZWFudXAgaW50byBhY2NvdW50Lgo+Cj4gVGhlIHNlcmll
cyByZW1pYWlucyBpbiB0d28gKG9yIHBvc3NpYmx5IDMpIGxvZ2ljYWwgcGFydHMgLSBmb3IgcGVv
cGxlCj4gQ0MnZCBvbiBjb29raWUgY2xlYW51cCBwYXRjaGVzLCB0aGUgbGF0ZXIgcGFydHMgc2hv
dWxkIG5vdCBhZmZlY3QgeW91Cj4gc2luY2UgeW91ciBkcml2ZXJzIGRvbid0IGltcGxlbWVudCBu
b24tc3RyaWN0IG1vZGUgYW55d2F5OyB0aGUgY2xlYW51cAo+IGlzIGFsbCBwcmV0dHkgc3RyYWln
aHRmb3J3YXJkLCBidXQgcGxlYXNlIGRvIHllbGwgYXQgbWUgaWYgSSd2ZSBtYW5hZ2VkCj4gdG8g
bGV0IGEgc2lsbHkgbWlzdGFrZSBzbGlwIHRocm91Z2ggYW5kIGJyb2tlbiB5b3VyIGRyaXZlci4K
Pgo+IFRoaXMgdGltZSBJIGhhdmUgYWxzbyBidWlsZC10ZXN0ZWQgeDg2IGFzIHdlbGwgYXMgYXJt
NjQgOikKCkkgaGF2ZSB0ZXN0ZWQgdGhvc2UgcGF0Y2hzZXQgb24gQVJNNjQgd2l0aCBTTU1VVjMs
IGFuZCB0aGUgdGVzdGNhc2VzIGFyZSAKYXMgZm9sbG93czoKLSBCb290IHdpdGggaW9tbXUuc3Ry
aWN0PTAsIHJ1bm5pbmcgZmlvIGFuZCBpdCB3b3JrcyB3ZWxsOwotIEJvb3Qgd2l0aCBpb21tdS5z
dHJpY3Q9MSwgcnVubmluZyBmaW8gYW5kIGl0IHdvcmtzIHdlbGw7Ci0gQ2hhbmdlIHN0cmljdCBt
b2RlIHRvIGxhenkgbW9kZSB3aGVuIGJ1aWxkaW5nLCB0aGUgY2hhbmdlIHRha2VzIGVmZmVjdDsK
LSBCb290IHdpdGhvdXQgaW9tbXUuc3RyaWN0KGRlZmF1bHQgc3RyaWN0IG1vZGUpLCBjaGFuZ2Ug
dGhlIHN5c2ZzIAppbnRlcmZhY2UgdHlwZSBmcm9tIERNQSB0byBETUEtRlEgZHluYW1pY2FsbHkg
ZHVyaW5nIHJ1bm5pbmcgZmlvLCBhbmQgaXQgCndvcmtzIHdlbGw7Ci0gQm9vdCB3aXRob3V0IGlv
bW11LnN0cmljdChkZWZhdWx0IHN0cmljdCBtb2RlKSwgY2hhbmdlIHRoZSBzeXNmcyAKaW50ZXJm
YWNlIHR5cGUgZnJvbSBETUEtRlEgdG8gRE1BIGR5bmFtaWNhbGx5LCBhbmQgaXQgaXMgbm90IGFs
bG93ZWQgYW5kIApwcmludCAiRGV2aWNlIG9yIHJlc291cmNlIGJ1c3kiCihpIGtub3cgaXQgaXMg
cXVhbGlmaWVkLCBhbmQgd2UgY2FuIGNoYW5nZSBuby1zdHJpY3QgbW9kZSB0byBzdHJpY3QgYnkg
CnVuYmluZCB0aGUgZHJpdmVyIC0+IGNoYW5nZSB0aGUgc3lzZnMgaW50ZXJmYWNlICh0eXBlKS0+
YmluZCB0aGUgZHJpdmVyIAoodGVzdGVkIHRoaXMgYW5kIGl0IHdvcmtzIHdlbGwpLApidXQgaSBo
YXZlIGEgc21hbGwgcXVlc3Rpb246IGlzIGl0IGFsc28gcG9zc2libGUgdG8gY2hhbmdlIGZyb20g
RE1BLUZRIAp0byBETUEgZHluYW1pY2FsbHk/ICkKCkFueXdheSwgcGxlYXNlIGZlZWwgZnJlZSB0
byBhZGQgOgpUZXN0ZWQtYnk6IFhpYW5nIENoZW4gPGNoZW54aWFuZzY2QGhpc2lsaWNvbi5jb20+
Cgo+Cj4gQ2hhbmdlcyBpbiB2MjoKPgo+IC0gQWRkIGlvbW11X2lzX2RtYV9kb21haW4oKSBoZWxw
ZXIgdG8gYWJzdHJhY3QgZmxhZyBjaGVjayAoYW5kIGhlbHAKPiAgICBhdm9pZCBzaWxseSB0eXBv
cyBsaWtlIHRoZSBvbmUgaW4gdjEpLgo+IC0gVHdlYWsgYSBmZXcgY29tbWl0IG1lc3NhZ2VzIGZv
ciBzcGVsbGluZyBhbmQgKGhvcGVmdWxseSkgY2xhcml0eS4KPiAtIE1vdmUgdGhlIGlvbW11X2Ny
ZWF0ZV9kZXZpY2VfZGlyZWN0X21hcHBpbmdzKCkgdXBkYXRlIHRvIHBhdGNoICMxNAo+ICAgIHdo
ZXJlIGl0IHNob3VsZCBoYXZlIGJlZW4uCj4gLSBSZXdyaXRlIHBhdGNoICMyMCBhcyBhIGNvbnZl
cnNpb24gb2YgdGhlIG5vdy1leGlzdGluZyBvcHRpb24uCj4gLSBDbGVhbiB1cCB0aGUgb3BzLT5m
bHVzaF9pb3RsYl9hbGwgY2hlY2sgd2hpY2ggaXMgYWxzbyBtYWRlIHJlZHVuZGFudAo+ICAgIGJ5
IHRoZSBuZXcgZG9tYWluIHR5cGUKPiAtIEFkZCBwYXRjaCAjMjQsIHdoaWNoIGlzIGFyZ3VhYmx5
IHRhbmdlbnRpYWwsIGJ1dCBpdCB3YXMgc29tZXRoaW5nIEkKPiAgICBzcG90dGVkIGR1cmluZyB0
aGUgcmViYXNlLCBzby4uLgo+Cj4gT25jZSBhZ2FpbiwgdGhlIHdob2xlIGxvdCBpcyBhdmFpbGFi
bGUgb24gYSBicmFuY2ggaGVyZToKPgo+IGh0dHBzOi8vZ2l0bGFiLmFybS5jb20vbGludXgtYXJt
L2xpbnV4LXJtLy0vdHJlZS9pb21tdS9mcQo+Cj4gVGhhbmtzLAo+IFJvYmluLgo+Cj4KPiBDQzog
TWFyZWsgU3p5cHJvd3NraSA8bS5zenlwcm93c2tpQHNhbXN1bmcuY29tPgo+IENDOiBZb3NoaWhp
cm8gU2hpbW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+Cj4gQ0M6IEdlZXJ0
IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+Cj4gQ0M6IFlvbmcgV3UgPHlv
bmcud3VAbWVkaWF0ZWsuY29tPgo+IENDOiBIZWlrbyBTdHVlYm5lciA8aGVpa29Ac250ZWNoLmRl
Pgo+IENDOiBDaHVueWFuIFpoYW5nIDxjaHVueWFuLnpoYW5nQHVuaXNvYy5jb20+Cj4gQ0M6IENo
dW55YW4gWmhhbmcgPGNodW55YW4uemhhbmdAdW5pc29jLmNvbT4KPiBDQzogTWF4aW1lIFJpcGFy
ZCA8bXJpcGFyZEBrZXJuZWwub3JnPgo+IENDOiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgPGplYW4t
cGhpbGlwcGVAbGluYXJvLm9yZz4KPgo+IFJvYmluIE11cnBoeSAoMjQpOgo+ICAgIGlvbW11OiBQ
dWxsIElPVkEgY29va2llIG1hbmFnZW1lbnQgaW50byB0aGUgY29yZQo+ICAgIGlvbW11L2FtZDog
RHJvcCBJT1ZBIGNvb2tpZSBtYW5hZ2VtZW50Cj4gICAgaW9tbXUvYXJtLXNtbXU6IERyb3AgSU9W
QSBjb29raWUgbWFuYWdlbWVudAo+ICAgIGlvbW11L3Z0LWQ6IERyb3AgSU9WQSBjb29raWUgbWFu
YWdlbWVudAo+ICAgIGlvbW11L2V4eW5vczogRHJvcCBJT1ZBIGNvb2tpZSBtYW5hZ2VtZW50Cj4g
ICAgaW9tbXUvaXBtbXUtdm1zYTogRHJvcCBJT1ZBIGNvb2tpZSBtYW5hZ2VtZW50Cj4gICAgaW9t
bXUvbXRrOiBEcm9wIElPVkEgY29va2llIG1hbmFnZW1lbnQKPiAgICBpb21tdS9yb2NrY2hpcDog
RHJvcCBJT1ZBIGNvb2tpZSBtYW5hZ2VtZW50Cj4gICAgaW9tbXUvc3ByZDogRHJvcCBJT1ZBIGNv
b2tpZSBtYW5hZ2VtZW50Cj4gICAgaW9tbXUvc3VuNTBpOiBEcm9wIElPVkEgY29va2llIG1hbmFn
ZW1lbnQKPiAgICBpb21tdS92aXJ0aW86IERyb3AgSU9WQSBjb29raWUgbWFuYWdlbWVudAo+ICAg
IGlvbW11L2RtYTogVW5leHBvcnQgSU9WQSBjb29raWUgbWFuYWdlbWVudAo+ICAgIGlvbW11L2Rt
YTogUmVtb3ZlIHJlZHVuZGFudCAiIWRldiIgY2hlY2tzCj4gICAgaW9tbXU6IEludHJvZHVjZSBl
eHBsaWNpdCB0eXBlIGZvciBub24tc3RyaWN0IERNQSBkb21haW5zCj4gICAgaW9tbXUvYW1kOiBQ
cmVwYXJlIGZvciBtdWx0aXBsZSBETUEgZG9tYWluIHR5cGVzCj4gICAgaW9tbXUvYXJtLXNtbXU6
IFByZXBhcmUgZm9yIG11bHRpcGxlIERNQSBkb21haW4gdHlwZXMKPiAgICBpb21tdS92dC1kOiBQ
cmVwYXJlIGZvciBtdWx0aXBsZSBETUEgZG9tYWluIHR5cGVzCj4gICAgaW9tbXU6IEV4cHJlc3Mg
RE1BIHN0cmljdG5lc3MgdmlhIHRoZSBkb21haW4gdHlwZQo+ICAgIGlvbW11OiBFeHBvc2UgRE1B
IGRvbWFpbiBzdHJpY3RuZXNzIHZpYSBzeXNmcwo+ICAgIGlvbW11OiBNZXJnZSBzdHJpY3RuZXNz
IGFuZCBkb21haW4gdHlwZSBjb25maWdzCj4gICAgaW9tbXUvZG1hOiBGYWN0b3Igb3V0IGZsdXNo
IHF1ZXVlIGluaXQKPiAgICBpb21tdTogQWxsb3cgZW5hYmxpbmcgbm9uLXN0cmljdCBtb2RlIGR5
bmFtaWNhbGx5Cj4gICAgaW9tbXUvYXJtLXNtbXU6IEFsbG93IG5vbi1zdHJpY3QgaW4gcGd0YWJs
ZV9xdWlya3MgaW50ZXJmYWNlCj4gICAgaW9tbXU6IE9ubHkgbG9nIHN0cmljdG5lc3MgZm9yIERN
QSBkb21haW5zCj4KPiAgIC4uLi9BQkkvdGVzdGluZy9zeXNmcy1rZXJuZWwtaW9tbXVfZ3JvdXBz
ICAgICB8ICAyICsKPiAgIGRyaXZlcnMvaW9tbXUvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAg
ICAgICB8IDgwICsrKysrKysrKy0tLS0tLS0tLS0KPiAgIGRyaXZlcnMvaW9tbXUvYW1kL2lvbW11
LmMgICAgICAgICAgICAgICAgICAgICB8IDIxICstLS0tCj4gICBkcml2ZXJzL2lvbW11L2FybS9h
cm0tc21tdS12My9hcm0tc21tdS12My5jICAgfCAyNSArKysrLS0KPiAgIGRyaXZlcnMvaW9tbXUv
YXJtL2FybS1zbW11L2FybS1zbW11LmMgICAgICAgICB8IDI5ICsrKystLS0KPiAgIGRyaXZlcnMv
aW9tbXUvYXJtL2FybS1zbW11L3Fjb21faW9tbXUuYyAgICAgICB8ICA4IC0tCj4gICBkcml2ZXJz
L2lvbW11L2RtYS1pb21tdS5jICAgICAgICAgICAgICAgICAgICAgfCA0NCArKysrKy0tLS0tCj4g
ICBkcml2ZXJzL2lvbW11L2V4eW5vcy1pb21tdS5jICAgICAgICAgICAgICAgICAgfCAxOCArLS0t
LQo+ICAgZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jICAgICAgICAgICAgICAgICAgIHwgMjMg
KystLS0tCj4gICBkcml2ZXJzL2lvbW11L2lvbW11LmMgICAgICAgICAgICAgICAgICAgICAgICAg
fCA1MyArKysrKysrLS0tLS0KPiAgIGRyaXZlcnMvaW9tbXUvaXBtbXUtdm1zYS5jICAgICAgICAg
ICAgICAgICAgICB8IDI3ICstLS0tLS0KPiAgIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgICAg
ICAgICAgICAgICAgICAgICB8ICA2IC0tCj4gICBkcml2ZXJzL2lvbW11L3JvY2tjaGlwLWlvbW11
LmMgICAgICAgICAgICAgICAgfCAxMSArLS0KPiAgIGRyaXZlcnMvaW9tbXUvc3ByZC1pb21tdS5j
ICAgICAgICAgICAgICAgICAgICB8ICA2IC0tCj4gICBkcml2ZXJzL2lvbW11L3N1bjUwaS1pb21t
dS5jICAgICAgICAgICAgICAgICAgfCAxMiArLS0KPiAgIGRyaXZlcnMvaW9tbXUvdmlydGlvLWlv
bW11LmMgICAgICAgICAgICAgICAgICB8ICA4IC0tCj4gICBpbmNsdWRlL2xpbnV4L2RtYS1pb21t
dS5oICAgICAgICAgICAgICAgICAgICAgfCAgOSArKy0KPiAgIGluY2x1ZGUvbGludXgvaW9tbXUu
aCAgICAgICAgICAgICAgICAgICAgICAgICB8IDE1ICsrKy0KPiAgIDE4IGZpbGVzIGNoYW5nZWQs
IDE3MSBpbnNlcnRpb25zKCspLCAyMjYgZGVsZXRpb25zKC0pCj4KCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
