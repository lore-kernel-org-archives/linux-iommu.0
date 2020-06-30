Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7CBC433E3
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 21:50:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96292077D
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 21:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WL8mIUlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96292077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 924F1863E0;
	Tue, 30 Jun 2020 21:50:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UnsBuHk9CnzC; Tue, 30 Jun 2020 21:50:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1FD2B863AC;
	Tue, 30 Jun 2020 21:50:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FCA9C0865;
	Tue, 30 Jun 2020 21:50:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA614C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:50:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9E9E6230FB
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:50:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id awNQFWgYrkCC for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 21:50:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 0BB70230F6
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:50:19 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A8E98207FF
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593553818;
 bh=ps1O6n5AnikolRhBCTihXbQMNSMQfOZXAH36HgCoRS4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=WL8mIUlvP8ZdPw97GTFDhLE9owK5PSRrzSYFoyrfrPy7s6zYlX4vGfNy0fqqs/2oh
 el9Aov4LRM2pzOeyBjVVPOwgDWzB2EipRzYWknIge+BAXW4Ump22ZlnusvWs75GUYZ
 7+yeYxD7tbCNEwxePoIMEH2LsV9pocliXL/hIIcE=
Received: by mail-oi1-f181.google.com with SMTP id k6so14871440oij.11
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 14:50:18 -0700 (PDT)
X-Gm-Message-State: AOAM5331LHJrXJ4N3LYMDvtpDNE0laguh4UQYg57qx7Qd//uBuLIfR44
 1py6f/KYEpPyvTKv9eITxrLgedWjfQgNHyEMtA==
X-Google-Smtp-Source: ABdhPJzCDnjeyS6viPAYkeruMzz+Xbix7X+IUVSkcFqPPKsJXUmSUC2CQjq4+pFIKX1D4r7LaJBSvTlLXTtZij02xWI=
X-Received: by 2002:aca:6004:: with SMTP id u4mr18457843oib.106.1593553817987; 
 Tue, 30 Jun 2020 14:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-8-lorenzo.pieralisi@arm.com>
In-Reply-To: <20200619082013.13661-8-lorenzo.pieralisi@arm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 30 Jun 2020 15:50:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK45W7i0jWum4_FL9+ZRzF8W-m2zzDTmJpRKwmyGDzAjw@mail.gmail.com>
Message-ID: <CAL_JsqK45W7i0jWum4_FL9+ZRzF8W-m2zzDTmJpRKwmyGDzAjw@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] of/device: Add input id to of_dma_configure()
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

On Fri, Jun 19, 2020 at 2:20 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> Devices sitting on proprietary busses have a device ID space that
> is owned by the respective bus and related firmware bindings. In order
> to let the generic OF layer handle the input translations to
> an IOMMU id, for such busses the current of_dma_configure() interface
> should be extended in order to allow the bus layer to provide the
> device input id parameter - that is retrieved/assigned in bus
> specific code and firmware.
>
> Augment of_dma_configure() to add an optional input_id parameter,
> leaving current functionality unchanged.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/bus/fsl-mc/fsl-mc-bus.c |  4 +-
>  drivers/iommu/of_iommu.c        | 81 ++++++++++++++++++---------------
>  drivers/of/device.c             |  8 ++--
>  include/linux/of_device.h       | 16 ++++++-
>  include/linux/of_iommu.h        |  6 ++-
>  5 files changed, 70 insertions(+), 45 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
