Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A2B23C0
	for <iommu@lists.linux.dev>; Sat, 29 Oct 2022 08:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667031756; x=1698567756;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ddN3j5eSW1Xdce1saH1Cy6ffr0QD86C5Yi/d3U3zqik=;
  b=i88qjE+eqnScTad4cNKmUqrxUZ8DcHuR7KoLfleDJVRoESKoQ9zK02lB
   In4Tdq8KAVbeyhxRUCZlZS9oZ3xQckGwEVD9+OFw1q2To5c29Lh4Eb/VK
   xWe+0wFAowrVQ/JmyZnbB24sm8Z3PbTqh2BY0kQuqaCoUXdbBL+rS1//R
   CQrrOvItK04vJcexBp88CruT8H0oWq/XNlEybMDARYmI2rMS7gCKPT3Qn
   24hfQQC8I2TtpABwOrOF7ZGn8ZW2xbhcpQYTiwVmmIhlNlYn1y+SIC7UY
   AukDGz1Wmd0COlccrsZEPalv7thBW4u8hPOASbXTsbve9b9H3aipISITk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="308648692"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="308648692"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 01:22:35 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="878231477"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="878231477"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.211]) ([10.254.215.211])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 01:22:34 -0700
Message-ID: <cd727ea9-32f8-cc6a-a070-74e039b725f5@linux.intel.com>
Date: Sat, 29 Oct 2022 16:22:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev
Subject: Re: lockdep splat with intel iommu
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Kevin Tian <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>
References: <Y1qOqBXgll9qa7Hm@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y1qOqBXgll9qa7Hm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/10/27 21:59, Jason Gunthorpe wrote:
> I'm seeing this at every boot, on v6.1-rc2
> 
> I've just realized it means lockdep is turned off for the actual
> testing I want to do. Very annoying
> 
> Lu, is there a solution yet? I saw some patches for a different
> lockdep splat but not this one.

Hi Jason,

Possibly the same issue as this one?

https://lore.kernel.org/linux-iommu/20220922101036.87457-1-janusz.krzysztofik@linux.intel.com/

Best regards,
baolu
