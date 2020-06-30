Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C14C433E2
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 21:55:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA7612074D
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 21:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcbnWKff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7612074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B8AE986BBD;
	Tue, 30 Jun 2020 21:55:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rhbYc9KXTIsQ; Tue, 30 Jun 2020 21:55:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5386686B82;
	Tue, 30 Jun 2020 21:55:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4035BC0865;
	Tue, 30 Jun 2020 21:55:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22148C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EE45123115
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:55:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cNjfdxWrpuvP for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 21:55:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 2552F230FE
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:55:27 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D4BBB2074D
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593554126;
 bh=9zUNEj5oN5SAHU+Io1r3um4tcIvwZ7eKxubOap/7K8I=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=HcbnWKffcoh0g1mVR4mah7XrymR6sWtyUcyXTdyAZ2ZOGS80GRRKGen65yA07olkT
 CgIrfwwzZXiQlM2RcQrhnQiKyBiG7uSHqfD1rYFWkn40U8PTNYlYDIYW1YbHpoJT7X
 qspNuUOOr/Yp4ETouPEo/I9sFxri83Ovv+AK53Ec=
Received: by mail-ot1-f43.google.com with SMTP id c25so2151957otf.7
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 14:55:26 -0700 (PDT)
X-Gm-Message-State: AOAM532PMWSq3VKe71rLW9E9VILXg2tPNAmPNYu5JZ1n0CpnFBxCUnaP
 gaK/KGlTwC32OMtDyeAV02HvCb7f8uDSCqIhcA==
X-Google-Smtp-Source: ABdhPJyyXxnAxH4wFWhtv/D22m3Q6cMFmZqY7qj0MphhN0JdR130l2+haUVcQhVV5W4bGOQJ2dvD35JH+WEsZ6nyYQ4=
X-Received: by 2002:a9d:3a36:: with SMTP id j51mr20268426otc.129.1593554126266; 
 Tue, 30 Jun 2020 14:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-9-lorenzo.pieralisi@arm.com>
In-Reply-To: <20200619082013.13661-9-lorenzo.pieralisi@arm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 30 Jun 2020 15:55:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLdq16MR8W96G9CfEcUytY+957Mm8PDXwBgkCk1=A_wAg@mail.gmail.com>
Message-ID: <CAL_JsqLdq16MR8W96G9CfEcUytY+957Mm8PDXwBgkCk1=A_wAg@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] dt-bindings: arm: fsl: Add msi-map device-tree
 binding for fsl-mc bus
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: devicetree@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 PCI <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Makarand Pawagi <makarand.pawagi@nxp.com>, linux-acpi@vger.kernel.org,
 Linux IOMMU <iommu@lists.linux-foundation.org>, Marc Zyngier <maz@kernel.org>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
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

On Fri, Jun 19, 2020 at 2:20 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> The existing bindings cannot be used to specify the relationship
> between fsl-mc devices and GIC ITSes.
> Add a generic binding for mapping fsl-mc devices to GIC ITSes, using
> msi-map property.
> In addition, deprecate msi-parent property which no longer makes sense
> now that we support translating the MSIs.
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  .../devicetree/bindings/misc/fsl,qoriq-mc.txt | 50 ++++++++++++++++---
>  1 file changed, 44 insertions(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
