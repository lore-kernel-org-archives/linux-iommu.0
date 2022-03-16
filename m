Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F477C4332F
	for <iommu@archiver.kernel.org>; Wed, 16 Mar 2022 12:49:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DFD96842B4;
	Wed, 16 Mar 2022 12:49:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5SnRrO9DE5kP; Wed, 16 Mar 2022 12:49:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B591A81DB2;
	Wed, 16 Mar 2022 12:49:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D6C3C0012;
	Wed, 16 Mar 2022 12:49:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7374C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 12:49:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 91D494018D
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 12:49:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RgFI9OPi_hKJ for <iommu@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 12:49:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4269340106
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 12:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647434980; x=1678970980;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=IIrsq5OUhyurUfvKKtDLorbLqzXKEGzZOMn7vCsCkiA=;
 b=QbU5MWAhyyu0adBQdnPatDWvOaQlgTUrJUykW7IVhNc6nhtmQYttFTVO
 2H4o3493FVHJPb4JWAotiTr/R6hZh5EdVxEgjoKfqJ7yMcgZigu1J0BO/
 VdM4jxpRENT6CSbEk8nwkHx+rhB0vyGgqYloM/SjqdW2c8vuntRl51sK8
 nA2OovAuc2Bz698GARByUVBBTo6K+liiS5ylJzsx6iBndJj0S70Y7HJ0e
 QaOck57eOpuUDf/bdLWElYQqNZXSuOTjEYIEsrb3sAutkmV7iym37WPzb
 YYxE19cSFITrfWayybOVzzmMmBmwcX3U/l55H1QhneXzZQHpTaMqFeMCO A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256526214"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; d="scan'208";a="256526214"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 05:49:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; d="scan'208";a="714584109"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 05:49:35 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 16 Mar 2022 14:45:11 +0200
Date: Wed, 16 Mar 2022 14:45:11 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] thunderbolt: Stop using iommu_present()
Message-ID: <YjHb1xCx4UAmUjrR@lahna>
References: <b4356b228db9cb88d12db6559e28714ce26e022e.1647429348.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b4356b228db9cb88d12db6559e28714ce26e022e.1647429348.git.robin.murphy@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: michael.jamet@intel.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, YehezkelShB@gmail.com,
 iommu@lists.linux-foundation.org, mario.limonciello@amd.com,
 andreas.noever@gmail.com, hch@lst.de
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

Hi Robin,

On Wed, Mar 16, 2022 at 11:25:51AM +0000, Robin Murphy wrote:
> Even if an IOMMU might be present for some PCI segment in the system,
> that doesn't necessarily mean it provides translation for the device
> we care about. Furthermore, the presence or not of one firmware flag
> doesn't imply anything about the IOMMU driver's behaviour, which may
> still depend on other firmware properties and kernel options too. What
> actually matters is whether an IOMMU is enforcing protection for our
> device - regardless of whether that stemmed from firmware policy, kernel
> config, or user control - at the point we need to decide whether to
> authorise it. We can ascertain that generically by simply looking at
> whether we're currently attached to a translation domain or not.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> I don't have the means to test this, but I'm at least 80% confident
> in my unpicking of the structures to retrieve the correct device...
> 
>  drivers/thunderbolt/domain.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
> index 7018d959f775..5f5fc5f6a09b 100644
> --- a/drivers/thunderbolt/domain.c
> +++ b/drivers/thunderbolt/domain.c
> @@ -257,13 +257,14 @@ static ssize_t iommu_dma_protection_show(struct device *dev,
>  					 struct device_attribute *attr,
>  					 char *buf)
>  {
> +	struct tb *tb = container_of(dev, struct tb, dev);
> +	struct iommu_domain *iod = iommu_get_domain_for_dev(&tb->nhi->pdev->dev);

I wonder if this is the correct "domain"? I mean it's typically no the
Thunderbolt controller (here tb->nhi->pdev->dev) that needs the
protection (although in discrete controllers it does get it too) but
it's the tunneled PCIe topology that we need to check here.

For instance in Intel with intergrated Thunderbolt we have topology like
this:

  Host bridge
      |
      +--- Tunneled PCIe root port #1
      +--- Tunneled PCIe root port #2
      +--- Thunderbolt host controller (the NHI above)
      +--- xHCI

and In case of discrete controllers it looks like this:

  Host bridge
      |
      +--- PCIe root port #x
                |
                |
           PCIe switch upstream port
                |
	        +--- Tunneled PCIe switch downstream port #1
	        +--- Tunneled PCIe switch downstream port #2
        	+--- Thunderbolt host controller (the NHI above)
        	+--- xHCI

What we want is to make sure the Tunneled PCIe ports get the full IOMMU
protection. In case of the discrete above it is also fine if all the
devices behind the PCIe root port get the full IOMMU protection. Note in
the integrated all the devices are "siblings".
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
