Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D24C2B9F4
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 17:30:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A4F61246
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 17:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A4F61246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F11A14038A;
	Mon, 14 Jun 2021 17:30:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EBDxLDPMxOgp; Mon, 14 Jun 2021 17:30:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F3EBF40388;
	Mon, 14 Jun 2021 17:30:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D065EC000D;
	Mon, 14 Jun 2021 17:30:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A526C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 17:30:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2CBE483AAC
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 17:30:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l3srR5BgGV-u for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 17:30:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 32B8C8374F
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 17:30:46 +0000 (UTC)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G3db804BLz6F9Tn;
 Tue, 15 Jun 2021 01:23:48 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 14 Jun 2021 19:30:44 +0200
Received: from [10.47.95.26] (10.47.95.26) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 14 Jun
 2021 18:30:43 +0100
Subject: Re: [PATCH v12 5/5] iommu: Remove mode argument from
 iommu_set_dma_strict()
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>, 
 <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-6-git-send-email-john.garry@huawei.com>
 <868374d4-e816-b607-82de-7e7c27a4c66b@arm.com>
 <b12d96fa-9879-2739-fadd-2ebb02d75918@huawei.com>
 <56f1fc88-baec-e1cf-109e-59978e2d16a8@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <0e477a85-db02-1513-a449-02a9fbfccdfa@huawei.com>
Date: Mon, 14 Jun 2021 18:24:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <56f1fc88-baec-e1cf-109e-59978e2d16a8@arm.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 14/06/2021 18:19, Robin Murphy wrote:
>>> We shouldn't need to keep IOMMU_CMD_LINE_STRICT at all now, since it 
>>> was only to prevent a driver's "default lazy" setting passed in here 
>>> from downgrading an explicitly-set strict mode.
>>>
>>> With that cleaned up too,
>>>
>>
>> Patch 1/5 mentions whether the invalidation policy comes from the 
>> cmdline - similar to the default domain type print - so I was going to 
>> keep that.
> 
> Oh, silly me, I'd forgotten that already and was just looking at my 
> local tree... Let's keep it for consistency with how we report the 
> domain type then.
> 
>> And then maybe we should also set it from the deprecated x86 
>> driver-specific params.
> 
> I don't think it's worth exporting more low-level guts to allow that to 
> happen - tying in to iommu_set_dma_strict() would be too late, as 
> before. I think the separate pr_warn()s which announce the relevant 
> parameter is deprecated (but has still taken effect) should be enough.
> 

Fine, I suppose someone using a deprecated interface can't complain 
about imperfect prints.

And I'll pick up your RB tag (unless you mention otherwise).

Thanks,
John


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
