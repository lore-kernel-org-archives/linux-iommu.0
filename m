Return-Path: <SRS0=A59K=AG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798F0C433DF
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 15:37:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 413DA207D8
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 15:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="lGOS3DQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413DA207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2A6882324E;
	Thu, 25 Jun 2020 15:37:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CK1jagnBYluS; Thu, 25 Jun 2020 15:37:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5DCAE2313B;
	Thu, 25 Jun 2020 15:37:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4392DC0863;
	Thu, 25 Jun 2020 15:37:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8F89C016F
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 15:37:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B4BBA85C1D
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 15:37:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vjWxJC-bofh7 for <iommu@lists.linux-foundation.org>;
 Thu, 25 Jun 2020 15:37:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com
 [209.85.219.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 383E485BE4
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 15:37:30 +0000 (UTC)
Received: by mail-qv1-f65.google.com with SMTP id u8so2946383qvj.12
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 08:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=M1cqSae7hNdYiqu+8k8gfItdpEDoX+sntlR/dwIK8h4=;
 b=lGOS3DQQ3dYsGxX5k6MlJyG0pAimjSFQZB1QmrFink0pbh6Xswfk9L8lV8cOs0RHKk
 +UF3pQffKHrTqtKWnZnlAllzISwdXv2nka21K3BDPku0gDkmfXEDYX+s6eDosHZUWSJt
 ME00OvnosHt+mNuFPMs0cFvYUbNreW0H1egdo4IIZBdBik0BIFGifcrlL2xj/zqh1wFU
 1SSPCZSd6jvIskLmbvQYlALJNRtQYU5K+w0rYR58iXyUJFB7+7cuQMiPpkmTo45IldMm
 btoVaoJSJXGAu5zOMmtUJoYm0uoDBHjqbOlLnHdhkDV2VPa2grdqOG/IbLeg+7ZVetHB
 XMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=M1cqSae7hNdYiqu+8k8gfItdpEDoX+sntlR/dwIK8h4=;
 b=PgSPELHtXMZtzC7sBO7OqSN92QLbpytJgp3Kz8H6IA5nlHdWp5FKqjQJTfnpd7+O6n
 Mw5+EkZ1CDjGTk70tbOwrYKh8hiC980VnzAEOdp0xVvlODlSvT4IMWJBYpeYtaYZ6Ggy
 rzLLLMmh8usf1br9VHICJ7aizaohb2RpydJNsryabPnruR2NCnki2RtnL84v/LW55Axy
 9fj/AObNdmoj97GPPOD6ecrQmv8Z6KhE55mMmYqlCoYLTJPOd5aiS9ZcJkPhKY60G7wd
 uhxkCxSTIAGY7/dUv+u6GzFhVeftEgsrrTOqGS6ppr7MhiKm6onz5SqTln6F7yZa3rLO
 4DBQ==
X-Gm-Message-State: AOAM5334DgeHs03H3tFupn1pA9E3jfr2SzU2MiHh6GommhzeizIcTlQ8
 OxQ/l5D/9N/sww4TGCEqy307Hw==
X-Google-Smtp-Source: ABdhPJwO/z3GqRdyLg4iaSC+qFfkcj7Jq1dkbV+B31fWZ2JKLNRWKszSnyC3Ab7uyP1yeR9AoP4b3A==
X-Received: by 2002:a0c:b5d8:: with SMTP id o24mr1205025qvf.214.1593099449041; 
 Thu, 25 Jun 2020 08:37:29 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net.
 [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id l127sm5920459qkc.117.2020.06.25.08.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 08:37:28 -0700 (PDT)
Date: Thu, 25 Jun 2020 11:37:20 -0400
From: Qian Cai <cai@lca.pw>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/2] iommu/amd: Use 'unsigned long' for domain->pt_root
Message-ID: <20200625153720.GA1127@lca.pw>
References: <20200625145227.4159-1-joro@8bytes.org>
 <20200625145227.4159-3-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200625145227.4159-3-joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
 linux-kernel@vger.kernel.org
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

On Thu, Jun 25, 2020 at 04:52:27PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Using atomic64_t can be quite expensive, so use unsigned long instead.
> This is safe because the write becomes visible atomically.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  2 +-
>  drivers/iommu/amd/iommu.c           | 10 ++++++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 30a5d412255a..f6f102282dda 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -468,7 +468,7 @@ struct protection_domain {
>  				       iommu core code */
>  	spinlock_t lock;	/* mostly used to lock the page table*/
>  	u16 id;			/* the domain id written to the device table */
> -	atomic64_t pt_root;	/* pgtable root and pgtable mode */
> +	unsigned long pt_root;	/* pgtable root and pgtable mode */
>  	int glx;		/* Number of levels for GCR3 table */
>  	u64 *gcr3_tbl;		/* Guest CR3 table */
>  	unsigned long flags;	/* flags to find out type of domain */
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 5286ddcfc2f9..b0e1dc58244e 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -156,7 +156,7 @@ static struct protection_domain *to_pdomain(struct iommu_domain *dom)
>  static void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
>  					 struct domain_pgtable *pgtable)
>  {
> -	u64 pt_root = atomic64_read(&domain->pt_root);
> +	unsigned long pt_root = domain->pt_root;

The pt_root might be reload later in case of register pressure where the
compiler decides to not store it as a stack variable, so it needs
smp_rmb() here to match to the smp_wmb() in
amd_iommu_domain_set_pt_root() to make the load visiable to all CPUs.

Then, smp_rmb/wmb() wouldn't be able to deal with data races, so it
needs,

unsigned long pt_root = READ_ONCE(domain->pt_root);

>  
>  	pgtable->root = (u64 *)(pt_root & PAGE_MASK);
>  	pgtable->mode = pt_root & 7; /* lowest 3 bits encode pgtable mode */
> @@ -164,7 +164,13 @@ static void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
>  
>  static void amd_iommu_domain_set_pt_root(struct protection_domain *domain, u64 root)
>  {
> -	atomic64_set(&domain->pt_root, root);
> +	domain->pt_root = root;

WRITE_ONCE(domain->pt_root, root);

> +
> +	/*
> +	 * The new value needs to be gobally visible in case pt_root gets
> +	 * cleared, so that the page-table can be safely freed.
> +	 */
> +	smp_wmb();
>  }
>  
>  static void amd_iommu_domain_clr_pt_root(struct protection_domain *domain)
> -- 
> 2.27.0
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
