Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79019C43334
	for <iommu@archiver.kernel.org>; Fri, 17 Jun 2022 10:32:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F00656128E;
	Fri, 17 Jun 2022 10:32:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F00656128E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Q4Xq9nPe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F1FlFvrMSwWT; Fri, 17 Jun 2022 10:32:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 95703607C7;
	Fri, 17 Jun 2022 10:32:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 95703607C7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 617F1C0032;
	Fri, 17 Jun 2022 10:32:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65CADC0032
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 10:32:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C01B83E66
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 10:32:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C01B83E66
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=Q4Xq9nPe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jYpWS9KrSTau for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 10:32:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5785183E60
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5785183E60
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 10:32:46 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id o8so5208534wro.3
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 03:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=iA5EBcmQ2c66Y7u9KNeT7Oa6qN+dCkHMcbRicp+TCdo=;
 b=Q4Xq9nPeLmza0xBivwLO25heE+A+TUnj/WZPvFO68o9h13OrMKzYQU34eaB/Hf8ova
 5eSQfSwpIpry1VgIA5pqyLOYk2Q+gkVYx3MQkaC1vcPY4WXsm2ZkYOitNdtPH4UzowS0
 Whd7Vcpepoylf0ieasWfwAhwUtvyW2lhyCa/RB7vCgtCNs9Ul1oOqtx6tH4N6upnTtt7
 8/gNLXgCRVtuLvl+7bDjmAuMwGIC8O+ydxspWVNjjM8PJgxmVJIpzw9tjsoPRsztkSGZ
 bkQsN7fSCUXh1k8ZrjhW6so4sttZVALFkobi9njTL7p2VucNEXaRCQ6Ouq7jahxTMBbT
 gj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=iA5EBcmQ2c66Y7u9KNeT7Oa6qN+dCkHMcbRicp+TCdo=;
 b=SmRMo4UxtkZ9EZurK1O5DyS4Ec4VpLP7Gyd9Mxrn/XsOpqle25kj7MdaTpb5E83o43
 nFwci+XThzXxbYwcDFUoCldfpfnRn5u8byjXg5U6r8DOiCoX/qA4ecYcZ7WCR0xAoCQC
 CvjramTMXYKPKR8BzUaGRtRR7fFx6Or8Jk8exT7Q/Np1uuB2x88V7OjMIJ2HNppZYQf2
 cAvZubi8H9khdQgjvCHV+T0/G1/2D/HdlFfkvCkhhOoQg8QYe7yyQhy+ZkSpOWbdeTv2
 SZJVPrRgIaqqgLpd3wDdmsjP8IPtSSJ6Crezdvh59A1UjkkelFjero8WfHVq8/i/s/r4
 euLQ==
X-Gm-Message-State: AJIora+9nEHV5RLka0OXNttX0F3JyfpVv8S2YZ1AupDyaOno+kD8n/xu
 +fo9LFpfrWycb2TJ5lJ62cw=
X-Google-Smtp-Source: AGRyM1uYjq5wWC/zJtt6I45f6wFuWH7TuoP4yuwyBDBcRtSPi5ZO0u8mVAdeLwt9O7+QKkwBI1AHBg==
X-Received: by 2002:a5d:448c:0:b0:21a:91e9:b896 with SMTP id
 j12-20020a5d448c000000b0021a91e9b896mr2606677wrq.296.1655461964551; 
 Fri, 17 Jun 2022 03:32:44 -0700 (PDT)
Received: from [192.168.0.24] (80.174.78.229.dyn.user.ono.com. [80.174.78.229])
 by smtp.gmail.com with ESMTPSA id
 d8-20020adfc088000000b00213ba0cab3asm4269032wrf.44.2022.06.17.03.32.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jun 2022 03:32:43 -0700 (PDT)
Message-ID: <3c2ac364-5eaf-b26f-2f93-d4cd93b53828@gmail.com>
Date: Fri, 17 Jun 2022 12:32:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 6/6] iommu: mtk_iommu: Lookup phandle to retrieve
 syscon to pericfg
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 yong.wu@mediatek.com
References: <20220609100802.54513-1-angelogioacchino.delregno@collabora.com>
 <20220609100802.54513-7-angelogioacchino.delregno@collabora.com>
 <8b31b1d2-4ed7-11a1-2124-4641c8f3abcd@gmail.com>
 <e4a2c56e-8e38-b44c-04b4-fd792fbf2f74@collabora.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <e4a2c56e-8e38-b44c-04b4-fd792fbf2f74@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@linaro.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 krzysztof.kozlowski+dt@linaro.org, will@kernel.org,
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

CgpPbiAxNS8wNi8yMDIyIDE0OjI4LCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToK
PiBJbCAxNS8wNi8yMiAxNDowOSwgTWF0dGhpYXMgQnJ1Z2dlciBoYSBzY3JpdHRvOgo+Pgo+Pgo+
PiBPbiAwOS8wNi8yMDIyIDEyOjA4LCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToK
Pj4+IE9uIHNvbWUgU29DcyAob2Ygd2hpY2ggb25seSBNVDgxOTUgaXMgc3VwcG9ydGVkIGF0IHRo
ZSB0aW1lIG9mIHdyaXRpbmcpLAo+Pj4gdGhlICJSIiBhbmQgIlciIChJL08pIGVuYWJsZSBiaXRz
IGZvciB0aGUgSU9NTVVzIGFyZSBpbiB0aGUgcGVyaWNmZ19hbwo+Pj4gcmVnaXN0ZXIgc3BhY2Ug
YW5kIG5vdCBpbiB0aGUgSU9NTVUgc3BhY2U6IGFzIGl0IGhhcHBlbmVkIGFscmVhZHkgd2l0aAo+
Pj4gaW5mcmFjZmcsIGl0IGlzIGV4cGVjdGVkIHRoYXQgdGhpcyBsaXN0IHdpbGwgZ3Jvdy4KPj4+
Cj4+PiBJbnN0ZWFkIG9mIHNwZWNpZnlpbmcgcGVyaWNmZyBjb21wYXRpYmxlcyBvbiBhIHBlci1T
b0MgYmFzaXMsIGZvbGxvd2luZwo+Pj4gd2hhdCB3YXMgZG9uZSB3aXRoIGluZnJhY2ZnLCBsZXQn
cyBsb29rdXAgdGhlIHN5c2NvbiBieSBwaGFuZGxlIGluc3RlYWQuCj4+Pgo+Pj4gU2lnbmVkLW9m
Zi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gCj4+PiA8YW5nZWxvZ2lvYWNjaGluby5k
ZWxyZWdub0Bjb2xsYWJvcmEuY29tPgo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL2lvbW11L210a19p
b21tdS5jIHwgMjMgKysrKysrKysrKysrKy0tLS0tLS0tLS0KPj4+IMKgIDEgZmlsZSBjaGFuZ2Vk
LCAxMyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMKPj4+
IGluZGV4IDkwNjg1OTQ2ZmNiZS4uMGVhMDg0ODU4MWU5IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVy
cy9pb21tdS9tdGtfaW9tbXUuYwo+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYwo+
Pj4gQEAgLTEzOCw2ICsxMzgsOCBAQAo+Pj4gwqAgLyogUE0gYW5kIGNsb2NrIGFsd2F5cyBvbi4g
ZS5nLiBpbmZyYSBpb21tdSAqLwo+Pj4gwqAgI2RlZmluZSBQTV9DTEtfQU/CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIEJJVCgxNSkKPj4+IMKgICNkZWZpbmUgSUZBX0lPTU1VX1BDSUVfU1VQUE9SVMKg
wqDCoMKgwqDCoMKgIEJJVCgxNikKPj4+ICsvKiBJT01NVSBJL08gKHIvdykgaXMgZW5hYmxlZCB1
c2luZyBQRVJJQ0ZHX0lPTU1VXzEgcmVnaXN0ZXIgKi8KPj4+ICsjZGVmaW5lIEhBU19QRVJJX0lP
TU1VMV9SRUfCoMKgwqDCoMKgwqDCoCBCSVQoMTcpCj4+Cj4+IMKgRnJvbSB3aGF0IEkgY2FuIHNl
ZSBNVEtfSU9NTVVfVFlQRV9JTkZSQSBpcyBvbmx5IHNldCBpbiBNVDgxOTUgd2hpY2ggdXNlcyAK
Pj4gcGVyaWNmZy4gU28gd2UgZG9uJ3QgbmVlZCBhIG5ldyBmbGFnIGhlcmUuIEZvciBtZSB0aGUg
ZmxhZyBuYW1lIAo+PiBNVEtfSU9NTVVfVFlQRV9JTkZSQSB3YXMgY29uZnVzaW5nIGFzIGl0IGhh
cyBub3RoaW5nIHRvIGRvIHdpdGggdGhlIHVzZSBvZiAKPj4gaW5mcmFjZmcuIEknbGwgaGlqYWNr
IHRoaXMgcGF0Y2ggdG8gcHJvdmlkZSBzb21lIGZlZWRiYWNrIG9uIHRoZSBhY3R1YWwgY29kZSwg
Cj4+IHBsZWFzZSBzZWUgYmVsb3cuCj4+Cj4+PiDCoCAjZGVmaW5lIE1US19JT01NVV9IQVNfRkxB
R19NQVNLKHBkYXRhLCBfeCwgbWFzaynCoMKgwqAgXAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAoKCgocGRhdGEpLT5mbGFncykgJiAobWFzaykpID09IChfeCkpCj4+PiBA
QCAtMTg3LDcgKzE4OSw2IEBAIHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIHsKPj4+IMKgwqDC
oMKgwqAgdTMywqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmbGFnczsKPj4+IMKgwqDCoMKgwqAgdTMy
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnZfc2VsX3JlZzsKPj4+IC3CoMKgwqAgY2hhcsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKnBlcmljZmdfY29tcF9zdHI7Cj4+PiDCoMKgwqDCoMKgIHN0cnVj
dCBsaXN0X2hlYWTCoMKgwqAgKmh3X2xpc3Q7Cj4+PiDCoMKgwqDCoMKgIHVuc2lnbmVkIGludMKg
wqDCoMKgwqDCoMKgIGlvdmFfcmVnaW9uX25yOwo+Pj4gwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3Qg
bXRrX2lvbW11X2lvdmFfcmVnaW9uwqDCoMKgICppb3ZhX3JlZ2lvbjsKPj4+IEBAIC0xMjE4LDE0
ICsxMjE5LDE2IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dF9ydW50
aW1lX2Rpc2FibGU7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4gwqDCoMKgwqDCoCB9IGVs
c2UgaWYgKE1US19JT01NVV9JU19UWVBFKGRhdGEtPnBsYXRfZGF0YSwgTVRLX0lPTU1VX1RZUEVf
SU5GUkEpICYmCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGF0YS0+cGxhdF9kYXRhLT5wZXJp
Y2ZnX2NvbXBfc3RyKSB7Cj4+Cj4+IENoZWNrIGZvciBwZXJpY2ZnX2NvbXBfc3RyIGlzIG5vdCBu
ZWVkZWQsIHdlIG9ubHkgaGF2ZSBvbmUgcGxhdGZvcm0gdGhhdCB1c2VzIAo+PiBNVEtfSU9NTVVf
VFlQRV9JTkZSQS4KPj4KPiAKPiBGYWlyIGVub3VnaC4gSSBhZ3JlZS4KPiAKPj4+IC3CoMKgwqDC
oMKgwqDCoCBpbmZyYWNmZyA9IAo+Pj4gc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfY29tcGF0aWJs
ZShkYXRhLT5wbGF0X2RhdGEtPnBlcmljZmdfY29tcF9zdHIpOwo+Pgo+PiBXZSBjYW4gZG8gc29t
ZXRoaW5nIGxpa2UgdGhpcyB0byBtYWtlIHRoZSBjb2RlIGNsZWFyZXI6Cj4+IGRhdGEtPnBlcmlj
ZmcgPSAKPj4gc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfY29tcGF0aWJsZShkYXRhLT5wbGF0X2Rh
dGEtPnBlcmljZmdfY29tcF9zdHIpOwo+PiDCoMKgwqDCoMKgwqDCoMKgIGlmIChJU19FUlIoZGF0
YS0+cGVyaWNmZykpIHsKPj4KPj4gVXNpbmcgaW5mcmFjZmcgdmFyaWFibGUgaGVyZSBpcyBjb25m
dXNpbmcgYXMgaXQgaGFzIG5vdGhpbmcgdG8gZG8gd2l0aCAKPj4gaW5mcmFjZmcgdXNlZCB3aXRo
IEhBU180R0JfTU9ERSBmbGFnLgo+IAo+IFllcyBNYXR0aGlhcywgdXNpbmcgdGhlIGluZnJhY2Zn
IHZhcmlhYmxlIGlzIGNvbmZ1c2luZyAtIHRoYXQncyB3aHkgSSBjaGFuZ2VkIHRoYXQKPiBhbHJl
YWR5Li4uLgo+IAo+Pgo+PiBSZWdhcmRzLAo+PiBNYXR0aGlhcwo+Pgo+Pj4gLcKgwqDCoMKgwqDC
oMKgIGlmIChJU19FUlIoaW5mcmFjZmcpKSB7Cj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXQgPSBQVFJfRVJSKGluZnJhY2ZnKTsKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8g
b3V0X3J1bnRpbWVfZGlzYWJsZTsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCBNVEtfSU9NTVVf
SEFTX0ZMQUcoZGF0YS0+cGxhdF9kYXRhLCBIQVNfUEVSSV9JT01NVTFfUkVHKSkgewo+IAo+IAo+
IAo+Pj4gK8KgwqDCoMKgwqDCoMKgIGRhdGEtPnBlcmljZmcgPSBzeXNjb25fcmVnbWFwX2xvb2t1
cF9ieV9waGFuZGxlKGRldi0+b2Zfbm9kZSwgCj4+PiAibWVkaWF0ZWsscGVyaWNmZyIpOwo+IAo+
IC4uLi5IZXJlLCB3aGVyZSBJJ20gYXNzaWduaW5nIGRpcmVjdGx5IHRvIGRhdGEtPnBlcmljZmcg
Oi1QCj4gCgpVdXV1cHMsIHNvcnJ5LCBkaWQgbG9vayB0b28gbXVjaCBvbiB0aGUgZXhpc3Rpbmcg
Y29kZSBhbmQgbm90IGVub3VnaCBvbiB5b3VyIHBhdGNoLgoKPiBCeSB0aGUgd2F5LCBzaW5jZSBp
dCB3YXMgb25seSBhYm91dCBvbmUgcGxhdGZvcm0sIG15IGludGVudGlvbiB3YXMgdG8gcmVtb3Zl
IHRoZQo+IHBlcmljZmdfY29tcF9zdHIgZnJvbSBzdHJ1Y3QgaW9tbXVfcGxhdF9kYXRhIChhcyB5
b3UgY2FuIHNlZSksIGJ1dCB0aGVuLCB3aXRoIHRoZQo+IGN1cnJlbnQgY29kZSwgSSBoYWQgdG8g
YXNzaWduIC4uLi4uCj4gCj4gCj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKElTX0VSUihkYXRhLT5w
ZXJpY2ZnKSkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcCA9ICJtZWRpYXRlayxtdDgx
OTUtcGVyaWNmZ19hbyI7Cj4gCj4gLi4udGhlIHN0cmluZyB0byAncCcsIGJlY2F1c2Ugb3RoZXJ3
aXNlIGl0IHdvdWxkIGdvIG92ZXIgMTAwIGNvbHVtbnMuCj4gCj4gSW4gYW55IGNhc2UsIEkganVz
dCBjaGVja2VkIGFuZCwgYXBwYXJlbnRseSwgTVQ4MTk1IGlzIHJlYWxseSB0aGUgb25lIGFuZCBv
bmx5IFNvQwo+IHRoYXQgbmVlZHMgdGhpcyBwZXJpY2ZnIHJlZ2lzdGVyIHRvIGJlIG1hbmFnZWQg
YnkgTGludXguLi4gZXZlbiB0aGUgbGF0ZXN0IGFuZAo+IGdyZWF0ZXN0IHNtYXJ0cGhvbmUgY2hp
cCAoRGltZW5zaXR5IDkwMDAsIE1UNjk4MykgZG9lc24ndCBuZWVkIHRoaXMgKGF0IGxlYXN0LAo+
IGZyb20gd2hhdCBJIGNhbiByZWFkIG9uIGEgZG93bnN0cmVhbSBrZXJuZWwpLgo+IAo+IE9uIGFu
IGFmdGVydGhvdWdodCwgcGVyaGFwcyB0aGUgYmVzdCBpZGVhIGlzIHRvIGp1c3QgbGVhdmUgdGhp
cyBhcyBpdCBpcyBhbmQsIGFzCj4geW91IHByb3Bvc2VkLCBhdm9pZCB1c2luZyB0aGF0IGNvbmZ1
c2luZyBpbmZyYWNmZyB2YXJpYWJsZSwgd2l0aG91dCBhZGRpbmcgdGhlCj4gcGVyaWNmZyBoYW5k
bGUgYXQgYWxsLgoKRWl0aGVyIHRoaXMgb3IgZ2V0IGFsc28gcmlkIG9mIHRoZSBwZXJpY2ZnX2Nv
bXBfc3RyIGluIHRoZSBfcGxhdF9kYXRhLiBJJ20gCnVuZW1vdGlvbmFsIGFib3V0IHRoaXMgOikK
ClJlZ2FyZHMsCk1hdHRoaWFzCgo+IAo+IEFmdGVyIGFsbCwgaXQncyBqdXN0IG9uZSBzaW5nbGUg
U29DLgo+IAo+IEknbGwgc2VuZCBhIG5ldyB2ZXJzaW9uIHNvb24hCj4gCj4gQ2hlZXJzLAo+IEFu
Z2Vsbwo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
