Return-Path: <SRS0=MUIX=UD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B88C28CC6
	for <iommu@archiver.kernel.org>; Tue,  4 Jun 2019 06:06:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38BC924A43
	for <iommu@archiver.kernel.org>; Tue,  4 Jun 2019 06:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38BC924A43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DF225D90;
	Tue,  4 Jun 2019 06:06:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AE64AD8D
	for <iommu@lists.linux-foundation.org>;
	Tue,  4 Jun 2019 06:06:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 29A5519B
	for <iommu@lists.linux-foundation.org>;
	Tue,  4 Jun 2019 06:06:21 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id EF17568B02; Tue,  4 Jun 2019 08:05:54 +0200 (CEST)
Date: Tue, 4 Jun 2019 08:05:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 07/26] iommu/dma: move the arm64 wrappers to common code
Message-ID: <20190604060554.GA14536@lst.de>
References: <20190422175942.18788-1-hch@lst.de>
	<20190422175942.18788-8-hch@lst.de>
	<06b331f0-7df7-a6cd-954c-789f89a0836d@arm.com>
	<acb46c7f-0855-de30-485f-a6242968f947@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <acb46c7f-0855-de30-485f-a6242968f947@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	linux-tegra <linux-tegra@vger.kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	linux-arm-kernel@lists.infradead.org
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

On Mon, Jun 03, 2019 at 08:47:57PM +0100, Jon Hunter wrote:
> Since next-20190529 one of our tests for MMC has started failing, where
> the symptom is that the data written to the MMC does not match the
> source. Bisecting this is pointing to this commit. Unfortunately, I am
> not able to cleanly revert this on top of -next, but wanted to report
> this if case you have any ideas.

Does this fix your problem?

https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/commit/?h=generic-dma-ops&id=1b961423158caaae49d3900b7c9c37477bbfa9b3
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
