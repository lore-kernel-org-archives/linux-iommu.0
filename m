Return-Path: <SRS0=lzux=GQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88686C433DB
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 11:30:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 982D6233EA
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 11:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982D6233EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 21376871B8;
	Wed, 13 Jan 2021 11:30:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hfHXhTGl-R-x; Wed, 13 Jan 2021 11:30:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 09A5387126;
	Wed, 13 Jan 2021 11:30:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF26EC0893;
	Wed, 13 Jan 2021 11:30:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E18EAC013A;
 Wed, 13 Jan 2021 11:30:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CFD8484494;
 Wed, 13 Jan 2021 11:30:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MMVAa0aa74xz; Wed, 13 Jan 2021 11:30:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7CFBB84186;
 Wed, 13 Jan 2021 11:30:23 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0514168AFE; Wed, 13 Jan 2021 12:30:18 +0100 (CET)
Date: Wed, 13 Jan 2021 12:30:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Martin Radev <martin.b.radev@gmail.com>
Subject: Re: [PATCH] swiotlb: Validate bounce size in the sync/unmap path
Message-ID: <20210113113017.GA28106@lst.de>
References: <X/27MSbfDGCY9WZu@martin>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <X/27MSbfDGCY9WZu@martin>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: thomas.lendacky@amd.com, file@sect.tu-berlin.de,
 robert.buhren@sect.tu-berlin.de, kvm@vger.kernel.org, konrad.wilk@oracle.com,
 mathias.morbitzer@aisec.fraunhofer.de, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, hch@lst.de, kirill.shutemov@linux.intel.com
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

On Tue, Jan 12, 2021 at 04:07:29PM +0100, Martin Radev wrote:
> The size of the buffer being bounced is not checked if it happens
> to be larger than the size of the mapped buffer. Because the size
> can be controlled by a device, as it's the case with virtio devices,
> this can lead to memory corruption.
> 

I'm really worried about all these hodge podge hacks for not trusted
hypervisors in the I/O stack.  Instead of trying to harden protocols
that are fundamentally not designed for this, how about instead coming
up with a new paravirtualized I/O interface that is specifically
designed for use with an untrusted hypervisor from the start?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
