Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3818928DAD
	for <iommu@lists.linux.dev>; Wed, 13 Dec 2023 11:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QD+feMPb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702468788; x=1734004788;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZPVp3ETxXIxALqF5k4Z5/m0QF1K6hbpGTk+sb7wheQ0=;
  b=QD+feMPbWa2H7fDtUqukMKJ+6lNcHpGvF0APCXrjUn61l7H84NlE6IyS
   Wblmqva0oo6mfN6uMRok9ZxKUXXgj+u9BUYgNBsSKM2NCvslzQU8TKcoN
   wcg6E/weCq8kclfL1fTHXf5A+2C4syW3gymYpBgWzHcK77Gg6wBtY0pkq
   l+yYUC0xv5AHAYkgksRz7j1hSXFN9JydsSSlbzAbwJNfwNn5Gk7KcipWu
   oCRe01IZnmiT4Hnx7RDvJnV2bNB4eteyolkvdzMGSqj9av9Kf28KnAT4m
   HhS3JU4GpaVbU8S2U9OvvqM5ujtKblJA7xJNbA/WscUBmG2XdLgIk5L+v
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1808510"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="1808510"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 03:59:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="839837065"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="839837065"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.212.246]) ([10.254.212.246])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 03:59:44 -0800
Message-ID: <96051115-c928-4f3c-bd65-4f3f8e83ca9c@linux.intel.com>
Date: Wed, 13 Dec 2023 19:59:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, linux-pci@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Haorong Ye <yehaorong@bytedance.com>
Subject: Re: [PATCH 2/2] iommu/vt-d: don's issue devTLB flush request when
 device is disconnected
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, bhelgaas@google.com,
 dwmw2@infradead.org, will@kernel.org, robin.murphy@arm.com
References: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
 <20231213034637.2603013-3-haifeng.zhao@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231213034637.2603013-3-haifeng.zhao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/12/13 11:46, Ethan Zhao wrote:
> For those endpoint devices connect to system via hotplug capable ports,
> users could request a warm reset to the device by flapping device's link
> through setting the slot's link control register, as pciehpt_ist() DLLSC
> interrupt sequence response, pciehp will unload the device driver and
> then power it off.

Is it possible for pciehp to disable ATS on the device before unloading
the driver? Or should the device follow some specific steps to warm
reset the device?

What happens if IOMMU issues device TLB invalidation after link down but
before pci_dev_is_disconnected() returns true?

Best regards,
baolu
