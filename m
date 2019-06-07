Return-Path: <SRS0=pxo5=UG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3D7C28CC3
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 08:36:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5A320B7C
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 08:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5A320B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A7F14ED9;
	Fri,  7 Jun 2019 08:36:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9EACFED6
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 08:35:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 25B85A9
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 08:35:14 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 7922868C4E; Fri,  7 Jun 2019 10:34:47 +0200 (CEST)
Date: Fri, 7 Jun 2019 10:34:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH] Documentation: DMA-API: fix a function name of
	max_mapping_size
Message-ID: <20190607083447.GA10860@lst.de>
References: <1559893633-6852-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<20190607080814.GA10303@lst.de>
	<TYAPR01MB3102C6CCC204DAAA6570FD25D8100@TYAPR01MB3102.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <TYAPR01MB3102C6CCC204DAAA6570FD25D8100@TYAPR01MB3102.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "jroedel@suse.de" <jroedel@suse.de>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
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

On Fri, Jun 07, 2019 at 08:19:08AM +0000, Yoshihiro Shimoda wrote:
> Hi Christoph,
> 
> > From: Christoph Hellwig, Sent: Friday, June 7, 2019 5:08 PM
> > 
> > Looks good.  And it seems like you've also found the solution to
> > your usb storage problem, but I'm going to post the variant I just
> > hacked up nevertheless.
> 
> Thank you for your reply! I think this API is related to my problem,
> but I don't have any actual solution (a patch) for now. So, I'll wait
> for your patch!

Turns out it isn't as simple as I thought, as there doesn't seem to
be an easy way to get to the struct device used for DMA mapping
from USB drivers.  I'll need to think a bit more how to handle that
best.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
