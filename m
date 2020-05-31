Return-Path: <SRS0=VdVt=7N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B37FC433E1
	for <iommu@archiver.kernel.org>; Sun, 31 May 2020 07:22:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0885A20723
	for <iommu@archiver.kernel.org>; Sun, 31 May 2020 07:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0885A20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C4FE98625F;
	Sun, 31 May 2020 07:22:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K5XT5DDRamWB; Sun, 31 May 2020 07:22:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8FCAB86241;
	Sun, 31 May 2020 07:22:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73853C0863;
	Sun, 31 May 2020 07:22:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72F04C0176
 for <iommu@lists.linux-foundation.org>; Sun, 31 May 2020 07:22:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6128386E69
 for <iommu@lists.linux-foundation.org>; Sun, 31 May 2020 07:22:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3h0hKmcRREcd for <iommu@lists.linux-foundation.org>;
 Sun, 31 May 2020 07:22:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.ispras.ru (winnie.ispras.ru [83.149.199.91])
 by whitealder.osuosl.org (Postfix) with ESMTP id 926BF86DEA
 for <iommu@lists.linux-foundation.org>; Sun, 31 May 2020 07:22:09 +0000 (UTC)
Received: from monopod.intra.ispras.ru (monopod.intra.ispras.ru [10.10.3.121])
 by smtp.ispras.ru (Postfix) with ESMTP id C439E203BF;
 Sun, 31 May 2020 10:22:04 +0300 (MSK)
Date: Sun, 31 May 2020 10:22:04 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Fix event counter availability check
In-Reply-To: <20200529200738.1923-1-amonakov@ispras.ru>
Message-ID: <alpine.LNX.2.20.13.2005311014450.16067@monopod.intra.ispras.ru>
References: <20200529200738.1923-1-amonakov@ispras.ru>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Shuah Khan <skhan@linuxfoundation.org>
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

Hi,

Adding Shuah Khan to Cc: I've noticed you've seen this issue on Ryzen 2400GE;
can you have a look at the patch? Would be nice to know if it fixes the
problem for you too.

Thanks.
Alexander

On Fri, 29 May 2020, Alexander Monakov wrote:

> The driver performs an extra check if the IOMMU's capabilities advertise
> presence of performance counters: it verifies that counters are writable
> by writing a hard-coded value to a counter and testing that reading that
> counter gives back the same value.
> 
> Unfortunately it does so quite early, even before pci_enable_device is
> called for the IOMMU, i.e. when accessing its MMIO space is not
> guaranteed to work. On Ryzen 4500U CPU, this actually breaks the test:
> the driver assumes the counters are not writable, and disables the
> functionality.
> 
> Moving init_iommu_perf_ctr just after iommu_flush_all_caches resolves
> the issue. This is the earliest point in amd_iommu_init_pci where the
> call succeeds on my laptop.
> 
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: iommu@lists.linux-foundation.org
> ---
> 
> PS. I'm seeing another hiccup with IOMMU probing on my system:
> pci 0000:00:00.2: can't derive routing for PCI INT A
> pci 0000:00:00.2: PCI INT A: not connected
> 
> Hopefully I can figure it out, but I'd appreciate hints.
> 
>  drivers/iommu/amd_iommu_init.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 5b81fd16f5fa..1b7ec6b6a282 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -1788,8 +1788,6 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
>  	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE))
>  		amd_iommu_np_cache = true;
>  
> -	init_iommu_perf_ctr(iommu);
> -
>  	if (is_rd890_iommu(iommu->dev)) {
>  		int i, j;
>  
> @@ -1891,8 +1889,10 @@ static int __init amd_iommu_init_pci(void)
>  
>  	init_device_table_dma();
>  
> -	for_each_iommu(iommu)
> +	for_each_iommu(iommu) {
>  		iommu_flush_all_caches(iommu);
> +		init_iommu_perf_ctr(iommu);
> +	}
>  
>  	if (!ret)
>  		print_iommu_info();
> 
> base-commit: 75caf310d16cc5e2f851c048cd597f5437013368
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
