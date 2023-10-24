Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AC2224FE
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jb2OtDxI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698148923; x=1729684923;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aPOLTqz6uP6WaCFzg7y4GFdJcJn10yPDR/rrSJsgu+M=;
  b=jb2OtDxIW+j1dpRTMSn/+n+xky0YWvy1oajH1FDfNjnpqs5eheoh0lxa
   FAsb824YhcBSpRLeVbSymf88cbOva28O7fptxtDMHyoIJ6imTBdsBoIVZ
   sZdHtwdStDs7RovmmU/Qv7JvwsiixPY4BCgotF0rRjr8ctmdTziIjzeqI
   lp0Kzbn2bVyYsuomH7eR1SCJ0YHd7McnbxCvAyqZOP/+44xY4pxkKDyoI
   BpPreq4j4LCkZg/zui2v3Yl+lBbetYUIQnA3FpmxJLyQTnjLBzse7j/Gl
   XVKFLhqQiCUqBibsPJyKbYAWm4L4I7JjmR9CJMQr9tdpzsu1ic9NeKrHQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="384239728"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="384239728"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 05:01:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="1005635705"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="1005635705"
Received: from qiangfu1-mobl1.ccr.corp.intel.com (HELO [10.254.212.47]) ([10.254.212.47])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 05:01:27 -0700
Message-ID: <b53672fe-cad4-4aa7-94ef-59895892b75a@linux.intel.com>
Date: Tue, 24 Oct 2023 20:01:25 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, jacob.jun.pan@linux.intel.com,
 kevin.tian@intel.com, yi.y.sun@intel.com, kvm@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/vt-d: Adopt new helper for looking up pci
 device
Content-Language: en-US
To: Huang Jiaqing <jiaqing.huang@intel.com>, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20231024084124.11155-1-jiaqing.huang@intel.com>
 <20231024084124.11155-2-jiaqing.huang@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231024084124.11155-2-jiaqing.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/10/24 16:41, Huang Jiaqing wrote:
> Adopt the new iopf_queue_find_pdev func() to look up PCI device
> for better efficiency and avoid the CPU stuck issue with parallel
> heavy dsa_test.
> 
> Signed-off-by: Huang Jiaqing <jiaqing.huang@intel.com>
> ---
>   drivers/iommu/intel/svm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 659de9c16024..0f1018b76557 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -672,7 +672,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>   		if (unlikely(req->lpig && !req->rd_req && !req->wr_req))
>   			goto prq_advance;
>   
> -		pdev = pci_get_domain_bus_and_slot(iommu->segment,
> +		pdev = iopf_queue_find_pdev(iommu->iopf_queue,
>   						   PCI_BUS_NUM(req->rid),
>   						   req->rid & 0xff);

Minor: align the new line with the left parenthesis.

>   		/*
> @@ -688,7 +688,6 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>   			trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
>   					 req->priv_data[0], req->priv_data[1],
>   					 iommu->prq_seq_number++);
> -		pci_dev_put(pdev);
>   prq_advance:
>   		head = (head + sizeof(*req)) & PRQ_RING_MASK;
>   	}

Best regards,
baolu
