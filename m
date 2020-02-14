Return-Path: <SRS0=UfLp=4C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3850FC35242
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 20:58:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB0A5222C2
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 20:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0A5222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8A4E52275F;
	Fri, 14 Feb 2020 20:58:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HS7oUxHPfI6n; Fri, 14 Feb 2020 20:58:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A48E422703;
	Fri, 14 Feb 2020 20:58:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90594C08A4;
	Fri, 14 Feb 2020 20:58:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B7EFC0177
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 20:58:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 59C6A87872
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 20:58:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8BGiYQu5N4Qu for <iommu@lists.linux-foundation.org>;
 Fri, 14 Feb 2020 20:58:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4A19287871
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 20:58:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7738930E;
 Fri, 14 Feb 2020 12:58:47 -0800 (PST)
Received: from [192.168.1.123] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A985B3F68F;
 Fri, 14 Feb 2020 12:58:46 -0800 (PST)
Subject: Re: arm-smmu.1.auto: Unhandled context fault starting with 5.4-rc1
To: Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux-foundation.org, 
 Will Deacon <will@kernel.org>
References: <20200214201353.qlbqcvpztcx55qud@cantor>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7c9a234e-78b1-2385-84b8-50744b9c4066@arm.com>
Date: Fri, 14 Feb 2020 20:58:40 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200214201353.qlbqcvpztcx55qud@cantor>
Content-Language: en-GB
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

SGkgSmVycnksCgpPbiAyMDIwLTAyLTE0IDg6MTMgcG0sIEplcnJ5IFNuaXRzZWxhYXIgd3JvdGU6
Cj4gSGkgV2lsbCwKPiAKPiBPbiBhIGdpZ2FieXRlIHN5c3RlbSB3aXRoIENhdml1bSBDTjh4eCwg
d2hlbiBkb2luZyBhIGZpbyB0ZXN0IGFnYWluc3QKPiBhbiBudm1lIGRyaXZlIHdlIGFyZSBzZWVp
bmcgdGhlIGZvbGxvd2luZzoKPiAKPiBbwqAgNjM3LjE2MTE5NF0gYXJtLXNtbXUgYXJtLXNtbXUu
MS5hdXRvOiBVbmhhbmRsZWQgY29udGV4dCBmYXVsdDogCj4gZnNyPTB4ODAwMDA0MDIsIGlvdmE9
MHg4MDEwMDAzZjYwMDAsIGZzeW5yPTB4NzAwOTEsIGNiZnJzeW5yYT0weDkwMDAsIGNiPTcKPiBb
wqAgNjM3LjE3NDMyOV0gYXJtLXNtbXUgYXJtLXNtbXUuMS5hdXRvOiBVbmhhbmRsZWQgY29udGV4
dCBmYXVsdDogCj4gZnNyPTB4ODAwMDA0MDIsIGlvdmE9MHg4MDEwMDAwMzYwMDAsIGZzeW5yPTB4
NzAwOTEsIGNiZnJzeW5yYT0weDkwMDAsIGNiPTcKPiBbwqAgNjM3LjE4Njg4N10gYXJtLXNtbXUg
YXJtLXNtbXUuMS5hdXRvOiBVbmhhbmRsZWQgY29udGV4dCBmYXVsdDogCj4gZnNyPTB4ODAwMDA0
MDIsIGlvdmE9MHg4MDEwMDAyZWUwMDAsIGZzeW5yPTB4NzAwOTEsIGNiZnJzeW5yYT0weDkwMDAs
IGNiPTcKPiBbwqAgNjM3LjE5OTI3NV0gYXJtLXNtbXUgYXJtLXNtbXUuMS5hdXRvOiBVbmhhbmRs
ZWQgY29udGV4dCBmYXVsdDogCj4gZnNyPTB4ODAwMDA0MDIsIGlvdmE9MHg4MDEwMDAzYzcwMDAs
IGZzeW5yPTB4NzAwOTEsIGNiZnJzeW5yYT0weDkwMDAsIGNiPTcKPiBbwqAgNjM3LjIxMTg4NV0g
YXJtLXNtbXUgYXJtLXNtbXUuMS5hdXRvOiBVbmhhbmRsZWQgY29udGV4dCBmYXVsdDogCj4gZnNy
PTB4ODAwMDA0MDIsIGlvdmE9MHg4MDEwMDAzOTIwMDAsIGZzeW5yPTB4NzAwOTEsIGNiZnJzeW5y
YT0weDkwMDAsIGNiPTcKPiBbwqAgNjM3LjIyNDU4MF0gYXJtLXNtbXUgYXJtLXNtbXUuMS5hdXRv
OiBVbmhhbmRsZWQgY29udGV4dCBmYXVsdDogCj4gZnNyPTB4ODAwMDA0MDIsIGlvdmE9MHg4MDEw
MDAwMTgwMDAsIGZzeW5yPTB4NzAwOTEsIGNiZnJzeW5yYT0weDkwMDAsIGNiPTcKPiBbwqAgNjM3
LjIzNzI0MV0gYXJtLXNtbXUgYXJtLXNtbXUuMS5hdXRvOiBVbmhhbmRsZWQgY29udGV4dCBmYXVs
dDogCj4gZnNyPTB4ODAwMDA0MDIsIGlvdmE9MHg4MDEwMDAzNjAwMDAsIGZzeW5yPTB4NzAwOTEs
IGNiZnJzeW5yYT0weDkwMDAsIGNiPTcKPiBbwqAgNjM3LjI0OTY1N10gYXJtLXNtbXUgYXJtLXNt
bXUuMS5hdXRvOiBVbmhhbmRsZWQgY29udGV4dCBmYXVsdDogCj4gZnNyPTB4ODAwMDA0MDIsIGlv
dmE9MHg4MDEwMDAwYmEwMDAsIGZzeW5yPTB4NzAwOTEsIGNiZnJzeW5yYT0weDkwMDAsIGNiPTcK
PiBbwqAgNjM3LjI2MjEyMF0gYXJtLXNtbXUgYXJtLXNtbXUuMS5hdXRvOiBVbmhhbmRsZWQgY29u
dGV4dCBmYXVsdDogCj4gZnNyPTB4ODAwMDA0MDIsIGlvdmE9MHg4MDEwMDAwM2UwMDAsIGZzeW5y
PTB4NzAwOTEsIGNiZnJzeW5yYT0weDkwMDAsIGNiPTcKPiBbwqAgNjM3LjI3NDQ2OF0gYXJtLXNt
bXUgYXJtLXNtbXUuMS5hdXRvOiBVbmhhbmRsZWQgY29udGV4dCBmYXVsdDogCj4gZnNyPTB4ODAw
MDA0MDIsIGlvdmE9MHg4MDEwMDAzMDQwMDAsIGZzeW5yPTB4NzAwOTEsIGNiZnJzeW5yYT0weDkw
MDAsIGNiPTcKClRob3NlICJJT1ZBcyIgZG9uJ3QgbG9vayBtdWNoIGxpa2UgSU9WQXMgZnJvbSB0
aGUgRE1BIGFsbG9jYXRvciAtIGlmIAp0aGV5IHdlcmUgcGh5c2ljYWwgYWRkcmVzc2VzLCB3b3Vs
ZCB0aGV5IGNvcnJlc3BvbmQgdG8gYW4gZXhwZWN0ZWQgCnJlZ2lvbiBvZiB0aGUgcGh5c2ljYWwg
bWVtb3J5IG1hcD8KCkkgd291bGQgc3VzcGVjdCB0aGF0IHRoaXMgaXMgbW9zdCBsaWtlbHkgbWlz
YmVoYXZpb3VyIGluIHRoZSBOVk1lIGRyaXZlciAKKGlzc3VpbmcgYSB3cml0ZSB0byBhIG5vbi1E
TUEtbWFwcGVkIGFkZHJlc3MpLCBhbmQgdGhlIFNNTVUgaXMganVzdCAKZG9pbmcgaXRzIGpvYiBp
biBibG9ja2luZyBhbmQgcmVwb3J0aW5nIGl0LgoKPiBJIGFsc28gcmVwcm9kdWNlZCB3aXRoIDUu
NS1yYzcsIGFuZCB3aWxsIGNoZWNrIDUuNi1yYzEgbGF0ZXIgdG9kYXkuIEkgCj4gY291bGRuJ3Qg
bmFycm93IGl0IGRvd24gZnVydGhlciBpbnRvIDUuNC1yYzEuCj4gSSBkb24ndCBrbm93IHNtbXUg
b3IgdGhlIGNvZGUgd2VsbCwgYW55IHRob3VnaHRzIG9uIHdoZXJlIHRvIHN0YXJ0IAo+IGRpZ2dp
bmcgaW50byB0aGlzPwo+IAo+IGZpbyB0ZXN0IHRoYXQgaXMgYmVpbmcgcnVuIGlzOgo+IAo+ICNm
aW8gLWZpbGVuYW1lPS9kZXYvbnZtZTBuMSAtaW9kZXB0aD02NCAtdGhyZWFkIC1ydz1yYW5kd3Jp
dGUgCj4gLWlvZW5naW5lPWxpYmFpbyAtYnM9NGsgLXJ1bnRpbWU9NDMyMDAgLXNpemU9LWdyb3Vw
X3JlcG9ydGluZyAKPiAtbmFtZT1teXRlc3QgLW51bWpvYnM9MzIKCkp1c3QgdG8gY2xhcmlmeSwg
ZG8gb3RoZXIgdGVzdHMgd29yayBPSyBvbiB0aGUgc2FtZSBkZXZpY2U/CgpUaGFua3MsClJvYmlu
LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
