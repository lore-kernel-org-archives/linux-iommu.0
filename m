Return-Path: <SRS0=3PM5=Y7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833AEFC6194
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 00:01:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54553217F5
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 00:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="pB2pRi2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54553217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ragnatech.se
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 43418CC3;
	Thu,  7 Nov 2019 00:01:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8C01BC75
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 00:01:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
	[209.85.208.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 916FC712
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 00:01:45 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id q2so168910ljg.7
	for <iommu@lists.linux-foundation.org>;
	Wed, 06 Nov 2019 16:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:content-transfer-encoding:in-reply-to
	:user-agent; bh=N3xggxZDcjAE7aQm0fUpcBPU4Y0Dslk0T0PK4QiJ3oc=;
	b=pB2pRi2+1/abDK6sddDzck85WGgKVT4eY8WliDcBlStTbgeu4coeFIgdmt7797Cm51
	nzUpUgyDszPQyOsGcFAra8z5Gd2/bJt8xunSz4GcBkJaFLI7DB/Q7VUf6FRftWAgrhqA
	dUv8ZuSOeyCG7MourWXp3K+SQkC0yZaV5+GnEixH8/2VI00k9y19kZFk329oM4iQmg+X
	juVEbFREBoN8HJU7z2EvYHD+d4oaxNJKHVd8W0tLpH4LDjKtH/iugz40c97MJEXapnai
	f/vYC5LkTDdchvMwrBddn5Ja7T5bYFEdMtomNq/fi8FyuIhgxDtiNET+4kRf0/DWMtao
	iAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=N3xggxZDcjAE7aQm0fUpcBPU4Y0Dslk0T0PK4QiJ3oc=;
	b=PYLqZL7NI9ay+lpaZlLC3nPfF38e+YqX6YC7IC5YE5vRCC/47Gh+/mCgDB2YgOzuTe
	rsS34jAFkcA1Mks4VeGcPSnB4Q7jeZGTPuXwXO8Qtp2vHKe4zZi5Ip18kdR3UFMzIKOJ
	e0pY+Ae3PyXt1sn7pSMQE4/+BvuM2S0/tCUYLUm0p67A6q1hwMIR5Vc4gOe7dKwSYjW4
	Db5gbLrEN4y7LJJD8j/3FyrTrErCVyJJK8yEfFIPg3lobQqx1BKPve8ClRRHcH3FTjvA
	G13miSpXMVgMs6E67wb1ZhZGqw+KTiGoZ/qbTLTEYJRgZ8pEsGlWWf3zQrDVPm3n4Yzt
	WEWQ==
X-Gm-Message-State: APjAAAVf7ppzSDbGzMatWSIa85Tl9tUpJIFwM8oLtR1YHXXRvoUipQ0o
	Vy4UwovTkb6gNJYWKHG0zXlXwfgIbak=
X-Google-Smtp-Source: APXvYqy5fmT1UorHhJvw44NfF9a13y4/JsIWzK1n5j+pH5N4vojlk2F+CWt1VJ7I8lTAkprX+IaZcw==
X-Received: by 2002:a2e:970a:: with SMTP id r10mr98856lji.142.1573084903973;
	Wed, 06 Nov 2019 16:01:43 -0800 (PST)
Received: from localhost (h-93-159.A463.priv.bahnhof.se. [46.59.93.159])
	by smtp.gmail.com with ESMTPSA id s28sm127882lfp.92.2019.11.06.16.01.43
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 06 Nov 2019 16:01:43 -0800 (PST)
Date: Thu, 7 Nov 2019 01:01:43 +0100
From: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v3 3/6] iommu/ipmmu-vmsa: Add helper functions for MMU
	"context" registers
Message-ID: <20191107000143.GD18345@bigcity.dyn.berto.se>
References: <1573007750-16611-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1573007750-16611-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1573007750-16611-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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

Thanks for your work,

On 2019-11-06 11:35:47 +0900, Yoshihiro Shimoda wrote:
> Since we will have changed memory mapping of the IPMMU in the future,
> This patch adds helper functions ipmmu_ctx_{reg,read,write}()
> for MMU "context" registers. No behavior change.
> =

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/iommu/ipmmu-vmsa.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> =

> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 79975e1..c4fcfda 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -190,29 +190,43 @@ static void ipmmu_write(struct ipmmu_vmsa_device *m=
mu, unsigned int offset,
>  	iowrite32(data, mmu->base + offset);
>  }
>  =

> +static unsigned int ipmmu_ctx_reg(struct ipmmu_vmsa_device *mmu,
> +				  unsigned int context_id, unsigned int reg)
> +{
> +	return context_id * IM_CTX_SIZE + reg;
> +}
> +
> +static u32 ipmmu_ctx_read(struct ipmmu_vmsa_device *mmu,
> +			  unsigned int context_id, unsigned int reg)
> +{
> +	return ipmmu_read(mmu, ipmmu_ctx_reg(mmu, context_id, reg));
> +}
> +
> +static void ipmmu_ctx_write(struct ipmmu_vmsa_device *mmu,
> +			    unsigned int context_id, unsigned int reg, u32 data)
> +{
> +	ipmmu_write(mmu, ipmmu_ctx_reg(mmu, context_id, reg), data);
> +}
> +
>  static u32 ipmmu_ctx_read_root(struct ipmmu_vmsa_domain *domain,
>  			       unsigned int reg)
>  {
> -	return ipmmu_read(domain->mmu->root,
> -			  domain->context_id * IM_CTX_SIZE + reg);
> +	return ipmmu_ctx_read(domain->mmu->root, domain->context_id, reg);
>  }
>  =

>  static void ipmmu_ctx_write_root(struct ipmmu_vmsa_domain *domain,
>  				 unsigned int reg, u32 data)
>  {
> -	ipmmu_write(domain->mmu->root,
> -		    domain->context_id * IM_CTX_SIZE + reg, data);
> +	ipmmu_ctx_write(domain->mmu->root, domain->context_id, reg, data);
>  }
>  =

>  static void ipmmu_ctx_write_all(struct ipmmu_vmsa_domain *domain,
>  				unsigned int reg, u32 data)
>  {
>  	if (domain->mmu !=3D domain->mmu->root)
> -		ipmmu_write(domain->mmu,
> -			    domain->context_id * IM_CTX_SIZE + reg, data);
> +		ipmmu_ctx_write(domain->mmu, domain->context_id, reg, data);
>  =

> -	ipmmu_write(domain->mmu->root,
> -		    domain->context_id * IM_CTX_SIZE + reg, data);
> +	ipmmu_ctx_write(domain->mmu->root, domain->context_id, reg, data);
>  }
>  =

>  /* ---------------------------------------------------------------------=
--------
> @@ -913,7 +927,7 @@ static void ipmmu_device_reset(struct ipmmu_vmsa_devi=
ce *mmu)
>  =

>  	/* Disable all contexts. */
>  	for (i =3D 0; i < mmu->num_ctx; ++i)
> -		ipmmu_write(mmu, i * IM_CTX_SIZE + IMCTR, 0);
> +		ipmmu_ctx_write(mmu, i, IMCTR, 0);
>  }
>  =

>  static const struct ipmmu_features ipmmu_features_default =3D {
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
