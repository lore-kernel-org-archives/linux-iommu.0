Return-Path: <SRS0=ZsFK=UJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E41EC4321A
	for <iommu@archiver.kernel.org>; Mon, 10 Jun 2019 18:53:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BFB9207E0
	for <iommu@archiver.kernel.org>; Mon, 10 Jun 2019 18:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFB9207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 16C3ADB9;
	Mon, 10 Jun 2019 18:53:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E188ADB4
	for <iommu@lists.linux-foundation.org>;
	Mon, 10 Jun 2019 18:53:07 +0000 (UTC)
X-Greylist: delayed 00:06:41 by SQLgrey-1.7.6
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by smtp1.linuxfoundation.org (Postfix) with SMTP id 44AC0174
	for <iommu@lists.linux-foundation.org>;
	Mon, 10 Jun 2019 18:53:07 +0000 (UTC)
Received: (qmail 7256 invoked by uid 2102); 10 Jun 2019 14:46:25 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
	by localhost with SMTP; 10 Jun 2019 14:46:25 -0400
Date: Mon, 10 Jun 2019 14:46:25 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Christoph Hellwig <hch@lst.de>
Subject: Re: How to resolve an issue in swiotlb environment?
In-Reply-To: <20190610123222.GA20985@lst.de>
Message-ID: <Pine.LNX.4.44L0.1906101423200.1560-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

On Mon, 10 Jun 2019, Christoph Hellwig wrote:

> Hi Yoshihiro,
> 
> sorry for not taking care of this earlier, today is a public holiday
> here and thus I'm not working much over the long weekend.
> 
> On Mon, Jun 10, 2019 at 11:13:07AM +0000, Yoshihiro Shimoda wrote:
> > I have another way to avoid the issue. But it doesn't seem that a good way though...
> > According to the commit that adding blk_queue_virt_boundary() [3],
> > this is needed for vhci_hcd as a workaround so that if we avoid to call it
> > on xhci-hcd driver, the issue disappeared. What do you think?
> > JFYI, I pasted a tentative patch in the end of email [4].
> 
> Oh, I hadn't even look at why USB uses blk_queue_virt_boundary, and it
> seems like the usage is wrong, as it doesn't follow the same rules as
> all the others.  I think your patch goes in the right direction,
> but instead of comparing a hcd name it needs to be keyed of a flag
> set by the driver (I suspect there is one indicating native SG support,
> but I can't quickly find it), and we need an alternative solution
> for drivers that don't see like vhci.  I suspect just limiting the
> entire transfer size to something that works for a single packet
> for them would be fine.

Christoph:

In most of the different kinds of USB host controllers, the hardware is
not capable of assembling a packet out of multiple buffers at arbitrary
addresses.  As a matter of fact, xHCI is the only kind that _can_ do 
this.

In some cases, the hardware can assemble packets provided each buffer
other than the last ends at a page boundary and each buffer other than
the first starts at a page boundary (Intel would say the buffers are
"virtually contiguous"), but this is a rather complex rule and we don't
want to rely on it.  Plus, in other cases the hardware _can't_ do this.

Instead, we want the SG buffers to be set up so that each one (except 
the last) is an exact multiple of the maximum packet size.  That way, 
each packet can be assembled from the contents of a single buffer and 
there's no problem.

The maximum packet size depends on the type of USB connection.  
Typical values are 1024, 512, or 64.  It's always a power of two and
it's smaller than 4096.  Therefore we simplify the problem even further
by requiring that each SG buffer in a scatterlist (except the last one)
be a multiple of the page size.  (It doesn't need to be aligned on a 
page boundary, as far as I remember.)

That's why the blk_queue_virt_boundary usage was added to the USB code.  
Perhaps it's not the right way of doing this; I'm not an expert on the
inner workings of the block layer.  If you can suggest a better way to
express our requirement, that would be great.

Alan Stern

PS: There _is_ a flag saying whether an HCD supports SG.  But what it
means is that the driver can handle an SG list that meets the
requirement above; it doesn't mean that the driver can reassemble the
data from an SG list into a series of bounce buffers in order to meet
the requirement.  We very much want not to do that, especially since
the block layer should already be capable of doing it for us.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
