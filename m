Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808E4C433F5
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 18:53:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 451644102F;
	Wed, 18 May 2022 18:53:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NF7fecjkFNfD; Wed, 18 May 2022 18:53:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C198540374;
	Wed, 18 May 2022 18:53:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B386C0032;
	Wed, 18 May 2022 18:53:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCB56C002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:50:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC52241C46
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:50:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uCS3qLBpFedI for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 18:50:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 014A541C3D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:50:54 +0000 (UTC)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IIR1A3029892;
 Wed, 18 May 2022 18:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=4QiPjCdPg3Nttp5ZQex4Yr5bF6MPx3WK06C74Ss8uqI=;
 b=eE02WS8hPyFJ8sdgdq1qu2Za/Jk/ZQJs7FX41axlYGLaPITrb2HEbXMbJ+i5xfB6+i9M
 qlEDafs2eop5zDYAyazwBtnKbApv/OMfdoGpXZoKYpMfntFdUW33Qq7l+S9JWWVqnIVb
 aXk86L/YdMFEUG0tA1Cb2VrmLCWMaROuj62OTZX/vQPKTB3G3NBpIP6heh6JNcT9frPM
 4nlly6cLakAJaDw95UXXxsK+WfSPqekoxRO6qPQK+ybu146d/rctTrAxb5AEojc0e9i4
 7ejmjRSH7ehze9zXFFkm6LIgdC5Za1zaG7V2UYeHFPSqPdd5CY5HTmr20qw+9ZGF2gWC dw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g56398ha7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 May 2022 18:50:40 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24IIikpK004305;
 Wed, 18 May 2022 18:50:39 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g56398h9v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 May 2022 18:50:39 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24IIRfx8003493;
 Wed, 18 May 2022 18:50:39 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma02wdc.us.ibm.com with ESMTP id 3g2429xfhr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 May 2022 18:50:39 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 24IIocn814615010
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 May 2022 18:50:38 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34D457805C;
 Wed, 18 May 2022 18:50:38 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2575E78066;
 Wed, 18 May 2022 18:50:37 +0000 (GMT)
Received: from farman-thinkpad-t470p (unknown [9.211.132.11])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 18 May 2022 18:50:37 +0000 (GMT)
Message-ID: <183e155eae268c32e7d02f68846250702fe99065.camel@linux.ibm.com>
Subject: Re: [PATCH v3] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
From: Eric Farman <farman@linux.ibm.com>
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux-foundation.org,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Date: Wed, 18 May 2022 14:50:36 -0400
In-Reply-To: <0-v3-db7f0785022b+149-iommu_dma_block_jgg@nvidia.com>
References: <0-v3-db7f0785022b+149-iommu_dma_block_jgg@nvidia.com>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zPPeklel7XZLjjr4iQlUV3O3BHddiCc_
X-Proofpoint-ORIG-GUID: NyB_sJyUj_X-2c06Xi3xERwg9b4hQF5u
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_06,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205180108
X-Mailman-Approved-At: Wed, 18 May 2022 18:53:07 +0000
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <jroedel@suse.de>,
 Qian Cai <quic_qiancai@quicinc.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, 2022-05-09 at 13:19 -0300, Jason Gunthorpe via iommu wrote:
> Once the group enters 'owned' mode it can never be assigned back to
> the
> default_domain or to a NULL domain. It must always be actively
> assigned to
> a current domain. If the caller hasn't provided a domain then the
> core
> must provide an explicit DMA blocking domain that has no DMA map.
> 
> Lazily create a group-global blocking DMA domain when
> iommu_group_claim_dma_owner is first called and immediately assign
> the
> group to it. This ensures that DMA is immediately fully isolated on
> all
> IOMMU drivers.
> 
> If the user attaches/detaches while owned then detach will set the
> group
> back to the blocking domain.
> 
> Slightly reorganize the call chains so that
> __iommu_group_set_core_domain() is the function that removes any
> caller
> configured domain and sets the domains back a core owned domain with
> an
> appropriate lifetime.
> 
> __iommu_group_set_domain() is the worker function that can change the
> domain assigned to a group to any target domain, including NULL.
> 
> Add comments clarifying how the NULL vs detach_dev vs default_domain
> works
> based on Robin's remarks.
> 
> This fixes an oops with VFIO and SMMUv3 because VFIO will call
> iommu_detach_group() and then immediately iommu_domain_free(), but
> SMMUv3 has no way to know that the domain it is holding a pointer to
> has been freed. Now the iommu_detach_group() will assign the blocking
> domain and SMMUv3 will no longer hold a stale domain reference.
> 
> Fixes: 1ea2a07a532b ("iommu: Add DMA ownership management
> interfaces")
> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> Tested-by: Baolu Lu <baolu.lu@linux.intel.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Co-developed-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> --
> 
> Just minor polishing as discussed
> 
> v3:
>  - Change names to __iommu_group_set_domain() /
>    __iommu_group_set_core_domain()
>  - Clarify comments
>  - Call __iommu_group_set_domain() directly in
>    iommu_group_release_dma_owner() since we know it is always
> selecting
>    the default_domain
> v2: 
> https://lore.kernel.org/r/0-v2-f62259511ac0+6-iommu_dma_block_jgg@nvidia.com
>  - Remove redundant detach_dev ops check in __iommu_detach_device and
>    make the added WARN_ON fail instead
>  - Check for blocking_domain in __iommu_attach_group() so VFIO can
>    actually attach a new group
>  - Update comments and spelling
>  - Fix missed change to new_domain in iommu_group_do_detach_device()
> v1: 
> https://lore.kernel.org/r/0-v1-6e9d2d0a759d+11b-iommu_dma_block_jgg@nvidia.com
> 
> ---
>  drivers/iommu/iommu.c | 127 ++++++++++++++++++++++++++++++--------
> ----
>  1 file changed, 91 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0c42ece2585406..0b22e51e90f416 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -44,6 +44,7 @@ struct iommu_group {
>  	char *name;
>  	int id;
>  	struct iommu_domain *default_domain;
> +	struct iommu_domain *blocking_domain;
>  	struct iommu_domain *domain;
>  	struct list_head entry;
>  	unsigned int owner_cnt;
> @@ -82,8 +83,8 @@ static int __iommu_attach_device(struct
> iommu_domain *domain,
>  				 struct device *dev);
>  static int __iommu_attach_group(struct iommu_domain *domain,
>  				struct iommu_group *group);
> -static void __iommu_detach_group(struct iommu_domain *domain,
> -				 struct iommu_group *group);
> +static int __iommu_group_set_domain(struct iommu_group *group,
> +				    struct iommu_domain *new_domain);
>  static int iommu_create_device_direct_mappings(struct iommu_group
> *group,
>  					       struct device *dev);
>  static struct iommu_group *iommu_group_get_for_dev(struct device
> *dev);
> @@ -596,6 +597,8 @@ static void iommu_group_release(struct kobject
> *kobj)
>  
>  	if (group->default_domain)
>  		iommu_domain_free(group->default_domain);
> +	if (group->blocking_domain)
> +		iommu_domain_free(group->blocking_domain);
>  
>  	kfree(group->name);
>  	kfree(group);
> @@ -1907,6 +1910,24 @@ void iommu_domain_free(struct iommu_domain
> *domain)
>  }
>  EXPORT_SYMBOL_GPL(iommu_domain_free);
>  
> +/*
> + * Put the group's domain back to the appropriate core-owned domain
> - either the
> + * standard kernel-mode DMA configuration or an all-DMA-blocked
> domain.
> + */
> +static void __iommu_group_set_core_domain(struct iommu_group *group)
> +{
> +	struct iommu_domain *new_domain;
> +	int ret;
> +
> +	if (group->owner)
> +		new_domain = group->blocking_domain;
> +	else
> +		new_domain = group->default_domain;
> +
> +	ret = __iommu_group_set_domain(group, new_domain);
> +	WARN(ret, "iommu driver failed to attach the default/blocking
> domain");
> +}
> +
>  static int __iommu_attach_device(struct iommu_domain *domain,
>  				 struct device *dev)
>  {
> @@ -1963,9 +1984,6 @@ static void __iommu_detach_device(struct
> iommu_domain *domain,
>  	if (iommu_is_attach_deferred(dev))
>  		return;
>  
> -	if (unlikely(domain->ops->detach_dev == NULL))
> -		return;
> -
>  	domain->ops->detach_dev(domain, dev);
>  	trace_detach_device_from_domain(dev);
>  }
> @@ -1979,12 +1997,10 @@ void iommu_detach_device(struct iommu_domain
> *domain, struct device *dev)
>  		return;
>  
>  	mutex_lock(&group->mutex);
> -	if (iommu_group_device_count(group) != 1) {
> -		WARN_ON(1);
> +	if (WARN_ON(domain != group->domain) ||
> +	    WARN_ON(iommu_group_device_count(group) != 1))
>  		goto out_unlock;
> -	}
> -
> -	__iommu_detach_group(domain, group);
> +	__iommu_group_set_core_domain(group);
>  
>  out_unlock:
>  	mutex_unlock(&group->mutex);
> @@ -2040,7 +2056,8 @@ static int __iommu_attach_group(struct
> iommu_domain *domain,
>  {
>  	int ret;
>  
> -	if (group->domain && group->domain != group->default_domain)
> +	if (group->domain && group->domain != group->default_domain &&
> +	    group->domain != group->blocking_domain)
>  		return -EBUSY;
>  
>  	ret = __iommu_group_for_each_dev(group, domain,
> @@ -2072,38 +2089,49 @@ static int
> iommu_group_do_detach_device(struct device *dev, void *data)
>  	return 0;
>  }
>  
> -static void __iommu_detach_group(struct iommu_domain *domain,
> -				 struct iommu_group *group)
> +static int __iommu_group_set_domain(struct iommu_group *group,
> +				    struct iommu_domain *new_domain)
>  {
>  	int ret;
>  
> +	if (group->domain == new_domain)
> +		return 0;
> +
>  	/*
> -	 * If the group has been claimed already, do not re-attach the
> default
> -	 * domain.
> +	 * New drivers should support default domains and so the
> detach_dev() op
> +	 * will never be called. Otherwise the NULL domain represents
> some
> +	 * platform specific behavior.
>  	 */
> -	if (!group->default_domain || group->owner) {
> -		__iommu_group_for_each_dev(group, domain,
> +	if (!new_domain) {
> +		if (WARN_ON(!group->domain->ops->detach_dev))
> +			return -EINVAL;
> +		__iommu_group_for_each_dev(group, group->domain,
>  					   iommu_group_do_detach_device
> );
>  		group->domain = NULL;
> -		return;
> +		return 0;
>  	}
>  
> -	if (group->domain == group->default_domain)
> -		return;
> -
> -	/* Detach by re-attaching to the default domain */
> -	ret = __iommu_group_for_each_dev(group, group->default_domain,
> +	/*
> +	 * Changing the domain is done by calling attach_dev() on the
> new
> +	 * domain. This switch does not have to be atomic and DMA can
> be
> +	 * discarded during the transition. DMA must only be able to
> access
> +	 * either new_domain or group->domain, never something else.
> +	 *
> +	 * Note that this is called in error unwind paths, attaching to
> a
> +	 * domain that has already been attached cannot fail.
> +	 */
> +	ret = __iommu_group_for_each_dev(group, new_domain,
>  					 iommu_group_do_attach_device);
> -	if (ret != 0)
> -		WARN_ON(1);
> -	else
> -		group->domain = group->default_domain;
> +	if (ret)
> +		return ret;
> +	group->domain = new_domain;
> +	return 0;
>  }
>  
>  void iommu_detach_group(struct iommu_domain *domain, struct
> iommu_group *group)
>  {
>  	mutex_lock(&group->mutex);
> -	__iommu_detach_group(domain, group);
> +	__iommu_group_set_core_domain(group);
>  	mutex_unlock(&group->mutex);
>  }
>  EXPORT_SYMBOL_GPL(iommu_detach_group);
> @@ -3088,6 +3116,29 @@ void iommu_device_unuse_default_domain(struct
> device *dev)
>  	iommu_group_put(group);
>  }
>  
> +static int __iommu_group_alloc_blocking_domain(struct iommu_group
> *group)
> +{
> +	struct group_device *dev =
> +		list_first_entry(&group->devices, struct group_device,
> list);
> +
> +	if (group->blocking_domain)
> +		return 0;
> +
> +	group->blocking_domain =
> +		__iommu_domain_alloc(dev->dev->bus,
> IOMMU_DOMAIN_BLOCKED);
> +	if (!group->blocking_domain) {
> +		/*
> +		 * For drivers that do not yet understand
> IOMMU_DOMAIN_BLOCKED
> +		 * create an empty domain instead.
> +		 */
> +		group->blocking_domain = __iommu_domain_alloc(
> +			dev->dev->bus, IOMMU_DOMAIN_UNMANAGED);
> +		if (!group->blocking_domain)
> +			return -EINVAL;

Hi Jason,

I got a heads up from Matt about the s390 KVM vfio- variants failing on
linux-next.

For vfio-ap and vfio-ccw, they fail on the above error. Both calls to
__iommu_domain_alloc fail because while dev->dev->bus is non-NULL (it
points to the mdev bus_type registered in mdev_init()), the bus-
>iommu_ops pointer is NULL. Which makes sense; the iommu_group is vfio-
noiommu, via vfio_register_emulated_iommu_dev(), and mdev didn't
establish an iommu_ops for its bus.

The caller of this, iommu_group_claim_dma_owner(), was added to
vfio_group_set_container() by commit 70693f470848 ("vfio: Set DMA
ownership for VFIO devices") [1] ... But that's as far as I got without
making some probably incorrect decisions. Do you have any thoughts
here?

Thanks,
Eric

[1] 
https://lore.kernel.org/r/20220418005000.897664-8-baolu.lu@linux.intel.com

> +	}
> +	return 0;
> +}
> +
>  /**
>   * iommu_group_claim_dma_owner() - Set DMA ownership of a group
>   * @group: The group.
> @@ -3111,9 +3162,14 @@ int iommu_group_claim_dma_owner(struct
> iommu_group *group, void *owner)
>  			goto unlock_out;
>  		}
>  
> +		ret = __iommu_group_alloc_blocking_domain(group);
> +		if (ret)
> +			goto unlock_out;
> +
> +		ret = __iommu_group_set_domain(group, group-
> >blocking_domain);
> +		if (ret)
> +			goto unlock_out;
>  		group->owner = owner;
> -		if (group->domain)
> -			__iommu_detach_group(group->domain, group);
>  	}
>  
>  	group->owner_cnt++;
> @@ -3132,18 +3188,17 @@
> EXPORT_SYMBOL_GPL(iommu_group_claim_dma_owner);
>   */
>  void iommu_group_release_dma_owner(struct iommu_group *group)
>  {
> +	int ret;
> +
>  	mutex_lock(&group->mutex);
>  	if (WARN_ON(!group->owner_cnt || !group->owner))
>  		goto unlock_out;
>  
>  	group->owner_cnt = 0;
> -	/*
> -	 * The UNMANAGED domain should be detached before all USER
> -	 * owners have been released.
> -	 */
> -	if (!WARN_ON(group->domain) && group->default_domain)
> -		__iommu_attach_group(group->default_domain, group);
>  	group->owner = NULL;
> +	ret = __iommu_group_set_domain(group, group->default_domain);
> +	WARN(ret, "iommu driver failed to attach the default domain");
> +
>  unlock_out:
>  	mutex_unlock(&group->mutex);
>  }
> 
> base-commit: da844db4722bdd333142b40f0e414e2aedc2a4c0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
