Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC246112
	for <iommu@lists.linux.dev>; Mon,  5 Dec 2022 16:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670257556; x=1701793556;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qsaDwc1B2ic2cfVgHuZV3ShLB7mLfhWqSmOSIOnkO6s=;
  b=RFb/5Ce7Sy1bTl6k8ba4c+VI29t22vDs6b7BH7e3oRGDTi9ikVB4z/9h
   p/IF+6XSAmlCw5TG+7Qw1TBJBBlzuxJ0z5XHf/goDDVq5DczbGnX71Iwl
   jr3LVKfX3UTbWmMDhD2KSQVZmIFyWbKcZzPsICoGrd5+Rk/VTgZlZ9Hjy
   c0+qhRn6kcHxANvuL8fZOLkWRkZ5z0iDiQggEbRb1/VCMfo3a0fd5gXoX
   rZ1n0htPW4gUNF2EWJ4/tYyuX6sjum3CYiQrU4DFaOazG2K0r2BRWp0G+
   0nl9UcjDixCfya2TyiVDB1Ys/xIVS/Ojy4y3Mu3pHWMB+7yl3FRg1CmgO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="299821212"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="299821212"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 08:25:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="709311569"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="709311569"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 08:25:53 -0800
Date: Mon, 5 Dec 2022 08:29:48 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: <iommu@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse
 <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>, Will Deacon
 <will@kernel.org>, Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Raghunathan Srinivasan
 <raghunathan.srinivasan@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] iommu/vt-d: Fix buggy QAT device mask
Message-ID: <20221205082948.3cb53a8c@jacob-builder>
In-Reply-To: <Y4qpPxpXO9XQ2NEL@a4bf019067fa.jf.intel.com>
References: <20221203005610.2927487-1-jacob.jun.pan@linux.intel.com>
	<Y4qpPxpXO9XQ2NEL@a4bf019067fa.jf.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ashok,

On Fri, 2 Dec 2022 17:41:19 -0800, Ashok Raj <ashok.raj@intel.com> wrote:

> On Fri, Dec 02, 2022 at 04:56:10PM -0800, Jacob Pan wrote:
> > Impacted QAT device IDs that need extra dtlb flush quirk is ranging
> > from 0x4940 to 0x4943. After bitwise AND device ID with 0xfffc the
> > result should be 0x4940 instead of 0x494c to identify these devices.  
> 
> Can you add the lore link for the original post here just for reference.
> 
> as a Link: tag, since this depends on the other patch.
yes, Looks like Baolu  has already taken care of it.

Thank you both!

Jacob
