Return-Path: <SRS0=dZmg=UM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF90C31E45
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 17:16:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EFE52053B
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 17:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFE52053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 05A5A12D4;
	Thu, 13 Jun 2019 17:16:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C92AB119E
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 17:16:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by smtp1.linuxfoundation.org (Postfix) with SMTP id 39F1E82F
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 17:16:33 +0000 (UTC)
Received: (qmail 4216 invoked by uid 2102); 13 Jun 2019 13:16:32 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
	by localhost with SMTP; 13 Jun 2019 13:16:32 -0400
Date: Thu, 13 Jun 2019 13:16:32 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Christoph Hellwig <hch@lst.de>, 
	Valentina Manea <valentina.manea.m@gmail.com>, 
	Shuah Khan <shuah@kernel.org>
Subject: Re: How to resolve an issue in swiotlb environment?
In-Reply-To: <20190613073900.GC12093@lst.de>
Message-ID: <Pine.LNX.4.44L0.1906131306580.1307-100000@iolanthe.rowland.org>
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

On Thu, 13 Jun 2019, Christoph Hellwig wrote:

> On Wed, Jun 12, 2019 at 10:43:11AM -0400, Alan Stern wrote:
> > Would it be okay to rely on the assumption that USB block devices never 
> > have block size < 512?  (We could even add code to the driver to 
> > enforce this, although refusing to handle such devices at all might be 
> > worse than getting an occasional error.)
> 
> sd.c only supports a few specific sector size, and none of them is
> < 512 bytes:
> 
> 	if (sector_size != 512 &&
> 	    sector_size != 1024 &&
> 	    sector_size != 2048 &&
> 	    sector_size != 4096) {
> 	    	...
> 		sdkp->capacity = 0;

Great!  So all we have to do is fix vhci-hcd.  Then we can remove all 
the virt_boundary_mask stuff from usb-storage and uas entirely.

(I'm assuming wireless USB isn't a genuine issue.  As far as I know, it 
is pretty much abandoned at this point.)

Valentina and Shua: Adding SG support to vhci-hcd shouldn't be too
hard.  It ought to be possible even without changing the network
protocol.

Alan Stern

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
