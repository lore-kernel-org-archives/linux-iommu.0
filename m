Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D300C433F5
	for <iommu@archiver.kernel.org>; Fri, 25 Feb 2022 01:56:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C641983E6F;
	Fri, 25 Feb 2022 01:56:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 60g34bmrUovi; Fri, 25 Feb 2022 01:56:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8E1F083E6C;
	Fri, 25 Feb 2022 01:56:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F433C0021;
	Fri, 25 Feb 2022 01:56:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFDB4C0011
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 01:56:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A581B607A4
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 01:56:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1k_Qli90ZUh3 for <iommu@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 01:56:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0824F6068A
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 01:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645754197; x=1677290197;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=TcpmV4noUFBiGEZ3o4FCce8aCYiup32Bd4REqfq6nEg=;
 b=LsqXC3SdEKB3mCJSeFtw7F0mg2IXedrNvLoUt+pb/uk2xyJ/4MP/LCvN
 mwIs6/oFSb4pBMmoXhVS+vsMLIkcuJiDL8PejnJC+kspi4WqsqOeBcxHu
 unmI0qINkRxPCsHo+COlGDu2SWoi25o2TJ/eMGtvMRmjmkjXQeyabpo3y
 QKP3acdUEfpHall9+r8gAqBm1FMCOimWkrshleDCiDB1PgVg/FB8YDexl
 /+f6SRV4eXk8WQ1F6ySq4uGVzhQiGRXpHND72ZwvPkRyjdR11aPTnlrdD
 TZDI05vwF6sB0vkHuK/3yrCm0wG+0m7mgiD5dm4tWM77fJNgexk1P5itY g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252127734"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; d="scan'208";a="252127734"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2022 17:56:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; d="scan'208";a="533385717"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 24 Feb 2022 17:56:33 -0800
Message-ID: <21befc9a-ff72-154f-9fad-3a11ff9b91a6@linux.intel.com>
Date: Fri, 25 Feb 2022 09:55:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 05/11] iommu/vt-d: Remove DEFER_DEVICE_DOMAIN_INFO
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-6-baolu.lu@linux.intel.com>
 <20220224130423.GH6413@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220224130423.GH6413@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On 2/24/22 9:04 PM, Jason Gunthorpe wrote:
> On Mon, Feb 14, 2022 at 10:56:58AM +0800, Lu Baolu wrote:
> 
>> diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
>> index db7a0ca73626..ed796eea4581 100644
>> --- a/drivers/iommu/intel/debugfs.c
>> +++ b/drivers/iommu/intel/debugfs.c
>> @@ -344,7 +344,8 @@ static void pgtable_walk_level(struct seq_file *m, struct dma_pte *pde,
>>   
>>   static int show_device_domain_translation(struct device *dev, void *data)
>>   {
>> -	struct dmar_domain *domain = find_domain(dev);
>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +	struct dmar_domain *domain = info->domain;
> 
> It might be nice to someday call 'struct device_domain_info' something
> clearer since it is now the dev_iommu_priv..

I have the same idea. :-) I will rename it later.

> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
