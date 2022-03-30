Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1F0C433EF
	for <iommu@archiver.kernel.org>; Wed, 30 Mar 2022 17:55:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7F23F40E08;
	Wed, 30 Mar 2022 17:55:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id et6k94-RtikN; Wed, 30 Mar 2022 17:55:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 48796401D5;
	Wed, 30 Mar 2022 17:55:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2137DC001D;
	Wed, 30 Mar 2022 17:55:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB908C0012
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 17:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BA4DF405A7
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 17:55:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qOBN51ymvSNT for <iommu@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 17:55:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C2C0401D5
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 17:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=SSKi39PDpsQvMNgCfkcWVHQSLGZLiPgFI8QRLkyxSyY=; b=SJnzdWhnhu1gvA7Efu9RcTl+A2
 z7PdgE1deeP5jyFNyL/D5kZe6Cm6S+bTlzBOgWYNmh/S2eSgdrZowCNHvTS9p6PyD486pRo1xa0y9
 TXmrU2cUfn9krlLbrfjVnMMBkdlv6rdZfEdZ1gOkgofp9tjPqbxPE3rUtm64kyqX6C9RKagXWhZjI
 sWkf0PuxUUppvonwUVDTrkSC/i/wksPR5LQkqbCx5YQjq/dSkc7/zrk3Hgr5G1l/2zi9L0ohR4FqP
 4lEHJLXc9bKF3apW3rCT+Z5PA9dwunQsc9IvwtvKkQ7yUXMaQzbkPt9qfzkKIKFo4/FS98bx8iJbL
 wV2ozBuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nZcXX-00H3Sa-Pd; Wed, 30 Mar 2022 17:55:27 +0000
Date: Wed, 30 Mar 2022 10:55:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: "dma-mapping: remove CONFIG_DMA_REMAP" causes AMD SME boot fail
Message-ID: <YkSZjwDfD+EFuenm@infradead.org>
References: <1648659326.eabkokyuym.none.ref@localhost>
 <1648659326.eabkokyuym.none@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1648659326.eabkokyuym.none@localhost>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Wed, Mar 30, 2022 at 01:51:07PM -0400, Alex Xu (Hello71) wrote:
> Hi,
> 
> After a recent kernel update, booting one of my machines causes it to 
> hang on a black screen. Pressing Lock keys on the USB keyboard does not 
> turn on the indicators, and the machine does not appear on the Ethernet 
> network. I don't have a serial port on this machine. I didn't try 
> netconsole, but I suspect it won't work.
> 
> Setting mem_encrypt=0 seems to resolve the issue. Reverting f5ff79fddf0e 
> ("dma-mapping: remove CONFIG_DMA_REMAP") also appears to resolve the 
> issue.
> 
> The machine in question has an AMD Ryzen 5 1600 and ASRock B450 Pro4.

This looks like something in the AMD IOMMU code or it's users can't
deal with vmalloc addresses.  I'll start looking for a culprit ASAP.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
