Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C06C48BE8
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 07:52:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D0761289
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 07:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D0761289
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50E696066E;
	Mon, 14 Jun 2021 07:52:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id snJA5zEre0cr; Mon, 14 Jun 2021 07:52:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3487D6065C;
	Mon, 14 Jun 2021 07:52:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC98BC000D;
	Mon, 14 Jun 2021 07:52:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D978C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 07:52:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3C52F40130
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 07:52:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qNzicadfg7ef for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 07:52:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A292140100
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 07:52:38 +0000 (UTC)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G3Nm307LTz6F9F6;
 Mon, 14 Jun 2021 15:45:39 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 14 Jun 2021 09:52:34 +0200
Received: from [10.47.95.26] (10.47.95.26) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 14 Jun
 2021 08:52:33 +0100
Subject: Re: [PATCH v12 5/5] iommu: Remove mode argument from
 iommu_set_dma_strict()
To: Lu Baolu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <will@kernel.org>, 
 <dwmw2@infradead.org>, <robin.murphy@arm.com>
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-6-git-send-email-john.garry@huawei.com>
 <1b58516d-73d5-0c40-11de-58b998ec803e@linux.intel.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <3b1c277e-fd8a-64d7-4fcb-1a4d64fbcfd4@huawei.com>
Date: Mon, 14 Jun 2021 08:46:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1b58516d-73d5-0c40-11de-58b998ec803e@linux.intel.com>
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

T24gMTIvMDYvMjAyMSAwMzoyMywgTHUgQmFvbHUgd3JvdGU6Cj4gT24gMjAyMS82LzExIDIwOjIw
LCBKb2huIEdhcnJ5IHdyb3RlOgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pb21tdS5j
IGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+IGluZGV4IGNjYmQ1ZDRjMWE1MC4uMTQ2Y2I3MWM3
NDQxIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2lvbW11LmMKPj4gKysrIGIvZHJpdmVy
cy9pb21tdS9pb21tdS5jCj4+IEBAIC0zNTAsMTAgKzM1MCw5IEBAIHN0YXRpYyBpbnQgX19pbml0
IGlvbW11X2RtYV9zZXR1cChjaGFyICpzdHIpCj4+IMKgIH0KPj4gwqAgZWFybHlfcGFyYW0oImlv
bW11LnN0cmljdCIsIGlvbW11X2RtYV9zZXR1cCk7Cj4+IC12b2lkIGlvbW11X3NldF9kbWFfc3Ry
aWN0KGJvb2wgc3RyaWN0KQo+PiArdm9pZCBpb21tdV9zZXRfZG1hX3N0cmljdCh2b2lkKQo+PiDC
oCB7Cj4+IC3CoMKgwqAgaWYgKHN0cmljdCB8fCAhKGlvbW11X2NtZF9saW5lICYgSU9NTVVfQ01E
X0xJTkVfU1RSSUNUKSkKPj4gLcKgwqDCoMKgwqDCoMKgIGlvbW11X2RtYV9zdHJpY3QgPSBzdHJp
Y3Q7Cj4+ICvCoMKgwqDCoMKgwqDCoCBpb21tdV9kbWFfc3RyaWN0ID0gdHJ1ZTsKPj4gwqAgfQo+
IAo+IFdpbGwgdGhpcyBjaGFuZ2UgYnJlYWsgdGhlIGZ1bmN0aW9uYWxpdHkgb2YgaW9tbXUuc3Ry
aWN0Pwo+IAoKTm8sIGlvbW11X2RtYV9zdHJpY3QgaXMgd3JpdHRlbiBkaXJlY3RseSBpbiBpb21t
dV9kbWFfc2V0dXAoKSBmb3IgCmlvbW11LnN0cmljdCBjbWRsaW5lIHByb2Nlc3NpbmcuCgpIZXJl
IEknbSBqdXN0IHNheWluZyB0aGF0IGFueW9uZSB0aGF0IHdobyB1c2VzIGlvbW11X3NldF9kbWFf
c3RyaWN0KGJvb2wgCnN0cmljdCkgYWx3YXlzIHBhc3NlcyB0cnVlLCBzbyBJIGp1c3QgcmVtb3Zl
IHRoYXQgYXJndW1lbnQgYW5kIHNpbXBsaWZ5IAp0aGF0IGZ1bmN0aW9uLgoKVGhhbmtzLApKb2hu
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
