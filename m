Return-Path: <SRS0=ytjs=7R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4427BC433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 14:27:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FFB7206E6
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 14:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFB7206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D820A86F85;
	Thu,  4 Jun 2020 14:27:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A76go8JHTfwm; Thu,  4 Jun 2020 14:27:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B1A0886F22;
	Thu,  4 Jun 2020 14:27:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A50C5C0888;
	Thu,  4 Jun 2020 14:27:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91D2CC016E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 14:27:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7C23788805
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 14:27:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1CJBA1d6Z-iK for <iommu@lists.linux-foundation.org>;
 Thu,  4 Jun 2020 14:27:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7D78888804
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 14:27:12 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC7EA2B;
 Thu,  4 Jun 2020 07:27:11 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com
 [10.1.196.255])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 384F03F305;
 Thu,  4 Jun 2020 07:27:09 -0700 (PDT)
Date: Thu, 4 Jun 2020 15:27:03 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 06/12] of/iommu: Make of_map_rid() PCI agnostic
Message-ID: <20200604142703.GA476@e121166-lin.cambridge.arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200521130008.8266-7-lorenzo.pieralisi@arm.com>
 <CAL_JsqK5aiEMAZpqgTmrOq=HPRSFEoQWJrpR2YA0hziEtLMwrg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_JsqK5aiEMAZpqgTmrOq=HPRSFEoQWJrpR2YA0hziEtLMwrg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: devicetree@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Marc Zyngier <maz@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Makarand Pawagi <makarand.pawagi@nxp.com>, linux-acpi@vger.kernel.org,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
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

On Thu, May 21, 2020 at 04:47:19PM -0600, Rob Herring wrote:
> On Thu, May 21, 2020 at 7:00 AM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > There is nothing PCI specific (other than the RID - requester ID)
> > in the of_map_rid() implementation, so the same function can be
> > reused for input/output IDs mapping for other busses just as well.
> >
> > Rename the RID instances/names to a generic "id" tag and provide
> > an of_map_rid() wrapper function so that we can leave the existing
> > (and legitimate) callers unchanged.
> 
> It's not all that clear to a casual observer that RID is a PCI thing,
> so I don't know that keeping it buys much. And there's only 3 callers.

Yes I agree - I think we can remove the _rid interface.

> > No functionality change intended.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/iommu/of_iommu.c |  2 +-
> >  drivers/of/base.c        | 42 ++++++++++++++++++++--------------------
> >  include/linux/of.h       | 17 +++++++++++++++-
> >  3 files changed, 38 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> > index 20738aacac89..ad96b87137d6 100644
> > --- a/drivers/iommu/of_iommu.c
> > +++ b/drivers/iommu/of_iommu.c
> > @@ -145,7 +145,7 @@ static int of_fsl_mc_iommu_init(struct fsl_mc_device *mc_dev,
> >         struct of_phandle_args iommu_spec = { .args_count = 1 };
> >         int err;
> >
> > -       err = of_map_rid(master_np, mc_dev->icid, "iommu-map",
> > +       err = of_map_id(master_np, mc_dev->icid, "iommu-map",
> 
> I'm not sure this is an improvement because I'd refactor this function
> and of_pci_iommu_init() into a single function:
> 
> of_bus_iommu_init(struct device *dev, struct device_node *np, u32 id)
> 
> Then of_pci_iommu_init() becomes:
> 
> of_pci_iommu_init()
> {
>   return of_bus_iommu_init(info->dev, info->np, alias);
> }
> 
> And replace of_fsl_mc_iommu_init call with:
> err = of_bus_iommu_init(dev, master_np, to_fsl_mc_device(dev)->icid);

I will follow up on this on patch 7.

> >                          "iommu-map-mask", &iommu_spec.np,
> >                          iommu_spec.args);
> >         if (err)
> > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > index ae03b1218b06..e000e17bd602 100644
> > --- a/drivers/of/base.c
> > +++ b/drivers/of/base.c
> > @@ -2201,15 +2201,15 @@ int of_find_last_cache_level(unsigned int cpu)
> >  }
> >
> >  /**
> > - * of_map_rid - Translate a requester ID through a downstream mapping.
> > + * of_map_id - Translate a requester ID through a downstream mapping.
> 
> Still a requester ID?

Fixed, thanks.

Lorenzo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
