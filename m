Return-Path: <SRS0=xEY5=QC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E543C433FE
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 13:20:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A206E61B72
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 13:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A206E61B72
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 55699401E8;
	Mon, 15 Nov 2021 13:20:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tr-XJo1TI0xg; Mon, 15 Nov 2021 13:20:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ED0A440177;
	Mon, 15 Nov 2021 13:20:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C490FC002E;
	Mon, 15 Nov 2021 13:20:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01F08C0012
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 13:20:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D209760784
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 13:20:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mwlvJRNF5rK1 for <iommu@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 13:20:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 680D16076F
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 13:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Bu7e9ybFrYh6YTEgv80th636KP7aBwp9xQAbowAq/9s=; b=sb/7SKjX4arvamWu6kujZ05Kc/
 L76KKWIP2vu7KEnuWKrmcZft4WsAJOJXx63D264Cn9iL6S9P6Yf4XXdHxl1qD9RwOPE2wHmjvtc6R
 Xy8l3hWjjUZ705xERSTgq6zioSlayuImvoPCtTsXE+rnie9T6nU1jyfGH38K6yzjnvgQziKG1Q41k
 SJy/Z+Q9RbW2otqKZ+JChGE/cNHa+0IZYMOn+s3BNsn4Nph9foreVafwcRFJMknt1Z+b/dGYZX//M
 FgKMLLpebwl9C9yaahjF0F0uJYfJpX5QZxUDhrkDSTROq5R4c/ouW3s3V7he7IEjT6g4EfT+lRqVK
 +IyJNfJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mmbuE-00Fe2J-0O; Mon, 15 Nov 2021 13:20:18 +0000
Date: Mon, 15 Nov 2021 05:20:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 02/11] driver core: Set DMA ownership during driver
 bind/unbind
Message-ID: <YZJekd9tdz8cLAz+@infradead.org>
References: <20211115020552.2378167-1-baolu.lu@linux.intel.com>
 <20211115020552.2378167-3-baolu.lu@linux.intel.com>
 <YZIFPv7BpsTibxE/@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YZIFPv7BpsTibxE/@kroah.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org, rafael@kernel.org,
 linux-pci@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Will Deacon <will@kernel.org>
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

On Mon, Nov 15, 2021 at 07:59:10AM +0100, Greg Kroah-Hartman wrote:
> This feels wrong to be doing it in the driver core, why doesn't the bus
> that cares about this handle it instead?
> 
> You just caused all drivers in the kernel today to set and release this
> ownership, as none set this flag.  Shouldn't it be the other way around?
> 
> And again, why not in the bus that cares?
> 
> You only have problems with 1 driver out of thousands, this feels wrong
> to abuse the driver core this way for just that one.

This isn't really a bus thingy, but related to the IOMMU subsystem.
That being said as pointed out in my previous reply I'd expect this
to go along with other IOMMU setup.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
