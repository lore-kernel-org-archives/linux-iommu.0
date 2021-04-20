Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834A1C433B4
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 17:30:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9DD8613C9
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 17:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9DD8613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70989404ED;
	Tue, 20 Apr 2021 17:30:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9lLZimRuBt0l; Tue, 20 Apr 2021 17:30:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2F62405AF;
	Tue, 20 Apr 2021 17:30:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFDECC000B;
	Tue, 20 Apr 2021 17:30:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB879C000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:30:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B9AED4024A
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:30:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3It2Ao1rQ5mo for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 17:30:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 28E1C401F5
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:30:50 +0000 (UTC)
Received: by mail-vs1-xe2c.google.com with SMTP id k19so6693080vsg.0
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 10:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G58TS9A9yYeMoSb17LgKAY3Blh89gTINhGV0E3IpGQE=;
 b=et2aicPqhBqREOY0dNhnVIpeKAqBqwCzKXvIfzgrBt6P66Jgo/2+oQEWI+6gyewphg
 VbhS+bw5RzxtJErHdYEL/G5C3BA7I4UJ6eL5VYd1XnMcLFOCvxA4QaOg5G/PfVgj9nY0
 lHTQOuBQKTK9gNs7yf2oHGIdtU/z3Wkt5iEJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G58TS9A9yYeMoSb17LgKAY3Blh89gTINhGV0E3IpGQE=;
 b=Ac/HfcD9Tqg3GQPpInx5k61lU7WLhue4ny7R40jMo/QtdFydeS7wKUW74ic7S2CHEF
 Ze4sAQpYwpeAtNH4ibq+U6dWY+2ktk3l/WJfAmkzloYxqMGFN5b7IjyRddSoXKHcaxMm
 jk+0ln+QU2JMrxc8h9PBBBmGE214mp9NNTY8117jxQXddw4TRRj6NRH/54gmLbs0Km3N
 lzIpLSKIcwSZmSDXJ+86IqoFfp3d/yNqRvVM0Ay0ref3vNvGMnE8AoS4pFvUc7YLGjsK
 +DjaRzeOy170xfG79EH4qMi6PK8cPgX0fmxYVKfjsarmjy1qa/C77iKkAoe4LOof6r3b
 GmvA==
X-Gm-Message-State: AOAM530spuGlZmezI0OZwUF5o95bEE7w5VYiaASeI8ZxPyQQpwMckT7v
 4EHymS92QC0sccrUCPnoL7IhjC13dNqAmQJk303OSw==
X-Google-Smtp-Source: ABdhPJwXS7FiUTSlDWt0dHxHZ5655bX8hkIGHT1fDhHkNqF1vZ+XhhN+pVaz/0zkCxHB6ILJZd90Q4uuCj/sRoEmvgk=
X-Received: by 2002:a67:c98b:: with SMTP id y11mr21793715vsk.2.1618939848572; 
 Tue, 20 Apr 2021 10:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <1618886913-6594-1-git-send-email-bingbu.cao@intel.com>
 <20210420091309.GH3@paasikivi.fi.intel.com>
In-Reply-To: <20210420091309.GH3@paasikivi.fi.intel.com>
From: Grant Grundler <grundler@chromium.org>
Date: Tue, 20 Apr 2021 17:30:37 +0000
Message-ID: <CANEJEGunDJ-Q3vP5ABVgtQqg2vmNye6g+i7arZKxZOUdJOJaQQ@mail.gmail.com>
Subject: Re: [RESEND v2] iommu/vt-d: Use passthrough mode for the Intel IPUs
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: andriy.shevchenko@linux.intel.com, will@kernel.org,
 Grant Grundler <grundler@chromium.org>, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
 senozhatsky@chromium.org, Linux IOMMU <iommu@lists.linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Bingbu Cao <bingbu.cao@intel.com>,
 Rajat Jain <rajatja@google.com>, David Woodhouse <dwmw2@infradead.org>,
 bingbu.cao@linux.intel.com
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

On Tue, Apr 20, 2021 at 11:02 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Bingbu,
>
> Thanks for the patch.
>
> On Tue, Apr 20, 2021 at 10:48:33AM +0800, Bingbu Cao wrote:
> > Intel IPU(Image Processing Unit) has its own (IO)MMU hardware,
> > The IPU driver allocates its own page table that is not mapped
> > via the DMA, and thus the Intel IOMMU driver blocks access giving
> > this error:
>
> The page table should be mapped to the possible IOMMU using the DMA API.

I've made the same "observation": this patch is intentionally enables
using "intel_iommu=on" (IIRC) to strictly enforce "all" DMA
transactions (except the ones we explicitly allow to identity map).

The question is: Is the security of IPU MMU the same as the system
IOMMU for the few devices behind the IPU MMU?

If not, then we (Chrome OS) require child devices to be "mapped"
twice: once in IPU MMU and again in the system IOMMU. I believe
dma_ops can be nested though I can't confidently point at examples
(IDE drivers maybe?)  This adds some latency to each DMA transaction -
decades ago I've measured roughly 5% on Itanium and PA-RISC systems
from HP. Perhaps Intel can measure this penatly on current HW they are
shipping.

If yes, then I think the IPU driver just needs to be consistent about
it's use of DMA API for it's own house keeping: Either use DMA API for
all IPU DMA operations or use it for none. This is the current plan
for Chrome OS (I didn't make this decision and wasn't party to the
discussion).

The IPU driver requires it's child devices to use DMA API and provides
the dma_ops table for those devices - this use of dma_ops is seperate
from IPU page tables and other host memory transactions to manage the
IPU MMU page tables.

CAVEAT: I'm not an expert in IPU driver - I've been reviewing Intel
IPU code for chromium.org inclusion here:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2787723
I have no illusions that I'm going to be an expert after staring at
28k lines of code less than 10h.

> > DMAR: DRHD: handling fault status reg 3
> > DMAR: [DMA Read] Request device [00:05.0] PASID ffffffff
> >       fault addr 76406000 [fault reason 06] PTE Read access is not set
> >
> > As IPU is not an external facing device which is not risky, so use
> > IOMMU passthrough mode for Intel IPUs.
>
> I think a factor here is that the page tables aren't accessible by the IPU
> firmware.

Correct. At least not accessible through the system IOMMU. This is why
Intel prefers the IPU to bypass the system IOMMU.

cheers,
grant

>
> >
> > Fixes: 26f5689592e2 ("media: staging/intel-ipu3: mmu: Implement driver")
> > Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
> > ---
> >  drivers/iommu/intel/iommu.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index ee0932307d64..7e2fbdae467e 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -55,6 +55,12 @@
> >  #define IS_GFX_DEVICE(pdev) ((pdev->class >> 16) == PCI_BASE_CLASS_DISPLAY)
> >  #define IS_USB_DEVICE(pdev) ((pdev->class >> 8) == PCI_CLASS_SERIAL_USB)
> >  #define IS_ISA_DEVICE(pdev) ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA)
> > +#define IS_INTEL_IPU(pdev) ((pdev)->vendor == PCI_VENDOR_ID_INTEL && \
> > +                         ((pdev)->device == 0x9a19 ||                \
> > +                          (pdev)->device == 0x9a39 ||                \
> > +                          (pdev)->device == 0x4e19 ||                \
> > +                          (pdev)->device == 0x465d ||                \
> > +                          (pdev)->device == 0x1919))
> >  #define IS_AZALIA(pdev) ((pdev)->vendor == 0x8086 && (pdev)->device == 0x3a3e)
> >
> >  #define IOAPIC_RANGE_START   (0xfee00000)
> > @@ -360,6 +366,7 @@ int intel_iommu_enabled = 0;
> >  EXPORT_SYMBOL_GPL(intel_iommu_enabled);
> >
> >  static int dmar_map_gfx = 1;
> > +static int dmar_map_ipu = 1;
>
> This works as long as there's only one IPU. Same for graphics. But I guess
> this can be reworked in the future if the presumption changes.
>
> >  static int dmar_forcedac;
> >  static int intel_iommu_strict;
> >  static int intel_iommu_superpage = 1;
> > @@ -368,6 +375,7 @@ static int iommu_skip_te_disable;
> >
> >  #define IDENTMAP_GFX         2
> >  #define IDENTMAP_AZALIA              4
> > +#define IDENTMAP_IPU         8
> >
> >  int intel_iommu_gfx_mapped;
> >  EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
> > @@ -2839,6 +2847,9 @@ static int device_def_domain_type(struct device *dev)
> >
> >               if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
> >                       return IOMMU_DOMAIN_IDENTITY;
> > +
> > +             if ((iommu_identity_mapping & IDENTMAP_IPU) && IS_INTEL_IPU(pdev))
> > +                     return IOMMU_DOMAIN_IDENTITY;
> >       }
> >
> >       return 0;
> > @@ -3278,6 +3289,9 @@ static int __init init_dmars(void)
> >       if (!dmar_map_gfx)
> >               iommu_identity_mapping |= IDENTMAP_GFX;
> >
> > +     if (!dmar_map_ipu)
> > +             iommu_identity_mapping |= IDENTMAP_IPU;
> > +
> >       check_tylersburg_isoch();
> >
> >       ret = si_domain_init(hw_pass_through);
> > @@ -5622,6 +5636,18 @@ static void quirk_iommu_igfx(struct pci_dev *dev)
> >       dmar_map_gfx = 0;
> >  }
> >
> > +static void quirk_iommu_ipu(struct pci_dev *dev)
> > +{
> > +     if (!IS_INTEL_IPU(dev))
> > +             return;
> > +
> > +     if (risky_device(dev))
> > +             return;
> > +
> > +     pci_info(dev, "Passthrough IOMMU for integrated Intel IPU\n");
> > +     dmar_map_ipu = 0;
> > +}
> > +
> >  /* G4x/GM45 integrated gfx dmar support is totally busted. */
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2a40, quirk_iommu_igfx);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e00, quirk_iommu_igfx);
> > @@ -5657,6 +5683,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1632, quirk_iommu_igfx);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163A, quirk_iommu_igfx);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163D, quirk_iommu_igfx);
> >
> > +/* disable IPU dmar support */
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_ANY_ID, quirk_iommu_ipu);
> > +
> >  static void quirk_iommu_rwbf(struct pci_dev *dev)
> >  {
> >       if (risky_device(dev))
>
> --
> Kind regards,
>
> Sakari Ailus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
