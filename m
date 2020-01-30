Return-Path: <SRS0=QAIZ=3T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFD4C33C9E
	for <iommu@archiver.kernel.org>; Thu, 30 Jan 2020 13:04:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FB2920702
	for <iommu@archiver.kernel.org>; Thu, 30 Jan 2020 13:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FdMory5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB2920702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F25958558D;
	Thu, 30 Jan 2020 13:04:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N+WEq4lqv8ZH; Thu, 30 Jan 2020 13:04:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 212EE84E68;
	Thu, 30 Jan 2020 13:04:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03048C1796;
	Thu, 30 Jan 2020 13:04:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6048C0171
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jan 2020 13:04:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 97D7F8833B
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jan 2020 13:04:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eWSxFMBqlqxj for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jan 2020 13:04:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 48DF286187
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jan 2020 13:04:20 +0000 (UTC)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00UD3r8w022295;
 Thu, 30 Jan 2020 07:03:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1580389433;
 bh=mEcLQEChF7CG3SdoHl9lJA4gqUSKK86HYBojtm7S8K4=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=FdMory5EL5Lpr0oRMV/b8+w2bkp0m8n3dQv69sKaKqOqAuQb7aVSxUZh0v5UsXSgg
 IDQfesYGJX3fhF+Gi4f5C2PIxuGmZNdZPCohbCRXc8q6GnwhwN7X6Pg5+qV3HTdI+E
 Lr3BM/QAGKgzOKtFWVKfsyuXXX3t2WX6q8Q6LGoM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00UD3rwY115312;
 Thu, 30 Jan 2020 07:03:53 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 30
 Jan 2020 07:03:52 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 30 Jan 2020 07:03:52 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00UD3oM1101462;
 Thu, 30 Jan 2020 07:03:50 -0600
Subject: Re: [PoC] arm: dma-mapping: direct: Apply dma_pfn_offset only when it
 is valid
To: Christoph Hellwig <hch@lst.de>
References: <8eb68140-97b2-62ce-3e06-3761984aa5b1@ti.com>
 <20200114164332.3164-1-peter.ujfalusi@ti.com>
 <f8121747-8840-e279-8c7c-75a9d4becce8@arm.com>
 <28ee3395-baed-8d59-8546-ab7765829cc8@ti.com>
 <4f0e307f-29a9-44cd-eeaa-3b999e03871c@arm.com>
 <75843c71-1718-8d61-5e3d-edba6e1b10bd@ti.com> <20200130075332.GA30735@lst.de>
Message-ID: <b2b1cb21-3aae-2181-fd79-f63701f283c0@ti.com>
Date: Thu, 30 Jan 2020 15:04:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200130075332.GA30735@lst.de>
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

CgpPbiAzMC8wMS8yMDIwIDkuNTMsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IFtza2lwcGlu
ZyB0aGUgRFQgYml0cywgYXMgSSdtIGV2ZXJ5dGhpbmcgYnV0IGFuIGV4cGVydCBvbiB0aGF0Li5d
Cj4gCj4gT24gTW9uLCBKYW4gMjcsIDIwMjAgYXQgMDQ6MDA6MzBQTSArMDIwMCwgUGV0ZXIgVWpm
YWx1c2kgd3JvdGU6Cj4+IEkgYWdyZWUgb24gdGhlIHBoeXNfdG9fZG1hKCkuIEl0IHNob3VsZCBm
YWlsIGZvciBhZGRyZXNzZXMgd2hpY2ggZG9lcwo+PiBub3QgZmFsbCBpbnRvIGFueSBvZiB0aGUg
cmFuZ2VzLgo+PiBJdCBpcyBqdXN0IGEgdGhhdCB3ZSBpbiBMaW51eCBkb24ndCBoYXZlIHRoZSBj
b25jZXB0IGF0bSBmb3IgcmFuZ2VzLCB3ZQo+PiBoYXZlIG9ubHkgX29uZV8gcmFuZ2Ugd2hpY2gg
YXBwbGllcyB0byBldmVyeSBtZW1vcnkgYWRkcmVzcy4KPiAKPiB3aGF0IGRvZXMgYXRtIGhlcmUg
bWVhbj8KCnN0cnVjdCBkZXZpY2UgaGF2ZSBvbmx5IHNpbmdsZSBkbWFfcGZuX29mZnNldCwgb25l
IGNhbiBub3QgaGF2ZSBtdWx0aXBsZQpyYW5nZXMgZGVmaW5lZC4gSWYgd2UgaGF2ZSB0aGVuIG9u
bHkgdGhlIGZpcnN0IGlzIHRha2VuIGFuZCB0aGUgcGh5c2ljYWwKYWRkcmVzcyBhbmQgZG1hIGFk
ZHJlc3MgaXMgZGlzY2FyZGVkLCBvbmx5IHRoZSBkbWFfcGZuX29mZnNldCBpcyBzdG9yZWQKYW5k
IHVzZWQuCgo+IFdlIGhhdmUgbmVlZGVkIG11bHRpLXJhbmdlIHN1cHBvcnQgZm9yIHF1aXRlIGEg
d2hpbGUsIGFzIGNvbW1vbiBicm9hZGNvbQo+IFNPQ3MgZG8gbmVlZCBpdC4gIFNvIHBhdGNoZXMg
Zm9yIHRoYXQgYXJlIHdlbGNvbWUgYXQgbGVhc3QgZnJvbSB0aGUKPiBETUEgbGF5ZXIgcGVyc3Bl
Y3RpdmUgKGtpbmRhIHNpbWlsYXIgdG8geW91ciBwc2V1ZG8gY29kZSBlYXJsaWVyKQoKQnV0IGRv
IHRoZXkgaGF2ZSBkbWFfcGZuX29mZnNldCAhPSAwPwoKPj4+IE5vYm9keSdzIGRpc3B1dGluZyB0
aGF0IHRoZSBjdXJyZW50IGRtYV9kaXJlY3Rfc3VwcG9ydGVkKCkKPj4+IGltcGxlbWVudGF0aW9u
IGlzIGJyb2tlbiBmb3IgdGhlIGNhc2Ugd2hlcmUgWk9ORV9ETUEgaXRzZWxmIGlzIG9mZnNldAo+
Pj4gZnJvbSBQQSAwOyB0aGUgbW9yZSBwcmVzc2luZyBxdWVzdGlvbiBpcyB3aHkgQ2hyaXN0b3Bo
J3MgZGlmZiwgd2hpY2ggd2FzCj4+PiB0cnlpbmcgdG8gdGFrZSB0aGF0IGludG8gYWNjb3VudCwg
c3RpbGwgZGlkbid0IHdvcmsuCj4+Cj4+IEkgdW5kZXJzdGFuZCB0aGF0IHRoaXMgaXMgYSBiaXQg
bW9yZSBjb21wbGV4IHRoYW4gSSBpbnRlcnByZXQgaXQsIGJ1dAo+PiB0aGUgazJnIGlzIGJyb2tl
biBhbmQgY3VycmVudGx5IHRoZSBzaW1wbGVzdCB3YXkgdG8gbWFrZSBpdCB3b3JrIGlzIHRvCj4+
IHVzZSB0aGUgYXJtIGRtYV9vcHMgaW4gY2FzZSB0aGUgcGZuX29mZnNldCBpcyBub3QgMC4KPj4g
SXQgd2lsbCBiZSBlYXN5IHRvIHRlc3QgZG1hLWRpcmVjdCBjaGFuZ2VzIHRyeWluZyB0byBhZGRy
ZXNzIHRoZSBpc3N1ZQo+PiBpbiBoYW5kLCBidXQgd2lsbCBhbGxvdyBrMmcgdG8gYmUgdXNhYmxl
IGF0IHRoZSBzYW1lIHRpbWUuCj4gCj4gV2VsbCwgdXNpbmcgdGhlIGxlZ2FjeSBhcm0gZG1hIG9w
cyBtZWFucyB3ZSBjYW4ndCB1c2Ugc3dpb3RsYiBpZiB0aGVyZQo+IGlzIGFuIG9mZnNldCwgd2hp
Y2ggaXMgYWxzbyB3cm9uZyBmb3IgbG90cyBvZiBjb21tb24gY2FzZXMsIGluY2x1ZGluZwo+IHRo
ZSBScGkgNC4gIEknbSBzdGlsbCBjdXJpb3VzIHdoeSBteSBwYXRjaCBkaWRuJ3Qgd29yaywgYXMg
SSB0aG91Z2h0Cj4gaXQgc2hvdWxkLgoKVGhlIGRtYV9wZm5fb2Zmc2V0IGlzIF9zdGlsbF8gYXBw
bGllZCB0byB0aGUgbWFzayB3ZSBhcmUgdHJ5aW5nIHRvIHNldAooYW5kIHZhbGlkYXRlKSB2aWEg
ZG1hLWRpcmVjdC4KCmluIGRtYV9kaXJlY3Rfc3VwcG9ydGVkOgptYXNrID09IDB4ZmZmZmZmZmYg
Ly8gRE1BX0JJVF9NQVNLKDMyKQpkZXYtPmRtYV9wZm5fb2Zmc2V0ID09IDB4NzgwMDAwIC8vIEtl
eXN0b25lIDIKbWluX21hc2sgPT0gMHhmZmZmZmYKCnRtcF9tYXNrID0gX19waHlzX3RvX2RtYShk
ZXYsIG1pbl9tYXNrKTsKdG1wX21hc2sgPT0gMHhmZjg4MGZmZmZmZgoKd2l0aGluIF9fcGh5c190
b19kbWEoKSBjb252ZXJ0cyB0aGUgbWluX21hc2sgdG8gcGZuIGFuZCBjYWxscwpwZm5fdG9fZG1h
KCkgd2hpY2ggZG9lczoKaWYgKGRldikKCXBmbiAtPSBkZXYtPmRtYV9wZm5fb2Zmc2V0OwoKdGhl
IHJldHVybmVkIHBmbiBpcyB0aGVuIGNvbnZlcnRlZCBiYWNrIHRvIGFkZHJlc3MuCgp0aGUgbWFz
ayAoMHhmZmZmZmZmZikgaXMgd2VsbCB1bmRlciB0aGUgdG1wX21hc2sgKDB4ZmY4ODBmZmZmZmYp
IHNvCmRtYV9kaXJlY3Rfc3VwcG9ydGVkKCkgd2lsbCB0ZWxsIHVzIHRoYXQgRE1BIGlzIG5vdCBz
dXBwb3J0ZWQgZm9yCkRNQV9CSVRfTUFTSygzMiksIHdoaWNoIGlzIG5vdCB0cnVlLCBiZWNhdXNl
IERNQSBpcyBzdXBwb3J0aW5nIDMyIGJpdHMuCgo+IFdlJ2xsIG5lZWQgdG8gZmluZCB0aGUgbWlu
aW11bSBjaGFuZ2UgdG8gbWFrZSBpdCB3b3JrCj4gZm9yIG5vdyB3aXRob3V0IHN3aXRjaGluZyBv
cHMsIGV2ZW4gaWYgaXQgaXNuJ3QgdGhlIGNvcnJlY3Qgb25lLCBhbmQKPiB0aGVuIHdvcmsgZnJv
bSB0aGVyZS4KClN1cmUsIGJ1dCBjYW4gd2UgZml4IHRoZSByZWdyZXNzaW9uIGJ5IHJldmVydGlu
ZyB0byBhcm1fb3BzIGZvciBub3cgb25seQppZiBkbWFfcGZuX29mZnNldCBpcyBub3QgMD8gSXQg
dXNlZCB0byB3b3JrIGZpbmUgaW4gdGhlIHBhc3QgYXQgbGVhc3QgaXQKYXBwZWFyZWQgdG8gd29y
ayBvbiBLMiBwbGF0Zm9ybXMuCgotIFDDqXRlcgoKVGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBP
eSwgUG9ya2thbGFua2F0dSAyMiwgMDAxODAgSGVsc2lua2kuClktdHVubnVzL0J1c2luZXNzIElE
OiAwNjE1NTIxLTQuIEtvdGlwYWlra2EvRG9taWNpbGU6IEhlbHNpbmtpCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
