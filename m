Return-Path: <SRS0=PBOI=OA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E359BC433F5
	for <iommu@archiver.kernel.org>; Fri, 10 Sep 2021 10:23:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 451F861100
	for <iommu@archiver.kernel.org>; Fri, 10 Sep 2021 10:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 451F861100
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F276640694;
	Fri, 10 Sep 2021 10:23:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nNEWI9hhyC5x; Fri, 10 Sep 2021 10:23:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DCD2940683;
	Fri, 10 Sep 2021 10:23:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B14E7C000F;
	Fri, 10 Sep 2021 10:23:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10B80C000D
 for <iommu@lists.linux-foundation.org>; Fri, 10 Sep 2021 10:23:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ED0F180E03
 for <iommu@lists.linux-foundation.org>; Fri, 10 Sep 2021 10:23:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IW30XkZDpWbX for <iommu@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 10:23:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1EB1580DED
 for <iommu@lists.linux-foundation.org>; Fri, 10 Sep 2021 10:23:10 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id BEA7067357; Fri, 10 Sep 2021 12:23:06 +0200 (CEST)
Date: Fri, 10 Sep 2021 12:23:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: DPAA2 triggers, [PATCH] dma debug: report -EEXIST errors in
 add_dma_entry
Message-ID: <20210910102306.GA13863@lst.de>
References: <20210518125443.34148-1-someguy@effective-light.com>
 <fd67fbac-64bf-f0ea-01e1-5938ccfab9d0@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fd67fbac-64bf-f0ea-01e1-5938ccfab9d0@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Hamza Mahfooz <someguy@effective-light.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Dan Williams <dan.j.williams@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Wed, Sep 08, 2021 at 10:33:26PM -0500, Jeremy Linton wrote:
> PS, it might not hurt to rate limit/_once this somehow to avoid a runtime 
> problem if it starts to trigger.

Yes, that might be a good idea.  Care to prepare a patch?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
