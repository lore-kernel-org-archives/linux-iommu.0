Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7646CC48BE8
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 07:59:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DA161289
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 07:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DA161289
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D72A383AAE;
	Mon, 14 Jun 2021 07:59:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id synBDG6rb8yO; Mon, 14 Jun 2021 07:59:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3E80783A7D;
	Mon, 14 Jun 2021 07:59:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03C58C000D;
	Mon, 14 Jun 2021 07:59:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2FE4C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 07:59:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BD38F83AAE
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 07:59:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J6w06K1j7j2r for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 07:59:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2DC9D83A7D
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 07:59:15 +0000 (UTC)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G3Nmg6Vzhz6H7N7;
 Mon, 14 Jun 2021 15:46:11 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 14 Jun 2021 09:59:12 +0200
Received: from [10.47.95.26] (10.47.95.26) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 14 Jun
 2021 08:59:11 +0100
Subject: Re: [PATCH v12 3/5] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
To: Lu Baolu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <will@kernel.org>, 
 <dwmw2@infradead.org>, <robin.murphy@arm.com>
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-4-git-send-email-john.garry@huawei.com>
 <4f2cec34-bad9-e1bf-85c1-04d1a0c1aecf@linux.intel.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <6055cd0d-a1d3-a73a-6831-3837021f3c9c@huawei.com>
Date: Mon, 14 Jun 2021 08:53:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <4f2cec34-bad9-e1bf-85c1-04d1a0c1aecf@linux.intel.com>
Content-Language: en-US
X-Originating-IP: [10.47.95.26]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com
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

T24gMTIvMDYvMjAyMSAwMzoyMiwgTHUgQmFvbHUgd3JvdGU6Cj4gT24gMjAyMS82LzExIDIwOjIw
LCBKb2huIEdhcnJ5IHdyb3RlOgo+PiBAQCAtNDUzLDggKzQ1Miw3IEBAIHN0YXRpYyBpbnQgX19p
bml0IGludGVsX2lvbW11X3NldHVwKGNoYXIgKnN0cikKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcHJfd2FybigiaW50ZWxfaW9tbXU9Zm9yY2VkYWMgZGVwcmVjYXRlZDsgdXNlIAo+PiBp
b21tdS5mb3JjZWRhYyBpbnN0ZWFkXG4iKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aW9tbXVfZG1hX2ZvcmNlZGFjID0gdHJ1ZTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSBp
ZiAoIXN0cm5jbXAoc3RyLCAic3RyaWN0IiwgNikpIHsKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcHJfaW5mbygiRGlzYWJsZSBiYXRjaGVkIElPVExCIGZsdXNoXG4iKTsKPj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaW50ZWxfaW9tbXVfc3RyaWN0ID0gMTsKPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaW9tbXVfc2V0X2RtYV9zdHJpY3QodHJ1ZSk7Cj4gCj4gSSB3b3VsZCBsaWtlIHRv
IGRlcHJlY2F0ZSB0aGlzIGNvbW1hbmQgbGluZSBhbmQgYXNrIHVzZXJzIHRvIHVzZQo+IGlvbW11
LnN0cmljdCBpbnN0ZWFkLgoKb2ssIGJ1dCB0aGVuIEkgc2hvdWxkIHByb2JhYmx5IG1ha2UgdGhl
IEFNRCBkcml2ZXIgYWxzbyBvZmZpY2lhbGx5IApzdXBwb3J0IHRoaXMuCgo+IAo+IC0tLSBhL2Ry
aXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9t
bXUuYwo+IEBAIC00MzYsNyArNDM2LDcgQEAgc3RhdGljIGludCBfX2luaXQgaW50ZWxfaW9tbXVf
c2V0dXAoY2hhciAqc3RyKQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHByX3dhcm4oImludGVsX2lvbW11PWZvcmNlZGFjIGRlcHJlY2F0ZWQ7IHVzZSAK
PiBpb21tdS5mb3JjZWRhYyBpbnN0ZWFkXG4iKTsKPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpb21tdV9kbWFfZm9yY2VkYWMgPSB0cnVlOwo+ICDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfSBlbHNlIGlmICghc3RybmNtcChzdHIsICJzdHJp
Y3QiLCA2KSkgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBwcl9pbmZvKCJEaXNhYmxlIGJhdGNoZWQgSU9UTEIgZmx1c2hcbiIpOwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcl93YXJuKCJpbnRlbF9pb21tdT1z
dHJpY3QgZGVwcmVjYXRlZDsgdXNlIAo+IGlvbW11LnN0cmljdCBpbnN0ZWFkXG4iKTsKPiAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnRlbF9pb21tdV9z
dHJpY3QgPSAxOwo+IAo+IEFsc28gdXBkYXRlIERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2Vy
bmVsLXBhcmFtZXRlcnMudHh0IGFjY29yZGluZ2x5LgoKVGhhbmtzLApKb2huCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
