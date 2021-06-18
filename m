Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4A9C2B9F4
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 01:54:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F485613B4
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 01:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F485613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32A2A83CF9;
	Fri, 18 Jun 2021 01:54:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ynbf-MuScHde; Fri, 18 Jun 2021 01:54:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1116583CF8;
	Fri, 18 Jun 2021 01:54:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC0F9C000D;
	Fri, 18 Jun 2021 01:54:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 578A0C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 01:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 52B5740569
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 01:54:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sU-tPagjm0Ph for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 01:54:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2C25A40563
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 01:54:00 +0000 (UTC)
IronPort-SDR: yboPfwQ8yw1lhQiIHxWJfHHWxCn8ykFs8WKoSjysp/wNWmaYiioawtVGUfRCfwWIuLJq/cIE2y
 Bk+Uk6w/wVLA==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="206298942"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; d="scan'208";a="206298942"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2021 18:53:59 -0700
IronPort-SDR: M+7j3e8w7yg2eVqLS5rDHawbsDeYbC4twNz64FToCwPMeSFGvwl1+C7/OBU26n4Mmu2kNQruxh
 Qt87RSrquZzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; d="scan'208";a="472613025"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2021 18:53:56 -0700
Subject: Re: [PATCH v13 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 dwmw2@infradead.org, robin.murphy@arm.com, corbet@lwn.net
References: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
 <1623841437-211832-7-git-send-email-john.garry@huawei.com>
 <de6a2874-3d6d-ed2a-78f5-fb1fb0195228@linux.intel.com>
 <c61376c8-5285-1121-046f-3ab12eee9902@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <cac021f9-8469-a3b4-a0c6-80a37e882b6f@linux.intel.com>
Date: Fri, 18 Jun 2021 09:52:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <c61376c8-5285-1121-046f-3ab12eee9902@huawei.com>
Content-Language: en-US
Cc: linux-doc@vger.kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
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

T24gNi8xNy8yMSAzOjQxIFBNLCBKb2huIEdhcnJ5IHdyb3RlOgo+IAo+Pj4gQEAgLTM0OSwxMCAr
MzQ5LDkgQEAgc3RhdGljIGludCBfX2luaXQgaW9tbXVfZG1hX3NldHVwKGNoYXIgKnN0cikKPj4+
IMKgIH0KPj4+IMKgIGVhcmx5X3BhcmFtKCJpb21tdS5zdHJpY3QiLCBpb21tdV9kbWFfc2V0dXAp
Owo+Pj4gLXZvaWQgaW9tbXVfc2V0X2RtYV9zdHJpY3QoYm9vbCBzdHJpY3QpCj4+PiArdm9pZCBp
b21tdV9zZXRfZG1hX3N0cmljdCh2b2lkKQo+Pj4gwqAgewo+Pj4gLcKgwqDCoCBpZiAoc3RyaWN0
IHx8ICEoaW9tbXVfY21kX2xpbmUgJiBJT01NVV9DTURfTElORV9TVFJJQ1QpKQo+Pj4gLcKgwqDC
oMKgwqDCoMKgIGlvbW11X2RtYV9zdHJpY3QgPSBzdHJpY3Q7Cj4+PiArwqDCoMKgIGlvbW11X2Rt
YV9zdHJpY3QgPSB0cnVlOwo+Pgo+PiBTb3JyeSwgSSBzdGlsbCBjYW4ndCBnZXQgaG93IGlvbW11
LnN0cmljdCBrZXJuZWwgb3B0aW9uIHdvcmtzLgo+Pgo+PiBzdGF0aWMgaW50IF9faW5pdCBpb21t
dV9kbWFfc2V0dXAoY2hhciAqc3RyKQo+PiB7Cj4+IMKgwqDCoMKgwqDCoMKgwqAgaW50IHJldCA9
IGtzdHJ0b2Jvb2woc3RyLCAmaW9tbXVfZG1hX3N0cmljdCk7Cj4+Cj4+IMKgwqDCoMKgwqDCoMKg
wqAgaWYgKCFyZXQpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlvbW11X2Nt
ZF9saW5lIHw9IElPTU1VX0NNRF9MSU5FX1NUUklDVDsKPj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gcmV0Owo+PiB9Cj4+IGVhcmx5X3BhcmFtKCJpb21tdS5zdHJpY3QiLCBpb21tdV9kbWFfc2V0
dXApOwo+Pgo+PiBUaGUgYml0IElPTU1VX0NNRF9MSU5FX1NUUklDVCBpcyBvbmx5IHNldCwgYnV0
IG5vdCB1c2VkIGFueXdoZXJlLgo+IAo+IEl0IGlzIHVzZWQgaW4gcGF0Y2ggMi82Ogo+IAo+ICvC
oMKgwqAgcHJfaW5mbygiRE1BIGRvbWFpbiBUTEIgaW52YWxpZGF0aW9uIHBvbGljeTogJXMgbW9k
ZSAlc1xuIiwKPiArwqDCoMKgwqDCoMKgwqAgaW9tbXVfZG1hX3N0cmljdCA/ICJzdHJpY3QiIDog
ImxhenkiLAo+ICvCoMKgwqDCoMKgwqDCoCAoaW9tbXVfY21kX2xpbmUgJiBJT01NVV9DTURfTElO
RV9TVFJJQ1QpID8KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiKHNldCB2aWEga2VybmVsIGNv
bW1hbmQgbGluZSkiIDogIiIpOwo+IAo+PiBIZW5jZSwKPj4gSSBhbSB3b25kZXJpbmcgaG93IGNv
dWxkIGl0IHdvcms/IEEgYnVnIG9yIEkgbWlzc2VkIGFueXRoaW5nPwo+IAo+IEl0IGlzIHJlYWxs
eSBqdXN0IHVzZWQgZm9yIGluZm9ybWF0aXZlIHB1cnBvc2Ugbm93LgoKSSBhbSBjbGVhciBub3cu
IFRoYW5rcyEKCkJlc3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2lvbW11
