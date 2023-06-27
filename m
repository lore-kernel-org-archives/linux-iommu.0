Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F18E846A
	for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 07:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687851967; x=1719387967;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1NU8lxJjIxrwpz0Gz2CrvoCxNYYRc60/+WVK8Xm+dBU=;
  b=fXGl7b2bHsM5dX55CeGP0GPmWJP5iqzElg8Go/0I83B1y3idzo8Skq/Y
   PsI9oIKqBh1A04+Qh21HPEEjOaivy4R4hiwhL707sPoBkraFQP+z+bU5d
   fOTAZoseCO15b63PXSrxT/5ABNFbf7rg544Jz8db37wLF7k4Mh9kEs+ew
   CarOF7B+uWklCnjDerybDbYrmpBTpWH0SKdIKezo2CF1qGoD9aGd2rvNn
   9msdUbm4IbOyNjnmp5esdES5fDY2zdBNkAupgd/zvZ/H76rDdQbJBE3+7
   bM/PgZV3sY6xvrnpqkfm4Vc0037nnhC3wASPbLi0Wm7ZxNiV+3hlaJ2nZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="360370758"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="360370758"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 00:44:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="806363818"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="806363818"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.29]) ([10.254.215.29])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 00:44:37 -0700
Message-ID: <9a1d3012-d35c-d5a0-8aa9-99dcd7bded5e@linux.intel.com>
Date: Tue, 27 Jun 2023 15:43:35 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Cc: baolu.lu@linux.intel.com,
 Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
 Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <jroedel@suse.de>,
 Kevin Tian <kevin.tian@intel.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH rc] iommu: Fix crash during syfs iommu_groups/N/type
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>
References: <0-v1-5bd8cc969d9e+1f1-iommu_set_def_fix_jgg@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <0-v1-5bd8cc969d9e+1f1-iommu_set_def_fix_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/6/26 23:13, Jason Gunthorpe wrote:
> The err_restore_domain flow was accidently inserted into the success path
> in commit 1000dccd5d13 ("iommu: Allow IOMMU_RESV_DIRECT to work on
> ARM"). It should only happen if iommu_create_device_direct_mappings()
> fails. This caused the domains the be wrongly changed and freed whenever

minor: ...caused the domains to be wrongly changed...

> the sysfs is used, resulting in an oops:
> 
>    BUG: kernel NULL pointer dereference, address: 0000000000000000
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    PGD 0 P4D 0
>    Oops: 0000 [#1] PREEMPT SMP NOPTI
>    CPU: 1 PID: 3417 Comm: avocado Not tainted 6.4.0-rc4-next-20230602 #3
>    Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS 2.3.6 07/06/2021
>    RIP: 0010:__iommu_attach_device+0xc/0xa0
>    Code: c0 c3 cc cc cc cc 48 89 f0 c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 54 55 48 8b 47 08 <48> 8b 00 48 85 c0 74 74 48 89 f5 e8 64 12 49 00 41 89 c4 85 c0 74
>    RSP: 0018:ffffabae0220bd48 EFLAGS: 00010246
>    RAX: 0000000000000000 RBX: ffff9ac04f70e410 RCX: 0000000000000001
>    RDX: ffff9ac044db20c0 RSI: ffff9ac044fa50d0 RDI: ffff9ac04f70e410
>    RBP: ffff9ac044fa50d0 R08: 1000000100209001 R09: 00000000000002dc
>    R10: 0000000000000000 R11: 0000000000000000 R12: ffff9ac043d54700
>    R13: ffff9ac043d54700 R14: 0000000000000001 R15: 0000000000000001
>    FS:  00007f02e30ae000(0000) GS:ffff9afeb2440000(0000) knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 0000000000000000 CR3: 000000012afca006 CR4: 0000000000770ee0
>    PKRU: 55555554
>    Call Trace:
>     <TASK>
>     ? __die+0x24/0x70
>     ? page_fault_oops+0x82/0x150
>     ? __iommu_queue_command_sync+0x80/0xc0
>     ? exc_page_fault+0x69/0x150
>     ? asm_exc_page_fault+0x26/0x30
>     ? __iommu_attach_device+0xc/0xa0
>     ? __iommu_attach_device+0x1c/0xa0
>     __iommu_device_set_domain+0x42/0x80
>     __iommu_group_set_domain_internal+0x5d/0x160
>     iommu_setup_default_domain+0x318/0x400
>     iommu_group_store_type+0xb1/0x200
>     kernfs_fop_write_iter+0x12f/0x1c0
>     vfs_write+0x2a2/0x3b0
>     ksys_write+0x63/0xe0
>     do_syscall_64+0x3f/0x90
>     entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>    RIP: 0033:0x7f02e2f14a6f
> 
> Reorganize the error flow so that the success branch and error branches
> are clearer.
> 
> Cc:<stable@vger.kernel.org>
> Fixes: 1000dccd5d13 ("iommu: Allow IOMMU_RESV_DIRECT to work on ARM")
> Reported-by: Dheeraj Kumar Srivastava<dheerajkumar.srivastava@amd.com>
> Tested-by: Vasant Hegde<vasant.hegde@amd.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
