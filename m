Return-Path: <SRS0=4l6Q=7E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D13C433E2
	for <iommu@archiver.kernel.org>; Fri, 22 May 2020 14:03:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D9E121475
	for <iommu@archiver.kernel.org>; Fri, 22 May 2020 14:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyuLw6VB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9E121475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D045388753;
	Fri, 22 May 2020 14:03:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0VyJEVOxW2FB; Fri, 22 May 2020 14:03:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 518FD88735;
	Fri, 22 May 2020 14:03:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CA90C088B;
	Fri, 22 May 2020 14:03:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20C8CC0176
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 14:03:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 14F9F87949
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 14:03:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AdZ3Gs3d5jVD for <iommu@lists.linux-foundation.org>;
 Fri, 22 May 2020 14:03:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EF822877FD
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 14:03:06 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A89CE21475
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 14:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590156186;
 bh=PC+uay0MBJgZb1HrY/dFqAwSM1Ui19cXenE7vxJsLa0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=TyuLw6VByNbf3Akwv2nKdLOf67tVruG4eCMaraUTwL3hqUcblq+NKU7TLQq2/q6P7
 Urxcqn76R9RqZme2DhUwavYqB037CsQzmbczJvuF46pziO3YVMZzasuU6xNRwmBL7f
 vNme/VqvGA771XxXTyZk9gWeSPQE+zPAaWiItqP8=
Received: by mail-oi1-f175.google.com with SMTP id x23so9388521oic.3
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 07:03:06 -0700 (PDT)
X-Gm-Message-State: AOAM5327uzggaho+AiLVi1JweXhPti1tshqy+sRc7IGgBmnbGhqynqB0
 ZeU4GFAu41Jtdp9t5uuQQGfLbkISEAoq6SGO2Q==
X-Google-Smtp-Source: ABdhPJz4NPfC/e/rYdjknKeQRurJR6ul989Dp2cHUGc/fsPE+++fhkbh8JKvoUs1QPU5OvCiTH3oazU9MRQGNkQBnro=
X-Received: by 2002:aca:f084:: with SMTP id o126mr2798405oih.106.1590156185879; 
 Fri, 22 May 2020 07:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200521130008.8266-10-lorenzo.pieralisi@arm.com>
 <CAL_Jsq+h18gH2D3B-OZku6ACCgonPUJcUnrN8a5=jApsXHdB5Q@mail.gmail.com>
 <abca6ecb-5d93-832f-ff7c-de53bb6203f3@arm.com>
In-Reply-To: <abca6ecb-5d93-832f-ff7c-de53bb6203f3@arm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 22 May 2020 08:02:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKVyqc9QZhGD7FeNLpJ=x3oLzmY0zADBa+6ZaE46dN39w@mail.gmail.com>
Message-ID: <CAL_JsqKVyqc9QZhGD7FeNLpJ=x3oLzmY0zADBa+6ZaE46dN39w@mail.gmail.com>
Subject: Re: [PATCH 09/12] dt-bindings: arm: fsl: Add msi-map device-tree
 binding for fsl-mc bus
To: Robin Murphy <robin.murphy@arm.com>
Cc: devicetree@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, PCI <linux-pci@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux IOMMU <iommu@lists.linux-foundation.org>, linux-acpi@vger.kernel.org,
 Makarand Pawagi <makarand.pawagi@nxp.com>, Marc Zyngier <maz@kernel.org>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Will Deacon <will@kernel.org>,
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

On Fri, May 22, 2020 at 3:42 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-05-22 00:10, Rob Herring wrote:
> > On Thu, May 21, 2020 at 7:00 AM Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> >>
> >> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>
> >> The existing bindings cannot be used to specify the relationship
> >> between fsl-mc devices and GIC ITSes.
> >>
> >> Add a generic binding for mapping fsl-mc devices to GIC ITSes, using
> >> msi-map property.
> >>
> >> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> ---
> >>   .../devicetree/bindings/misc/fsl,qoriq-mc.txt | 30 +++++++++++++++++--
> >>   1 file changed, 27 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> >> index 9134e9bcca56..b0813b2d0493 100644
> >> --- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> >> +++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> >> @@ -18,9 +18,9 @@ same hardware "isolation context" and a 10-bit value called an ICID
> >>   the requester.
> >>
> >>   The generic 'iommus' property is insufficient to describe the relationship
> >> -between ICIDs and IOMMUs, so an iommu-map property is used to define
> >> -the set of possible ICIDs under a root DPRC and how they map to
> >> -an IOMMU.
> >> +between ICIDs and IOMMUs, so the iommu-map and msi-map properties are used
> >> +to define the set of possible ICIDs under a root DPRC and how they map to
> >> +an IOMMU and a GIC ITS respectively.
> >>
> >>   For generic IOMMU bindings, see
> >>   Documentation/devicetree/bindings/iommu/iommu.txt.
> >> @@ -28,6 +28,9 @@ Documentation/devicetree/bindings/iommu/iommu.txt.
> >>   For arm-smmu binding, see:
> >>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml.
> >>
> >> +For GICv3 and GIC ITS bindings, see:
> >> +Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml.
> >> +
> >>   Required properties:
> >>
> >>       - compatible
> >> @@ -119,6 +122,15 @@ Optional properties:
> >>     associated with the listed IOMMU, with the iommu-specifier
> >>     (i - icid-base + iommu-base).
> >>
> >> +- msi-map: Maps an ICID to a GIC ITS and associated iommu-specifier
> >> +  data.
> >> +
> >> +  The property is an arbitrary number of tuples of
> >> +  (icid-base,iommu,iommu-base,length).
> >
> > I'm confused because the example has GIC ITS phandle, not an IOMMU.
> >
> > What is an iommu-base?
>
> Right, I was already halfway through writing a reply to say that all the
> copy-pasted "iommu" references here should be using the terminology from
> the pci-msi.txt binding instead.
>
> >> +
> >> +  Any ICID in the interval [icid-base, icid-base + length) is
> >> +  associated with the listed GIC ITS, with the iommu-specifier
> >> +  (i - icid-base + iommu-base).
> >>   Example:
> >>
> >>           smmu: iommu@5000000 {
> >> @@ -128,6 +140,16 @@ Example:
> >>                  ...
> >>           };
> >>
> >> +       gic: interrupt-controller@6000000 {
> >> +               compatible = "arm,gic-v3";
> >> +               ...
> >> +               its: gic-its@6020000 {
> >> +                       compatible = "arm,gic-v3-its";
> >> +                       msi-controller;
> >> +                       ...
> >> +               };
> >> +       };
> >> +
> >>           fsl_mc: fsl-mc@80c000000 {
> >>                   compatible = "fsl,qoriq-mc";
> >>                   reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
> >> @@ -135,6 +157,8 @@ Example:
> >>                   msi-parent = <&its>;
>
> Side note: is it right to keep msi-parent here? It rather implies that
> the MC itself has a 'native' Device ID rather than an ICID, which I
> believe is not strictly true. Plus it's extra-confusing that it doesn't
> specify an ID either way, since that makes it look like the legacy PCI
> case that gets treated implicitly as an identity msi-map, which makes no
> sense at all to combine with an actual msi-map.

No, it doesn't make sense from a binding perspective.

>
> >>                   /* define map for ICIDs 23-64 */
> >>                   iommu-map = <23 &smmu 23 41>;
> >> +                /* define msi map for ICIDs 23-64 */
> >> +                msi-map = <23 &its 23 41>;
> >
> > Seeing 23 twice is odd. The numbers to the right of 'its' should be an
> > ITS number space.
>
> On about 99% of systems the values in the SMMU Stream ID and ITS Device
> ID spaces are going to be the same. Nobody's going to bother carrying
> *two* sets of sideband data across the interconnect if they don't have to ;)

I'm referring to the 23 on the left and right, not between the msi and
iommu. If the left and right are the same, then what are we remapping
exactly?

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
