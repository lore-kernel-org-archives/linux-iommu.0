Return-Path: <SRS0=/T8B=3Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C0BC2D0B1
	for <iommu@archiver.kernel.org>; Tue,  4 Feb 2020 09:34:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C3CF2166E
	for <iommu@archiver.kernel.org>; Tue,  4 Feb 2020 09:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lo3rwbgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3CF2166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 53A71842F8;
	Tue,  4 Feb 2020 09:34:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HTM2GLwxucA3; Tue,  4 Feb 2020 09:34:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4D65983F08;
	Tue,  4 Feb 2020 09:34:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2967DC1D81;
	Tue,  4 Feb 2020 09:34:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 438EDC0174
 for <iommu@lists.linux-foundation.org>; Tue,  4 Feb 2020 09:34:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 31FB02036B
 for <iommu@lists.linux-foundation.org>; Tue,  4 Feb 2020 09:34:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NGb8jRuwHvq8 for <iommu@lists.linux-foundation.org>;
 Tue,  4 Feb 2020 09:34:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 by silver.osuosl.org (Postfix) with ESMTPS id 4D48220349
 for <iommu@lists.linux-foundation.org>; Tue,  4 Feb 2020 09:34:51 +0000 (UTC)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0149YbZM070502;
 Tue, 4 Feb 2020 03:34:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1580808877;
 bh=0YLT5G2KDDkaXYmv/lijgenq70L6rJ93LRjbmt0OMok=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=lo3rwbgEe/PjhcxYvDiI14ysBcjXhMf+d211fVU0G0lHMuWdy4vM8sFKX21HJF4rA
 vIGJAK+1evNgkugBYeW0Fi8gNJ9A+zNLHUBoc2TAnS7WS17WyCMP0y3huK1ehAQFTV
 ylfU80fWWkvf5MXpzHIZIT+VOQlZxxG+WTcb9wa8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0149YbJL077913
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 4 Feb 2020 03:34:37 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 4 Feb
 2020 03:34:37 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 4 Feb 2020 03:34:37 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0149YZ1A087824;
 Tue, 4 Feb 2020 03:34:35 -0600
Subject: Re: [PATCH] dma-direct: relax addressability checks in
 dma_direct_supported
To: Christoph Hellwig <hch@lst.de>, <iommu@lists.linux-foundation.org>
References: <20200203171601.539254-1-hch@lst.de>
Message-ID: <1011c272-9527-9e61-4954-c7e27cd1fcb6@ti.com>
Date: Tue, 4 Feb 2020 11:34:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200203171601.539254-1-hch@lst.de>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: robin.murphy@arm.com, linux-kernel@vger.kernel.org,
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
From: Peter Ujfalusi via iommu <iommu@lists.linux-foundation.org>
Reply-To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgQ2hyaXN0b3BoLAoKT24gMDMvMDIvMjAyMCAxOS4xNiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3Jv
dGU6Cj4gZG1hX2RpcmVjdF9zdXBwb3J0ZWQgdHJpZXMgdG8gZmluZCB0aGUgbWluaW11bSBhZGRy
ZXNzYWJsZSBiaXRtYXNrCj4gYmFzZWQgb24gdGhlIGVuZCBwZm4gYW5kIG9wdGlvbmFsIG1hZ2lj
IHRoYXQgYXJjaGl0ZWN0dXJlcyBjYW4gdXNlCj4gdG8gY29tbXVuaWNhdGUgdGhlIHNpemUgb2Yg
dGhlIG1hZ2ljIFpPTkVfRE1BIHRoYXQgY2FuIGJlIHVzZWQKPiBmb3IgYm91bmNlIGJ1ZmZlcmlu
Zy4gIEJ1dCBiZXR3ZWVuIHRoZSBETUEgb2Zmc2V0cyB0aGF0IGNhbiBjaGFuZ2UKPiBwZXIgZGV2
aWNlIChvciBzb21ldGltZXMgZXZlbiByZWdpb24pLCB0aGUgZmFjdCB0aGUgWk9ORV9ETUEgaXNu
J3QKPiBldmVuIGd1YXJhbnRlZWQgdG8gYmUgdGhlIGxvd2VzdCBhZGRyZXNzZXMgYW5kIGZhaWx1
cmUgb2YgaGF2aW5nCj4gcHJvcGVyIGludGVyZmFjZXMgdG8gdGhlIE1NIGNvZGUgdGhpcyBmYWls
cyBhdCBsZWFzdCBmb3Igb25lCj4gYXJtIHN1YmFyY2hpdGVjdHVyZS4KPiAKPiBBcyBhbGwgdGhl
IGxlZ2FjeSBETUEgaW1wbGVtZW50YXRpb25zIGhhdmUgc3VwcG9ydGVkIDMyLWJpdCBETUEKPiBt
YXNrcywgYW5kIDMyLWJpdCBtYXNrcyBhcmUgZ3VyYW50ZWVkIHRvIGFsd2F5cyB3b3JrIGJ5IHRo
ZSBBUEkKPiBjb250cmFjdCAodXNpbmcgYm91bmNlIGJ1ZmZlcnMgaWYgbmVlZGVkKSwgd2UgY2Fu
IHNob3J0IGN1dCB0aGUKPiBjb21wbGljYXRlZCBjaGVjayBhbmQgYWx3YXlzIHJldHVybiB0cnVl
IHdpdGhvdXQgYnJlYWtpbmcgZXhpc3RpbmcKPiBhc3N1bXB0aW9ucy4gIEhvcGVmdWxseSB3ZSBj
YW4gcHJvcGVybHkgY2xlYW4gdXAgdGhlIGludGVyYWN0aW9uCj4gd2l0aCB0aGUgYXJjaCBkZWZp
bmVkIHpvbmVzIGFuZCB0aGUgYm9vdG1lbSBhbGxvY2F0b3IgZXZlbnR1YWxseS4KPiAKPiBGaXhl
czogYWQzYzdiMThjNWIzICgiYXJtOiB1c2Ugc3dpb3RsYiBmb3IgYm91bmNlIGJ1ZmZlcmluZyBv
biBMUEFFIGNvbmZpZ3MiKQo+IFJlcG9ydGVkLWJ5OiBQZXRlciBVamZhbHVzaSA8cGV0ZXIudWpm
YWx1c2lAdGkuY29tPgo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0
LmRlPgo+IFRlc3RlZC1ieTogUGV0ZXIgVWpmYWx1c2kgPHBldGVyLnVqZmFsdXNpQHRpLmNvbT4K
ClRoYW5rIHlvdSBmb3IgdGhlIHByb3BlciBwYXRjaCwgSSBjYW4gcmVhZmZpcm0gbXkgVGVzdGVk
LWJ5LgpXZSBoYXZlIGFsc28gdGVzdGVkIHJlbW90ZXByb2Mgb24gazIsIHdoaWNoIGdvdCBicm9r
ZW4gYXMgd2VsbC4KClRoYW5rcyBhZ2FpbiwKLSBQw6l0ZXIKCj4gLS0tCj4gIGtlcm5lbC9kbWEv
ZGlyZWN0LmMgfCAyNCArKysrKysrKysrKy0tLS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQs
IDExIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9rZXJu
ZWwvZG1hL2RpcmVjdC5jIGIva2VybmVsL2RtYS9kaXJlY3QuYwo+IGluZGV4IDA0ZjMwOGE0N2Zj
My4uZWZhYjg5NGMxNjc5IDEwMDY0NAo+IC0tLSBhL2tlcm5lbC9kbWEvZGlyZWN0LmMKPiArKysg
Yi9rZXJuZWwvZG1hL2RpcmVjdC5jCj4gQEAgLTQ2NCwyOCArNDY0LDI2IEBAIGludCBkbWFfZGly
ZWN0X21tYXAoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwK
PiAgfQo+ICAjZW5kaWYgLyogQ09ORklHX01NVSAqLwo+ICAKPiAtLyoKPiAtICogQmVjYXVzZSAz
Mi1iaXQgRE1BIG1hc2tzIGFyZSBzbyBjb21tb24gd2UgZXhwZWN0IGV2ZXJ5IGFyY2hpdGVjdHVy
ZSB0byBiZQo+IC0gKiBhYmxlIHRvIHNhdGlzZnkgdGhlbSAtIGVpdGhlciBieSBub3Qgc3VwcG9y
dGluZyBtb3JlIHBoeXNpY2FsIG1lbW9yeSwgb3IgYnkKPiAtICogcHJvdmlkaW5nIGEgWk9ORV9E
TUEzMi4gIElmIG5laXRoZXIgaXMgdGhlIGNhc2UsIHRoZSBhcmNoaXRlY3R1cmUgbmVlZHMgdG8K
PiAtICogdXNlIGFuIElPTU1VIGluc3RlYWQgb2YgdGhlIGRpcmVjdCBtYXBwaW5nLgo+IC0gKi8K
PiAgaW50IGRtYV9kaXJlY3Rfc3VwcG9ydGVkKHN0cnVjdCBkZXZpY2UgKmRldiwgdTY0IG1hc2sp
Cj4gIHsKPiAtCXU2NCBtaW5fbWFzazsKPiAtCj4gLQlpZiAoSVNfRU5BQkxFRChDT05GSUdfWk9O
RV9ETUEpKQo+IC0JCW1pbl9tYXNrID0gRE1BX0JJVF9NQVNLKHpvbmVfZG1hX2JpdHMpOwo+IC0J
ZWxzZQo+IC0JCW1pbl9tYXNrID0gRE1BX0JJVF9NQVNLKDMyKTsKPiArCXU2NCBtaW5fbWFzayA9
IChtYXhfcGZuIC0gMSkgPDwgUEFHRV9TSElGVDsKPiAgCj4gLQltaW5fbWFzayA9IG1pbl90KHU2
NCwgbWluX21hc2ssIChtYXhfcGZuIC0gMSkgPDwgUEFHRV9TSElGVCk7Cj4gKwkvKgo+ICsJICog
QmVjYXVzZSAzMi1iaXQgRE1BIG1hc2tzIGFyZSBzbyBjb21tb24gd2UgZXhwZWN0IGV2ZXJ5IGFy
Y2hpdGVjdHVyZQo+ICsJICogdG8gYmUgYWJsZSB0byBzYXRpc2Z5IHRoZW0gLSBlaXRoZXIgYnkg
bm90IHN1cHBvcnRpbmcgbW9yZSBwaHlzaWNhbAo+ICsJICogbWVtb3J5LCBvciBieSBwcm92aWRp
bmcgYSBaT05FX0RNQTMyLiAgSWYgbmVpdGhlciBpcyB0aGUgY2FzZSwgdGhlCj4gKwkgKiBhcmNo
aXRlY3R1cmUgbmVlZHMgdG8gdXNlIGFuIElPTU1VIGluc3RlYWQgb2YgdGhlIGRpcmVjdCBtYXBw
aW5nLgo+ICsJICovCj4gKwlpZiAobWFzayA+PSBETUFfQklUX01BU0soMzIpKQo+ICsJCXJldHVy
biAxOwo+ICAKPiAgCS8qCj4gIAkgKiBUaGlzIGNoZWNrIG5lZWRzIHRvIGJlIGFnYWluc3QgdGhl
IGFjdHVhbCBiaXQgbWFzayB2YWx1ZSwgc28KPiAgCSAqIHVzZSBfX3BoeXNfdG9fZG1hKCkgaGVy
ZSBzbyB0aGF0IHRoZSBTTUUgZW5jcnlwdGlvbiBtYXNrIGlzbid0Cj4gIAkgKiBwYXJ0IG9mIHRo
ZSBjaGVjay4KPiAgCSAqLwo+ICsJaWYgKElTX0VOQUJMRUQoQ09ORklHX1pPTkVfRE1BKSkKPiAr
CQltaW5fbWFzayA9IG1pbl90KHU2NCwgbWluX21hc2ssIERNQV9CSVRfTUFTSyh6b25lX2RtYV9i
aXRzKSk7Cj4gIAlyZXR1cm4gbWFzayA+PSBfX3BoeXNfdG9fZG1hKGRldiwgbWluX21hc2spOwo+
ICB9Cj4gIAo+IAoKVGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBPeSwgUG9ya2thbGFua2F0dSAy
MiwgMDAxODAgSGVsc2lua2kuClktdHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlw
YWlra2EvRG9taWNpbGU6IEhlbHNpbmtpCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
