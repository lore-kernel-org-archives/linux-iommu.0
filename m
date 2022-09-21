Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29847C
	for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 02:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663728577; x=1695264577;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SpwZqyP/NsakNUiAYbXlk6VtCsQb6pxkSE0VYT9lA+E=;
  b=M6vjKkqGEtY2JoQHpxY6JgrAIRfkXBYAxwxC1bXpS3FTXj0lp2UQpyhf
   0qupQGmVcGQBCgFu/4jX5WLppafaYBtQIrGTkhE2vPVLINPCOGB7NrNJV
   HQOJhHQazYTTZPx9N4SeZNvOO8SHLpBF+rzjnOjNvKXWtg00iFmVjtNg7
   ikOjIUWNLmDk6RESRD+YRGmoYbc7Tcyt6DMeu/lxZhA8aXomL4j/bQJZd
   5muzWOMsrzwxvJFnLYZrX36xwbo2mviX9AODhJtpK51qBtcgZm8+m/im9
   gfOsCtIGdqIcWU6n109Mu9rJITrVzx2c8ravzN2ieQbZz38pmtTyxn1FH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="363856511"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="363856511"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 19:49:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="794500836"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga005.jf.intel.com with ESMTP; 20 Sep 2022 19:49:35 -0700
Message-ID: <4dc8f9a4-c2cb-261e-21e7-37b2d29c7332@linux.intel.com>
Date: Wed, 21 Sep 2022 10:43:40 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 George Hilliard <thirtythreeforty@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Revert "iommu/vt-d: Fix possible recursive locking in
 intel_iommu_init()"
Content-Language: en-US
To: iommu@lists.linux.dev
References: <20220920081701.3453504-1-baolu.lu@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220920081701.3453504-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/22 4:17 PM, Lu Baolu wrote:
> This reverts commit 9cd4f1434479f1ac25c440c421fbf52069079914.
> 
> Some issues were reported on the original commit. Some thunderbolt devices
> don't work anymore due to the following DMA fault.
> 
> DMAR: DRHD: handling fault status reg 2
> DMAR: [INTR-REMAP] Request device [09:00.0] fault index 0x8080
>        [fault reason 0x25]
>        Blocked a compatibility format interrupt request
> 
> Bring it back for now to avoid functional regression.
> 
> Fixes: 9cd4f1434479f ("iommu/vt-d: Fix possible recursive locking in intel_iommu_init()")
> Link:https://lore.kernel.org/linux-iommu/485A6EA5-6D58-42EA-B298-8571E97422DE@getmailspring.com/
> Link:https://bugzilla.kernel.org/show_bug.cgi?id=216497
> Cc: Mika Westerberg<mika.westerberg@linux.intel.com>
> Reported-and-tested-by: George Hilliard<thirtythreeforty@gmail.com>
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>

Queued for v6.0.

https://lore.kernel.org/linux-iommu/20220921024054.3570256-1-baolu.lu@linux.intel.com

Best regards,
baolu
