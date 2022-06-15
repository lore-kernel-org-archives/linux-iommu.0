Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C7FC43334
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 01:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E6C760A8C;
	Wed, 15 Jun 2022 01:53:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tK5KHOHeW3-A; Wed, 15 Jun 2022 01:53:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F001C60A69;
	Wed, 15 Jun 2022 01:53:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0122C0032;
	Wed, 15 Jun 2022 01:53:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD202C002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 01:53:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D48B9818E6
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 01:53:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O89QOLrkrVS1 for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 01:53:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF46E818C0
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 01:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655258027; x=1686794027;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=wYIf8dNX/BnoqZbWiiybUsjtAEjgSh60fNd/XByI5Mw=;
 b=UQ7rQwpjKUQ+c5UPzcPBQTpw1vTiMGpERnSnSK3he2Uj0dQR8RMBj3wO
 fc3IRL9cNvWi6AwayLypnQK7mov57IEWY8FVVTXHGvPzHat7AckzPtNDM
 fO0PGjJf/GlhPNBr/kL25tYb9ci0EzRWQq2rQoPXnvgZmYEpPMvCLfFVq
 Ofh3+ktQH3FdKeBdYTXMCbEr7YArMS9DaNkJWRpruYk5qRLqdYOqRIuWd
 xM5374MVu6SqRYZh7uiNnWo+VtPJCHtRYLtpYpUlNHocwWWRynkQyAxo9
 j8I2aYUmMch7vo/oWwBklchwxdL3/5Bmyg+Ag/+UgomTd62tcor0j2q6B Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="279838868"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; d="scan'208";a="279838868"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2022 18:53:46 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; d="scan'208";a="588814758"
Received: from leitan-mobl.ccr.corp.intel.com (HELO [10.255.31.142])
 ([10.255.31.142])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2022 18:53:43 -0700
Message-ID: <4f6f7bb9-5ea4-b466-7a59-62ebd5bc2cf7@linux.intel.com>
Date: Wed, 15 Jun 2022 09:53:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 01/12] iommu/vt-d: debugfs: Remove device_domain_lock
 usage
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
 <20220614025137.1632762-2-baolu.lu@linux.intel.com>
 <BN9PR11MB527680C1957C0E29E8AE85168CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527680C1957C0E29E8AE85168CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022/6/14 14:43, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 14, 2022 10:51 AM
>>
>> The domain_translation_struct debugfs node is used to dump the DMAR
>> page
>> tables for the PCI devices. It potentially races with setting domains to
>> devices. The existing code uses a global spinlock device_domain_lock to
>> avoid the races, but this is problematical as this lock is only used to
>> protect the device tracking lists of each domain.
> is it really problematic at this point? Before following patches are applied
> using device_domain_lock should have similar effect as holding the group
> lock.
> 
> Here it might make more sense to just focus on removing the use of
> device_domain_lock outside of iommu.c. Just that using group lock is
> cleaner and more compatible to following cleanups.
> 
> and it's worth mentioning that racing with page table updates is out
> of the scope of this series. Probably also add a comment in the code
> to clarify this point.
> 

Hi Kevin,

How do you like below updated patch?

 From cecc9a0623780a11c4ea4d0a15aa6187f01541c4 Mon Sep 17 00:00:00 2001
From: Lu Baolu <baolu.lu@linux.intel.com>
Date: Sun, 29 May 2022 10:18:56 +0800
Subject: [PATCH 1/1] iommu/vt-d: debugfs: Remove device_domain_lock usage

The domain_translation_struct debugfs node is used to dump the DMAR page
tables for the PCI devices. It potentially races with setting domains to
devices. The existing code uses the global spinlock device_domain_lock to
avoid the races.

This removes the use of device_domain_lock outside of iommu.c by replacing
it with the group mutex lock. Using the group mutex lock is cleaner and
more compatible to following cleanups.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
  drivers/iommu/intel/debugfs.c | 42 +++++++++++++++++++++++++----------
  drivers/iommu/intel/iommu.c   |  2 +-
  drivers/iommu/intel/iommu.h   |  1 -
  3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index d927ef10641b..f4acd8993f60 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -342,13 +342,13 @@ static void pgtable_walk_level(struct seq_file *m, 
struct dma_pte *pde,
  	}
  }

-static int show_device_domain_translation(struct device *dev, void *data)
+static int __show_device_domain_translation(struct device *dev, void *data)
  {
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct dmar_domain *domain = info->domain;
+	struct dmar_domain *domain;
  	struct seq_file *m = data;
  	u64 path[6] = { 0 };

+	domain = to_dmar_domain(iommu_get_domain_for_dev(dev));
  	if (!domain)
  		return 0;

@@ -359,20 +359,38 @@ static int show_device_domain_translation(struct 
device *dev, void *data)
  	pgtable_walk_level(m, domain->pgd, domain->agaw + 2, 0, path);
  	seq_putc(m, '\n');

-	return 0;
+	return 1;
  }

-static int domain_translation_struct_show(struct seq_file *m, void *unused)
+static int show_device_domain_translation(struct device *dev, void *data)
  {
-	unsigned long flags;
-	int ret;
+	struct iommu_group *group;

-	spin_lock_irqsave(&device_domain_lock, flags);
-	ret = bus_for_each_dev(&pci_bus_type, NULL, m,
-			       show_device_domain_translation);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	group = iommu_group_get(dev);
+	if (group) {
+		/*
+		 * The group->mutex is held across the callback, which will
+		 * block calls to iommu_attach/detach_group/device. Hence,
+		 * the domain of the device will not change during traversal.
+		 *
+		 * All devices in an iommu group share a single domain, hence
+		 * we only dump the domain of the first device. Even though,
+		 * this code still possibly races with the iommu_unmap()
+		 * interface. This could be solved by RCU-freeing the page
+		 * table pages in the iommu_unmap() path.
+		 */
+		iommu_group_for_each_dev(group, data,
+					 __show_device_domain_translation);
+		iommu_group_put(group);
+	}

-	return ret;
+	return 0;
+}
+
+static int domain_translation_struct_show(struct seq_file *m, void *unused)
+{
+	return bus_for_each_dev(&pci_bus_type, NULL, m,
+				show_device_domain_translation);
  }
  DEFINE_SHOW_ATTRIBUTE(domain_translation_struct);

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 19024dc52735..a39d72a9d1cf 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -314,7 +314,7 @@ static int iommu_skip_te_disable;
  #define IDENTMAP_GFX		2
  #define IDENTMAP_AZALIA		4

-DEFINE_SPINLOCK(device_domain_lock);
+static DEFINE_SPINLOCK(device_domain_lock);
  static LIST_HEAD(device_domain_list);

  /*
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index a22adfbdf870..8a6d64d726c0 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -480,7 +480,6 @@ enum {
  #define VTD_FLAG_SVM_CAPABLE		(1 << 2)

  extern int intel_iommu_sm;
-extern spinlock_t device_domain_lock;

  #define sm_supported(iommu)	(intel_iommu_sm && ecap_smts((iommu)->ecap))
  #define pasid_supported(iommu)	(sm_supported(iommu) &&			\
-- 
2.25.1

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
