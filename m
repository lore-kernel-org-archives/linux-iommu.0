Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5233C433EF
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 11:11:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72C6680DDB;
	Tue, 23 Nov 2021 11:11:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e7JhNr4Y2mXk; Tue, 23 Nov 2021 11:11:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5315E80DA8;
	Tue, 23 Nov 2021 11:11:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07784C001E;
	Tue, 23 Nov 2021 11:11:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B918C0012
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 11:11:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 52AAB4018E
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 11:11:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JtZvoZ1-zhKl for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 11:11:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 89B3E40164
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 11:11:21 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="234949115"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; d="scan'208";a="234949115"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2021 03:11:20 -0800
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; d="scan'208";a="497249160"
Received: from songallx-mobl.ccr.corp.intel.com (HELO [10.254.215.84])
 ([10.254.215.84])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2021 03:11:18 -0800
Message-ID: <016271ae-956e-23c1-8ff1-67fc108023b3@linux.intel.com>
Date: Tue, 23 Nov 2021 19:11:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/2] iommu/vt-d: Remove unused PASID_DISABLED
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20211123105507.7654-1-joro@8bytes.org>
 <20211123105507.7654-2-joro@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20211123105507.7654-2-joro@8bytes.org>
Cc: Joerg Roedel <jroedel@suse.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>
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

On 2021/11/23 18:55, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The macro is unused after commit 00ecd5401349a so it can be removed.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Fixes: 00ecd5401349a ("iommu/vt-d: Clean up unused PASID updating functions")

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   arch/x86/include/asm/fpu/api.h | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
> index 6053674f9132..c2767a6a387e 100644
> --- a/arch/x86/include/asm/fpu/api.h
> +++ b/arch/x86/include/asm/fpu/api.h
> @@ -102,12 +102,6 @@ extern void switch_fpu_return(void);
>    */
>   extern int cpu_has_xfeatures(u64 xfeatures_mask, const char **feature_name);
>   
> -/*
> - * Tasks that are not using SVA have mm->pasid set to zero to note that they
> - * will not have the valid bit set in MSR_IA32_PASID while they are running.
> - */
> -#define PASID_DISABLED	0
> -
>   /* Trap handling */
>   extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
>   extern void fpu_sync_fpstate(struct fpu *fpu);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
