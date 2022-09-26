Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511442F50
	for <iommu@lists.linux.dev>; Mon, 26 Sep 2022 13:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664198688; x=1695734688;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6vZEOvuaX3fYuRgprKfAm1QGIqBUF0nPgMzjL0S6HQk=;
  b=NqjdTUhY9valUm5QcEEAq9l4Jpc2qvsMU3b/+9CwtlbjLzvemjTodA1+
   yVnVpxR28/L8tfnlyRab3MQX98AbUJNxI0nMyK7AJm8e88ONKc8lQC2sj
   KPe65vORQ+v6VHXpXLsr1duIAD/Yf1sF/RKZfyjd6x/nhZ54/NgRNYl5b
   peiD9Qxv0SzBBzFnlXEXERCVnC9jo/sotP1M7h2jlqOqBITRnFqsxu3E5
   MHyVKSBr+8/sjR9S4aPG1+e15SN18ZMfGlHFYnQ8DB6H7sCYo7zY/l3+r
   XHsPdo4GPjkkiwSOPRLMVQ7f/Lmum47RTkxPwVxSGVw/md72hSeWUtaGq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="288163167"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="288163167"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 06:24:47 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="654258495"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="654258495"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.229]) ([10.254.209.229])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 06:24:46 -0700
Message-ID: <7d98e18b-a310-d54f-f0b5-0c8a013c0b8b@linux.intel.com>
Date: Mon, 26 Sep 2022 21:24:44 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] [PULL REQUEST] Intel IOMMU updates for Linux v6.1
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20220923004206.3630441-1-baolu.lu@linux.intel.com>
 <YzGX7ri+CYTpKfeP@8bytes.org>
 <64405aee-0701-5b1f-084a-f0750372a563@linux.intel.com>
 <YzGik3y4J0Fkc9fd@8bytes.org>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YzGik3y4J0Fkc9fd@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/9/26 21:01, Joerg Roedel wrote:
> On Mon, Sep 26, 2022 at 08:38:09PM +0800, Baolu Lu wrote:
>> Do you prefer applying de9f8a91eb32 to vt-d branch, or let me send a new
>> v6.0-rc7 based pull request?
> Yes, please send a v6.0-rc7 pull-request. I'd like to carry the conflict
> resolution in the merge commit for next.

Sure. A new pull request has been posted:

https://lore.kernel.org/linux-iommu/20220926131529.4045281-1-baolu.lu@linux.intel.com/

Best regards,
baolu
