Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9497A2908
	for <iommu@lists.linux.dev>; Sat, 28 Jan 2023 07:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674892557; x=1706428557;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QQ+oKMKIO3r/YGYgIlS7IpSJ6lLAzzTTT2x0LwrRzRU=;
  b=MUM64nzeTaFje4r2L/jw74Hy9wGYs/9HQHDYOii0HmEwUWwzl1CxLdQp
   TaO1xOIVIGwqZ1hggJoy0iMBq5+yACJOj/P2I7mv0KjQ8COSwXmbmIXUe
   CrBqc+f2+YNAYJSH6VvmIoOpR3O7q28y6hUdEudviiFKD6t83EqyP1Drb
   lViFVk71i+1Si/H119meUV6DB9aDUao+vGnKMt3hXJsCxcjS5IFGF967z
   tprjcqr///RRJqb765w9ikX0z4tcOYjZqxLVs1h+0D61+pAYVwakVGDrK
   4bAfIvsX2UDAXEoezuCQXLgQW4UX89tTLvC3aDLa2VG7veozafwGVbQYj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="391826910"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="391826910"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 23:55:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="771856631"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="771856631"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.186.212]) ([10.252.186.212])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 23:55:54 -0800
Message-ID: <20e1ba45-adfe-b947-e871-76bc00ff972a@linux.intel.com>
Date: Sat, 28 Jan 2023 15:55:52 +0800
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
Subject: Re: [PATCH v2 1/8] iommu: Decouple iommu_present() from bus ops
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1674753627.git.robin.murphy@arm.com>
 <bf052fb0301eabe8c2831c6d53b9de2bbe000ac6.1674753627.git.robin.murphy@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <bf052fb0301eabe8c2831c6d53b9de2bbe000ac6.1674753627.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/1/27 2:26, Robin Murphy wrote:
> Much as I'd like to remove iommu_present(), the final remaining users
> are proving stubbornly difficult to clean up, so kick that can down
> the road and just rework it to preserve the current behaviour without
> depending on bus ops.
> 
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
