Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E92F8BFB
	for <iommu@lists.linux.dev>; Fri, 27 Oct 2023 06:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jG17LllE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698386889; x=1729922889;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MfNBA+R8W2olLLNj9+ipO5U4qZClWyZHkbwLz8wq2w0=;
  b=jG17LllEbz6arbxe1VIA8ad5AO8bZU9jwvyeGseyWmYVIPn/Lj2MF3n8
   Erj3x20cWNPvOTA2I/UhUlEBn5DMZj8hD9ihZr1S/peteg1TkzGOgAlUy
   6WQAspX/3YzgK8xlXVNVHEcs9pzNZz+jELv14NY3d8MUCznMF7KiqwGKW
   gOBtu7Y1XMqpe6iQM3DJuiLcf7P2yOAXJGKbOPt3mIlvQw8/ACgkH6iTz
   CbnVxEuKaoDAzM3tsWeaTT8A8aeLQ3Jfw3JausfVaADSal7OY4QoVhbug
   gnkBKMOQmnsxJ1wn9XwggvHSN84f4/IizYuwiWYX3qKLoZX/l8VY0zFb7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="418823613"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="418823613"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 23:08:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="707978"
Received: from jiaqingh-mobl.ccr.corp.intel.com (HELO [10.93.11.63]) ([10.93.11.63])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 23:07:29 -0700
Message-ID: <2f1ed1eb-6ac3-4af9-b328-5b62c38459a8@intel.com>
Date: Fri, 27 Oct 2023 14:08:02 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/vt-d: Adopt new helper for looking up pci
 device
To: Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, dwmw2@infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
Cc: jacob.jun.pan@linux.intel.com, kevin.tian@intel.com, yi.y.sun@intel.com,
 kvm@vger.kernel.org
References: <20231024084124.11155-1-jiaqing.huang@intel.com>
 <20231024084124.11155-2-jiaqing.huang@intel.com>
 <b53672fe-cad4-4aa7-94ef-59895892b75a@linux.intel.com>
Content-Language: en-US
From: "Huang, Jiaqing" <jiaqing.huang@intel.com>
In-Reply-To: <b53672fe-cad4-4aa7-94ef-59895892b75a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/24/2023 8:01 PM, Baolu Lu wrote:

> On 2023/10/24 16:41, Huang Jiaqing wrote:
>> Adopt the new iopf_queue_find_pdev func() to look up PCI device
>> for better efficiency and avoid the CPU stuck issue with parallel
>> heavy dsa_test.
>>
>> Signed-off-by: Huang Jiaqing <jiaqing.huang@intel.com>
>> ---
>>   drivers/iommu/intel/svm.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>> index 659de9c16024..0f1018b76557 100644
>> --- a/drivers/iommu/intel/svm.c
>> +++ b/drivers/iommu/intel/svm.c
>> @@ -672,7 +672,7 @@ static irqreturn_t prq_event_thread(int irq, void
>> *d)
>>           if (unlikely(req->lpig && !req->rd_req && !req->wr_req))
>>               goto prq_advance;
>>   -        pdev = pci_get_domain_bus_and_slot(iommu->segment,
>> +        pdev = iopf_queue_find_pdev(iommu->iopf_queue,
>>                              PCI_BUS_NUM(req->rid),
>>                              req->rid & 0xff);
>
> Minor: align the new line with the left parenthesis.

Got it, will fix it, thanks for catching!

BRs,
Jiaqing
