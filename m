Return-Path: <SRS0=Ni9g=YC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C07C47404
	for <iommu@archiver.kernel.org>; Wed,  9 Oct 2019 21:13:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D5A206B6
	for <iommu@archiver.kernel.org>; Wed,  9 Oct 2019 21:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="PLcIfGu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D5A206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ragnatech.se
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6AFEACC2;
	Wed,  9 Oct 2019 21:13:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 770C6CBD
	for <iommu@lists.linux-foundation.org>;
	Wed,  9 Oct 2019 21:13:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
	[209.85.208.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0E2E114D
	for <iommu@lists.linux-foundation.org>;
	Wed,  9 Oct 2019 21:13:44 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id b20so3957404ljj.5
	for <iommu@lists.linux-foundation.org>;
	Wed, 09 Oct 2019 14:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:content-transfer-encoding:in-reply-to
	:user-agent; bh=O1szppMdVqNwuc6KuWMWhQME2fGH410c8EpWWgDMBF4=;
	b=PLcIfGu1u1IvCWMz1vxBuFV0cu89qCdiTOjKDli2FoE8twmwiLbiKPOXHeTCC3RUCU
	ldKrvjDP8gQWymjJGBXTEs94sEhw5wG78ttfeaD6QiCLHhW5STKX9DDZfBTfEcQ0PDoq
	Z1EM/7ctGyhoVPhtj49iP+Gmv9PuSwDNt++VGgwgzS6Ym1nleMYhJIuYBAZKq3XHwykJ
	pHDYsUN77cr0PlOmU4bCt/2QjDEkWEPoIqpBJY5cT+yemqPdqakbP3sfuTdCrnbrP93g
	65tmDu4eanInpA7bA6eACIOIG/1olQELCY9txCJ61+Mytdu+ZQ5m4B6W5G96vVLleRT7
	kETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=O1szppMdVqNwuc6KuWMWhQME2fGH410c8EpWWgDMBF4=;
	b=mufQekwFIBHk8S0314q77xOyre8svvsZTlpWGANRZKs2dS8o7Eho10ThRApPygf/IY
	V2jPOxF4VfSuQmr/KYWcT9NT8+54SH2GfvKjTrOqQzsJknNRuz3QUiE9WCcRmgc+ho04
	bBdzchznAdOAeCFWVOUKcXhO0sT6LTDrhZ6T6upLO7RDyqUz0Z+vCH3YBbYx2TH5Nvvo
	+QNg6kryj+7qa04KKIW3+GMVC7GW+A6PiUJ1I7M16R3n+OIQq/wD46g5R1xvWvDKDatd
	WTmDOXovHO2QDmOkbbqwZuuG8C0m4+8qbwv6UVGZZq1H2EjGnzd2vZJHAF4K9JXoCwT7
	FuQQ==
X-Gm-Message-State: APjAAAV52kVCAGdgsoVzthuGDJSi5/ilOpK6F40oOwUyopf5UGE5C6Sr
	9z29Ps7I6REO/P/41z1GMxu5EA==
X-Google-Smtp-Source: APXvYqwmUqnXBsqREPMUGkbmw/+UBNGTNWOYeVWtRCD6oDkAT12c6t2TrIalLcatg3lkNslAjq9Ylg==
X-Received: by 2002:a2e:2b91:: with SMTP id r17mr3698727ljr.1.1570655622441;
	Wed, 09 Oct 2019 14:13:42 -0700 (PDT)
Received: from localhost (h-93-159.A463.priv.bahnhof.se. [46.59.93.159])
	by smtp.gmail.com with ESMTPSA id c69sm741520ljf.32.2019.10.09.14.13.41
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 09 Oct 2019 14:13:41 -0700 (PDT)
Date: Wed, 9 Oct 2019 23:13:41 +0200
From: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH 2/3] iommu/ipmmu-vmsa: Calculate context registers'
	offset instead of a macro
Message-ID: <20191009211341.GC21066@bigcity.dyn.berto.se>
References: <1570609609-1332-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1570609609-1332-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1570609609-1332-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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

Thanks for your patch.

On 2019-10-09 17:26:48 +0900, Yoshihiro Shimoda wrote:
> Since we will have changed memory mapping of the IPMMU in the future,
> this patch uses ipmmu_features values instead of a macro to
> calculate context registers offset. No behavior change.
> =

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/iommu/ipmmu-vmsa.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> =

> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index dd554c2..76fb250 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -50,6 +50,8 @@ struct ipmmu_features {
>  	bool twobit_imttbcr_sl0;
>  	bool reserved_context;
>  	bool cache_snoop;
> +	u32 ctx_offset_base;
> +	u32 ctx_offset_stride;
>  };
>  =

>  struct ipmmu_vmsa_device {
> @@ -99,8 +101,6 @@ static struct ipmmu_vmsa_device *to_ipmmu(struct devic=
e *dev)
>  =

>  #define IM_NS_ALIAS_OFFSET		0x800
>  =

> -#define IM_CTX_SIZE			0x40
> -
>  #define IMCTR				0x0000
>  #define IMCTR_TRE			(1 << 17)
>  #define IMCTR_AFE			(1 << 16)
> @@ -253,18 +253,25 @@ static void ipmmu_write(struct ipmmu_vmsa_device *m=
mu, unsigned int offset,
>  	iowrite32(data, mmu->base + offset);
>  }
>  =

> +static u32 ipmmu_ctx_reg(struct ipmmu_vmsa_device *mmu, unsigned int con=
text_id,
> +			 unsigned int reg)
> +{
> +	return mmu->features->ctx_offset_base +
> +	       context_id * mmu->features->ctx_offset_stride + reg;
> +}
> +
>  static u32 ipmmu_ctx_read_root(struct ipmmu_vmsa_domain *domain,
>  			       unsigned int reg)
>  {
>  	return ipmmu_read(domain->mmu->root,
> -			  domain->context_id * IM_CTX_SIZE + reg);
> +			  ipmmu_ctx_reg(domain->mmu, domain->context_id, reg));
>  }
>  =

>  static void ipmmu_ctx_write_root(struct ipmmu_vmsa_domain *domain,
>  				 unsigned int reg, u32 data)
>  {
>  	ipmmu_write(domain->mmu->root,
> -		    domain->context_id * IM_CTX_SIZE + reg, data);
> +		    ipmmu_ctx_reg(domain->mmu, domain->context_id, reg), data);
>  }
>  =

>  static void ipmmu_ctx_write_all(struct ipmmu_vmsa_domain *domain,
> @@ -272,10 +279,10 @@ static void ipmmu_ctx_write_all(struct ipmmu_vmsa_d=
omain *domain,
>  {
>  	if (domain->mmu !=3D domain->mmu->root)
>  		ipmmu_write(domain->mmu,
> -			    domain->context_id * IM_CTX_SIZE + reg, data);
> +			    ipmmu_ctx_reg(domain->mmu, domain->context_id, reg),
> +			    data);
>  =

> -	ipmmu_write(domain->mmu->root,
> -		    domain->context_id * IM_CTX_SIZE + reg, data);
> +	ipmmu_ctx_write_root(domain, reg, data);
>  }
>  =

>  /* ---------------------------------------------------------------------=
--------
> @@ -974,7 +981,7 @@ static void ipmmu_device_reset(struct ipmmu_vmsa_devi=
ce *mmu)
>  =

>  	/* Disable all contexts. */
>  	for (i =3D 0; i < mmu->num_ctx; ++i)
> -		ipmmu_write(mmu, i * IM_CTX_SIZE + IMCTR, 0);
> +		ipmmu_write(mmu, ipmmu_ctx_reg(mmu, i, IMCTR), 0);
>  }
>  =

>  static const struct ipmmu_features ipmmu_features_default =3D {
> @@ -986,6 +993,8 @@ static const struct ipmmu_features ipmmu_features_def=
ault =3D {
>  	.twobit_imttbcr_sl0 =3D false,
>  	.reserved_context =3D false,
>  	.cache_snoop =3D true,
> +	.ctx_offset_base =3D 0,
> +	.ctx_offset_stride =3D 0x40,
>  };
>  =

>  static const struct ipmmu_features ipmmu_features_rcar_gen3 =3D {
> @@ -997,6 +1006,8 @@ static const struct ipmmu_features ipmmu_features_rc=
ar_gen3 =3D {
>  	.twobit_imttbcr_sl0 =3D true,
>  	.reserved_context =3D true,
>  	.cache_snoop =3D false,
> +	.ctx_offset_base =3D 0,
> +	.ctx_offset_stride =3D 0x40,
>  };
>  =

>  static const struct of_device_id ipmmu_of_ids[] =3D {
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
