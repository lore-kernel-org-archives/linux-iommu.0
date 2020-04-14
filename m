Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CA4C2BB1D
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 06:44:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F40020735
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 06:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F40020735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 06EDF8637D;
	Tue, 14 Apr 2020 06:44:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 93BmX2LLkCtD; Tue, 14 Apr 2020 06:44:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 65AF5862C7;
	Tue, 14 Apr 2020 06:44:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B71FC1D7D;
	Tue, 14 Apr 2020 06:44:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81880C0172
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 06:44:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 656D720027
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 06:44:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y1vRjtaD6HoI for <iommu@lists.linux-foundation.org>;
 Tue, 14 Apr 2020 06:44:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by silver.osuosl.org (Postfix) with ESMTPS id BD0D31FEED
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 06:44:43 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id C623E68BEB; Tue, 14 Apr 2020 08:44:41 +0200 (CEST)
Date: Tue, 14 Apr 2020 08:44:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Rientjes <rientjes@google.com>
Subject: Re: [rfc v2 3/6] dma-pool: dynamically expanding atomic pools
Message-ID: <20200414064441.GC23359@lst.de>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com>
 <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com>
 <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com>
 <20200410145520.17864-1-hdanton@sina.com>
 <alpine.DEB.2.21.2004101231240.249689@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2004101231240.249689@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Hillf Danton <hdanton@sina.com>,
 "Singh, Brijesh" <brijesh.singh@amd.com>, "Grimm, Jon" <jon.grimm@amd.com>,
 linux <linux-kernel@vger.kernel.org>, iommu <iommu@lists.linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>
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

On Fri, Apr 10, 2020 at 12:37:20PM -0700, David Rientjes wrote:
> I'll rely on Christoph to determine whether it makes sense to add some 
> periodic scavening of the atomic pools, whether that's needed for this to 
> be merged, or wheter we should enforce some maximum pool size.

I don't really see the point.  In fact the only part of the series
I feel uneasy about is the growing of the pools, because it already
adds a fair amount of complexity that we might not need for simple
things, but shrinking really doesn't make any sense.  So I'm tempted
to not ever support shrinking, and even make growing optional code under
a new config variable.  We'll also need a way to query the current size
through e.g. a debugfs file.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
