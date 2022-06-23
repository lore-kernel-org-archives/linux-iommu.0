Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4CDC433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 08:22:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B36E761360;
	Thu, 23 Jun 2022 08:22:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B36E761360
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ERdetjNJJta0; Thu, 23 Jun 2022 08:22:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6171160E66;
	Thu, 23 Jun 2022 08:22:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6171160E66
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B8D0C0032;
	Thu, 23 Jun 2022 08:22:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D214C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:22:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 681F541A4C
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:22:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 681F541A4C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DWRPyr34csyq for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 08:22:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6C52A41A3C
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6C52A41A3C
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:22:42 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 40B0B447; Thu, 23 Jun 2022 10:22:40 +0200 (CEST)
Date: Thu, 23 Jun 2022 10:22:38 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v3 1/7] iommu/amd: Warn when found inconsistency EFR mask
Message-ID: <YrQizrI5lR3ki37B@8bytes.org>
References: <20220622171131.11870-1-suravee.suthikulpanit@amd.com>
 <20220622171131.11870-2-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220622171131.11870-2-suravee.suthikulpanit@amd.com>
Cc: thomas.lendacky@amd.com, ashish.kalra@amd.com, linux-kernel@vger.kernel.org,
 vasant.hegde@amd.com, iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

On Wed, Jun 22, 2022 at 12:11:25PM -0500, Suravee Suthikulpanit wrote:
>  #ifdef CONFIG_IRQ_REMAP
> +/*
> + * Iterate through all the IOMMUs to verify if the specified
> + * EFR bitmask of IOMMU feature are set.
> + * Warn and return false if found inconsistency.
> + */
>  static bool check_feature_on_all_iommus(u64 mask)
>  {
>  	bool ret = false;
>  	struct amd_iommu *iommu;
>  
>  	for_each_iommu(iommu) {
> -		ret = iommu_feature(iommu, mask);
> -		if (!ret)
> +		bool tmp = iommu_feature(iommu, mask);
> +
> +		if ((ret != tmp) &&
> +		    !list_is_first(&iommu->list, &amd_iommu_list)) {
> +			pr_err(FW_BUG "Found inconsistent EFR mask (%#llx) on iommu%d (%04x:%02x:%02x.%01x).\n",
> +			       mask, iommu->index, iommu->pci_seg->id, PCI_BUS_NUM(iommu->devid),
> +			       PCI_SLOT(iommu->devid), PCI_FUNC(iommu->devid));
>  			return false;
> +		}
> +		ret = tmp;

It is better to implement this by introducing a global feature mask,
which represents the minial set of features supported by any IOMMU in
the system.

The warning is then something like:

	if ((global_feature_mask & iommu_features) != global_feature_mask)
		pr_warn(...);

This also makes the global variable to track SNP support obsolete.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
