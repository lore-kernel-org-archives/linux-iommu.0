Return-Path: <SRS0=/wjm=Y6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131A7FC6196
	for <iommu@archiver.kernel.org>; Wed,  6 Nov 2019 23:57:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C99FB206C3
	for <iommu@archiver.kernel.org>; Wed,  6 Nov 2019 23:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="EyJuna9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99FB206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ragnatech.se
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 755F4CC2;
	Wed,  6 Nov 2019 23:57:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E1982CBD
	for <iommu@lists.linux-foundation.org>;
	Wed,  6 Nov 2019 23:57:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
	[209.85.208.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7573CE6
	for <iommu@lists.linux-foundation.org>;
	Wed,  6 Nov 2019 23:57:01 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id r7so184305ljg.2
	for <iommu@lists.linux-foundation.org>;
	Wed, 06 Nov 2019 15:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:content-transfer-encoding:in-reply-to
	:user-agent; bh=xfQdZv3rlCqFdF3pxkbe5faxXsBGkHBJR+o8Kau/hvg=;
	b=EyJuna9uSI2254aYkiVpAO3g+oM2C3fd3/s+ZZz2bJq0xgHRtLo41z+6yiG50VQNh2
	mdx4k9n5dKvC29qZ5LFx2koZt1WcG5MXtO6XDTQqigarmE0d9mXrs9jiQAPDK27rSGbZ
	ko6KWoZWYFB+vA1Rdgp4RovX55O3z1mNz80KGRvvsPyJa+hJRY0yJpavfjNf59wfU8hz
	IuI0M7FZSg11McpGakH+elyz/EJRmjZxTfNTnOWJy8Eo0wqa7guYXP/SyDMAJM49Z36o
	a75pFyV/1fYYCrSHjcqBMF6AjnMFkh1Qz1H2WJm5RuuKUUVc7You+Ep+flT6+ryap07i
	/d8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=xfQdZv3rlCqFdF3pxkbe5faxXsBGkHBJR+o8Kau/hvg=;
	b=FyzMLKgj9Gpt44ckcF5wZ0mU7WFx0iuu2Sl/YAdCy8L6eJO2tC/O8jwUchvzMAosqR
	SFrI6fobIwjacCH6RAsp9mt7379V+TfzKQQdwX/9A2Zu3Q81Z0ICEzmhJUlIw38Z6xWZ
	ordSV5m2Bio1D7W8dgsiz9LeWo09rOxexJL3Oq4Hv5eAwTDJXoAqYfZOyEzW0zlviAxu
	mVnavxdDVnBvLl6MTTvpPJI+WbbO4Ub6k08DBVQqmUaha5aI3KXnsPoKeuzAjPBrx0Tb
	S49/aCOolN0ommU1rxLhQCj4fc78q9eF5+ZLHK2lJ4yOPrX9FjINWX9X/JCcgObVFB8/
	arFg==
X-Gm-Message-State: APjAAAVSrDO/BGTpoi8f752YOUoURAxCm6CLAz7uA6U8lJBXVWHtBFtI
	FBkUsbXdwDta6A6G7TgV2EtgLw==
X-Google-Smtp-Source: APXvYqxUdGwuJzHIcm8kxeUmpbzTlnr0AgVzUhUfheJ3YbSig2noVKVTlztwVCEkbIKedJAVsjUSqw==
X-Received: by 2002:a2e:2419:: with SMTP id k25mr69255ljk.59.1573084619546;
	Wed, 06 Nov 2019 15:56:59 -0800 (PST)
Received: from localhost (h-93-159.A463.priv.bahnhof.se. [46.59.93.159])
	by smtp.gmail.com with ESMTPSA id y21sm127159ljm.25.2019.11.06.15.56.58
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 06 Nov 2019 15:56:58 -0800 (PST)
Date: Thu, 7 Nov 2019 00:56:58 +0100
From: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v3 1/6] iommu/ipmmu-vmsa: Remove all unused register
	definitions
Message-ID: <20191106235658.GB18345@bigcity.dyn.berto.se>
References: <1573007750-16611-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1573007750-16611-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1573007750-16611-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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

Thanks for your work.

On 2019-11-06 11:35:45 +0900, Yoshihiro Shimoda wrote:
> To support different registers memory mapping hardware easily
> in the future, this patch removes all unused register
> definitions.
> =

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/iommu/ipmmu-vmsa.c | 76 ----------------------------------------=
------
>  1 file changed, 76 deletions(-)
> =

> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 5904c23..c4ec166 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -102,122 +102,46 @@ static struct ipmmu_vmsa_device *to_ipmmu(struct d=
evice *dev)
>  #define IM_CTX_SIZE			0x40
>  =

>  #define IMCTR				0x0000
> -#define IMCTR_TRE			(1 << 17)
> -#define IMCTR_AFE			(1 << 16)
> -#define IMCTR_RTSEL_MASK		(3 << 4)
> -#define IMCTR_RTSEL_SHIFT		4
> -#define IMCTR_TREN			(1 << 3)
>  #define IMCTR_INTEN			(1 << 2)
>  #define IMCTR_FLUSH			(1 << 1)
>  #define IMCTR_MMUEN			(1 << 0)
>  =

> -#define IMCAAR				0x0004
> -
>  #define IMTTBCR				0x0008
>  #define IMTTBCR_EAE			(1 << 31)
> -#define IMTTBCR_PMB			(1 << 30)
> -#define IMTTBCR_SH1_NON_SHAREABLE	(0 << 28)	/* R-Car Gen2 only */
> -#define IMTTBCR_SH1_OUTER_SHAREABLE	(2 << 28)	/* R-Car Gen2 only */
> -#define IMTTBCR_SH1_INNER_SHAREABLE	(3 << 28)	/* R-Car Gen2 only */
> -#define IMTTBCR_SH1_MASK		(3 << 28)	/* R-Car Gen2 only */
> -#define IMTTBCR_ORGN1_NC		(0 << 26)	/* R-Car Gen2 only */
> -#define IMTTBCR_ORGN1_WB_WA		(1 << 26)	/* R-Car Gen2 only */
> -#define IMTTBCR_ORGN1_WT		(2 << 26)	/* R-Car Gen2 only */
> -#define IMTTBCR_ORGN1_WB		(3 << 26)	/* R-Car Gen2 only */
> -#define IMTTBCR_ORGN1_MASK		(3 << 26)	/* R-Car Gen2 only */
> -#define IMTTBCR_IRGN1_NC		(0 << 24)	/* R-Car Gen2 only */
> -#define IMTTBCR_IRGN1_WB_WA		(1 << 24)	/* R-Car Gen2 only */
> -#define IMTTBCR_IRGN1_WT		(2 << 24)	/* R-Car Gen2 only */
> -#define IMTTBCR_IRGN1_WB		(3 << 24)	/* R-Car Gen2 only */
> -#define IMTTBCR_IRGN1_MASK		(3 << 24)	/* R-Car Gen2 only */
> -#define IMTTBCR_TSZ1_MASK		(7 << 16)
> -#define IMTTBCR_TSZ1_SHIFT		16
> -#define IMTTBCR_SH0_NON_SHAREABLE	(0 << 12)	/* R-Car Gen2 only */
> -#define IMTTBCR_SH0_OUTER_SHAREABLE	(2 << 12)	/* R-Car Gen2 only */
>  #define IMTTBCR_SH0_INNER_SHAREABLE	(3 << 12)	/* R-Car Gen2 only */
> -#define IMTTBCR_SH0_MASK		(3 << 12)	/* R-Car Gen2 only */
> -#define IMTTBCR_ORGN0_NC		(0 << 10)	/* R-Car Gen2 only */
>  #define IMTTBCR_ORGN0_WB_WA		(1 << 10)	/* R-Car Gen2 only */
> -#define IMTTBCR_ORGN0_WT		(2 << 10)	/* R-Car Gen2 only */
> -#define IMTTBCR_ORGN0_WB		(3 << 10)	/* R-Car Gen2 only */
> -#define IMTTBCR_ORGN0_MASK		(3 << 10)	/* R-Car Gen2 only */
> -#define IMTTBCR_IRGN0_NC		(0 << 8)	/* R-Car Gen2 only */
>  #define IMTTBCR_IRGN0_WB_WA		(1 << 8)	/* R-Car Gen2 only */
> -#define IMTTBCR_IRGN0_WT		(2 << 8)	/* R-Car Gen2 only */
> -#define IMTTBCR_IRGN0_WB		(3 << 8)	/* R-Car Gen2 only */
> -#define IMTTBCR_IRGN0_MASK		(3 << 8)	/* R-Car Gen2 only */
> -#define IMTTBCR_SL0_TWOBIT_LVL_3	(0 << 6)	/* R-Car Gen3 only */
> -#define IMTTBCR_SL0_TWOBIT_LVL_2	(1 << 6)	/* R-Car Gen3 only */
>  #define IMTTBCR_SL0_TWOBIT_LVL_1	(2 << 6)	/* R-Car Gen3 only */
> -#define IMTTBCR_SL0_LVL_2		(0 << 4)
>  #define IMTTBCR_SL0_LVL_1		(1 << 4)
> -#define IMTTBCR_TSZ0_MASK		(7 << 0)
> -#define IMTTBCR_TSZ0_SHIFT		O
>  =

>  #define IMBUSCR				0x000c
>  #define IMBUSCR_DVM			(1 << 2)
> -#define IMBUSCR_BUSSEL_SYS		(0 << 0)
> -#define IMBUSCR_BUSSEL_CCI		(1 << 0)
> -#define IMBUSCR_BUSSEL_IMCAAR		(2 << 0)
> -#define IMBUSCR_BUSSEL_CCI_IMCAAR	(3 << 0)
>  #define IMBUSCR_BUSSEL_MASK		(3 << 0)
>  =

>  #define IMTTLBR0			0x0010
>  #define IMTTUBR0			0x0014
> -#define IMTTLBR1			0x0018
> -#define IMTTUBR1			0x001c
>  =

>  #define IMSTR				0x0020
> -#define IMSTR_ERRLVL_MASK		(3 << 12)
> -#define IMSTR_ERRLVL_SHIFT		12
> -#define IMSTR_ERRCODE_TLB_FORMAT	(1 << 8)
> -#define IMSTR_ERRCODE_ACCESS_PERM	(4 << 8)
> -#define IMSTR_ERRCODE_SECURE_ACCESS	(5 << 8)
> -#define IMSTR_ERRCODE_MASK		(7 << 8)
>  #define IMSTR_MHIT			(1 << 4)
>  #define IMSTR_ABORT			(1 << 2)
>  #define IMSTR_PF			(1 << 1)
>  #define IMSTR_TF			(1 << 0)
>  =

>  #define IMMAIR0				0x0028
> -#define IMMAIR1				0x002c
> -#define IMMAIR_ATTR_MASK		0xff
> -#define IMMAIR_ATTR_DEVICE		0x04
> -#define IMMAIR_ATTR_NC			0x44
> -#define IMMAIR_ATTR_WBRWA		0xff
> -#define IMMAIR_ATTR_SHIFT(n)		((n) << 3)
> -#define IMMAIR_ATTR_IDX_NC		0
> -#define IMMAIR_ATTR_IDX_WBRWA		1
> -#define IMMAIR_ATTR_IDX_DEV		2
>  =

>  #define IMELAR				0x0030	/* IMEAR on R-Car Gen2 */
>  #define IMEUAR				0x0034	/* R-Car Gen3 only */
>  =

> -#define IMPCTR				0x0200
> -#define IMPSTR				0x0208
> -#define IMPEAR				0x020c
> -#define IMPMBA(n)			(0x0280 + ((n) * 4))
> -#define IMPMBD(n)			(0x02c0 + ((n) * 4))
> -
>  #define IMUCTR(n)			((n) < 32 ? IMUCTR0(n) : IMUCTR32(n))
>  #define IMUCTR0(n)			(0x0300 + ((n) * 16))
>  #define IMUCTR32(n)			(0x0600 + (((n) - 32) * 16))
> -#define IMUCTR_FIXADDEN			(1 << 31)
> -#define IMUCTR_FIXADD_MASK		(0xff << 16)
> -#define IMUCTR_FIXADD_SHIFT		16
>  #define IMUCTR_TTSEL_MMU(n)		((n) << 4)
> -#define IMUCTR_TTSEL_PMB		(8 << 4)
> -#define IMUCTR_TTSEL_MASK		(15 << 4)
>  #define IMUCTR_FLUSH			(1 << 1)
>  #define IMUCTR_MMUEN			(1 << 0)
>  =

>  #define IMUASID(n)			((n) < 32 ? IMUASID0(n) : IMUASID32(n))
>  #define IMUASID0(n)			(0x0308 + ((n) * 16))
>  #define IMUASID32(n)			(0x0608 + (((n) - 32) * 16))
> -#define IMUASID_ASID8_MASK		(0xff << 8)
> -#define IMUASID_ASID8_SHIFT		8
> -#define IMUASID_ASID0_MASK		(0xff << 0)
> -#define IMUASID_ASID0_SHIFT		0
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
