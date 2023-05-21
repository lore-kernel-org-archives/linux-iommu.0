Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DD77EC
	for <iommu@lists.linux.dev>; Sun, 21 May 2023 09:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684660156; x=1716196156;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=heKkj2TnvrCjRt2R7xWsfK6yv4o+64Djjy0XBCmzP7s=;
  b=EMnc5i9EPgboaUwPMX5ZK9sRo6RdK6E2ItQwzqBYT09TuqMifcSR4yi8
   W/5lOnrWMETAchyTa5OlS9TZpWLuo7QbyB3lBgoZsrU9cBZ3f/v3fg4Wl
   rfZiqDxtsSjB7amlOTNZL3HbC/EKAVEoxKKln0YeWD94DUpsN81f4Ziyz
   36qsEOhPmXh03nO5dvx+IbaSeVEv41wAikkPZuNuWYS7g19h+fBe6kEhC
   JPombJZT50lJjUPKXU9MWOcSAAiWOAyspZMKNpb6Y/66pdEofm+YfoH7j
   AyQurC5IyiPbW8WBlMbmZDE8hM2CLv1uFrm07g/LP5L7v01xjhT67HrzE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10716"; a="333046925"
X-IronPort-AV: E=Sophos;i="6.00,181,1681196400"; 
   d="scan'208";a="333046925"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 02:09:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10716"; a="768162205"
X-IronPort-AV: E=Sophos;i="6.00,181,1681196400"; 
   d="scan'208";a="768162205"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga008.fm.intel.com with ESMTP; 21 May 2023 02:09:13 -0700
Message-ID: <dca9acc5-8466-83f3-01f7-2194d9ec1109@linux.intel.com>
Date: Sun, 21 May 2023 17:08:33 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 04/10] iommu: Simplify the
 __iommu_group_remove_device() flow
To: Jason Gunthorpe <jgg@nvidia.com>, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
References: <4-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <4-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/23 2:42 AM, Jason Gunthorpe wrote:
> Instead of returning the struct group_device and then later freeing it, do
> the entire free under the group->mutex and defer only putting the
> iommu_group.
> 
> It is safe to remove the sysfs_links and free memory while holding that
> mutex.
> 
> Move the sanity assert of the group status into
> __iommu_group_free_device().
> 
> The next patch will improve upon this and consolidate the group put and
> the mutex into __iommu_group_remove_device().
> 
> __iommu_group_free_device() is close to being the paired undo of
> iommu_group_add_device(), following patches will improve on that.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
