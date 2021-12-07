Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730FFC433F5
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 11:48:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EDED60724;
	Tue,  7 Dec 2021 11:48:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4c_ED_60jxb4; Tue,  7 Dec 2021 11:48:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 29B24606E2;
	Tue,  7 Dec 2021 11:48:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08397C001E;
	Tue,  7 Dec 2021 11:48:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8F3DC0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 11:48:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E50BA80DA1
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 11:48:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bt3ObJFgtLxj for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 11:48:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A00A80C5F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 11:48:52 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id C610868AFE; Tue,  7 Dec 2021 12:48:47 +0100 (CET)
Date: Tue, 7 Dec 2021 12:48:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 03/11] dma-direct: always leak memory that can't be
 re-encrypted
Message-ID: <20211207114847.GA20713@lst.de>
References: <20211111065028.32761-1-hch@lst.de>
 <20211111065028.32761-4-hch@lst.de>
 <6a8f8c40-a3bd-9dac-fbf1-8feeca8ac554@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a8f8c40-a3bd-9dac-fbf1-8feeca8ac554@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
 David Rientjes <rientjes@google.com>
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

On Mon, Dec 06, 2021 at 04:32:58PM +0000, Robin Murphy wrote:
> On 2021-11-11 06:50, Christoph Hellwig wrote:
>> We must never unencryped memory go back into the general page pool.
>> So if we fail to set it back to encrypted when freeing DMA memory, leak
>> the memory insted and warn the user.
>
> Nit: typos of "unencrypted" and "instead". Plus presumably the first 
> sentence was meant to have a "let" or similar in there too.

Fixed.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
