Return-Path: <SRS0=1cKf=HA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B60C433E0
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 15:36:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D60D64E02
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 15:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D60D64E02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BD71B8633B;
	Fri, 29 Jan 2021 15:36:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xyuRYjE75WN6; Fri, 29 Jan 2021 15:36:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9FBC087393;
	Fri, 29 Jan 2021 15:36:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6069AC08A1;
	Fri, 29 Jan 2021 15:36:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 911A0C013A
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 15:36:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 75B7187046
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 15:36:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qwCr4c21d-iv for <iommu@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 15:36:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B8D618700A
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 15:36:01 +0000 (UTC)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DS1Vc2BXVz67bPw;
 Fri, 29 Jan 2021 23:30:00 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 29 Jan 2021 16:35:58 +0100
Received: from [10.210.172.213] (10.210.172.213) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 29 Jan 2021 15:35:57 +0000
Subject: Re: [PATCH v3 2/3] perf/smmuv3: Add a MODULE_SOFTDEP() to indicate
 dependency on SMMU
To: Robin Murphy <robin.murphy@arm.com>, Zhen Lei
 <thunder.leizhen@huawei.com>, Will Deacon <will@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
References: <20210127113258.1421-1-thunder.leizhen@huawei.com>
 <20210127113258.1421-3-thunder.leizhen@huawei.com>
 <67e0859b-2633-3516-527f-57557e210fa1@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <4b116f38-84da-9ef9-350c-8900944b0433@huawei.com>
Date: Fri, 29 Jan 2021 15:34:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <67e0859b-2633-3516-527f-57557e210fa1@arm.com>
Content-Language: en-US
X-Originating-IP: [10.210.172.213]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
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

On 29/01/2021 15:12, Robin Murphy wrote:
> On 2021-01-27 11:32, Zhen Lei wrote:
>> The MODULE_SOFTDEP() gives user space a hint of the loading sequence. And
>> when command "modprobe arm_smmuv3_pmu" is executed, the arm_smmu_v3.ko is
>> automatically loaded in advance.
> 
> Why do we need this? If probe order doesn't matter when both drivers are 
> built-in, why should module load order?
> 
> TBH I'm not sure why we even have a Kconfig dependency on ARM_SMMU_V3, 
> given that the drivers operate completely independently :/

Can that Kconfig dependency just be removed? I think that it was added 
under the idea that there is no point in having the SMMUv3 PMU driver 
without the SMMUv3 driver.

However even on that basis it seems broken, as we cannot have 
ARM_SMMU_V3=m + ARM_SMMU_V3_PMU=y.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
