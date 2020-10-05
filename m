Return-Path: <SRS0=BXsX=DM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCD0C4363A
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 10:35:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F6FE2078D
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 10:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6FE2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 18BAD20381;
	Mon,  5 Oct 2020 10:35:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3tzNsLbEwpQ6; Mon,  5 Oct 2020 10:35:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DE42520012;
	Mon,  5 Oct 2020 10:35:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2729C016F;
	Mon,  5 Oct 2020 10:35:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DA56C0051
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 10:35:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 56E2485608
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 10:35:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bWjw44TqlQ9B for <iommu@lists.linux-foundation.org>;
 Mon,  5 Oct 2020 10:35:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4D0B9855C6
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 10:35:44 +0000 (UTC)
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 966FAD6551D65A98996D;
 Mon,  5 Oct 2020 11:35:41 +0100 (IST)
Received: from localhost (10.52.124.175) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 5 Oct 2020
 11:35:41 +0100
Date: Mon, 5 Oct 2020 11:33:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v3 14/14] iommu/amd: Adopt IO page table framework
Message-ID: <20201005103357.000062d9@Huawei.com>
In-Reply-To: <20201004014549.16065-15-suravee.suthikulpanit@amd.com>
References: <20201004014549.16065-1-suravee.suthikulpanit@amd.com>
 <20201004014549.16065-15-suravee.suthikulpanit@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.52.124.175]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Sun, 4 Oct 2020 01:45:49 +0000
Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:

> Switch to using IO page table framework for AMD IOMMU v1 page table.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

One minor thing inline.


> ---
>  drivers/iommu/amd/iommu.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 77f44b927ae7..6f8316206fb8 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -32,6 +32,7 @@
>  #include <linux/irqdomain.h>
>  #include <linux/percpu.h>
>  #include <linux/iova.h>
> +#include <linux/io-pgtable.h>
>  #include <asm/irq_remapping.h>
>  #include <asm/io_apic.h>
>  #include <asm/apic.h>
> @@ -1573,6 +1574,22 @@ static int pdev_iommuv2_enable(struct pci_dev *pdev)
>  	return ret;
>  }
>  
> +struct io_pgtable_ops *
> +amd_iommu_setup_io_pgtable_ops(struct iommu_dev_data *dev_data,
> +			       struct protection_domain *domain)
> +{
> +	struct amd_iommu *iommu = amd_iommu_rlookup_table[dev_data->devid];
> +
> +	domain->iop.pgtbl_cfg = (struct io_pgtable_cfg) {
> +		.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
> +		.ias		= IOMMU_IN_ADDR_BIT_SIZE,
> +		.oas		= IOMMU_OUT_ADDR_BIT_SIZE,
> +		.iommu_dev	= &iommu->dev->dev,
> +	};
> +
> +	return alloc_io_pgtable_ops(AMD_IOMMU_V1, &domain->iop.pgtbl_cfg, domain);
> +}
> +
>  /*
>   * If a device is not yet associated with a domain, this function makes the
>   * device visible in the domain
> @@ -1580,6 +1597,7 @@ static int pdev_iommuv2_enable(struct pci_dev *pdev)
>  static int attach_device(struct device *dev,
>  			 struct protection_domain *domain)
>  {
> +	struct io_pgtable_ops *pgtbl_ops;
>  	struct iommu_dev_data *dev_data;
>  	struct pci_dev *pdev;
>  	unsigned long flags;
> @@ -1623,6 +1641,12 @@ static int attach_device(struct device *dev,
>  skip_ats_check:
>  	ret = 0;
>  
> +	pgtbl_ops = amd_iommu_setup_io_pgtable_ops(dev_data, domain);
> +	if (!pgtbl_ops) {

Perhaps cleaner to not store in a local variable if you aren't going to use it?

	if (!amd_iommu_setup_io_pgtable_ops(dev_data, domain)) {

> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
>  	do_attach(dev_data, domain);
>  
>  	/*
> @@ -1958,6 +1982,8 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
>  	if (domain->dev_cnt > 0)
>  		cleanup_domain(domain);
>  
> +	free_io_pgtable_ops(&domain->iop.iop.ops);
> +
>  	BUG_ON(domain->dev_cnt != 0);
>  
>  	if (!dom)


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
