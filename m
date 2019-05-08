Return-Path: <SRS0=jTem=TI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67580C04AAD
	for <iommu@archiver.kernel.org>; Wed,  8 May 2019 17:52:42 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44131216F4
	for <iommu@archiver.kernel.org>; Wed,  8 May 2019 17:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44131216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 16D72AEF;
	Wed,  8 May 2019 17:52:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7D6425AA
	for <iommu@lists.linux-foundation.org>;
	Wed,  8 May 2019 17:52:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EF958196
	for <iommu@lists.linux-foundation.org>;
	Wed,  8 May 2019 17:52:39 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id C491667358; Wed,  8 May 2019 19:52:19 +0200 (CEST)
Date: Wed, 8 May 2019 19:52:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jon Mason <jdmason@kudzu.us>
Subject: Re: status of the calgary iommu driver
Message-ID: <20190508175219.GA32030@lst.de>
References: <20190409140347.GA11524@lst.de>
	<CAPoiz9wwMCRkzM5FWm18kecC1=kt+5qPNHmQ7eUFhH=3ZNAqYw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPoiz9wwMCRkzM5FWm18kecC1=kt+5qPNHmQ7eUFhH=3ZNAqYw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	iommu@lists.linux-foundation.org, x86@kernel.org,
	Christoph Hellwig <hch@lst.de>, Muli Ben-Yehuda <mulix@mulix.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Wed, May 08, 2019 at 06:42:39PM +0100, Jon Mason wrote:
> These systems were plentiful for 2-4 years after the original series
> made it in.  After that, the Intel and AMD IOMMUs should were shipped
> and were superior to this chip.  So, even in systems where these might
> be present, the AMD/Intel ones should be used (unknown if they were
> shipped on the same ones, as both Muli and I have left IBM).
> 
> You thinking about removing the code?

I'm wondering if we could remove it.  I've been done lots of
maintainance on various dma mapping and iommu drivers, and the calgary
one seems like it didn't get a whole lot of love, and I've not seen
any recent users, so I mostly wonder if I should bother at all.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
