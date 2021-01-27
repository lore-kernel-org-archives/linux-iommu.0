Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486F8C433E0
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 09:36:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCCFB20771
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 09:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCFB20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1769A20C41;
	Wed, 27 Jan 2021 09:36:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DBcjHi-NkFW6; Wed, 27 Jan 2021 09:36:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2E38020005;
	Wed, 27 Jan 2021 09:36:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 123BBC08A1;
	Wed, 27 Jan 2021 09:36:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 550CEC013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 09:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4271E85B71
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 09:36:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7LLMsF4aUuM0 for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 09:36:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9E79B84C20
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 09:36:08 +0000 (UTC)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DQdjl4GX9zjDTQ;
 Wed, 27 Jan 2021 17:34:51 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0;
 Wed, 27 Jan 2021 17:36:01 +0800
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: Use DEFINE_RES_MEM() to simplify
 code
To: Will Deacon <will@kernel.org>
References: <20210122131448.1167-1-thunder.leizhen@huawei.com>
 <7f0b488d-f9b2-92b8-5914-2cef76b4d398@huawei.com>
 <20210127092352.GA31790@willie-the-truck>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <266dcbb7-56fb-6b29-6e50-d49fbee5a966@huawei.com>
Date: Wed, 27 Jan 2021 17:35:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210127092352.GA31790@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 2021/1/27 17:23, Will Deacon wrote:
> On Wed, Jan 27, 2021 at 10:05:50AM +0800, Leizhen (ThunderTown) wrote:
>> I've sent another set of patches. https://lkml.org/lkml/2021/1/26/1065
>> If those patches are acceptable, then this one should be ignored.
> 
> I've already queued this one, so if you want me to drop it then you need to
> send me a revert.

Thanks. Since it's queued, keep it. I'll update the new patch set.

> 
> Will
> 
> .
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
