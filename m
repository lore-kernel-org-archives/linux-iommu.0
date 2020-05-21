Return-Path: <SRS0=DnMm=7D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06067C433E0
	for <iommu@archiver.kernel.org>; Thu, 21 May 2020 23:11:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE63207F9
	for <iommu@archiver.kernel.org>; Thu, 21 May 2020 23:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="b50y5T4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE63207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9EA5E894B8;
	Thu, 21 May 2020 23:11:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0d+6MzIkYss9; Thu, 21 May 2020 23:11:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F1C3489493;
	Thu, 21 May 2020 23:11:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3F55C088B;
	Thu, 21 May 2020 23:11:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DFBAC0176
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 23:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7983389494
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 23:11:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zw1Ozyo4P4Wb for <iommu@lists.linux-foundation.org>;
 Thu, 21 May 2020 23:11:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D604389493
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 23:11:01 +0000 (UTC)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BD01C20884
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 23:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590102660;
 bh=wnVJsMcdVukL+7XmCXsH+1qcmY1rqDsn5grM0oKG+Vg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=b50y5T4/xOs+s5TZp/SGmlaI5l765m7i1wx22uNGLyBKIBzdh+5hpkyDWuuwfftfw
 ZMVAwk/zlo8GumNufVyNpb4usNPG//XsYyyQXbgxHwdmLqfTUQP35eVkbpBQ8lm1Eo
 mVRPCZQ5iXEuAXf0diEbUoBLJVSOffrww0tgviDU=
Received: by mail-oi1-f179.google.com with SMTP id o24so7759265oic.0
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 16:11:00 -0700 (PDT)
X-Gm-Message-State: AOAM533HWzPVaz11w81U4jiRChzjUGm6XzVXct5zgOYNNhl5XrEeRfbP
 CVbqBZMZgQILtX7lJSpgj1W1wMP7lz8glKJZlA==
X-Google-Smtp-Source: ABdhPJyY199Y85sucuTO5/BYg8SBRhUI/9X/7ZmJwp5eotefflL8Rgk71V55e2sEv0jRnuhZ/fAClQc1SjSy9dm5eSY=
X-Received: by 2002:aca:f084:: with SMTP id o126mr744784oih.106.1590102659988; 
 Thu, 21 May 2020 16:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200521130008.8266-10-lorenzo.pieralisi@arm.com>
In-Reply-To: <20200521130008.8266-10-lorenzo.pieralisi@arm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 21 May 2020 17:10:49 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+h18gH2D3B-OZku6ACCgonPUJcUnrN8a5=jApsXHdB5Q@mail.gmail.com>
Message-ID: <CAL_Jsq+h18gH2D3B-OZku6ACCgonPUJcUnrN8a5=jApsXHdB5Q@mail.gmail.com>
Subject: Re: [PATCH 09/12] dt-bindings: arm: fsl: Add msi-map device-tree
 binding for fsl-mc bus
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Diana Craciun <diana.craciun@oss.nxp.com>,
 PCI <linux-pci@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Makarand Pawagi <makarand.pawagi@nxp.com>, linux-acpi@vger.kernel.org,
 Linux IOMMU <iommu@lists.linux-foundation.org>, Marc Zyngier <maz@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, May 21, 2020 at 7:00 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> The existing bindings cannot be used to specify the relationship
> between fsl-mc devices and GIC ITSes.
>
> Add a generic binding for mapping fsl-mc devices to GIC ITSes, using
> msi-map property.
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  .../devicetree/bindings/misc/fsl,qoriq-mc.txt | 30 +++++++++++++++++--
>  1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> index 9134e9bcca56..b0813b2d0493 100644
> --- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> +++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> @@ -18,9 +18,9 @@ same hardware "isolation context" and a 10-bit value called an ICID
>  the requester.
>
>  The generic 'iommus' property is insufficient to describe the relationship
> -between ICIDs and IOMMUs, so an iommu-map property is used to define
> -the set of possible ICIDs under a root DPRC and how they map to
> -an IOMMU.
> +between ICIDs and IOMMUs, so the iommu-map and msi-map properties are used
> +to define the set of possible ICIDs under a root DPRC and how they map to
> +an IOMMU and a GIC ITS respectively.
>
>  For generic IOMMU bindings, see
>  Documentation/devicetree/bindings/iommu/iommu.txt.
> @@ -28,6 +28,9 @@ Documentation/devicetree/bindings/iommu/iommu.txt.
>  For arm-smmu binding, see:
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml.
>
> +For GICv3 and GIC ITS bindings, see:
> +Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml.
> +
>  Required properties:
>
>      - compatible
> @@ -119,6 +122,15 @@ Optional properties:
>    associated with the listed IOMMU, with the iommu-specifier
>    (i - icid-base + iommu-base).
>
> +- msi-map: Maps an ICID to a GIC ITS and associated iommu-specifier
> +  data.
> +
> +  The property is an arbitrary number of tuples of
> +  (icid-base,iommu,iommu-base,length).

I'm confused because the example has GIC ITS phandle, not an IOMMU.

What is an iommu-base?

> +
> +  Any ICID in the interval [icid-base, icid-base + length) is
> +  associated with the listed GIC ITS, with the iommu-specifier
> +  (i - icid-base + iommu-base).
>  Example:
>
>          smmu: iommu@5000000 {
> @@ -128,6 +140,16 @@ Example:
>                 ...
>          };
>
> +       gic: interrupt-controller@6000000 {
> +               compatible = "arm,gic-v3";
> +               ...
> +               its: gic-its@6020000 {
> +                       compatible = "arm,gic-v3-its";
> +                       msi-controller;
> +                       ...
> +               };
> +       };
> +
>          fsl_mc: fsl-mc@80c000000 {
>                  compatible = "fsl,qoriq-mc";
>                  reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
> @@ -135,6 +157,8 @@ Example:
>                  msi-parent = <&its>;
>                  /* define map for ICIDs 23-64 */
>                  iommu-map = <23 &smmu 23 41>;
> +                /* define msi map for ICIDs 23-64 */
> +                msi-map = <23 &its 23 41>;

Seeing 23 twice is odd. The numbers to the right of 'its' should be an
ITS number space.

>                  #address-cells = <3>;
>                  #size-cells = <1>;
>
> --
> 2.26.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
