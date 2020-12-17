Return-Path: <SRS0=GPww=FV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E605C4361B
	for <iommu@archiver.kernel.org>; Thu, 17 Dec 2020 11:50:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE399238E5
	for <iommu@archiver.kernel.org>; Thu, 17 Dec 2020 11:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE399238E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 793EB87A19;
	Thu, 17 Dec 2020 11:50:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WPSjnNMXJtj5; Thu, 17 Dec 2020 11:50:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 85DA687A15;
	Thu, 17 Dec 2020 11:50:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EFC3C088E;
	Thu, 17 Dec 2020 11:50:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC6FBC013B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Dec 2020 11:50:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D07E7875C7
 for <iommu@lists.linux-foundation.org>; Thu, 17 Dec 2020 11:50:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JHzaDSypfBxA for <iommu@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 11:50:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2E33F875A0
 for <iommu@lists.linux-foundation.org>; Thu, 17 Dec 2020 11:50:00 +0000 (UTC)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CxVdp4VVtz56Gr;
 Thu, 17 Dec 2020 19:49:18 +0800 (CST)
Received: from dggema765-chm.china.huawei.com (10.1.198.207) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 17 Dec 2020 19:49:56 +0800
Received: from [10.174.185.137] (10.174.185.137) by
 dggema765-chm.china.huawei.com (10.1.198.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 17 Dec 2020 19:49:55 +0800
Subject: Re: [PATCH v11 04/13] vfio/pci: Add VFIO_REGION_TYPE_NESTED region
 type
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
 <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>, <will@kernel.org>,
 <joro@8bytes.org>, <maz@kernel.org>, <robin.murphy@arm.com>,
 <alex.williamson@redhat.com>
References: <20201116110030.32335-1-eric.auger@redhat.com>
 <20201116110030.32335-5-eric.auger@redhat.com>
From: Kunkun Jiang <jiangkunkun@huawei.com>
Message-ID: <2b5031d4-fa1a-c893-e7e4-56c68da600e4@huawei.com>
Date: Thu, 17 Dec 2020 19:49:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201116110030.32335-5-eric.auger@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.137]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggema765-chm.china.huawei.com (10.1.198.207)
X-CFilter-Loop: Reflected
Cc: jean-philippe@linaro.org, vivek.gautam@arm.com, wanghaibin.wang@huawei.com,
 zhangfei.gao@linaro.org, Keqian Zhu <zhukeqian1@huawei.com>
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

SGkgRXJpYywKCk9uIDIwMjAvMTEvMTYgMTk6MDAsIEVyaWMgQXVnZXIgd3JvdGU6Cj4gQWRkIGEg
bmV3IHNwZWNpZmljIERNQV9GQVVMVCByZWdpb24gYWltaW5nIHRvIGV4cG9zZWQgbmVzdGVkIG1v
ZGUKPiB0cmFuc2xhdGlvbiBmYXVsdHMuIFRoaXMgcmVnaW9uIG9ubHkgaXMgZXhwb3NlZCBpZiB0
aGUgZGV2aWNlCj4gaXMgYXR0YWNoZWQgdG8gYSBuZXN0ZWQgZG9tYWluLgo+Cj4gVGhlIHJlZ2lv
biBoYXMgYSByaW5nIGJ1ZmZlciB0aGF0IGNvbnRhaW5zIHRoZSBhY3R1YWwgZmF1bHQKPiByZWNv
cmRzIHBsdXMgYSBoZWFkZXIgYWxsb3dpbmcgdG8gaGFuZGxlIGl0ICh0YWlsL2hlYWQgaW5kaWNl
cywKPiBtYXggY2FwYWNpdHksIGVudHJ5IHNpemUpLiBBdCB0aGUgbW9tZW50IHRoZSByZWdpb24g
aXMgZGltZW5zaW9ubmVkCj4gZm9yIDUxMiBmYXVsdCByZWNvcmRzLgo+Cj4gU2lnbmVkLW9mZi1i
eTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPgo+Cj4gLS0tClsuLi5dCj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC92ZmlvLmggYi9pbmNsdWRlL3VhcGkvbGludXgv
dmZpby5oCj4gaW5kZXggYjM1MmU3NmNmYjcxLi42MjlkZmIzOGQ5ZTcgMTAwNjQ0Cj4gLS0tIGEv
aW5jbHVkZS91YXBpL2xpbnV4L3ZmaW8uaAo+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92Zmlv
LmgKPiBAQCAtMzQzLDYgKzM0Myw5IEBAIHN0cnVjdCB2ZmlvX3JlZ2lvbl9pbmZvX2NhcF90eXBl
IHsKPiAgIC8qIHN1Yi10eXBlcyBmb3IgVkZJT19SRUdJT05fVFlQRV9HRlggKi8KPiAgICNkZWZp
bmUgVkZJT19SRUdJT05fU1VCVFlQRV9HRlhfRURJRCAgICAgICAgICAgICgxKQo+ICAgCj4gKyNk
ZWZpbmUgVkZJT19SRUdJT05fVFlQRV9ORVNURUQJCQkoMikKPiArI2RlZmluZSBWRklPX1JFR0lP
Tl9TVUJUWVBFX05FU1RFRF9ETUFfRkFVTFQJKDEpCj4gKwoKVGhlIG1hY3JvICpkZWZpbmUgVkZJ
T19SRUdJT05fVFlQRV9ORVNURUTCoMKgwqAgKDIpKiBpcyBpbiBjb25mbGljdCB3aXRoCgoqI2Rl
ZmluZSBWRklPX1JFR0lPTl9UWVBFX0NDV8KgwqDCoCAoMikqLgoKClRoYW5rcywKCkt1bmt1biBK
aWFuZy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
