Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47321FD0
	for <iommu@lists.linux.dev>; Mon,  8 Aug 2022 03:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659931010; x=1691467010;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FCwEs46tCUBeH45UUcOwuVoyCRQxW8P/kZO2NYT1VX4=;
  b=JZ9SEcqmsl/jMG2hhAptHictYc+GXuLVMybE1HeS3ddJZKTlH1oZI5dG
   AXZqibTvslr9os96vey0v+phycpjS0VblHGC7CVZ02GhN+SBqkXCeS0UQ
   7AHTk/5iJpliGwJja3nM5iLbrYqNDOR/pX9IO1phCcVh1Ru4vJy/6CLCV
   7diUBEMafS3tmBDH3lQbauI5rr0gi0Mn4rDU87IhKl2ronAerRpundkfn
   c8WQ87ZrWbgNafgtph6BGHzfxRuitJKn5jjAtnpJZr/Ww7KgKUpmoHdt5
   SUZu6IPgdzQBgi2bqQAp0gVMcB55yTzPppQjcjV5kBXB/EWgqIC+H+o5h
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="273544112"
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="273544112"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 20:56:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="931877149"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.228]) ([10.254.211.228])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 20:56:48 -0700
Message-ID: <ee49e711-d4bb-bf77-6bb0-714a217f0786@linux.intel.com>
Date: Mon, 8 Aug 2022 11:56:46 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Cc: baolu.lu@linux.intel.com
Subject: Re: Scalable mode and kdump kernels
Content-Language: en-US
To: Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>
References: <20220702154956.x2dxqalzjuzjraxk@cantor>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220702154956.x2dxqalzjuzjraxk@cantor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jerry,

On 2022/7/2 23:49, Jerry Snitselaar wrote:
> Apparently there is an issue on Sapphire Rapids if you have the following conditions:
> 
> - kernel configured to default to passthrough dma domains, or set it on the command line
> - scalable mode enabled
> 
> If you force a system crash, there will be a number of DMAR faults
> when booting the kdump kernel, with the result being it doesn't mount
> the disk and harvest the vmcore.  The fault reason is 0x39, which is no
> present bit in the scalable mode root entry.
> 
> Looking at the translation table copying code, it looks like what is
> there currently is based on the older 2.5 vt-d spec and the extended
> root/context entry formats, and doesn't handle the scalable mode
> formats. The pasid enabled bit has moved in the scalable mode context
> entry from bit 11 to bit 3, and the translation type mode in the root
> table address register is different as well. Poking around at it last
> night, adding code to deal with those just shifts to the problem to
> the present bit in the scalable mode pasid table entry (fault reason
> 0x59) which isn't copied.
> 
> Beyond the translation table copy bits needing to work with scalable
> mode formats, should scalable mode force the default dma domain type
> to switch to one of the translation modes if the default is passthrough?

I posted a fix patch for this issue. Can you please give it a try?

https://lore.kernel.org/linux-iommu/20220808034612.1691470-1-baolu.lu@linux.intel.com/

Best regards,
baolu
