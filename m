Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05A4C433F5
	for <iommu@archiver.kernel.org>; Tue, 30 Nov 2021 11:54:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42E214034C;
	Tue, 30 Nov 2021 11:54:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WCcQExvOgrgy; Tue, 30 Nov 2021 11:54:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 06E174036C;
	Tue, 30 Nov 2021 11:54:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCD04C001C;
	Tue, 30 Nov 2021 11:54:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6428C001C
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 11:54:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C385360642
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 11:54:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WLHQlBFg0tlN for <iommu@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 11:54:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A51026063B
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 11:54:04 +0000 (UTC)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J3LF31Knkz67jq6;
 Tue, 30 Nov 2021 19:52:39 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Tue, 30 Nov 2021 12:54:00 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 30 Nov
 2021 11:53:59 +0000
Date: Tue, 30 Nov 2021 11:53:58 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 08/37] genirq/msi: Provide
 msi_device_populate/destroy_sysfs()
Message-ID: <20211130115358.000017ec@Huawei.com>
In-Reply-To: <20211126230524.416227100@linutronix.de>
References: <20211126224100.303046749@linutronix.de>
 <20211126230524.416227100@linutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: Nishanth Menon <nm@ti.com>, Mark
 Rutland <mark.rutland@arm.com>, Stuart Yoder <stuyoder@gmail.com>,
 linux-pci@vger.kernel.org, Will Deacon <will@kernel.org>,
 Ashok Raj <ashok.raj@intel.com>, Marc Zygnier <maz@kernel.org>, x86@kernel.org,
 Sinan Kaya <okaya@kernel.org>, iommu@lists.linux-foundation.org,
 Bjorn Helgaas <helgaas@kernel.org>, Megha Dey <megha.dey@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org
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
From: Jonathan Cameron via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Sat, 27 Nov 2021 02:20:19 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> Add new allocation functions which can be activated by domain info
> flags. They store the groups pointer in struct msi_device_data.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

A few trivial comments...

> ---
>  include/linux/msi.h |   12 +++++++++++-
>  kernel/irq/msi.c    |   42 ++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 51 insertions(+), 3 deletions(-)
> 
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -174,9 +174,11 @@ struct msi_desc {
>  /**
>   * msi_device_data - MSI per device data
>   * @lock:		Spinlock to protect register access
> + * @attrs:		Pointer to the sysfs attribute group
>   */
>  struct msi_device_data {
> -	raw_spinlock_t		lock;
> +	raw_spinlock_t			lock;

Trivial: Move the alignment change back to patch 2.

> +	const struct attribute_group    **attrs;
>  };
>  
>  int msi_setup_device_data(struct device *dev);
> @@ -242,10 +244,16 @@ void pci_msi_mask_irq(struct irq_data *d
>  void pci_msi_unmask_irq(struct irq_data *data);
>  
>  #ifdef CONFIG_SYSFS
> +int msi_device_populate_sysfs(struct device *dev);
> +void msi_device_destroy_sysfs(struct device *dev);
> +
>  const struct attribute_group **msi_populate_sysfs(struct device *dev);
>  void msi_destroy_sysfs(struct device *dev,
>  		       const struct attribute_group **msi_irq_groups);
>  #else
> +static inline int msi_device_populate_sysfs(struct device *dev) { return 0; }
> +static inline void msi_device_destroy_sysfs(struct device *dev) { }
> +
>  static inline const struct attribute_group **msi_populate_sysfs(struct device *dev)
>  {
>  	return NULL;
> @@ -393,6 +401,8 @@ enum {
>  	MSI_FLAG_MUST_REACTIVATE	= (1 << 5),
>  	/* Is level-triggered capable, using two messages */
>  	MSI_FLAG_LEVEL_CAPABLE		= (1 << 6),
> +	/* Populate sysfs on alloc() and destroy it on free() */
> +	MSI_FLAG_DEV_SYSFS		= (1 << 7),
>  };
>  
>  int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -214,6 +214,20 @@ const struct attribute_group **msi_popul
>  }
>  
>  /**
> + * msi_device_populate_sysfs - Populate msi_irqs sysfs entries for a device
> + * @dev:	The device(PCI, platform etc) which will get sysfs entries

Space after device

> + */
> +int msi_device_populate_sysfs(struct device *dev)
> +{
> +	const struct attribute_group **group = msi_populate_sysfs(dev);
> +
> +	if (IS_ERR(group))
> +		return PTR_ERR(group);
> +	dev->msi.data->attrs = group;
> +	return 0;
> +}
> +
> +/**
>   * msi_destroy_sysfs - Destroy msi_irqs sysfs entries for devices
>   * @dev:		The device(PCI, platform etc) who will remove sysfs entries
>   * @msi_irq_groups:	attribute_group for device msi_irqs entries
> @@ -239,6 +253,17 @@ void msi_destroy_sysfs(struct device *de
>  		kfree(msi_irq_groups);
>  	}
>  }
> +
> +/**
> + * msi_device_destroy_sysfs - Destroy msi_irqs sysfs entries for a device
> + * @dev:		The device(PCI, platform etc) for which to remove
> + *			sysfs entries
> + */
> +void msi_device_destroy_sysfs(struct device *dev)
> +{
> +	msi_destroy_sysfs(dev, dev->msi.data->attrs);
> +	dev->msi.data->attrs = NULL;
> +}
>  #endif
>  
>  #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
> @@ -686,8 +711,19 @@ int msi_domain_alloc_irqs(struct irq_dom
>  {
>  	struct msi_domain_info *info = domain->host_data;
>  	struct msi_domain_ops *ops = info->ops;
> +	int ret;
>  
> -	return ops->domain_alloc_irqs(domain, dev, nvec);
> +	ret = ops->domain_alloc_irqs(domain, dev, nvec);
> +	if (ret)
> +		return ret;
> +
> +	if (!(info->flags & MSI_FLAG_DEV_SYSFS))
> +		return 0;
> +
> +	ret = msi_device_populate_sysfs(dev);
> +	if (ret)
> +		msi_domain_free_irqs(domain, dev);
> +	return ret;
>  }
>  
>  void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
> @@ -726,7 +762,9 @@ void msi_domain_free_irqs(struct irq_dom
>  	struct msi_domain_info *info = domain->host_data;
>  	struct msi_domain_ops *ops = info->ops;
>  
> -	return ops->domain_free_irqs(domain, dev);
> +	if (info->flags & MSI_FLAG_DEV_SYSFS)
> +		msi_device_destroy_sysfs(dev);
> +	ops->domain_free_irqs(domain, dev);
>  }
>  
>  /**
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
