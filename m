Return-Path: <SRS0=d63v=UZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29700C48BD8
	for <iommu@archiver.kernel.org>; Wed, 26 Jun 2019 12:54:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0932C208E3
	for <iommu@archiver.kernel.org>; Wed, 26 Jun 2019 12:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0932C208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D0528C96;
	Wed, 26 Jun 2019 12:53:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D6119C8F
	for <iommu@lists.linux-foundation.org>;
	Wed, 26 Jun 2019 12:53:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6C230831
	for <iommu@lists.linux-foundation.org>;
	Wed, 26 Jun 2019 12:53:58 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 57FB268B05; Wed, 26 Jun 2019 14:53:25 +0200 (CEST)
Date: Wed, 26 Jun 2019 14:53:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Roger Quadros <rogerq@ti.com>
Subject: Re: SATA broken with LPAE
Message-ID: <20190626125325.GA4744@lst.de>
References: <16f065ef-f4ac-46b4-de2a-6b5420ae873a@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <16f065ef-f4ac-46b4-de2a-6b5420ae873a@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: axboe@kernel.dk, Vignesh Raghavendra <vigneshr@ti.com>,
	martin.petersen@oracle.com, linux-ide@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>, jejb@linux.ibm.com, "Nori,
	Sekhar" <nsekhar@ti.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	iommu@lists.linux-foundation.org, rmk+kernel@arm.linux.org.uk,
	linux-omap@vger.kernel.org, hch@lst.de
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

Hi Roger,

it seems the arm dma direct mapping code isn't doing the right thing
here.  On other platforms that have > 4G memory we always use swiotlb
for bounce buffering in case a device that can't DMA to all the memory.

Arm is the odd one out and uses its own dmabounce framework instead,
but it seems like it doesn't get used in this case.  We need to make
sure dmabounce (or swiotlb for that matter) is set up if > 32-bit
addressing is supported.  I'm not really an arm platform expert,
but some of those on the Cc list are and might chime in on how to
do that.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
