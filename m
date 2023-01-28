Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABCE2908
	for <iommu@lists.linux.dev>; Sat, 28 Jan 2023 08:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674893329; x=1706429329;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OkTqIttwZehfM8GUhzudD/mFz8N4/RQ7nv7RdzmULY0=;
  b=RP0WRRb2wKqKsAyzryrKslBZuAXYNl+ISN6ixeV7Ds30Da40r4tO2bx+
   8iiRJBswjbHlCysgZcUi2VTfRDw3cKpkPndC5o/lEjHo+/Jeo7+C+SKsF
   GDawUZQXgs/BWCF50WGDP3/zj+J6TD/GnAtAkgD4sq3JjaRv3fERzyF3s
   z7o7OmtFmwjyRPW4sSDl0MMJNpuy5IEZFZl/qEhn5Fj7NpTzhoimxj7CH
   uqISLpzgEgS8c7hb/ryj0AyKfghV+Nav8rBfg1kgTzIKqwyPFXqTuCISR
   7TOfr0NaSWBmbKH49fiT+8KCOYSS2DN4d5SDVMAVELyW960LzUVtWiGFp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="391828013"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="391828013"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 00:08:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="806086593"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="806086593"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.186.212]) ([10.252.186.212])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 00:08:45 -0800
Message-ID: <2c8c0d1d-56d2-4db7-ffb2-5a51eddfa13b@linux.intel.com>
Date: Sat, 28 Jan 2023 16:08:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, hch@lst.de, jgg@nvidia.com
Subject: Re: [PATCH v2 3/8] iommu: Add lockdep annotations for group list
 iterators
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1674753627.git.robin.murphy@arm.com>
 <57cba0cf89556d586e554a9c64cbd28205d67c5c.1674753627.git.robin.murphy@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <57cba0cf89556d586e554a9c64cbd28205d67c5c.1674753627.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/1/27 2:26, Robin Murphy wrote:
> Before we add any more common helpers for iterating or otherwise
> accessing the group device list, let's start the good habit of
> annotating their locking expectations for robustness.
> 
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
