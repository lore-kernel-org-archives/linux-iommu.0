Received: from mgamail.intel.com (unknown [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5766FAB
	for <iommu@lists.linux.dev>; Tue, 26 Sep 2023 08:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695716733; x=1727252733;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RzaK2ndr7+vnVbIQ7VkWAWjQc7Kpbl44AZ82PRlStIo=;
  b=U8H+lHyNlIn0dyKblc0ZSImYPRNIq8hXRpIyNYN7Ayfe6ZcpLXSQEfL5
   4bFPSv0qdz99pgx14mODBGQkBvNtZvF0X304Q+v+Vnykf1jBjTczXwMNt
   vSXpTRj3iegQBfZe126JZsQ+UOW7ebypYIa6qo5FjSrv3xKNW7uU0Rb9W
   5ppqEpuNrdvgiN44PPL8e1bEDlvOxcWc62YgWQa84yzQua1yzwHQxK7d+
   F05Pwmui3f/LbjmEsYaH1CJk06EpPcBkT3tjSYoBZ6DxgGQLIug2UavL/
   hwEq8ZFoa+yo2ulsWBUEOo6XWuHe9fppibh3mahGKokN5Tr2dxPAk4hLu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="160421"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="160421"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:25:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="995744380"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="995744380"
Received: from jiaqingh-mobl.ccr.corp.intel.com (HELO [10.93.22.70]) ([10.93.22.70])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:25:28 -0700
Message-ID: <56cc2e4e-81dd-f2d2-f690-6d82217b9e7d@intel.com>
Date: Tue, 26 Sep 2023 16:25:26 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] iommu/vt-d: Introduce a rb_tree for looking up device
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
 baolu.lu@linux.intel.com, jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com
References: <20230821071659.123981-1-jiaqing.huang@intel.com>
 <ZRFA3uj1-QjlXpGx@8bytes.org>
From: "Huang, Jiaqing" <jiaqing.huang@intel.com>
In-Reply-To: <ZRFA3uj1-QjlXpGx@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/2023 4:12 PM, Joerg Roedel wrote:

> On Mon, Aug 21, 2023 at 12:16:59AM -0700, Huang Jiaqing wrote:
>> The existing IO page fault handler locates the PCI device by calling
>> pci_get_domain_bus_and_slot(), which searches the list of all PCI
>> devices until the desired PCI device is found. This is inefficient
>> because the algorithm efficiency of searching a list is O(n). In the
>> critical path of handling an IO page fault, this can cause a significant
>> performance bottleneck.
> Can you elaborate a little more on the 'significant performance
> bottleneck' part? Where do you see this as a problem?
>
> Regards,
>
> 	Joerg
While lots of dsa devices were enabled, parallel dsa_test with large 
transfer size
would be executed ineffciently and cause cpu stuck in 
pci_get_domain_bus_and_slot
by lock competition. The introduced patch could significantly improve 
the speed and
prevent the CPU from getting sutck. It maybe confusing for "significant 
performance
bottleneck" since it didn't benefit all the cases, would rephase it in 
the new patch. Thanks!

BRs,
Jiaqing
