Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9CAC433EF
	for <iommu@archiver.kernel.org>; Thu, 14 Apr 2022 23:16:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 519EC8403A;
	Thu, 14 Apr 2022 23:16:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ia2hp_tO2Kxm; Thu, 14 Apr 2022 23:16:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D3C828400D;
	Thu, 14 Apr 2022 23:16:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A21E9C002F;
	Thu, 14 Apr 2022 23:16:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23260C002C
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 23:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0029941910
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 23:16:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O-Ibgx0NF-XI for <iommu@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 23:16:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A3926418AC
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 23:16:24 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id be5so5881311plb.13
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 16:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vLhomrpooyVkCPnT/V3GspH1VkT6rkdcQOEP4TxU1jc=;
 b=Xwr79i/rtcdMWZfT7X4gLtn/vh+8ejYnbNEzZrzwPEZQJl3GxaqMmrDWnIP06UETWf
 QO6k2kmSdAsNnxYgt5BIdG2EfI3eWsFLzQeSK+jjRh9x9Y4Ioih9qk0/4ccMmDO9ZGTP
 EkpiuIOmmyUG5xn/9MPYjBUzbjrx0E+jWGo4iZCqvaBK2YXRzbgBSN0AmU/0CHsAwf9+
 IF01Mv0mvybjqpC+tQ4CafC4sv+hVw5uKhFGwj3DUjqowV5+8pMXD7VHKN6TvZnrX5Vb
 1PCwm0BXhEAlX8VODN06SyLQVUhJsM3g/UH1w0Vi8Obymk11oeN6R/gTjqo3gv7a6mpE
 t4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vLhomrpooyVkCPnT/V3GspH1VkT6rkdcQOEP4TxU1jc=;
 b=FliGIkoP0XWDo8q3rsar8HUu7HynUz9GjTG2Zt5OaMAFm+792NncmG8Wt0UKx28vQ7
 /ph7mzgbpfEaWIHNUHtZpcZ9hpADirhPygiLpH+PLu19P9WU2tP38BcFk+OJ2OhEORYP
 umyOonyuzK0P88vEoCAaiOzXAYu5LfZs//1UEvPBA5RMMg9WY4BWuWMUgxCH6TVJRLXo
 Uh9Js4bhuFnmqorNin3ZtdjcDwMItaPSlbhLD638yLqHPL9Yw685UQEIi0smSfBCclan
 9em8FW6P3RFwzy9O3VlZ6+450jtjjEAGpoU11b2qCJ+GD9OvWrlLW5uC/u6H0U2CEzq9
 rJqw==
X-Gm-Message-State: AOAM530uvWtm0syPSsjjfn25QX0bBNbo284YiH191DzOOwKhyZ6hpCmv
 5Drba4sc6hOyyesQhgHRt1YjnDMWQ5TdtnrbzioSsw==
X-Google-Smtp-Source: ABdhPJxbflLVSecIO9jWZq3CT3nUwaSAazyRt2mR5j1dkuDUM61ZcKA4cPzGoWlR/Al2tHHRIW81IvsVP4tAvssYgs8=
X-Received: by 2002:a17:90b:164f:b0:1c7:8d20:ff6d with SMTP id
 il15-20020a17090b164f00b001c78d20ff6dmr1006092pjb.64.1649978183669; Thu, 14
 Apr 2022 16:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220325184609.4059963-1-rajatja@google.com>
 <20220407191715.GA254460@bhelgaas>
In-Reply-To: <20220407191715.GA254460@bhelgaas>
Date: Thu, 14 Apr 2022 16:15:47 -0700
Message-ID: <CACK8Z6Fy3L7vijVn4w+6HwRuuTtW5ePrWc04rUc8U8TPT0Re0w@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] PCI: ACPI: Support Microsoft's "DmaProperty"
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Rajat Jain <rajatxjain@gmail.com>, Will Deacon <will@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Pavel Machek <pavel@denx.de>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Oliver O'Halloran <oohall@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jesse Barnes <jsbarnes@google.com>, Dmitry Torokhov <dtor@google.com>,
 Len Brown <lenb@kernel.org>
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
From: Rajat Jain via iommu <iommu@lists.linux-foundation.org>
Reply-To: Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hello Bjorn,


On Thu, Apr 7, 2022 at 12:17 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> In subject,
>
>   PCI/ACPI: ...
>
> would be consistent with previous history (at least things coming
> through the PCI tree :)).

Will do.

>
> On Fri, Mar 25, 2022 at 11:46:08AM -0700, Rajat Jain wrote:
> > The "DmaProperty" is supported and documented by Microsoft here:
> > https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports
>
> Here's a more specific link (could probably be referenced below to
> avoid cluttering the text here):
>
> https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-internal-pcie-ports-accessible-to-users-and-requiring-dma-protection

Will do.

>
> > They use this property for DMA protection:
> > https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
> >
> > Support the "DmaProperty" with the same semantics. This is useful for
> > internal PCI devices that do not hang off a PCIe rootport, but offer
> > an attack surface for DMA attacks (e.g. internal network devices).
>
> Same semantics as what?

Er, I meant the same semantics as the "DmaProperty". Please also see below.

>
> The MS description of "ExternalFacingPort" says:
>
>   This ACPI object enables the operating system to identify externally
>   exposed PCIe hierarchies, such as Thunderbolt.
>

No, my patch doesn't have to do with this one.

> and "DmaProperty" says:
>
>   This ACPI object enables the operating system to identify internal
>   PCIe hierarchies that are easily accessible by users (such as,
>   Laptop M.2 PCIe slots accessible by way of a latch) and require
>   protection by the OS Kernel DMA Protection mechanism.

Yes, this is the property that my patch uses. Microsoft has agreed to
update this documentation (in a sideband thread that I also copied you
on), with the updated semantics that this property can be used to
identify any PCI devices that require Kernel DMA protection. i.e. the
property is not restricted to identify "internal PCIe hierarchies"
(starting at root port), but to "any PCI device".

>
> I don't really understand why they called out "laptop M.2 PCIe slots"
> here.  Is the idea that those are more accessible than a standard
> internal PCIe slot?  Seems like a pretty small distinction to me.
>
> I can understand your example of internal network devices adding an
> attack surface.  But I don't see how "DmaProperty" helps identify
> those.  Wouldn't a NIC in a standard internal PCIe slot add the same
> attack surface?

Yes it would. The attack surface is the same. They probably only
thought of devices external to the SoC (starting from a root port)
when designing this property and thus called out internal M.2 PCI
slots. But nowhave realized that this could be opened to any PCI
device.

>
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> > v5: * Reorder the patches in the series
> > v4: * Add the GUID.
> >     * Update the comment and commitlog.
> > v3: * Use Microsoft's documented property "DmaProperty"
> >     * Resctrict to ACPI only
> >
> >  drivers/acpi/property.c |  3 +++
> >  drivers/pci/pci-acpi.c  | 16 ++++++++++++++++
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index d0986bda2964..20603cacc28d 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -48,6 +48,9 @@ static const guid_t prp_guids[] = {
> >       /* Storage device needs D3 GUID: 5025030f-842f-4ab4-a561-99a5189762d0 */
> >       GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
> >                 0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
> > +     /* DmaProperty for PCI devices GUID: 70d24161-6dd5-4c9e-8070-705531292865 */
> > +     GUID_INIT(0x70d24161, 0x6dd5, 0x4c9e,
> > +               0x80, 0x70, 0x70, 0x55, 0x31, 0x29, 0x28, 0x65),
> >  };
> >
> >  /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index 1f15ab7eabf8..378e05096c52 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -1350,12 +1350,28 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
> >               dev->external_facing = 1;
> >  }
> >
> > +static void pci_acpi_check_for_dma_protection(struct pci_dev *dev)
>
> I try to avoid function names like *_check_*() because they don't give
> any hint about whether there's a side effect or what direction things
> are going.  I prefer things that return a value or make sense when
> used as a predicate.  Maybe something like this?
>
>   int pci_dev_has_dma_property(struct pci_dev *dev)
>
>   dev->untrusted |= pci_dev_has_dma_property(pci_dev);
>

OK, will do.


> > +{
> > +     u8 val;
> > +
> > +     /*
> > +      * Property also used by Microsoft Windows for same purpose,
> > +      * (to implement DMA protection from a device, using the IOMMU).
> > +      */
> > +     if (device_property_read_u8(&dev->dev, "DmaProperty", &val))
>
> The MS web page says a _DSD with this property must be implemented in
> the Root Port device scope, but we don't enforce that here.  We *do*
> enforce it in pci_acpi_set_untrusted().  Shouldn't we do the same
> here?

No, the whole point of doing this (please refer to the discussion on
the previous versions of this patch) was that we want to have a
property that is NOT limited to the root ports only. And we have
reached an agreement with Microsoft about that.

>
> We currently look at three properties from the same _DSD:
>
>   DmaProperty
>   ExternalFacingPort
>   HotPlugSupportInD3
>
> For "HotPlugSupportInD3", we check that "value == 1".  For
> "ExternalFacingPort", we check that it's non-zero.  The MS doc isn't
> explicit about the values, but shows "1" in the sample ASL.  I think
> we should handle all three cases the same.

I think we can handle all three cases with "value==1". I will send a
separate patch for the ExternalFacingPort, and will fixup this patch
too).

>
> The first two use device_property_read_u8(); the last uses
> acpi_dev_get_property().  Again, I think they should all be the same.
>
> acpi_dev_get_property() is easier for me to read because there are
> slightly fewer layers of abstraction between _DSD and
> acpi_dev_get_property().

I'd prefer that too, and can change it to acpi_dev_get_property.

>
> But IIUC, device_property_read_u8() works for either ACPI or DT
> properties, and maybe there is interest in using this for DT systems.
> None of these appear in any in-tree DTs, but maybe it is important to
> handle these in DTs?
>
> If that's the case, this code would no longer be specific to ACPI and
> should be moved to somewhere that's compiled even when CONFIG_ACPI
> isn't set.

I think unifying ACPI and GPIO systems to use the same code / function
to read the properties might be more work/investigation, because
reading the properties for ACPI system happens much later than DT
systems (For acpi systems, it happens in pci_acpi_setup() which is
called much later). Given that no one wants to use this for DT
systems, I'd prefer for this to be ACPI specific for now, and then we
can solve it for DT once someone needs it.

WDYT?

Thanks & Best regards,

Rajat

>
> > +             return;
> > +
> > +     if (val)
> > +             dev->untrusted = 1;
> > +}
> > +
> >  void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
> >  {
> >       struct pci_dev *pci_dev = to_pci_dev(dev);
> >
> >       pci_acpi_optimize_delay(pci_dev, adev->handle);
> >       pci_acpi_set_external_facing(pci_dev);
> > +     pci_acpi_check_for_dma_protection(pci_dev);
> >       pci_acpi_add_edr_notifier(pci_dev);
> >
> >       pci_acpi_add_pm_notifier(adev, pci_dev);
> > --
> > 2.35.1.1021.g381101b075-goog
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
