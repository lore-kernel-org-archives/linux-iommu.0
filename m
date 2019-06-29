Return-Path: <SRS0=Olzo=U4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959D0C5B57A
	for <iommu@archiver.kernel.org>; Sat, 29 Jun 2019 15:09:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C936215EA
	for <iommu@archiver.kernel.org>; Sat, 29 Jun 2019 15:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G57SADTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C936215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3943FBE7;
	Sat, 29 Jun 2019 15:09:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 03893BA4
	for <iommu@lists.linux-foundation.org>;
	Sat, 29 Jun 2019 15:09:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
	[209.85.215.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 949063D0
	for <iommu@lists.linux-foundation.org>;
	Sat, 29 Jun 2019 15:09:17 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id f25so3909686pgv.10
	for <iommu@lists.linux-foundation.org>;
	Sat, 29 Jun 2019 08:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=4PDRDSdPlik/3Dz2WUeVgJcUfwA9IGRhonB1MM/wefg=;
	b=G57SADTMggL8n0pIpOEwPt5rucFLcFzaP0n3oeowJewkuuCijNkliMNKU+dGOlJ2fq
	EgAKCtiA3mOadRCmiaX8mEmLoId9NM33CuXBJlIVjavZ/WnnrRH6vZHvEDKKT/5R/aNr
	Y5VefnWEapcSksrsGqA6l2yPB2FUYnOh6Vi+ec1DRkT7wk27vt4ez6cL1TsEWp+WmJJD
	9czSVDIssaRJU7VtpsTT4SisHJVQZCK2gJ5Zlmlmi/1yGLJ9FoIo0IwwGlCR0OXlLBsy
	u8gp3kAJF4pXyVF54QHX3ujHIFjdgstGjSggr8TMM7tCgzpMymyRIkW7A3k/oUiZp/ow
	4BnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=4PDRDSdPlik/3Dz2WUeVgJcUfwA9IGRhonB1MM/wefg=;
	b=N7kz9W5cEcyjacCqyBxRNevcbLUI7W3CEhLDrwCz1Bcw8jmg7aY96BKhYl5V2rAqhW
	nhZq2zdexcm1+dGBU77f53ierSO69Kz5kk7gsK8Al0UfDipMdXXeh/11uhJNwPwUATFx
	AGA5hm6HI9J/sAZHCMPCDKtFI/sgaRAeAf7yg2YYBCHD5KpGe8rewtq1Fg+Yuwiz5lc0
	PhQnpIk/ewDKBFN4pihX+DsA2CsU5XpnwR+/SM8zmZg98udIv4pp2YjfkRok71dbCah5
	bA+iHo0BzOWNVFqfSOnqGRs5RyAkf7JCixueHTfO30ZgRIM/rHr0O8Krc4wKX2WurUaJ
	pn1w==
X-Gm-Message-State: APjAAAWXP5vw/mcmz7yNAcuW8U8ZQcvzb40Ds+TTzVkPLRSB/uiRpY+5
	RbgTwzplno0CTcOITWM9zEw=
X-Google-Smtp-Source: APXvYqyDBBSk+rR6gLpGBEL0OVOHp9fl5zjs/iRj+V1a6MYIR50eUUkJF3Dx9enR+JvisdUNTLheWg==
X-Received: by 2002:a17:90a:634a:: with SMTP id
	v10mr20203751pjs.16.1561820957173; 
	Sat, 29 Jun 2019 08:09:17 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
	by smtp.gmail.com with ESMTPSA id
	b3sm10519235pfp.65.2019.06.29.08.09.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 29 Jun 2019 08:09:16 -0700 (PDT)
Date: Sat, 29 Jun 2019 08:09:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/7] dma-direct: handle DMA_ATTR_NO_KERNEL_MAPPING in
	common code
Message-ID: <20190629150915.GA817@roeck-us.net>
References: <20190614144431.21760-1-hch@lst.de>
	<20190614144431.21760-7-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190614144431.21760-7-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Jonas Bonn <jonas@southpole.se>, linux-xtensa@linux-xtensa.org,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
	Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	iommu@lists.linux-foundation.org, openrisc@lists.librecores.org,
	Stafford Horne <shorne@gmail.com>, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
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

On Fri, Jun 14, 2019 at 04:44:30PM +0200, Christoph Hellwig wrote:
> DMA_ATTR_NO_KERNEL_MAPPING is generally implemented by allocating
> normal cacheable pages or CMA memory, and then returning the page
> pointer as the opaque handle.  Lift that code from the xtensa and
> generic dma remapping implementations into the generic dma-direct
> code so that we don't even call arch_dma_alloc for these allocations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This patch results in build failures for mips:nlm_xlp_defconfig and
mips:cavium_octeon_defconfig.

kernel/dma/direct.c:144: undefined reference to `arch_dma_prep_coherent'

Reverting the patch fixes the problem.

Guenter
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
