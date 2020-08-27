Return-Path: <SRS0=m4IM=CF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B28C433E3
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 15:45:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373982177B
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 15:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMPa8N1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373982177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 064B1884C1;
	Thu, 27 Aug 2020 15:45:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m-yDwnLrogXx; Thu, 27 Aug 2020 15:45:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 769F181B71;
	Thu, 27 Aug 2020 15:45:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BD4DC016F;
	Thu, 27 Aug 2020 15:45:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2B56C0051
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 15:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AAC1586AF2
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 15:45:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s0q6+fZuvmDD for <iommu@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 15:45:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9A90486866
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 15:45:06 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id c10so5342229edk.6
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=74Ao/c7oeFoBT1F8v8BlKUziYBzWC4YEYws/h439jKs=;
 b=AMPa8N1AoD9YB7fIeGgmF/cNowE7jTvmdnSlHkNXqWgTuHGj1LDyz6RY9dorKnL/fN
 Z30pyVOeUrs4fDWQn3hrs1dZvRxrbplQZbImRrNJNHdCgPH/5mhyGT43pJeH7xkrp6Sb
 MZBcScUrs/MJyLn42oxJRGaNJrvbJexbN1cPg2Cxkb3XtnP+LC3+ovtJFuj8hqptSUOv
 CcXCkksNHNjATY9ob/FlyIIO46cj2X4u3uwybNf4+PMBFfX+68NaraOwOxzF+DfICVCM
 VN25BNvOEthy10Y2DCDS0ilfaqRXmZ3ernBzLlAAUqcBNegk+XnORCZVVMope4D1TZQ+
 iXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=74Ao/c7oeFoBT1F8v8BlKUziYBzWC4YEYws/h439jKs=;
 b=PnwGVNYbLKyDhjaRw4AEm2/jS3k6C4NnXw7BO+z0obcIWI6ZvodKvve8XOytKGbykG
 uNkVa0GXtLTC8fGf1HvdVPBOfOJ8LzyRJqxlHXLB/dVDxmFJE3IjoanMB0pJC1bdklAB
 K+atR1EMvgxhpGfvYgie0Jprfhe+R6GzqltZyyARr55B97s/udYcMaRA0i9cwEgt5iaT
 vm3BYW3nr5dHA4HpXYkHvveYg3EEwlKuR5iRQM3hyIuUdjNTOCl9zitvp+n3a2OyPkIa
 m1hEOnFBbSGvwGqDXZdSOe3WqZ0YPWrfJuKovgPjkmf2F1Ik46EyIBlSMHmmneQo24Ta
 l49A==
X-Gm-Message-State: AOAM532iNsxZLiQ2c7u1NOzQgc2q+Eou7zS/rXbzUhhLlb/aENep23eR
 ZNDMGyAkxxaC9G/owEFSSN8=
X-Google-Smtp-Source: ABdhPJxRtAe6Y1ma+0338eCNyd9I0m6G1oP+UGM2tA/8xgx0U3OYLFtKYBAAwxNFg0VrZz+x/RmEmw==
X-Received: by 2002:a05:6402:3088:: with SMTP id
 de8mr20472098edb.88.1598543104973; 
 Thu, 27 Aug 2020 08:45:04 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id u4sm1804409edt.11.2020.08.27.08.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 08:45:03 -0700 (PDT)
Date: Thu, 27 Aug 2020 17:45:02 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 13/18] iommu/tegra: Add IOMMU_DOMAIN_DMA support
Message-ID: <20200827154502.GA1660457@ulmo>
References: <cover.1597931875.git.robin.murphy@arm.com>
 <cd11bc7851dbe46db6d14821a942678047331913.1597931876.git.robin.murphy@arm.com>
MIME-Version: 1.0
In-Reply-To: <cd11bc7851dbe46db6d14821a942678047331913.1597931876.git.robin.murphy@arm.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Cc: geert+renesas@glider.be, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, laurent.pinchart@ideasonboard.com,
 digetx@gmail.com, will@kernel.org, hch@lst.de,
 linux-samsung-soc@vger.kernel.org, magnus.damm@gmail.com,
 linux@armlinux.org.uk, jonathanh@nvidia.com, agross@kernel.org,
 kyungmin.park@samsung.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, inki.dae@samsung.com,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org, sw0312.kim@samsung.com,
 linux-kernel@vger.kernel.org, t-kristo@ti.com,
 iommu@lists.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============6936220530884252532=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6936220530884252532==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2020 at 04:08:32PM +0100, Robin Murphy wrote:
> Now that arch/arm is wired up for default domains and iommu-dma,
> implement the corresponding driver-side support for DMA domains.
>=20
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/tegra-smmu.c | 37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)

We can't do that yet because it will currently still break for use-cases
such as display where we don't properly set up identity mappings during
boot. The result is that the dma-iommu code will enable translations
before the driver gets a chance to set up any mappings and if the
display controller was left on by the bootloader, scanning out a splash
screen, this causes faults between the point where dma-iommu is being
set up for the display controller and where the display controller
starts mapping its own buffers (rather than the ones mapped by the
bootloader).

That said, I do have a series that I've been carrying around for longer
than I've wanted that does exactly this for Tegra SMMU and I'd prefer if
you could drop this particular change from your series so that I can
keep working on resolving the identity mapping issues first.

Thierry

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9H1PwACgkQ3SOs138+
s6GMrhAAqb0k0/ZQ/J5VIibNnM1oZSG1CTD/3tuwm94u1T1J++b71xlQpN0U7Fru
gJNX22olSrdpzdecS9LQ3Twqu4qgPzLazvenfBLxxrDuwS466j3hbbW8cG1Tlb/m
6lEbacziO0f91GP7ao5dAG0HIPZvIYfU1PIA/eOPnBcOlFVvWVfCnN6gOjPOSocz
20X/S1W6d5Jo7x2T0PtA0TFpD9BZVzjZA2q9XVzPSxkqLfEVMU00Yp/TnHySfWJ3
+sfRxeaUl5Ysjrtkd5YeFoIGlVctyKIKtGCIR60HU4bPlB4cdaVaaJBVkJAM7kQh
p+UGnGgl09/DyAe57qVaEWsbcXwHaxeveFmdjMHn9y0veGidzQPg0KtDUL2k7D3V
NXHKnets8HdkODT8PjTSbS3ELLEHf1GxsYAcR9aHvV1FLMl3c/8ZmMA1RZ5CIAbD
rmFaxQENmVHUev0lQnwlYP7Wwt2YyXc62L9UfyhrIkQjHmm/D+uIlPmjkr/YDreI
xndQ7H0OgVFKuc9nfSpnBOgIEeLDNr2AA59wzUxHikB+5MfDyxOk5TqnsjdcqSqr
b8257AC5ZWe79OOD0/hwDAlmSlx/hB3lO2kmm3BhLX+5tOTQv7vTSgr9BTppkZrD
dQHiT2TjMsiQyBhXhceazD0hhSAC3MSh1+TpgLDrBy2Sh96zUQ8=
=Dzgn
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

--===============6936220530884252532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6936220530884252532==--
