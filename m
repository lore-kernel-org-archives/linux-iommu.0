Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DAEC433EF
	for <iommu@archiver.kernel.org>; Mon, 31 Jan 2022 15:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 22F22405A0;
	Mon, 31 Jan 2022 15:40:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id byDyULM-FdiV; Mon, 31 Jan 2022 15:40:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E5D9140236;
	Mon, 31 Jan 2022 15:40:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B996EC001A;
	Mon, 31 Jan 2022 15:40:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3C8EC000B
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 15:40:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB293409E3
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 15:40:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ba1-0Ysd-xXN for <iommu@lists.linux-foundation.org>;
 Mon, 31 Jan 2022 15:40:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 36AEB409C6
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 15:40:36 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id E61894DC; Mon, 31 Jan 2022 16:40:33 +0100 (CET)
Date: Mon, 31 Jan 2022 16:40:32 +0100
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: nvme: IO_PAGE_FAULT logged with Intel SSDPEKKF512G8
Message-ID: <YfgC8H/EJRLRpgES@8bytes.org>
References: <366b1545-fdea-3423-10a7-308ca2bef746@molgen.mpg.de>
 <20220118165325.GA3301052@dhcp-10-100-145-180.wdc.com>
 <fd1c1767-0029-58d2-3878-5bc1a85b8e2c@molgen.mpg.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fd1c1767-0029-58d2-3878-5bc1a85b8e2c@molgen.mpg.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Keith Busch <kbusch@kernel.org>
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

On Tue, Jan 18, 2022 at 06:01:06PM +0100, Paul Menzel wrote:
> > >      $ dmesg --level=err
> > >      [    4.194306] nvme 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000c address=0xffffc080 flags=0x0050]
> > >      [    4.206970] nvme 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000c address=0xffffc000 flags=0x0050]

This was caused by a DMA read to a write-only page. Looks like a bug in
the driver or the devices firmware.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
