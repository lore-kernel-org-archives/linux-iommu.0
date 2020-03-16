Return-Path: <SRS0=N4Nm=5B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEEAC0044D
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 21:44:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0200206C0
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 21:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7TUMxfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0200206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AB1A422056;
	Mon, 16 Mar 2020 21:44:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u+aNNylXhUcE; Mon, 16 Mar 2020 21:44:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0139220404;
	Mon, 16 Mar 2020 21:44:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D60E4C1D7C;
	Mon, 16 Mar 2020 21:44:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D341C013E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 21:44:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1913E86BC4
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 21:44:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hlm9wfLbaXGB for <iommu@lists.linux-foundation.org>;
 Mon, 16 Mar 2020 21:44:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A1EAF86BAE
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 21:44:51 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id mj6so8870452pjb.5
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 14:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=D3D+qRAc+7oS8J6Sb2B1Mz4hpBLBqFH8O13t3FcfVa4=;
 b=n7TUMxfS05q1sAGxhXfS9KBXthw4r/gV1wXyY3/HpwXnOs+Yf4tGf5oszH9qukZVML
 Woma4yNpxC5KWOU6oTIBDHv/5/ZOV5plbE8NVxCxOmEAK+nVWI0W/MmSWVPVSwDdtLha
 skblwS0q9kA8z6T7FDwQcwTZJI1UofMPLd8rpqDlQPEwCp5TdX+CJh3xxCQGkTKFDLX6
 lxXaJPjSxD8mLnFCjTOTifmCJ5qyABOPd/kHcOZDE077fAGrmFbdZD5eUu/aC8F8FGMq
 cLG3FOnrfaRSlMtmlqvG0zr4Wtew6oQhNzY8Xm3csG5EPY3Fn56nbQAhcKNGnt+WVg7g
 inrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=D3D+qRAc+7oS8J6Sb2B1Mz4hpBLBqFH8O13t3FcfVa4=;
 b=lt96OsNtExOD6rj3T3xZjC7KptBgxt5Zb7GQQeuDQa7y9A+91CmR1k4J1tGLT3Yg4n
 8UU22j2xrywShC1bqnTW2hO523Rkuqa4tz4TNiANTqxF8BBwfEWXvIxkE9TjtgovEo6C
 AmBn1qzYbtvW1c/lysRiq8uUyo6v7YQPQr2eQlCx/mAOA04TXbnVismd+TtGdshVHDP8
 1JK5HXpkRyS4Pi0sKJtWeur+H8fZ++RAr2wQu5EyDrH6qLkkJDUs/tJHAG3ERGF/W1UT
 B6adoGh6YPzt0+PTX1B5yHF+R8dBO81iMnVq1IBqj1L7ZDSrq3DGMOyVrQRNPNeFPN0/
 kFIQ==
X-Gm-Message-State: ANhLgQ1RWOVFmsFFKfSbiT0mnZwB9tDTg3IPpIxqyfhq0kODcMTQ9gOf
 C+MRonnNeKtkosGGXG7xlts=
X-Google-Smtp-Source: ADFU+vs60R8/j/ZW6FCkLMviIra7UhFL+U4BLcl8OYqLfjSUIx79EqZSX89WiGJDT2CyWWVnFVsKfg==
X-Received: by 2002:a17:902:b118:: with SMTP id
 q24mr1265410plr.0.1584395091130; 
 Mon, 16 Mar 2020 14:44:51 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id j1sm812274pfg.64.2020.03.16.14.44.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 16 Mar 2020 14:44:51 -0700 (PDT)
Date: Mon, 16 Mar 2020 14:45:06 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC][PATCH] dma-mapping: align default segment_boundary_mask
 with dma_mask
Message-ID: <20200316214506.GC18970@Asurada-Nvidia.nvidia.com>
References: <20200314000007.13778-1-nicoleotsuka@gmail.com>
 <20200316124850.GB17386@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200316124850.GB17386@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com,
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

Hi Christoph,

On Mon, Mar 16, 2020 at 01:48:50PM +0100, Christoph Hellwig wrote:
> On Fri, Mar 13, 2020 at 05:00:07PM -0700, Nicolin Chen wrote:
> > @@ -736,7 +736,7 @@ static inline unsigned long dma_get_seg_boundary(struct device *dev)
> >  {
> >  	if (dev->dma_parms && dev->dma_parms->segment_boundary_mask)
> >  		return dev->dma_parms->segment_boundary_mask;
> > -	return DMA_BIT_MASK(32);
> > +	return (unsigned long)dma_get_mask(dev);
> 
> Just thinking out loud after my reply - shouldn't we just return ULONG_MAX
> by default here to mark this as no limit?

Yea, ULONG_MAX (saying no limit) sounds good to me.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
