Return-Path: <SRS0=KoUT=IC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1106C433DB
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 01:28:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A8246517E
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 01:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8246517E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE570842EF;
	Thu,  4 Mar 2021 01:28:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KkEy4-Fn4_wA; Thu,  4 Mar 2021 01:28:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5EB6842F0;
	Thu,  4 Mar 2021 01:28:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 874A2C000A;
	Thu,  4 Mar 2021 01:28:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA2BFC0001
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 01:28:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C240740197
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 01:28:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 35pSm_hyl9Lo for <iommu@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 01:28:00 +0000 (UTC)
X-Greylist: delayed 05:05:28 by SQLgrey-1.8.0
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ED1584017D
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 01:27:59 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id g3so32578871edb.11
 for <iommu@lists.linux-foundation.org>; Wed, 03 Mar 2021 17:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=eYt6ZSK+EgInFtZhuqC1D7JLS9QReq7n15THZCTsgVk=;
 b=So6UcJhCtr+TDGsTKMYMGcEgIvQ8qXS4pXDKMPVBvrdP/soN6tyXdmr6H1WwEx5bx2
 gDPW3JGvrUYYsRYHxDlhwWpKL2xFRD85s4z/RnPDTafKD/rMB2Wtyu+Ax4GjZXWLjoAD
 ahEgKEfGQEmNtYLcB5l8ewTYob5tz0S3ywVva2YE/+AJGyetg4W5IyzC5FJfje/q0pLK
 tPCm8dcSDOG5WCSVIlcSEfK0NC+XXJX5H4nMp72gNHNrEEro7BEIVgQ8x52+L0xypZXF
 vKDz+0zzeUhqZwMeVl8EkICSriB8JJ+AWWbmnl6vN0PT15NQIRJGiiGwsxJ+0jTH3w3Z
 XJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eYt6ZSK+EgInFtZhuqC1D7JLS9QReq7n15THZCTsgVk=;
 b=QuAqF8Q+A9YqnBHIASZr8mslJ9uWaRZVckub71nBBRd1EjQiAEkm8ktuVMzXKi1QdU
 KxGI1t2pJIH0cescP6vz1m+VzcJ2ItVR9GjTwgR3wlPQ02QUozSEI6bItg/t8F/w8Mvx
 dRitJpZFMsMtzsoSlvRiN+OH4wsecze/jOKKpxk4tljNc4qjlS2eykh9EGzSrd0bPeMH
 v0d30XXOApxx1CfY50+/g+rmi0XswkXK7p5yBYB59PSazAIfz95fpcAFx/OFbkNCfWAf
 DFIAKkz5SHp8nO+HpqaCbkPadbg0NI2s4y8sO14yY5zl33s/yribujvbgKX6gPTl/1Sn
 /ggw==
X-Gm-Message-State: AOAM533BDO0ey52YPo805/pj8CmOua2Q6U+7WO3mek8exh8j+kpqws8K
 tdGPTdRkz98GaHi7t/soCeS+mX5gSgo=
X-Google-Smtp-Source: ABdhPJxHDJsAroLvERXU4YkzIwdRIoOC7p/qdk/y2QIvgCLRbM4GrW5br5tfym/QqGE47oBEkp/Dbw==
X-Received: by 2002:adf:e38a:: with SMTP id e10mr16973744wrm.37.1614795963156; 
 Wed, 03 Mar 2021 10:26:03 -0800 (PST)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id o11sm13549883wrq.74.2021.03.03.10.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Mar 2021 10:26:01 -0800 (PST)
Date: Wed, 3 Mar 2021 19:26:00 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] iommu/tegra-smmu: Fix mc errors on tegra124-nyan
Message-ID: <YD/UuLSeVTLMh6HG@ulmo.localdomain>
References: <20210218220702.1962-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20210218220702.1962-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Cc: guillaume.tucker@collabora.com, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org, digetx@gmail.com,
 will@kernel.org, linux-kernel@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============9020429007341068937=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============9020429007341068937==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4ou0ZJPXLgmnnIia"
Content-Disposition: inline


--4ou0ZJPXLgmnnIia
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 18, 2021 at 02:07:02PM -0800, Nicolin Chen wrote:
> Commit 25938c73cd79 ("iommu/tegra-smmu: Rework tegra_smmu_probe_device()")
> removed certain hack in the tegra_smmu_probe() by relying on IOMMU core to
> of_xlate SMMU's SID per device, so as to get rid of tegra_smmu_find() and
> tegra_smmu_configure() that are typically done in the IOMMU core also.
>=20
> This approach works for both existing devices that have DT nodes and other
> devices (like PCI device) that don't exist in DT, on Tegra210 and Tegra3
> upon testing. However, Page Fault errors are reported on tegra124-Nyan:
>=20
>   tegra-mc 70019000.memory-controller: display0a: read @0xfe056b40:
> 	 EMEM address decode error (SMMU translation error [--S])
>   tegra-mc 70019000.memory-controller: display0a: read @0xfe056b40:
> 	 Page fault (SMMU translation error [--S])
>=20
> After debugging, I found that the mentioned commit changed some function
> callback sequence of tegra-smmu's, resulting in enabling SMMU for display
> client before display driver gets initialized. I couldn't reproduce exact
> same issue on Tegra210 as Tegra124 (arm-32) differs at arch-level code.
>=20
> Actually this Page Fault is a known issue, as on most of Tegra platforms,
> display gets enabled by the bootloader for the splash screen feature, so
> it keeps filling the framebuffer memory. A proper fix to this issue is to
> 1:1 linear map the framebuffer memory to IOVA space so the SMMU will have
> the same address as the physical address in its page table. Yet, Thierry
> has been working on the solution above for a year, and it hasn't merged.
>=20
> Therefore, let's partially revert the mentioned commit to fix the errors.
>=20
> The reason why we do a partial revert here is that we can still set priv
> in ->of_xlate() callback for PCI devices. Meanwhile, devices existing in
> DT, like display, will go through tegra_smmu_configure() at the stage of
> bus_set_iommu() when SMMU gets probed(), as what it did before we merged
> the mentioned commit.
>=20
> Once we have the linear map solution for framebuffer memory, this change
> can be cleaned away.
>=20
> [Big thank to Guillaume who reported and helped debugging/verification]
>=20
> Fixes: 25938c73cd79 ("iommu/tegra-smmu: Rework tegra_smmu_probe_device()")
> Reported-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>=20
> Guillaume, would you please give a "Tested-by" to this change? Thanks!
>=20
>  drivers/iommu/tegra-smmu.c | 72 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 71 insertions(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--4ou0ZJPXLgmnnIia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmA/1LQACgkQ3SOs138+
s6HVGg//XRVrMcKyH+kjocZCLqbtvtkJkZW4MT4aOg4HGwc1axFrRTMlHVOWPn3j
dcMwCbAVNb/ClbkvxsZ5bxbK5/ZnSR2ZQGV9srukln9RWKO+255jlM925qVJ5Yzd
UNweJ9ToVMeNfkSeU9VK8JnpnJDF/NLxevydeX9UJQVieclLKhjW6dcASIc/sRGI
X4E8dqtO/sbj5712Qj0A2p7VnrYQ+02tyipiXI3p4KSRiMWArCcLqLs0F9ccv47+
mEsHB7P8+nstkiatna0jC4xzdBeIznxVwkIYYr+TcHLCrycljQh56giXPN0TnQn0
7xplMX5OHAHFhJyqXgOw4ZeuXFuc5uOjNFcA6fGJ5uCyOhpQMZhoFQRFxkGy8edc
bNoLiHjFO2HyS7YXdkzscj15xTS0wq/aKLFMo7I9AJedHnNnfzHEhzcpQmg1eIFl
svEAap+gQFG1X0Bc5DC8puXRWwkHwrr/xCcfDp53dQirjIJoOQDo7usVtQRWLi/0
rNWU5r/HQ04pqJZcdEVpT+VmzwcOZoLcQCHjDW2ohllPq8hZGfldaW9OZzXaveKe
UMikX5lx3ANPkTKTxxq7rfsbzq0UIfII4o391Vdzxk83YIvDbENrfx3tl2LGxJsT
4O00KcDGgdgfy8oxcy22+TbhdeSdC0MDo/CRLGzPLnwxdMn1s2c=
=66rd
-----END PGP SIGNATURE-----

--4ou0ZJPXLgmnnIia--

--===============9020429007341068937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============9020429007341068937==--
