Return-Path: <SRS0=yPDG=DQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBACC433E7
	for <iommu@archiver.kernel.org>; Fri,  9 Oct 2020 03:59:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D19822248
	for <iommu@archiver.kernel.org>; Fri,  9 Oct 2020 03:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D19822248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 230978763B;
	Fri,  9 Oct 2020 03:59:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ETn-hZGsvA3K; Fri,  9 Oct 2020 03:59:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 765D7876A5;
	Fri,  9 Oct 2020 03:59:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58848C016F;
	Fri,  9 Oct 2020 03:59:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36859C0051
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 03:59:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 21CF6876A5
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 03:59:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EU59xal9zKtZ for <iommu@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 03:59:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id D2AA08763B
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 03:59:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B5AF1063;
 Thu,  8 Oct 2020 20:59:17 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 996353F66B;
 Thu,  8 Oct 2020 20:59:16 -0700 (PDT)
Subject: Re: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in bcm2711
To: Ard Biesheuvel <ardb@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20201001161740.29064-1-nsaenzjulienne@suse.de>
 <20201001161740.29064-2-nsaenzjulienne@suse.de> <20201001171500.GN21544@gaia>
 <20201001172320.GQ21544@gaia>
 <b47232e2173e9e5ddf8f5be4c7b5a2f897f34eb7.camel@suse.de>
 <20201002115541.GC7034@gaia>
 <12f33d487eabd626db4c07ded5a1447795eed355.camel@suse.de>
 <20201008101353.GE7661@gaia>
 <CAMj1kXFDEdEJ_eaB=jb1m=tKBpVdskrC0fW67NvGNZFS5PVL=Q@mail.gmail.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <978e01a1-71e6-7286-0876-bb10698ba1d2@arm.com>
Date: Thu, 8 Oct 2020 22:59:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXFDEdEJ_eaB=jb1m=tKBpVdskrC0fW67NvGNZFS5PVL=Q@mail.gmail.com>
Content-Language: en-US
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-rpi-kernel@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 10/8/20 2:43 PM, Ard Biesheuvel wrote:
> (+ Lorenzo)
> 
> On Thu, 8 Oct 2020 at 12:14, Catalin Marinas <catalin.marinas@arm.com> wrote:
>>
>> On Thu, Oct 08, 2020 at 12:05:25PM +0200, Nicolas Saenz Julienne wrote:
>>> On Fri, 2020-10-02 at 12:55 +0100, Catalin Marinas wrote:
>>>> On Thu, Oct 01, 2020 at 07:31:19PM +0200, Nicolas Saenz Julienne wrote:
>>>>> On Thu, 2020-10-01 at 18:23 +0100, Catalin Marinas wrote:
>>>>>> On Thu, Oct 01, 2020 at 06:15:01PM +0100, Catalin Marinas wrote:
>>>>>>> On Thu, Oct 01, 2020 at 06:17:37PM +0200, Nicolas Saenz Julienne wrote:
>>>>>>>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>>>>>>>> index 4602e467ca8b..cd0d115ef329 100644
>>>>>>>> --- a/drivers/of/fdt.c
>>>>>>>> +++ b/drivers/of/fdt.c
>>>>>>>> @@ -25,6 +25,7 @@
>>>>>>>>   #include <linux/serial_core.h>
>>>>>>>>   #include <linux/sysfs.h>
>>>>>>>>   #include <linux/random.h>
>>>>>>>> +#include <linux/dma-direct.h>      /* for zone_dma_bits */
>>>>>>>>
>>>>>>>>   #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>>>>>>>>   #include <asm/page.h>
>>>>>>>> @@ -1198,6 +1199,14 @@ void __init early_init_dt_scan_nodes(void)
>>>>>>>>      of_scan_flat_dt(early_init_dt_scan_memory, NULL);
>>>>>>>>   }
>>>>>>>>
>>>>>>>> +void __init early_init_dt_update_zone_dma_bits(void)
>>>>>>>> +{
>>>>>>>> +   unsigned long dt_root = of_get_flat_dt_root();
>>>>>>>> +
>>>>>>>> +   if (of_flat_dt_is_compatible(dt_root, "brcm,bcm2711"))
>>>>>>>> +           zone_dma_bits = 30;
>>>>>>>> +}
>>>>>>>
>>>>>>> I think we could keep this entirely in the arm64 setup_machine_fdt() and
>>>>>>> not pollute the core code with RPi4-specific code.
>>>>>>
>>>>>> Actually, even better, could we not move the check to
>>>>>> arm64_memblock_init() when we initialise zone_dma_bits?
>>>>>
>>>>> I did it this way as I vaguely remembered Rob saying he wanted to centralise
>>>>> all early boot fdt code in one place. But I'll be happy to move it there.
>>>>
>>>> I can see Rob replied and I'm fine if that's his preference. However,
>>>> what I don't particularly like is that in the arm64 code, if
>>>> zone_dma_bits == 24, we set it to 32 assuming that it wasn't touched by
>>>> the early_init_dt_update_zone_dma_bits(). What if at some point we'll
>>>> get a platform that actually needs 24 here (I truly hope not, but just
>>>> the principle of relying on magic values)?
>>>>
>>>> So rather than guessing, I'd prefer if the arch code can override
>>>> ZONE_DMA_BITS_DEFAULT. Then, in arm64, we'll just set it to 32 and no
>>>> need to explicitly touch the zone_dma_bits variable.
>>>
>>> Yes, sonds like the way to go. TBH I wasn't happy with that solution either,
>>> but couldn't think of a nicer alternative.
>>>
>>> Sadly I just realised that the series is incomplete, we have RPi4 users that
>>> want to boot unsing ACPI, and this series would break things for them. I'll
>>> have a word with them to see what we can do for their use-case.
>>
>> Is there a way to get some SoC information from ACPI?
>>
> 
> This is unfortunate. We used ACPI _DMA methods as they were designed
> to communicate the DMA limit of the XHCI controller to the OS.
> 
> It shouldn't be too hard to match the OEM id field in the DSDT, and
> switch to the smaller mask. But it sucks to have to add a quirk like
> that.
> It also requires delaying setting the arm64_dma_phy_limit a bit, but 
that doesn't appear to be causing a problem. I've been boot/compiling 
with a patch like:

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index cada0b816c8a..9dfe776c1c75 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -14,6 +14,7 @@

  #include <linux/acpi.h>
  #include <linux/cpumask.h>
+#include <linux/dma-direct.h>
  #include <linux/efi.h>
  #include <linux/efi-bgrt.h>
  #include <linux/init.h>
@@ -168,6 +169,11 @@ static int __init acpi_fadt_sanity_check(void)
                 ret = -EINVAL;
         }

+       if (!strncmp(table->oem_id, "RPIFDN", ACPI_OEM_ID_SIZE) &&
+           !strncmp(table->oem_table_id,  "RPI4    ", 
ACPI_OEM_TABLE_ID_SIZE) &&
+           table->oem_revision <= 0x200)  {
+               zone_dma_bits = 30;
+       }
  out:
         /*
          * acpi_get_table() creates FADT table mapping that
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index cd5caca8a929..6c8aaf1570ce 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -195,6 +195,7 @@ static void __init zone_sizes_init(unsigned long 
min, unsigned long max)
         unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};

  #ifdef CONFIG_ZONE_DMA
+       arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
         max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
  #endif
  #ifdef CONFIG_ZONE_DMA32
@@ -393,7 +394,6 @@ void __init arm64_memblock_init(void)
                  */
                 if (zone_dma_bits == ZONE_DMA_BITS_DEFAULT)
                         zone_dma_bits = 32;
-               arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
         }

         if (IS_ENABLED(CONFIG_ZONE_DMA32))


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
