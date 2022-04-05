Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6028C433EF
	for <iommu@archiver.kernel.org>; Tue,  5 Apr 2022 13:25:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6EC274136B;
	Tue,  5 Apr 2022 13:25:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oVCUpU6_KySF; Tue,  5 Apr 2022 13:25:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 073C541296;
	Tue,  5 Apr 2022 13:25:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC33EC002C;
	Tue,  5 Apr 2022 13:25:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 067D2C0012
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 13:25:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D3BD360E15
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 13:25:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F64xR2BO4IrK for <iommu@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 13:25:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com
 [209.85.219.182])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9C1DC60C01
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 13:25:30 +0000 (UTC)
Received: by mail-yb1-f182.google.com with SMTP id f23so23272825ybj.7
 for <iommu@lists.linux-foundation.org>; Tue, 05 Apr 2022 06:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E5Al4J7VCG/P8LTv1wy0Uzk4KB0CIZvLVMNw+72bmlY=;
 b=VDMkXUqeEJx/hdQmcyqUbnX3+LvHCyK0KxelgaAHx3CN63P3l4CRmgDT2HwD6e3h0x
 tyCpHwiRdfN49EGfiByYskhjwLgMxQwVpT/LY3JNwm1d8bvsrD3BE7Ni2DW6USl0Qak4
 SpqUUWqrqBmRSMQ1+7wOpR7wEnttb+NoHP/8cl2d3DtUMiKllWqqV2BvD9JMWHzhNf1n
 yQTvIV6jqtyT9lsD9loAlc9UGdSlMmCkOJwwZq+FpMNxdpP8BJgVY4Nj3ghSROQJrx9R
 RQf4AeqJXW3tqMfOD1gfW9MfMKiDiXlCoXwwSoDefLx8owm3paDavz5txrc9a+WjYVX+
 0ErA==
X-Gm-Message-State: AOAM532+TodKE2Q8icVN1DrTn6RNRXtuEYLAUYeqtdVfdtXt4QXgsfeQ
 E+TNz796r0sKSayXIebfqQMceDfITfmQQPU8tTQ=
X-Google-Smtp-Source: ABdhPJzvtUL+VkrikhhCBPKyLKqDEV2E5D8I7wR0e3nEvz40gGldfHk2pv2u3E/1r3WC/KqC7zaSc0uRoPXPW/UhUpc=
X-Received: by 2002:a05:6902:1544:b0:63d:d3a7:8cc4 with SMTP id
 r4-20020a056902154400b0063dd3a78cc4mr2582151ybu.622.1649165129602; Tue, 05
 Apr 2022 06:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220325184609.4059963-1-rajatja@google.com>
In-Reply-To: <20220325184609.4059963-1-rajatja@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Apr 2022 15:25:17 +0200
Message-ID: <CAJZ5v0jQW3NcbtBWxUW8RQ-eCB3M6wdqztDmPr4q5+=FYmfJHw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] PCI: ACPI: Support Microsoft's "DmaProperty"
To: Rajat Jain <rajatja@google.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Rajat Jain <rajatxjain@gmail.com>, Will Deacon <will@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Pavel Machek <pavel@denx.de>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Bjorn Helgaas <helgaas@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Oliver O'Halloran <oohall@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, Mar 25, 2022 at 7:46 PM Rajat Jain <rajatja@google.com> wrote:
>
> The "DmaProperty" is supported and documented by Microsoft here:
> https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports
> They use this property for DMA protection:
> https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
>
> Support the "DmaProperty" with the same semantics. This is useful for
> internal PCI devices that do not hang off a PCIe rootport, but offer
> an attack surface for DMA attacks (e.g. internal network devices).
>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> v5: * Reorder the patches in the series
> v4: * Add the GUID.
>     * Update the comment and commitlog.
> v3: * Use Microsoft's documented property "DmaProperty"
>     * Resctrict to ACPI only
>
>  drivers/acpi/property.c |  3 +++
>  drivers/pci/pci-acpi.c  | 16 ++++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index d0986bda2964..20603cacc28d 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -48,6 +48,9 @@ static const guid_t prp_guids[] = {
>         /* Storage device needs D3 GUID: 5025030f-842f-4ab4-a561-99a5189762d0 */
>         GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
>                   0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
> +       /* DmaProperty for PCI devices GUID: 70d24161-6dd5-4c9e-8070-705531292865 */
> +       GUID_INIT(0x70d24161, 0x6dd5, 0x4c9e,
> +                 0x80, 0x70, 0x70, 0x55, 0x31, 0x29, 0x28, 0x65),
>  };
>
>  /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 1f15ab7eabf8..378e05096c52 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1350,12 +1350,28 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
>                 dev->external_facing = 1;
>  }
>
> +static void pci_acpi_check_for_dma_protection(struct pci_dev *dev)
> +{
> +       u8 val;
> +
> +       /*
> +        * Property also used by Microsoft Windows for same purpose,
> +        * (to implement DMA protection from a device, using the IOMMU).
> +        */
> +       if (device_property_read_u8(&dev->dev, "DmaProperty", &val))
> +               return;
> +
> +       if (val)
> +               dev->untrusted = 1;
> +}
> +
>  void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
>  {
>         struct pci_dev *pci_dev = to_pci_dev(dev);
>
>         pci_acpi_optimize_delay(pci_dev, adev->handle);
>         pci_acpi_set_external_facing(pci_dev);
> +       pci_acpi_check_for_dma_protection(pci_dev);
>         pci_acpi_add_edr_notifier(pci_dev);
>
>         pci_acpi_add_pm_notifier(adev, pci_dev);
> --
> 2.35.1.1021.g381101b075-goog
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
