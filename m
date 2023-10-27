Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608905245
	for <iommu@lists.linux.dev>; Fri, 27 Oct 2023 06:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mKG1UFNT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698386956; x=1729922956;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+DrVyO/lmmzNiD355grMg157EiJ4H0MKLPJHIYM0VSM=;
  b=mKG1UFNT+mlANRW8ML17QeyB+uwjp1Fu6UqRQjQOTgQWrU71h0jEjDUv
   45DllGW0JNvuX7ZysimkM/uCGWFL4Q6duTGz3F9C6VO7syfAALBOvxMtt
   gNGkoBF8CvFUjj6qXEIgWMaNFLdTq2rTpAE4M4phTzebzDf+XeBTCALK/
   Ez6Alu+78wyOROrV/15Ot4yYyNt223BPpO0oON670takaBk9HvHyl3Tok
   UPe3E6S1WypvGa0rIMeIX1IwWGZnIM9HvmaDJ28Wl8WoryBCg3D84/sMq
   yRE/rHCj8Lk3V2m6alWpNJEtFGCdmC+FhL5diYOTQ8KxhaFpOx9eJGXE0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="418823664"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="418823664"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 23:09:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="708126"
Received: from jiaqingh-mobl.ccr.corp.intel.com (HELO [10.93.11.63]) ([10.93.11.63])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 23:08:35 -0700
Message-ID: <bf2dbc64-a6b6-4763-b497-80f0f1675366@intel.com>
Date: Fri, 27 Oct 2023 14:09:11 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu: Introduce a rb_tree for looking up device
Content-Language: en-US
To: Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, dwmw2@infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
Cc: jacob.jun.pan@linux.intel.com, kevin.tian@intel.com, yi.y.sun@intel.com,
 kvm@vger.kernel.org
References: <20231024084124.11155-1-jiaqing.huang@intel.com>
 <5a4c169d-8e42-4609-87db-8b68f04bb0fe@linux.intel.com>
From: "Huang, Jiaqing" <jiaqing.huang@intel.com>
In-Reply-To: <5a4c169d-8e42-4609-87db-8b68f04bb0fe@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/2023 7:58 PM, Baolu Lu wrote:

> On 2023/10/24 16:41, Huang Jiaqing wrote:
>> The existing IO page fault handler locates the PCI device by calling
>> pci_get_domain_bus_and_slot(), which searches the list of all PCI
>> devices until the desired PCI device is found. This is inefficient
>> because the algorithm efficiency of searching a list is O(n). In the
>> critical path of handling an IO page fault, this is not performance
>> friendly given that I/O page fault handling patch is performance
>> critical, and parallel heavy dsa_test may cause cpu stuck due to
>> the low efficiency and lock competition in current path.
>>
>> To improve the performance of the IO page fault handler, replace
>> pci_get_domain_bus_and_slot() with a local red-black tree. A red-black
>> tree is a self-balancing binary search tree, which means that the
>> average time complexity of searching a red-black tree is O(log(n)). This
>> is significantly faster than O(n), so it can significantly improve the
>> performance of the IO page fault handler.
>>
>> In addition, we can only insert the affected devices (those that have IO
>> page fault enabled) into the red-black tree. This can further improve
>> the performance of the IO page fault handler.
>>
>> This series depends on "deliver page faults to user space" patch-set:
>> https://lore.kernel.org/linux-iommu/20230928042734.16134-1-baolu.lu@linux.intel.com/
>>
>
> The note above is not part of the commit message, and should be placed
> below the tear line or in the cover letter, if there is one.

Will fix, thanks for catching!

BRs,
Jiaqing
