Return-Path: <SRS0=ytjs=7R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26979C433DF
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 15:08:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFB78206DC
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 15:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB78206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D092B86C82;
	Thu,  4 Jun 2020 15:08:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A7DIZOpRpCFF; Thu,  4 Jun 2020 15:08:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BCE5986C3B;
	Thu,  4 Jun 2020 15:08:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6419C0881;
	Thu,  4 Jun 2020 15:08:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4024AC016E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 15:08:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2D889888BD
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 15:08:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q7BCv3rElGoq for <iommu@lists.linux-foundation.org>;
 Thu,  4 Jun 2020 15:08:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 59BA0888BA
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 15:08:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE3BA1FB;
 Thu,  4 Jun 2020 08:08:35 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com
 [10.1.196.255])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 436823F305;
 Thu,  4 Jun 2020 08:08:33 -0700 (PDT)
Date: Thu, 4 Jun 2020 16:08:27 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 10/12] of/irq: Make of_msi_map_rid() PCI bus agnostic
Message-ID: <20200604150827.GA1232@e121166-lin.cambridge.arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200521130008.8266-11-lorenzo.pieralisi@arm.com>
 <CAL_JsqLTBxX_3KjiEqMfw0qMaTmj_DdPD3j-yMUvrvONPBSvjg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_JsqLTBxX_3KjiEqMfw0qMaTmj_DdPD3j-yMUvrvONPBSvjg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, PCI <linux-pci@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Hanjun Guo <guohanjun@huawei.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>, linux-acpi@vger.kernel.org,
 Makarand Pawagi <makarand.pawagi@nxp.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Will Deacon <will@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>
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

On Thu, May 21, 2020 at 05:17:27PM -0600, Rob Herring wrote:
> On Thu, May 21, 2020 at 7:00 AM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > There is nothing PCI bus specific in the of_msi_map_rid()
> > implementation other than the requester ID tag for the input
> > ID space. Rename requester ID to a more generic ID so that
> > the translation code can be used by all busses that require
> > input/output ID translations.
> >
> > Leave a wrapper function of_msi_map_rid() in place to keep
> > existing PCI code mapping requester ID syntactically unchanged.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/of/irq.c       | 28 ++++++++++++++--------------
> >  include/linux/of_irq.h | 14 ++++++++++++--
> >  2 files changed, 26 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> > index 48a40326984f..25d17b8a1a1a 100644
> > --- a/drivers/of/irq.c
> > +++ b/drivers/of/irq.c
> > @@ -576,43 +576,43 @@ void __init of_irq_init(const struct of_device_id *matches)
> >         }
> >  }
> >
> > -static u32 __of_msi_map_rid(struct device *dev, struct device_node **np,
> > -                           u32 rid_in)
> > +static u32 __of_msi_map_id(struct device *dev, struct device_node **np,
> > +                           u32 id_in)
> >  {
> >         struct device *parent_dev;
> > -       u32 rid_out = rid_in;
> > +       u32 id_out = id_in;
> >
> >         /*
> >          * Walk up the device parent links looking for one with a
> >          * "msi-map" property.
> >          */
> >         for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent)
> > -               if (!of_map_rid(parent_dev->of_node, rid_in, "msi-map",
> > -                               "msi-map-mask", np, &rid_out))
> > +               if (!of_map_id(parent_dev->of_node, id_in, "msi-map",
> > +                               "msi-map-mask", np, &id_out))
> >                         break;
> > -       return rid_out;
> > +       return id_out;
> >  }
> >
> >  /**
> > - * of_msi_map_rid - Map a MSI requester ID for a device.
> > + * of_msi_map_id - Map a MSI ID for a device.
> >   * @dev: device for which the mapping is to be done.
> >   * @msi_np: device node of the expected msi controller.
> > - * @rid_in: unmapped MSI requester ID for the device.
> > + * @id_in: unmapped MSI ID for the device.
> >   *
> >   * Walk up the device hierarchy looking for devices with a "msi-map"
> > - * property.  If found, apply the mapping to @rid_in.
> > + * property.  If found, apply the mapping to @id_in.
> >   *
> > - * Returns the mapped MSI requester ID.
> > + * Returns the mapped MSI ID.
> >   */
> > -u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in)
> > +u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in)
> >  {
> > -       return __of_msi_map_rid(dev, &msi_np, rid_in);
> > +       return __of_msi_map_id(dev, &msi_np, id_in);
> >  }
> >
> >  /**
> >   * of_msi_map_get_device_domain - Use msi-map to find the relevant MSI domain
> >   * @dev: device for which the mapping is to be done.
> > - * @rid: Requester ID for the device.
> > + * @id: Device ID.
> >   * @bus_token: Bus token
> >   *
> >   * Walk up the device hierarchy looking for devices with a "msi-map"
> > @@ -625,7 +625,7 @@ struct irq_domain *of_msi_map_get_device_domain(struct device *dev, u32 id,
> >  {
> >         struct device_node *np = NULL;
> >
> > -       __of_msi_map_rid(dev, &np, id);
> > +       __of_msi_map_id(dev, &np, id);
> >         return irq_find_matching_host(np, bus_token);
> >  }
> >
> > diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
> > index 7142a3722758..cf9cb1e545ce 100644
> > --- a/include/linux/of_irq.h
> > +++ b/include/linux/of_irq.h
> > @@ -55,7 +55,12 @@ extern struct irq_domain *of_msi_map_get_device_domain(struct device *dev,
> >                                                         u32 id,
> >                                                         u32 bus_token);
> >  extern void of_msi_configure(struct device *dev, struct device_node *np);
> > -u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in);
> > +u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in);
> > +static inline u32 of_msi_map_rid(struct device *dev,
> > +                                struct device_node *msi_np, u32 rid_in)
> > +{
> > +       return of_msi_map_id(dev, msi_np, rid_in);
> > +}
> >  #else
> >  static inline int of_irq_count(struct device_node *dev)
> >  {
> > @@ -93,10 +98,15 @@ static inline struct irq_domain *of_msi_map_get_device_domain(struct device *dev
> >  static inline void of_msi_configure(struct device *dev, struct device_node *np)
> >  {
> >  }
> > +static inline u32 of_msi_map_id(struct device *dev,
> > +                                struct device_node *msi_np, u32 id_in)
> > +{
> > +       return id_in;
> > +}
> >  static inline u32 of_msi_map_rid(struct device *dev,
> >                                  struct device_node *msi_np, u32 rid_in)
> 
> Move this out of the ifdef and you only need it declared once.
> 
> But again, I think I'd just kill of_msi_map_rid.

Yes I don't think there is a clear benefit in keeping the _rid
interface.

Thanks,
Lorenzo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
