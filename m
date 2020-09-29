Return-Path: <SRS0=l9dJ=DG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEC8C47423
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 11:15:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B72220848
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 11:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B72220848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E00508700A;
	Tue, 29 Sep 2020 11:15:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UyQcDN+1BvK9; Tue, 29 Sep 2020 11:15:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2096F86FC7;
	Tue, 29 Sep 2020 11:15:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06F94C0890;
	Tue, 29 Sep 2020 11:15:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33A56C016F
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 11:15:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2FBE7867B7
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 11:15:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uSSqL7Qt0VdW for <iommu@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 11:15:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A5168855E1
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 11:15:41 +0000 (UTC)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id DCFDFD0187B43990C58A;
 Tue, 29 Sep 2020 19:15:37 +0800 (CST)
Received: from [10.63.139.185] (10.63.139.185) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 19:15:31 +0800
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add rmb after reading event queue
 prod_reg
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Joerg Roedel
 <joro@8bytes.org>
References: <1601281922-117296-1-git-send-email-wangzhou1@hisilicon.com>
 <160132830305.1858738.13352352759100546799.b4-ty@kernel.org>
From: Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5F731754.5040609@hisilicon.com>
Date: Tue, 29 Sep 2020 19:15:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <160132830305.1858738.13352352759100546799.b4-ty@kernel.org>
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Cc: catalin.marinas@arm.com, iommu@lists.linux-foundation.org,
 kernel-team@android.com, linuxarm@huawei.com,
 linux-arm-kernel@lists.infradead.org
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

On 2020/9/29 6:13, Will Deacon wrote:
> On Mon, 28 Sep 2020 16:32:02 +0800, Zhou Wang wrote:
>> In arm_smmu_evtq_thread, reading event queue is from consumer pointer,
>> which has no address dependency on producer pointer, prog_reg(MMIO) and
>> event queue memory(Normal memory) can disorder. So the load for event queue
>> can be done before the load of prod_reg, then perhaps wrong event entry
>> value will be got.
>>
>> Add rmb to make sure to get correct event queue entry value.
> 
> Applied to will (for-joerg/arm-smmu/updates), thanks!
> 
> [1/1] iommu/arm-smmu-v3: Add rmb after reading event queue prod_reg
>       https://git.kernel.org/will/c/a76a37777f2c 
> 
> (please note that I changed the patch to use readl() instead of an rmb()
> in conjunction with the _relaxed() accessor, and then adjusted the cons
> side to match in terms of DMB vs DSB).

Thanks for taking this patch!

Best,
Zhou

> 
> Cheers,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
