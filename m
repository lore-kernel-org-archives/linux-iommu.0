Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25158375
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 02:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684464563; x=1716000563;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YlGUzZYLdlp8PPHldOoXpzQtyPgUf7pfJQY5cYObzAU=;
  b=C49FWvP6lRPgtM8uf50qkuQib0gLLuP0js4tWQsF096rMViklyE5xED3
   AY3Fy080FbCxwwAqh36SHLNqRSK4r9KTSmRfwznezrKxomyMImv2ieRDB
   hd6vEYZQuRE3PnJG+RcotFozOgbY35uQYd0LhxPSfJDltcC9GBDEk0/os
   eZ6d0NfM65B+fudIkz6ialBm1lI9p5bRHILhXWELZG035AikRYEka3PTW
   /h4KJk9FzElsmARswMFOgIRlBSMNbThO5PM8wGAms0ysyDziRuTMR7all
   lUE2j3f0TDinzQ4I19bDv/A7lXAV/0424WXt7bHIRaB4GPVC4jPZteU2b
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="336851957"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="336851957"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 19:49:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="814567147"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="814567147"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.160]) ([10.254.210.160])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 19:49:19 -0700
Message-ID: <29132993-25e1-3e9d-464c-b9037d5c71d3@linux.intel.com>
Date: Fri, 19 May 2023 10:49:17 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
 "will@kernel.org" <will@kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: arm-smmu-v3 sharing SID
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Peng Fan <peng.fan@nxp.com>
References: <DU0PR04MB94172CB3F138AD39E9B6DEEF887F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <359b01bc-e87a-9a50-c971-681e89985491@arm.com>
 <DU0PR04MB9417B971D20D1572FB598769887F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20230518130459.GA2587493@myrica>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230518130459.GA2587493@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/5/18 21:04, Jean-Philippe Brucker wrote:
> On Thu, May 18, 2023 at 11:44:56AM +0000, Peng Fan wrote:
>>> Subject: Re: arm-smmu-v3 sharing SID
>>>
>>> On 2023-05-18 11:46, Peng Fan wrote:
>>>> Hi all,
>>>>
>>>> Current arm-smmu-v3 driver does not support sharing SID, If there are
>>>> two devices sharing one SID, the smmu-v3 driver will report "stream x
>>>> already in tree".
>>>>
>>>> We have an SOC that using smmu-v3, only supports limited SIDs. From my
>>>> understanding, the smmu-v3 hardware supports SID sharing, but linux
>>>> driver not support that.
>>>
>>> Ugh, we've always hoped that nobody would build such a thing, since
>>> SMMUv3 allows for plenty of stream IDs for any reasonable system (Arm's
>>> implementations support at least 24 bits), and aliasing at the StreamID level
>>> does rather compromise the usefulness.
>>
>> We only support max 64 SIDs. So I am thinking to share SID, since we
>> have lots of dma channels.
>>
>>>
>>>> I would like know is it ok to add support for sharing SID?
>>>> Something like to use common rb_add/find, not
>>>> smmu-v3 driver local rb tree add/find.
>>>
>>> Not sure what you're thinking there - the StreamID tree is still private to the
>>> SMMU instance either way, and the existing arm_smmu_find_master()
>>> function is ideal for arm_smmu_device_group() to detect aliasing devices
>>> and group them appropriately. Then you also need some way to skip
>>> updating STEs that have already been touched for a previous device in the
>>> group (basically generalising what arm_smmu_install_ste_for_dev()
>>> currently does for duplicate StreamIDs owned by one device).
>>
>> Thanks for sharing insights. BTW, would you plan to add the support?
>>
>>>
>>> I'm fairly confident in reasoning about this for basic .attach_dev purposes,
>>> since I did implement the equivalent for SMMUv2, but I'm not sure I even
>>> want to think about what it would mean for SVA, PASIDs and nesting...
> 
> We should disable all these things for multi-device groups, it's not worth
> the headache. I think we used to but I can't find it anywhere. That said,
> I guess only PCIe PRI (not upstream) absolutely won't work with multiple
> devices sharing a SID, since page responses are routed back by RID to the
> endpoint.

I second that we only support pasid features with singleton group.

Previously we have below explicit check and comment in
iommu_sva_bind_device():

         /*
          * To keep things simple, SVA currently doesn't support IOMMU 
groups
          * with more than one device. Existing SVA-capable systems are not
          * affected by the problems that required IOMMU groups (lack of ACS
          * isolation, device ID aliasing and other hardware issues).
          */
         if (iommu_group_device_count(group) != 1)
                 goto out_unlock;

This fact still holds true today, but the check has been moved to
pci_enable_pasid():

         if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
                 return -EINVAL;

And the implementation of iommu_attach/detach_device_pasid() is quite
confusing. The pasid domains are stored in the iommu_group. The
attach/detach_device_pasid interfaces iterate all devices in the group
and set pasid domain to each device of the group.

This creates an illusion that the iommu core still insists on supporting
pasid on multiple device groups.

> Stall and by extension SVA can't really be supported with multiple devices
> per SID either, but that's mainly a software complexity issue (we'd need
> to guess which device it comes from, or report the fault for all devices).
> PASID and nesting might work transparently due to iommu_group, though I'd
> rather not think about that either.
> 
> It may boil down to updating the smmu->streams structure to support
> multiple masters per stream (maybe simplify the driver first by moving to
> a xarray [1]). That would provide a refcount for each SID and allow to
> only write the STE once on setup and teardown. Since arm_smmu_find_master()
> is only used to handle I/O page faults (stall/PRI which we won't support
> in this case), it could return NULL for multi-master streams.
> 
> Thanks,
> Jean
> 
> [1] https://lore.kernel.org/linux-iommu/ecb3725c-27c4-944b-b42c-f4e293521f94@arm.com/
> 

Best regards,
baolu
