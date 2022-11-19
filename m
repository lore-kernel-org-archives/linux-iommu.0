Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161FB20E4
	for <iommu@lists.linux.dev>; Sat, 19 Nov 2022 11:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668857049; x=1700393049;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yJfOdiSLzRH78Mxz/QhCbGiSMi5+QhKtJkNRwKnlkmg=;
  b=YIGuY50amJ5Kp5yxjVAD71LviZ+2W3DTVlHK8u6XsygODf+qq6y/k0O5
   i+EsUR+CyPlkrxLDJLeCiArcO6ujOrOMU58x3H1evDWsBpC15urmx5Hbb
   zzf+jjjT0nq3BE5c5lG+mGFXN6mhLI12W8sbnpDIaOLKf7MD/OtUrbEFo
   Iuie/g2rDDMapZmbM4ZTNvPPr+YS83Tmu/eV07lIbdh5WC+KuXw6BYndL
   nSQAWqQrzvGazzRv7b743x+HJ5lPvYdNT3xMyqkzAWJoLb7NGzEG4uqt8
   UVPSbR2UVK6UzPcSxZvIyGt2W623O+7udfiaOIRShG0AUc4L06YCqYyUj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="312013217"
X-IronPort-AV: E=Sophos;i="5.96,176,1665471600"; 
   d="scan'208";a="312013217"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2022 03:24:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="671604467"
X-IronPort-AV: E=Sophos;i="5.96,176,1665471600"; 
   d="scan'208";a="671604467"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.92]) ([10.254.210.92])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2022 03:24:06 -0800
Message-ID: <5067335c-381f-3548-081a-c1a278871c85@linux.intel.com>
Date: Sat, 19 Nov 2022 19:24:04 +0800
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
To: Yang Yingliang <yangyingliang@huawei.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
References: <20221119103436.1859167-1-yangyingliang@huawei.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20221119103436.1859167-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Yingliang,

On 2022/11/19 18:34, Yang Yingliang wrote:
> As comment of pci_get_domain_bus_and_slot() says, it returns
> a pci device with refcount increment, when finish using it,
> the caller must decrement the reference count by calling
> pci_dev_put(). So call pci_dev_put() after using the 'pdev'
> to avoid refcount leak.
> 
> Fixes: 06f4b8d09dba ("iommu/vt-d: Remove unnecessary SVA data accesses in page fault path")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   drivers/iommu/intel/svm.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 7d08eb034f2d..47c07556955e 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -751,6 +751,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>   		trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
>   				 req->priv_data[0], req->priv_data[1],
>   				 iommu->prq_seq_number++);
> +		pci_dev_put(pdev);
>   prq_advance:
>   		head = (head + sizeof(*req)) & PRQ_RING_MASK;
>   	}

Thanks for the fix.Furthermore, if the returned @pdev is empty, we do
not need to trace this fault, nor do we need to put the device. Hence,
how about below changes?

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 7d08eb034f2d..2991f9cccf5f 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -745,12 +745,17 @@ static irqreturn_t prq_event_thread(int irq, void *d)
                  * If prq is to be handled outside iommu driver via 
receiver of
                  * the fault notifiers, we skip the page response here.
                  */
-               if (!pdev || intel_svm_prq_report(iommu, &pdev->dev, req))
-                       handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
+               if (!pdev)
+                       goto prq_advance;

-               trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
-                                req->priv_data[0], req->priv_data[1],
-                                iommu->prq_seq_number++);
+               if (intel_svm_prq_report(iommu, &pdev->dev, req))
+                       handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
+               else
+                       trace_prq_report(iommu, &pdev->dev,
+                                        req->qw_0, req->qw_1,
+                                        req->priv_data[0], 
req->priv_data[1],
+                                        iommu->prq_seq_number++);
+               pci_dev_put(pdev);
  prq_advance:
                 head = (head + sizeof(*req)) & PRQ_RING_MASK;
         }

Best regards,
baolu
