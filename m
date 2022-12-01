Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF6E7C
	for <iommu@lists.linux.dev>; Thu,  1 Dec 2022 04:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669867438; x=1701403438;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Cq7Rcax49nKIPkMML09f9SasCtdqbgznUQk1YJXx10M=;
  b=lGmutbXX4xiVu6VN+7dRf/NN6gxFW3sb2bLqTM5qio1+101LWQ1izlSx
   cY619Vm0P8ufVWE5PFuKWuffFn+jruJN4Dw9EiCMxMfoPKvC6RO3zuUBy
   bqjuT4DxaDG7NjwhosSZiNHOo64sP5op9qgDCWvLs393lVMWGEWtMU06j
   zVPXHYvt8jKakYld2GX6brznF3UvNgBLsM35oQzcovpkW8Jliqp2rRDGM
   /Xw2vEFXcPLULSvwxWl/FyWrcFnQGZaQmUpROqKAYpWsO1gSPRuaNWi5y
   M4jyiNGD1DWemsHkLjMhz0qFk+885dv4NFVWR0+XKI2F/ZLK8lcUcVVyQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="379856254"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="379856254"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 20:03:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="786734738"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="786734738"
Received: from xuhuiyan-mobl1.ccr.corp.intel.com (HELO [10.254.215.206]) ([10.254.215.206])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 20:03:55 -0800
Message-ID: <ca42703c-1a1d-63f1-eee0-8b128c8d809e@linux.intel.com>
Date: Thu, 1 Dec 2022 12:03:53 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev
Subject: Re: [PATCH v2] iommu/vt-d: fix pci device refcount leak in
 prq_event_thread()
Content-Language: en-US
To: Yang Yingliang <yangyingliang@huawei.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
References: <20221119144028.2452731-1-yangyingliang@huawei.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20221119144028.2452731-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/11/19 22:40, Yang Yingliang wrote:
> As comment of pci_get_domain_bus_and_slot() says, it returns
> a pci device with refcount increment, when finish using it,
> the caller must decrement the reference count by calling
> pci_dev_put(). So call pci_dev_put() after using the 'pdev'
> to avoid refcount leak.
> 
> Besides, if the 'pdev' is null or intel_svm_prq_report()
> returns error, there is no need to trace this fault.
> 
> Fixes: 06f4b8d09dba ("iommu/vt-d: Remove unnecessary SVA data accesses in page fault path")
> Suggested-by: Lu Baolu<baolu.lu@linux.intel.com>
> Signed-off-by: Yang Yingliang<yangyingliang@huawei.com>

Queued for Joerg. Thank you!

Best regards,
baolu
