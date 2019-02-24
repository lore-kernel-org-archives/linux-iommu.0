From: James Dong <xmdong@google.com>
Subject: RE: [PATCH] iommu/vt-d: Handle hotplug devices' default identity
 mapping setting
Date: Sun, 24 Feb 2019 16:10:30 +0000
Message-ID: <20190224161030.253393-1-xmdong@google.com>
References: <897e8383-ad75-35d0-5ad9-3d3a8b46b6ba@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <897e8383-ad75-35d0-5ad9-3d3a8b46b6ba@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jis Ben <jisben@google.com>, James Dong <xmdong@google.com>
List-Id: iommu@lists.linux-foundation.org

Baolu:

Yes, it is a generic issue for hotplug devices with current Intel IOMMU driver,
as reported in this thread as well.

The patch you provided does the job in our case. Please update this thread once
your patch is merged. Thanks.

Best Regards,
James

On 2/23/19 12:56 AM, Lu Baolu wrote
>
> @@ -4807,16 +4807,19 @@ static int device_notifier(struct notifier_block *nb,
> 	if (iommu_dummy(dev))
> 		return 0;
> 
>-	if (action != BUS_NOTIFY_REMOVED_DEVICE)
>-		return 0;
>-
>-	domain = find_domain(dev);
>-	if (!domain)
>-		return 0;
>+	if (action == BUS_NOTIFY_REMOVED_DEVICE) {
>+		domain = find_domain(dev);
>+		if (!domain)
>+			return 0;
> 
>-	dmar_remove_one_dev_info(dev);
>-	if (!domain_type_is_vm_or_si(domain) && list_empty(&domain->devices))
>-		domain_exit(domain);
>+		dmar_remove_one_dev_info(dev);
>+		if (!domain_type_is_vm_or_si(domain) &&
>+		    list_empty(&domain->devices))
>+			domain_exit(domain);
>+	} else if (action == BUS_NOTIFY_ADD_DEVICE) {
>+		if (iommu_should_identity_map(dev, 1))
>+			domain_add_dev_info(si_domain, dev);
>+	}
