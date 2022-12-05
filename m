Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5866F7C
	for <iommu@lists.linux.dev>; Mon,  5 Dec 2022 13:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670246387; x=1701782387;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jsaNo7Maum2Ukm51MdiAG+iYw1fujknlh5Mph9eOT6k=;
  b=Na8YKzMPWRSbwNX2wf4GkyW2KkNkHZwj4Y5vhgTW2ycRKH+LjNVBj75f
   uxUYXWeQRVtH47Ug7MblsYbjGrQAi82fS3EFo1AfhCGV5ABFREGF+1Vz7
   G6vxi996pn9R0Y/Fp0y2gJRSWzVjl8vlsHZpC9Dw4UY1FragJRYMW8RkS
   Kr7uiZzyYjOr16DIV81N1a95l8opokuCbnfnvjWTb4+FSOi8r95qISjFP
   gHerCrm+G2GPQgA4tBS9Fog10Wg1IwdYvf7kdgnwwZ9jDG+M0zLRryet6
   ONaU+VNWGJy/Oy4ZHr6dAbvFPKaXB5XoVA/2BVJ+S1TZ/DT+rwKqsrtty
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="315045765"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="315045765"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 05:19:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="676582866"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="676582866"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.227]) ([10.254.213.227])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 05:19:43 -0800
Message-ID: <af6f1e65-5f2d-e55b-ff6c-0fefba2e8faa@linux.intel.com>
Date: Mon, 5 Dec 2022 21:19:40 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Cc: baolu.lu@linux.intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Yuzhang Luo <yuzhang.luo@intel.com>
Subject: Re: [PATCH v3] iommu/vt-d: Add a fix for devices need extra dtlb
 flush
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20221130062449.1360063-1-jacob.jun.pan@linux.intel.com>
 <Y43LUVS1heMxGBC7@8bytes.org>
 <b64c5b16-79bd-182d-354b-73a74430a8cc@linux.intel.com>
 <Y43nw0vZLfy9aFUz@8bytes.org>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y43nw0vZLfy9aFUz@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/12/5 20:44, Joerg Roedel wrote:
> Baolu,
> 
> On Mon, Dec 05, 2022 at 06:59:19PM +0800, Baolu Lu wrote:
>> Is this still feasible?
> 
> Can you please review the fix and provide your tag? I will put in the
> fixes branch then.

It seems that this patch doesn't apply to the fixes branch. Let me
prepare a pull request for you.

Best regards,
baolu
