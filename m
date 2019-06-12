Return-Path: <SRS0=EPGj=UL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93676C31E46
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 14:45:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72218208CA
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 14:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72218208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2A91B1C95;
	Wed, 12 Jun 2019 14:45:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5E03519B2
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 14:43:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by smtp1.linuxfoundation.org (Postfix) with SMTP id D239779
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 14:43:12 +0000 (UTC)
Received: (qmail 3203 invoked by uid 2102); 12 Jun 2019 10:43:11 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
	by localhost with SMTP; 12 Jun 2019 10:43:11 -0400
Date: Wed, 12 Jun 2019 10:43:11 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Christoph Hellwig <hch@lst.de>
Subject: Re: How to resolve an issue in swiotlb environment?
In-Reply-To: <20190612120653.GA25285@lst.de>
Message-ID: <Pine.LNX.4.44L0.1906121038210.1557-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
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

On Wed, 12 Jun 2019, Christoph Hellwig wrote:

> On Wed, Jun 12, 2019 at 01:46:06PM +0200, Oliver Neukum wrote:
> > > Thay is someething the virt_boundary prevents.  But could still give
> > > you something like:
> > > 
> > > 	1536 4096 4096 1024
> > > 
> > > or
> > > 	1536 16384 8192 4096 16384 512
> > 
> > That would kill the driver, if maxpacket were 1024.
> > 
> > USB has really two kinds of requirements
> > 
> > 1. What comes from the protocol
> > 2. What comes from the HCD
> > 
> > The protocol wants just multiples of maxpacket. XHCI can satisfy
> > that in arbitrary scatter/gather. Other HCs cannot.
> 
> We have no real way to enforce that for the other HCs unfortunately.
> I can't really think of any better way to handle their limitations
> except for setting max_segments to 1 or bounce buffering.

Would it be okay to rely on the assumption that USB block devices never 
have block size < 512?  (We could even add code to the driver to 
enforce this, although refusing to handle such devices at all might be 
worse than getting an occasional error.)

As I mentioned before, the only HCD that sometimes ends up with
maxpacket = 1024 but is unable to do full SG is vhci-hcd, and that one
shouldn't be too hard to fix.

Alan Stern

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
