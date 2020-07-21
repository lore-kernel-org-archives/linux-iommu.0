Return-Path: <SRS0=qNYd=BA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2280BC433E5
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 14:59:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E015320729
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 14:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVngLU/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E015320729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B513F889AF;
	Tue, 21 Jul 2020 14:59:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lCE294U0DbPD; Tue, 21 Jul 2020 14:59:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 08A74889AB;
	Tue, 21 Jul 2020 14:59:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4903C089F;
	Tue, 21 Jul 2020 14:59:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25EA3C016F
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 14:59:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1F77120530
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 14:59:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9R2+SHjTgQue for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jul 2020 14:59:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 4145420493
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 14:59:05 +0000 (UTC)
Received: from localhost (mobile-166-175-191-139.mycingular.net
 [166.175.191.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B7F6E20578;
 Tue, 21 Jul 2020 14:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595343545;
 bh=4IycvsYyfCQven5hmEHIv/wE1B/4BTld8UhyXIAjIwk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=BVngLU/SGFKGdQVLXD0kKAx7KrJjQBCObzjMI7XXMnLPcOaJ1uDP3ToNUia1AhmTw
 uL3nZhL8/9Ucx6nS9GSO+uT81Lhla1RNKWihgB10H8s1NuCo6gFGz35ho5OvxTKi5S
 nEC7yGL7Sb2KrxySzhtgq2rk86sZt5CTTiq5xGGw=
Date: Tue, 21 Jul 2020 09:59:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 03/12] ACPI/IORT: Make iort_msi_map_rid() PCI agnostic
Message-ID: <20200721145903.GA1117934@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200619082013.13661-4-lorenzo.pieralisi@arm.com>
Cc: devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Makarand Pawagi <makarand.pawagi@nxp.com>, linux-pci@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Hanjun Guo <guohanjun@huawei.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robin Murphy <robin.murphy@arm.com>,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Diana Craciun <diana.craciun@oss.nxp.com>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Fri, Jun 19, 2020 at 09:20:04AM +0100, Lorenzo Pieralisi wrote:
> There is nothing PCI specific in iort_msi_map_rid().
> 
> Rename the function using a bus protocol agnostic name,
> iort_msi_map_id(), and convert current callers to it.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Sorry I missed this!

> ---
>  drivers/acpi/arm64/iort.c | 12 ++++++------
>  drivers/pci/msi.c         |  2 +-
>  include/linux/acpi_iort.h |  6 +++---
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 902e2aaca946..53f9ef515089 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -568,22 +568,22 @@ static struct acpi_iort_node *iort_find_dev_node(struct device *dev)
>  }
>  
>  /**
> - * iort_msi_map_rid() - Map a MSI requester ID for a device
> + * iort_msi_map_id() - Map a MSI input ID for a device
>   * @dev: The device for which the mapping is to be done.
> - * @req_id: The device requester ID.
> + * @input_id: The device input ID.
>   *
> - * Returns: mapped MSI RID on success, input requester ID otherwise
> + * Returns: mapped MSI ID on success, input ID otherwise
>   */
> -u32 iort_msi_map_rid(struct device *dev, u32 req_id)
> +u32 iort_msi_map_id(struct device *dev, u32 input_id)
>  {
>  	struct acpi_iort_node *node;
>  	u32 dev_id;
>  
>  	node = iort_find_dev_node(dev);
>  	if (!node)
> -		return req_id;
> +		return input_id;
>  
> -	iort_node_map_id(node, req_id, &dev_id, IORT_MSI_TYPE);
> +	iort_node_map_id(node, input_id, &dev_id, IORT_MSI_TYPE);
>  	return dev_id;
>  }
>  
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 74a91f52ecc0..77f48b95e277 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1536,7 +1536,7 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
>  
>  	of_node = irq_domain_get_of_node(domain);
>  	rid = of_node ? of_msi_map_rid(&pdev->dev, of_node, rid) :
> -			iort_msi_map_rid(&pdev->dev, rid);
> +			iort_msi_map_id(&pdev->dev, rid);
>  
>  	return rid;
>  }
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index 08ec6bd2297f..e51425e083da 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -28,7 +28,7 @@ void iort_deregister_domain_token(int trans_id);
>  struct fwnode_handle *iort_find_domain_token(int trans_id);
>  #ifdef CONFIG_ACPI_IORT
>  void acpi_iort_init(void);
> -u32 iort_msi_map_rid(struct device *dev, u32 req_id);
> +u32 iort_msi_map_id(struct device *dev, u32 id);
>  struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
>  					  enum irq_domain_bus_token bus_token);
>  void acpi_configure_pmsi_domain(struct device *dev);
> @@ -39,8 +39,8 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev);
>  int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
>  #else
>  static inline void acpi_iort_init(void) { }
> -static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
> -{ return req_id; }
> +static inline u32 iort_msi_map_id(struct device *dev, u32 id)
> +{ return id; }
>  static inline struct irq_domain *iort_get_device_domain(
>  	struct device *dev, u32 id, enum irq_domain_bus_token bus_token)
>  { return NULL; }
> -- 
> 2.26.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
