Return-Path: <SRS0=jcR/=E5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C12C2D0E4
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 12:33:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 179242076E
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 12:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wRhhY5oD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179242076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 77BD48676E;
	Mon, 23 Nov 2020 12:33:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YfV-AAPIT8tR; Mon, 23 Nov 2020 12:33:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 85F3F86767;
	Mon, 23 Nov 2020 12:33:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70298C163C;
	Mon, 23 Nov 2020 12:33:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A926C0052
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 12:33:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 65633870D3
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 12:33:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AN7XuQGAwwRt for <iommu@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 12:33:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9988587075
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 12:33:05 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 769942076E;
 Mon, 23 Nov 2020 12:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606134785;
 bh=0QSv09rGW0WuAiAunEEQ7oj/27dyFGEZgt+e6cLrLtI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wRhhY5oDR9O6SI4elKUy6j4JiYwRnLeUIusACXuaJrzeN9ZZiguwygT+Vh+BIK5bn
 1QQ4VhGF8+m8rzx/29h0VjrBkQpBujH/X1jgFMI76jBaK+oDdnmWyGqrWuW6MUTBOc
 5iEqZjkGYXfposO9rTtzNODSeMyzzsozvxw40LXc=
Date: Mon, 23 Nov 2020 12:32:58 +0000
From: Will Deacon <will@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH] iommu: Improve the performance for direct_mapping
Message-ID: <20201123123258.GC10233@willie-the-truck>
References: <20201120090628.6566-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201120090628.6566-1-yong.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

On Fri, Nov 20, 2020 at 05:06:28PM +0800, Yong Wu wrote:
> Currently direct_mapping always use the smallest pgsize which is SZ_4K
> normally to mapping. This is unnecessary. we could gather the size, and
> call iommu_map then, iommu_map could decide how to map better with the
> just right pgsize.
> 
> From the original comment, we should take care overlap, otherwise,
> iommu_map may return -EEXIST. In this overlap case, we should map the
> previous region before overlap firstly. then map the left part.
> 
> Each a iommu device will call this direct_mapping when its iommu
> initialize, This patch is effective to improve the boot/initialization
> time especially while it only needs level 1 mapping.
> 
> Signed-off-by: Anan Sun <anan.sun@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/iommu.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index df87c8e825f7..854a8fcb928d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -737,6 +737,7 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
>  	/* We need to consider overlapping regions for different devices */
>  	list_for_each_entry(entry, &mappings, list) {
>  		dma_addr_t start, end, addr;
> +		size_t unmapped_sz = 0;

I think "unmapped" is the wrong word here, as this variable actually
represents the amount we want to map! I suggest "map_size" instead.

>  		if (domain->ops->apply_resv_region)
>  			domain->ops->apply_resv_region(dev, domain, entry);
> @@ -752,10 +753,25 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
>  			phys_addr_t phys_addr;
>  
>  			phys_addr = iommu_iova_to_phys(domain, addr);
> -			if (phys_addr)
> +			if (phys_addr == 0) {
> +				unmapped_sz += pg_size; /* Gather the size. */
>  				continue;
> +			}
>  
> -			ret = iommu_map(domain, addr, addr, pg_size, entry->prot);
> +			if (unmapped_sz) {
> +				/* Map the region before the overlap. */
> +				ret = iommu_map(domain, start, start,
> +						unmapped_sz, entry->prot);
> +				if (ret)
> +					goto out;
> +				start += unmapped_sz;

I think it's a bit confusing to update start like this. Can we call
iommu_map(domain, addr - map_size, addr - map_size, map_size, entry->prot)
instead?

> +				unmapped_sz = 0;
> +			}
> +			start += pg_size;
> +		}
> +		if (unmapped_sz) {
> +			ret = iommu_map(domain, start, start, unmapped_sz,
> +					entry->prot);

Can you avoid this hunk by changing your loop check to something like:

	if (!phys_addr) {
		map_size += pg_size;
		if (addr + pg_size < end)
			continue;
	}

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
