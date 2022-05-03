Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3725C433F5
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 17:22:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7B231403F7;
	Tue,  3 May 2022 17:22:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qb1IFQPlXhl0; Tue,  3 May 2022 17:22:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 333B4405D8;
	Tue,  3 May 2022 17:22:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05CDCC0039;
	Tue,  3 May 2022 17:22:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBDA2C002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 17:22:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D1A62403F7
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 17:22:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NCgf0LWpjLyp for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 17:22:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id C7D1D400BF
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 17:22:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B76212FC;
 Tue,  3 May 2022 10:22:54 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 546413F5A1;
 Tue,  3 May 2022 10:22:52 -0700 (PDT)
Message-ID: <18831161-473f-e04f-4a81-1c7062ad192d@arm.com>
Date: Tue, 3 May 2022 18:22:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RESEND PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
 <20220502161204.GA22@qian> <20220502164216.GP8364@nvidia.com>
 <8b3d31ef-caf7-da92-fa95-0df378d5b091@arm.com>
 <20220503152336.GA3939@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220503152336.GA3939@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Qian Cai <quic_qiancai@quicinc.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
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

On 2022-05-03 16:23, Jason Gunthorpe wrote:
> On Tue, May 03, 2022 at 02:04:37PM +0100, Robin Murphy wrote:
> 
>>> I'm guessing SMMU3 needs to call it's arm_smmu_detach_dev(master) from
>>> the detach_dev op and null it's cached copy of the domain, but I don't
>>> know this driver.. Robin?
>>
>> The original intent was that .detach_dev is deprecated in favour of default
>> domains, and when the latter are in use, a device is always attached
>> *somewhere* once probed (i.e. group->domain is never NULL). At face value,
>> the neatest fix IMO would probably be for SMMUv3's .domain_free to handle
>> smmu_domain->devices being non-empty and detach them at that point. However
>> that wouldn't be viable for virtio-iommu or anyone else keeping an internal
>> one-way association of devices to their current domains.
> 
> Oh wow that is not obvious
> 
> Actually, I think it is much worse than this because
> iommu_group_claim_dma_owner() does a __iommu_detach_group() with the
> expecation that this would actually result in DMA being blocked,
> immediately. The idea that __iomuu_detatch_group() is a NOP is kind of
> scary.

Scarier than the fact that even where it *is* implemented, .detach_dev
has never had a well-defined behaviour either, and plenty of drivers
treat it as a "remove the IOMMU from the picture altogether" operation
which ends up with the device in bypass rather than blocked?

> Leaving the group attached to the kernel DMA domain will allow
> userspace to DMA to all kernel memory :\

Note that a fair amount of IOMMU hardware only has two states, thus
could only actually achieve a blocking behaviour by enabling translation
with an empty pagetable anyway. (Trivia: and technically some of them
aren't even capable of blocking invalid accesses *when* translating -
they can only apply a "default" translation targeting some scratch page)

> So one approach could be to block use of iommu_group_claim_dma_owner()
> if no detatch_dev op is present and then go through and put them back
> or do something else. This could be short-term OK if we add an op to
> SMMUv3, but long term everything would have to be fixed
> 
> Or we can allocate a dummy empty/blocked domain during
> iommu_group_claim_dma_owner() and attach it whenever.

How does the compile-tested diff below seem? There's a fair chance it's
still broken, but I don't have the bandwidth to give it much more
thought right now.

Cheers,
Robin.

----->8-----
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 29906bc16371..597d70ed7007 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -45,6 +45,7 @@ struct iommu_group {
  	int id;
  	struct iommu_domain *default_domain;
  	struct iommu_domain *domain;
+	struct iommu_domain *purgatory;
  	struct list_head entry;
  	unsigned int owner_cnt;
  	void *owner;
@@ -596,6 +597,8 @@ static void iommu_group_release(struct kobject *kobj)
  
  	if (group->default_domain)
  		iommu_domain_free(group->default_domain);
+	if (group->purgatory)
+		iommu_domain_free(group->purgatory);
  
  	kfree(group->name);
  	kfree(group);
@@ -2041,6 +2044,12 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
  	return dev->iommu_group->default_domain;
  }
  
+static bool iommu_group_user_attached(struct iommu_group *group)
+{
+	return group->domain && group->domain != group->default_domain &&
+	       group->domain != group->purgatory;
+}
+
  /*
   * IOMMU groups are really the natural working unit of the IOMMU, but
   * the IOMMU API works on domains and devices.  Bridge that gap by
@@ -2063,7 +2072,7 @@ static int __iommu_attach_group(struct iommu_domain *domain,
  {
  	int ret;
  
-	if (group->domain && group->domain != group->default_domain)
+	if (iommu_group_user_attached(group))
  		return -EBUSY;
  
  	ret = __iommu_group_for_each_dev(group, domain,
@@ -2104,7 +2113,12 @@ static void __iommu_detach_group(struct iommu_domain *domain,
  	 * If the group has been claimed already, do not re-attach the default
  	 * domain.
  	 */
-	if (!group->default_domain || group->owner) {
+	if (group->owner) {
+		WARN_ON(__iommu_attach_group(group->purgatory, group));
+		return;
+	}
+
+	if (!group->default_domain) {
  		__iommu_group_for_each_dev(group, domain,
  					   iommu_group_do_detach_device);
  		group->domain = NULL;
@@ -3111,6 +3125,25 @@ void iommu_device_unuse_default_domain(struct device *dev)
  	iommu_group_put(group);
  }
  
+static struct iommu_domain *iommu_group_get_purgatory(struct iommu_group *group)
+{
+	struct group_device *dev;
+
+	mutex_lock(&group->mutex);
+	if (group->purgatory)
+		goto out;
+
+	dev = list_first_entry(&group->devices, struct group_device, list);
+	group->purgatory = __iommu_domain_alloc(dev->dev->bus,
+						IOMMU_DOMAIN_BLOCKED);
+	if (!group->purgatory)
+		group->purgatory = __iommu_domain_alloc(dev->dev->bus,
+							IOMMU_DOMAIN_UNMANAGED);
+out:
+	mutex_unlock(&group->mutex);
+	return group->purgatory;
+}
+
  /**
   * iommu_group_claim_dma_owner() - Set DMA ownership of a group
   * @group: The group.
@@ -3122,6 +3155,7 @@ void iommu_device_unuse_default_domain(struct device *dev)
   */
  int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner)
  {
+	struct iommu_domain *pd;
  	int ret = 0;
  
  	mutex_lock(&group->mutex);
@@ -3133,10 +3167,13 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner)
  			ret = -EBUSY;
  			goto unlock_out;
  		}
+		pd = iommu_group_get_purgatory(group);
+		if (!pd)
+			return -ENOMEM;
  
  		group->owner = owner;
-		if (group->domain)
-			__iommu_detach_group(group->domain, group);
+		if (group->domain && group->domain != pd)
+			__iommu_attach_group(pd, group);
  	}
  
  	group->owner_cnt++;
@@ -3164,7 +3201,7 @@ void iommu_group_release_dma_owner(struct iommu_group *group)
  	 * The UNMANAGED domain should be detached before all USER
  	 * owners have been released.
  	 */
-	if (!WARN_ON(group->domain) && group->default_domain)
+	if (!WARN_ON(iommu_group_user_attached(group) && group->default_domain))
  		__iommu_attach_group(group->default_domain, group);
  	group->owner = NULL;
  unlock_out:
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
