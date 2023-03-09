Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D3D947A
	for <iommu@lists.linux.dev>; Thu,  9 Mar 2023 14:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678370564; x=1709906564;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tbBO1XF9px/UsbckwD/VzZzCEHWREMG7gRd+33hcda8=;
  b=JX0/Ex6aG6wyWWcNpcf5XQgAdDDYh8tVink8RnQsiq9aOiv0//JXVZhl
   tmXkxoA0XBlM+cxZLZJsgYjZUp8mmhsy9ahFMrejmc8hX1qHaP/EAT6Ug
   akO4oPxq/cE/yKzC+gTZgXLMe3EX3T4jdnqc2lDNSxiys1niLfj+6jiHP
   6KbxQK05cYnZ8a+5VYJA2QRLr49j6lBazIGoaAord+eV9elfmkjjFZzgQ
   h6iE2UYnTDGWCCVRb2i/p6K8Cwvp/0dqjtQob3g+KYPEPTicvHOECjPud
   sGnnWO6uaUQkh6R1NO88JuglVMePj68lEpw9huIjiJqnsORwn4FsYnUDR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="422718827"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="422718827"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 06:02:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="707619130"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="707619130"
Received: from xueyingl-mobl.ccr.corp.intel.com (HELO [10.249.171.149]) ([10.249.171.149])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 06:02:25 -0800
Message-ID: <0193b5e3-68b5-16e8-b4e8-7fc5a3175a25@linux.intel.com>
Date: Thu, 9 Mar 2023 22:02:21 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc: baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
 chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com, peterx@redhat.com,
 jasowang@redhat.com, shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/12] iommufd: Add nesting infrastructure
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, alex.williamson@redhat.com,
 jgg@nvidia.com, kevin.tian@intel.com, robin.murphy@arm.com
References: <20230309080910.607396-1-yi.l.liu@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230309080910.607396-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/9 16:08, Yi Liu wrote:
> Nested translation is a hardware feature that is supported by many modern
> IOMMU hardwares. It has two stages (stage-1, stage-2) address translation
> to get access to the physical address. stage-1 translation table is owned
> by userspace (e.g. by a guest OS), while stage-2 is owned by kernel. Changes
> to stage-1 translation table should be followed by an IOTLB invalidation.

The last sentence is not always true. If any entry of the stage-1
translation table is changed from non-present to present, the IOTLB has
no chance to cache it yet. Hence there's no need for invalidation.

Best regards,
baolu
