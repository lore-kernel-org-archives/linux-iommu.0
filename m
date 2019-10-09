Return-Path: <SRS0=Ni9g=YC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75660ECE58C
	for <iommu@archiver.kernel.org>; Wed,  9 Oct 2019 22:28:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CD61206BB
	for <iommu@archiver.kernel.org>; Wed,  9 Oct 2019 22:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="NsUpvKLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD61206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ragnatech.se
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DA019DC8;
	Wed,  9 Oct 2019 22:28:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 404E0DAB
	for <iommu@lists.linux-foundation.org>;
	Wed,  9 Oct 2019 22:28:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
	[209.85.208.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5A0C65D3
	for <iommu@lists.linux-foundation.org>;
	Wed,  9 Oct 2019 22:28:56 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id m7so4143026lji.2
	for <iommu@lists.linux-foundation.org>;
	Wed, 09 Oct 2019 15:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:content-transfer-encoding:in-reply-to
	:user-agent; bh=R/HtMaWym45Jgs9DzJ9pn5UaNkfLO50BqU9y3ggWmRs=;
	b=NsUpvKLiPn8OYIAleT5jio4lqmOTA75y81AmU5GfR+c3SKfZeI6wUFH6dvMGjYcaJG
	PEM2/QOoSmGwlKPisbliCY22oJbEMhJCDagmdWGrPmnT2lD4tP+KT2RUFNqbq34QSw8R
	0gxaZuazih0Ss8CDxN/Tgp/MuVlRAn6Qij07VwQ0qSy8iySnsjk9Jg/gpAHb9vRmToLZ
	5ShwxiuYucpGf44U0LFXMmknCxelRM3xDbvCo2Zah+gGbRL3PR/DIdL/Y2PJUTZKPbdF
	0bFJSdMGc1b/RTAB+5gbqA+NOFvnx6IhhdsBhA/TkOo0dVWQODmLpK7Fr07apDawM5q5
	TB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=R/HtMaWym45Jgs9DzJ9pn5UaNkfLO50BqU9y3ggWmRs=;
	b=NQfd71GUmpkpv6hjBzz3+D3LUpYZJT8GPVn5mQdzJOdjJus3/msZ5wObpjAzELbhKy
	d6qHgqT9L94gtUDCc+DqGB+CIiIvD5jde774ot2R7DYD27Heq2E2OAj7ohPCajVdsL1o
	q2L4lYHcU4+ZCcdWcVcA3Ry1Tc+sEg+W7Ghz5iPw23jnVB+x3QfE9UtUiV+q9cZAyEX9
	GnDCwvUhS3USjAK9Dihga11qm3rUeNNd1wBlmfIyVyKQgRkMed+HNcuJceiIojxzChh4
	XR0R+OnxZP4WGwsdjYztwKZa0oyGQzVwYVXdD9hMeVGpVKi4qbDJhPbpYqKoApMBjEuc
	eAJA==
X-Gm-Message-State: APjAAAXfCwyLdJop9oepzpkmjmDdW9YdDnlGRG9aWTAwGuYOAFSRFE4P
	UJn+KASOynfZr3XivKOrQeithA==
X-Google-Smtp-Source: APXvYqzONDXkmPjiIUmwEb3PEEeWJnbuEAEK0K2ke1CH0KMhOtf0YIrgYEoNlOGgpagsgyBNyua2IA==
X-Received: by 2002:a05:651c:1031:: with SMTP id
	w17mr3800047ljm.38.1570660134713; 
	Wed, 09 Oct 2019 15:28:54 -0700 (PDT)
Received: from localhost (h-93-159.A463.priv.bahnhof.se. [46.59.93.159])
	by smtp.gmail.com with ESMTPSA id k15sm735891ljg.65.2019.10.09.15.28.53
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 09 Oct 2019 15:28:53 -0700 (PDT)
Date: Thu, 10 Oct 2019 00:28:53 +0200
From: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH 3/3] iommu/ipmmu-vmsa: Add utlb_offset_base
Message-ID: <20191009222853.GA32293@bigcity.dyn.berto.se>
References: <1570609609-1332-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1570609609-1332-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1570609609-1332-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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

On 2019-10-09 17:26:49 +0900, Yoshihiro Shimoda wrote:
> Since we will have changed memory mapping of the IPMMU in the future,
> this patch adds a utlb_offset_base into struct ipmmu_features
> for IMUCTR and IMUASID registers.
> No behavior change.
> =

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/iommu/ipmmu-vmsa.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> =

> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 76fb250..bc00e58 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -52,6 +52,7 @@ struct ipmmu_features {
>  	bool cache_snoop;
>  	u32 ctx_offset_base;
>  	u32 ctx_offset_stride;
> +	u32 utlb_offset_base;
>  };
>  =

>  struct ipmmu_vmsa_device {
> @@ -285,6 +286,11 @@ static void ipmmu_ctx_write_all(struct ipmmu_vmsa_do=
main *domain,
>  	ipmmu_ctx_write_root(domain, reg, data);
>  }
>  =

> +static u32 ipmmu_utlb_reg(struct ipmmu_vmsa_device *mmu, unsigned int re=
g)
> +{
> +	return mmu->features->utlb_offset_base + reg;
> +}
> +
>  /* ---------------------------------------------------------------------=
--------
>   * TLB and microTLB Management
>   */
> @@ -330,9 +336,9 @@ static void ipmmu_utlb_enable(struct ipmmu_vmsa_domai=
n *domain,
>  	 */
>  =

>  	/* TODO: What should we set the ASID to ? */
> -	ipmmu_write(mmu, IMUASID(utlb), 0);
> +	ipmmu_write(mmu, ipmmu_utlb_reg(mmu, IMUASID(utlb)), 0);
>  	/* TODO: Do we need to flush the microTLB ? */
> -	ipmmu_write(mmu, IMUCTR(utlb),
> +	ipmmu_write(mmu, ipmmu_utlb_reg(mmu, IMUCTR(utlb)),
>  		    IMUCTR_TTSEL_MMU(domain->context_id) | IMUCTR_FLUSH |
>  		    IMUCTR_MMUEN);
>  	mmu->utlb_ctx[utlb] =3D domain->context_id;
> @@ -346,7 +352,7 @@ static void ipmmu_utlb_disable(struct ipmmu_vmsa_doma=
in *domain,
>  {
>  	struct ipmmu_vmsa_device *mmu =3D domain->mmu;
>  =

> -	ipmmu_write(mmu, IMUCTR(utlb), 0);
> +	ipmmu_write(mmu, ipmmu_utlb_reg(mmu, IMUCTR(utlb)), 0);
>  	mmu->utlb_ctx[utlb] =3D IPMMU_CTX_INVALID;
>  }
>  =

> @@ -995,6 +1001,7 @@ static const struct ipmmu_features ipmmu_features_de=
fault =3D {
>  	.cache_snoop =3D true,
>  	.ctx_offset_base =3D 0,
>  	.ctx_offset_stride =3D 0x40,
> +	.utlb_offset_base =3D 0,
>  };
>  =

>  static const struct ipmmu_features ipmmu_features_rcar_gen3 =3D {
> @@ -1008,6 +1015,7 @@ static const struct ipmmu_features ipmmu_features_r=
car_gen3 =3D {
>  	.cache_snoop =3D false,
>  	.ctx_offset_base =3D 0,
>  	.ctx_offset_stride =3D 0x40,
> +	.utlb_offset_base =3D 0,
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
