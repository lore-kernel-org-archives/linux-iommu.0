Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB5B620
	for <iommu@lists.linux.dev>; Wed, 31 Aug 2022 01:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661907758; x=1693443758;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4g2unoSDN1ukBbO1EGZvQu17z9pHdUQ6vWbPZmoPISc=;
  b=iwBJGqLhPWaxyrGXq6Ir/k7K/mTfwtD8Y6MCjHrxOljiFjT7SFfF43Si
   ExWOkzmp0HZrF2XrdDL9B8uqAQ+FUcBg4O7SahlH6Tm+iCqrYztpBdgqk
   pbQSAIKq7zhGKo3YBQBs2qq8nHCxUcSUyZwsGKdtm/ZXdZmR/Ei1Oid/y
   zDqAqlpfjdHc1I1iXpIG7TRf6hWyRCleptcSdEJhyJ49Oao9g5urJ87nB
   HBXmL69O0UgMveG0S7MSPTuxjwCydNGVvQimpWt/Yj9shTjZD2jY5S1pP
   d+cMSrKdqbyMMlEh3En5O4m0wpUDEho6ubZHV4LGManIv2h7XryOlGz8n
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="275744293"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="275744293"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 18:02:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="608040973"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 30 Aug 2022 18:02:35 -0700
Message-ID: <3aa28716-9d91-321a-0e52-58ae425ac598@linux.intel.com>
Date: Wed, 31 Aug 2022 08:57:05 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: baolu.lu@linux.intel.com, Raj Ashok <ashok.raj@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@intel.com>,
 Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 2/2] iommu: Use the user PGD for SVA if PTI is enabled
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, x86@kernel.org,
 Joerg Roedel <joro@8bytes.org>
References: <20220822201213.352289-1-jacob.jun.pan@linux.intel.com>
 <20220822201213.352289-3-jacob.jun.pan@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220822201213.352289-3-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/23/22 4:12 AM, Jacob Pan wrote:
> With page table isolation, the kernel manages two sets of page tables
> for each process: one for user one for kernel. When enabling SVA, the
> current x86 IOMMU drivers bind device and PASID with the kernel copy
> of the process page table.
> 
> While there is no known "Meltdown" type of DMA attack, exposing
> kernel mapping to DMA intended for userspace makes the system vulnerable
> unnecessarily. It also breaks the intention of PTI.
> 
> This patch replaces kernel page table PGD with the user counterpart,
> thus fulfill the promise of PTI on the DMA side.
> 
> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
