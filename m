Return-Path: <SRS0=4mi1=S3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61DDC43218
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 14:33:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F802067D
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 14:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F802067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4CAB31EA7;
	Thu, 25 Apr 2019 14:33:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F23EF1EA3
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 14:32:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8528674A
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 14:32:52 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 0BCB568B20; Thu, 25 Apr 2019 16:32:36 +0200 (CEST)
Date: Thu, 25 Apr 2019 16:32:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH] dma-mapping: remove an unnecessary NULL check
Message-ID: <20190425143235.GD16790@lst.de>
References: <20190424142437.GA29490@mwanda> <20190424142743.GC20974@lst.de>
	<3142dc82-1d4c-5f01-678e-628038d86bd6@mev.co.uk>
	<20190425141832.GA16643@lst.de>
	<ab71b3ad-c737-82ed-5727-9f4382569b4b@mev.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ab71b3ad-c737-82ed-5727-9f4382569b4b@mev.co.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	"kernel-janitors@vger.kernel.org H Hartley Sweeten"
	<hsweeten@visionengravers.com>, iommu@lists.linux-foundation.org,
	Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>, Dan Carpenter <dan.carpenter@oracle.com>
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
Message-ID: <20190425143235.H-xovlUAxX_Yy0vhQcXF2MhktseEZR012e9FHUOWJVM@z>

On Thu, Apr 25, 2019 at 03:31:01PM +0100, Ian Abbott wrote:
> On 25/04/2019 15:18, Christoph Hellwig wrote:
>> On Thu, Apr 25, 2019 at 03:13:49PM +0100, Ian Abbott wrote:
>>> So for comedi_isadma, we can just replace the NULL with a pointer to a
>>> static dummy device with a 24-bit coherent mask?
>>
>> It should be converted to a proper isa_driver, so that it gets a real
>> struct device.
>
> But it will work as a short term solution?  comedi_isadma isn't a driver, 
> but is used by a few comedi drivers for ISA cards.

Then convert the drivers properly and pass on the device from them.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
