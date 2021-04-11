Return-Path: <SRS0=/53O=JI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE546C433B4
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 06:41:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71770610A8
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 06:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71770610A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38A5740395;
	Sun, 11 Apr 2021 06:41:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xglfuywWk0_o; Sun, 11 Apr 2021 06:41:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FA0640394;
	Sun, 11 Apr 2021 06:41:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBEC5C000B;
	Sun, 11 Apr 2021 06:41:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC0BCC000A
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 06:41:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B657783ACD
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 06:41:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SjGoY53zTvX0 for <iommu@lists.linux-foundation.org>;
 Sun, 11 Apr 2021 06:41:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 06C2B83AC9
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 06:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=acFKTT6j+VIJs5Iv9WmiwQ+Ih1xaWJpjPGlz3k/Bpuc=; b=WCUkIBI9Ib2tmGjLv1koAFK6xW
 wnmntCyQWuznBzTiEY5H18tqoRToqfsAJefuz3l+tVWdmuLf1GCa4oDJenwVYdx9GIklbM2naDP0v
 YmG1/hObiuIByileOSBUu2aj1+pUyjtIE2eUgLiOr+9ltXjjyFgcuHO3DCoG6dI+MceYy3rwP2dGM
 HfwmeYA9xZW6xWZD0W4qgqTdWq2z+GG58iU6mH0OKY5pzIq8HdxVpI1VA3ZsS5u09MNFz8X2OgYQm
 bc4lFqMX11kJ9A3RqZ/YD0qPhlyYnte5Xw1xKb6VpzNlk32C4ic7VaG/IQGCHnzCT9Zp8DkPEvw19
 S4RDhfgg==;
Received: from [2601:1c0:6280:3f0::e0e1]
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lVTm4-002ets-4l; Sun, 11 Apr 2021 06:40:49 +0000
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix build error of pasid_enable_wpe()
 with !X86
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <20210411062312.3057579-1-baolu.lu@linux.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6a36c635-5f88-6264-e9c8-62ea6c5d771e@infradead.org>
Date: Sat, 10 Apr 2021 23:40:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210411062312.3057579-1-baolu.lu@linux.intel.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, Sanjay Kumar <sanjay.k.kumar@intel.com>,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
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

On 4/10/21 11:23 PM, Lu Baolu wrote:
> Commit f68c7f539b6e9 ("iommu/vt-d: Enable write protect for supervisor
> SVM") added pasid_enable_wpe() which hit below compile error with !X86.
> 
> ../drivers/iommu/intel/pasid.c: In function 'pasid_enable_wpe':
> ../drivers/iommu/intel/pasid.c:554:22: error: implicit declaration of function 'read_cr0' [-Werror=implicit-function-declaration]
>   554 |  unsigned long cr0 = read_cr0();
>       |                      ^~~~~~~~
> In file included from ../include/linux/build_bug.h:5,
>                  from ../include/linux/bits.h:22,
>                  from ../include/linux/bitops.h:6,
>                  from ../drivers/iommu/intel/pasid.c:12:
> ../drivers/iommu/intel/pasid.c:557:23: error: 'X86_CR0_WP' undeclared (first use in this function)
>   557 |  if (unlikely(!(cr0 & X86_CR0_WP))) {
>       |                       ^~~~~~~~~~
> ../include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
>    78 | # define unlikely(x) __builtin_expect(!!(x), 0)
>       |                                          ^
> ../drivers/iommu/intel/pasid.c:557:23: note: each undeclared identifier is reported only once for each function it appears in
>   557 |  if (unlikely(!(cr0 & X86_CR0_WP))) {
>       |                       ^~~~~~~~~~
> ../include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
>    78 | # define unlikely(x) __builtin_expect(!!(x), 0)
>       |
> 
> Add the missing dependency.
> 
> Cc: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: f68c7f539b6e9 ("iommu/vt-d: Enable write protect for supervisor SVM")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


Thanks.

> ---
>  drivers/iommu/intel/pasid.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 477b2e1d303c..72646bafc52f 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -551,6 +551,7 @@ static void pasid_flush_caches(struct intel_iommu *iommu,
>  
>  static inline int pasid_enable_wpe(struct pasid_entry *pte)
>  {
> +#ifdef CONFIG_X86
>  	unsigned long cr0 = read_cr0();
>  
>  	/* CR0.WP is normally set but just to be sure */
> @@ -558,6 +559,7 @@ static inline int pasid_enable_wpe(struct pasid_entry *pte)
>  		pr_err_ratelimited("No CPU write protect!\n");
>  		return -EINVAL;
>  	}
> +#endif
>  	pasid_set_wpe(pte);
>  
>  	return 0;
> 


-- 
~Randy

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
