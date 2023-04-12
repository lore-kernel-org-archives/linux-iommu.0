Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC975660
	for <iommu@lists.linux.dev>; Wed, 12 Apr 2023 13:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305154; x=1712841154;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pHDdNub1XE313y0o+udCKvVcUwWqzEfrQeWMSLbvAXY=;
  b=YU0ZtwMDGn66B4Kiy6uKFbKqY5NvkVLKHLE22PQWiHhfa7FbHh9pdJDE
   /Z3mSbCdGxA2H3qk7+/wjThfuXwBXxKmMTnt68Yvuw0lJg0i5qqlnsfbk
   rbHvcdDP1LWLbaW4eour45h7sMMshPy7yKfkgULUfNUDeC/OH9eiv/V0q
   UeZ96lXU8MCF72qcVqjVmLnKGhoPzJs3Oa9dhNrBj25D9jl4qVgKpqmzV
   NcogWFyZw/CMsS8exTK6N01JcYozzSRZkk2aK0MkX49j+Hho2fQmcxywi
   3FL0aG8lHqBiJwJcXA4wbY7FkMd5hYWvfOowGVGO8nfWASoV9OFGK0mC2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332586540"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332586540"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:10:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="721563470"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="721563470"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.58]) ([10.254.215.58])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:10:32 -0700
Message-ID: <cbf041c7-119b-e23a-185d-288194629324@linux.intel.com>
Date: Wed, 12 Apr 2023 21:10:30 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Cc: baolu.lu@linux.intel.com, Vinod Koul <vkoul@kernel.org>,
 Tina Zhang <tina.zhang@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/17] iommu/vt-d: Fix operand size in bitwise operation
To: David Laight <David.Laight@ACULAB.COM>, Joerg Roedel <joro@8bytes.org>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
 <20230411064815.31456-12-baolu.lu@linux.intel.com>
 <ec1536af68e6478a9b10a0d884cc988d@AcuMS.aculab.com>
 <6d9ed10d-12ee-792f-fc34-60a8e432c5d2@linux.intel.com>
 <b6ab9a30960d41c9b42e5880b89277e3@AcuMS.aculab.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <b6ab9a30960d41c9b42e5880b89277e3@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/4/12 15:11, David Laight wrote:
> From: Baolu Lu
>> Sent: 12 April 2023 02:32
>>
>> On 4/12/23 5:22 AM, David Laight wrote:
>>>> Sent: 11 April 2023 07:48
>>>>
>>>> From: Tina Zhang<tina.zhang@intel.com>
>>>>
>>>> The patch fixes the klocwork issues that operands in a bitwise operation
>>>> have different size at line 1692 of dmar.c, line 1898 and line 1907 of
>>>> iommu.c.
>>> Why is this any kind of thing that needs fixing?
>>
>> This description is a bit misleading. Actually I queued it as a cleanup
>> patch.
> 
> Hopefully without 'fix' anywhere in the description.
> Otherwise the scripts will pick it for a back-port.

Fair enough.I will refine the commit message like below:

iommu/vt-d: Make size of operands same in bitwise operations

The addresses the following issue reported by klocwork tool:

  - operands of different size in bitwise operations

Suggested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>

> 
>>> -		val |= (1 << 11) | 1;
>>> +		val |= BIT_ULL(11) | BIT_ULL(0);
> 
> More problematic it what is bit 11 anyway?

There is already a comment at the top of the code explaining the meaning
of these bits. Because this is not a newly added code, it is not
displayed in this patch.

         /*
          * Set DW=1 and QS=1 in IQA_REG when Scalable Mode capability
          * is present.
          */
         if (ecap_smts(iommu->ecap))
                 val |= BIT_ULL(11) | BIT_ULL(0);

Best regards,
baolu
