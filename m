Return-Path: <SRS0=00Kx=7A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BAEC433E0
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 13:55:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EFE20674
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 13:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EFE20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5679684DD4;
	Mon, 18 May 2020 13:55:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 062kE6OS5lqX; Mon, 18 May 2020 13:55:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3738F84E88;
	Mon, 18 May 2020 13:55:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 129E5C0888;
	Mon, 18 May 2020 13:55:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A438C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 13:55:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 444858770A
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 13:55:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zPzLk46JAlvW for <iommu@lists.linux-foundation.org>;
 Mon, 18 May 2020 13:55:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A5A82876D7
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 13:55:05 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 10B08386; Mon, 18 May 2020 15:55:04 +0200 (CEST)
Date: Mon, 18 May 2020 15:55:02 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v2 23/33] iommu/mediatek-v1 Convert to
 probe/release_device() call-backs
Message-ID: <20200518135502.GE18353@8bytes.org>
References: <20200414131542.25608-1-joro@8bytes.org>
 <20200414131542.25608-24-joro@8bytes.org>
 <1589528699.26119.9.camel@mhfsdcap03>
 <20200515100718.GS18353@8bytes.org>
 <1589784680.15083.19.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1589784680.15083.19.camel@mhfsdcap03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Joerg Roedel <jroedel@suse.de>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>
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

Hi,

On Mon, May 18, 2020 at 02:51:20PM +0800, Yong Wu wrote:
> below is my local patch. split "dma_attach" to attach_device and
> probe_finalize. About attach_device, Use the existed
> __iommu_attach_group instead. Then rename from the "dma_attach" to
> "probe_finalize" to do the probe_finalize job. And move it outside of
> the mutex_unlock.
> 
> I'm not sure if it is right. and of course I will test if you have any
> other solution. Thanks.
> 
> 
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1665,26 +1665,20 @@ static void probe_alloc_default_domain(struct
> bus_type *bus,
>  
>  }
>  
> -static int iommu_group_do_dma_attach(struct device *dev, void *data)
> +static int iommu_group_do_probe_finalize(struct device *dev, void
> *data)
>  {
>  	struct iommu_domain *domain = data;
> -	const struct iommu_ops *ops;
> -	int ret;
> -
> -	ret = __iommu_attach_device(domain, dev);
> -
> -	ops = domain->ops;
> +	const struct iommu_ops *ops = domain->ops;
>  
> -	if (ret == 0 && ops->probe_finalize)
> +	if (ops->probe_finalize)
>  		ops->probe_finalize(dev);
> -
> -	return ret;
> +	return 0;
>  }
>  
> -static int __iommu_group_dma_attach(struct iommu_group *group)
> +static int iommu_group_probe_finalize(struct iommu_group *group)
>  {
>  	return __iommu_group_for_each_dev(group, group->default_domain,
> -					  iommu_group_do_dma_attach);
> +					  iommu_group_do_probe_finalize);
>  }
>  
>  static int iommu_do_create_direct_mappings(struct device *dev, void
> *data)
> @@ -1731,12 +1725,14 @@ int bus_iommu_probe(struct bus_type *bus)
>  
>  		iommu_group_create_direct_mappings(group);
>  
> -		ret = __iommu_group_dma_attach(group);
> +		ret = __iommu_attach_group(group->default_domain, group);
>  
>  		mutex_unlock(&group->mutex);
>  
>  		if (ret)
>  			break;
> +
> +		iommu_group_probe_finalize(group);
>  	}
>  
>  	return ret;
> -- 

Yes, I think moving the probe_finalize call out of the group->mutex
section is the right fix for this issue.

Thanks for reporting it and working on a fix.


Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
