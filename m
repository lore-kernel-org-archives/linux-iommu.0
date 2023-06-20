Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8E715B2
	for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 05:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687238019; x=1718774019;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9ILhoGo0+BoaYI4NjjHXvPsTSFIzBvrK8enoxKt18Mg=;
  b=eFiNl2e1vnhX90qgw5TyPNt919Ah3fPbwMI3fC5mVA/juRYzPaG9TnXV
   B5iDZtUIhR+CzuJyFBpT47cUEnhCaBy1+8kl7CNvyXpdrhxaEd90BquzP
   SuNuXDUaW98Fe2M4/N1z9xF/Pth3/0WPb9ESV0luKXLv8Q2eIfbdvfTNR
   h5nqwbDML0v3WwxzTTU1X15TxNfaSm7sxWzeTeioufLJC9bekN+I4Ll+0
   QbPB313gwwSU/UgHUoFJ345taj0duPQUGdG6VcD/ggm+J7fWxj6zJHr14
   /HtKtoFj1TjtPWkR79A4JhmkslRmKgsOCRg87jbepfivuAD+0d0kcF5A8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="425721706"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="425721706"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 22:13:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="838076351"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="838076351"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga004.jf.intel.com with ESMTP; 19 Jun 2023 22:13:36 -0700
Message-ID: <5b4f9e9a-ef97-94c4-ba3f-364b5ba30eff@linux.intel.com>
Date: Tue, 20 Jun 2023 13:12:21 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
 Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Subject: Re: [PATCH iommu/next] iommu: Fix default domain setup
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
References: <20230614055627.27286-1-vasant.hegde@amd.com>
 <851e7760-94e2-9691-f059-e48aac9d51ca@linux.intel.com>
 <358def2d-163d-ea57-c0c7-6d4affc68d0d@amd.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <358def2d-163d-ea57-c0c7-6d4affc68d0d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/19/23 2:49 PM, Vasant Hegde wrote:
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 9e0228ef612b..d21d0a217bdf 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -2880,7 +2880,6 @@ static int iommu_setup_default_domain(struct iommu_group
>>> *group,
>>>        }
>>>          /* We must set default_domain early for __iommu_device_set_domain */
>> Is the above comment still relevant? If yes, this fix seems to be
>> problematic. Or no?
> I think we should keep below change.

If the change is necessary then we should remove above comment with
sufficient justification.

Best regards,
baolu

