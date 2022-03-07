Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FF0C433EF
	for <iommu@archiver.kernel.org>; Mon,  7 Mar 2022 07:58:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF89860BF0;
	Mon,  7 Mar 2022 07:58:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V9JZuaHfYaPS; Mon,  7 Mar 2022 07:58:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A402F60B17;
	Mon,  7 Mar 2022 07:58:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82B23C001D;
	Mon,  7 Mar 2022 07:58:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D272C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 07:58:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C75B8183D
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 07:58:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NV5BrWJACzZa for <iommu@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 07:58:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 637A7817F5
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 07:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=SBkufQbkk7WS7cnTX6Fdy468qPhDhtk/GXWCSTup/Tk=; b=xQj49Z6kmfBylR8KA/UdSDpvUz
 2HQJ0OZ3qRoMv5IeF0IQ/68p+VdqWxJ4qG7BGTzd6ru4qeiILLEFi3OuVN/MqLS00YT/OG4KJeJoO
 AR5oik0TyTpTYSTCXokA78CHsVWLIlAqCXVOaWPhQeYx6wJbIlkUdS9Z55Pjkp6PtzDsZSs8kVtK+
 f3UYXsB7Hh3XGQqWr+QeIfKuvwVJA3e2H772HR57Q1DJV/B0QAWzzH2zpoTs0n4YeNJZodhYXs6HO
 mcnivCjVE2R+/Rm+XSDVmJXDdzi/GD1D1SRLhS/wLNhnxtg4wFtY44x2Ts8nxKQOiWN5qBNNXIyzp
 TAAlsP9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nR8Fo-00GMXh-RF; Mon, 07 Mar 2022 07:58:04 +0000
Date: Sun, 6 Mar 2022 23:58:04 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 1/1] swiotlb: rework "fix info leak with
 DMA_FROM_DEVICE"
Message-ID: <YiW7DMRymTV/zvDb@infradead.org>
References: <20220305170714.2043896-1-pasic@linux.ibm.com>
 <CAHk-=wgZ6fNG03pd2pAVw9RtymwPDyHNvTLHr2Q3LX3S0Y1k5Q@mail.gmail.com>
 <YiRpuGbjyU2M47pQ@infradead.org>
 <CAHk-=wgQGLgqqgsKXUCykiK9B1UwdCj2-NvDkBAuYhSgdtAmkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wgQGLgqqgsKXUCykiK9B1UwdCj2-NvDkBAuYhSgdtAmkQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, stable <stable@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu <iommu@lists.linux-foundation.org>, Doug Gilbert <dgilbert@interlog.com>,
 Halil Pasic <pasic@linux.ibm.com>, Robin Murphy <robin.murphy@arm.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
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

On Sun, Mar 06, 2022 at 12:30:55PM -0800, Linus Torvalds wrote:
> So I would expect that
> 
>  (a) READ/WRITE actually fills the whole buffer
> 
>  (b) READ/WRITE are the only ones where we care about performance at a
> bounce-buffer level
> 
> so it boils down to "do we still do this horrible memcpy even for
> regular IO commands"? Because that would, in my opinion, just be
> stupid.

For one thing this is not just for block I/O, but for all DMA.
Second, "normal" I/O might always fail, including after partial
transfers.  SCSI even considers that normal.  Network devices consider
it normal to not fill the entiret receive buffers, etc.

In short:  anything that operates directly on user memory is a trivial
reproducer here.  The CVE uses SG_IO, but staying in block land direct
I/O will work just the same because swiotlb will copy back the
uninitialized data to user memory after an I/O failure.

What we've been thinking of is a version of the dma map calls where
the unmap gets passed how much data actually was transferred and only
copies that out.  But that seems like the only sane interface.

Now IFF we known that the buffer is never looked at on I/O failure
or short I/O we could do away with all this.  But without adding new
interfaces where the caller guarantees that we can't know that.  For
userspace memory it is guaranteed to be not true.  For kernel memory
is most likely is true, but there's some amazingly awful pieces of
code that probably still get it wrong.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
