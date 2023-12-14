Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AC038E
	for <iommu@lists.linux.dev>; Thu, 14 Dec 2023 00:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T885dl0E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702515537; x=1734051537;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w4CvfAEx5Otr1z8ctNIsiiCXmkHh9thOmbmC19YRFYY=;
  b=T885dl0EKN8uwwAjzBtP+zyxpJ8siNu0y6RzoXOan2pVdUNmvUY9ywk9
   uTSJuVD8ulWjtKyqMqCqQz3N4SNfA+M4rYu+OK5lRC/foEEBgpA9RNc15
   NfiyjD/QNLsafu5z1z2mWHe7CuemehDmMVMElFjhDgOE92knpXZ4LKpEb
   E8zzNnvrq4w83nxBhchvJok/7Vkgx6ZnuCdJH2yRQrs1g21j2iDHPyBam
   EStwvKjxoWH6eeiGcodqBUzOQmQm35p1R28T6mxmcQe+P1H84d2hxa4m7
   TCoQJRzayBoi3zqQBNSgzuXfujviMmsT5eZecIK6srbBk8w7/rhZfMjVC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="481246316"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="481246316"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 16:58:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="750326235"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="750326235"
Received: from jiqing1x-mobl1.ccr.corp.intel.com (HELO [10.254.210.186]) ([10.254.210.186])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 16:58:53 -0800
Message-ID: <31bd82b6-6f7e-4dc4-8cbb-46fa806d699f@linux.intel.com>
Date: Thu, 14 Dec 2023 08:58:49 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: make pci_dev_is_disconnected() helper public for
 other drivers
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
 will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Haorong Ye <yehaorong@bytedance.com>
References: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
 <20231213034637.2603013-2-haifeng.zhao@linux.intel.com>
 <20231213104930.GB31964@wunner.de>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20231213104930.GB31964@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/13/2023 6:49 PM, Lukas Wunner wrote:
> On Tue, Dec 12, 2023 at 10:46:36PM -0500, Ethan Zhao wrote:
>> move pci_dev_is_disconnected() from driver/pci/pci.h to public
>> include/linux/pci.h for other driver's reference.
>> no function change.
> That's merely a prose description of the code.  A reader can already
> see from the code what it's doing.  You need to explain the *reason*
> for the change instead.  E.g.:  "Make pci_dev_is_disconnected() public
> so that it can be called from $DRIVER to speed up hot removal
> handling which may otherwise take seconds because of $REASONS."

Yup, why I made it public. then how about

"

Make pci_dev_is_disconnected() public so that it can be called from
Intel vt-d driver to check the device's hotplug removal state when
issue devTLB flush request."



Thanks,

Ethan

>
> Thanks,
>
> Lukas
