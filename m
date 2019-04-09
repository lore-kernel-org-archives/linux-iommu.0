Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA014C10F0E
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 09:57:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B096220857
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 09:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B096220857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 77DBC1083;
	Tue,  9 Apr 2019 09:57:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4BAD9107B
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 09:57:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D3614CF
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 09:57:52 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id A73E668B02; Tue,  9 Apr 2019 11:57:40 +0200 (CEST)
Date: Tue, 9 Apr 2019 11:57:40 +0200
From: "hch@lst.de" <hch@lst.de>
To: Thomas Hellstrom <thellstrom@vmware.com>
Subject: Re: revert dma direct internals abuse
Message-ID: <20190409095740.GE6827@lst.de>
References: <20190408105525.5493-1-hch@lst.de>
	<7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Deepak Singh Rawat <drawat@vmware.com>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"hch@lst.de" <hch@lst.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
Message-ID: <20190409095740.a1FucQ3mQCWguPhXMDa6tLcTz2KrXrKafF3RW0N5ybw@z>

On Mon, Apr 08, 2019 at 06:47:52PM +0000, Thomas Hellstrom wrote:
> We HAVE discussed our needs, although admittedly some of my emails
> ended up unanswered.

And than you haven't followed up, and instead ignored the layering
instructions and just commited a broken patch?

> We've as you're well aware of had a discussion with the other
> subsystems doing user-space DMA-buffers wanting this functionality from
> the dma api (AMD graphics and RDMA people IIRC). that is a bool that
> tells us whether streaming dma mappings are coherent, and I described
> in detail why we couldn't use the dma_sync_* API and
> dma_alloc_coherent().

And that is not at all what you either check or claim to do in the
changelog (which btw, are two different things).

> The other option we have is to just fail miserably without messages if
> streaming DMA is not coherent, which I think the other drivers might
> do... That's all I'm trying to avoid here. I'd much prefer to have the
> dma API export this bool.

Both DMA direct and non-DMA direct streaming mappings can be either
coherent or incoherent, so your patch doesn't archive that.  The
commit log claims the following:

"drm/vmwgfx: Improve on IOMMU detection
    
 instead of relying on intel_iommu_enabled, use the fact that the
 dma_map_ops::map_page != dma_direct_map_page"

which has nothing to do with the fact that streaming mappings are
coherent.  It also is incorrect as there are direct mapping that
do not use dma_direct_map_page (e.g. on ARM, or x86 with VMD).
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
