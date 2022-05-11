Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0A2C433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 02:25:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63AE8417CD;
	Wed, 11 May 2022 02:25:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gXL8Zr250xur; Wed, 11 May 2022 02:25:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C65F5417AB;
	Wed, 11 May 2022 02:25:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9883EC0032;
	Wed, 11 May 2022 02:25:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F00AC002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 02:25:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB7DC60A83
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 02:25:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RjadEPH-wm20 for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 02:25:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3353060A69
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 02:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652235955; x=1683771955;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=W+VWsIRnkEGuh9oI6gzNdZHzNHTm1OXhUcAHi/Gdvh8=;
 b=I/sM79sr0N+tUEJDf73NqJpMZHT2dJU4+5rTJceS/l8MAaFwyFRk6iZt
 dVLDAV/PvhsxAce1FGjRWcGZRVgezGvl5Jzg+g1KARIVLuh/gqESjMAQt
 d3+U7D1Ageyek0/177hL+7+ENSrt8Q7WV1GtsXr2mwYUZBtJrQevoVnj6
 8r1l5EjGhgu9zCgMbDsJLqWwD5oNssyzMC9PmnIVP2uuiOEgnkrTXRvRu
 nVLNbP8xFzBO2srs03WL8urlNyMUdN+K5JL66IQnCfVLERXD5LcAnuGJx
 OGRsr8cwCk6mJQcdlVrv8U6p/wA96qF4HxXSj7/82Kz5SDKRpkUbl4sQr w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="330158181"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; d="scan'208";a="330158181"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2022 19:25:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; d="scan'208";a="542091647"
Received: from chenji3x-mobl1.ccr.corp.intel.com (HELO [10.255.30.10])
 ([10.255.30.10])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2022 19:25:50 -0700
Message-ID: <3fe05f18-6726-276a-8c42-79e0b134dfdc@linux.intel.com>
Date: Wed, 11 May 2022 10:25:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 02/12] iommu: Add pasid_bits field in struct dev_iommu
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-3-baolu.lu@linux.intel.com>
 <20220510143405.GE49344@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220510143405.GE49344@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On 2022/5/10 22:34, Jason Gunthorpe wrote:
> On Tue, May 10, 2022 at 02:17:28PM +0800, Lu Baolu wrote:
> 
>>   int iommu_device_register(struct iommu_device *iommu,
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 627a3ed5ee8f..afc63fce6107 100644
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -2681,6 +2681,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>>   	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
>>   		master->stall_enabled = true;
>>   
>> +	dev->iommu->pasid_bits = master->ssid_bits;
>>   	return &smmu->iommu;
>>   
>>   err_free_master:
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 2990f80c5e08..99643f897f26 100644
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4624,8 +4624,11 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>>   			if (pasid_supported(iommu)) {
>>   				int features = pci_pasid_features(pdev);
>>   
>> -				if (features >= 0)
>> +				if (features >= 0) {
>>   					info->pasid_supported = features | 1;
>> +					dev->iommu->pasid_bits =
>> +						fls(pci_max_pasids(pdev)) - 1;
>> +				}
> 
> It is not very nice that both the iommu drivers have to duplicate the
> code to read the pasid capability out of the PCI device.
> 
> IMHO it would make more sense for the iommu layer to report the
> capability of its own HW block only, and for the core code to figure
> out the master's limitation using a bus-specific approach.

Fair enough. The iommu hardware capability could be reported in

/**
  * struct iommu_device - IOMMU core representation of one IOMMU hardware
  *                       instance
  * @list: Used by the iommu-core to keep a list of registered iommus
  * @ops: iommu-ops for talking to this iommu
  * @dev: struct device for sysfs handling
  */
struct iommu_device {
         struct list_head list;
         const struct iommu_ops *ops;
         struct fwnode_handle *fwnode;
         struct device *dev;
};

I haven't checked ARM code yet, but it works for x86 as far as I can
see.

> 
> It is also unfortunate that the enable/disable pasid is inside the
> iommu driver as well - ideally the PCI driver itself would do this
> when it knows it wants to use PASIDs.
> 
> The ordering interaction with ATS makes this look quite annoying
> though. :(
> 
> I'm also not convinced individual IOMMU drivers should be forcing ATS
> on, there are performance and functional implications here. Using ATS
> or not is possibly best left as an administrator policy controlled by
> the core code. Again we seem to have some mess.

Agreed with you. This has already been in my task list. I will start to
solve it after the iommufd tasks.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
