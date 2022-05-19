Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8602C433F5
	for <iommu@archiver.kernel.org>; Thu, 19 May 2022 11:55:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58C1860EAD;
	Thu, 19 May 2022 11:55:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j8dJp9vsKWbW; Thu, 19 May 2022 11:55:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 53C9B60E33;
	Thu, 19 May 2022 11:55:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 314FDC0032;
	Thu, 19 May 2022 11:55:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D608C002D
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 11:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7676F60EAD
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 11:55:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MstRCfiz2ONa for <iommu@lists.linux-foundation.org>;
 Thu, 19 May 2022 11:55:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 728B860E33
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 11:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652961321; x=1684497321;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=TKh87fcu8gDUB/G0iIOkwc196gZQ+TKq8cbdTGbs8hs=;
 b=NP5MbYY2VVGI8poL1gTYkAquFZXzsMK1G+OEvKd+qwR3ffyP7Kjj3H/m
 a6/mNz8VEspJ4VqXOvrwyNUtYwgBowvw1BAS7TjrjLEVt7sVlo+FeQB8N
 BKHGxK71vwxteCgc/DkLWgIFvGaTyxHgRrmobMuZmMi64tG3LyKSbg9oT
 6U2qFdfcVwrln1cTJgoaMtEWHV/ga4Fagl6OX1qoBlGuwzhPhhMDMnhjI
 ztoBwM79pjCVaNRBtzShqGWGR2CIj7YjcF1CQmPl/pVBsJrx32r/IZmA7
 E+zyz+r1oA1AivZideWo5UCzh5upWCq2MF/T1thQdqxrVktqCq62JlS1p w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="272294544"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; d="scan'208";a="272294544"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2022 04:55:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; d="scan'208";a="742878697"
Received: from zhongz9x-mobl.ccr.corp.intel.com (HELO [10.255.28.182])
 ([10.255.28.182])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2022 04:55:15 -0700
Message-ID: <dc607792-0285-6a11-83f9-9dafd083bd9b@linux.intel.com>
Date: Thu, 19 May 2022 19:55:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v7 01/10] iommu: Add pasids field in struct iommu_device
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-2-baolu.lu@linux.intel.com> <YoYd43JFXJcqngby@myrica>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YoYd43JFXJcqngby@myrica>
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
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

Hi Jean,

On 2022/5/19 18:37, Jean-Philippe Brucker wrote:
> On Thu, May 19, 2022 at 03:20:38PM +0800, Lu Baolu wrote:
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 88817a3376ef..6e2cd082c670 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -3546,6 +3546,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>>   	/* SID/SSID sizes */
>>   	smmu->ssid_bits = FIELD_GET(IDR1_SSIDSIZE, reg);
>>   	smmu->sid_bits = FIELD_GET(IDR1_SIDSIZE, reg);
>> +	smmu->iommu.pasids = smmu->ssid_bits;
> This should be 1UL << smmu->ssid_bits

Done. Thank you for the reminding.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
