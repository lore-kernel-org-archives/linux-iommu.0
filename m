Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B46C433ED
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 06:11:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E76DC6127C
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 06:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76DC6127C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8FC5A40105;
	Tue, 20 Apr 2021 06:11:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vyvSjQPbMAdC; Tue, 20 Apr 2021 06:11:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0C6F040003;
	Tue, 20 Apr 2021 06:11:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E42B8C000F;
	Tue, 20 Apr 2021 06:11:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72AFAC000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 06:11:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4C54640105
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 06:11:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CMxnDK4588Qm for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 06:11:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4D21A40003
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 06:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=VtGKwlLzt3o9NMgYENh3GoR2m2ntsi4c0i/iVk3g+b0=; b=KJc8dDKOso7aewyB5hdF/M9Udy
 MJFlVN+fw0/ovRszP9qlI2D1dVX1Unx0DlfQMBXu/8B5zNzja2NRAwcbv9Hax+2208lVnYl4EQzDM
 dDzsBnXkPcIrhbt5+GGxdQJlZuNRSWdk9PSwFdbm6nVnfM/B33tSPYZnJiMGwJagLpEIHv1V8EMc9
 1b9DQtuLk+/Pcvpad9gemSkgNe83axRZwq+6+OR1iQs0SNSXPvBD4i6rQ4JEOOle03Lvr0PMVkRvb
 ajK7yNVB5eB6QHGkIW8XCyA1iHit+L7KevaB89YmWSGSnlyCRRHH0+L6CvPAGBksDlK26hvVKwwue
 8e6w2fhQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lYjaI-00EmxI-EI; Tue, 20 Apr 2021 06:10:11 +0000
Date: Tue, 20 Apr 2021 07:10:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH] pci: Rename pci_dev->untrusted to pci_dev->external
Message-ID: <20210420061006.GA3523612@infradead.org>
References: <20210420003049.1635027-1-rajatja@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210420003049.1635027-1-rajatja@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: rajatxjain@gmail.com, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 helgaas@kernel.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>
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

On Mon, Apr 19, 2021 at 05:30:49PM -0700, Rajat Jain wrote:
> The current flag name "untrusted" is not correct as it is populated
> using the firmware property "external-facing" for the parent ports. In
> other words, the firmware only says which ports are external facing, so
> the field really identifies the devices as external (vs internal).
> 
> Only field renaming. No functional change intended.

I don't think this is a good idea.  First the field should have been
added to the generic struct device as requested multiple times before.
Right now this requires horrible hacks in the IOMMU code to get at the
pci_dev, and also doesn't scale to various other potential users.

Second the untrusted is objectively a better name.  Because untrusted
is how we treat the device, which is what mattes.  External is just
how we come to that conclusion.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
