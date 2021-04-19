Return-Path: <SRS0=soV1=JQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0203C433B4
	for <iommu@archiver.kernel.org>; Mon, 19 Apr 2021 19:23:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A386135F
	for <iommu@archiver.kernel.org>; Mon, 19 Apr 2021 19:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A386135F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CE506060D;
	Mon, 19 Apr 2021 19:23:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w3ONXFWo52BC; Mon, 19 Apr 2021 19:23:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C90A605A2;
	Mon, 19 Apr 2021 19:23:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAA39C000F;
	Mon, 19 Apr 2021 19:23:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9AAEC000B
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 19:23:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D783C83829
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 19:23:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xv-i0LSFABHu for <iommu@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 19:23:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F1D0B837D3
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 19:23:35 +0000 (UTC)
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTPS id 5E0EC4076B4A;
 Mon, 19 Apr 2021 19:23:23 +0000 (UTC)
Date: Mon, 19 Apr 2021 22:23:23 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2] iommu/amd: Fix extended features logging
In-Reply-To: <0362ad3912473d24e5927c0b54ed8fd3648c68a9.camel@perches.com>
Message-ID: <alpine.LNX.2.20.13.2104192207130.19608@monopod.intra.ispras.ru>
References: <20210411211330.2252-1-amonakov@ispras.ru>
 <0362ad3912473d24e5927c0b54ed8fd3648c68a9.camel@perches.com>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="168458499-251955098-1618860203=:19608"
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, iommu@lists.linux-foundation.org,
 Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--168458499-251955098-1618860203=:19608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Sun, 11 Apr 2021, Joe Perches wrote:

> > v2: avoid pr_info(""), change pci_info() to pr_info() for a nicer
> > solution
> > 
> >  drivers/iommu/amd/init.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> > index 596d0c413473..62913f82a21f 100644
> > --- a/drivers/iommu/amd/init.c
> > +++ b/drivers/iommu/amd/init.c
> > @@ -1929,8 +1929,8 @@ static void print_iommu_info(void)
> >  		pci_info(pdev, "Found IOMMU cap 0x%hx\n", iommu->cap_ptr);
> >  
> > 
> >  		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
> > -			pci_info(pdev, "Extended features (%#llx):",
> > -				 iommu->features);
> > +			pr_info("Extended features (%#llx):", iommu->features);
> > +
> >  			for (i = 0; i < ARRAY_SIZE(feat_str); ++i) {
> >  				if (iommu_feature(iommu, (1ULL << i)))
> >  					pr_cont(" %s", feat_str[i]);
> 
> How about avoiding all of this by using a temporary buffer
> and a single pci_info.

I think it is mostly up to the maintainers, but from my perspective, it's not
good to conflate such a simple bugfix with the substantial rewrite you are
proposing (which also increases code complexity).

My two-line patch is a straightforward fix to a bug that people already agreed
needs to be fixed (just the previous attempt turned out to be insufficient). If
there's a desire to eliminate pr_cont calls (which I wouldn't support in this
instance), the rewrite can go in separately from the bugfix.

A major problem with landing a simple bugfix together with a rewrite in a big
patch is that if a rewrite causes a problem, the whole patch gets reverted and
we end up without a trivial bugfix.

And, once again: can we please not emit the feature list via pci_info, the line
is long enough already even without the pci bus location info.

Joerg, are you satisfied with my v2 patch, are you waiting for anything before
picking it up?

Alexander

> 
> Miscellanea:
> o Move the feat_str and i declarations into the if block for locality
> 
> ---
>  drivers/iommu/amd/init.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 321f5906e6ed..0d219044726e 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1943,30 +1943,37 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
>  
>  static void print_iommu_info(void)
>  {
> -	static const char * const feat_str[] = {
> -		"PreF", "PPR", "X2APIC", "NX", "GT", "[5]",
> -		"IA", "GA", "HE", "PC"
> -	};
>  	struct amd_iommu *iommu;
>  
>  	for_each_iommu(iommu) {
>  		struct pci_dev *pdev = iommu->dev;
> -		int i;
>  
>  		pci_info(pdev, "Found IOMMU cap 0x%x\n", iommu->cap_ptr);
>  
>  		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
> -			pci_info(pdev, "Extended features (%#llx):",
> -				 iommu->features);
> +			static const char * const feat_str[] = {
> +				"PreF", "PPR", "X2APIC", "NX", "GT", "[5]",
> +				"IA", "GA", "HE", "PC"
> +			};
> +			int i;
> +			char features[128] = "";
> +			int len = 0;
> +
>  			for (i = 0; i < ARRAY_SIZE(feat_str); ++i) {
> -				if (iommu_feature(iommu, (1ULL << i)))
> -					pr_cont(" %s", feat_str[i]);
> +				if (!iommu_feature(iommu, BIT_ULL(i)))
> +					continue;
> +				len += scnprintf(features + len,
> +						 sizeof(features) - len,
> +						 " %s", feat_str[i]);
>  			}
>  
>  			if (iommu->features & FEATURE_GAM_VAPIC)
> -				pr_cont(" GA_vAPIC");
> +				len += scnprintf(features + len,
> +						 sizeof(features) - len,
> +						 " %s", "GA_vPIC");
>  
> -			pr_cont("\n");
> +			pci_info(pdev, "Extended features (%#llx):%s\n",
> +				 iommu->features, features);
>  		}
>  	}
>  	if (irq_remapping_enabled) {
> 
> 
> 
--168458499-251955098-1618860203=:19608
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--168458499-251955098-1618860203=:19608--
