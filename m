Return-Path: <SRS0=aVDl=HK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9E1C433E0
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 08:21:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2344064E88
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 08:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2344064E88
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E773986DEE;
	Mon,  8 Feb 2021 08:21:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DCe43UzAzCe2; Mon,  8 Feb 2021 08:21:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5E79D86221;
	Mon,  8 Feb 2021 08:21:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45F48C0174;
	Mon,  8 Feb 2021 08:21:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4E09C013A
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 08:21:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CB4C686DEE
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 08:21:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EGJZIMzj4J72 for <iommu@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 08:21:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 33FAB86221
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 08:21:53 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0382464E7C;
 Mon,  8 Feb 2021 08:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612772512;
 bh=Sc4SyiQNkQRCBMHLyFUuSu5h5GfleBywijQHNH8VGwY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uJALf7V4OHLbpIhOfAaIY+MW1DSl6gXscF6VMcBh40t2jSQt5+FY63KEiG5/CcOKn
 HwOtotob3s8s5mWKCjZ8R2yckWr0niOxr9yvGYFM5KRqUfmRhq7iDoNF7tNiQP1xkl
 5HW7Tnd4J9yiImoLgJX4gc0c99c6AdQtsHdEoJ0zVfKQWUbl4A3k5AhITSxeNBZSnM
 gAsDTp+NIMv3oSMlyWQOBSJQ7YQbEscsEdxxoCGM2zAlQcIv8mPFwxC13BuzX+1PCB
 w/lULHjroi+HVcAWeGxBZThE8Axw0VEbz2QG7NJrcIenkZ+KOSkqMRootvv6mLMg3u
 P/e9iMqmKYCBA==
Date: Mon, 8 Feb 2021 10:21:48 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Megha Dey <megha.dey@intel.com>
Subject: Re: [PATCH 11/12] platform-msi: Add platform check for subdevice irq
 domain
Message-ID: <20210208082148.GA20265@unreal>
References: <1612385805-3412-1-git-send-email-megha.dey@intel.com>
 <1612385805-3412-12-git-send-email-megha.dey@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1612385805-3412-12-git-send-email-megha.dey@intel.com>
Cc: alex.williamson@redhat.com, kevin.tian@intel.com, tony.luck@intel.com,
 dave.jiang@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 ravi.v.shankar@intel.com, maz@kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jgg@mellanox.com, linux-pci@vger.kernel.org, bhelgaas@google.com,
 tglx@linutronix.de, dan.j.williams@intel.com, dwmw@amazon.co.uk
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

On Wed, Feb 03, 2021 at 12:56:44PM -0800, Megha Dey wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
>
> The pci_subdevice_msi_create_irq_domain() should fail if the underlying
> platform is not able to support IMS (Interrupt Message Storage). Otherwise,
> the isolation of interrupt is not guaranteed.
>
> For x86, IMS is only supported on bare metal for now. We could enable it
> in the virtualization environments in the future if interrupt HYPERCALL
> domain is supported or the hardware has the capability of interrupt
> isolation for subdevices.
>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/linux-pci/87pn4nk7nn.fsf@nanos.tec.linutronix.de/
> Link: https://lore.kernel.org/linux-pci/877dqrnzr3.fsf@nanos.tec.linutronix.de/
> Link: https://lore.kernel.org/linux-pci/877dqqmc2h.fsf@nanos.tec.linutronix.de/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Megha Dey <megha.dey@intel.com>
> ---
>  arch/x86/pci/common.c       | 74 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/base/platform-msi.c |  8 +++++
>  include/linux/msi.h         |  1 +
>  3 files changed, 83 insertions(+)
>
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 3507f45..263ccf6 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -12,6 +12,8 @@
>  #include <linux/init.h>
>  #include <linux/dmi.h>
>  #include <linux/slab.h>
> +#include <linux/iommu.h>
> +#include <linux/msi.h>
>
>  #include <asm/acpi.h>
>  #include <asm/segment.h>
> @@ -724,3 +726,75 @@ struct pci_dev *pci_real_dma_dev(struct pci_dev *dev)
>  	return dev;
>  }
>  #endif
> +
> +#ifdef CONFIG_DEVICE_MSI

Sorry for my naive question, but I see it in all your patches in this series
and wonder why did you wrap everything with ifdefs?.

All *.c code is wrapped with those ifdefs, which is hard to navigate and
unlikely to give any code/size optimization benefit if kernel is compiled
without CONFIG_DEVICE_MSI. The more common approach is to put those
ifdef in the public header files and leave to the compiler to drop not
called functions.

Thanks
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
