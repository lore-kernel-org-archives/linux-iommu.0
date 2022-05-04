Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6CAC433EF
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 11:14:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1C08140407;
	Wed,  4 May 2022 11:14:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4CS1biR8sFci; Wed,  4 May 2022 11:14:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E80F740004;
	Wed,  4 May 2022 11:14:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC966C0039;
	Wed,  4 May 2022 11:14:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4322BC002D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 11:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 198278340C
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 11:14:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kYxn_MwKOXB9 for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 11:14:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id B5FEC83F3D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 11:14:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A906C1042;
 Wed,  4 May 2022 04:14:16 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAA1B3FA50;
 Wed,  4 May 2022 04:14:12 -0700 (PDT)
Message-ID: <8d6c30e0-dcf7-56f8-c44b-2d8bdb1dc04c@arm.com>
Date: Wed, 4 May 2022 12:14:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [bug] NULL pointer deref after 3f6634d997db ("iommu: Use right
 way to retrieve iommu_ops")
Content-Language: en-GB
To: Jan Stancek <jstancek@redhat.com>, Lu Baolu <baolu.lu@linux.intel.com>
References: <20220216025249.3459465-1-baolu.lu@linux.intel.com>
 <20220216025249.3459465-8-baolu.lu@linux.intel.com>
 <20220504075356.GA2361844@janakin.usersys.redhat.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220504075356.GA2361844@janakin.usersys.redhat.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 bgoncalv@redhat.com, David Airlie <airlied@linux.ie>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Daniel Vetter <daniel@ffwll.ch>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

On 2022-05-04 08:53, Jan Stancek wrote:
[...]
> Hi,
> 
> I'm getting panics after hunk above was applied in this patch
> on ppc64le KVM guest, dev->iommu is NULL.

Oof, this can probably be hit with vfio-noiommu too, and by the look of
things, `echo auto > /sys/kernel/iommu_groups/0/type` would likely blow
up as well. Does the patch below work for you?

Thanks,
Robin.

----->8-----
 From abf0a38563bb2922a849e235d33d342170b5bc90 Mon Sep 17 00:00:00 2001
Message-Id: <abf0a38563bb2922a849e235d33d342170b5bc90.1651662442.git.robin.murphy@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Date: Wed, 4 May 2022 11:53:20 +0100
Subject: [PATCH] iommu: Make sysfs robust for non-API groups

Groups created by VFIO backends outside the core IOMMU API should never
be passed directly into the API itself, however they still expose their
standard sysfs attributes, so we can still stumble across them that way.
Take care to consider those cases before jumping into our normal
assumptions of a fully-initialised core API group.

Fixes: 3f6634d997db ("iommu: Use right way to retrieve iommu_ops")
Reported-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
  drivers/iommu/iommu.c | 9 ++++++++-
  1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 29906bc16371..41ea2deaee03 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -510,6 +510,13 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
  	list_for_each_entry(device, &group->devices, list) {
  		struct list_head dev_resv_regions;
  
+		/*
+		 * Non-API groups still expose reserved_regions in sysfs,
+		 * so filter out calls that get here that way.
+		 */
+		if (!device->dev->iommu)
+			break;
+
  		INIT_LIST_HEAD(&dev_resv_regions);
  		iommu_get_resv_regions(device->dev, &dev_resv_regions);
  		ret = iommu_insert_device_resv_regions(&dev_resv_regions, head);
@@ -2977,7 +2984,7 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
  	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
  		return -EACCES;
  
-	if (WARN_ON(!group))
+	if (WARN_ON(!group) || !group->default_domain)
  		return -EINVAL;
  
  	if (sysfs_streq(buf, "identity"))
-- 
2.35.3.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
