Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B651C433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 11:53:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1153C64F4F
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 11:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1153C64F4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C269E8678E;
	Tue,  2 Feb 2021 11:53:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fdQu7H9ICDci; Tue,  2 Feb 2021 11:53:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D5C0386749;
	Tue,  2 Feb 2021 11:53:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9F38C0174;
	Tue,  2 Feb 2021 11:53:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34D29C013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 11:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 269CE86749
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 11:53:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c6lQuGwy5h4a for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 11:53:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A966A866E2
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 11:53:07 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 949E264EDA;
 Tue,  2 Feb 2021 11:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1612266787;
 bh=BRH68+6vOxOQ4LInf/FRWhZDyh3A94ESv/43pW43Yt8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OJ8N1X8f4o+yVH+a6dN3B/AyPw/cXpDy9CSfhpaCFB9Pa2HmmOTPmoaihArZTNnal
 TmR/WYbIOe25gnkHYcuWdIdweGqctOyJgUioqJreKa2g9TO4uxZrNsAJa2EbDxh24A
 xiEodTo2bHyB5/pstyzXoaX6qrNTA/sMppxDmtLo=
Date: Tue, 2 Feb 2021 12:53:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jianxiong Gao <jxgao@google.com>
Subject: Re: [PATCH V2 0/3] SWIOTLB: Preserve swiotlb map offset when needed.
Message-ID: <YBk9HsrdvcUb50Kz@kroah.com>
References: <20210201183017.3339130-1-jxgao@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210201183017.3339130-1-jxgao@google.com>
Cc: axboe@fb.com, heikki.krogerus@linux.intel.com, sagi@grimberg.me,
 saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, kbusch@kernel.org, bgolaszewski@baylibre.com,
 iommu@lists.linux-foundation.org, jroedel@suse.de, dan.j.williams@intel.com,
 andriy.shevchenko@linux.intel.com, robin.murphy@arm.com, hch@lst.de
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

On Mon, Feb 01, 2021 at 10:30:14AM -0800, Jianxiong Gao wrote:
> NVMe driver and other applications may depend on the data offset
> to operate correctly. Currently when unaligned data is mapped via
> SWIOTLB, the data is mapped as slab aligned with the SWIOTLB. This
> patch adds an option to make sure the mapped data preserves its
> offset of the orginal addrss.
> 
> Without the patch when creating xfs formatted disk on NVMe backends,
> with swiotlb=force in kernel boot option, creates the following error:
> meta-data=/dev/nvme2n1   isize=512    agcount=4, agsize=131072 blks
>          =               sectsz=512   attr=2, projid32bit=1
>          =               crc=1        finobt=1, sparse=0, rmapbt=0, refl
> ink=0
> data     =               bsize=4096   blocks=524288, imaxpct=25
>          =               sunit=0      swidth=0 blks
> naming   =version 2      bsize=4096   ascii-ci=0 ftype=1
> log      =internal log   bsize=4096   blocks=2560, version=2
>          =               sectsz=512   sunit=0 blks, lazy-count=1
> realtime =none           extsz=4096   blocks=0, rtextents=0
> mkfs.xfs: pwrite failed: Input/output error
> 
> Jianxiong Gao (3):
>   Adding page_offset_mask to device_dma_parameters
>   Add swiotlb offset preserving mapping when
>     dma_dma_parameters->page_offset_mask is non zero.
>   Adding device_dma_parameters->offset_preserve_mask to NVMe driver.
> 
>  drivers/nvme/host/pci.c     |  4 ++++
>  include/linux/device.h      |  1 +
>  include/linux/dma-mapping.h | 17 +++++++++++++++++
>  kernel/dma/swiotlb.c        | 16 +++++++++++++++-
>  4 files changed, 37 insertions(+), 1 deletion(-)
> 
> -- 
> 2.27.0
> 

You forgot to mention somewhere, what changed from v1 to v2 :(
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
