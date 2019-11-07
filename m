Return-Path: <SRS0=3PM5=Y7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C590CFC6195
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 00:10:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9479A21848
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 00:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="zulUmFxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9479A21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ragnatech.se
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 66A96CA4;
	Thu,  7 Nov 2019 00:10:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C2A14B7D
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 00:10:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
	[209.85.167.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5B29D196
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 00:10:02 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id z12so91335lfj.9
	for <iommu@lists.linux-foundation.org>;
	Wed, 06 Nov 2019 16:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:content-transfer-encoding:in-reply-to
	:user-agent; bh=te+ktKBdR0/7Bnwe4NQVECjo/K794ub0RnLYyZUu4GI=;
	b=zulUmFxzS8/LeD8wD6otjK4rBmmr91ro4L4T4AJeCUIFoU2Q2XhfLoz9gClslGHuqC
	geSYZdwi/5C/W4OeznUv298Up6IIHVFLIo2yZSNj1OyQgHbwObB0tfTYC/ZG79VP1Jxa
	7TuzwIhHbR/VKjs2NVqPbtOKSlD0hCzxmqO34D7QLZqE2NftzSK4Ns2WJNHZnmSFVq/m
	nMpy10UobnyAoa6tT4oWUugUqBCORYYNiWCiFKp4WrNQNiKA8xGtH3xVWvZnfGMNfcPV
	0fDnQZyZ1Uab2RPP7MnfkqxipNh0KZgywTnQNW3XQwfhUp5xLG4vE2xMHSyMjvk7dza4
	LUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=te+ktKBdR0/7Bnwe4NQVECjo/K794ub0RnLYyZUu4GI=;
	b=eBPX1TS2yqnqQAdmlxdW2NgrXkdVtbOfQZeVkeRJGsa8f9V+QwZq8UBYvEq1TdkSi6
	JvSuKJv0ykMUcU+KgnKQxU2psGRTuCbuTDhDraMlFIAFQAE1cHuG5fVNC+DSAT8C0/kF
	d1sB/n7MnfyLIbDleM1nRrvUyVBVGbqLldRSjKy6/935XZMSoNrtPqVxtnoF4LxXlvzH
	HKxDIXdqr8hPVGSQjWxU1vfH3MQEmnI+iCZHb1mbpdyqoBkjeNIlZh7bS0pNvCuoFPeT
	sKnzKIa5WzlZ/CQGO3/rQULewDrKGA9hCmpfuPAXDHN6ZPuv1k0NFud30LCXngGapwsI
	7uBw==
X-Gm-Message-State: APjAAAXwKMFKl1J+7n4vKVKpTUt9V8y7x3vcAeBhi6gTjP2s7MbqUTtq
	DLpcbkdQ8H6sRBmjhLfAh8n1jA==
X-Google-Smtp-Source: APXvYqx+nMnPVZo0EIzd46VakJEV0IvTW5DkIiTE/fTpRwd4zNPHr3YsxDdkfZJUa+l2xrQF6/5JqQ==
X-Received: by 2002:ac2:4ace:: with SMTP id m14mr127408lfp.130.1573085400783; 
	Wed, 06 Nov 2019 16:10:00 -0800 (PST)
Received: from localhost (h-93-159.A463.priv.bahnhof.se. [46.59.93.159])
	by smtp.gmail.com with ESMTPSA id n10sm142584lfe.86.2019.11.06.16.09.59
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 06 Nov 2019 16:09:59 -0800 (PST)
Date: Thu, 7 Nov 2019 01:09:59 +0100
From: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v3 5/6] iommu/ipmmu-vmsa: Add helper functions for "uTLB"
	registers
Message-ID: <20191107000959.GF18345@bigcity.dyn.berto.se>
References: <1573007750-16611-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1573007750-16611-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1573007750-16611-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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

On 2019-11-06 11:35:49 +0900, Yoshihiro Shimoda wrote:
> Since we will have changed memory mapping of the IPMMU in the future,
> This patch adds helper functions ipmmu_utlb_reg() and
> ipmmu_imu{asid,ctr}_write() for "uTLB" registers. No behavior change.
> =

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/iommu/ipmmu-vmsa.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> =

> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 8e2ca1c..82da486 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -230,6 +230,23 @@ static void ipmmu_ctx_write_all(struct ipmmu_vmsa_do=
main *domain,
>  	ipmmu_ctx_write(domain->mmu->root, domain->context_id, reg, data);
>  }
>  =

> +static u32 ipmmu_utlb_reg(struct ipmmu_vmsa_device *mmu, unsigned int re=
g)
> +{
> +	return reg;
> +}
> +
> +static void ipmmu_imuasid_write(struct ipmmu_vmsa_device *mmu,
> +				unsigned int utlb, u32 data)
> +{
> +	ipmmu_write(mmu, ipmmu_utlb_reg(mmu, IMUASID(utlb)), data);
> +}
> +
> +static void ipmmu_imuctr_write(struct ipmmu_vmsa_device *mmu,
> +			       unsigned int utlb, u32 data)
> +{
> +	ipmmu_write(mmu, ipmmu_utlb_reg(mmu, IMUCTR(utlb)), data);
> +}
> +
>  /* ---------------------------------------------------------------------=
--------
>   * TLB and microTLB Management
>   */
> @@ -275,11 +292,10 @@ static void ipmmu_utlb_enable(struct ipmmu_vmsa_dom=
ain *domain,
>  	 */
>  =

>  	/* TODO: What should we set the ASID to ? */
> -	ipmmu_write(mmu, IMUASID(utlb), 0);
> +	ipmmu_imuasid_write(mmu, utlb, 0);
>  	/* TODO: Do we need to flush the microTLB ? */
> -	ipmmu_write(mmu, IMUCTR(utlb),
> -		    IMUCTR_TTSEL_MMU(domain->context_id) | IMUCTR_FLUSH |
> -		    IMUCTR_MMUEN);
> +	ipmmu_imuctr_write(mmu, utlb, IMUCTR_TTSEL_MMU(domain->context_id) |
> +				      IMUCTR_FLUSH | IMUCTR_MMUEN);
>  	mmu->utlb_ctx[utlb] =3D domain->context_id;
>  }
>  =

> @@ -291,7 +307,7 @@ static void ipmmu_utlb_disable(struct ipmmu_vmsa_doma=
in *domain,
>  {
>  	struct ipmmu_vmsa_device *mmu =3D domain->mmu;
>  =

> -	ipmmu_write(mmu, IMUCTR(utlb), 0);
> +	ipmmu_imuctr_write(mmu, utlb, 0);
>  	mmu->utlb_ctx[utlb] =3D IPMMU_CTX_INVALID;
>  }
>  =

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
