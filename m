Return-Path: <SRS0=hOEw=KX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D11C47087
	for <iommu@archiver.kernel.org>; Fri, 28 May 2021 17:04:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBE516117A
	for <iommu@archiver.kernel.org>; Fri, 28 May 2021 17:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE516117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A6DC340265;
	Fri, 28 May 2021 17:04:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JweBhHhszAyv; Fri, 28 May 2021 17:04:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 61938400AE;
	Fri, 28 May 2021 17:04:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B129C000D;
	Fri, 28 May 2021 17:04:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 557D7C0001
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 17:04:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2F6DF83FE8
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 17:04:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DLnPy_zLFoCH for <iommu@lists.linux-foundation.org>;
 Fri, 28 May 2021 17:04:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9DF9C8421E
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 17:03:59 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id j9so5613935edt.6
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 10:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vQATZo+AZo4YlZU2F1YsWzh6lrZA5xtN0yUkcxgQjB0=;
 b=BYr+K+Nr36WmmfDScZnUlfK7sTAJZtKemw1pJ/mtrtl2v5/tAfPjczuIoU0iraIwWA
 t2A2/7pNO92Fik4NAZDBo4xu8R0AMrkCqypSw7uoWgehNvCcdYxpXBYZKHjgFG/PhBYO
 /fNWHcozCdeVVnly3t7XODxA7RLCfdPPnGV+KpN1hCM9/fXI24BwQ+vMb1owRVmNJDjq
 +K7sLll2egnECQFloecqqKplJa3uscANWEVV6+LUhMdv9jLHAjfwR8rzKCDZvtHk7tyG
 o0Vd9pu4fjXSVLntOmm2ayPnD0uY2+lkKuBiu3PfVUjDJCB0LsgnDpWDIWR1nCk6QWXI
 oUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vQATZo+AZo4YlZU2F1YsWzh6lrZA5xtN0yUkcxgQjB0=;
 b=hgTVJKSYCv7rRYFTL/iWFULFms9rcSpJDfJ4MdKlrlNa5KTMd/PTj/FVtZAsZJFUnk
 1ZdufD+vGFZnpUEgxwtfYDupEjWp0WV9ak4k844x5NnyLtuwLXZxUocT+YM0GDc/ndMs
 uBsdecAtdKKKRwnWy9ifQYE6Gl5/rzJ0d0nYiIWB16xYP9usLxqrGi/4V2OsTKAFlYkw
 WBG0hYQ89zgnlzcRA43I7fif8UMmAqceoLenOzn7zmzc4E4E6LMv2Wms8vUnbhjrLrBQ
 UPwrseqfQEh2DOF2lSHynHI4uBKVuzat9BvM0BRLxlv7m9nkosXoCQQ4oXADTLRr8Klp
 u2WQ==
X-Gm-Message-State: AOAM530NBaSmniyTDRMIjhu9SvhjyLDPD4pBwsUnQN8OhQopuELfIYju
 DUDnulhVGb51SuOkKbXwmLA=
X-Google-Smtp-Source: ABdhPJycpvmB9hvj5UhOb2wxYw+dia0+6YsgtT4XQ9JGvgKIKbT94ArxpuxjPIbVv1cFQLHbODVwWg==
X-Received: by 2002:a05:6402:40c:: with SMTP id
 q12mr10793692edv.0.1622221437848; 
 Fri, 28 May 2021 10:03:57 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id e25sm600142eja.15.2021.05.28.10.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 May 2021 10:03:56 -0700 (PDT)
Date: Fri, 28 May 2021 19:05:28 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 00/10] arm64: tegra: Prevent early SMMU faults
Message-ID: <YLEi2FonP568wYrE@orome.fritz.box>
References: <20210420172619.3782831-1-thierry.reding@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20210420172619.3782831-1-thierry.reding@gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Cc: iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============7685166724509397763=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7685166724509397763==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dbXO9L0VPFIC9kST"
Content-Disposition: inline


--dbXO9L0VPFIC9kST
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 20, 2021 at 07:26:09PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Hi,
>=20
> this is a set of patches that is the result of earlier discussions
> regarding early identity mappings that are needed to avoid SMMU faults
> during early boot.
>=20
> The goal here is to avoid early identity mappings altogether and instead
> postpone the need for the identity mappings to when devices are attached
> to the SMMU. This works by making the SMMU driver coordinate with the
> memory controller driver on when to start enforcing SMMU translations.
> This makes Tegra behave in a more standard way and pushes the code to
> deal with the Tegra-specific programming into the NVIDIA SMMU
> implementation.
>=20
> Compared to the original version of these patches, I've split the
> preparatory work into a separate patch series because it became very
> large and will be mostly uninteresting for this audience.
>=20
> Patch 1 provides a mechanism to program SID overrides at runtime. Patch
> 2 updates the ARM SMMU device tree bindings to include the Tegra186
> compatible string as suggested by Robin during review.
>=20
> Patches 3 and 4 create the fundamentals in the SMMU driver to support
> this and also make this functionality available on Tegra186. Patch 5
> hooks the ARM SMMU up to the memory controller so that the memory client
> stream ID overrides can be programmed at the right time.
>=20
> Patch 6 extends this mechanism to Tegra186 and patches 7-9 enable all of
> this through device tree updates. Patch 10 is included here to show how
> SMMU will be enabled for display controllers. However, it cannot be
> applied yet because the code to create identity mappings for potentially
> live framebuffers hasn't been merged yet.
>=20
> The end result is that various peripherals will have SMMU enabled, while
> the display controllers will keep using passthrough, as initially set up
> by firmware. Once the device tree bindings have been accepted and the
> SMMU driver has been updated to create identity mappings for the display
> controllers, they can be hooked up to the SMMU and the code in this
> series will automatically program the SID overrides to enable SMMU
> translations at the right time.
>=20
> Note that the series creates a compile time dependency between the
> memory controller and IOMMU trees. If it helps I can provide a branch
> for each tree, modelling the dependency, once the series has been
> reviewed.
>=20
> Changes in v2:
> - split off the preparatory work into a separate series (that needs to
>   be applied first)
> - address review comments by Robin
>=20
> Thierry
>=20
> Thierry Reding (10):
>   memory: tegra: Implement SID override programming
>   dt-bindings: arm-smmu: Add Tegra186 compatible string
>   iommu/arm-smmu: Implement ->probe_finalize()
>   iommu/arm-smmu: tegra: Detect number of instances at runtime
>   iommu/arm-smmu: tegra: Implement SID override programming
>   iommu/arm-smmu: Use Tegra implementation on Tegra186
>   arm64: tegra: Use correct compatible string for Tegra186 SMMU
>   arm64: tegra: Hook up memory controller to SMMU on Tegra186
>   arm64: tegra: Enable SMMU support on Tegra194
>   arm64: tegra: Enable SMMU support for display on Tegra194
>=20
>  .../devicetree/bindings/iommu/arm,smmu.yaml   |  11 +-
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi      |   4 +-
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi      | 166 ++++++++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu-impl.c    |   3 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c  |  90 ++++++++--
>  drivers/iommu/arm/arm-smmu/arm-smmu.c         |  13 ++
>  drivers/iommu/arm/arm-smmu/arm-smmu.h         |   1 +
>  drivers/memory/tegra/mc.c                     |   9 +
>  drivers/memory/tegra/tegra186.c               |  72 ++++++++
>  include/soc/tegra/mc.h                        |   3 +
>  10 files changed, 349 insertions(+), 23 deletions(-)

Will, Robin,

do you have any more comments on the ARM SMMU bits of this series? If
not, can you guys provide an Acked-by so that Krzysztof can pick this
(modulo the DT patches) up into the memory-controller tree for v5.14?

I'll send out a v3 with the bisectibilitiy fix that Krishna pointed
out.

Thanks,
Thierry

--dbXO9L0VPFIC9kST
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmCxItYACgkQ3SOs138+
s6EDOBAAwOiGOvTRsOL0/TG+ekj2Qy8EtKdkYVeeHYkYzILZEbzntRj67AJ3MyWc
Qz+08dicUEwFlehcUGCX1iltXX61eTLLxWATt14ogx2QWJMQ8MLAqbEifYpm1Q3g
YqO7p/7l6y0F7Ah//pbROLvhHdQfIjbzypfpyzVRV4eyo8MVjttvOVymxYyekIHS
5WT0lHXOxmOZBemH6bK66tdIceIZ/TEGSy6sI9a7fo1KSJRC8UyAvlUb2eG2WIgI
KbsIunQUbT7jZx0bLTGVD5xJpcuZURgm+KkN0Y1cfRPP3XVlHWsotPH8O2G1Vqbb
Ul5aQYHunYKOXRq4YxhtpTWCmg38ZsNjT941VvVqpZlUHHnHdPAIoV+e6B5Z/ZMk
tVmWhG91uoGOiCp/KJZ+kc8E7TxkpYtw+HzdW1nQEVhlCJ6Lcjjp7vQdmuWb54/l
5/ql3ep8u2Ycj0SBcuUMsfCZPoJwvysnlY5DswqHI1i5UslQ8FPBxH3pkNyERKZp
b/pmkMN+RjKezyD6Y6LULATQG6Dif5Hrb7uIXOcMnhcDuFhb11Vf7MuXQwe4K+Ok
MTqVgNWNo0kIMDNMZXraN3+k24R0MFBBOoLAY/bMeNDxXknCpqxWky6ouQbRalf+
nc3IEDIy7U/mgb4HvI+25P1WIArtLpA9ZKbhUYmahdMlbkn77ww=
=bqed
-----END PGP SIGNATURE-----

--dbXO9L0VPFIC9kST--

--===============7685166724509397763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7685166724509397763==--
