Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D105F256E
	for <iommu@lists.linux.dev>; Tue, 23 Aug 2022 14:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661263730; x=1692799730;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QGleQ3Y6XcUG4H6+bm+kkCZykmEPRuSH/26duaMmWz8=;
  b=mB9gCoSYIe/REb8rZ+FGxzcFGPxYP38nS+W7z3BIpfgw/PiyE3AIXm3c
   gXf71J062YqFeLtS3PbWg6y+YVHRLx+Bwz5FWHnjmZKt69PpC4/1lILiW
   yA7GAMxgTtnAs/4GURcWYlGI5cf+c3rQXHXhVJyZjGuG7iUJbNKE1H72a
   cI4XzO4cWYKdveArzydev8v5MvvjiJAHqFYqSbUtCXyH5VJ5KklgDNGHO
   Nsf5d39fpr1W7KDRcGIdOv4fDlgU1Havj4PeFLXXav8tEGgtvtQw6fF73
   mGT/oDXKE0Ou7Tq7/JKMRuWznuPK0yAYqaKsUxy9MToZey77PX/aN/QUB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="276721516"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="276721516"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:08:41 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="560178643"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:08:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1oQUZt-002T40-12;
	Tue, 23 Aug 2022 17:08:25 +0300
Date: Tue, 23 Aug 2022 17:08:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joerg Roedel <jroedel@suse.de>, Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v1 1/1] iommu: Do not dereference fwnode in struct device
Message-ID: <YwTfWdnAqB6S9Ysy@smile.fi.intel.com>
References: <20220801164758.20664-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801164758.20664-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 01, 2022 at 07:47:58PM +0300, Andy Shevchenko wrote:
> In order to make the underneath API easier to change in the future,
> prevent users from dereferencing fwnode from struct device.
> Instead, use the specific dev_fwnode() API for that.

Any news?

-- 
With Best Regards,
Andy Shevchenko


