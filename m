Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83162381
	for <iommu@lists.linux.dev>; Sat, 19 Nov 2022 12:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668859589; x=1700395589;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yUCLbGjtsJsXoW+MW0nRMBuWfLTIAmIF89MnRXySkmc=;
  b=CSiJIMlw4Cy9PthIOJv2UduxCftgnqGjCp5d5Sta2UP8QGFvQcc5uyBI
   qcNds1wBXNw5gCph2lZOxySIms0nGpVHIbMDhPxlwtf15/XYUvbbjZrVx
   Hm36eiMz8/B7B076Bg51In9YGrJVMVhc3gI/gAHz/HKBLLrbIojmLDFfi
   n77hN8mL7mfKXNzfzyYUstoNWqZVG0tJ9kDfwOIwuHixRngtK49AK+0sd
   Xn5anFarZtXTqXc6OBQJMfktxSku3n4voeplkkPKY7OPngxKZR3AhKZBK
   qxOVwUAmFna7J2RSqfS7qcVWHFzIj90494DZVjL4bst0hKAkUyM+I6j7U
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="310944117"
X-IronPort-AV: E=Sophos;i="5.96,176,1665471600"; 
   d="scan'208";a="310944117"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2022 04:06:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="709323372"
X-IronPort-AV: E=Sophos;i="5.96,176,1665471600"; 
   d="scan'208";a="709323372"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.92]) ([10.254.210.92])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2022 04:06:27 -0800
Message-ID: <878d3750-2561-6fb6-c722-fc40d6e66e85@linux.intel.com>
Date: Sat, 19 Nov 2022 20:06:25 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev
Subject: Re: [PATCH] iommu/vt-d: fix pci device refcount leak in
 prq_event_thread()
Content-Language: en-US
To: Yang Yingliang <yangyingliang@huawei.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
References: <20221119103436.1859167-1-yangyingliang@huawei.com>
 <5067335c-381f-3548-081a-c1a278871c85@linux.intel.com>
 <4d3afa6b-b386-fef4-cfea-0eac4d52175f@linux.intel.com>
 <229799e9-f9ff-820a-e911-deb482c0f2e4@huawei.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <229799e9-f9ff-820a-e911-deb482c0f2e4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2022/11/19 20:00, Yang Yingliang wrote:
> May be this looks more clear:
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 7d08eb034f2d..35e44f79b7ac 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -745,12 +745,16 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>                   * If prq is to be handled outside iommu driver via 
> receiver of
>                   * the fault notifiers, we skip the page response here.
>                   */
> -               if (!pdev || intel_svm_prq_report(iommu, &pdev->dev, req))
> +               if (!pdev || intel_svm_prq_report(iommu, &pdev->dev, 
> req)) {
>                          handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
> +                       goto put_dev;
> +               }

	else
		trace_prq_report(...)

looks more readable.

> 
>                  trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
>                                   req->priv_data[0], req->priv_data[1],
>                                   iommu->prq_seq_number++);
> +put_dev:
> +               pci_dev_put(pdev);
>   prq_advance:
>                  head = (head + sizeof(*req)) & PRQ_RING_MASK;
>          }

Best regards,
baolu
