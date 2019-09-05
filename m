Return-Path: <SRS0=Lu7X=XA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923EBC3A5AB
	for <iommu@archiver.kernel.org>; Thu,  5 Sep 2019 08:45:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70EA32070C
	for <iommu@archiver.kernel.org>; Thu,  5 Sep 2019 08:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70EA32070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 55862149B;
	Thu,  5 Sep 2019 08:45:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2A7891498
	for <iommu@lists.linux-foundation.org>;
	Thu,  5 Sep 2019 08:45:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id B70B4756
	for <iommu@lists.linux-foundation.org>;
	Thu,  5 Sep 2019 08:44:59 +0000 (UTC)
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
	by kirsty.vergenet.net (Postfix) with ESMTPA id D3A0125B753;
	Thu,  5 Sep 2019 18:44:58 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
	id C9EC1940AC6; Thu,  5 Sep 2019 10:44:56 +0200 (CEST)
Date: Thu, 5 Sep 2019 10:44:56 +0200
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 2/2] iommu/ipmmu-vmsa: Disable cache snoop transactions
	on R-Car Gen3
Message-ID: <20190905084456.bzbb2wpivignlyhr@verge.net.au>
References: <20190904120802.2163-1-geert+renesas@glider.be>
	<20190904120802.2163-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190904120802.2163-3-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: linux-renesas-soc@vger.kernel.org, Magnus Damm <damm+renesas@opensource.se>,
	iommu@lists.linux-foundation.org, Hai Nguyen Pham <hai.pham.ud@renesas.com>
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

On Wed, Sep 04, 2019 at 02:08:02PM +0200, Geert Uytterhoeven wrote:
> From: Hai Nguyen Pham <hai.pham.ud@renesas.com>
> 
> According to the Hardware Manual Errata for Rev. 1.50 of April 10, 2019,
> cache snoop transactions for page table walk requests are not supported
> on R-Car Gen3.
> 
> Hence, this patch removes setting these fields in the IMTTBCR register,
> since it will have no effect, and adds comments to the register bit
> definitions, to make it clear they apply to R-Car Gen2 only.
> 
> Signed-off-by: Hai Nguyen Pham <hai.pham.ud@renesas.com>
> [geert: Reword, add comments]
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
