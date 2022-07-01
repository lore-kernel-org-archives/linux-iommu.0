Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1CACCA47B
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 16:13:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF69F83180;
	Fri,  1 Jul 2022 16:13:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF69F83180
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=qJk6VJJc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tfWszVnY3TI0; Fri,  1 Jul 2022 16:13:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 575EE83054;
	Fri,  1 Jul 2022 16:13:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 575EE83054
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B9BBC0032;
	Fri,  1 Jul 2022 16:13:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2B3DC002D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 16:13:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6A0CB61412
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 16:13:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6A0CB61412
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=qJk6VJJc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 60UalSTdtXgF for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 16:13:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB1BE613E4
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB1BE613E4
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 16:13:48 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id pk21so4950977ejb.2
 for <iommu@lists.linux-foundation.org>; Fri, 01 Jul 2022 09:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=fmpoE3SOxYGWE+UCHZpRNu+aOmNCjiBhQz/RLU3kMgM=;
 b=qJk6VJJcSU7isiM5qXM+sSU4s/LlKTET2BRCOqWrJIqxxh/i3lPC7pfHcyhMy+btU+
 g5n+l6B2zEXXP8cSrA9forQxxsIT41YfSI9xAlHmPO3yGqR/8H++2vtHX7XmJAnHlQD1
 9fNm5fDQV5+OonmZesiVvE4l5AUtWzvZ3ewhgmnsGL1nfMinckdK7NXALm7l2mCfo+oP
 rqLfeuNYXtDP3GOKQ09P/lcUObHjjfmsIZcFrLEY7rqGB0BaqD2lZaCFlt7MnY3d5MB4
 zox+hrKu84JY41U+bgJjNd4tRsqQ1qPSp1uIlMGJRPZ0Nf7YN+xKrcPMTIKqxyeoy7ZB
 n7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=fmpoE3SOxYGWE+UCHZpRNu+aOmNCjiBhQz/RLU3kMgM=;
 b=WMUMojwJea/QjlaaUaRo7BIgdOQYRXM7o/T845ah+nZ3VYNgn4MAsgmB0vaNhAbvxY
 JYO2xobshmIib2euPCPOHHsCUzXbLS3WY+OLMSPSBIo+qJDpUrCgx2c/lx3uJsdrBYGe
 qVIurYIDKzRcyp08e5SITE3ln/qEBeW3GKSz+iVQdGhvYKS2XgUCwY9Bwvd86sGsvpHN
 pfsyAixusgCC7Q9+n9RZnbBb0ZT9nkBRxF266mpNdvbTmeW8jBCFstAO79oeg/EbFvym
 BrK4Vwr4U7pVGIWTnjuauXerOfKO6Rko9qDxO0RWMeRI7YkB9FEJs8w11/1Zu5+ASLfa
 sFnQ==
X-Gm-Message-State: AJIora/kV6pbERgVWDf9EYqoM3dGWV2Amri91uFMyfSKXaF3ub+GmZaz
 ZS8HVC2ZSA49mdz8mDN+TAI=
X-Google-Smtp-Source: AGRyM1sz1O6/fl0Ea97Sugobh0As/pTf+zl7GKY+/4ILQ5LqMP8NXQlvG/BhAH8xe+n8+2hAfZwTNA==
X-Received: by 2002:a17:907:7f90:b0:726:e8ed:3c28 with SMTP id
 qk16-20020a1709077f9000b00726e8ed3c28mr15294148ejc.63.1656692027029; 
 Fri, 01 Jul 2022 09:13:47 -0700 (PDT)
Received: from [192.168.1.10] (adsl-146.37.6.170.tellas.gr. [37.6.170.146])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a1709060c0a00b0070beb9401d9sm10689704ejf.171.2022.07.01.09.13.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Jul 2022 09:13:46 -0700 (PDT)
Message-ID: <d74cb4e1-e504-75be-f46c-aac1115cdc55@gmail.com>
Date: Fri, 1 Jul 2022 19:13:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix undefined behavior in GBPA_UPDATE
Content-Language: en-US
To: Will Deacon <will@kernel.org>
References: <20220630063959.27226-1-burzalodowa@gmail.com>
 <20220701143401.GA28408@willie-the-truck>
From: xenia <burzalodowa@gmail.com>
In-Reply-To: <20220701143401.GA28408@willie-the-truck>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
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

T24gNy8xLzIyIDE3OjM0LCBXaWxsIERlYWNvbiB3cm90ZToKPiBPbiBUaHUsIEp1biAzMCwgMjAy
MiBhdCAwOTozOTo1OUFNICswMzAwLCBYZW5pYSBSYWdpYWRha291IHdyb3RlOgo+PiBUaGUgZXhw
cmVzc2lvbiAxIDw8IDMxIHJlc3VsdHMgaW4gdW5kZWZpbmVkIGJlaGF2aW91ciBiZWNhdXNlIHRo
ZSB0eXBlIG9mCj4+IGludGVnZXIgY29uc3RhbnQgMSBpcyAoc2lnbmVkKSBpbnQgYW5kIHRoZSBy
ZXN1bHQgb2Ygc2hpZnRpbmcgMSBieSAzMSBiaXRzCj4+IGlzIG5vdCByZXByZXNlbnRhYmxlIGlu
IHRoZSAoc2lnbmVkKSBpbnQgdHlwZS4KPj4KPj4gQ2hhbmdlIHRoZSB0eXBlIG9mIDEgdG8gdW5z
aWduZWQgaW50IGJ5IGFkZGluZyB0aGUgVSBzdWZmaXguCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFhl
bmlhIFJhZ2lhZGFrb3UgPGJ1cnphbG9kb3dhQGdtYWlsLmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVy
cy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuaCB8IDIgKy0KPj4gICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmggYi9kcml2ZXJzL2lv
bW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5oCj4+IGluZGV4IGNkNDg1OTBhZGEzMC4u
NDRmYmQ0OTllZGVhIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12
My9hcm0tc21tdS12My5oCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2Fy
bS1zbW11LXYzLmgKPj4gQEAgLTk2LDcgKzk2LDcgQEAKPj4gICAjZGVmaW5lIENSMl9FMkgJCQkJ
KDEgPDwgMCkKPj4gICAKPj4gICAjZGVmaW5lIEFSTV9TTU1VX0dCUEEJCQkweDQ0Cj4+IC0jZGVm
aW5lIEdCUEFfVVBEQVRFCQkJKDEgPDwgMzEpCj4+ICsjZGVmaW5lIEdCUEFfVVBEQVRFCQkJKDFV
IDw8IDMxKQo+IFRoZXJlIGFyZSBsb2FkcyBvZiB0aGVzZSBraWNraW5nIGFyb3VuZCBpbiB0aGUg
a2VybmVsIHNvdXJjZXMgYW5kIHdlIGNvbXBpbGUKPiB3aXRoIC1mbm8tc3RyaWN0LW92ZXJmbG93
Lgo+Cj4gSWYgeW91IHJlYWxseSB3YW50IHRvIGNoYW5nZSB0aGVzZSwgdGhlbiBsZXQncyB1c2Ug
dGhlIEJJVCgpIG1hY3JvIGluc3RlYWQsCj4gYnV0IEkgdGhpbmsgaXQncyByZWFsbHkganVzdCBj
aHVybi4KPgo+IFdpbGwKSGkgV2lsbCwKCkkgdGhvdWdodCB0aGF0IHNpbmNlIGluIGNvbW1pdCA1
ODdlNmMxMGE3Y2U4OWE1OTI0ZmRiZWZmMmVjNTI0ZmJkNmExMjRiIAp0aGVyZSB3YXMgYSBzaW1p
bGFyIGZpeCB0byBRX09WRVJGTE9XX0ZMQUcgKHNlZSBiZWxvdykKCi0tLSBhL2RyaXZlcnMvaW9t
bXUvYXJtLXNtbXUtdjMuYworKysgYi9kcml2ZXJzL2lvbW11L2FybS1zbW11LXYzLmMKQEAgLTE4
Myw3ICsxODMsNyBAQAoKIMKgI2RlZmluZSBRX0lEWChsbHEsIHApwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAoKHApICYgKCgxIDw8IAoobGxxKS0+bWF4X25fc2hpZnQpIC0gMSkp
CiDCoCNkZWZpbmUgUV9XUlAobGxxLCBwKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKChwKSAmICgxIDw8IChsbHEpLT5tYXhfbl9zaGlmdCkpCi0jZGVmaW5lIFFfT1ZFUkZMT1df
RkxBR8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDEgPDwg
MzEpCisjZGVmaW5lIFFfT1ZFUkZMT1dfRkxBR8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKDFVIDw8IDMxKQogwqAjZGVmaW5lIFFfT1ZGKHApwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKChwKSAmIFFfT1ZFUkZMT1dfRkxB
RykKIMKgI2RlZmluZSBRX0VOVChxLCBwKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICgocSktPmJhc2UgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFwKIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFFfSURYKCYoKHEpLT5sbHEpLCBwKSAqwqDCoMKg
wqDCoMKgwqAgXAoKdGhlbiBpdCB3b3VsZCBtYWtlIHNlbnNlIHRvIGZpeCBHQlBBX1VQREFURSBp
biB0aGUgc2FtZSB3YXkuCgpYZW5pYQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2lvbW11
