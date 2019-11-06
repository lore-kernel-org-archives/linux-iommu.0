Return-Path: <SRS0=/wjm=Y6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F39FC6195
	for <iommu@archiver.kernel.org>; Wed,  6 Nov 2019 23:58:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D68A5217F4
	for <iommu@archiver.kernel.org>; Wed,  6 Nov 2019 23:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="1J4qFusA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68A5217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ragnatech.se
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C50ACCC8;
	Wed,  6 Nov 2019 23:58:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3FE83CA8
	for <iommu@lists.linux-foundation.org>;
	Wed,  6 Nov 2019 23:58:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
	[209.85.167.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6D533E6
	for <iommu@lists.linux-foundation.org>;
	Wed,  6 Nov 2019 23:58:46 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id y6so101977lfj.2
	for <iommu@lists.linux-foundation.org>;
	Wed, 06 Nov 2019 15:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:content-transfer-encoding:in-reply-to
	:user-agent; bh=D/iwXlhFDVs74I7pbjZdJ9OqgCy7tcoxyzMcRknhddQ=;
	b=1J4qFusAVYFC+vItP7CFyKPrQGTC3FlsTM+OitfDz8fF0g+tClf/HPiq01Om4XFqRd
	NAZDYQQw7oB24ZiSEo1cKuGWFH88J3/zaK6aMgdy+NYKaedKNxHQeGKeiB90MuVioLZ5
	/Mv+UFKVwSYbJJn14z+QXzcn1QaseMslbjTM/KCrfkjeqpwYtLRWWgPEO1dSEwNFDP3x
	0K9nzcAoD4xknlhqKtTh2yS8l0ZkSefKGFpICyODUCrL1nKzfR69irvp9f7zFmZHdMWU
	xCzznp2w6fXaqxbVyKLBVQuUcwn66sohFH/zUbZT5IrazKTaghM4igAyj6rtK1lN+X9J
	+gmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=D/iwXlhFDVs74I7pbjZdJ9OqgCy7tcoxyzMcRknhddQ=;
	b=G7orgCer7HLhXMbSLaYVf/MORpnQ09wLleZ/v5lYgTfumpavv93h8QJgDjg1oc20gR
	CRVvT3V32TEnWvvWaJqLQvZILjdmcTLLoghlIxaPwRl/8xgIP/KBT0U6cqnAYD212RoY
	M8kKjDIrd/Bon0LtXPEDXKAbkw89wgIElrgje8aEq+BPTIxhKU3ESKTYasIWu6v26FQ8
	GbpHAh1QuQmj3dab5kwL77Bm/j3cId0jS4SHWKEANGomLEcfoVyjT6fBhO15iJUsf3su
	PBuxPwa3UF+L9z5YRHvx4psuaLF78Z49FUnW2scRmituCLapWy5hIHyvWGyUQ6olWmxS
	06iQ==
X-Gm-Message-State: APjAAAVa+lTTnHxst8NBjlTVpTXVC5x9OgmT4DLf8Gv3/oSz8ITcYJPp
	5bUbZAbwazLUdIOV3FvhHksCKfQdV9U=
X-Google-Smtp-Source: APXvYqxKe+k+8WY10yjRi5lvytyIaJt/JCNj41QoQlGkR+tR4Ih+qJIAaIMmQw9vdMS2sLQkYx3XPA==
X-Received: by 2002:ac2:563c:: with SMTP id b28mr69177lff.149.1573084724820;
	Wed, 06 Nov 2019 15:58:44 -0800 (PST)
Received: from localhost (h-93-159.A463.priv.bahnhof.se. [46.59.93.159])
	by smtp.gmail.com with ESMTPSA id e2sm143928ljp.48.2019.11.06.15.58.44
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 06 Nov 2019 15:58:44 -0800 (PST)
Date: Thu, 7 Nov 2019 00:58:43 +0100
From: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v3 2/6] iommu/ipmmu-vmsa: tidyup register definitions
Message-ID: <20191106235843.GC18345@bigcity.dyn.berto.se>
References: <1573007750-16611-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1573007750-16611-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1573007750-16611-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Shimoda-san,

Thanks for your patch,

On 2019-11-06 11:35:46 +0900, Yoshihiro Shimoda wrote:
> To support different registers memory mapping hardware easily
> in the future, this patch tidies up the register definitions
> as below:
>  - Add comments to state to which SoCs or SoC families they apply
>  - Add categories about MMU "context" and uTLB registers
> =

> No change behavior.
> =

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/iommu/ipmmu-vmsa.c | 58 ++++++++++++++++++++++++----------------=
------
>  1 file changed, 30 insertions(+), 28 deletions(-)
> =

> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index c4ec166..79975e1 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -101,47 +101,49 @@ static struct ipmmu_vmsa_device *to_ipmmu(struct de=
vice *dev)
>  =

>  #define IM_CTX_SIZE			0x40
>  =

> -#define IMCTR				0x0000
> -#define IMCTR_INTEN			(1 << 2)
> -#define IMCTR_FLUSH			(1 << 1)
> -#define IMCTR_MMUEN			(1 << 0)
> -
> -#define IMTTBCR				0x0008
> -#define IMTTBCR_EAE			(1 << 31)
> +/* MMU "context" registers */
> +#define IMCTR				0x0000		/* R-Car Gen2/3 */
> +#define IMCTR_INTEN			(1 << 2)	/* R-Car Gen2/3 */
> +#define IMCTR_FLUSH			(1 << 1)	/* R-Car Gen2/3 */
> +#define IMCTR_MMUEN			(1 << 0)	/* R-Car Gen2/3 */
> +
> +#define IMTTBCR				0x0008		/* R-Car Gen2/3 */
> +#define IMTTBCR_EAE			(1 << 31)	/* R-Car Gen2/3 */
>  #define IMTTBCR_SH0_INNER_SHAREABLE	(3 << 12)	/* R-Car Gen2 only */
>  #define IMTTBCR_ORGN0_WB_WA		(1 << 10)	/* R-Car Gen2 only */
>  #define IMTTBCR_IRGN0_WB_WA		(1 << 8)	/* R-Car Gen2 only */
>  #define IMTTBCR_SL0_TWOBIT_LVL_1	(2 << 6)	/* R-Car Gen3 only */
> -#define IMTTBCR_SL0_LVL_1		(1 << 4)
> +#define IMTTBCR_SL0_LVL_1		(1 << 4)	/* R-Car Gen2 only */
>  =

> -#define IMBUSCR				0x000c
> -#define IMBUSCR_DVM			(1 << 2)
> -#define IMBUSCR_BUSSEL_MASK		(3 << 0)
> +#define IMBUSCR				0x000c		/* R-Car Gen2 only */
> +#define IMBUSCR_DVM			(1 << 2)	/* R-Car Gen2 only */
> +#define IMBUSCR_BUSSEL_MASK		(3 << 0)	/* R-Car Gen2 only */
>  =

> -#define IMTTLBR0			0x0010
> -#define IMTTUBR0			0x0014
> +#define IMTTLBR0			0x0010		/* R-Car Gen2/3 */
> +#define IMTTUBR0			0x0014		/* R-Car Gen2/3 */
>  =

> -#define IMSTR				0x0020
> -#define IMSTR_MHIT			(1 << 4)
> -#define IMSTR_ABORT			(1 << 2)
> -#define IMSTR_PF			(1 << 1)
> -#define IMSTR_TF			(1 << 0)
> +#define IMSTR				0x0020		/* R-Car Gen2/3 */
> +#define IMSTR_MHIT			(1 << 4)	/* R-Car Gen2/3 */
> +#define IMSTR_ABORT			(1 << 2)	/* R-Car Gen2/3 */
> +#define IMSTR_PF			(1 << 1)	/* R-Car Gen2/3 */
> +#define IMSTR_TF			(1 << 0)	/* R-Car Gen2/3 */
>  =

> -#define IMMAIR0				0x0028
> +#define IMMAIR0				0x0028		/* R-Car Gen2/3 */
>  =

> -#define IMELAR				0x0030	/* IMEAR on R-Car Gen2 */
> -#define IMEUAR				0x0034	/* R-Car Gen3 only */
> +#define IMELAR				0x0030		/* R-Car Gen2/3, IMEAR on R-Car Gen2 */
> +#define IMEUAR				0x0034		/* R-Car Gen3 only */
>  =

> +/* uTLB registers */
>  #define IMUCTR(n)			((n) < 32 ? IMUCTR0(n) : IMUCTR32(n))
> -#define IMUCTR0(n)			(0x0300 + ((n) * 16))
> -#define IMUCTR32(n)			(0x0600 + (((n) - 32) * 16))
> -#define IMUCTR_TTSEL_MMU(n)		((n) << 4)
> -#define IMUCTR_FLUSH			(1 << 1)
> -#define IMUCTR_MMUEN			(1 << 0)
> +#define IMUCTR0(n)			(0x0300 + ((n) * 16))		/* R-Car Gen2/3 */
> +#define IMUCTR32(n)			(0x0600 + (((n) - 32) * 16))	/* R-Car Gen3 only */
> +#define IMUCTR_TTSEL_MMU(n)		((n) << 4)	/* R-Car Gen2/3 */
> +#define IMUCTR_FLUSH			(1 << 1)	/* R-Car Gen2/3 */
> +#define IMUCTR_MMUEN			(1 << 0)	/* R-Car Gen2/3 */
>  =

>  #define IMUASID(n)			((n) < 32 ? IMUASID0(n) : IMUASID32(n))
> -#define IMUASID0(n)			(0x0308 + ((n) * 16))
> -#define IMUASID32(n)			(0x0608 + (((n) - 32) * 16))
> +#define IMUASID0(n)			(0x0308 + ((n) * 16))		/* R-Car Gen2/3 */
> +#define IMUASID32(n)			(0x0608 + (((n) - 32) * 16))	/* R-Car Gen3 only */
>  =

>  /* ---------------------------------------------------------------------=
--------
>   * Root device handling
> -- =

> 2.7.4
> =


-- =

Regards,
Niklas S=F6derlund
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
