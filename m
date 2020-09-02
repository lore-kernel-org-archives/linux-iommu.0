Return-Path: <SRS0=BMay=CL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CC7C433E7
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 11:31:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED6B2065E
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 11:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED6B2065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 22B2B86741;
	Wed,  2 Sep 2020 11:31:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id azc8L6j5sLNt; Wed,  2 Sep 2020 11:31:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1A31D8673C;
	Wed,  2 Sep 2020 11:31:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C29EC0052;
	Wed,  2 Sep 2020 11:31:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDB1AC0051
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 11:31:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DCB6B86F80
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 11:31:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H16Fhgnb2DiZ for <iommu@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 11:31:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8D83E86F79
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 11:31:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA1F6D6E;
 Wed,  2 Sep 2020 04:31:33 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0020D3F66F;
 Wed,  2 Sep 2020 04:31:32 -0700 (PDT)
Subject: Re: [PATCH] iommu: Allocate dev_iommu before accessing priv data
To: Torsten Hilbrich <torsten.hilbrich@secunet.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <jroedel@suse.de>
References: <e27cd096-a721-db9d-e4ce-7a432ed6cd4c@secunet.com>
 <12935d0b-61ff-d274-b1ee-3b1fba36bdc7@linux.intel.com>
 <1eafacd8-8cdb-d6ae-130c-dca66dbe3598@secunet.com>
 <175fe2a7-922e-1800-298e-1481b648c6d8@linux.intel.com>
 <96717683-70be-7388-3d2f-61131070a96a@secunet.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <0bceb7a0-5765-bfa8-2bcd-f5d98a366a34@arm.com>
Date: Wed, 2 Sep 2020 12:31:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <96717683-70be-7388-3d2f-61131070a96a@secunet.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org
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

On 2020-09-02 06:32, Torsten Hilbrich wrote:
> After updating from v5.8 to v5.9-rc2 I noticed some problems when
> booting a system with kernel cmdline "intel_iommu=on,igfx_off".
> 
> The following stacktrace was produced:
> 
> <6>[    0.000000] Command line: BOOT_IMAGE=/isolinux/bzImage console=tty1 intel_iommu=on,igfx_off
> ...
> <6>[    3.341682] DMAR: Host address width 39
> <6>[    3.341684] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
> <6>[    3.341702] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
> <6>[    3.341705] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
> <6>[    3.341711] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
> <6>[    3.341713] DMAR: RMRR base: 0x0000009aa9f000 end: 0x0000009aabefff
> <6>[    3.341716] DMAR: RMRR base: 0x0000009d000000 end: 0x0000009f7fffff
> <6>[    3.341726] DMAR: No ATSR found
> <1>[    3.341772] BUG: kernel NULL pointer dereference, address: 0000000000000038
> <1>[    3.341774] #PF: supervisor write access in kernel mode
> <1>[    3.341776] #PF: error_code(0x0002) - not-present page
> <6>[    3.341777] PGD 0 P4D 0
> <4>[    3.341780] Oops: 0002 [#1] SMP PTI
> <4>[    3.341783] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.9.0-devel+ #2
> <4>[    3.341785] Hardware name: LENOVO 20HGS0TW00/20HGS0TW00, BIOS N1WET46S (1.25s ) 03/30/2018
> <4>[    3.341790] RIP: 0010:intel_iommu_init+0xed0/0x1136
> <4>[    3.341792] Code: fe e9 61 02 00 00 bb f4 ff ff ff e9 57 02 00 00 48 63 d1 48 c1 e2 04 48 03 50 20 48 8b 12 48 85 d2 74 0b 48 8b 92 d0 02 00 00 <48> 89 7a 38 ff c1 e9 15 f5 ff ff 48 c7 c7 60 99 ac a7 49 c7 c7 a0
> <4>[    3.341796] RSP: 0000:ffff96d180073dd0 EFLAGS: 00010282
> <4>[    3.341798] RAX: ffff8c91037a7d20 RBX: 0000000000000000 RCX: 0000000000000000
> <4>[    3.341800] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffffffffff
> <4>[    3.341802] RBP: ffff96d180073e90 R08: 0000000000000001 R09: ffff8c91039fe3c0
> <4>[    3.341804] R10: 0000000000000226 R11: 0000000000000226 R12: 000000000000000b
> <4>[    3.341806] R13: ffff8c910367c650 R14: ffffffffa8426d60 R15: 0000000000000000
> <4>[    3.341808] FS:  0000000000000000(0000) GS:ffff8c9107480000(0000) knlGS:0000000000000000
> <4>[    3.341810] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[    3.341812] CR2: 0000000000000038 CR3: 00000004b100a001 CR4: 00000000003706e0
> <4>[    3.341814] Call Trace:
> <4>[    3.341820]  ? _raw_spin_unlock_irqrestore+0x1f/0x30
> <4>[    3.341824]  ? call_rcu+0x10e/0x320
> <4>[    3.341828]  ? trace_hardirqs_on+0x2c/0xd0
> <4>[    3.341831]  ? rdinit_setup+0x2c/0x2c
> <4>[    3.341834]  ? e820__memblock_setup+0x8b/0x8b
> <4>[    3.341836]  pci_iommu_init+0x16/0x3f
> <4>[    3.341839]  do_one_initcall+0x46/0x1e4
> <4>[    3.341842]  kernel_init_freeable+0x169/0x1b2
> <4>[    3.341845]  ? rest_init+0x9f/0x9f
> <4>[    3.341847]  kernel_init+0xa/0x101
> <4>[    3.341849]  ret_from_fork+0x22/0x30
> <4>[    3.341851] Modules linked in:
> <4>[    3.341854] CR2: 0000000000000038
> <4>[    3.341860] ---[ end trace 3653722a6f936f18 ]---
> 
> I could track the problem down to the dev_iommu_priv_set call in the function
> init_no_remapping_devices in the path where !dmar_map_gfx. It turned out that
> the dev->iommu entry is NULL at this time.
> 
> Lu Baolu <baolu.lu@linux.intel.com> suggested for dev_iommu_priv_set
> to automatically allocate the iommu entry by using the function
> dev_iommu_get to retrieve that pointer. This function allocates the
> entry if needed.
> 
> Fixes: 01b9d4e21148 ("iommu/vt-d: Use dev_iommu_priv_get/set()")
> Signed-off-by: Torsten Hilbrich <torsten.hilbrich@secunet.com>
> Tested-by: Torsten Hilbrich <torsten.hilbrich@secunet.com>
> Link: https://lists.linuxfoundation.org/pipermail/iommu/2020-August/048098.html
> ---
>   drivers/iommu/iommu.c | 22 ++++++++++++++++++++++
>   include/linux/iommu.h | 11 ++---------
>   2 files changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 609bd25bf154..3edca2a31296 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2849,3 +2849,25 @@ int iommu_sva_get_pasid(struct iommu_sva *handle)
>   	return ops->sva_get_pasid(handle);
>   }
>   EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
> +
> +void *dev_iommu_priv_get(struct device *dev)
> +{
> +       struct dev_iommu *param = dev_iommu_get(dev);
> +
> +       if (WARN_ON(!param))
> +               return ERR_PTR(-ENOMEM);
> +
> +        return param->priv;
> +}
> +EXPORT_SYMBOL_GPL(dev_iommu_priv_get);

Hmm, I'm not convinced by this - it looks it would only paper over real 
driver bugs. If the driver's calling dev_iommu_priv_get(), it presumably 
wants to actually *do* something with its private data - if it somehow 
manages to make that call before it's processed ->probe_device(), it 
can't possibly get *meaningful* data, so even if we stop that call from 
crashing how can it result in correct behaviour?

And if the device isn't managed by that IOMMU driver, then it shouldn't 
be calling dev_iommu_priv_get() blindly in the first place (and 
allocating redundant structures would just be a waste).

> +void dev_iommu_priv_set(struct device *dev, void *priv)
> +{
> +       struct dev_iommu *param = dev_iommu_get(dev);
> +
> +       if (WARN_ON(!param))
> +               return;
> +
> +        param->priv = priv;
> +}
> +EXPORT_SYMBOL_GPL(dev_iommu_priv_set);

In this direction it's at least not completely illogical, but it's still 
indicative of a driver operating very much outside the expected API 
flow. If a driver has special knowledge of devices it manages before 
it's seen ->probe_device() for them then fair enough, but it should 
probably be that driver's responsibility to manage any "out of order" 
usage of its private data as a special case, rather than pretending that 
this is expected common behaviour. Again, for most drivers it's more 
likely to just mask bugs than be genuinely useful.

Robin.

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index fee209efb756..e3e725cf64b3 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -609,15 +609,8 @@ static inline void dev_iommu_fwspec_set(struct device *dev,
>   	dev->iommu->fwspec = fwspec;
>   }
>   
> -static inline void *dev_iommu_priv_get(struct device *dev)
> -{
> -	return dev->iommu->priv;
> -}
> -
> -static inline void dev_iommu_priv_set(struct device *dev, void *priv)
> -{
> -	dev->iommu->priv = priv;
> -}
> +void *dev_iommu_priv_get(struct device *dev);
> +void dev_iommu_priv_set(struct device *dev, void *priv);
>   
>   int iommu_probe_device(struct device *dev);
>   void iommu_release_device(struct device *dev);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
