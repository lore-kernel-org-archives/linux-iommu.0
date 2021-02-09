Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE21C433DB
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 09:41:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEBF464E85
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 09:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEBF464E85
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 927C387275;
	Tue,  9 Feb 2021 09:41:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g9e5VFV3BBq4; Tue,  9 Feb 2021 09:41:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C083A870F0;
	Tue,  9 Feb 2021 09:41:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8791C1834;
	Tue,  9 Feb 2021 09:41:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 943E3C013A;
 Tue,  9 Feb 2021 09:41:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8331885784;
 Tue,  9 Feb 2021 09:41:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PiTXot-eZo03; Tue,  9 Feb 2021 09:41:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 253A085624;
 Tue,  9 Feb 2021 09:41:22 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 313FB67373; Tue,  9 Feb 2021 09:26:24 +0100 (CET)
Date: Tue, 9 Feb 2021 09:26:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] swiotlb: Validate bounce size in the sync/unmap path
Message-ID: <20210209082623.GA31955@lst.de>
References: <X/27MSbfDGCY9WZu@martin> <20210113113017.GA28106@lst.de>
 <YAV0uhfkimXn1izW@martin> <20210203124922.GB16923@lst.de>
 <20210203193638.GA325136@fedora> <20210205175852.GA1021@lst.de>
 <YCFxiTB//Iz6aIhk@Konrads-MacBook-Pro.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YCFxiTB//Iz6aIhk@Konrads-MacBook-Pro.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Martin Radev <martin.b.radev@gmail.com>, thomas.lendacky@amd.com,
 file@sect.tu-berlin.de, robert.buhren@sect.tu-berlin.de, kvm@vger.kernel.org,
 mathias.morbitzer@aisec.fraunhofer.de, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, Christoph Hellwig <hch@lst.de>,
 kirill.shutemov@linux.intel.com
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

On Mon, Feb 08, 2021 at 12:14:49PM -0500, Konrad Rzeszutek Wilk wrote:
> > ring buffer or whatever because you know I/O will be copied anyway
> > and none of all the hard work higher layers do to make the I/O suitable
> > for a normal device apply.
> 
> I lost you here. Sorry, are you saying have a simple ring protocol
> (like NVME has), where the ring entries (SG or DMA phys) are statically
> allocated and whenever NVME driver gets data from user-space it
> would copy it in there?

Yes.  Basically extend the virtio or NVMe ring/queue concept to not just
cover commands and completions, but also the data transfers.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
