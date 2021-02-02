Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32934C433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 01:31:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A33A264EC6
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 01:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33A264EC6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7483585A25;
	Tue,  2 Feb 2021 01:31:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MHseTLWkOFPd; Tue,  2 Feb 2021 01:31:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DF00784B35;
	Tue,  2 Feb 2021 01:31:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2B8FC0FA7;
	Tue,  2 Feb 2021 01:31:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 207C2C013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 01:31:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 070D4855A1
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 01:31:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AyThLk7-ddMD for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 01:31:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F015885621
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 01:31:03 +0000 (UTC)
X-UUID: cda5d4d113ca42bbb099e175ef846e14-20210202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=J3x52rLYllyw6VRGlPTtdTLgRiZI9s1w8kgapGIcpuo=; 
 b=b2t9H/HD7MO/64tenkUKzflw/fYrhq6naszlpBRPwLHbySkw4sGKW71GiLwn6YH0hnUi/y4+LhYe+iF2cpfp918y6G1LVvwVUF0Kl7zfEJFocU0KCzgel0gbTIn+7ZBUTkMb/HLiH/UW4gd9jTZl3/zbPMlQSNalDPx6gB94Y+Y=;
X-UUID: cda5d4d113ca42bbb099e175ef846e14-20210202
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 410525093; Tue, 02 Feb 2021 09:30:57 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 2 Feb 2021 09:30:50 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 2 Feb 2021 09:30:49 +0800
Message-ID: <1612229449.2524.2.camel@mhfsdcap03>
Subject: Re: [PATCH] iommu: Properly pass gfp_t in _iommu_map() to avoid
 atomic sleeping
From: Yong Wu <yong.wu@mediatek.com>
To: Douglas Anderson <dianders@chromium.org>
Date: Tue, 2 Feb 2021 09:30:49 +0800
In-Reply-To: <20210201170611.1.I64a7b62579287d668d7c89e105dcedf45d641063@changeid>
References: <20210201170611.1.I64a7b62579287d668d7c89e105dcedf45d641063@changeid>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D4D6B793B12B73E0D43EA4A0C2B613719A984C7639A6230D7A507072D26ECEAC2000:8
X-MTK: N
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, 2021-02-01 at 17:06 -0800, Douglas Anderson wrote:
> Sleeping while atomic = bad.  Let's fix an obvious typo to try to avoid it.
> 
> The warning that was seen (on a downstream kernel with the problematic
> patch backported):
> 
>  BUG: sleeping function called from invalid context at mm/page_alloc.c:4726
>  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 9, name: ksoftirqd/0
>  CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 5.4.93-12508-gc10c93e28e39 #1
>  Call trace:
>   dump_backtrace+0x0/0x154
>   show_stack+0x20/0x2c
>   dump_stack+0xa0/0xfc
>   ___might_sleep+0x11c/0x12c
>   __might_sleep+0x50/0x84
>   __alloc_pages_nodemask+0xf8/0x2bc
>   __arm_lpae_alloc_pages+0x48/0x1b4
>   __arm_lpae_map+0x124/0x274
>   __arm_lpae_map+0x1cc/0x274
>   arm_lpae_map+0x140/0x170
>   arm_smmu_map+0x78/0xbc
>   __iommu_map+0xd4/0x210
>   _iommu_map+0x4c/0x84
>   iommu_map_atomic+0x44/0x58
>   __iommu_dma_map+0x8c/0xc4
>   iommu_dma_map_page+0xac/0xf0
> 
> Fixes: d8c1df02ac7f ("iommu: Move iotlb_sync_map out from __iommu_map")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

oh. This is my fault. Thanks for the fix.

Reviewed-by: Yong Wu <yong.wu@mediatek.com>

> ---
> I haven't done any serious testing on this.  I saw a report of the
> warning and the fix seemed obvious so I'm shooting it out.
> 
>  drivers/iommu/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3d099a31ddca..2b06b01850d5 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2441,7 +2441,7 @@ static int _iommu_map(struct iommu_domain *domain, unsigned long iova,
>  	const struct iommu_ops *ops = domain->ops;
>  	int ret;
>  
> -	ret = __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
> +	ret = __iommu_map(domain, iova, paddr, size, prot, gfp);
>  	if (ret == 0 && ops->iotlb_sync_map)
>  		ops->iotlb_sync_map(domain, iova, size);
>  

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
