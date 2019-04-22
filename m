Return-Path: <SRS0=kOFq=SY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BBFC10F11
	for <iommu@archiver.kernel.org>; Mon, 22 Apr 2019 17:56:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D1BC2175B
	for <iommu@archiver.kernel.org>; Mon, 22 Apr 2019 17:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1BC2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3A334D38;
	Mon, 22 Apr 2019 17:56:40 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A09A4D36
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Apr 2019 17:56:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4CE8D82E
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Apr 2019 17:56:39 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 8A81E68B02; Mon, 22 Apr 2019 19:56:23 +0200 (CEST)
Date: Mon, 22 Apr 2019 19:56:23 +0200
From: "hch@lst.de" <hch@lst.de>
To: Thomas Hellstrom <thellstrom@vmware.com>
Subject: Re: revert dma direct internals abuse
Message-ID: <20190422175623.GA32411@lst.de>
References: <20190408105525.5493-1-hch@lst.de>
	<7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com>
	<20190409095740.GE6827@lst.de>
	<5f0837ffc135560c764c38849eead40269cebb48.camel@vmware.com>
	<20190409133157.GA10876@lst.de>
	<466e658c73607fca5112d718972e87c0b78653ad.camel@vmware.com>
	<20190409152538.GA12816@lst.de>
	<da06614b308500392c179651ef9c6fb835ee4045.camel@vmware.com>
	<20190410064359.GC5543@lst.de>
	<0c897b24b234f8d42ef597dbe31fa8293519a4b2.camel@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0c897b24b234f8d42ef597dbe31fa8293519a4b2.camel@vmware.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Deepak Singh Rawat <drawat@vmware.com>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"hch@lst.de" <hch@lst.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
Message-ID: <20190422175623.gCWWdM1uXlvO_ANDzrnbvoDciEagI-aTLxly8Z4yM6g@z>

On Wed, Apr 10, 2019 at 03:01:14PM +0000, Thomas Hellstrom wrote:
> > So can you please respin a version acceptable to you and submit it
> > for 5.1 ASAP?  Otherwise I'll need to move ahead with the simple
> > revert.
> 
> I will. 
> I need to do some testing to investigate how to best choose between the
> options, but will have something ready for 5.1.

I still don't see anything in -rc6..
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
