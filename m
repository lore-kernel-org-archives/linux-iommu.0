Return-Path: <SRS0=/53O=JI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0D6C433ED
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 06:17:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9E70611C9
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 06:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9E70611C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CBD9403A5;
	Sun, 11 Apr 2021 06:17:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pLgA6n7jfSds; Sun, 11 Apr 2021 06:17:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27062403A7;
	Sun, 11 Apr 2021 06:17:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3EB3C000B;
	Sun, 11 Apr 2021 06:17:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3032C000A
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 06:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 95BC64028D
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 06:17:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Z9BeyOA8Igk for <iommu@lists.linux-foundation.org>;
 Sun, 11 Apr 2021 06:17:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 99EF54028A
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 06:17:06 +0000 (UTC)
Received: from [192.168.178.35] (unknown [94.134.88.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id ED738206473C5;
 Sun, 11 Apr 2021 08:17:02 +0200 (CEST)
Subject: Re: [PATCH] iommu/amd: Fix extended features logging
To: Alexander Monakov <amonakov@ispras.ru>
References: <20210410211152.1938-1-amonakov@ispras.ru>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <e884200f-55a4-59b5-4311-964e6ddc94d1@molgen.mpg.de>
Date: Sun, 11 Apr 2021 08:17:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210410211152.1938-1-amonakov@ispras.ru>
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

Dear Alexander,


Am 10.04.21 um 23:11 schrieb Alexander Monakov:
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

Hmm, did I really screw that up during my testing? I am sorry about that.

I tried to wrap my head around, where the newline is implicitly 
appended, and only found the definitions below.

     include/linux/pci.h:#define pci_info(pdev, fmt, arg...) 
dev_info(&(pdev)->dev, fmt, ##arg)

     include/linux/dev_printk.h:#define dev_info(dev, fmt, ...) 
                                      \
     include/linux/dev_printk.h:     _dev_info(dev, dev_fmt(fmt), 
##__VA_ARGS__)

     include/linux/dev_printk.h:__printf(2, 3) __cold
     include/linux/dev_printk.h:void _dev_info(const struct device *dev, 
const char *fmt, ...);

     include/linux/compiler_attributes.h:#define __printf(a, b) 
          __attribute__((__format__(printf, a, b)))


> Restore the newline, and call pr_info with empty format string to set
> the loglevel for subsequent pr_cont calls. The same solution is used in
> EFI and uvesafb drivers.

Thank you for fixing this.

> Fixes: 9a295ff0ffc9 ("iommu/amd: Print extended features in one line to fix divergent log levels")
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: iommu@lists.linux-foundation.org
> ---
>   drivers/iommu/amd/init.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 596d0c413473..a25e241eff1c 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1929,8 +1929,11 @@ static void print_iommu_info(void)
>   		pci_info(pdev, "Found IOMMU cap 0x%hx\n", iommu->cap_ptr);
>   
>   		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
> -			pci_info(pdev, "Extended features (%#llx):",
> +			pci_info(pdev, "Extended features (%#llx):\n",
>   				 iommu->features);
> +
> +			pr_info("");
> +
>   			for (i = 0; i < ARRAY_SIZE(feat_str); ++i) {
>   				if (iommu_feature(iommu, (1ULL << i)))
>   					pr_cont(" %s", feat_str[i]);
> 

In the discussion *smpboot: CPU numbers printed as warning* [1] John wrote:

> It is supported to provide loglevels for CONT messages. The loglevel is
> then only used if the append fails:
> 
>     pr_cont(KERN_INFO "message part");
> 
> I don't know if we want to go down that path. But it is supported.


Kind regards,

Paul


[1]: https://lkml.org/lkml/2021/2/16/191
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
