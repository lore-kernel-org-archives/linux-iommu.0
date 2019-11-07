Return-Path: <SRS0=3PM5=Y7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE0CFC6196
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 00:11:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B83217F5
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 00:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="OAdQ+KsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B83217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ragnatech.se
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A4F52CA8;
	Thu,  7 Nov 2019 00:11:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2924AAD7
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 00:11:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
	[209.85.208.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BA470196
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 00:11:06 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id n21so167461ljg.12
	for <iommu@lists.linux-foundation.org>;
	Wed, 06 Nov 2019 16:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:content-transfer-encoding:in-reply-to
	:user-agent; bh=t29L8pHs1xG8RkPaoBvRVOiIoBVujBGtSMYiRlmYjVE=;
	b=OAdQ+KsKiqDB9xQ7oq5ZPDOzzwG97KbHoOqeMqEibD7QPpjsuJhAI7Cft08HkNpGg+
	ei74ztX3onpYg824xTaD3+yUvyz/l+y2oUKrxdbMY80sISVWlNdKKkC7/uee8Y6N1CcY
	x0NcLz1wgaOK25ytY0YAi0QoSmi7cyiEiQDRnDXtps5Xvjrc7entKTKs0RWxBdyGkp6r
	6q7lMMCI9umbJkFFbd7IlFQVQnT70OeiBstlm8HuaO53te7QeBFXaLqzzludIF3JHYf1
	7OqP9dnTfPFjQoZLizgmy+6cOWi2fObDnYp8Sn/RGcOjO15QoPPuIkEHY1/VJLezNySh
	+XxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=t29L8pHs1xG8RkPaoBvRVOiIoBVujBGtSMYiRlmYjVE=;
	b=bm4Z5DIowD0mVg/x9cXXrLT88zRC6A8EkjWiJS5e+30FRzeQ4s1ot2WnNfHI2nhsGn
	zrK+sN8iZ+WUsYhXiNDWGWAflFXlDhsgeWPDu63D9vGc8BuVjyc3MfQjFymnjJb4VzwX
	dsUkCdE0v6D0Z6uvBZfKq2P5gF3tUAmllmDWJ0r9F9+X5Mox+wUfA0Zz12Oy0H0IS6dv
	90mV+15JDdWYcBs6WKj3Fhr9Un6l0UVzEbA3cdjtZrMV4pAvV48ors6T/6F22cg0jweQ
	D6abxz6+U4KFLBsmU9h1qyMljSeS+z93fr5QDAOTDpnIVV+WuCC9XVoeTTJenHmJZCSF
	fgIw==
X-Gm-Message-State: APjAAAXoxbx5dtbwymJMA2OpI0268mLsZ712nRLe3FY55ejJe0TTkFzn
	Fob6C+XIs23QLiizgB9BumpM/w==
X-Google-Smtp-Source: APXvYqwcCzcfy4vXW68zINBR9vMAZfZrg1ZzfCfum+hibvhaKKo7kAAzkGbwPeRkSRmqfQBuiRatJA==
X-Received: by 2002:a2e:9e97:: with SMTP id f23mr101367ljk.89.1573085465185;
	Wed, 06 Nov 2019 16:11:05 -0800 (PST)
Received: from localhost (h-93-159.A463.priv.bahnhof.se. [46.59.93.159])
	by smtp.gmail.com with ESMTPSA id q26sm138561lfo.65.2019.11.06.16.11.04
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 06 Nov 2019 16:11:04 -0800 (PST)
Date: Thu, 7 Nov 2019 01:11:03 +0100
From: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v3 6/6] iommu/ipmmu-vmsa: Add utlb_offset_base
Message-ID: <20191107001103.GG18345@bigcity.dyn.berto.se>
References: <1573007750-16611-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1573007750-16611-7-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1573007750-16611-7-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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

On 2019-11-06 11:35:50 +0900, Yoshihiro Shimoda wrote:
> Since we will have changed memory mapping of the IPMMU in the future,
> this patch adds a utlb_offset_base into struct ipmmu_features
> for IMUCTR and IMUASID registers. No behavior change.
> =

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/iommu/ipmmu-vmsa.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 82da486..c813436 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -52,6 +52,7 @@ struct ipmmu_features {
>  	bool cache_snoop;
>  	unsigned int ctx_offset_base;
>  	unsigned int ctx_offset_stride;
> +	unsigned int utlb_offset_base;
>  };
>  =

>  struct ipmmu_vmsa_device {
> @@ -232,7 +233,7 @@ static void ipmmu_ctx_write_all(struct ipmmu_vmsa_dom=
ain *domain,
>  =

>  static u32 ipmmu_utlb_reg(struct ipmmu_vmsa_device *mmu, unsigned int re=
g)
>  {
> -	return reg;
> +	return mmu->features->utlb_offset_base + reg;
>  }
>  =

>  static void ipmmu_imuasid_write(struct ipmmu_vmsa_device *mmu,
> @@ -958,6 +959,7 @@ static const struct ipmmu_features ipmmu_features_def=
ault =3D {
>  	.cache_snoop =3D true,
>  	.ctx_offset_base =3D 0,
>  	.ctx_offset_stride =3D 0x40,
> +	.utlb_offset_base =3D 0,
>  };
>  =

>  static const struct ipmmu_features ipmmu_features_rcar_gen3 =3D {
> @@ -971,6 +973,7 @@ static const struct ipmmu_features ipmmu_features_rca=
r_gen3 =3D {
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
