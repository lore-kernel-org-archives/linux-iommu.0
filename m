Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2F2C4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 17:15:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EC51610FD
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 17:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5EC51610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 27DD1404F2;
	Thu,  5 Aug 2021 17:15:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T5gxdKqRts2L; Thu,  5 Aug 2021 17:15:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 31CC8400D0;
	Thu,  5 Aug 2021 17:15:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3731C001A;
	Thu,  5 Aug 2021 17:15:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBA50C000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 17:15:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D9345400D0
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 17:15:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ObFrChy2L8wi for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 17:14:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A04740003
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 17:14:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1D4D1042;
 Thu,  5 Aug 2021 10:14:58 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EEA13F66F;
 Thu,  5 Aug 2021 10:14:57 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu-v3: Remove some unneeded init in
 arm_smmu_cmdq_issue_cmdlist()
To: John Garry <john.garry@huawei.com>, will@kernel.org
References: <1624293394-202509-1-git-send-email-john.garry@huawei.com>
 <ee1f3ab5-3acc-f442-f2d2-898cf88bc447@arm.com>
 <45a8af4f-4202-ecd8-0882-507acf9b2eb2@huawei.com>
 <577a625a-4fc5-7402-8e4f-4e0e5be93144@arm.com>
 <44c5e07b-e663-5b96-a142-ec25666e2a14@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <2af4315a-c02a-2185-93a2-b07a891314a6@arm.com>
Date: Thu, 5 Aug 2021 18:14:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <44c5e07b-e663-5b96-a142-ec25666e2a14@huawei.com>
Content-Language: en-GB
Cc: linuxarm@huawei.com, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

T24gMjAyMS0wOC0wNSAxNjoxNiwgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAwNS8wOC8yMDIxIDE1
OjQxLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+PiBJIHN1cHBvc2UgdGhleSBjb3VsZCBiZSBjb21i
aW5lZCBpbnRvIGEgc21hbGxlciBzdWItc3RydWN0IGFuZCBsb2FkZWQgCj4+PiBpbiBhIHNpbmds
ZSBvcGVyYXRpb24sIGJ1dCBpdCBsb29rcyBtZXNzeSwgYW5kIHByb2Igd2l0aG91dCBtdWNoIGdh
aW4uCj4+Cj4+IEluZGVlZCBJIHdvdWxkbid0IHNheSB0aGF0IHNhdmluZyBtZW1vcnkgaXMgdGhl
IHByaW1hcnkgY29uY2VybiBoZXJlLCAKPj4gYW5kIGFueSBtb3JlIGNvbnZvbHV0ZWQgY29kZSBp
cyBoYXJkbHkgZ29pbmcgdG8gaGVscCBwZXJmb3JtYW5jZS4gUGx1cyAKPj4gaXQgc3RpbGwgd291
bGRuJ3QgaGVscCB0aGUgb3RoZXIgY2FzZXMgd2hlcmUgd2UncmUganVzdCBjb3B5aW5nIHRoZSAK
Pj4gc2l6ZSBpbnRvIGEgZmFrZSBxdWV1ZSB0byBkbyBzb21lIHByb2QgYXJpdGhtZXRpYyAtIEkg
aGFkbid0IGZ1bGx5IAo+PiBjbG9ja2VkIHdoYXQgd2FzIGdvaW5nIG9uIHRoZXJlIHdoZW4gSSBz
a2ltbWVkIHRocm91Z2ggdGhpbmdzIGVhcmxpZXIuCj4+Cj4+IERpc3JlZ2FyZGluZyB0aGUgYm9n
dXMgbGF5b3V0IGNoYW5nZSwgdGhvdWdoLCBkbyB5b3UgcmVja29uIHRoZSByZXN0IAo+PiBvZiBt
eSBpZGVhIG1ha2VzIHNlbnNlPwo+IAo+IEkgdHJpZWQgdGhlIHNpbWlsYXIgY2hhbmdlIHRvIGF2
b2lkIHplcm8taW5pdCB0aGUgcGFkZGluZyBpbiAKPiBhcm1fc21tdV9jbWRxX3dyaXRlX2VudHJp
ZXMoKSBhbmQgdGhlIAo+IF9hcm1fc21tdV9jbWRxX3BvbGxfc2V0X3ZhbGlkX21hcCgpLCBidXQg
dGhlIGRpc2Fzc2VtYmx5IHdhcyB0aGUgc2FtZS4gCj4gU28gdGhlIGNvbXBpbGVyIG11c3QgaGF2
ZSBnb3Qgc21hcnQgdGhlcmUuCgpZZWFoLCBpbiBteSBidWlsZCBfX2FybV9zbW11X2NtZHFfcG9s
bF9zZXRfdmFsaWRfbWFwKCkgb25seSB1c2VzIDMyIApieXRlcyBvZiBzdGFjaywgc28gY2xlYXJs
eSBpdCdzIG1hbmFnZWQgdG8gc2VlIHRocm91Z2ggdGhlIG1hY3JvIG1hZ2ljIApvbmNlIHF1ZXVl
X2luY19wcm9kX24oKSBpcyBpbmxpbmVkIGFuZCBlbGlkZSB0aGUgd2hvbGUgc3RydWN0LiAKYXJt
X3NtbXVfY21kcV93cml0ZV9lbnRyaWVzKCkgaXMgaW5saW5lZCBhbHJlYWR5LCBidXQgbG9naWNh
bGx5IG11c3QgYmUgCnRoZSBzYW1lIGRlYWwgc2luY2UgaXQncyBhIHNpbWlsYXJseSBpbmxpbmVk
IHF1ZXVlX2luY19wcm9kX24oKS4KCkhvd2V2ZXIsIHRoYXQgbWF5IGFsbCBjaGFuZ2UgaWYgZGlm
ZmVyZW50IGNvbXBpbGVyIGZsYWdzIG9yIGEgZGlmZmVyZW50IApjb21waWxlciBsZWFkIHRvIGRp
ZmZlcmVudCBpbmxpbmluZyBkZWNpc2lvbnMsIHNvIEknZCBhcmd1ZSB0aGF0IGlmIHRoaXMgCmNh
biBtYXR0ZXIgYW55d2hlcmUgdGhlbiBpdCdzIHdvcnRoIHRyZWF0aW5nIGNvbnNpc3RlbnRseSBl
dmVyeXdoZXJlLgoKPiBCdXQgZm9yIHRoZSBvcmlnaW5hbCBjaGFuZ2UgaW4gdGhpcyBwYXRjaCwg
aXQgZGlkIG1ha2UgYSBkaWZmZXJlbmNlLiAKPiBJdCdzIG5pY2UgdG8gcmVtb3ZlIHdoYXQgd2Fz
IGEgbWVtY3B5Ogo+IAo+ICDCoMKgwqAgMTc3MDogYTkwNzdlZmYgc3RwIHh6ciwgeHpyLCBbeDIz
LCAjMTEyXQo+IH0sIGhlYWQgPSBsbHE7Cj4gIMKgwqDCoCAxNzc0OiA5NDAwMDAwMCBibCAwIDxt
ZW1jcHk+Cj4gCj4gQW5kIHBlcmZvcm1hbmNlIHdhcyB2ZXJ5IGZyYWN0aW9uYWxseSBiZXR0ZXIu
CgpIZWgsIG1pbmUgd2FzIHRoaXMgYmVhdXR5OgoKICAgICAgICAgc3RydWN0IGFybV9zbW11X2xs
X3F1ZXVlIGxscSA9IHsKICAgICAxN2Q0OiAgICAgICBhOTAxN2Y3ZiAgICAgICAgc3RwICAgICB4
enIsIHh6ciwgW3gyNywgIzE2XQogICAgIDE3ZDg6ICAgICAgIGE5MDI3ZjdmICAgICAgICBzdHAg
ICAgIHh6ciwgeHpyLCBbeDI3LCAjMzJdCiAgICAgMTdkYzogICAgICAgYTkwMzdmN2YgICAgICAg
IHN0cCAgICAgeHpyLCB4enIsIFt4MjcsICM0OF0KICAgICAxN2UwOiAgICAgICBhOTA0N2Y3ZiAg
ICAgICAgc3RwICAgICB4enIsIHh6ciwgW3gyNywgIzY0XQogICAgICAgICB9LCBoZWFkID0gbGxx
OwogICAgIDE3ZTQ6ICAgICAgIGI5MDBjMzQwICAgICAgICBzdHIgICAgIHcwLCBbeDI2LCAjMTky
XQp7CiAgICAgMTdlODogICAgICAgMjkwZDBiZTEgICAgICAgIHN0cCAgICAgdzEsIHcyLCBbc3As
ICMxMDRdCiAgICAgICAgIH0sIGhlYWQgPSBsbHE7CiAgICAgMTdlYzogICAgICAgYTk0NDBmNjIg
ICAgICAgIGxkcCAgICAgeDIsIHgzLCBbeDI3LCAjNjRdCiAgICAgMTdmMDogICAgICAgYTkwMDdm
NWYgICAgICAgIHN0cCAgICAgeHpyLCB4enIsIFt4MjZdCiAgICAgMTdmNDogICAgICAgYTkwMTdm
NWYgICAgICAgIHN0cCAgICAgeHpyLCB4enIsIFt4MjYsICMxNl0KICAgICAxN2Y4OiAgICAgICBh
OTAyN2Y1ZiAgICAgICAgc3RwICAgICB4enIsIHh6ciwgW3gyNiwgIzMyXQogICAgIDE3ZmM6ICAg
ICAgIGE5MDM3ZjVmICAgICAgICBzdHAgICAgIHh6ciwgeHpyLCBbeDI2LCAjNDhdCiAgICAgMTgw
MDogICAgICAgYTkwNDBmNDIgICAgICAgIHN0cCAgICAgeDIsIHgzLCBbeDI2LCAjNjRdCiAgICAg
ICAgIHN0cnVjdCBhcm1fc21tdV9sbF9xdWV1ZSBsbHEgPSB7CiAgICAgMTgwNDogICAgICAgYTkw
NTdmN2YgICAgICAgIHN0cCAgICAgeHpyLCB4enIsIFt4MjcsICM4MF0KICAgICAgICAgfSwgaGVh
ZCA9IGxscTsKICAgICAxODA4OiAgICAgICBhOTA1N2Y1ZiAgICAgICAgc3RwICAgICB4enIsIHh6
ciwgW3gyNiwgIzgwXQogICAgICAgICBzdHJ1Y3QgYXJtX3NtbXVfbGxfcXVldWUgbGxxID0gewog
ICAgIDE4MGM6ICAgICAgIGE5MDY3ZjdmICAgICAgICBzdHAgICAgIHh6ciwgeHpyLCBbeDI3LCAj
OTZdCiAgICAgICAgIH0sIGhlYWQgPSBsbHE7CiAgICAgMTgxMDogICAgICAgYTkwNjdmNWYgICAg
ICAgIHN0cCAgICAgeHpyLCB4enIsIFt4MjYsICM5Nl0KICAgICAgICAgc3RydWN0IGFybV9zbW11
X2xsX3F1ZXVlIGxscSA9IHsKICAgICAxODE0OiAgICAgICBhOTA3N2Y3ZiAgICAgICAgc3RwICAg
ICB4enIsIHh6ciwgW3gyNywgIzExMl0KICAgICAgICAgfSwgaGVhZCA9IGxscTsKICAgICAxODE4
OiAgICAgICBhOTA3N2Y1ZiAgICAgICAgc3RwICAgICB4enIsIHh6ciwgW3gyNiwgIzExMl0KICAg
ICAgICAgc3RydWN0IGFybV9zbW11X2xsX3F1ZXVlIGxscSA9IHsKICAgICAxODFjOiAgICAgICBh
OTA4N2Y1ZiAgICAgICAgc3RwICAgICB4enIsIHh6ciwgW3gyNiwgIzEyOF0KCj4gQXMgZm9yIHBy
ZS1ldmFsdWF0aW5nICJuZW50cyIsIEknbSBub3Qgc3VyZSBob3cgbXVjaCB0aGF0IGNhbiBoZWxw
LCBidXQgCj4gSSBhbSBub3QgdG9vIG9wdGltaXN0aWMuIEkgY2FuIHRyeSBzb21lIHRlc3Rpbmcg
d2hlbiBJIGdldCBhIGNoYW5jZS4gCj4gSGF2aW5nIHNhaWQgdGhhdCwgSSB3b3VsZCBuZWVkIHRv
IGNoZWNrIHRoZSBkaXNhc3NlbWJseSBhbHNvLgoKSXQnbGwganVzdCB0dXJuIE1PVixMRFIsTFNM
IHNlcXVlbmNlcyBpbnRvIHBsYWluIExEUnMgLSBhIHNtYWxsIHNhdmluZyAKYnV0IHdpdGggbm8g
cmVhbCBkb3duc2lkZSwgYW5kIGEgdGhpcmQgb2YgaXQgaXMgaW4gdGhlIHBsYWNlIHdoZXJlIGRv
aW5nIApsZXNzIHdvcmsgbWF0dGVycyBtb3N0OgoKYWRkL3JlbW92ZTogMC8wIGdyb3cvc2hyaW5r
OiAwLzggdXAvZG93bjogMC8tMTAwICgtMTAwKQpGdW5jdGlvbiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBvbGQgICAgIG5ldyAgIGRlbHRhCmFybV9zbW11X3ByaXFfdGhyZWFk
ICAgICAgICAgICAgICAgICAgICAgICAgIDUzMiAgICAgNTI4ICAgICAgLTQKYXJtX3NtbXVfZXZ0
cV90aHJlYWQgICAgICAgICAgICAgICAgICAgICAgICAgMzY4ICAgICAzNjQgICAgICAtNAphcm1f
c21tdV9kZXZpY2VfcHJvYmUgICAgICAgICAgICAgICAgICAgICAgIDQ1NjQgICAgNDU1NiAgICAg
IC04Cl9fYXJtX3NtbXVfY21kcV9wb2xsX3NldF92YWxpZF9tYXAuaXNyYSAgICAgIDMxNiAgICAg
MzA4ICAgICAgLTgKYXJtX3NtbXVfaW5pdF9vbmVfcXVldWUuaXNyYSAgICAgICAgICAgICAgICAg
MzIwICAgICAzMDggICAgIC0xMgpxdWV1ZV9yZW1vdmVfcmF3ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAxOTIgICAgIDE3NiAgICAgLTE2CmFybV9zbW11X2dlcnJvcl9oYW5kbGVyICAgICAg
ICAgICAgICAgICAgICAgIDc1MiAgICAgNzM2ICAgICAtMTYKYXJtX3NtbXVfY21kcV9pc3N1ZV9j
bWRsaXN0ICAgICAgICAgICAgICAgICAxODEyICAgIDE3ODAgICAgIC0zMgpUb3RhbDogQmVmb3Jl
PTIzNzc2LCBBZnRlcj0yMzY3NiwgY2hnIC0wLjQyJQoKClJvYmluLgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
