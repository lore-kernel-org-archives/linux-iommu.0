Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6264EC10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 08:18:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B3C520873
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 08:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3C520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A40192372;
	Thu, 11 Apr 2019 08:17:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 80F24216F
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 08:17:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 191B763D
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 08:17:41 +0000 (UTC)
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
	by kirsty.vergenet.net (Postfix) with ESMTPA id 6C63625AD6D;
	Thu, 11 Apr 2019 18:10:31 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
	id ED1A2940356; Thu, 11 Apr 2019 10:10:28 +0200 (CEST)
Date: Thu, 11 Apr 2019 10:10:28 +0200
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2 1/6] iommu/ipmmu-vmsa: Link IOMMUs and devices in sysfs
Message-ID: <20190411081028.b2wf3nnzx4tw7xdr@verge.net.au>
References: <20190403182148.18058-1-geert+renesas@glider.be>
	<20190403182148.18058-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190403182148.18058-2-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Magnus Damm <damm+renesas@opensource.se>,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	iommu@lists.linux-foundation.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190411081028.VbMCYhmSS_izkHLIe_PaiRPirEoGgDRudlHUl3Ksw3o@z>

On Wed, Apr 03, 2019 at 08:21:43PM +0200, Geert Uytterhoeven wrote:
> As of commit 7af9a5fdb9e0ca33 ("iommu/ipmmu-vmsa: Use
> iommu_device_sysfs_add()/remove()"), IOMMU devices show up under
> /sys/class/iommus/, but their "devices" subdirectories are empty.

Hi Geert,

Should the path be /sys/class/iommu/ (no trailing 's') ?

> Likewise, devices tied to an IOMMU do not have an "iommu" backlink.
> 
> Make sure all links are created, on both arm32 and arm64.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> v2:
>   - Add Reviewed-by.
> ---
>  drivers/iommu/ipmmu-vmsa.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 9a380c10655e182d..9f2b781e20a0eba6 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -885,27 +885,37 @@ static int ipmmu_init_arm_mapping(struct device *dev)
>  
>  static int ipmmu_add_device(struct device *dev)
>  {
> +	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
>  	struct iommu_group *group;
> +	int ret;
>  
>  	/*
>  	 * Only let through devices that have been verified in xlate()
>  	 */
> -	if (!to_ipmmu(dev))
> +	if (!mmu)
>  		return -ENODEV;
>  
> -	if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA))
> -		return ipmmu_init_arm_mapping(dev);
> +	if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)) {
> +		ret = ipmmu_init_arm_mapping(dev);
> +		if (ret)
> +			return ret;
> +	} else {
> +		group = iommu_group_get_for_dev(dev);
> +		if (IS_ERR(group))
> +			return PTR_ERR(group);
>  
> -	group = iommu_group_get_for_dev(dev);
> -	if (IS_ERR(group))
> -		return PTR_ERR(group);
> +		iommu_group_put(group);
> +	}
>  
> -	iommu_group_put(group);
> +	iommu_device_link(&mmu->iommu, dev);
>  	return 0;
>  }
>  
>  static void ipmmu_remove_device(struct device *dev)
>  {
> +	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
> +
> +	iommu_device_unlink(&mmu->iommu, dev);
>  	arm_iommu_detach_device(dev);
>  	iommu_group_remove_device(dev);
>  }
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
