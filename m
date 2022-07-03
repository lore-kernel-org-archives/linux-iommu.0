Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F88441A
	for <iommu@lists.linux.dev>; Sun,  3 Jul 2022 04:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656824195; x=1688360195;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e5bt0jdKAEDseQOPq8JD71rk8uXlJ1O3Ql15bVD41do=;
  b=KDvFmf0BUo09wdo3VMmFS1U6SrUwL869RjYYb0zHaU8XICbSPrwfjgDW
   LKMhJHtRKrVVyWDnK/XMG6jmB6f4PFDE9POC5ipp90WTdVWBCTraJnbuW
   x8P0LEhcI8cVUf9XuxtqQu3BP2koBeyr1GiuXo4Ir/wakY9vTbjeNINOk
   vU7nWqZUFcpsJPPQD+8eVEqQaemQwlTPdfyNJv99NiIRsotmBBHjnwdxl
   dT5Yhi6mHgcv6/GR18rAJMMbzx8jAH/hnReP3gl/llhj24Xh/Ov8rBmQl
   WWAjXGAV+ZcIDAGnAQJdC2sFk9lvX2ch1Z6meHsTW0rmEjt2deS6XC84a
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="265930819"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="265930819"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 21:56:34 -0700
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="648971158"
Received: from sunqi-mobl1.ccr.corp.intel.com (HELO [10.249.173.69]) ([10.249.173.69])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 21:56:33 -0700
Message-ID: <1fb81dd8-7fc5-ddce-6b78-2bb2b1c03fa3@linux.intel.com>
Date: Sun, 3 Jul 2022 12:56:31 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
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

Yes. It is written for ECS mode, which has no real hardware
implementation in the market.

> formats. The pasid enabled bit has moved in the scalable mode context
> entry from bit 11 to bit 3, and the translation type mode in the root
> table address register is different as well. Poking around at it last
> night, adding code to deal with those just shifts to the problem to
> the present bit in the scalable mode pasid table entry (fault reason
> 0x59) which isn't copied.

The translation mode bits are in the pasid table entries, hence to make
that work, the pasid tables should also be copied.

> 
> Beyond the translation table copy bits needing to work with scalable
> mode formats, should scalable mode force the default dma domain type
> to switch to one of the translation modes if the default is passthrough?

Agreed. The copy table code needs some extensions to support the
scalable mode.

Best regards,
baolu
