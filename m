Return-Path: <SRS0=GPDh=E7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B212C6379D
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 11:13:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA7BB20857
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 11:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uahWelgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7BB20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2F3E886CA1;
	Wed, 25 Nov 2020 11:13:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BZZeiaj_uqCt; Wed, 25 Nov 2020 11:13:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A665B86C99;
	Wed, 25 Nov 2020 11:13:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F8B5C163C;
	Wed, 25 Nov 2020 11:13:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DD7DC0052
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 11:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 39A9D86DCF
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 11:13:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LH2Dgtl6C3a1 for <iommu@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 11:13:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 943FC86DCE
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 11:13:08 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5FECF206B7;
 Wed, 25 Nov 2020 11:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606302788;
 bh=rbevIJAsSB/iRPD2vJR1nkW2xROzISyxEwaJMCSnkso=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uahWelgQafXjRsuI496JVdUNxkEZm3JksQ9wJ1cwLh6puVI2ye4SNLrtruQL4fU4V
 UwWTo+hCjkW7fqNmMG4Qi6yOj6GcqoKnuediWkLgQ0DfOEXU/BVkN87icfKT45+m8X
 l9QM/ksIyV6ERAwsQpKuBYGIddyhVWQ4oOhKWgaA=
Date: Wed, 25 Nov 2020 11:13:02 +0000
From: Will Deacon <will@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH] iommu: Improve the performance for direct_mapping
Message-ID: <20201125111301.GB15239@willie-the-truck>
References: <20201120090628.6566-1-yong.wu@mediatek.com>
 <20201123123258.GC10233@willie-the-truck>
 <1606209884.26323.132.camel@mhfsdcap03>
 <20201124110520.GA12980@willie-the-truck>
 <1606302214.26323.141.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1606302214.26323.141.camel@mhfsdcap03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Tomasz Figa <tfiga@google.com>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, chao.hao@mediatek.com,
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

On Wed, Nov 25, 2020 at 07:03:34PM +0800, Yong Wu wrote:
> On Tue, 2020-11-24 at 11:05 +0000, Will Deacon wrote:
> > On Tue, Nov 24, 2020 at 05:24:44PM +0800, Yong Wu wrote:
> > > On Mon, 2020-11-23 at 12:32 +0000, Will Deacon wrote:
> > That said, maybe we could simplify this further by changing the loop bounds
> > to be:
> > 
> > 	for (addr = start; addr <= end; addr += pg_size)
> > 
> > and checking:
> > 
> > 	if (!phys_addr && addr != end) {
> > 		map_size += pg_size;
> > 		continue;
> > 	}
> > 
> > does that work?
> 
> It works but I think we can not check iommu_iova_to_phys(domain, end).
> We should add a "if", like:
> 
> for (addr = start; addr <= end; addr += pg_size) {
> ...
> 	if (addr < end) {
> 		phys_addr = iommu_iova_to_phys(domain, addr);
> 		if (!phys_addr) {
> 			map_size += pg_size;
> 			continue;
> 		}
> 	}
> ...
> 

Oh yes, you're right.

> If you don't like this "if (addr < end)", then we have to add a "goto".
> like this:
> 
> 
> for (addr = start; addr <= end; addr += pg_size) {
>  	phys_addr_t phys_addr;
>  
> 	if (addr == end)
> 		goto map_last;
> 
> 	phys_addr = iommu_iova_to_phys(domain, addr);
> 	if (!phys_addr) {
> 		map_size += pg_size;
> 		continue;
> 	}
> 
> map_last:
> 	if (!map_size)
> 		continue;
> 	ret = iommu_map(domain, addr - map_size,
> 			addr - map_size, map_size, entry->prot);

I think it's cleared to invert this as you had before:

	if (map_size)
		ret = iommu_map(...);

> Which one is better?

The second one is easier to read. I'll stop making suggestions now, thanks.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
