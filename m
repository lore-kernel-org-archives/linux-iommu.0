Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AFD1FA0
	for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 02:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663813761; x=1695349761;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xzZUwTfwlHTWrPQgmoKLFFVPv4RovsUidZyXm+C/SNc=;
  b=IiHf9xse526CvPY/0G0kavyg7iUP8cjn5wt834BmNSvJ1J7jvFTK5pgp
   rIaZ/bifNRW6CL1bzC2lh1iLU2APFFgTVlk4m6ThEsxKwoqv9BS0ANrHD
   NZ8o0ZWRjwXNg2dnR+jZneslXlA3h4y7t3/1b9X5aeJDbBSMo2IQod8Om
   ZeedKbFcLEaSw+diFgUzD8LvlQIHOQvfmih7Tc9XsmnYWhfStQAtWAmhH
   y2IoVoWO4XBwJtds+dSxdZdvFaLDGQRKg/O+6xmniL5d7cuD2P8aobE9j
   lvQbQxF+CJkVu01LjOR/wPny/2O71RHFmA9g4RSLmoq1I7pfarakSOuP2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="287253992"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="287253992"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 19:29:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="794911859"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga005.jf.intel.com with ESMTP; 21 Sep 2022 19:29:19 -0700
Message-ID: <99c17173-45af-6892-4cc7-b17bad7dc645@linux.intel.com>
Date: Thu, 22 Sep 2022 10:23:23 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: baolu.lu@linux.intel.com
Subject: Re: [PATCH RESEND 1/3] iommu: return early when devices in a group
 require different domain type
Content-Language: en-US
To: Yuan Can <yuancan@huawei.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, iommu@lists.linux.dev
References: <20220921132607.43820-1-yuancan@huawei.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220921132607.43820-1-yuancan@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/22 9:26 PM, Yuan Can wrote:
> When alloc default domain for an iommu_group in
> probe_alloc_default_domain, the expected domain type
> of each device in the iommu_group is checked in a loop,
> if two devices require different types, the loop can
> be broken since the default domain will be set to
> iommu_def_domain_type.
> Return 1 when this happened to break the loop in
> __iommu_group_for_each_dev.

As I commented here

https://lore.kernel.org/linux-iommu/50b8489c-bd93-c8ae-cd92-af429ae762b0@linux.intel.com/

Please use up the allowed number of characters per line before wrapping.

Best regards,
baolu
