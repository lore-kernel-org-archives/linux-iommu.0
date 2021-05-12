Return-Path: <SRS0=CJHf=KH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBC1C433ED
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 19:55:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E679C613F7
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 19:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E679C613F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8060E40F5A;
	Wed, 12 May 2021 19:55:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nLy_pVAIRLb8; Wed, 12 May 2021 19:55:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id E866440F58;
	Wed, 12 May 2021 19:55:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BECE8C000E;
	Wed, 12 May 2021 19:55:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03812C0001
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 19:55:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F2F49844C3
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 19:55:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bPGSiJwIYNgZ for <iommu@lists.linux-foundation.org>;
 Wed, 12 May 2021 19:55:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56C6183D13
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 19:55:18 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5aef16.dynamic.kabel-deutschland.de
 [95.90.239.22])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id BAB0561E5FE33;
 Wed, 12 May 2021 21:55:14 +0200 (CEST)
Subject: Re: [RESEND PATCH v2] iommu/amd: Fix extended features logging
To: Alexander Monakov <amonakov@ispras.ru>
References: <20210504102220.1793-1-amonakov@ispras.ru>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <189e74f3-40a0-12ec-08fa-982dff3708f2@molgen.mpg.de>
Date: Wed, 12 May 2021 21:55:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210504102220.1793-1-amonakov@ispras.ru>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
 LKML <linux-kernel@vger.kernel.org>
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



Am 04.05.21 um 12:22 schrieb Alexander Monakov:
> print_iommu_info prints the EFR register and then the decoded list of
> features on a separate line:
> 
> pci 0000:00:00.2: AMD-Vi: Extended features (0x206d73ef22254ade):
>   PPR X2APIC NX GT IA GA PC GA_vAPIC
> 
> The second line is emitted via 'pr_cont', which causes it to have a
> different ('warn') loglevel compared to the previous line ('info').
> 
> Commit 9a295ff0ffc9 attempted to rectify this by removing the newline
> from the pci_info format string, but this doesn't work, as pci_info
> calls implicitly append a newline anyway.
> 
> Printing the decoded features on the same line would make it quite long.
> Instead, change pci_info() to pr_info() to omit PCI bus location info,
> which is also shown in the preceding message. This results in:
> 
> pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
> AMD-Vi: Extended features (0x206d73ef22254ade): PPR X2APIC NX GT IA GA PC GA_vAPIC
> AMD-Vi: Interrupt remapping enabled
> 
> Fixes: 9a295ff0ffc9 ("iommu/amd: Print extended features in one line to fix divergent log levels")
> Link: https://lore.kernel.org/lkml/alpine.LNX.2.20.13.2104112326460.11104@monopod.intra.ispras.ru
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: iommu@lists.linux-foundation.org
> ---
>   drivers/iommu/amd/init.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 429a4baa3aee..8f0eb865119a 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1954,8 +1954,8 @@ static void print_iommu_info(void)
>   		pci_info(pdev, "Found IOMMU cap 0x%x\n", iommu->cap_ptr);
>   
>   		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
> -			pci_info(pdev, "Extended features (%#llx):",
> -				 iommu->features);
> +			pr_info("Extended features (%#llx):", iommu->features);
> +
>   			for (i = 0; i < ARRAY_SIZE(feat_str); ++i) {
>   				if (iommu_feature(iommu, (1ULL << i)))
>   					pr_cont(" %s", feat_str[i]);
> 
> base-commit: 9f4ad9e425a1d3b6a34617b8ea226d56a119a717

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
