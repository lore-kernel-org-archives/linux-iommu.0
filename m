Return-Path: <SRS0=VhCt=WE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62400C433FF
	for <iommu@archiver.kernel.org>; Thu,  8 Aug 2019 20:10:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E12D216C8
	for <iommu@archiver.kernel.org>; Thu,  8 Aug 2019 20:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E12D216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0EE35CC1;
	Thu,  8 Aug 2019 20:10:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 053F3CB2
	for <iommu@lists.linux-foundation.org>;
	Thu,  8 Aug 2019 20:10:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9D442829
	for <iommu@lists.linux-foundation.org>;
	Thu,  8 Aug 2019 20:10:32 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11A5B3024562;
	Thu,  8 Aug 2019 20:10:32 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 23990600C8;
	Thu,  8 Aug 2019 20:10:31 +0000 (UTC)
Date: Thu, 8 Aug 2019 14:10:30 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/2] iommu/vt-d: Detach domain before using a private one
Message-ID: <20190808141030.323b4a0a@x1.home>
In-Reply-To: <20190806001409.3293-1-baolu.lu@linux.intel.com>
References: <20190806001409.3293-1-baolu.lu@linux.intel.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Thu, 08 Aug 2019 20:10:32 +0000 (UTC)
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
	David Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue,  6 Aug 2019 08:14:08 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> When the default domain of a group doesn't work for a device,
> the iommu driver will try to use a private domain. The domain
> which was previously attached to the device must be detached.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Fixes: 942067f1b6b97 ("iommu/vt-d: Identify default domains replaced with private")
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Link: https://lkml.org/lkml/2019/8/2/1379
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---

Tested-by: Alex Williamson <alex.williamson@redhat.com>

This series resolves the issue I reported against:
 iommu/vt-d: Cleanup get_valid_domain_for_dev()

Thanks,
Alex

>  drivers/iommu/intel-iommu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 3e22fa6ae8c8..37259b7f95a7 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3449,6 +3449,7 @@ static bool iommu_need_mapping(struct device *dev)
>  				dmar_domain = to_dmar_domain(domain);
>  				dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
>  			}
> +			dmar_remove_one_dev_info(dev);
>  			get_private_domain_for_dev(dev);
>  		}
>  
> @@ -4803,7 +4804,8 @@ static void dmar_remove_one_dev_info(struct device *dev)
>  
>  	spin_lock_irqsave(&device_domain_lock, flags);
>  	info = dev->archdata.iommu;
> -	__dmar_remove_one_dev_info(info);
> +	if (info)
> +		__dmar_remove_one_dev_info(info);
>  	spin_unlock_irqrestore(&device_domain_lock, flags);
>  }
>  
> @@ -5281,6 +5283,7 @@ static int intel_iommu_add_device(struct device *dev)
>  		if (device_def_domain_type(dev) == IOMMU_DOMAIN_IDENTITY) {
>  			ret = iommu_request_dm_for_dev(dev);
>  			if (ret) {
> +				dmar_remove_one_dev_info(dev);
>  				dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
>  				domain_add_dev_info(si_domain, dev);
>  				dev_info(dev,
> @@ -5291,6 +5294,7 @@ static int intel_iommu_add_device(struct device *dev)
>  		if (device_def_domain_type(dev) == IOMMU_DOMAIN_DMA) {
>  			ret = iommu_request_dma_domain_for_dev(dev);
>  			if (ret) {
> +				dmar_remove_one_dev_info(dev);
>  				dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
>  				if (!get_private_domain_for_dev(dev)) {
>  					dev_warn(dev,

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
