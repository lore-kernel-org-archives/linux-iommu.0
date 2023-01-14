Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B527C
	for <iommu@lists.linux.dev>; Sat, 14 Jan 2023 06:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673678651; x=1705214651;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZWBI4yEDtYe5SgIEcmnWVxcrxOfnPV3XsNS6rea3BZo=;
  b=mP7fGvjt1+ud+XuHWFHl+1vnYGoGKQwYFoUTDNTrc/ofR4tXcM1H1zRD
   jocudS+W55Wrrs7F2lRzVke2GrahwIFPm2EGWJmzaeMM7tU8ldgKjuH98
   HpVlA8FuIzxuSCmyYkkrLUbqtcd8c6DSVztn7ZZ6hxq+Y/umrgDVyQBfJ
   xoHcmDxOYhHZojbXUk8B9hnl0s8qEYEhQnaQqZx73Qs4I48X2aIBeoVRM
   atWCsXWQ9PnCrqJ+b8+BnNbD1TkjVa5A4FEJb3fQHhr5qAmHPgHtH5u4k
   UL/yl8agvavaAFQ4ULCyBm9GqOQJHKpLOql1HfuY9cObHEDJQV3NMuqev
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="325427796"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="325427796"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 22:44:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="987245324"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="987245324"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.184.153]) ([10.252.184.153])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 22:44:07 -0800
Message-ID: <76e7b9fe-5ee5-83f6-0e91-4d07e8e821f8@linux.intel.com>
Date: Sat, 14 Jan 2023 14:44:04 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Sven Peter <sven@svenpeter.dev>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Remove ipmmu_utlb_disable()
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>
References: <20230113185640.8050-1-joro@8bytes.org>
 <Y8GtFcNq2jugBpI3@ziepe.ca> <Y8GwHQLKnXyqa3Ty@8bytes.org>
 <Y8G06onFowE3ZIy8@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y8G06onFowE3ZIy8@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/1/14 3:45, Jason Gunthorpe wrote:
> On Fri, Jan 13, 2023 at 08:25:17PM +0100, Joerg Roedel wrote:
>> On Fri, Jan 13, 2023 at 03:12:21PM -0400, Jason Gunthorpe wrote:
>>> I'm surprised the 0-day bot didn't notice?
>>
>> Well, I think 0-day does not spend that much time on iommu patch-sets,
>> especially doing randconfigs or allyes/modconfigs.
> 
> Intel folks, can you check on this with the 0-day team? Perhaps since
> the list was moved it is not properly subscribed.

I've forwarded this thread to the Intel 0-day team.

> 
>> In general it is a good idea to at least compile-test every file that is
>> changed in a patch-set before sending it out and not rely on 0-day bot
>> for that.
> 
> Against every arch combination? This is why we have automation bots :(
> 
> Jason
> 

--
Best regards,
baolu
