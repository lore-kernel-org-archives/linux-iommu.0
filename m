Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215C4224FE
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YeUaP9Ox"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698148737; x=1729684737;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pnGRnp7vVwZkr643r1FTOWjeVjSHpkg1wCabNnnRz1c=;
  b=YeUaP9OxvvTTdC62G/BIZ4XGysbd3K6rLD174uEdB9iTDsOH0PfPOEjB
   eFsPDo+zRMwL6E9KUv6s1IyOaxrYZnISdNl75Zi9AiNjStDdLPVTY5fyy
   k3kFKwMIKmyonZKMqIn9RGQbW4FlQmLBxX3eXSyrUHcXt+dUcXkF5DokN
   ejEO09Szrjl4QvmECyIUCj3QNCa3jenVggQV7DzE2h2DB4gMPvrTCHdGE
   KXdPdCUuBohQdob16XecmQnZzbbl83bvZr8YDBXFU2gDJrSXcpba9Vdj1
   e2BMTS8KNDkBcNLVdTtJPLJkvQMhteCczT8RySlr0CjBtV9Lf0cJ1lb+6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="384239197"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="384239197"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 04:58:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="6153680"
Received: from qiangfu1-mobl1.ccr.corp.intel.com (HELO [10.254.212.47]) ([10.254.212.47])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 04:57:35 -0700
Message-ID: <5a4c169d-8e42-4609-87db-8b68f04bb0fe@linux.intel.com>
Date: Tue, 24 Oct 2023 19:58:50 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, jacob.jun.pan@linux.intel.com,
 kevin.tian@intel.com, yi.y.sun@intel.com, kvm@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu: Introduce a rb_tree for looking up device
Content-Language: en-US
To: Huang Jiaqing <jiaqing.huang@intel.com>, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20231024084124.11155-1-jiaqing.huang@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231024084124.11155-1-jiaqing.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/10/24 16:41, Huang Jiaqing wrote:
> The existing IO page fault handler locates the PCI device by calling
> pci_get_domain_bus_and_slot(), which searches the list of all PCI
> devices until the desired PCI device is found. This is inefficient
> because the algorithm efficiency of searching a list is O(n). In the
> critical path of handling an IO page fault, this is not performance
> friendly given that I/O page fault handling patch is performance
> critical, and parallel heavy dsa_test may cause cpu stuck due to
> the low efficiency and lock competition in current path.
> 
> To improve the performance of the IO page fault handler, replace
> pci_get_domain_bus_and_slot() with a local red-black tree. A red-black
> tree is a self-balancing binary search tree, which means that the
> average time complexity of searching a red-black tree is O(log(n)). This
> is significantly faster than O(n), so it can significantly improve the
> performance of the IO page fault handler.
> 
> In addition, we can only insert the affected devices (those that have IO
> page fault enabled) into the red-black tree. This can further improve
> the performance of the IO page fault handler.
> 
> This series depends on "deliver page faults to user space" patch-set:
> https://lore.kernel.org/linux-iommu/20230928042734.16134-1-baolu.lu@linux.intel.com/

The note above is not part of the commit message, and should be placed
below the tear line or in the cover letter, if there is one.

> 
> Signed-off-by: Huang Jiaqing <jiaqing.huang@intel.com>
> ---
>   drivers/iommu/io-pgfault.c | 104 ++++++++++++++++++++++++++++++++++++-
>   include/linux/iommu.h      |  16 ++++++
>   2 files changed, 118 insertions(+), 2 deletions(-)

Best regards,
baolu
