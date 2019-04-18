Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85834C10F0E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 11:20:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ECE4214DA
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 11:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECE4214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2C3BF1561;
	Thu, 18 Apr 2019 11:20:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A1348154C
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 11:20:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 455A8108
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 11:20:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1F0380D;
	Thu, 18 Apr 2019 04:20:35 -0700 (PDT)
Received: from red-moon (unknown [10.1.197.39])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 263683F59C;
	Thu, 18 Apr 2019 04:20:33 -0700 (PDT)
Date: Thu, 18 Apr 2019 12:20:29 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 3/9] ACPI/IORT: Check ATS capability in root complex
	nodes
Message-ID: <20190418112018.GA20470@red-moon>
References: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
	<20190417182448.12382-4-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190417182448.12382-4-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: zhongmiao@hisilicon.com, rjw@rjwysocki.net, will.deacon@arm.com,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
	bhelgaas@google.com, okaya@kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190418112029.pjUhWrJSucwwfudqw2MQr0r2EHG7rIDyjxtg3mAsdE8@z>

On Wed, Apr 17, 2019 at 07:24:42PM +0100, Jean-Philippe Brucker wrote:
> Root complex node in IORT has a bit telling whether it supports ATS or
> not. Store this bit in the IOMMU fwspec when setting up a device, so it
> can be accessed later by an IOMMU driver. In the future we'll probably
> want to store this bit at the host bridge or SMMU rather than in each
> endpoint.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/acpi/arm64/iort.c | 11 +++++++++++
>  include/linux/iommu.h     |  4 ++++
>  2 files changed, 15 insertions(+)

For the IORT portion:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index e48894e002ba..4000902e57f0 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1028,6 +1028,14 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>  	dev_dbg(dev, "dma_pfn_offset(%#08llx)\n", offset);
>  }
>  
> +static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
> +{
> +	struct acpi_iort_root_complex *pci_rc;
> +
> +	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
> +	return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
> +}
> +
>  /**
>   * iort_iommu_configure - Set-up IOMMU configuration for a device.
>   *
> @@ -1063,6 +1071,9 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>  		info.node = node;
>  		err = pci_for_each_dma_alias(to_pci_dev(dev),
>  					     iort_pci_iommu_init, &info);
> +
> +		if (!err && iort_pci_rc_supports_ats(node))
> +			dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
>  	} else {
>  		int i = 0;
>  
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 480921dfbadf..51ab006d348e 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -446,6 +446,7 @@ struct iommu_fwspec {
>  	const struct iommu_ops	*ops;
>  	struct fwnode_handle	*iommu_fwnode;
>  	void			*iommu_priv;
> +	u32			flags;
>  	unsigned int		num_ids;
>  	u32			ids[1];
>  };
> @@ -458,6 +459,9 @@ struct iommu_sva {
>  	const struct iommu_sva_ops	*ops;
>  };
>  
> +/* ATS is supported */
> +#define IOMMU_FWSPEC_PCI_RC_ATS			(1 << 0)
> +
>  int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
>  		      const struct iommu_ops *ops);
>  void iommu_fwspec_free(struct device *dev);
> -- 
> 2.21.0
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
