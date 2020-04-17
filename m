Return-Path: <SRS0=1rof=6B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958CAC2BB1D
	for <iommu@archiver.kernel.org>; Fri, 17 Apr 2020 07:11:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E6E42083E
	for <iommu@archiver.kernel.org>; Fri, 17 Apr 2020 07:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6E42083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 648FA21F69;
	Fri, 17 Apr 2020 07:11:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fIxfv6HxHx7C; Fri, 17 Apr 2020 07:11:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A5C0020134;
	Fri, 17 Apr 2020 07:11:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A1F8C089E;
	Fri, 17 Apr 2020 07:11:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D6A3C0172
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 07:11:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7CD9488159
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 07:11:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZslNzpuB36gI for <iommu@lists.linux-foundation.org>;
 Fri, 17 Apr 2020 07:11:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 50C4988154
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 07:11:15 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id DFFFA68BEB; Fri, 17 Apr 2020 09:11:12 +0200 (CEST)
Date: Fri, 17 Apr 2020 09:11:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Rientjes <rientjes@google.com>
Subject: Re: [patch 0/7] unencrypted atomic DMA pools with dynamic expansion
Message-ID: <20200417071112.GD19153@lst.de>
References: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 Brijesh Singh <brijesh.singh@amd.com>, Jon Grimm <jon.grimm@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
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

So modulo a few comments that I can fix up myself this looks good.  Unless
you want to resend for some reason I'm ready to pick this up once I open
the dma-mapping tree after -rc2.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
