Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B762D1FA8
	for <iommu@lists.linux.dev>; Wed, 19 Oct 2022 01:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666141242; x=1697677242;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aDVSrblbxjUrl9rBex0zEUaGNmL3cagKEcM5NrBCtus=;
  b=OhkLA8ttqxRixUgWNrSXO7jJxAFhliLziA6rHigxKntpX8wGp5osx4T/
   KD+qGs1bBwBhNh47RRddfr3Z+iRW6IZ8KYe3WoV/KdUqbbKUDZlizsb2+
   hpjDNXMNyaPbFlk20tHsIzHYsrXYJ1wqLy5+YkFo7VXSZBeqS85kMgiE2
   Od/8UiMub+TYO0vFBINfwUGWfKLpk6D8kjZ2Du6Gx1WhQcLo774yAzE8T
   +PQfqIhDsexCpvHI94ahJu/eKqyJW4JQxW6VgjF3B05w/a3bo2HlC5YZb
   tA6ffmziT0PQUoPeJJdk7nmprZWaszQJXlKK0V+BChWUua0gw7xD219kk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="392575895"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="392575895"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 18:00:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="660079123"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="660079123"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 18 Oct 2022 18:00:39 -0700
Message-ID: <a732a2c7-c5d7-53f1-1abc-f9907384ef71@linux.intel.com>
Date: Wed, 19 Oct 2022 08:54:13 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] iommu/vt-d: Clean up si_domain in the init_dmars()
 error path
Content-Language: en-US
To: Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20221010065608.281860-1-jsnitsel@redhat.com>
 <20221010144842.308890-1-jsnitsel@redhat.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20221010144842.308890-1-jsnitsel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/22 10:48 PM, Jerry Snitselaar wrote:
> A splat from kmem_cache_destroy() was seen with a kernel prior to
> commit ee2653bbe89d ("iommu/vt-d: Remove domain and devinfo mempool")
> when there was a failure in init_dmars(), because the iommu_domain
> cache still had objects. While the mempool code is now gone, there
> still is a leak of the si_domain memory if init_dmars() fails. So
> clean up si_domain in the init_dmars() error path.
> 
> Cc: Lu Baolu<baolu.lu@linux.intel.com>
> Cc: Joerg Roedel<joro@8bytes.org>
> Cc: Will Deacon<will@kernel.org>
> Cc: Robin Murphy<robin.murphy@arm.com>
> Fixes: 86080ccc223a ("iommu/vt-d: Allocate si_domain in init_dmars()")
> Signed-off-by: Jerry Snitselaar<jsnitsel@redhat.com>

Thanks for the patch. It has been queued for v6.1.

https://lore.kernel.org/linux-iommu/20221019004447.4563-1-baolu.lu@linux.intel.com/

Best regards,
baolu
