Return-Path: <SRS0=q6a/=3Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F5AC33CA1
	for <iommu@archiver.kernel.org>; Wed,  5 Feb 2020 10:19:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F0020674
	for <iommu@archiver.kernel.org>; Wed,  5 Feb 2020 10:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="byogR5Y9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F0020674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A2EAD2047C;
	Wed,  5 Feb 2020 10:19:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Aue9K7+1F6t8; Wed,  5 Feb 2020 10:19:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 63BFB203D0;
	Wed,  5 Feb 2020 10:19:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AE25C1D81;
	Wed,  5 Feb 2020 10:19:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75306C0174
 for <iommu@lists.linux-foundation.org>; Wed,  5 Feb 2020 10:19:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5F8EF813E5
 for <iommu@lists.linux-foundation.org>; Wed,  5 Feb 2020 10:19:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gqGgf7gsEuXF for <iommu@lists.linux-foundation.org>;
 Wed,  5 Feb 2020 10:19:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 70A0C811F1
 for <iommu@lists.linux-foundation.org>; Wed,  5 Feb 2020 10:19:30 +0000 (UTC)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 015AJAWT038813;
 Wed, 5 Feb 2020 04:19:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1580897950;
 bh=a4B3Bqd5Pf17C8VTQl7PRrNSGniXRgvhSLeM1x0d+hk=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=byogR5Y93N6sxhLZuK2obDyLC3hmzVNNSkPNhl2ry7ZEcrYkt8Hqq8IySduCmkPtB
 ohzI1jKztmbskV4V7+4t9v6xsAEHReAeS1KcuOg+pfCOipcjcKomxqyKJ64H4kQq/o
 E3K6QUFcAKw8gAI++17jnsbO91gCzSVdho02fGa4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 015AJA6F008867;
 Wed, 5 Feb 2020 04:19:10 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 5 Feb
 2020 04:19:09 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 5 Feb 2020 04:19:09 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 015AJ7R3091177;
 Wed, 5 Feb 2020 04:19:07 -0600
Subject: Re: [PoC] arm: dma-mapping: direct: Apply dma_pfn_offset only when it
 is valid
To: Christoph Hellwig <hch@lst.de>
References: <8eb68140-97b2-62ce-3e06-3761984aa5b1@ti.com>
 <20200114164332.3164-1-peter.ujfalusi@ti.com>
 <f8121747-8840-e279-8c7c-75a9d4becce8@arm.com>
 <28ee3395-baed-8d59-8546-ab7765829cc8@ti.com>
 <4f0e307f-29a9-44cd-eeaa-3b999e03871c@arm.com>
 <75843c71-1718-8d61-5e3d-edba6e1b10bd@ti.com> <20200130075332.GA30735@lst.de>
 <b2b1cb21-3aae-2181-fd79-f63701f283c0@ti.com> <20200130164010.GA6472@lst.de>
 <c37b12e4-0e0c-afa2-a8e4-782ccd57542d@ti.com> <20200203170809.GA19293@lst.de>
Message-ID: <af52fd8e-4991-cbf1-2b55-c2b4496f4703@ti.com>
Date: Wed, 5 Feb 2020 12:19:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200203170809.GA19293@lst.de>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: robh@kernel.org, vigneshr@ti.com, konrad.wilk@oracle.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, rogerq@ti.com
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
From: Peter Ujfalusi via iommu <iommu@lists.linux-foundation.org>
Reply-To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgpPbiAwMy8wMi8yMDIwIDE5LjA4LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBGcmks
IEphbiAzMSwgMjAyMCBhdCAwNDowMDoyMFBNICswMjAwLCBQZXRlciBVamZhbHVzaSB3cm90ZToK
Pj4gSSBzZWUuIE15IFBvQyBwYXRjaCB3YXMgbm90IHRvbyBvZmYgdGhlbiA7KQo+PiBTbyB0aGUg
cGxhbiBpcyB0byBoYXZlIGEgZ2VuZXJpYyBpbXBsZW1lbnRhdGlvbiBmb3IgYWxsIG9mIHRoZQo+
PiBhcmNoaXRlY3R1cmUsIHJpZ2h0Pwo+IAo+INCGIGRvbid0IGtub3cgb2YgYSBjb25jcmV0ZSBw
bGFuLCBidXQgdGhhdCdzIGRlZmludGl2ZWx5IHdoYXQgSSdkIGxpa2UKPiB0byBzZWUuCj4gCj4+
Pj4gVGhlIGRtYV9wZm5fb2Zmc2V0IGlzIF9zdGlsbF8gYXBwbGllZCB0byB0aGUgbWFzayB3ZSBh
cmUgdHJ5aW5nIHRvIHNldAo+Pj4+IChhbmQgdmFsaWRhdGUpIHZpYSBkbWEtZGlyZWN0Lgo+Pj4K
Pj4+IEFuZCBmb3IgdGhlIGdlbmVyYWwgY2FzZSB0aGF0IGlzIGV4YWN0bHkgdGhlIHJpZ2h0IHRo
aW5nIHRvIGRvLCB3ZQo+Pj4ganVzdCBuZWVkIHRvIGRlYWwgd2l0aCByZWFsbHkgb2RkIFpPTkVf
RE1BIHBsYWNlbWVudHMgbGlrZSB5b3Vycy4KPj4KPj4gSSdtIHN0aWxsIG5vdCBjb252aW5jZWQs
IHRoZSBwb2ludCBvZiB0aGUgRE1BIG1hc2ssIGF0IGxlYXN0IGhvdyBJIHNlZQo+PiBpdCwgdG8g
Y2hlY2sgdGhhdCB0aGUgZG1hIGFkZHJlc3MgY2FuIGJlIGhhbmRsZWQgYnkgdGhlIGRldmljZSAo
RE1BLAo+PiBwZXJpcGhlcmFsIHdpdGggYnVpbHQgaW4gRE1BLCBldGMpLCBpdCBpcyBub3QgYWdh
aW5zdCBwaHlzaWNhbCBhZGRyZXNzLgo+PiBEb2luZyBwaHlzX3RvX2RtYSgpIG9uIHRoZSBtYXNr
IGZyb20gdGhlIGRtYV9zZXRfbWFzaygpIGlzIGp1c3Qgd3JvbmcuCj4gCj4gV2UgaGF2ZSBhIHRy
YW5zbGF0aW9uIGJldHdlZW4gdGhlIGFkZHJlc3NlcyB0aGF0IHRoZSBkZXZpY2Ugc2VlcywgYW5k
Cj4gdGhvc2UgdGhhdCB0aGUgQ1BVIHNlZXMuICBUaGUgZGV2aWNlIGNhbiBhZGRyZXNzIE4gYml0
cyBvZiBhZGRyZXNzIHNwYWNlCj4gYXMgc2VlbiBmcm9tIHRoZSBkZXZpY2UuICBUaGUgYWRkcmVz
c2VzIGVuY29kZWQgaW4gbWF4X3BmbiwKPiB6b25lX2RtYV9iaXRzIG9yIHRoZSBoYXJjb2RlZCAz
MiBpbiB0aGUgem9uZSBkbWEgMzIgY2FzZSBhcmUgQ1BVIGFkZHJlc3MuCj4gU28gbm8sIHdlIGNh
bid0IGJsaW5kbHkgY29tcGFyZSB0aG9zZS4KClJpZ2h0LCB0aGFua3MgZm9yIHRoZSBleHBsYW5h
dGlvbi4KCj4+PiBCdXQgdGhhdCB3aWxsIGNhdXNlIHlldCBhbm90aGVyIHJlZ3Jlc3Npb24gaW4g
d2hhdCB3ZSBoYXZlIGp1c3QgZml4ZWQKPj4+IHdpdGggdXNpbmcgdGhlIGdlbmVyaWMgZGlyZWN0
IG9wcywgYXQgd2hpY2ggcG9pbnRzIGl0IHR1cm5zIGludG8gd2hvCj4+PiBzY3JlYW1zIGxvdWRl
ci4KPj4KPj4gSGVoZSwgSSBzZWUuCj4+IEkgZ2VudWluZWx5IGN1cmlvdXMgd2h5IGsyIHBsYXRm
b3JtIHdvcmtlZCBqdXN0IGZpbmUgd2l0aCBMUEFFIChpdCBuZWVkcwo+PiBpdCksIGJ1dCBndXlz
IGhhZCBpc3N1ZXMgd2l0aCBMUEFFIG9uIGRyYTcvYW01Lgo+PiBUaGUgZml4IGZvciBkcmE3L2Ft
NSBicm9rZSBrMi4KPj4gQXMgZmFyIGFzIEkgY2FuIHNlZSB0aGUgbWFpbiAob25seSkgZGlmZmVy
ZW5jZSBpcyB0aGF0IGsyIGhhdmUKPj4gZG1hX3Bmbl9vZmZzZXQgPSAweDc4MDAwMCwgd2hpbGUg
ZHJhNy9hbTUgaGF2ZSBpdCAwIChyZWFsbHkgZGlyZWN0IG1hcHBpbmcpLgo+IAo+IEhvdyBtdWNo
IG1lbW9yeSBkb2VzIHRoZSBwbGF0Zm9ybSBoYXZlPwoKVGhlIGJvYXJkcyB3aGljaCBpcyBib290
YWJsZSBpbiBtYWlubGluZSBoYXZlIG1heGltdW0gb2YgMkcsIHRoZXJlIG1pZ2h0CmJlIGN1c3Rv
bSBib2FyZHMgd2l0aCBtb3JlIFJBTSwgYnV0IEknbSBub3QgYXdhcmUgb2YgdGhlbS4KCj4gT25j
ZSB5b3UgYXJlIGFib3ZlIDMyLWJpdHMgd29ydGgKPiBvZiBhZGRyZXNzIHNwYWNlIGRldmljZXMg
d2l0aCBhIDMyLWJpdCBETUEgbWFzayBjYW4ndCBhZGRyZXNzIGFsbCB0aGUKPiBtZW1vcnkuICBO
b3cgaWYgazIgZm9yIGV4YW1wbGUgb25seSBoYWQgbGVzcyB0aGFuIDRHIG9mIG1lbW9yeSwgYnV0
IGF0Cj4gYWRkcmVzc2VzIG92ZXIgNEcsIGFuZCB0aGUgb2Zmc2V0IGNvbXBlbnNhdGVzIGZvciB0
aGUgb2Zmc2V0IG9mIHRoZSBEUkFNCj4gaXQgd29ya3Mgd2l0aG91dCBib3VuY2UgYnVmZmVyaW5n
IGFuZCB0aHVzIGRpZG4ndCBuZWVkIHN3aW90bGIuICBCdXQgYW55Cj4gcGxhdGZvcm0gdGhhdCBo
YXMgRFJBTSB0aGF0IGlzIG5vdCBhZGRyZXNzYWJsZSB3aWxsIG5lZWQgc3dpb3RsYi4KCkkgc2Vl
LCBzaW5jZSB3ZSBoYXZlIG1heGltdW0gb2YgMkcsIHdoaWNoIGlzIG1pcnJvcmVkIGF0IDB4ODAw
MDAwMDAgZm9yCmRldmljZXMgd2UgbmV2ZXIgbmVlZGVkIHRoZSBhc3Npc3RhbmNlIGZyb20gc3dp
b3RsYiBmb3IgYm91bmNlIGJ1ZmZlcmluZwphbmQgdGhhdCdzIHdoeSB0aGUgYXJtIG9wcyB3b3Jr
ZWQgZmluZS4KCj4gCj4+PiAgCXU2NCBtaW5fbWFzazsKPj4+ICAKPj4+ICsJaWYgKG1hc2sgPj0g
RE1BX0JJVF9NQVNLKDMyKSkKPj4+ICsJCXJldHVybiAxOwo+Pj4gKwo+Pgo+PiBSaWdodCwgc28g
c2tpcHBpbmcgcGh5c190b19kbWEoKSBmb3IgdGhlIG1hc2sgYW5kIGJlbGlldmluZyB0aGF0IGl0
IHdpbGwKPj4gd29yay4uCj4+Cj4+IEl0IGRvZXM6IGF1ZGlvIGFuZCBkbWF0ZXN0IG1lbWNweSB0
ZXN0cyBhcmUganVzdCBmaW5lIHdpdGggdGhpcywgTU1DCj4+IGFsc28gcHJvYmVkIHdpdGggQURN
QSBlbmFibGVkLgo+Pgo+PiBBcyBmYXIgYXMgSSBjYW4gdGVsbCBpdCB3b3JrcyBhcyB3ZWxsIGFz
IGZhbGxpbmcgYmFjayB0byB0aGUgb2xkIGFybSBvcHMKPj4gaW4gY2FzZSBvZiBMUEFFICYmIGRt
YV9wZm5fb2Zmc2V0ICE9IDAKPj4KPj4gRndpdzoKPj4gVGVzdGVkLWJ5OiBQZXRlciBVamZhbHVz
aSA8cGV0ZXIudWpmYWx1c2lAdGkuY29tPgo+Pgo+PiBXb3VsZCB5b3UgYmUgY29tZm9ydGFibGUg
dG8gc2VuZCB0aGlzIHBhdGNoIGZvciBtYWlubGluZSB3aXRoCj4+IEZpeGVzOiBhZDNjN2IxOGM1
YjMgKCJhcm06IHVzZSBzd2lvdGxiIGZvciBib3VuY2UgYnVmZmVyaW5nIG9uIExQQUUKPj4gY29u
ZmlncyIpCj4gCj4gVGhhdCBpcyB0aGUgYmlnIHF1ZXN0aW9uLiAgSSBkb24ndCBmZWVsIG92ZXJs
eSBjb21mb3J0YWJsZSBhcyBJJ3ZlIGJlZW4KPiB0cnlpbmcgdG8gZ2V0IHRoaXMgcmlnaHQsIGJ1
dCBzbyBmYXIgaXQgc2VlbXMgbGlrZSB0aGUgbGVhc3QgYmFkIG9wdGlvbi4KPiBJJ2xsIHNlbmQg
b3V0IGEgcHJvcGVyIHBhdGNoIHdpdGggdXBkYXRlZCBjb21tZW50cyBhbmQgd2lsbCBzZWUgd2hh
dAo+IHBlb3BsZSB0aGluay4KCkkgdW5kZXJzdGFuZCBhbmQgdGhhbmsgeW91IGZvciB0aGUgcGF0
Y2gsIGl0IG1ha2VzIGsyIHBsYXRmb3JtIHdvcmtpbmcKYWdhaW4hCgotIFDDqXRlcgoKVGV4YXMg
SW5zdHJ1bWVudHMgRmlubGFuZCBPeSwgUG9ya2thbGFua2F0dSAyMiwgMDAxODAgSGVsc2lua2ku
ClktdHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlwYWlra2EvRG9taWNpbGU6IEhl
bHNpbmtpCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
