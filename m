Return-Path: <SRS0=6I1K=SK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62A0C10F13
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 15:55:29 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9448721473
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 15:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V8nnt+Nh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9448721473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6C51CE9C;
	Mon,  8 Apr 2019 15:55:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 28896E91
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 15:55:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C7F42623
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 15:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BHhFt2oaMMJ7V74IhJSxg9lMwl9bWRsVOlKZvw2i/Tg=;
	b=V8nnt+NhTQCpLQA/kIx70MJHb
	mvTGcBePQOW9txOBsC77boPKcBDMnW+VUxR7I7dIeufV36nJQuNL/D5xFl7Jq6RQOj5PpPtk6y+zR
	G70XIoxJHWb7zBHZ6VHfJLCGs1PGFsgqffg0ROAYuSfcsYbQWRM0QVErSJGJHP0o2qEpryVxCCU7l
	a+d9W8LKjTpeF6AlKWuXsBH5/tWnsQg1hw1DnGafNpPRw8wTyMvYRNvJV23+4zNuw78fwopKvmu+J
	TCsbAONE32eX2u83Z+m9NuoXBAP1+Aw6mIN3Ql4eRo2/xYdwFqwDjQ2IH6wUhmPsFBXD4wXOvX6rH
	pyv83NcWQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
	Hat Linux)) id 1hDWcH-0008Au-LF; Mon, 08 Apr 2019 15:55:25 +0000
Date: Mon, 8 Apr 2019 08:55:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: kernel BUG at drivers/iommu/intel-iommu.c:608
Message-ID: <20190408155525.GA11471@infradead.org>
References: <a523ea10-3dab-fa2c-1ecf-5cf32077565f@acm.org>
	<20190407150650.060cc508@x1.home>
	<8d876549-21da-e027-0157-8737b10e26f8@acm.org>
	<20190407173132.24032810@x1.home>
	<1554736414.118779.265.camel@acm.org>
	<20190408092345.01751472@x1.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190408092345.01751472@x1.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: James Smart <jsmart2021@gmail.com>, Bart Van Assche <bvanassche@acm.org>,
	iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jiang Liu <jiang.liu@linux.intel.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190408155525.gVaNcufpyO6cj3Gpa9C9bH7pLdIVWm_QDfP3bQkVmlE@z>

On Mon, Apr 08, 2019 at 09:23:45AM -0600, Alex Williamson wrote:
> Loading modules is privileged:
> 
> $ modprobe vfio-pci
> modprobe: ERROR: could not insert 'vfio_pci': Operation not permitted
> 
> Granting a device to a user for device assignment purposes is also a
> privileged operation.  Can you describe a scenario where this is
> reachable without elevated privileges?  The driver core maintainer has
> indicated previously that manipulation of driver binding is effectively
> at your own risk.  It's entirely possible to bind devices to the wrong
> driver creating all sorts of bad behavior.  In this case, it appears
> that the system has been improperly configured if devices from a user
> owned group can accidentally be bound to host drivers.  Thanks,

Sorry, but BUG()ing in case of invalid user input is simply not
acceptable.  Please fix this code to have proper error handling.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
