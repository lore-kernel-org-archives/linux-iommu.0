Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3BC6105
	for <iommu@lists.linux.dev>; Fri, 24 Feb 2023 15:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677252354; x=1708788354;
  h=message-id:date:mime-version:to:from:subject:
   content-transfer-encoding;
  bh=ItKIGG5N+/UxjvEatvaLc6JjkF8GckzsoSLKWMW7h34=;
  b=n7nYn95mL4/tqBnBD93b7dilutqdBA6gO1Ls2FHdj+tn4XKw+vJfia+U
   jNWz6uGpmW0LWLCVDNCbp8jROFxScuS40t/JfGjTYvBDkAl9DMSRyTCcS
   fHT2jia9Ego3s9c/TVDIEJdkz91osghtOERre0Qr3zP1uGgqyhtIeJyC6
   2NLBU7gdUEpcCBF5CMWle0Y8aoDgVqw+8Bfy3iCdPKUBxtQaeThmWRiT9
   FLAgv8d9SG7Km/YWdqZhJ4sVLZl02sYH2VTNiYlutTNUEeKDCD6C4UItx
   dePyA/TR4lqqJenQ7l6pewm2qxxilvHxCIKOerAdUziM0k73N/FNo0B0w
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="335732728"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="335732728"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 07:25:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="674962912"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="674962912"
Received: from mbrenk-mobl1.ger.corp.intel.com (HELO [10.249.254.65]) ([10.249.254.65])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 07:25:51 -0800
Message-ID: <70208b6f-8428-dd87-93e7-393ad3146d47@linux.intel.com>
Date: Fri, 24 Feb 2023 16:25:49 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To: "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Content-Language: en-US
From: =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas.hellstrom@linux.intel.com>
Subject: Combine IOMMU recoverable page faults with dma mappings?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Forgive an ignorant question, but is it possible to combine an IOMMU 
recoverable page-fault mapping of
user-space addresses with mappings set up with the dma api in the same 
PASID? I was thinking something
along the first half or the PASID address pace matches the CPU 
user-space address space whereas the second half mirrors the mappings 
set up by the DMA API (or rather the first half of it?)

The use-case is a device mapping where we typically use the mmu range 
notifier to map relevant parts of
a user-space CPU address space, but where we can't halt DMA fast enough 
in the mmu notifier invalidation callback for the system to remain 
responsive. IOMMU pagefaults could be a good replacement, but we still 
need to be able to map device-allocated system pages within the same PASID.

Any comments or guidance appreciated.

Thanks,
Thomas


