Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EE0C43461
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 12:39:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E69661159
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 12:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E69661159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F96084AD4;
	Thu,  8 Apr 2021 12:39:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5kXdXT0KO8NZ; Thu,  8 Apr 2021 12:39:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id E975684ACC;
	Thu,  8 Apr 2021 12:39:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C87E1C000C;
	Thu,  8 Apr 2021 12:39:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75A1AC000A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 12:39:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6577D84AD4
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 12:39:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E_mZPhbhjfmh for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 12:39:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A79584ACC
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 12:39:55 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id e7so2204588edu.10
 for <iommu@lists.linux-foundation.org>; Thu, 08 Apr 2021 05:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ldEtYBSo9icSaV7Ru0Hgvo2mRzkssFWyJBEPkEeuVk4=;
 b=UyR9UA0A0wJCi8qmeXIQbtws/BwABZpv5E3G4DfYWkynZ4AZSKJA0X07IxuY8kLZ2I
 bkTmOwhTtIfJV/jvW3KDqhl8ITs+MguxyZ6dNi7Pvn2oAddnmEtQBVAa6VAI2Coem93S
 KQf1hkxEUWYXaSkopNw0L8RLEZZjiqFSTs9CYdzDw1YUn3KHHXdVSxUhgTpY50cKKTtJ
 M/5YmdNBl20CiiTe/U7VHrE/KbNvP3DRM1eHxlfTaYjT3G5P0okTHhGK29rWshq1U5Ei
 yTpiC22lMYCeWX1V6ZSRv1Ph5tYFFajua6PyzQAKUzs4h7dMK/q41AojnxeRH2nj2sq/
 pFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ldEtYBSo9icSaV7Ru0Hgvo2mRzkssFWyJBEPkEeuVk4=;
 b=WNIML3K6C6i+sk4QV9AucM8XgyG/d9jMts8l/Bs3Jg+n88zg58f6ISfQ8uQYOpFAGB
 kFm2AZuk0BpwdIow0eadV6zJY3v43ceCHQnNQvn21ypT/0pbfb85g7ZP4Dgo8gEn26OS
 bxwv0IpLLsCf3JLM1+zlWtuFs1Ktn88nWVPQx9Fcq5m5INRZYlTqfd5ljOk2wwhWtNBj
 SeQLOORTxdmeTs0AMJupQODQ5pBrLgUcEnbauF+e1iOj7V5gATgnsAHbqX843vHDllGu
 PLd+EOpWOLuW9g/PyioCzW7gg8fyz32o/u8vN9UXVRet9ZqThNzlebCUyuDKGBSqAl5Q
 hFrw==
X-Gm-Message-State: AOAM5319pGmKwfvLOUUGp4mr08eocMynmgvFtHBqrgF3Bww5iGftP8j0
 jotvnsX6EQFjXR4U4ESLHao=
X-Google-Smtp-Source: ABdhPJx18kttbZszeC9sn/xiBvZQ6GO5acnFzqNWeXNeymfbXJ3mMOGR5EBVk3Szl2zG0Ov2DT5xXQ==
X-Received: by 2002:aa7:da46:: with SMTP id w6mr11545868eds.30.1617885593751; 
 Thu, 08 Apr 2021 05:39:53 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id w1sm9660802edt.89.2021.04.08.05.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Apr 2021 05:39:52 -0700 (PDT)
Date: Thu, 8 Apr 2021 14:40:26 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1 1/2] iommu/tegra-smmu: Defer attachment of display
 clients
Message-ID: <YG75urcXAb90Jj12@orome.fritz.box>
References: <20210328233256.20494-1-digetx@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20210328233256.20494-1-digetx@gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
 Will Deacon <will@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: multipart/mixed; boundary="===============0927879763253738586=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0927879763253738586==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WuhvTUWuu4INKIyN"
Content-Disposition: inline


--WuhvTUWuu4INKIyN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 29, 2021 at 02:32:55AM +0300, Dmitry Osipenko wrote:
> All consumer-grade Android and Chromebook devices show a splash screen
> on boot and then display is left enabled when kernel is booted. This
> behaviour is unacceptable in a case of implicit IOMMU domains to which
> devices are attached during kernel boot since devices, like display
> controller, may perform DMA at that time. We can work around this problem
> by deferring the enable of SMMU translation for a specific devices,
> like a display controller, until the first IOMMU mapping is created,
> which works good enough in practice because by that time h/w is already
> stopped.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-smmu.c | 71 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)

In general I do see why we would want to enable this. However, I think
this is a bad idea because it's going to proliferate the bad practice of
not describing things properly in device tree.

Whatever happened to the idea of creating identity mappings based on the
obscure tegra_fb_mem (or whatever it was called) command-line option? Is
that command-line not universally passed to the kernel from bootloaders
that initialize display?

That idealistic objection aside, this seems a bit over-engineered for
the hack that it is. See below.

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 602aab98c079..af1e4b5adb27 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -60,6 +60,8 @@ struct tegra_smmu_as {
>  	dma_addr_t pd_dma;
>  	unsigned id;
>  	u32 attr;
> +	bool display_attached[2];
> +	bool attached_devices_need_sync;
>  };
> =20
>  static struct tegra_smmu_as *to_smmu_as(struct iommu_domain *dom)
> @@ -78,6 +80,10 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu, =
unsigned long offset)
>  	return readl(smmu->regs + offset);
>  }
> =20
> +/* all Tegra SoCs use the same group IDs for displays */
> +#define SMMU_SWGROUP_DC		1
> +#define SMMU_SWGROUP_DCB	2
> +
>  #define SMMU_CONFIG 0x010
>  #define  SMMU_CONFIG_ENABLE (1 << 0)
> =20
> @@ -253,6 +259,20 @@ static inline void smmu_flush(struct tegra_smmu *smm=
u)
>  	smmu_readl(smmu, SMMU_PTB_ASID);
>  }
> =20
> +static int smmu_swgroup_to_display_id(unsigned int swgroup)
> +{
> +	switch (swgroup) {
> +	case SMMU_SWGROUP_DC:
> +		return 0;
> +
> +	case SMMU_SWGROUP_DCB:
> +		return 1;
> +
> +	default:
> +		return -1;
> +	}
> +}
> +

Why do we need to have this two-level mapping? Do we even need to care
about the specific swgroups IDs? Can we not just simply check at attach
time if the client that's being attached is a display client and then
set atteched_devices_need_sync =3D true?

Thierry

--WuhvTUWuu4INKIyN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBu+bgACgkQ3SOs138+
s6GnYg//akmYGEEg0hZ/wfT4gktVzczuNNA1sjPxwj34gUrKsdRHuZWFr4gFlzqw
LE/ObmCAkAHO99WeD0cXPbf/Eulr2QWzlNK8DZ2/YcPJgBg7lpnPcVYhro0ujvUJ
voTVDRp1NnFLesP6CkfLskgsSKRRIJBMf/F4D6EPSKl1NO4fFcwBFvAVcI0cnJpT
BFeSH6CeBfXYZpsNOOi+4wEPmZ3YQ2ejZ+r9/RLHv+vkqYTqVcVx7g+HOxJIEFpo
J9ygKJ8WG9NKwaF4x/PXozyIWnxyFTjLe5Cxscn999SM3HUkolb9ncNTMleZE7hb
94secQ4GBGR7VJcJrkkwSka5LpfWWqnyHSy1MdsCj2dAEHJSc5ELWiir1UmysKX7
i3LDq8zAJAIqS1gKU58UIDNIqDmfJBeP9bcUGH34YxlUTnAepRsFxB9nX5s5A0Wm
9MskrIRl3TXhedTQXSd4F3ih/QLuL7V0pMhuYdBCHLgUa0Djn2LLO+MOg3yzluvk
0AfzPp10SDMw20YZhDOlDOQf5IXJQxKiYiJYUb56wOAkmDpkwx5rTmYiVkoN4JRq
9f5IuqI+5K9L5vDWjaL+J57E7WDrs1c6OoRC200h9gPZnjUBHxDdJPmDrPovFOUm
JL0+kPRZNlvkipYSaBP3HHeUtpb88R+MAVKnlANCaejpO7cuCTY=
=OZ9i
-----END PGP SIGNATURE-----

--WuhvTUWuu4INKIyN--

--===============0927879763253738586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0927879763253738586==--
