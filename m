Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E23FC432BE
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 01:21:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9210D60F4B
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 01:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9210D60F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47E9060A53;
	Fri, 30 Jul 2021 01:21:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uQ_nh0gIcKXS; Fri, 30 Jul 2021 01:21:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DAD8E606CF;
	Fri, 30 Jul 2021 01:21:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA72CC0010;
	Fri, 30 Jul 2021 01:21:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 527E8C000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 01:21:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3976483ABD
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 01:21:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DAmm-2d1XXog for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 01:21:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A9A883ABC
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 01:21:24 +0000 (UTC)
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GbTz14l6hz7x3G;
 Fri, 30 Jul 2021 09:17:33 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by dggeme756-chm.china.huawei.com
 (10.3.19.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 30
 Jul 2021 09:21:19 +0800
Subject: Re: [PATCH v2 00/24] iommu: Refactor DMA domain strictness
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
References: <cover.1627468308.git.robin.murphy@arm.com>
 <49c7ca2c-11a3-ff93-05bc-feb482a79980@hisilicon.com>
 <942c3da1-fb79-967a-d50e-4cbf5331261c@arm.com>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <08de8f83-addc-8547-eca1-912323402e2f@hisilicon.com>
Date: Fri, 30 Jul 2021 09:21:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <942c3da1-fb79-967a-d50e-4cbf5331261c@arm.com>
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

CgrlnKggMjAyMS83LzI5IDE4OjU5LCBSb2JpbiBNdXJwaHkg5YaZ6YGTOgo+IE9uIDIwMjEtMDct
MjkgMDM6NTUsIGNoZW54aWFuZyAoTSkgd3JvdGU6Cj4+IEhpIFJvYmluLAo+Pgo+Pgo+PiDlnKgg
MjAyMS83LzI4IDIzOjU4LCBSb2JpbiBNdXJwaHkg5YaZ6YGTOgo+Pj4gSGkgYWxsLAo+Pj4KPj4+
IEhlcmUncyB2MiB3aGVyZSB0aGluZ3Mgc3RhcnQgdG8gbG9vayBtb3JlIHJlYWxpc3RpYywgaGVu
Y2UgdGhlIGV4cGFuZGVkCj4+PiBDQyBsaXN0LiBUaGUgcGF0Y2hlcyBhcmUgbm93IGJhc2VkIG9u
IHRoZSBjdXJyZW50IGlvbW11L2NvcmUgYnJhbmNoIHRvCj4+PiB0YWtlIEpvaG4ncyBpb21tdV9z
ZXRfZG1hX3N0cmljdCgpIGNsZWFudXAgaW50byBhY2NvdW50Lgo+Pj4KPj4+IFRoZSBzZXJpZXMg
cmVtaWFpbnMgaW4gdHdvIChvciBwb3NzaWJseSAzKSBsb2dpY2FsIHBhcnRzIC0gZm9yIHBlb3Bs
ZQo+Pj4gQ0MnZCBvbiBjb29raWUgY2xlYW51cCBwYXRjaGVzLCB0aGUgbGF0ZXIgcGFydHMgc2hv
dWxkIG5vdCBhZmZlY3QgeW91Cj4+PiBzaW5jZSB5b3VyIGRyaXZlcnMgZG9uJ3QgaW1wbGVtZW50
IG5vbi1zdHJpY3QgbW9kZSBhbnl3YXk7IHRoZSBjbGVhbnVwCj4+PiBpcyBhbGwgcHJldHR5IHN0
cmFpZ2h0Zm9yd2FyZCwgYnV0IHBsZWFzZSBkbyB5ZWxsIGF0IG1lIGlmIEkndmUgbWFuYWdlZAo+
Pj4gdG8gbGV0IGEgc2lsbHkgbWlzdGFrZSBzbGlwIHRocm91Z2ggYW5kIGJyb2tlbiB5b3VyIGRy
aXZlci4KPj4+Cj4+PiBUaGlzIHRpbWUgSSBoYXZlIGFsc28gYnVpbGQtdGVzdGVkIHg4NiBhcyB3
ZWxsIGFzIGFybTY0IDopCj4+Cj4+IEkgaGF2ZSB0ZXN0ZWQgdGhvc2UgcGF0Y2hzZXQgb24gQVJN
NjQgd2l0aCBTTU1VVjMsIGFuZCB0aGUgdGVzdGNhc2VzIAo+PiBhcmUgYXMgZm9sbG93czoKPj4g
LSBCb290IHdpdGggaW9tbXUuc3RyaWN0PTAsIHJ1bm5pbmcgZmlvIGFuZCBpdCB3b3JrcyB3ZWxs
Owo+PiAtIEJvb3Qgd2l0aCBpb21tdS5zdHJpY3Q9MSwgcnVubmluZyBmaW8gYW5kIGl0IHdvcmtz
IHdlbGw7Cj4+IC0gQ2hhbmdlIHN0cmljdCBtb2RlIHRvIGxhenkgbW9kZSB3aGVuIGJ1aWxkaW5n
LCB0aGUgY2hhbmdlIHRha2VzIAo+PiBlZmZlY3Q7Cj4+IC0gQm9vdCB3aXRob3V0IGlvbW11LnN0
cmljdChkZWZhdWx0IHN0cmljdCBtb2RlKSwgY2hhbmdlIHRoZSBzeXNmcyAKPj4gaW50ZXJmYWNl
IHR5cGUgZnJvbSBETUEgdG8gRE1BLUZRIGR5bmFtaWNhbGx5IGR1cmluZyBydW5uaW5nIGZpbywg
YW5kIAo+PiBpdCB3b3JrcyB3ZWxsOwo+PiAtIEJvb3Qgd2l0aG91dCBpb21tdS5zdHJpY3QoZGVm
YXVsdCBzdHJpY3QgbW9kZSksIGNoYW5nZSB0aGUgc3lzZnMgCj4+IGludGVyZmFjZSB0eXBlIGZy
b20gRE1BLUZRIHRvIERNQSBkeW5hbWljYWxseSwgYW5kIGl0IGlzIG5vdCBhbGxvd2VkIAo+PiBh
bmQgcHJpbnQgIkRldmljZSBvciByZXNvdXJjZSBidXN5Igo+PiAoaSBrbm93IGl0IGlzIHF1YWxp
ZmllZCwgYW5kIHdlIGNhbiBjaGFuZ2Ugbm8tc3RyaWN0IG1vZGUgdG8gc3RyaWN0IAo+PiBieSB1
bmJpbmQgdGhlIGRyaXZlciAtPiBjaGFuZ2UgdGhlIHN5c2ZzIGludGVyZmFjZSAodHlwZSktPmJp
bmQgdGhlIAo+PiBkcml2ZXIgKHRlc3RlZCB0aGlzIGFuZCBpdCB3b3JrcyB3ZWxsKSwKPj4gYnV0
IGkgaGF2ZSBhIHNtYWxsIHF1ZXN0aW9uOiBpcyBpdCBhbHNvIHBvc3NpYmxlIHRvIGNoYW5nZSBm
cm9tIAo+PiBETUEtRlEgdG8gRE1BIGR5bmFtaWNhbGx5PyApCj4KPiBBcyBwYXRjaCAjMjIgbWVu
dGlvbnMsIEkgdGhpbmsgaXQncyBwb3NzaWJsZSBpbiBwcmluY2lwbGUsIGJ1dCBpdCdzIAo+IGNl
cnRhaW5seSB0cmlja2llci4gV2hlbiBlbmFibGluZyBhIGZsdXNoIHF1ZXVlLCBpdCBkb2Vzbid0
IG1hdHRlciBpZiAKPiBpdCB0YWtlcyBhIHdoaWxlIGZvciBvdGhlciB0aHJlYWRzIHRvIG5vdGlj
ZSB0aGF0IGNvb2tpZS0+ZnFfZG9tYWluIGlzIAo+IG5vdyBzZXQgYW5kIHN0b3AgZG9pbmcgc3lu
Y2hyb25vdXMgaW52YWxpZGF0aW9ucyAoYW5kIGluIHRoZSBTTU1VIGNhc2UgCj4gaXQgc2VlbXMg
bGlrZSB0aGVyZSBhcmUgcHJvYmFibHkgZW5vdWdoIGRlcGVuZGVuY2llcyB0byBhZGRpdGlvbmFs
bHkgCj4gcHJldmVudCB0aGUgaW9fcGd0YWJsZSBxdWlyayBiZWluZyBvYnNlcnZhYmxlIGJlZm9y
ZSB0aGF0KS4gSG93ZXZlciAKPiB3aGVuIGRpc2FibGluZywgd2UnZCBuZWVkIHRvIGJlIGFic29s
dXRlbHkgc3VyZSB0aGF0IHRoZSBkcml2ZXIgKmhhcyogCj4gc3RhcnRlZCBpbnZhbGlkYXRpbmcg
c3RyaWN0bHkgYmVmb3JlIHdlIHN0b3AgcXVldWVpbmcgZnJlZWQgSU9WQXMsIAo+IHBsdXMgd2Ug
bmVlZCB0byBiZSBhYnNvbHV0ZWx5IHN1cmUgdGhhdCB3ZSd2ZSBzdG9wcGVkIHF1ZXVlaW5nIGZy
ZWVkIAo+IElPVkFzIGJlZm9yZSB3ZSBhdHRlbXB0IHRvIHRlYXIgZG93biB0aGUgZmx1c2ggcXVl
dWUgaXRzZWxmLiBJJ20gbm90IAo+IHN1cmUgb2ZmLWhhbmQgaG93IGZlYXNpYmxlIGl0IHdvdWxk
IGJlIHRvIHB1dCBhbGwgdGhhdCBzeW5jaHJvbmlzYXRpb24gCj4gaW4gdGhlIHJpZ2h0IHBsYWNl
cyB3aXRob3V0IGl0IGFsc28gaW1wYWN0aW5nIG5vcm1hbCBvcGVyYXRpb24uCj4KPiBGdXJ0aGVy
bW9yZSwgYXMgYWxzbyBub3RlZCwgdGhlcmUgZG9lc24ndCBzZWVtIHRvIGJlIGEgZ29vZCByZWFz
b24gZm9yIAo+IGV2ZXIgYWN0dWFsbHkgbmVlZGluZyB0byBkbyB0aGF0LiBJZiBhIGRldmljZSBp
c24ndCB0cnVzdGVkLCBpdCBzaG91bGQgCj4gYmUgZ2l2ZW4gYSBzdHJpY3QgZG9tYWluICpiZWZv
cmUqIGFueSBkcml2ZXIgaGFzIGEgY2hhbmNlIHRvIHN0YXJ0IAo+IGRvaW5nIGFueXRoaW5nLCBv
ciB5b3VyIHRydXN0IG1vZGVsIGlzIGJyb2tlbiBhbmQgcHJldHR5IHVzZWxlc3MuIEkgCj4gY2Fu
IGltYWdpbmUgc29tZSBuaWNoZSBkZWJ1Z2dpbmcvYmVuY2htYXJraW5nIGNhc2VzIHdoZXJlIGl0
IG1pZ2h0IAo+IGhlbHAgc2F2ZSBhIGJpdCBvZiBlZmZvcnQsIGJ1dCBub3RoaW5nIHdpdGggYSBz
dHJvbmcgZW5vdWdoIAo+IGp1c3RpZmljYXRpb24gdG8gYmUgd29ydGggc3VwcG9ydGluZyBpbiBt
YWlubGluZS4KCk9rLCB0aGFua3MuCgo+Cj4+IEFueXdheSwgcGxlYXNlIGZlZWwgZnJlZSB0byBh
ZGQgOgo+PiBUZXN0ZWQtYnk6IFhpYW5nIENoZW4gPGNoZW54aWFuZzY2QGhpc2lsaWNvbi5jb20+
Cj4KPiBUaGF0J3MgZ3JlYXQsIHRoYW5rcyEKPgo+IFJvYmluLgo+Cj4+PiBDaGFuZ2VzIGluIHYy
Ogo+Pj4KPj4+IC0gQWRkIGlvbW11X2lzX2RtYV9kb21haW4oKSBoZWxwZXIgdG8gYWJzdHJhY3Qg
ZmxhZyBjaGVjayAoYW5kIGhlbHAKPj4+ICAgIGF2b2lkIHNpbGx5IHR5cG9zIGxpa2UgdGhlIG9u
ZSBpbiB2MSkuCj4+PiAtIFR3ZWFrIGEgZmV3IGNvbW1pdCBtZXNzYWdlcyBmb3Igc3BlbGxpbmcg
YW5kIChob3BlZnVsbHkpIGNsYXJpdHkuCj4+PiAtIE1vdmUgdGhlIGlvbW11X2NyZWF0ZV9kZXZp
Y2VfZGlyZWN0X21hcHBpbmdzKCkgdXBkYXRlIHRvIHBhdGNoICMxNAo+Pj4gICAgd2hlcmUgaXQg
c2hvdWxkIGhhdmUgYmVlbi4KPj4+IC0gUmV3cml0ZSBwYXRjaCAjMjAgYXMgYSBjb252ZXJzaW9u
IG9mIHRoZSBub3ctZXhpc3Rpbmcgb3B0aW9uLgo+Pj4gLSBDbGVhbiB1cCB0aGUgb3BzLT5mbHVz
aF9pb3RsYl9hbGwgY2hlY2sgd2hpY2ggaXMgYWxzbyBtYWRlIHJlZHVuZGFudAo+Pj4gICAgYnkg
dGhlIG5ldyBkb21haW4gdHlwZQo+Pj4gLSBBZGQgcGF0Y2ggIzI0LCB3aGljaCBpcyBhcmd1YWJs
eSB0YW5nZW50aWFsLCBidXQgaXQgd2FzIHNvbWV0aGluZyBJCj4+PiAgICBzcG90dGVkIGR1cmlu
ZyB0aGUgcmViYXNlLCBzby4uLgo+Pj4KPj4+IE9uY2UgYWdhaW4sIHRoZSB3aG9sZSBsb3QgaXMg
YXZhaWxhYmxlIG9uIGEgYnJhbmNoIGhlcmU6Cj4+Pgo+Pj4gaHR0cHM6Ly9naXRsYWIuYXJtLmNv
bS9saW51eC1hcm0vbGludXgtcm0vLS90cmVlL2lvbW11L2ZxCj4+Pgo+Pj4gVGhhbmtzLAo+Pj4g
Um9iaW4uCj4+Pgo+Pj4KPj4+IENDOiBNYXJlayBTenlwcm93c2tpIDxtLnN6eXByb3dza2lAc2Ft
c3VuZy5jb20+Cj4+PiBDQzogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGlyby5zaGltb2RhLnVo
QHJlbmVzYXMuY29tPgo+Pj4gQ0M6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0Bn
bGlkZXIuYmU+Cj4+PiBDQzogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+Cj4+PiBDQzog
SGVpa28gU3R1ZWJuZXIgPGhlaWtvQHNudGVjaC5kZT4KPj4+IENDOiBDaHVueWFuIFpoYW5nIDxj
aHVueWFuLnpoYW5nQHVuaXNvYy5jb20+Cj4+PiBDQzogQ2h1bnlhbiBaaGFuZyA8Y2h1bnlhbi56
aGFuZ0B1bmlzb2MuY29tPgo+Pj4gQ0M6IE1heGltZSBSaXBhcmQgPG1yaXBhcmRAa2VybmVsLm9y
Zz4KPj4+IENDOiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgPGplYW4tcGhpbGlwcGVAbGluYXJvLm9y
Zz4KPj4+Cj4+PiBSb2JpbiBNdXJwaHkgKDI0KToKPj4+ICAgIGlvbW11OiBQdWxsIElPVkEgY29v
a2llIG1hbmFnZW1lbnQgaW50byB0aGUgY29yZQo+Pj4gICAgaW9tbXUvYW1kOiBEcm9wIElPVkEg
Y29va2llIG1hbmFnZW1lbnQKPj4+ICAgIGlvbW11L2FybS1zbW11OiBEcm9wIElPVkEgY29va2ll
IG1hbmFnZW1lbnQKPj4+ICAgIGlvbW11L3Z0LWQ6IERyb3AgSU9WQSBjb29raWUgbWFuYWdlbWVu
dAo+Pj4gICAgaW9tbXUvZXh5bm9zOiBEcm9wIElPVkEgY29va2llIG1hbmFnZW1lbnQKPj4+ICAg
IGlvbW11L2lwbW11LXZtc2E6IERyb3AgSU9WQSBjb29raWUgbWFuYWdlbWVudAo+Pj4gICAgaW9t
bXUvbXRrOiBEcm9wIElPVkEgY29va2llIG1hbmFnZW1lbnQKPj4+ICAgIGlvbW11L3JvY2tjaGlw
OiBEcm9wIElPVkEgY29va2llIG1hbmFnZW1lbnQKPj4+ICAgIGlvbW11L3NwcmQ6IERyb3AgSU9W
QSBjb29raWUgbWFuYWdlbWVudAo+Pj4gICAgaW9tbXUvc3VuNTBpOiBEcm9wIElPVkEgY29va2ll
IG1hbmFnZW1lbnQKPj4+ICAgIGlvbW11L3ZpcnRpbzogRHJvcCBJT1ZBIGNvb2tpZSBtYW5hZ2Vt
ZW50Cj4+PiAgICBpb21tdS9kbWE6IFVuZXhwb3J0IElPVkEgY29va2llIG1hbmFnZW1lbnQKPj4+
ICAgIGlvbW11L2RtYTogUmVtb3ZlIHJlZHVuZGFudCAiIWRldiIgY2hlY2tzCj4+PiAgICBpb21t
dTogSW50cm9kdWNlIGV4cGxpY2l0IHR5cGUgZm9yIG5vbi1zdHJpY3QgRE1BIGRvbWFpbnMKPj4+
ICAgIGlvbW11L2FtZDogUHJlcGFyZSBmb3IgbXVsdGlwbGUgRE1BIGRvbWFpbiB0eXBlcwo+Pj4g
ICAgaW9tbXUvYXJtLXNtbXU6IFByZXBhcmUgZm9yIG11bHRpcGxlIERNQSBkb21haW4gdHlwZXMK
Pj4+ICAgIGlvbW11L3Z0LWQ6IFByZXBhcmUgZm9yIG11bHRpcGxlIERNQSBkb21haW4gdHlwZXMK
Pj4+ICAgIGlvbW11OiBFeHByZXNzIERNQSBzdHJpY3RuZXNzIHZpYSB0aGUgZG9tYWluIHR5cGUK
Pj4+ICAgIGlvbW11OiBFeHBvc2UgRE1BIGRvbWFpbiBzdHJpY3RuZXNzIHZpYSBzeXNmcwo+Pj4g
ICAgaW9tbXU6IE1lcmdlIHN0cmljdG5lc3MgYW5kIGRvbWFpbiB0eXBlIGNvbmZpZ3MKPj4+ICAg
IGlvbW11L2RtYTogRmFjdG9yIG91dCBmbHVzaCBxdWV1ZSBpbml0Cj4+PiAgICBpb21tdTogQWxs
b3cgZW5hYmxpbmcgbm9uLXN0cmljdCBtb2RlIGR5bmFtaWNhbGx5Cj4+PiAgICBpb21tdS9hcm0t
c21tdTogQWxsb3cgbm9uLXN0cmljdCBpbiBwZ3RhYmxlX3F1aXJrcyBpbnRlcmZhY2UKPj4+ICAg
IGlvbW11OiBPbmx5IGxvZyBzdHJpY3RuZXNzIGZvciBETUEgZG9tYWlucwo+Pj4KPj4+ICAgLi4u
L0FCSS90ZXN0aW5nL3N5c2ZzLWtlcm5lbC1pb21tdV9ncm91cHMgICAgIHwgIDIgKwo+Pj4gICBk
cml2ZXJzL2lvbW11L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgfCA4MCAKPj4+ICsr
KysrKysrKy0tLS0tLS0tLS0KPj4+ICAgZHJpdmVycy9pb21tdS9hbWQvaW9tbXUuYyAgICAgICAg
ICAgICAgICAgICAgIHwgMjEgKy0tLS0KPj4+ICAgZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUt
djMvYXJtLXNtbXUtdjMuYyAgIHwgMjUgKysrKy0tCj4+PiAgIGRyaXZlcnMvaW9tbXUvYXJtL2Fy
bS1zbW11L2FybS1zbW11LmMgICAgICAgICB8IDI5ICsrKystLS0KPj4+ICAgZHJpdmVycy9pb21t
dS9hcm0vYXJtLXNtbXUvcWNvbV9pb21tdS5jICAgICAgIHwgIDggLS0KPj4+ICAgZHJpdmVycy9p
b21tdS9kbWEtaW9tbXUuYyAgICAgICAgICAgICAgICAgICAgIHwgNDQgKysrKystLS0tLQo+Pj4g
ICBkcml2ZXJzL2lvbW11L2V4eW5vcy1pb21tdS5jICAgICAgICAgICAgICAgICAgfCAxOCArLS0t
LQo+Pj4gICBkcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgICAgICAgICAgICAgICAgICAgfCAy
MyArKy0tLS0KPj4+ICAgZHJpdmVycy9pb21tdS9pb21tdS5jICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgNTMgKysrKysrKy0tLS0tCj4+PiAgIGRyaXZlcnMvaW9tbXUvaXBtbXUtdm1zYS5jICAg
ICAgICAgICAgICAgICAgICB8IDI3ICstLS0tLS0KPj4+ICAgZHJpdmVycy9pb21tdS9tdGtfaW9t
bXUuYyAgICAgICAgICAgICAgICAgICAgIHwgIDYgLS0KPj4+ICAgZHJpdmVycy9pb21tdS9yb2Nr
Y2hpcC1pb21tdS5jICAgICAgICAgICAgICAgIHwgMTEgKy0tCj4+PiAgIGRyaXZlcnMvaW9tbXUv
c3ByZC1pb21tdS5jICAgICAgICAgICAgICAgICAgICB8ICA2IC0tCj4+PiAgIGRyaXZlcnMvaW9t
bXUvc3VuNTBpLWlvbW11LmMgICAgICAgICAgICAgICAgICB8IDEyICstLQo+Pj4gICBkcml2ZXJz
L2lvbW11L3ZpcnRpby1pb21tdS5jICAgICAgICAgICAgICAgICAgfCAgOCAtLQo+Pj4gICBpbmNs
dWRlL2xpbnV4L2RtYS1pb21tdS5oICAgICAgICAgICAgICAgICAgICAgfCAgOSArKy0KPj4+ICAg
aW5jbHVkZS9saW51eC9pb21tdS5oICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTUgKysrLQo+
Pj4gICAxOCBmaWxlcyBjaGFuZ2VkLCAxNzEgaW5zZXJ0aW9ucygrKSwgMjI2IGRlbGV0aW9ucygt
KQo+Pj4KPj4KPj4KPgo+IC4KPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
