Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ABB7F9
	for <iommu@lists.linux.dev>; Thu, 14 Dec 2023 02:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1nxI5Kw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702520778; x=1734056778;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bTE8VtNJbCiL/s1yAvkGTFLh3wedrZObxMgUdd+VPZY=;
  b=J1nxI5Kwc9+Ehlu5BDd007bylo4nKEl28fYlkmza6EbwGpOm3ElIOD3k
   BrEBRUiWuxM2H0ySM9jX6V3w6RJMQotMev1DAdREmjVDsfp4q21I4eJIU
   YVYwLIM5+C4va7GLe8pP+0uH1Zf+ssDTUB+UPLJLxqKFja0OhHtP0Z611
   SZhmEChS+UX5qF6ubZfQRpAMt6xRx4LjFPa/izpFzoh6ryLqQ49czX/Jv
   kT4dN3g6Rjr1GLTFDSQ97bF188zo+m9Ohf6nT0fA3MpRt9GxXbY4h+pTe
   YiVnNgysg38deBv52nQLUUgo0ppZcmKf703a8HhuptzKEhnxrsJpOaSyu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="2229870"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="2229870"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 18:26:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="22211022"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.254.210.186]) ([10.254.210.186])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 18:26:13 -0800
Message-ID: <e6fddbb0-fa8f-43d4-8a5e-d177e9465912@linux.intel.com>
Date: Thu, 14 Dec 2023 10:26:10 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/vt-d: don's issue devTLB flush request when
 device is disconnected
To: Baolu Lu <baolu.lu@linux.intel.com>, bhelgaas@google.com,
 dwmw2@infradead.org, will@kernel.org, robin.murphy@arm.com
Cc: linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Haorong Ye <yehaorong@bytedance.com>
References: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
 <20231213034637.2603013-3-haifeng.zhao@linux.intel.com>
 <96051115-c928-4f3c-bd65-4f3f8e83ca9c@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <96051115-c928-4f3c-bd65-4f3f8e83ca9c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/13/2023 7:59 PM, Baolu Lu wrote:
> On 2023/12/13 11:46, Ethan Zhao wrote:
>> For those endpoint devices connect to system via hotplug capable ports,
>> users could request a warm reset to the device by flapping device's link
>> through setting the slot's link control register, as pciehpt_ist() DLLSC
>> interrupt sequence response, pciehp will unload the device driver and
>> then power it off.
>
> Is it possible for pciehp to disable ATS on the device before unloading
> the driver? Or should the device follow some specific steps to warm
> reset the device?
>
In this case, link down first, then pciehp_ist() got DLLSC interrupt to 
know

that, I don't think it makes sense to disable device ATS here, but it could

flag the device is ATS disabled, well,  "disconnected" is enough to let

vt-d like software knows the device state.


> What happens if IOMMU issues device TLB invalidation after link down but
> before pci_dev_is_disconnected() returns true?

Seems it wouldn't happen with hotplug cases, safe_removal or

supprise_removal.



Thanks,

Ethan

>
> Best regards,
> baolu
