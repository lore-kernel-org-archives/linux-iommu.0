Return-Path: <SRS0=tixU=6C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CC4C38A2E
	for <iommu@archiver.kernel.org>; Sat, 18 Apr 2020 13:07:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D66022051A
	for <iommu@archiver.kernel.org>; Sat, 18 Apr 2020 13:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66022051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B46C386914;
	Sat, 18 Apr 2020 13:07:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jZXzzZW6H0tY; Sat, 18 Apr 2020 13:07:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C9F3186088;
	Sat, 18 Apr 2020 13:07:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADEFEC1D7E;
	Sat, 18 Apr 2020 13:07:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35287C0172
 for <iommu@lists.linux-foundation.org>; Sat, 18 Apr 2020 13:07:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2C8348783F
 for <iommu@lists.linux-foundation.org>; Sat, 18 Apr 2020 13:07:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l4JTrOXIwErk for <iommu@lists.linux-foundation.org>;
 Sat, 18 Apr 2020 13:06:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com
 [221.176.66.80])
 by hemlock.osuosl.org (Postfix) with ESMTP id E9D2987590
 for <iommu@lists.linux-foundation.org>; Sat, 18 Apr 2020 13:06:55 +0000 (UTC)
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by
 rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee75e9afb3b720-ae9ec;
 Sat, 18 Apr 2020 21:06:04 +0800 (CST)
X-RM-TRANSID: 2ee75e9afb3b720-ae9ec
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.0.105] (unknown[112.1.172.61])
 by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee55e9afb3b593-93bdc;
 Sat, 18 Apr 2020 21:06:04 +0800 (CST)
X-RM-TRANSID: 2ee55e9afb3b593-93bdc
Subject: Re: [PATCH] iommu/qcom:fix local_base status check
To: Joerg Roedel <joro@8bytes.org>
References: <20200402063302.20640-1-tangbin@cmss.chinamobile.com>
 <20200402064552.GG663905@yoga>
 <7a565c74-f223-83da-cf32-0474be6c9460@cmss.chinamobile.com>
 <20200418115400.GF21900@8bytes.org>
From: Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <a92f6302-e7bb-0456-b0c4-83298eab71fe@cmss.chinamobile.com>
Date: Sat, 18 Apr 2020 21:08:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200418115400.GF21900@8bytes.org>
Content-Language: en-US
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, agross@kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>
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

Ck9uIDIwMjAvNC8xOCAxOTo1NCwgSm9lcmcgUm9lZGVsIHdyb3RlOgo+IE9uIFRodSwgQXByIDE2
LCAyMDIwIGF0IDAyOjQyOjIzUE0gKzA4MDAsIFRhbmcgQmluIHdyb3RlOgo+PiAgwqDCoMKgwqDC
oMKgwqAgVGhlIGZ1bmN0aW9uIHFjb21faW9tbXVfZGV2aWNlX3Byb2JlKCkgZG9lcyBub3QgcGVy
Zm9ybSBzdWZmaWNpZW50Cj4+IGVycm9yIGNoZWNraW5nIGFmdGVyIGV4ZWN1dGluZyBkZXZtX2lv
cmVtYXBfcmVzb3VyY2UoKSwgd2hpY2ggY2FuIHJlc3VsdCBpbgo+PiBjcmFzaGVzIGlmIGEgY3Jp
dGljYWwgZXJyb3IgcGF0aCBpcyBlbmNvdW50ZXJlZC4KPj4KPj4gRml4ZXM6IDBhZTM0OWEwKCJp
b21tdS9xY29tOiBBZGQgcWNvbV9pb21tdSIpCj4gWWVzLCB0aGF0IHNvdW5kcyBiZXR0ZXIuIFBs
ZWFzZSB1c2UgaXQgZm9yIHRoZSBjb21taXQgbWVzc2FnZSBhbmQgYWxzbwo+IGFkZCB0aGUgRml4
ZXMgbGluZSBhbmQgcmVzdWJtaXQgdGhlIGZpeCB0byBtZS4KPiBQbGVhc2UgbWFrZSB0aGUgZml4
ZXMgbGluZToKPgo+IAlGaXhlczogMGFlMzQ5YTBmMzNmICgiaW9tbXUvcWNvbTogQWRkIHFjb21f
aW9tbXUiKQo+Cj4gU28gdGhhdCB0aGUgY29tbWl0LWlkIGlzIDEyIGNoYXJhY3RlcnMgbG9uZyBh
bmQgYSBzcGFjZSBiZXR3ZWVuIGl0IGFuZAo+IHRoZSBzdWJqZWN0LgoKR290IGl0LCB0aGFua3Mg
Zm9yIHlvdXIgaW5zdHJ1Y3Rpb24uCgpUYW5nIEJpbgoKPgo+CgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
