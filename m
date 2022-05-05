Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50348C433FE
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 01:07:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E934F40146;
	Thu,  5 May 2022 01:07:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xNN5_eCfhgu0; Thu,  5 May 2022 01:07:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E05B640182;
	Thu,  5 May 2022 01:07:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98C9FC0039;
	Thu,  5 May 2022 01:07:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72044C002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 01:07:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 59FCF418B8
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 01:07:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YAlAoC9sbZLK for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 01:07:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EF58D41710
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 01:07:52 +0000 (UTC)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KtwXS3dZ5zhYtd;
 Thu,  5 May 2022 09:07:20 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 09:07:50 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 09:07:49 +0800
Subject: Re: [PATCH v12 3/9] ACPI/IORT: Provide a generic helper to retrieve
 reserve regions
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
References: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
 <20220503163330.509-4-shameerali.kolothum.thodi@huawei.com>
Message-ID: <001ff5d0-09da-ec73-3b3f-d3ce9bed4dc7@huawei.com>
Date: Thu, 5 May 2022 09:07:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220503163330.509-4-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-GB
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Cc: robin.murphy@arm.com, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, hch@infradead.org, Sami.Mujawar@arm.com, will@kernel.org,
 wanghuiqiang@huawei.com
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
From: Hanjun Guo via iommu <iommu@lists.linux-foundation.org>
Reply-To: Hanjun Guo <guohanjun@huawei.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMjAyMi81LzQgMDozMywgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToKPiBDdXJyZW50bHkgSU9S
VCBwcm92aWRlcyBhIGhlbHBlciB0byByZXRyaWV2ZSBIVyBNU0kgcmVzZXJ2ZSByZWdpb25zLgo+
IENoYW5nZSB0aGlzIHRvIGEgZ2VuZXJpYyBoZWxwZXIgdG8gcmV0cmlldmXCoGFueSBJT1JUIHJl
bGF0ZWQgcmVzZXJ2ZQo+IHJlZ2lvbnMuIFRoaXMgd2lsbCBiZSB1c2VmdWwgd2hlbiB3ZcKgYWRk
IHN1cHBvcnQgZm9yIFJNUiBub2RlcyBpbgo+IHN1YnNlcXVlbnQgcGF0Y2hlcy4KPiAKPiBbTG9y
ZW56bzogRm9yIEFDUEkgSU9SVF0KPiBSZXZpZXdlZC1ieTogTG9yZW56byBQaWVyYWxpc2kgPGxv
cmVuem8ucGllcmFsaXNpQGFybS5jb20+Cj4gUmV2aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2ln
IDxoY2hAbHN0LmRlPgo+IFRlc3RlZC1ieTogU3RldmVuIFByaWNlIDxzdGV2ZW4ucHJpY2VAYXJt
LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxzaGFtZWVyYWxpLmtvbG90
aHVtLnRob2RpQGh1YXdlaS5jb20+CgpSZXZpZXdlZC1ieTogSGFuanVuIEd1byA8Z3VvaGFuanVu
QGh1YXdlaS5jb20+CgpUaGFua3MKSGFuanVuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
