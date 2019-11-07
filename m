Return-Path: <SRS0=3PM5=Y7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E760DFC6194
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 00:03:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC3B21848
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 00:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="lcycutDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC3B21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ragnatech.se
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 958F9CA8;
	Thu,  7 Nov 2019 00:03:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6DFC6C75
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 00:03:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
	[209.85.167.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B4C22712
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 00:03:29 +0000 (UTC)
Received: by mail-lf1-f68.google.com with SMTP id y6so109367lfj.2
	for <iommu@lists.linux-foundation.org>;
	Wed, 06 Nov 2019 16:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:content-transfer-encoding:in-reply-to
	:user-agent; bh=3bCNZ4bucKIoWN7TF6mWSYKlcv1HzD7HrSwv37jbXQw=;
	b=lcycutDkccaGGcgzrWYWgtG4ks+615mNfLJ/BljiDQDV2T1DkdHb8sH8Xn4/cSA/gk
	8FcfikrRfc4CuFeDJVGZu0kIaC7VekJEyobuOywdkKF8RBUmNqdNnDjBwh+ykXXOvnX/
	TR1fqdjqTpzqGQPzmLd/cUspsSGSiWf/rKnfvHWdCD0hfQDraGnyXb1xjY72Hgzg3a1v
	8bpFifpWMPRXZ7uS/NVZjvB4V8YfzyMf6I5ZftJTgsFxrw8JKni8SjXR5kQt06TlQ3m0
	fvLBPYoMRGDKci09irK7QVb4AU/fnrKaaBlJkjTQDAprws9VkQzalW8Oz+0sGF9LVd6Y
	k+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=3bCNZ4bucKIoWN7TF6mWSYKlcv1HzD7HrSwv37jbXQw=;
	b=c4h22aPGX3GFL+ThMlZ0oP4VlOU4zaOm4sm3ou+/jZFi6Bd9Q+M+J8wDQXVpPOJDLI
	48svL85uogs3eGCin4YBXKhXsnT5xhm+u3nScOSPG9GvD/xhNmhePnRMzJ11G2H5HQkb
	zOd5D3gXj68EUlY0la8MevMKrJMUjYEI+qmO7SG+eUiLEWKzbx17ezd4bpQbZQoMGuqD
	+6vECoaYbbEb7uWvR4RM4TVpxBJ445DDCVQmnkNzrCvcyMds+P9m8QTsWEKPQ2xrTd2i
	bTAKB73lDb6huSCG6NJrM7KMtr26Km0O05l8nro6KrDf3bk3TOKBI9F0K5NznAutcyFN
	jRIg==
X-Gm-Message-State: APjAAAW+vDjkOzFCQvBCKxJO7Z/wQZDsBeo+aLF4QIkOSBJK625DJ9Xl
	mVquxGat0YJ/IZ4cT32sN5J4Sg==
X-Google-Smtp-Source: APXvYqwGbXN/opVQnMIvlpPa/UV5/4fu28QrnvOsj00+Iq20XKjbUBlcXNhbN5JBoGrrMTkpMJ6bWA==
X-Received: by 2002:a05:6512:203:: with SMTP id a3mr97679lfo.7.1573085008049; 
	Wed, 06 Nov 2019 16:03:28 -0800 (PST)
Received: from localhost (h-93-159.A463.priv.bahnhof.se. [46.59.93.159])
	by smtp.gmail.com with ESMTPSA id 30sm169170ljw.29.2019.11.06.16.03.27
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 06 Nov 2019 16:03:27 -0800 (PST)
Date: Thu, 7 Nov 2019 01:03:27 +0100
From: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v3 4/6] iommu/ipmmu-vmsa: Calculate context registers'
	offset instead of a macro
Message-ID: <20191107000327.GE18345@bigcity.dyn.berto.se>
References: <1573007750-16611-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1573007750-16611-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1573007750-16611-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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

On 2019-11-06 11:35:48 +0900, Yoshihiro Shimoda wrote:
> Since we will have changed memory mapping of the IPMMU in the future,
> this patch uses ipmmu_features values instead of a macro to
> calculate context registers offset. No behavior change.
> =

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/iommu/ipmmu-vmsa.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> =

> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index c4fcfda..8e2ca1c 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -50,6 +50,8 @@ struct ipmmu_features {
>  	bool twobit_imttbcr_sl0;
>  	bool reserved_context;
>  	bool cache_snoop;
> +	unsigned int ctx_offset_base;
> +	unsigned int ctx_offset_stride;
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
>  /* MMU "context" registers */
>  #define IMCTR				0x0000		/* R-Car Gen2/3 */
>  #define IMCTR_INTEN			(1 << 2)	/* R-Car Gen2/3 */
> @@ -193,7 +193,8 @@ static void ipmmu_write(struct ipmmu_vmsa_device *mmu=
, unsigned int offset,
>  static unsigned int ipmmu_ctx_reg(struct ipmmu_vmsa_device *mmu,
>  				  unsigned int context_id, unsigned int reg)
>  {
> -	return context_id * IM_CTX_SIZE + reg;
> +	return mmu->features->ctx_offset_base +
> +	       context_id * mmu->features->ctx_offset_stride + reg;
>  }
>  =

>  static u32 ipmmu_ctx_read(struct ipmmu_vmsa_device *mmu,
> @@ -939,6 +940,8 @@ static const struct ipmmu_features ipmmu_features_def=
ault =3D {
>  	.twobit_imttbcr_sl0 =3D false,
>  	.reserved_context =3D false,
>  	.cache_snoop =3D true,
> +	.ctx_offset_base =3D 0,
> +	.ctx_offset_stride =3D 0x40,
>  };
>  =

>  static const struct ipmmu_features ipmmu_features_rcar_gen3 =3D {
> @@ -950,6 +953,8 @@ static const struct ipmmu_features ipmmu_features_rca=
r_gen3 =3D {
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
