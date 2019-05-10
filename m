Return-Path: <SRS0=MPmd=TK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D255EC04A6B
	for <iommu@archiver.kernel.org>; Fri, 10 May 2019 10:21:41 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC72E20881
	for <iommu@archiver.kernel.org>; Fri, 10 May 2019 10:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC72E20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 652FCE90;
	Fri, 10 May 2019 10:21:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2F75BE82
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 10:21:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 3AAAE1FB
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 10:21:38 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7E7CA78;
	Fri, 10 May 2019 03:21:37 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFC863F738;
	Fri, 10 May 2019 03:21:35 -0700 (PDT)
Subject: Re: [PATCH 1/4] s390: pci: Exporting access to CLP PCI function and
	PCI group
To: Pierre Morel <pmorel@linux.ibm.com>, sebott@linux.vnet.ibm.com
References: <1557476555-20256-1-git-send-email-pmorel@linux.ibm.com>
	<1557476555-20256-2-git-send-email-pmorel@linux.ibm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a06ffd83-5fde-8c6e-b25b-bd4163d4cd5f@arm.com>
Date: Fri, 10 May 2019 11:21:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557476555-20256-2-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-GB
Cc: linux-s390@vger.kernel.org, pasic@linux.vnet.ibm.com, kvm@vger.kernel.org,
	heiko.carstens@de.ibm.com, walling@linux.ibm.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	borntraeger@de.ibm.com, alex.williamson@redhat.com,
	schwidefsky@de.ibm.com, gerald.schaefer@de.ibm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 10/05/2019 09:22, Pierre Morel wrote:
> For the generic implementation of VFIO PCI we need to retrieve
> the hardware configuration for the PCI functions and the
> PCI function groups.
> 
> We modify the internal function using CLP Query PCI function and
> CLP query PCI function group so that they can be called from
> outside the S390 architecture PCI code and prefix the two
> functions with "zdev" to make clear that they can be called
> knowing only the associated zdevice.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
> ---
>   arch/s390/include/asm/pci.h |  3 ++
>   arch/s390/pci/pci_clp.c     | 72 ++++++++++++++++++++++++---------------------
>   2 files changed, 41 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 305befd..e66b246 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -261,4 +261,7 @@ cpumask_of_pcibus(const struct pci_bus *bus)
>   
>   #endif /* CONFIG_NUMA */
>   
> +int zdev_query_pci_fngrp(struct zpci_dev *zdev,
> +			 struct clp_req_rsp_query_pci_grp *rrb);
> +int zdev_query_pci_fn(struct zpci_dev *zdev, struct clp_req_rsp_query_pci *rrb);
>   #endif
> diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
> index 3a36b07..4ae5d77 100644
> --- a/arch/s390/pci/pci_clp.c
> +++ b/arch/s390/pci/pci_clp.c
> @@ -113,32 +113,18 @@ static void clp_store_query_pci_fngrp(struct zpci_dev *zdev,
>   	}
>   }
>   
> -static int clp_query_pci_fngrp(struct zpci_dev *zdev, u8 pfgid)
> +int zdev_query_pci_fngrp(struct zpci_dev *zdev,
> +			 struct clp_req_rsp_query_pci_grp *rrb)
>   {
> -	struct clp_req_rsp_query_pci_grp *rrb;
> -	int rc;
> -
> -	rrb = clp_alloc_block(GFP_KERNEL);
> -	if (!rrb)
> -		return -ENOMEM;
> -
>   	memset(rrb, 0, sizeof(*rrb));
>   	rrb->request.hdr.len = sizeof(rrb->request);
>   	rrb->request.hdr.cmd = CLP_QUERY_PCI_FNGRP;
>   	rrb->response.hdr.len = sizeof(rrb->response);
> -	rrb->request.pfgid = pfgid;
> +	rrb->request.pfgid = zdev->pfgid;
>   
> -	rc = clp_req(rrb, CLP_LPS_PCI);
> -	if (!rc && rrb->response.hdr.rsp == CLP_RC_OK)
> -		clp_store_query_pci_fngrp(zdev, &rrb->response);
> -	else {
> -		zpci_err("Q PCI FGRP:\n");
> -		zpci_err_clp(rrb->response.hdr.rsp, rc);
> -		rc = -EIO;
> -	}
> -	clp_free_block(rrb);
> -	return rc;
> +	return clp_req(rrb, CLP_LPS_PCI);
>   }
> +EXPORT_SYMBOL(zdev_query_pci_fngrp);

AFAICS it's only the IOMMU driver itself which needs to call these. That 
can't be built as a module, so you shouldn't need explicit exports - the 
header declaration is enough.

Robin.

>   static int clp_store_query_pci_fn(struct zpci_dev *zdev,
>   				  struct clp_rsp_query_pci *response)
> @@ -174,32 +160,50 @@ static int clp_store_query_pci_fn(struct zpci_dev *zdev,
>   	return 0;
>   }
>   
> -static int clp_query_pci_fn(struct zpci_dev *zdev, u32 fh)
> +int zdev_query_pci_fn(struct zpci_dev *zdev, struct clp_req_rsp_query_pci *rrb)
> +{
> +
> +	memset(rrb, 0, sizeof(*rrb));
> +	rrb->request.hdr.len = sizeof(rrb->request);
> +	rrb->request.hdr.cmd = CLP_QUERY_PCI_FN;
> +	rrb->response.hdr.len = sizeof(rrb->response);
> +	rrb->request.fh = zdev->fh;
> +
> +	return clp_req(rrb, CLP_LPS_PCI);
> +}
> +EXPORT_SYMBOL(zdev_query_pci_fn);
> +
> +static int clp_query_pci(struct zpci_dev *zdev)
>   {
>   	struct clp_req_rsp_query_pci *rrb;
> +	struct clp_req_rsp_query_pci_grp *grrb;
>   	int rc;
>   
>   	rrb = clp_alloc_block(GFP_KERNEL);
>   	if (!rrb)
>   		return -ENOMEM;
>   
> -	memset(rrb, 0, sizeof(*rrb));
> -	rrb->request.hdr.len = sizeof(rrb->request);
> -	rrb->request.hdr.cmd = CLP_QUERY_PCI_FN;
> -	rrb->response.hdr.len = sizeof(rrb->response);
> -	rrb->request.fh = fh;
> -
> -	rc = clp_req(rrb, CLP_LPS_PCI);
> -	if (!rc && rrb->response.hdr.rsp == CLP_RC_OK) {
> -		rc = clp_store_query_pci_fn(zdev, &rrb->response);
> -		if (rc)
> -			goto out;
> -		rc = clp_query_pci_fngrp(zdev, rrb->response.pfgid);
> -	} else {
> +	rc = zdev_query_pci_fn(zdev, rrb);
> +	if (rc || rrb->response.hdr.rsp != CLP_RC_OK) {
>   		zpci_err("Q PCI FN:\n");
>   		zpci_err_clp(rrb->response.hdr.rsp, rc);
>   		rc = -EIO;
> +		goto out;
>   	}
> +	rc = clp_store_query_pci_fn(zdev, &rrb->response);
> +	if (rc)
> +		goto out;
> +
> +	grrb = (struct clp_req_rsp_query_pci_grp *)rrb;
> +	rc = zdev_query_pci_fngrp(zdev, grrb);
> +	if (rc || grrb->response.hdr.rsp != CLP_RC_OK) {
> +		zpci_err("Q PCI FGRP:\n");
> +		zpci_err_clp(grrb->response.hdr.rsp, rc);
> +		rc = -EIO;
> +		goto out;
> +	}
> +	clp_store_query_pci_fngrp(zdev, &grrb->response);
> +
>   out:
>   	clp_free_block(rrb);
>   	return rc;
> @@ -219,7 +223,7 @@ int clp_add_pci_device(u32 fid, u32 fh, int configured)
>   	zdev->fid = fid;
>   
>   	/* Query function properties and update zdev */
> -	rc = clp_query_pci_fn(zdev, fh);
> +	rc = clp_query_pci(zdev);
>   	if (rc)
>   		goto error;
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
