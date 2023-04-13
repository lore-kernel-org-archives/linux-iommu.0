Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5AC62F
	for <iommu@lists.linux.dev>; Thu, 13 Apr 2023 04:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681359169; x=1712895169;
  h=message-id:date:mime-version:cc:subject:from:to:
   references:in-reply-to:content-transfer-encoding;
  bh=Qx1roPB9NVHKquwWhlDSEPgRlas4fd/F7m3pwsubR+4=;
  b=aqQguHsJEDw0gBKPy2bVUq2NtNHyN3V+aJzuB6zQCbDaxSB9mfFwJADa
   Q/b4LVwkkSNdFPFQzesqGZHdydIc4m1ai0DZTvHk0SjCsQ8tpgI1Q9HS4
   RyCVe4hAmZWTGyxrnFf6V8GfZ4+2xENe0Au/o3n+unvXtHjoW3w3v1YhT
   YR8CRmSvTCSEiw+qTykzeveIXQ/xJoCqR0F7wzSopaevE9Auy4IU1twIJ
   spAZWsM6ax/ne8ZJq3houdx1LJeyYwkrX61ywRVEIH387IOgZHjEWAqn9
   +UOohUA1MA36dbmsGGsMfHJu+yTC5MPdLTpmYa3SgJC8AJEJi9YTxCsV4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="345872341"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="345872341"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 21:12:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="753808034"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="753808034"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga008.fm.intel.com with ESMTP; 12 Apr 2023 21:12:15 -0700
Message-ID: <aab4ab9b-1e5b-6ad8-385e-46f0240a23cf@linux.intel.com>
Date: Thu, 13 Apr 2023 12:12:19 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc: Vinod Koul <vkoul@kernel.org>, Tina Zhang <tina.zhang@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] [PULL REQUEST] Intel IOMMU updates for Linux v6.4
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
In-Reply-To: <20230411064815.31456-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/23 2:47 PM, Lu Baolu wrote:
> Hi Joerg,
> 
> This includes patches queued for v6.4. They are:
> 
>   - Allow the VT-d driver to support non-PRI IOPF
>   - Remove PASID supervisor request support
>   - Various small and misc cleanups
> 
> This series also includes an idxd patch to avoid driver regression after
> changes in the IOMMU driver. It has been reviewed by the driver's
> maintainers. Please feel free to let me know if it's inappropriate to
> route it through the iommu tree.
> 
> The whole series is based on v6.3-rc6 and also available at:
> https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.4
> 
> Please pull them for x86/vt-d branch.

Hi Joerg,

I just sent a v2 for this pull request. I addressed David's comments
there.

https://lore.kernel.org/linux-iommu/20230413040645.46157-1-baolu.lu@linux.intel.com/

Best regards,
baolu
