Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB34BC433E1
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 00:42:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABB0420663
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 00:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB0420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 70AF989403;
	Tue,  7 Jul 2020 00:42:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lnApB7LCYGj2; Tue,  7 Jul 2020 00:42:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1FCC389407;
	Tue,  7 Jul 2020 00:42:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08E96C0891;
	Tue,  7 Jul 2020 00:42:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71ADEC016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 00:42:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5E1F12010C
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 00:42:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PpHc5uWwYknP for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 00:42:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by silver.osuosl.org (Postfix) with ESMTPS id 6F8B020336
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 00:42:34 +0000 (UTC)
IronPort-SDR: 7u0p27nYeY3gAU2/A5oBGmBQy1Fa+oHnLku7oTiLUelqHgrdrUon1EJrdkzyE27egrCm652WMO
 2h6dnLS0G1hw==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="127115209"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; d="scan'208";a="127115209"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 17:42:33 -0700
IronPort-SDR: u4JunD8GPdQ6hA34qVhYuO63vCPCxTcen2WvjRSBrrm5DJ4/junCz4v1flKrG9dikpy48GBL+R
 8CqVuteqoZnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; d="scan'208";a="279439564"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga003.jf.intel.com with ESMTP; 06 Jul 2020 17:42:31 -0700
Date: Tue, 7 Jul 2020 08:31:41 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Hillf Danton <hdanton@sina.com>
Subject: Re: [RFC PATCH] vfio: type1: fix kthread use case
Message-ID: <20200707003140.GA20022@joy-OptiPlex-7040>
References: <20200706104915.11460-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200706104915.11460-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Alex Williamson <alex.williamson@redhat.com>,
 Markus Elfring <Markus.Elfring@web.de>, Christoph Hellwig <hch@lst.de>
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Jul 06, 2020 at 06:49:15PM +0800, Hillf Danton wrote:
> 
> It's incorrect to tell out if a task is kthread without checking
> PF_KTHREAD at all.
> 
> What's also fixed, if no need to be in a seperate patch, is to
> invoke kthread_use_mm() without checking the current mm first as
> the kthread may hold a mm struct atm and it's not the right place
> to switch mm.
> 
> Fixes: 8d46c0cca5f4 ("vfio: introduce vfio_dma_rw to read/write a range of IOVAs")
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Markus Elfring <Markus.Elfring@web.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> ---
> 
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2798,7 +2798,8 @@ static int vfio_iommu_type1_dma_rw_chunk
>  	struct mm_struct *mm;
>  	unsigned long vaddr;
>  	struct vfio_dma *dma;
> -	bool kthread = current->mm == NULL;
> +	bool kthread = current->flags & PF_KTHREAD;
> +	bool use_mm = current->mm == NULL;
is it acceptable to just rename "kthread" to "kthread_no_use_mm"?

I think "current->mm == NULL" in itself implies kthread and not use_mm,
as a user thread is not able to have "current->mm == NULL", right?


Thanks
Yan

>  	size_t offset;
>  
>  	*copied = 0;
> @@ -2812,11 +2813,10 @@ static int vfio_iommu_type1_dma_rw_chunk
>  		return -EPERM;
>  
>  	mm = get_task_mm(dma->task);
> -
>  	if (!mm)
>  		return -EPERM;
>  
> -	if (kthread)
> +	if (kthread && use_mm)
>  		kthread_use_mm(mm);
>  	else if (current->mm != mm)
>  		goto out;
> @@ -2843,7 +2843,7 @@ static int vfio_iommu_type1_dma_rw_chunk
>  	} else
>  		*copied = copy_from_user(data, (void __user *)vaddr,
>  					   count) ? 0 : count;
> -	if (kthread)
> +	if (kthread && use_mm)
>  		kthread_unuse_mm(mm);
>  out:
>  	mmput(mm);
> --
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
