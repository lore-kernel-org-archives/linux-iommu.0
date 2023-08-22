Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9169017EE
	for <iommu@lists.linux.dev>; Tue, 22 Aug 2023 06:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692686211; x=1724222211;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=afCoa/ZZo8JlXd4rmTwsUfx9qsQ2KBQvigqx0/qmV5A=;
  b=JDKkXbZk2eyh9pqnqeGIsNar/Qhfs3H3P3TWWYO/pBqtBgwhoMRNXnrI
   pjeTFmwloXKdtm+jyqNe+D8TrASk7Vn9B594EaX0oSTgJaSKXwJIXFR6s
   XNRnU227ia8XYDDUot1riimsNvhhFUYEiZt4IViDCjS4SqUdf6krtzKAA
   LQseG/5Y07syHnlXHjYztKkhiFfpxLf2KB4oyVR6ak/o6za/kl8s7PvvZ
   yRygm9iq8Yhp0NlexljjfhPrsqD9ZnowqPf4oGEwcTihtkcFqp1kaD5G2
   c6UneL7IpY6nrllsYXG6kPXrcvikwarOxCJSiscidGhN8ZOHVvz+xUx3Z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="404795977"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="404795977"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 23:36:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="801540554"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="801540554"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.189.107]) ([10.252.189.107])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 23:36:44 -0700
Message-ID: <93811e0c-ff04-366d-493e-7186e4588359@linux.intel.com>
Date: Tue, 22 Aug 2023 14:36:40 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc: baolu.lu@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iommu: Make single-device group for PASID explicit
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20230814011759.102089-1-baolu.lu@linux.intel.com>
 <20230814011759.102089-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276E3C3D99C2DFA963805C98C1BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <51dfc143-aafd-fea2-26fe-e2e9025fcd21@linux.intel.com>
 <BN9PR11MB5276EBE5788713FBA99332F88C1EA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276EBE5788713FBA99332F88C1EA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/21 14:33, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Monday, August 21, 2023 1:45 PM
>>
>> On 2023/8/18 11:56, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Monday, August 14, 2023 9:18 AM
>>>>
>>>> The PASID interfaces have always supported only single-device groups.
>>>> This was first introduced in commit 26b25a2b98e45 ("iommu: Bind
>> process
>>>> address spaces to devices"), and has been kept consistent in subsequent
>>>> commits.
>>>>
>>>> However, the core code doesn't explicitly check for this requirement
>>>> after commit 201007ef707a8 ("PCI: Enable PASID only when ACS RR & UF
>>>> enabled on upstream path"), which made this requirement implicit.
>>>>
>>>> Restore the check to make it explicit that the PASID interfaces only
>>>> support devices belonging to single-device groups.
>>>>
>>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>> ---
>>>>    drivers/iommu/iommu.c | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index 71b9c41f2a9e..f1eba60e573f 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -3408,6 +3408,11 @@ int iommu_attach_device_pasid(struct
>>>> iommu_domain *domain,
>>>>    		return -ENODEV;
>>>>
>>>>    	mutex_lock(&group->mutex);
>>>> +	if (list_count_nodes(&group->devices) != 1) {
>>>> +		ret = -EINVAL;
>>>> +		goto out_unlock;
>>>> +	}
>>>> +
>>>
>>> I wonder whether we should also block adding new device to this
>>> group once the single-device has pasid enabled. Otherwise the
>>
>> This has been guaranteed by pci_enable_pasid():
>>
>>           if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
>>                   return -EINVAL;
>>
> 
> well since you are adding generic core check then it's not good to
> rely on the fact of a specific bus...

We attempted to do this in the patch linked below.

https://lore.kernel.org/linux-iommu/20220705050710.2887204-5-baolu.lu@linux.intel.com/

After long discussion, we decided to move it to the pci_enable_pasid()
interface. The non-static single device group is only relevant to PCI
fabrics that support hot-plugging without ACS support on the upstream
path.

Best regards,
baolu
