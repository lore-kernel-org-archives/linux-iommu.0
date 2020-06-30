Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137F7C433E2
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 21:51:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A762074D
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 21:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfOglyVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A762074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B57DF863E0;
	Tue, 30 Jun 2020 21:51:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7pe1PnoShnBv; Tue, 30 Jun 2020 21:51:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5BFEE863AC;
	Tue, 30 Jun 2020 21:51:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48A4AC0865;
	Tue, 30 Jun 2020 21:51:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3624C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:50:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E1F9988579
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:50:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 874-FUtOjIUM for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 21:50:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 711C48855C
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:50:58 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2C54320771
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593553858;
 bh=Y08yb1+85H5CsPhN8ZHhbI4ulSqWuc3rJJ7/ULdUJNM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=LfOglyVc53syQnH+ENGGMBJ43MMGwpXaAFiPzBQhdI/fJHlPjgPyT1ZYdY1WJehvq
 2eAP36M/GRNzPxR0NdnQqPx0pWf1+Qu8CDMaH2wi2Z/DcgIoowR0WVyxmfgkTRrZsO
 2msYeR93Pkd6ApEYizVCifZploGHdUvEZDRNlaeM=
Received: by mail-ot1-f43.google.com with SMTP id w17so11885964otl.4
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 14:50:58 -0700 (PDT)
X-Gm-Message-State: AOAM533skKnO54dTSOyGeSt1O2fFDPG8Wj61Ckw+Unu7gfsyxz8YIqhN
 M2EBRI2JkRZcdRyp6jzEf0YvPHjrCrkbb3O7OA==
X-Google-Smtp-Source: ABdhPJx7pnl9Svudsv4ydHbc2/CjlDVMFTLvVkn6po1+o39FpJpEk6/LM/iNmoDYoPrvmUEdQJboN67w9UvSKjOzwhQ=
X-Received: by 2002:a05:6830:3104:: with SMTP id
 b4mr20071478ots.192.1593553857583; 
 Tue, 30 Jun 2020 14:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-10-lorenzo.pieralisi@arm.com>
In-Reply-To: <20200619082013.13661-10-lorenzo.pieralisi@arm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 30 Jun 2020 15:50:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKEXOhmK6Mi1BK4UWwc=eZKNoAvfHU-K7DnMcW34fNFdw@mail.gmail.com>
Message-ID: <CAL_JsqKEXOhmK6Mi1BK4UWwc=eZKNoAvfHU-K7DnMcW34fNFdw@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] of/irq: make of_msi_map_get_device_domain() bus
 agnostic
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: devicetree@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Marc Zyngier <maz@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, PCI <linux-pci@vger.kernel.org>,
 Makarand Pawagi <makarand.pawagi@nxp.com>, linux-acpi@vger.kernel.org,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
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
> From: Diana Craciun <diana.craciun@oss.nxp.com>
>
> of_msi_map_get_device_domain() is PCI specific but it need not be and
> can be easily changed to be bus agnostic in order to be used by other
> busses by adding an IRQ domain bus token as an input parameter.
>
> Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>   # pci/msi.c
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/of/irq.c       | 8 +++++---
>  drivers/pci/msi.c      | 2 +-
>  include/linux/of_irq.h | 5 +++--
>  3 files changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
