Return-Path: <SRS0=oYak=EI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751E8C00A89
	for <iommu@archiver.kernel.org>; Mon,  2 Nov 2020 18:32:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C1C22245
	for <iommu@archiver.kernel.org>; Mon,  2 Nov 2020 18:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C1C22245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6C4E886CF8;
	Mon,  2 Nov 2020 18:32:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pQvk9DKO8NoX; Mon,  2 Nov 2020 18:32:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B827286C67;
	Mon,  2 Nov 2020 18:32:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB00DC088B;
	Mon,  2 Nov 2020 18:32:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D336C0051
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 18:32:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 540E886CBF
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 18:32:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p98t8QwGJfgT for <iommu@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 18:32:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7313086C67
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 18:32:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D34FD139F;
 Mon,  2 Nov 2020 10:32:20 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEF683F719;
 Mon,  2 Nov 2020 10:32:18 -0800 (PST)
Subject: Re: [PATCH v18 3/4] dt-bindings: arm-smmu: Add compatible string for
 Adreno GPU SMMU
From: Robin Murphy <robin.murphy@arm.com>
To: Jordan Crouse <jcrouse@codeaurora.org>, linux-arm-msm@vger.kernel.org
References: <20201102171416.654337-1-jcrouse@codeaurora.org>
 <20201102171416.654337-4-jcrouse@codeaurora.org>
 <77278507-a6be-8517-6f76-02a0ff588e39@arm.com>
Message-ID: <9409941f-366e-4dca-f49b-48eeff1ea248@arm.com>
Date: Mon, 2 Nov 2020 18:32:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <77278507-a6be-8517-6f76-02a0ff588e39@arm.com>
Content-Language: en-GB
Cc: Rob Clark <robdclark@chromium.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

T24gMjAyMC0xMS0wMiAxODoyMiwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjAtMTEtMDIg
MTc6MTQsIEpvcmRhbiBDcm91c2Ugd3JvdGU6Cj4+IEV2ZXJ5IFFjb20gQWRyZW5vIEdQVSBoYXMg
YW4gZW1iZWRkZWQgU01NVSBmb3IgaXRzIG93biB1c2UuIFRoZXNlCj4+IGRldmljZXMgZGVwZW5k
IG9uIHVuaXF1ZSBmZWF0dXJlcyBzdWNoIGFzIHNwbGl0IHBhZ2V0YWJsZXMsCj4+IGRpZmZlcmVu
dCBzdGFsbC9oYWx0IHJlcXVpcmVtZW50cyBhbmQgb3RoZXIgc2V0dGluZ3MuIElkZW50aWZ5IHRo
ZW0KPj4gd2l0aCBhIGNvbXBhdGlibGUgc3RyaW5nIHNvIHRoYXQgdGhleSBjYW4gYmUgaWRlbnRp
ZmllZCBpbiB0aGUKPj4gYXJtLXNtbXUgaW1wbGVtZW50YXRpb24gc3BlY2lmaWMgY29kZS4KPj4K
Pj4gU2lnbmVkLW9mZi1ieTogSm9yZGFuIENyb3VzZSA8amNyb3VzZUBjb2RlYXVyb3JhLm9yZz4K
Pj4gUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+Cj4+IFNpZ25lZC1v
ZmYtYnk6IFJvYiBDbGFyayA8cm9iZGNsYXJrQGNocm9taXVtLm9yZz4KPj4gUmV2aWV3ZWQtYnk6
IEJqb3JuIEFuZGVyc3NvbiA8Ympvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc+Cj4+IC0tLQo+Pgo+
PiDCoCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW9tbXUvYXJtLHNtbXUueWFt
bCB8IDkgKysrKysrKy0tCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvaW9tbXUvYXJtLHNtbXUueWFtbCAKPj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvaW9tbXUvYXJtLHNtbXUueWFtbAo+PiBpbmRleCA1MDMxNjBhN2I5YTAuLjNi
NjNmMmFlMjRkYiAxMDA2NDQKPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2lvbW11L2FybSxzbW11LnlhbWwKPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2lvbW11L2FybSxzbW11LnlhbWwKPj4gQEAgLTI4LDggKzI4LDYgQEAgcHJvcGVy
dGllczoKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGVudW06Cj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAtIHFjb20sbXNtODk5Ni1zbW11LXYyCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAtIHFjb20sbXNtODk5OC1zbW11LXYyCj4+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAtIHFjb20sc2M3MTgwLXNtbXUtdjIKPj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC0gcWNvbSxzZG04NDUtc21tdS12Mgo+IAo+IFdoYXQgYWJvdXQgdGhlICJBcHBz
IFNNTVUiIGluc3RhbmNlcz8gVGhvc2UgYXJlIGRpc3RpbmN0IGFuZCBkb24ndCAKPiBoYXZlL25l
ZWQgdGhlIEdQVSBzcGVjaWFsIGJlaGF2aW91ciwgcmlnaHQ/CgpPaCwgaGF2aW5nIGxvb2tlZCBh
dCBwYXRjaCAjNCwgd2hpY2ggcHJvbXB0ZWQgbWUgZ28gYW5kIGxvb2sgYXQgdGhlIDg0NSAKRFRT
SSBpbiBjb250ZXh0LCBub3cgSSByZWFsaXNlIHRoZSBzdWJ0bGV0eSBJIG92ZXJsb29rZWQuIFNv
IEkgZ3Vlc3MgaXQgCnJlYWxseSB3YXMgd29ydGggcmVzZW5kaW5nLCBoYSEgU29ycnkgZm9yIGJl
aW5nIHRoaWNrIDopCgpSZXZpZXdlZC1ieTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJt
LmNvbT4KCj4gCj4gUm9iaW4uCj4gCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBjb25zdDog
cWNvbSxzbW11LXYyCj4+IMKgwqDCoMKgwqDCoMKgIC0gZGVzY3JpcHRpb246IFFjb20gU29DcyBp
bXBsZW1lbnRpbmcgImFybSxtbXUtNTAwIgo+PiBAQCAtNDAsNiArMzgsMTMgQEAgcHJvcGVydGll
czoKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gcWNvbSxzbTgxNTAtc21tdS01
MDAKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gcWNvbSxzbTgyNTAtc21tdS01
MDAKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiBhcm0sbW11LTUwMAo+PiArwqDC
oMKgwqDCoCAtIGRlc2NyaXB0aW9uOiBRY29tIEFkcmVubyBHUFVzIGltcGxlbWVudGluZyAiYXJt
LHNtbXUtdjIiCj4+ICvCoMKgwqDCoMKgwqDCoCBpdGVtczoKPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oCAtIGVudW06Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIHFjb20sc2M3MTgwLXNt
bXUtdjIKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gcWNvbSxzZG04NDUtc21tdS12
Mgo+PiArwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29uc3Q6IHFjb20sYWRyZW5vLXNtbXUKPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiBxY29tLHNtbXUtdjIKPj4gwqDCoMKgwqDCoMKgwqAg
LSBkZXNjcmlwdGlvbjogTWFydmVsbCBTb0NzIGltcGxlbWVudGluZyAiYXJtLG1tdS01MDAiCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCBpdGVtczoKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGNv
bnN0OiBtYXJ2ZWxsLGFwODA2LXNtbXUtNTAwCj4+Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
