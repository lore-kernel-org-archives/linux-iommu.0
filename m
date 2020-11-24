Return-Path: <SRS0=f5WA=E6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B229EC6379D
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 11:05:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 242752076B
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 11:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3SBAmZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242752076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3F9558711B;
	Tue, 24 Nov 2020 11:05:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kpLYxIumuXoR; Tue, 24 Nov 2020 11:05:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 859C287160;
	Tue, 24 Nov 2020 11:05:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3615BC0891;
	Tue, 24 Nov 2020 11:05:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 626AEC0052
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 11:05:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 50408859D1
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 11:05:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QClQE4FACNLq for <iommu@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 11:05:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D5F7B845A0
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 11:05:27 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9A41B20708;
 Tue, 24 Nov 2020 11:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606215927;
 bh=p7cS0enyaISQXUsFbBkJBL1aoa2MlX33h5/J260iXIw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F3SBAmZRTb54N/YAxmPu1vt5vCXgqcUrDxC/I6tq4FoRWdxlhKAXh24e2A3yq6vzm
 BgHxbhukrj9r3LrDIPXIc3Mwe2Guh38i3iRJEe4ZQjjNxebY2oBWMFXYq3afwnmKfK
 THIyImd3gme1xi91jEdzIxGCeTTwpRkoTNsv8iK8=
Date: Tue, 24 Nov 2020 11:05:21 +0000
From: Will Deacon <will@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH] iommu: Improve the performance for direct_mapping
Message-ID: <20201124110520.GA12980@willie-the-truck>
References: <20201120090628.6566-1-yong.wu@mediatek.com>
 <20201123123258.GC10233@willie-the-truck>
 <1606209884.26323.132.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1606209884.26323.132.camel@mhfsdcap03>
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

On Tue, Nov 24, 2020 at 05:24:44PM +0800, Yong Wu wrote:
> On Mon, 2020-11-23 at 12:32 +0000, Will Deacon wrote:
> > On Fri, Nov 20, 2020 at 05:06:28PM +0800, Yong Wu wrote:
> > > +				unmapped_sz = 0;
> > > +			}
> > > +			start += pg_size;
> > > +		}
> > > +		if (unmapped_sz) {
> > > +			ret = iommu_map(domain, start, start, unmapped_sz,
> > > +					entry->prot);
> > 
> > Can you avoid this hunk by changing your loop check to something like:
> > 
> > 	if (!phys_addr) {
> > 		map_size += pg_size;
> > 		if (addr + pg_size < end)
> > 			continue;
> > 	}
> 
> Thanks for your quick review. I have fixed and tested it. the patch is
> simple. I copy it here. Is this readable for you now?
> 
> 
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -737,6 +737,7 @@ static int
> iommu_create_device_direct_mappings(struct iommu_group *group,
>  	/* We need to consider overlapping regions for different devices */
>  	list_for_each_entry(entry, &mappings, list) {
>  		dma_addr_t start, end, addr;
> +		size_t map_size = 0;
>  
>  		if (domain->ops->apply_resv_region)
>  			domain->ops->apply_resv_region(dev, domain, entry);
> @@ -752,12 +753,21 @@ static int
> iommu_create_device_direct_mappings(struct iommu_group *group,
>  			phys_addr_t phys_addr;
>  
>  			phys_addr = iommu_iova_to_phys(domain, addr);
> -			if (phys_addr)
> -				continue;
> +			if (!phys_addr) {
> +				map_size += pg_size;
> +				if (addr + pg_size < end)
> +					continue;
> +				else

You don't need the 'else' here  ^^^

> +					addr += pg_size; /*Point to End */

addr = end ?

That said, maybe we could simplify this further by changing the loop bounds
to be:

	for (addr = start; addr <= end; addr += pg_size)

and checking:

	if (!phys_addr && addr != end) {
		map_size += pg_size;
		continue;
	}

does that work?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
