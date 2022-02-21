Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161F0C4332F
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 16:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BADAF817E4;
	Mon, 21 Feb 2022 16:58:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HGGGnoxNeHfD; Mon, 21 Feb 2022 16:58:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 77DCA81418;
	Mon, 21 Feb 2022 16:58:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BE90C0021;
	Mon, 21 Feb 2022 16:58:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CD96C0011
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 16:58:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1284A4036A
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 16:58:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id igesyi5w3ZZx for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 16:58:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id B751A40186
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 16:58:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D5461042;
 Mon, 21 Feb 2022 08:58:12 -0800 (PST)
Received: from [10.57.40.147] (unknown [10.57.40.147])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB2533F70D;
 Mon, 21 Feb 2022 08:58:09 -0800 (PST)
Message-ID: <56cf458b-080b-2e22-69d7-039ff7d0b56a@arm.com>
Date: Mon, 21 Feb 2022 16:58:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 1/9] dt-bindings: host1x: Add memory-contexts property
Content-Language: en-GB
To: Mikko Perttunen <cyndis@kapsi.fi>, Mikko Perttunen
 <mperttunen@nvidia.com>, thierry.reding@gmail.com, jonathanh@nvidia.com,
 joro@8bytes.org, will@kernel.org, robh+dt@kernel.org
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-2-mperttunen@nvidia.com>
 <48ac567b-37e8-1fa2-c389-536e276fdd2c@arm.com>
 <2e9c4ea5-6bbd-9724-0f4e-ed25f7294aa2@kapsi.fi>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <2e9c4ea5-6bbd-9724-0f4e-ed25f7294aa2@kapsi.fi>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

T24gMjAyMi0wMi0yMSAxNToyOCwgTWlra28gUGVydHR1bmVuIHdyb3RlOgo+IE9uIDIvMjEvMjIg
MTc6MjMsIFJvYmluIE11cnBoeSB3cm90ZToKPj4gT24gMjAyMi0wMi0xOCAxMTozOSwgTWlra28g
UGVydHR1bmVuIHZpYSBpb21tdSB3cm90ZToKPj4+IEFkZCBzY2hlbWEgaW5mb3JtYXRpb24gZm9y
IHRoZSBtZW1vcnktY29udGV4dHMgcHJvcGVydHkgdXNlZCB0bwo+Pj4gc3BlY2lmeSBjb250ZXh0
IHN0cmVhbSBJRHMuIFRoaXMgdXNlcyB0aGUgc3RhbmRhcmQgaW9tbXUtbWFwIHByb3BlcnR5Cj4+
PiBpbnNpZGUgYSBjaGlsZCBub2RlLgo+Pgo+PiBDb3VsZG4ndCB5b3Ugc2ltcGx5IG1ha2UgImlv
bW11LW1hcCIgYW4gYWxsb3dlZCBwcm9wZXJ0eSBvbiB0aGUgaG9zdDF4IAo+PiBub2RlIGl0c2Vs
Zj8gRnJvbSBhIERUIHBlcnNwZWN0aXZlIEknbSBub3Qgc3VyZSB0aGUgaW50ZXJtZWRpYXRlIG5v
ZGUgCj4+IHJlYWxseSBmaXRzIG1lYW5pbmdmdWxseSwgYW5kIEkgY2FuJ3Qgc2VlIHRoYXQgaXQg
c2VydmVzIG11Y2ggcHVycG9zZSAKPj4gaW4gcHJhY3RpY2UgZWl0aGVyLCBvdGhlciB0aGFuIHBl
cmhhcHMgZGVmZWF0aW5nIGZ3X2RldmxpbmsuCj4+Cj4+IFJvYmluLgo+IAo+IFRoZSBzdHJlYW0g
SURzIGRlc2NyaWJlZCBoZXJlIGFyZSBub3QgdXNlZCBieSB0aGUgaG9zdDF4IGRldmljZSBpdHNl
bGYsIAo+IHNvIEkgZG9uJ3QgdGhpbmsgSSBjYW4uIEhvc3QxeCdzIG1lbW9yeSB0cmFuc2FjdGlv
bnMgc3RpbGwgZ28gdGhyb3VnaCAKPiB0aGUgc3RyZWFtIElEIHNwZWNpZmllZCBpbiBpdHMgJ2lv
bW11cycgcHJvcGVydHksIHRoZXNlIHN0cmVhbSBJRHMgYXJlIAo+IHVzZWQgYnkgZW5naW5lcyAo
dHlwaWNhbGx5IGluIGFkZGl0aW9uIHRvIHRoZSBzdHJlYW0gSUQgc3BlY2lmaWVkIGluIAo+IHRo
ZWlyIG93biBub2RlcykuCj4gCj4gSG9zdDF4ICdpb21tdXMnIC0tIENoYW5uZWwgY29tbWFuZHMK
PiBFbmdpbmUgJ2lvbW11cycgLS0gRW5naW5lIGZpcm13YXJlIChhbmQgZGF0YSBpZiBjb250ZXh0
IGlzb2xhdGlvbiBpcyBub3QgCj4gZW5hYmxlZCkKPiBtZW1vcnktY29udGV4dHMgJ2lvbW11LW1h
cCcgLS0gRGF0YSB1c2VkIGJ5IGVuZ2luZXMuCgpSaWdodCwgdGhhdCBzdGlsbCBhcHBlYXJzIHRv
IG1hdGNoIG15IHVuZGVyc3RhbmRpbmcsIHRoYXQgYXMgZmFyIGFzIApzb2Z0d2FyZSBzZWVzLCB0
aGUgaG9zdDF4IGlzIGVmZmVjdGl2ZWx5IGFjdGluZyBhcyBhIGJyaWRnZSB0byB0aGUgCmVuZ2lu
ZXMgaW4gaXRzZWxmLiBFdmVuIGlmIGl0J3Mgbm90IHBoeXNpY2FsbHkgcm91dGluZyB0cmFmZmlj
IGluIGFuZC9vciAKb3V0LCB0aGUgaG9zdDF4IGRldmljZSBpcyB0aGUgcGxhY2Ugd2hlcmUgdGhl
IGNvbnRleHQgSURzICpsb2dpY2FsbHkqIApleGlzdCwgYW5kIHRodXMgb3ducyB0aGUgbWFwcGlu
ZyBiZXR3ZWVuIGNvbnRleHQgSURzIGFuZCB0aGUgU3RyZWFtSURzIAplbWl0dGVkIGJ5IGFueSBl
bmdpbmUgd29ya2luZyBpbiBhIGdpdmVuIGNvbnRleHQuCgpDb25zaWRlciBhIFBDSWUgcm9vdCBj
b21wbGV4IHdpdGggaW50ZWdyYXRlZCBlbmRwb2ludHMgLSBjaGFuY2VzIGFyZSB0aGUgClJDaUVQ
cyBoYXZlIHRoZWlyIG93biBwaHlzaWNhbCBpbnRlcmZhY2VzIHRvIGlzc3VlIERNQSBkaXJlY3Rs
eSBpbnRvIHRoZSAKU29DIGludGVyY29ubmVjdCwgYnV0IHRoYXQgZG9lc24ndCBjaGFuZ2UgaG93
IHdlIGRlc2NyaWJlIHRoZSBQQ0kgClJlcXVlc3RlciBJRCB0byBTdHJlYW1JRCBtYXBwaW5nIGF0
IHRoZSByb290IGNvbXBsZXgsIHNpbmNlIHRoZSBSQyBzdGlsbCAKbG9naWNhbGx5IG93bnMgdGhl
IFJJRCBzcGFjZS4gWW91IGNhbiB0aGluayBvZiBhIFJJRCBhcyBiZWluZyAiY29uc3VtZWQiIAph
dCB0aGUgUkMgYnkgaW5kZXhpbmcgaW50byBjb25maWcgc3BhY2UgdG8gdWx0aW1hdGVseSBnYWlu
IGNvbnRyb2wgb2YgCnRoZSBjb3JyZXNwb25kaW5nIGVuZHBvaW50LCBqdXN0IGxpa2UgY29udGV4
dCBJRHMgYXJlICJjb25zdW1lZCIgYXQgdGhlIAogIGhvc3QxeCBieSBnZW5lcmF0aW5nIGNvbW1h
bmRzIHRvIHVsdGltYXRlbHkgY2F1c2Ugc29tZSBlbmdpbmUgdG8gCm9wZXJhdGUgaW4gdGhlIGNv
cnJlY3QgYWRkcmVzcyBzcGFjZS4KCllvdSBkb24ndCBoYXZlIHRvIHByZXRlbmQgdGhlIGhvc3Qx
eCB1c2VzIGEgY29udGV4dCBmb3IgaXRzIG93biAKY29tbWFuZC1mZXRjaGluZyAob3Igd2hhdGV2
ZXIpIHRyYWZmaWMgZWl0aGVyIC0gaXQncyBhbHdheXMgYmVlbiAKaW50ZW5kZWQgdGhhdCB0aGUg
ImlvbW11cyIgYW5kICJpb21tdS1tYXAiIHByb3BlcnRpZXMgc2hvdWxkIGhhcHBpbHkgYmUgCmFi
bGUgdG8gY29leGlzdCBvbiB0aGUgc2FtZSBub2RlLCBzaW5jZSB0aGV5IHNlcnZlIGRpc3RpbmN0
bHkgZGlmZmVyZW50IApwdXJwb3Nlcy4gSWYgaXQgZG9lc24ndCB3b3JrIGluIHByYWN0aWNlIHRo
ZW4gd2UndmUgZ290IGEgYnVnIHRvIGZpeCAKc29tZXdoZXJlLgoKSWYgdGhlIGNvbnRleHQtc3dp
dGNoaW5nIG1lY2hhbmlzbSB3YXMgc29tZSBkaXN0aW5jdCBzZWxmLWNvbnRhaW5lZCAKdGhpbmcg
Ym9sdGVkIG9uIGJlc2lkZSB0aGUgb3RoZXIgaG9zdDF4IGZ1bmN0aW9uYWxpdHkgdGhlbiBkZXNj
cmliaW5nIGl0IAphcyBhIHNlcGFyYXRlIGxldmVsIG9mIERUIGhpZXJhcmNoeSBtaWdodCBiZSBt
b3JlIGp1c3RpZmlhYmxlLCBidXQgCnRoYXQncyBub3QgdGhlIGltcHJlc3Npb24gSSdtIGdldHRp
bmcgZnJvbSBza2ltbWluZyB0aGUgcmVzdCBvZiB0aGUgCnNlcmllcy4gSnVzdCByZWFkaW5nIG9m
IHRoZSBuYW1lcyBvZiB0aGluZ3MgaW4gcGF0Y2ggIzYsIG15IGludHVpdGl2ZSAKcmVhY3Rpb24g
aXMgdGhhdCBjbGVhcmx5IGVhY2ggaG9zdDF4IG93bnMgOSBTdHJlYW1JRHMsIG9uZSBmb3IgZ2Vu
ZXJhbCAKc3R1ZmYgYW5kIDggZm9yIGNvbnRleHRzLiBBZGRpbmcgdGhlIGtub3dsZWRnZSB0aGF0
IHRlY2huaWNhbGx5IHRoZSAKY29udGV4dCBTdHJlYW1JRHMgZW5kIHVwIGRlbGVnYXRlZCB0byBv
dGhlciBob3N0MXgtY29udHJvbGxlZCBlbmdpbmVzIApzdGlsbCBkb2Vzbid0IHNoaWZ0IHRoZSBw
YXJhZGlnbS4gSSBkb24ndCBiZWxpZXZlIHdlIG5lZWQgYSBsZXZlbCBvZiBEVCAKc3RydWN0dXJl
IHB1cmVseSB0byBoZWxwIGRvY3VtZW50IHdoYXQgdGhlIGlvbW11LW1hcCBtZWFucyBmb3IgaG9z
dDF4IC0gCnRoZSBiaW5kaW5nIGNhbiBkbyB0aGF0IGp1c3QgZmluZS4KClRoYW5rcywKUm9iaW4u
Cgo+IChQZXJoYXBzIEkgc2hvdWxkIGFkZCB0aGlzIGluZm9ybWF0aW9uIHRvIHZhcmlvdXMgcGxh
Y2VzIGluIG1vcmUgCj4gYWJ1bmRhbmNlIGFuZCBjbGFyaXR5LikKPiAKPiBNaWtrbwo+IAo+Pgo+
Pj4gU2lnbmVkLW9mZi1ieTogTWlra28gUGVydHR1bmVuIDxtcGVydHR1bmVuQG52aWRpYS5jb20+
Cj4+PiAtLS0KPj4+IHYzOgo+Pj4gKiBOZXcgcGF0Y2gKPj4+IC0tLQo+Pj4gwqAgLi4uL2JpbmRp
bmdzL2Rpc3BsYXkvdGVncmEvbnZpZGlhLHRlZ3JhMjAtaG9zdDF4LnlhbWzCoCB8IDEwICsrKysr
KysrKysKPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlm
ZiAtLWdpdCAKPj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkv
dGVncmEvbnZpZGlhLHRlZ3JhMjAtaG9zdDF4LnlhbWwgCj4+PiBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3RlZ3JhL252aWRpYSx0ZWdyYTIwLWhvc3QxeC55YW1s
IAo+Pj4KPj4+IGluZGV4IDRmZDUxM2VmYjBmNy4uM2FjMGZkZTU0YTE2IDEwMDY0NAo+Pj4gLS0t
IAo+Pj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS90ZWdyYS9u
dmlkaWEsdGVncmEyMC1ob3N0MXgueWFtbCAKPj4+Cj4+PiArKysgCj4+PiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3RlZ3JhL252aWRpYSx0ZWdyYTIwLWhvc3Qx
eC55YW1sIAo+Pj4KPj4+IEBAIC0xNDQsNiArMTQ0LDE2IEBAIGFsbE9mOgo+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgIHJlc2V0LW5hbWVzOgo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtYXhJdGVt
czogMQo+Pj4gK8KgwqDCoMKgwqDCoMKgIG1lbW9yeS1jb250ZXh0czoKPj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqAgdHlwZTogb2JqZWN0Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgIHByb3BlcnRpZXM6
Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpb21tdS1tYXA6Cj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZGVzY3JpcHRpb246IFNwZWNpZmljYXRpb24gb2Ygc3RyZWFtIElEcyBh
dmFpbGFibGUgZm9yIAo+Pj4gbWVtb3J5IGNvbnRleHQgZGV2aWNlCj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHVzZS4gU2hvdWxkIGJlIGEgbWFwcGluZyBvZiBJRHMgMC4ubiB0
byBJT01NVSAKPj4+IGVudHJpZXMgY29ycmVzcG9uZGluZyB0bwo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB1c2FibGUgc3RyZWFtIElEcy4KPj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqAgcmVxdWlyZWQ6Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGlvbW11LW1hcAo+Pj4g
Kwo+Pj4gwqDCoMKgwqDCoMKgwqAgcmVxdWlyZWQ6Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLSBy
ZWctbmFtZXMKPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
