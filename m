Return-Path: <SRS0=6gDp=FO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDFBC433FE
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 09:14:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B48B2343B
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 09:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B48B2343B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AEED386457;
	Thu, 10 Dec 2020 09:14:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 52Mjxdp8QuDS; Thu, 10 Dec 2020 09:14:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 49B6681FA0;
	Thu, 10 Dec 2020 09:14:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24944C0FA7;
	Thu, 10 Dec 2020 09:14:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D822C013B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 09:14:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EBF128727D
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 09:14:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6YgpqfX5fS3b for <iommu@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 09:14:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9421E8727C
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 09:14:27 +0000 (UTC)
Date: Thu, 10 Dec 2020 09:14:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607591667;
 bh=yun00gcSza28jPxmidu8d/jRXVEqHTNFTP7yNX/2r1E=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=iUDsh3EdSqeE8frOwQNvA8yzZWx1ijVXVnE8NA92FhngxH8ErQPQ/HofhxNC73pqj
 C9gMVAnhk9a8PJa9uuIJ9DjcJg0PxGVdKzik+Z3S3VR9/KDnt8RE/ZMfR90Uz1/WHY
 MB6j9U6ETrhEI5pvlXvmrReFVz1GdAg9OwwYavQ/GB8lq4Bk5RV5Hv8AiJpslHHQL6
 DLtTzWChkk6Rx1k06ELpvnUd1ZpQxBrWMyd/ZdFXNnIMpfm5Rcv2E7GHmN+xi5mWhE
 JY6nF4iOpnIk79J2ht3V/YyLU2cuixbJpMfUUtrKn3/KAkbRjA7x/ai/RfLlNGNKsK
 IeVlxBDf3XrWQ==
From: Will Deacon <will@kernel.org>
To: tangzhenhao <tzh18@mails.tsinghua.edu.cn>
Subject: Re: [PATCH] drivers/iommu: fix a null-ptr-deref bug in
 fsl_pamu_domain.c
Message-ID: <20201210091422.GB9633@willie-the-truck>
References: <20201209123430.35310-1-tzh18@mails.tsinghua.edu.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201209123430.35310-1-tzh18@mails.tsinghua.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org
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

On Wed, Dec 09, 2020 at 04:34:30AM -0800, tangzhenhao wrote:
>     At line 362 in drivers/iommu/fsl_pamu_domain.c, the ret-val of kmem_cache_zalloc should be checked to avoid null-ptr-deref bug.
> 
> Signed-off-by: tangzhenhao <tzh18@mails.tsinghua.edu.cn>
> ---
>  drivers/iommu/fsl_pamu_domain.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
> index b2110767caf4..9ebd5135f4a8 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -360,6 +360,10 @@ static void attach_device(struct fsl_dma_domain *dma_domain, int liodn, struct d
>  	}
>  
>  	info = kmem_cache_zalloc(iommu_devinfo_cache, GFP_ATOMIC);
> +	if (!info) {
> +		pr_debug("device_domain_info allocation failed\n");
> +		return;
> +	}

All the comments I made on your other patch [1] apply to this one too.

Will

[1] https://lore.kernel.org/r/20201210091326.GA9633@willie-the-truck
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
