Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6788F40
	for <iommu@lists.linux.dev>; Thu, 16 Nov 2023 03:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GeS2vE5m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700105378; x=1731641378;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e7Vj3hzUi2owuqUml83r8SMkIgCZDOcihonf5G65bzo=;
  b=GeS2vE5mYfjjW9LOo9IspmTanB5MCfSIGXkH1J8Rn+LcaKgRDFzQk1Ce
   01A5nJqBoNESlq8AYAVw1smvwxOH9XSzuCuws/EB1V8oCWHU7aowXXr2L
   HJSiH/jUB1Vc3QGNqFrkptv4bJx7cKlnZMSRoyoljZn/iC2DOLgFAjk70
   MHWBGDQ34sbfFRGlk5K6snXOb3DmPC82rw1jvbqe2Fa/EPGCRUeTW8mjO
   Sv+zyYc6M1tK+sk+TIQ/jS+49CGGpEFwrSHyDjpe1W4n2ajOS7kv2X2gG
   fJjpe40sV9dSW79xR1jS16FgQyy+WmqtIl7dZjXc+uWYJRcLRfMiXOyHz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="4132799"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="4132799"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 19:29:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="765180796"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="765180796"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga002.jf.intel.com with ESMTP; 15 Nov 2023 19:29:14 -0800
Message-ID: <d6e8fbaf-c49d-421f-ad05-7737060785ff@linux.intel.com>
Date: Thu, 16 Nov 2023 11:25:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] iommu/vt-d: Remove unused vcmd interfaces
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20231116015048.29675-1-baolu.lu@linux.intel.com>
 <20231116015048.29675-4-baolu.lu@linux.intel.com>
 <BN9PR11MB52762063ED9337AD624E62148CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52762063ED9337AD624E62148CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/16/23 11:21 AM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, November 16, 2023 9:51 AM
>>
>> Commit 99b5726b4423 ("iommu: Remove ioasid infrastructure") has
>> removed
>> ioasid allocation interfaces from the iommu subsystem. As a result, these
>> vcmd interfaces have become obsolete. Remove them to avoid dead code.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> it's a surprise to see some remaining vcmd bits not removed.
> 
> with a grep actually there are more (mostly in the header files):
> 
> drivers/iommu/intel/debugfs.c:  IOMMU_REGSET_ENTRY(VCMD),
> drivers/iommu/intel/pasid.h:#define VCMD_CMD_ALLOC                      0x1
> drivers/iommu/intel/pasid.h:#define VCMD_CMD_FREE                       0x2
> drivers/iommu/intel/pasid.h:#define VCMD_VRSP_IP                        0x1
> drivers/iommu/intel/pasid.h:#define VCMD_VRSP_SC(e)                     (((e) & 0xff) >> 1)
> drivers/iommu/intel/pasid.h:#define VCMD_VRSP_SC_SUCCESS                0
> drivers/iommu/intel/pasid.h:#define VCMD_VRSP_SC_NO_PASID_AVAIL 16
> drivers/iommu/intel/pasid.h:#define VCMD_VRSP_SC_INVALID_PASID  16
> drivers/iommu/intel/pasid.h:#define VCMD_VRSP_RESULT_PASID(e)   (((e) >> 16) & 0xfffff)
> drivers/iommu/intel/pasid.h:#define VCMD_CMD_OPERAND(e)         ((e) << 16)
> drivers/iommu/intel/iommu.h:#define DMAR_VCMD_REG               0xe00 /* Virtual command register */
> 
> 

Yeah! I will also remove these bits. Thanks!

Best regards,
baolu
