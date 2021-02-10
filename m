Return-Path: <SRS0=5Lc9=HM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D806CC433E0
	for <iommu@archiver.kernel.org>; Wed, 10 Feb 2021 08:57:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 017F164E2F
	for <iommu@archiver.kernel.org>; Wed, 10 Feb 2021 08:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017F164E2F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84EB46F51A
	for <iommu@archiver.kernel.org>; Wed, 10 Feb 2021 08:57:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id djqmKfv6Qybc for <iommu@archiver.kernel.org>;
	Wed, 10 Feb 2021 08:57:36 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 11E876F4E9; Wed, 10 Feb 2021 08:57:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F2A86F4B9;
	Wed, 10 Feb 2021 08:57:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68B54C0174;
	Wed, 10 Feb 2021 08:57:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CE83C013A
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 08:57:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E2BA66F4B9
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 08:57:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dj0XXrTjas_m for <iommu@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 08:57:31 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 50FEF6F4E9; Wed, 10 Feb 2021 08:57:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C52AE6F4B9
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 08:57:29 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 37B6B6736F; Wed, 10 Feb 2021 09:57:25 +0100 (CET)
Date: Wed, 10 Feb 2021 09:57:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 4/6] MIPS: refactor the maybe coherent DMA indicators
Message-ID: <20210210085724.GA24610@lst.de>
References: <20210208145024.3320420-1-hch@lst.de>
 <20210208145024.3320420-5-hch@lst.de>
 <20210209131237.GB11915@alpha.franken.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210209131237.GB11915@alpha.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
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

On Tue, Feb 09, 2021 at 02:12:37PM +0100, Thomas Bogendoerfer wrote:
> > +#ifdef CONFIG_DMA_MAYBE_COHERENT
> > +extern bool dma_default_coherent;
> >  static inline bool dev_is_dma_coherent(struct device *dev)
> >  {
> > -	return coherentio == IO_COHERENCE_ENABLED ||
> > -		(coherentio == IO_COHERENCE_DEFAULT && hw_coherentio);
> > +	return dma_default_coherent;
> 
> this breaks overriding of coherentio via command line. plat_mem_setup/
> plat_setup_iocoherency is called before earlyparams are handled. So
> changing coherentio after that doesn't have any effect.

Hmm.  In that case a manual override does actually work for alchemy,
as that initializes coherentio from plat_mem_setup().  But the
elaborate sanity checking that malta performs in plat_setup_iocoherency
is rather pointless then, as coherentio will always be set to
IO_COHERENCE_DISABLED at this point.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
