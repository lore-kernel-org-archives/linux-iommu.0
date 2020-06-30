Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A2AC433E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 16:32:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C1F620722
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 16:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="d+UqhUrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1F620722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EBE812284C;
	Tue, 30 Jun 2020 16:32:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5VkboDEmQE6e; Tue, 30 Jun 2020 16:32:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 79EF9204D3;
	Tue, 30 Jun 2020 16:32:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1632C088F;
	Tue, 30 Jun 2020 16:32:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7039DC016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 16:32:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5DF1B88005
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 16:32:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HLE-XPnKeduG for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 16:32:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C3D4887D5C
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 16:32:50 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5efb68cf0000>; Tue, 30 Jun 2020 09:31:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 30 Jun 2020 09:32:50 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 30 Jun 2020 09:32:50 -0700
Received: from [10.26.75.203] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 16:32:43 +0000
Subject: Re: [PATCH v8 1/3] iommu/arm-smmu: add NVIDIA implementation for dual
 ARM MMU-500 usage
To: Krishna Reddy <vdumpa@nvidia.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-2-vdumpa@nvidia.com>
 <e6da9661-4e62-6e34-ac21-63ff993ca8bc@nvidia.com>
 <BYAPR12MB282210677459B8D62623C642B36F0@BYAPR12MB2822.namprd12.prod.outlook.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <4037efc7-fbed-e8cf-dac7-212c65014e4e@nvidia.com>
Date: Tue, 30 Jun 2020 17:32:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB282210677459B8D62623C642B36F0@BYAPR12MB2822.namprd12.prod.outlook.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1593534671; bh=BrdgzbzbGOaqIwpth+UjSE/3zpix62EIsg7FYiFJ6po=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=d+UqhUrDKQr8qFYOz/u1vjt8DsYokVFOhzKCisRgy5ftkePf+uBolfrmg8FgEHwdS
 piLlBWJ0pLcqmaeAwHPOo/UaGVj9zVUQNskhfOXQpG0k6Ias7wEyUgS7An8mBhyL5p
 tMQrr173OXX1OggHX8tDrBt3AxuIsi9WThAIxJW/79t3EfyxVilU+9a6SqzZALM6S/
 p1xDklctnzMXhkzlodCLxyMmAnpk+KM94/7MvD6rRAYRUePSHy3nAMp+tNqgKSvViJ
 3fQ+OW2hvHql+Q6b6F2BYaMga1HaxbS7PeG+b1/qaNATJXb75hdM3242unbLTHx59U
 Q/kF7UjjTvN8g==
Cc: Sachin Nikam <Snikam@nvidia.com>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, Bryan Huntsman <bhuntsman@nvidia.com>,
 "will@kernel.org" <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Pritesh Raithatha <praithatha@nvidia.com>, Timo Alho <talho@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Yu-Huan
 Hsu <YHsu@nvidia.com>, Thierry Reding <treding@nvidia.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Bitan Biswas <bbiswas@nvidia.com>
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



On 30/06/2020 17:23, Krishna Reddy wrote:
>>> +struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device 
>>> +*smmu) {
>>> +	unsigned int i;
> ....
>>> +	for (i = 1; i < MAX_SMMU_INSTANCES; i++) {
>>> +		struct resource *res;
>>> +
>>> +		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
>>> +		if (!res)
>>> +			break;
> 
>> Currently this driver is only supported for Tegra194 which I understand has 3 SMMUs. Therefore, I don't feel that we should fail silently here, I think it is better to return an error if all 3 cannot be initialised.
> 
> Initialization of all the three SMMU instances is not necessary here.

That is not what I am saying.

> The driver can work with all the possible number of instances 1, 2 and 3 based on the DT config though it doesn't make much sense to use it with 1 instance.
> There is no silent failure here from driver point of view. If there is misconfig in DT, SMMU faults would catch issues.

I disagree and you should return a proper error here.

>>> +		nvidia_smmu->bases[i] = devm_ioremap_resource(smmu->dev, res);
>>> +		if (IS_ERR(nvidia_smmu->bases[i]))
>>> +			return ERR_CAST(nvidia_smmu->bases[i]);
> 
>> You want to use PTR_ERR() here.
> 
> PTR_ERR() returns long integer. 
> This function returns a pointer. ERR_CAST is the right one to use here. 

Ah yes, indeed. OK that's fine.

Jon

-- 
nvpublic
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
