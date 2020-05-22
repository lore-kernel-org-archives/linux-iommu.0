Return-Path: <SRS0=4l6Q=7E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD64C433E0
	for <iommu@archiver.kernel.org>; Fri, 22 May 2020 09:53:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDAA520738
	for <iommu@archiver.kernel.org>; Fri, 22 May 2020 09:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDAA520738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 90BEA88886;
	Fri, 22 May 2020 09:53:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uy+sWyc7oITg; Fri, 22 May 2020 09:53:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A595088707;
	Fri, 22 May 2020 09:53:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79A7DC088B;
	Fri, 22 May 2020 09:53:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C839C0176
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 09:53:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3A4108870A
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 09:53:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9IxUpLEBMSC0 for <iommu@lists.linux-foundation.org>;
 Fri, 22 May 2020 09:53:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3E27188707
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 09:53:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95F79D6E;
 Fri, 22 May 2020 02:53:10 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com
 [10.1.196.255])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCEDC3F305;
 Fri, 22 May 2020 02:53:07 -0700 (PDT)
Date: Fri, 22 May 2020 10:53:02 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Makarand Pawagi <makarand.pawagi@nxp.com>
Subject: Re: [PATCH 12/12] bus: fsl-mc: Add ACPI support for fsl-mc
Message-ID: <20200522095301.GA11785@e121166-lin.cambridge.arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200521130008.8266-13-lorenzo.pieralisi@arm.com>
 <3045acd5-0bcf-40c1-e65f-0b740200b2e0@nxp.com>
 <AM6PR04MB49847931D51AD92057043D92EBB40@AM6PR04MB4984.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AM6PR04MB49847931D51AD92057043D92EBB40@AM6PR04MB4984.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
 "Diana Madalina Craciun \(OSS\)" <diana.craciun@oss.nxp.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Fri, May 22, 2020 at 05:32:02AM +0000, Makarand Pawagi wrote:

[...]

> > Subject: Re: [PATCH 12/12] bus: fsl-mc: Add ACPI support for fsl-mc
> > 
> > Hi Lorenzo,
> > 
> > On 5/21/2020 4:00 PM, Lorenzo Pieralisi wrote:
> > > From: Diana Craciun <diana.craciun@oss.nxp.com>
> > >
> > > Add ACPI support in the fsl-mc driver. Driver parses MC DSDT table to
> > > extract memory and other resources.
> > >
> > > Interrupt (GIC ITS) information is extracted from the MADT table by
> > > drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c.
> > >
> > > IORT table is parsed to configure DMA.
> > >
> > > Signed-off-by: Makarand Pawagi <makarand.pawagi@nxp.com>
> > > Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
> > > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > > ---
> > 
> > The author of this patch should be Makarand. I think I accidentaly broke it when
> > we exchanged the patches. Very sorry about it.
> > 
>  
> Will you be able to correct this or should I post another patch?

I will update it.

Lorenzo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
