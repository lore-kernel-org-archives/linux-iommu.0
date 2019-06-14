Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5DAC31E4D
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 14:45:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0228621721
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 14:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0228621721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 586BD136F;
	Fri, 14 Jun 2019 14:44:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BD5D912C6
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 14:44:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp1.linuxfoundation.org (Postfix) with SMTP id 88E3976D
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 14:44:54 +0000 (UTC)
Received: (qmail 26355 invoked by uid 500); 14 Jun 2019 10:44:53 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
	by localhost with SMTP; 14 Jun 2019 10:44:53 -0400
Date: Fri, 14 Jun 2019 10:44:53 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: shuah <shuah@kernel.org>
Subject: Re: How to resolve an issue in swiotlb environment?
In-Reply-To: <41caad16-3fa1-413b-0d49-594d48b88de4@kernel.org>
Message-ID: <Pine.LNX.4.44L0.1906141043530.24571-100000@netrider.rowland.org>
MIME-Version: 1.0
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	Valentina Manea <valentina.manea.m@gmail.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
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

On Thu, 13 Jun 2019, shuah wrote:

> > Great!  So all we have to do is fix vhci-hcd.  Then we can remove all
> > the virt_boundary_mask stuff from usb-storage and uas entirely.
> > 
> > (I'm assuming wireless USB isn't a genuine issue.  As far as I know, it
> > is pretty much abandoned at this point.)
> > 
> > Valentina and Shua: Adding SG support to vhci-hcd shouldn't be too
> > hard.  It ought to be possible even without changing the network
> > protocol.
> > 
> 
> I will start taking a look at this. Is there a target release in plan
> to drop virt_boundary_mask stuff?

Not yet.  But since it doesn't do what we want anyway, this should be 
fixed quickly.

Alan Stern

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
