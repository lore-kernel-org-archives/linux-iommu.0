Return-Path: <SRS0=1Qk8=EU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2F4C5519F
	for <iommu@archiver.kernel.org>; Sat, 14 Nov 2020 16:53:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF56D2080C
	for <iommu@archiver.kernel.org>; Sat, 14 Nov 2020 16:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF56D2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8890C872E1;
	Sat, 14 Nov 2020 16:53:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eTCKtHpiz+lW; Sat, 14 Nov 2020 16:53:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 25411872E3;
	Sat, 14 Nov 2020 16:53:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F048C088E;
	Sat, 14 Nov 2020 16:53:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C610C0800
 for <iommu@lists.linux-foundation.org>; Sat, 14 Nov 2020 16:53:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 00A5F876F2
 for <iommu@lists.linux-foundation.org>; Sat, 14 Nov 2020 16:53:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f2ecGyDVxqIx for <iommu@lists.linux-foundation.org>;
 Sat, 14 Nov 2020 16:53:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CFD9B87697
 for <iommu@lists.linux-foundation.org>; Sat, 14 Nov 2020 16:53:41 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id CD7B267373; Sat, 14 Nov 2020 17:53:36 +0100 (CET)
Date: Sat, 14 Nov 2020 17:53:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v3 1/2] dma-mapping: add benchmark support for
 streaming DMA APIs
Message-ID: <20201114165336.GA24844@lst.de>
References: <20201102080646.2180-1-song.bao.hua@hisilicon.com>
 <20201102080646.2180-2-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201102080646.2180-2-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Shuah Khan <shuah@kernel.org>, xuwei5@huawei.com,
 Will Deacon <will@kernel.org>, linuxarm@huawei.com,
 iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 robin.murphy@arm.com, hch@lst.de
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

Lots of > 80 char lines.  Please fix up the style.

I think this needs to set a dma mask as behavior for unlimited dma
mask vs the default 32-bit one can be very different.  I also think
you need to be able to pass the direction or have different tests
for directions.  bidirectional is not exactly heavily used and pays
more cache management penality.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
