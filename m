Return-Path: <SRS0=1/MC=HT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F153C433E0
	for <iommu@archiver.kernel.org>; Wed, 17 Feb 2021 18:10:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C239764E4B
	for <iommu@archiver.kernel.org>; Wed, 17 Feb 2021 18:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C239764E4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8BCB287213;
	Wed, 17 Feb 2021 18:10:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TpRyN5Xjlgcr; Wed, 17 Feb 2021 18:10:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1512C87165;
	Wed, 17 Feb 2021 18:10:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA394C0174;
	Wed, 17 Feb 2021 18:10:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BA2BC013A
 for <iommu@lists.linux-foundation.org>; Wed, 17 Feb 2021 18:10:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 18A268669F
 for <iommu@lists.linux-foundation.org>; Wed, 17 Feb 2021 18:10:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 13ROend5AWNH for <iommu@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 18:10:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9D98A863FD
 for <iommu@lists.linux-foundation.org>; Wed, 17 Feb 2021 18:10:07 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF80664E42;
 Wed, 17 Feb 2021 18:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613585407;
 bh=0Z0WorCxaD7BP56hnkNMqdSiCglGFGlqAwsbSLCh6m8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DomK4OPIHSzryzMWD5lTcExqL1chGXqVrXzu9LoLydAPrkFf74FsawJICKWnt1zWI
 q/KJDAtzBK0+DcQxYKC8mRmCTx/OdNROykkMOmkda4Pt0NX1x+J4uz4QfbMAFIyyyt
 /ldV/cm2fyYDcojGz4m2mitcaJknMpOXR66i4TBDaY+7hCMayTqa5tFicFYdsPRaEx
 aaCqO/zycLaUsiMFLcteS6hyBTRyZxwgfuFCkTPLbkT6yTcVSbT6aPeZ+t1fCxghBV
 HbpBcx4xDe+WnFP9gd2WEcFUm9g39+iVELWLsCMO1fDXQd6efesRCk7BD3IHzsE5W0
 rtbd55DCpwibA==
Date: Wed, 17 Feb 2021 18:10:02 +0000
From: Will Deacon <will@kernel.org>
To: Andrey Ryabinin <arbn@yandex-team.com>
Subject: Re: [PATCH] iommu/amd: Fix sleeping in atomic in
 increase_address_space()
Message-ID: <20210217181002.GC4304@willie-the-truck>
References: <20210217143004.19165-1-arbn@yandex-team.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210217143004.19165-1-arbn@yandex-team.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: valesini@yandex-team.ru, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, iommu@lists.linux-foundation.org,
 Qian Cai <cai@lca.pw>
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

On Wed, Feb 17, 2021 at 05:30:04PM +0300, Andrey Ryabinin wrote:
> increase_address_space() calls get_zeroed_page(gfp) under spin_lock with
> disabled interrupts. gfp flags passed to increase_address_space() may allow
> sleeping, so it comes to this:
> 
>  BUG: sleeping function called from invalid context at mm/page_alloc.c:4342
>  in_atomic(): 1, irqs_disabled(): 1, pid: 21555, name: epdcbbf1qnhbsd8
> 
>  Call Trace:
>   dump_stack+0x66/0x8b
>   ___might_sleep+0xec/0x110
>   __alloc_pages_nodemask+0x104/0x300
>   get_zeroed_page+0x15/0x40
>   iommu_map_page+0xdd/0x3e0
>   amd_iommu_map+0x50/0x70
>   iommu_map+0x106/0x220
>   vfio_iommu_type1_ioctl+0x76e/0x950 [vfio_iommu_type1]
>   do_vfs_ioctl+0xa3/0x6f0
>   ksys_ioctl+0x66/0x70
>   __x64_sys_ioctl+0x16/0x20
>   do_syscall_64+0x4e/0x100
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Fix this by moving get_zeroed_page() out of spin_lock/unlock section.
> 
> Fixes: 754265bcab ("iommu/amd: Fix race in increase_address_space()")
> Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/iommu/amd/iommu.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
