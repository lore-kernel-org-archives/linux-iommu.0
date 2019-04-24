Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758A2C282E1
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 15:08:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C1BA2089F
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 15:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1BA2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 12BAE102C;
	Wed, 24 Apr 2019 15:08:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EFDF81029
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 15:08:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9AB8D82E
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 15:08:48 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 558F767358; Wed, 24 Apr 2019 17:08:32 +0200 (CEST)
Date: Wed, 24 Apr 2019 17:08:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2 RFC/RFT 1/5] ARM: dma-mapping: Add fallback normal
	page allocations
Message-ID: <20190424150832.GA22474@lst.de>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
	<20190326230131.16275-2-nicoleotsuka@gmail.com>
	<20190424150638.GA22191@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190424150638.GA22191@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: tony@atomide.com, catalin.marinas@arm.com, will.deacon@arm.com,
	linux@armlinux.org.uk, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, hch@lst.de,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190424150832.DhBc3NlAnFd0O5Gz7W6Ro9MQpfqtm1EpFa1tDOREKbI@z>

On Wed, Apr 24, 2019 at 05:06:38PM +0200, Christoph Hellwig wrote:
>      I'd also use the oppurtunity to forbid a NULL dev argument and
>      opencode those uses.

Actually, looking at your last patch again the NULL argument might
still fit in ok, so maybe we should keep it.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
