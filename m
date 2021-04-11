Return-Path: <SRS0=/53O=JI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5108C433B4
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 12:08:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6627A60C41
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 12:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6627A60C41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F36BA40387;
	Sun, 11 Apr 2021 12:08:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7wegE-oG3yEt; Sun, 11 Apr 2021 12:08:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8409D40278;
	Sun, 11 Apr 2021 12:08:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69A3DC000C;
	Sun, 11 Apr 2021 12:08:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDEEBC000A
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 12:08:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B3890608DD
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 12:08:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AHSF2IwI0b8l for <iommu@lists.linux-foundation.org>;
 Sun, 11 Apr 2021 12:08:32 +0000 (UTC)
X-Greylist: delayed 00:20:02 by SQLgrey-1.8.0
Received: from smtprelay.hostedemail.com (smtprelay0224.hostedemail.com
 [216.40.44.224])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DA12A60726
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 12:08:32 +0000 (UTC)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave07.hostedemail.com (Postfix) with ESMTP id CB2E81802F494
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 11:31:11 +0000 (UTC)
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id AC886181D2098;
 Sun, 11 Apr 2021 11:31:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf07.hostedemail.com (Postfix) with ESMTPA id 32507315D79; 
 Sun, 11 Apr 2021 11:31:07 +0000 (UTC)
Message-ID: <6fbc8d6b885771ad4e69fc6789d07fd2b66f01d5.camel@perches.com>
Subject: Re: [PATCH] iommu/amd: Fix extended features logging
From: Joe Perches <joe@perches.com>
To: Alexander Monakov <amonakov@ispras.ru>, linux-kernel@vger.kernel.org, 
 Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, John
 Ogness <john.ogness@linutronix.de>
Date: Sun, 11 Apr 2021 04:31:06 -0700
In-Reply-To: <20210410211152.1938-1-amonakov@ispras.ru>
References: <20210410211152.1938-1-amonakov@ispras.ru>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 32507315D79
X-Stat-Signature: gxjes4ah47oq6d917spxhf1rbfm9bpsm
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18gDYP58m9/GUiRCS+mgNCaIQI5Gz2Pa7s=
X-HE-Tag: 1618140667-663278
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, iommu@lists.linux-foundation.org,
 Joerg Roedel <jroedel@suse.de>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

(cc'ing the printk maintainers)

On Sun, 2021-04-11 at 00:11 +0300, Alexander Monakov wrote:
> print_iommu_info prints the EFR register and then the decoded list of
> features on a separate line:
> =

> pci 0000:00:00.2: AMD-Vi: Extended features (0x206d73ef22254ade):
> =A0PPR X2APIC NX GT IA GA PC GA_vAPIC
> =

> The second line is emitted via 'pr_cont', which causes it to have a
> different ('warn') loglevel compared to the previous line ('info').
> =

> Commit 9a295ff0ffc9 attempted to rectify this by removing the newline
> from the pci_info format string, but this doesn't work, as pci_info
> calls implicitly append a newline anyway.
> =

> Restore the newline, and call pr_info with empty format string to set
> the loglevel for subsequent pr_cont calls. The same solution is used in
> EFI and uvesafb drivers.
> =

> Fixes: 9a295ff0ffc9 ("iommu/amd: Print extended features in one line to f=
ix divergent log levels")
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: iommu@lists.linux-foundation.org
> ---
> =A0drivers/iommu/amd/init.c | 5 ++++-
> =A01 file changed, 4 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 596d0c413473..a25e241eff1c 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1929,8 +1929,11 @@ static void print_iommu_info(void)
> =A0		pci_info(pdev, "Found IOMMU cap 0x%hx\n", iommu->cap_ptr);
> =A0
> =

> =A0		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
> -			pci_info(pdev, "Extended features (%#llx):",
> +			pci_info(pdev, "Extended features (%#llx):\n",
> =A0				 iommu->features);
> +
> +			pr_info("");
> +
> =A0			for (i =3D 0; i < ARRAY_SIZE(feat_str); ++i) {
> =A0				if (iommu_feature(iommu, (1ULL << i)))
> =A0					pr_cont(" %s", feat_str[i]);

This shouldn't be necessary.
If this is true then a lot of output logging code broke.



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
