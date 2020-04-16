Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADF0C2BB85
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 10:11:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49CBB21D92
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 10:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CBB21D92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 35DF086169;
	Thu, 16 Apr 2020 10:11:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QP-P9Z-PE1G7; Thu, 16 Apr 2020 10:11:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EEEF685F81;
	Thu, 16 Apr 2020 10:11:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6D65C1AE8;
	Thu, 16 Apr 2020 10:11:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AF8EC0172
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 10:11:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 073DE8758F
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 10:11:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yGeCBGt63Acu for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 10:11:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from cmccmta3.chinamobile.com (cmccmta3.chinamobile.com
 [221.176.66.81])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8D32D8488D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 10:11:30 +0000 (UTC)
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by
 rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb5e982f35040-842ae;
 Thu, 16 Apr 2020 18:11:01 +0800 (CST)
X-RM-TRANSID: 2eeb5e982f35040-842ae
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.20.145.111] (unknown[112.25.154.146])
 by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25e982f3465a-49ba9;
 Thu, 16 Apr 2020 18:11:01 +0800 (CST)
X-RM-TRANSID: 2ee25e982f3465a-49ba9
Subject: Re: [PATCH] iommu/qcom:fix local_base status check
To: Robin Murphy <robin.murphy@arm.com>, agross@kernel.org,
 bjorn.andersson@linaro.org, robdclark@gmail.com
References: <20200402063302.20640-1-tangbin@cmss.chinamobile.com>
 <7f8cadbf-2568-19f5-610f-6ae7d9846ec6@arm.com>
From: Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <252fecfd-28bc-7331-c17e-70032cdb980e@cmss.chinamobile.com>
Date: Thu, 16 Apr 2020 18:12:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7f8cadbf-2568-19f5-610f-6ae7d9846ec6@arm.com>
Content-Language: en-US
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

Ck9uIDIwMjAvNC8xNiAxODowNSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjAtMDQtMDIg
NzozMyBhbSwgVGFuZyBCaW4gd3JvdGU6Cj4+IFJlbGVhc2UgcmVzb3VyY2VzIHdoZW4gZXhpdGlu
ZyBvbiBlcnJvci4KPj4KPj4gU2lnbmVkLW9mZi1ieTogVGFuZyBCaW4gPHRhbmdiaW5AY21zcy5j
aGluYW1vYmlsZS5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2lvbW11L3Fjb21faW9tbXUuYyB8
IDUgKysrKy0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9xY29tX2lvbW11LmMgYi9kcml2
ZXJzL2lvbW11L3Fjb21faW9tbXUuYwo+PiBpbmRleCA0MzI4ZGEwYjAuLmMwOGFhOTY1MSAxMDA2
NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9xY29tX2lvbW11LmMKPj4gKysrIGIvZHJpdmVycy9p
b21tdS9xY29tX2lvbW11LmMKPj4gQEAgLTgxMyw4ICs4MTMsMTEgQEAgc3RhdGljIGludCBxY29t
X2lvbW11X2RldmljZV9wcm9iZShzdHJ1Y3QgCj4+IHBsYXRmb3JtX2RldmljZSAqcGRldikKPj4g
wqDCoMKgwqDCoCBxY29tX2lvbW11LT5kZXYgPSBkZXY7Cj4+IMKgIMKgwqDCoMKgwqAgcmVzID0g
cGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsKPj4gLcKgwqDC
oCBpZiAocmVzKQo+PiArwqDCoMKgIGlmIChyZXMpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHFj
b21faW9tbXUtPmxvY2FsX2Jhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOwo+
PiArwqDCoMKgwqDCoMKgwqAgaWYgKElTX0VSUihxY29tX2lvbW11LT5sb2NhbF9iYXNlKSkKPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFBUUl9FUlIocWNvbV9pb21tdS0+bG9jYWxf
YmFzZSk7Cj4+ICvCoMKgwqAgfQo+Cj4gLi4ub3IganVzdCB1c2UgZGV2bV9wbGF0Zm9ybV9pb3Jl
bWFwX3Jlc291cmNlKCkgdG8gbWFrZSB0aGUgd2hvbGUgCj4gdGhpbmcgc2ltcGxlci4KWWVzLCBJ
IHdhcyBnb2luZyB0byBzaW1wbGlmeSB0aGUgY29kZSBoZXJlLCBidXQgc3RhdHVzIGNoZWNrIGlz
IHN0aWxsIApyZXF1aXJlZC4KClNvIEknbSB3YWl0aW5nLgoKVGhhbmtzLAoKVGFuZyBCaW4KCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
