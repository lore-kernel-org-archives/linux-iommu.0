Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795333165;
	b=R8vbIjSJzkwGiLu7aUHVci70zqhg30HshoJ4j9FVQX2hLViNX/HWAFolEWT407T8KbOU
	 4b75YEN7v31OEbp7Fc4S97Z+nAGKktzClHKnvo9fEDMG2bdyjiDqCxOGIfNnzUbTysqLK
	 6yPIWsWESyPKm3hdMForO3ZGQ/I65FTMcquPZGuu/WM6ExAAt25CiAtoW0BNYZxPKmmng
	 H8mixNRMJWq5gKVWCAq4iQnFf6yUfDAVypPpWGEx0xYaFsUNhkjMNNxs5RrrjO3kkvz70
	 biRse3HUnYpm9FILEWT4z02SG29xnQ/yJ+SG0uxBbENEA4B5g+p4im1OF+UBlfDdsCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795333165;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=/i0BBmxYJHnl1sI6r8Fuvvf6z53wFQICc+bQGalYAOg=;
	b=5DfKOZuqfsHFGN/R68Q31++aZyYfgYnHzhRkstE0H2Du3wM+RtDl7/CQC/siApSOyiHO
	 xW8C2bjG+SjS4EQETdiuaZhQxd+v09RVORBPddAyOeQRrgrx/fCY3LdatfkfkmeeRcuMq
	 M5863y2/NGH44W6ecNNEo7aCGRbpEepP2CBoAmk5yhuAXZ6T9+xGrSTiT6vb+Wc2ruH5B
	 OtktoWD/Zw9o6QWDsYYtvC/bEToLYGzVcIGgxJYVRrogSDL1YDabkCX8bH5aoT8kYy/hz
	 Zs9c5jiTzTHc+UFlceXFgFeWDeB+UuzZyCWKmaZ0M+WuJacwUkneNGv1KFhBSlVPrpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=My7lpD3G;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50934606A320
	for <iommu@lists.linux.dev>; Sun, 22 Nov 2026 07:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50934606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=My7lpD3G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795333164; x=1826869164;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gNQJBOrAzYgMarp6lvWVLnCLvqjZR0sUSvKqu3XwAnU=;
  b=My7lpD3GPIL8/hsUF5v5NDp4v5AowE9bbg+Pu4tkwX3ALybJLZY9FP9+
   jZbuJmTdEF6uJiTiEX/deaWCL/gR4qjQlnhVXqpCzz5L0GK8K4XTzOW68
   iPNJT9BehEtqVaTuXlaXftsHDlEh9HXG/yJM2DgJKMLkgOTi0WUIJ6RkC
   TmWiNfsDmE8/FM6oZZ7cJvd2vt4u14nruM2N7g4CmZq1enBrz98UR7y22
   dbF+BJ1dEzMoppI0Vg/ZUqsC290C8lLlVxgbFCevn+91qpFSYV5CsmVPe
   fzM/sVZIz/dE4SbK2sf/4a4dSkd0yl0kB22h9+DCRSxsw9wOSfeIwkfzN
   g==;
X-CSE-ConnectionGUID: h/X5MCLBRb6xgUn2JeY99w==
X-CSE-MsgGUID: qgdDYxWFTeqaGl+FrsQ//w==
X-IronPort-AV: E=McAfee;i="6800,10657,11973"; a="4159314"
X-IronPort-AV: E=Sophos;i="6.27,226,1787036400"; 
   d="scan'208";a="4159314"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2026 23:39:23 -0800
X-CSE-ConnectionGUID: JbiD7njBSTGxfSf+R6dfZA==
X-CSE-MsgGUID: 2ZpzEVs1QSGp6C4mLgAJeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,226,1787036400"; 
   d="scan'208";a="11363685"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2026 23:39:22 -0800
Message-ID: <4420a997-82e9-43e6-8ceb-5ede44594c51@linux.intel.com>
Date: Sun, 22 Nov 2026 15:39:19 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH 0/2] iommu/io-pgfault: reject partial faults after device
 removal
To: Qihang <q.h.hack.winter@gmail.com>
References: <20261117015409.25492-1-q.h.hack.winter@gmail.com>
 <56be2b4e-aefb-413b-8f72-0bea1f9e96db@linux.intel.com>
 <CAH78GvuUtU=zhe-Qbn9k73D3U5n1Ye1=8wtQqR7vCEpDzgNUJg@mail.gmail.com>
 <aceb9e9f-7ba3-48e2-8945-95179f22581d@linux.intel.com>
 <CAH78Gvubo20uU4ntOxzd-+B6GHpUovL_wYQt9yahF-8=x3sEVA@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CAH78Gvubo20uU4ntOxzd-+B6GHpUovL_wYQt9yahF-8=x3sEVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/2026 10:13 AM, Qihang wrote:
> Hi Baolu,
> 
> Thanks for confirming the VT-d ordering bug. I'll keep this series
> withdrawn and won't resend it.
> 
> I still have one question about AMD. detach_device() calls
> iopf_queue_flush_dev() just before amd_iommu_iopf_remove_device().
> That flush only waits on the iopf workqueue, while the PPR IRQ thread
> runs amd_iommu_poll_ppr_log() and reports the fault through
> iommu_report_device_fault() directly. What ensures that the thread has
> finished reporting faults for this device, and cannot report another
> one, before the device is removed from the IOPF queue?

+ Vasant

> Thanks,
> Qihang

Thanks,
baolu
