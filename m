Return-Path: <SRS0=4mi1=S3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD2DC43219
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 19:34:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E6920685
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 19:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="JZJzO+mE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E6920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mev.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0271B227B;
	Thu, 25 Apr 2019 19:34:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DB4FC1EA5
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 14:36:46 +0000 (UTC)
X-Greylist: delayed 00:05:42 by SQLgrey-1.7.6
Received: from smtp68.ord1d.emailsrvr.com (smtp68.ord1d.emailsrvr.com
	[184.106.54.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8CCBF74A
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 14:36:46 +0000 (UTC)
Received: from smtp9.relay.ord1d.emailsrvr.com (localhost [127.0.0.1])
	by smtp9.relay.ord1d.emailsrvr.com (SMTP Server) with ESMTP id
	E5492C0289; Thu, 25 Apr 2019 10:31:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20190130-41we5z8j; t=1556202663;
	bh=w18i9e5QU9exjC8EuByjFALVjeh17EI57d2TFOrUF90=;
	h=Subject:To:From:Date:From;
	b=JZJzO+mE7htKl4IHFy1AskJ48Fb1Ix37C0eA9c85Weu+N43zNibb6jlIgToS4nMUh
	PDGXuYf+Dl4xLuKupT9CyrDcrpYSjnRTqNCfrA7owsaUFhJb1E6MeRoE/gVgGbN8yy
	CSdkQ3WxzSxNfbdAG5pfD3/5LBPevrAD/RV0pkMQ=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp9.relay.ord1d.emailsrvr.com (Authenticated sender:
	abbotti-AT-mev.co.uk) with ESMTPSA id BB782C0291; 
	Thu, 25 Apr 2019 10:31:02 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.62] (remote.quintadena.com [81.133.34.160])
	(using TLSv1.2 with cipher AES128-SHA) by 0.0.0.0:465 (trex/5.7.12);
	Thu, 25 Apr 2019 10:31:03 -0400
Subject: Re: [PATCH] dma-mapping: remove an unnecessary NULL check
To: Christoph Hellwig <hch@lst.de>
References: <20190424142437.GA29490@mwanda> <20190424142743.GC20974@lst.de>
	<3142dc82-1d4c-5f01-678e-628038d86bd6@mev.co.uk>
	<20190425141832.GA16643@lst.de>
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <ab71b3ad-c737-82ed-5727-9f4382569b4b@mev.co.uk>
Date: Thu, 25 Apr 2019 15:31:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425141832.GA16643@lst.de>
Content-Language: en-GB
X-Mailman-Approved-At: Thu, 25 Apr 2019 19:33:38 +0000
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	"kernel-janitors@vger.kernel.org H Hartley Sweeten"
	<hsweeten@visionengravers.com>, iommu@lists.linux-foundation.org,
	Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>,
	Dan Carpenter <dan.carpenter@oracle.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190425143101.OaI7PdgdrjL65FkOa7VZkBjdIuDOV2bZ6LDFcsE0yOA@z>

On 25/04/2019 15:18, Christoph Hellwig wrote:
> On Thu, Apr 25, 2019 at 03:13:49PM +0100, Ian Abbott wrote:
>> So for comedi_isadma, we can just replace the NULL with a pointer to a
>> static dummy device with a 24-bit coherent mask?
> 
> It should be converted to a proper isa_driver, so that it gets a real
> struct device.

But it will work as a short term solution?  comedi_isadma isn't a 
driver, but is used by a few comedi drivers for ISA cards.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
