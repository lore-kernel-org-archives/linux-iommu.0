Return-Path: <SRS0=Ni9g=YC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5C1ECE58C
	for <iommu@archiver.kernel.org>; Wed,  9 Oct 2019 21:03:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1A64206B6
	for <iommu@archiver.kernel.org>; Wed,  9 Oct 2019 21:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="pGEmno8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A64206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ragnatech.se
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 506EBC6D;
	Wed,  9 Oct 2019 21:03:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A7B12B3E
	for <iommu@lists.linux-foundation.org>;
	Wed,  9 Oct 2019 21:03:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
	[209.85.208.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B765014D
	for <iommu@lists.linux-foundation.org>;
	Wed,  9 Oct 2019 21:03:28 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id y3so3928186ljj.6
	for <iommu@lists.linux-foundation.org>;
	Wed, 09 Oct 2019 14:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:content-transfer-encoding:in-reply-to
	:user-agent; bh=h+JtTq4mvtCEE5k+YHCZXtpasm7hEklC4uGdnSVTHGk=;
	b=pGEmno8dmtihs+7wmXMqz4WCLVyUuv646qTbiHEu2tvyoCCbHds/OVskPeTXb2bdRU
	aMXIxUt9FdmOvrvBAqFWarohzoNqySFgHiWBHO7MnGsrsnz4WC0FB7z8lAOqFA7BaTfK
	ZpkSPyg5q647LxZBY6uKMmzONgKRzmRYZWavW+2aIZKmJT9AyGWKSioN8WcvIAaAn//I
	dNoCMFfLuPIzrY6T1n3YrWN8hisdVx6ts6etnIzdWzl6NdQHGUfLZ6WPNcLd6wWjhYP1
	HgPVrqak+yZP1rjgCeFEe/JHfWgvB8seP5raK9TrD/G2mSP8/aEGo2wouB3uWZnrY43V
	66AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=h+JtTq4mvtCEE5k+YHCZXtpasm7hEklC4uGdnSVTHGk=;
	b=tP/icBm4XCPDiRZOx6QWKpkfjndfNSjhVOJz52wZotQxW11udeY5j0YPhqH9mnZ1N1
	E8xyvh9UGvmQv5WXbaSnF1/e+uIbZKVTlrXAwNMQaQJIj7ewNvPNFTgd4bK7cyTB+exs
	NebVKCrUBOnGQy3FqTNmWz2uAsx2DSXYR9oPX5AGIFZMa5rgESvBqe4dx2QR/AOSyt2f
	vUo4RbQusWRmdBkt5UlBPUFj+m0BpWSyzpPQo/bFRQHQ/YYm3yfR/GS7lcNOwXjnkjAC
	yId6DgEChmeqEWXj1MrjGna+ar7gmVrldBgpKu4L/wPM6zydpcmIRfdWfzAHLx3ZgIUr
	5vRQ==
X-Gm-Message-State: APjAAAU3TFVX88EXeNiIivqtBbR45k90ZY24xMyB5021jArh2d1CUgp+
	opL+6wO/JgBo1UZFyqVqE+Rq1A==
X-Google-Smtp-Source: APXvYqwLJ2rhXvva2jrhIe1pQp5i5yMl0cuwrQ9Jtl/Y9+Gw7fgUZIFTLel2xHbEsJoXbquIwq0+ug==
X-Received: by 2002:a05:651c:1ad:: with SMTP id
	c13mr3673147ljn.131.1570655006786; 
	Wed, 09 Oct 2019 14:03:26 -0700 (PDT)
Received: from localhost (h-93-159.A463.priv.bahnhof.se. [46.59.93.159])
	by smtp.gmail.com with ESMTPSA id f21sm880077lfm.90.2019.10.09.14.03.25
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 09 Oct 2019 14:03:25 -0700 (PDT)
Date: Wed, 9 Oct 2019 23:03:25 +0200
From: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH 1/3] iommu/ipmmu-vmsa: Remove some unused register
	declarations
Message-ID: <20191009210325.GB21066@bigcity.dyn.berto.se>
References: <1570609609-1332-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1570609609-1332-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1570609609-1332-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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

On 2019-10-09 17:26:47 +0900, Yoshihiro Shimoda wrote:
> To support different registers memory mapping hardware easily
> in the future, this patch removes some unused register
> declarations.
> =

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/iommu/ipmmu-vmsa.c | 11 -----------
>  1 file changed, 11 deletions(-)
> =

> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 9da8309..dd554c2 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -104,8 +104,6 @@ static struct ipmmu_vmsa_device *to_ipmmu(struct devi=
ce *dev)
>  #define IMCTR				0x0000
>  #define IMCTR_TRE			(1 << 17)
>  #define IMCTR_AFE			(1 << 16)
> -#define IMCTR_RTSEL_MASK		(3 << 4)
> -#define IMCTR_RTSEL_SHIFT		4
>  #define IMCTR_TREN			(1 << 3)
>  #define IMCTR_INTEN			(1 << 2)
>  #define IMCTR_FLUSH			(1 << 1)
> @@ -115,7 +113,6 @@ static struct ipmmu_vmsa_device *to_ipmmu(struct devi=
ce *dev)
>  =

>  #define IMTTBCR				0x0008
>  #define IMTTBCR_EAE			(1 << 31)
> -#define IMTTBCR_PMB			(1 << 30)
>  #define IMTTBCR_SH1_NON_SHAREABLE	(0 << 28)	/* R-Car Gen2 only */
>  #define IMTTBCR_SH1_OUTER_SHAREABLE	(2 << 28)	/* R-Car Gen2 only */
>  #define IMTTBCR_SH1_INNER_SHAREABLE	(3 << 28)	/* R-Car Gen2 only */
> @@ -193,12 +190,6 @@ static struct ipmmu_vmsa_device *to_ipmmu(struct dev=
ice *dev)
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
> @@ -206,8 +197,6 @@ static struct ipmmu_vmsa_device *to_ipmmu(struct devi=
ce *dev)
>  #define IMUCTR_FIXADD_MASK		(0xff << 16)
>  #define IMUCTR_FIXADD_SHIFT		16
>  #define IMUCTR_TTSEL_MMU(n)		((n) << 4)
> -#define IMUCTR_TTSEL_PMB		(8 << 4)
> -#define IMUCTR_TTSEL_MASK		(15 << 4)
>  #define IMUCTR_FLUSH			(1 << 1)
>  #define IMUCTR_MMUEN			(1 << 0)
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
