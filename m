Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C56CC352BE
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 06:41:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F94D206D6
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 06:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F94D206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CCFCB8798A;
	Thu, 16 Apr 2020 06:41:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j72z8LDcP1k8; Thu, 16 Apr 2020 06:41:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AA7E487941;
	Thu, 16 Apr 2020 06:41:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91498C1AE8;
	Thu, 16 Apr 2020 06:41:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E5C5C0172
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 06:41:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4A5EC86E68
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 06:41:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2q39LCTIjOw3 for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 06:41:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from cmccmta1.chinamobile.com (cmccmta1.chinamobile.com
 [221.176.66.79])
 by whitealder.osuosl.org (Postfix) with ESMTP id B307A86E18
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 06:41:01 +0000 (UTC)
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by
 rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35e97fddbd0a-7cff8;
 Thu, 16 Apr 2020 14:40:28 +0800 (CST)
X-RM-TRANSID: 2ee35e97fddbd0a-7cff8
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.20.145.111] (unknown[112.25.154.146])
 by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee75e97fdda580-29be2;
 Thu, 16 Apr 2020 14:40:28 +0800 (CST)
X-RM-TRANSID: 2ee75e97fdda580-29be2
Subject: Re: [PATCH] iommu/qcom:fix local_base status check
To: Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20200402063302.20640-1-tangbin@cmss.chinamobile.com>
 <20200402064552.GG663905@yoga>
From: Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <7a565c74-f223-83da-cf32-0474be6c9460@cmss.chinamobile.com>
Date: Thu, 16 Apr 2020 14:42:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200402064552.GG663905@yoga>
Content-Language: en-US
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, agross@kernel.org
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

SGkgQmpvcm46CgpPbiAyMDIwLzQvMiAxNDo0NSwgQmpvcm4gQW5kZXJzc29uIHdyb3RlOgo+IE9u
IFdlZCAwMSBBcHIgMjM6MzMgUERUIDIwMjAsIFRhbmcgQmluIHdyb3RlOgo+Cj4+IFJlbGVhc2Ug
cmVzb3VyY2VzIHdoZW4gZXhpdGluZyBvbiBlcnJvci4KPj4KPiBSZXZpZXdlZC1ieTogQmpvcm4g
QW5kZXJzc29uIDxiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZz4KClRoYW5rcyBmb3IgeW91ciBw
b3NpdGl2ZSBmZWVkYmFjay4KCkkgZG9uJ3Qga25vdyB3aGV0aGVyIHRoZSBjb21taXQgbWVzc2Fn
ZSBhZmZlY3QgdGhpcyBwYXRjaCdzIHJlc3VsdC4gSWYgCnNvLCBJIHRoaW5rIHRoZSBjb21taXQg
bWVzc2FnZSBuZWVkIG1vcmUgY2xhcmlmaWNhdGlvbi4gQXMgZm9sbHdvczoKCiDCoMKgwqDCoMKg
wqDCoCBUaGUgZnVuY3Rpb24gcWNvbV9pb21tdV9kZXZpY2VfcHJvYmUoKSBkb2VzIG5vdCBwZXJm
b3JtIApzdWZmaWNpZW50IGVycm9yIGNoZWNraW5nIGFmdGVyIGV4ZWN1dGluZyBkZXZtX2lvcmVt
YXBfcmVzb3VyY2UoKSwgd2hpY2ggCmNhbiByZXN1bHQgaW4gY3Jhc2hlcyBpZiBhIGNyaXRpY2Fs
IGVycm9yIHBhdGggaXMgZW5jb3VudGVyZWQuCgpGaXhlczogMGFlMzQ5YTAoImlvbW11L3Fjb206
IEFkZCBxY29tX2lvbW11IikKCgpJJ20gd2FpdGluZyBmb3IgeW91ciByZXBseSBhY3RpdmVseS4K
ClRoYW5rcywKClRhbmcgQmluCgoKPgo+PiBTaWduZWQtb2ZmLWJ5OiBUYW5nIEJpbiA8dGFuZ2Jp
bkBjbXNzLmNoaW5hbW9iaWxlLmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVycy9pb21tdS9xY29tX2lv
bW11LmMgfCA1ICsrKystCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9xY29tX2lvbW11LmMg
Yi9kcml2ZXJzL2lvbW11L3Fjb21faW9tbXUuYwo+PiBpbmRleCA0MzI4ZGEwYjAuLmMwOGFhOTY1
MSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9xY29tX2lvbW11LmMKPj4gKysrIGIvZHJp
dmVycy9pb21tdS9xY29tX2lvbW11LmMKPj4gQEAgLTgxMyw4ICs4MTMsMTEgQEAgc3RhdGljIGlu
dCBxY29tX2lvbW11X2RldmljZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+
PiAgIAlxY29tX2lvbW11LT5kZXYgPSBkZXY7Cj4+ICAgCj4+ICAgCXJlcyA9IHBsYXRmb3JtX2dl
dF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7Cj4+IC0JaWYgKHJlcykKPj4gKwlp
ZiAocmVzKSB7Cj4+ICAgCQlxY29tX2lvbW11LT5sb2NhbF9iYXNlID0gZGV2bV9pb3JlbWFwX3Jl
c291cmNlKGRldiwgcmVzKTsKPj4gKwkJaWYgKElTX0VSUihxY29tX2lvbW11LT5sb2NhbF9iYXNl
KSkKPj4gKwkJCXJldHVybiBQVFJfRVJSKHFjb21faW9tbXUtPmxvY2FsX2Jhc2UpOwo+PiArCX0K
Pj4gICAKPj4gICAJcWNvbV9pb21tdS0+aWZhY2VfY2xrID0gZGV2bV9jbGtfZ2V0KGRldiwgImlm
YWNlIik7Cj4+ICAgCWlmIChJU19FUlIocWNvbV9pb21tdS0+aWZhY2VfY2xrKSkgewo+PiAtLSAK
Pj4gMi4yMC4xLndpbmRvd3MuMQo+Pgo+Pgo+PgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
