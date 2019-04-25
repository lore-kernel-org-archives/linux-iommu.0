Return-Path: <SRS0=4mi1=S3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412F4C43218
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 19:34:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5199720685
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 19:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="bVfgVT+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5199720685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mev.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BC96E2278;
	Thu, 25 Apr 2019 19:34:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0C77C1D92
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 14:21:47 +0000 (UTC)
X-Greylist: delayed 00:07:54 by SQLgrey-1.7.6
Received: from smtp92.iad3b.emailsrvr.com (smtp92.iad3b.emailsrvr.com
	[146.20.161.92])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B00D874A
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 14:21:46 +0000 (UTC)
Received: from smtp12.relay.iad3b.emailsrvr.com (localhost [127.0.0.1])
	by smtp12.relay.iad3b.emailsrvr.com (SMTP Server) with ESMTP id
	C1161C0174; Thu, 25 Apr 2019 10:13:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20190130-41we5z8j; t=1556201631;
	bh=ZTDJFDMurbCxWd1zNz+FBNlikriqJ0a3UjAP/wPvR0g=;
	h=Subject:To:From:Date:From;
	b=bVfgVT+9y0FnsEUTZxEzhXHPuCaVyTQId6KBhMs1lvXffrUl9r9vVYahO6Xh/S4fR
	9jlTj4OYQMRqBbPZQiNidD4yhdvxxlTneLs8q4ZNy/2BHkq7nzcKLecljbRC14LKgi
	jpEZSUsnoSIw/cq2j9NLk75rWQ2p3iJJ0iVC3/u0=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp12.relay.iad3b.emailsrvr.com (Authenticated sender:
	abbotti-AT-mev.co.uk) with ESMTPSA id AFE1AC01FB; 
	Thu, 25 Apr 2019 10:13:50 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.62] (remote.quintadena.com [81.133.34.160])
	(using TLSv1.2 with cipher AES128-SHA) by 0.0.0.0:465 (trex/5.7.12);
	Thu, 25 Apr 2019 10:13:51 -0400
Subject: Re: [PATCH] dma-mapping: remove an unnecessary NULL check
To: Christoph Hellwig <hch@lst.de>, Dan Carpenter <dan.carpenter@oracle.com>
References: <20190424142437.GA29490@mwanda> <20190424142743.GC20974@lst.de>
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <3142dc82-1d4c-5f01-678e-628038d86bd6@mev.co.uk>
Date: Thu, 25 Apr 2019 15:13:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424142743.GC20974@lst.de>
Content-Language: en-GB
X-Mailman-Approved-At: Thu, 25 Apr 2019 19:33:38 +0000
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	"kernel-janitors@vger.kernel.org H Hartley Sweeten"
	<hsweeten@visionengravers.com>, iommu@lists.linux-foundation.org,
	Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>
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
Message-ID: <20190425141349.WGyl0LzIeVR1FE6Y5W4wh0BQ9y1WkKDw-sTQoID0jBk@z>

On 24/04/2019 15:27, Christoph Hellwig wrote:
> On Wed, Apr 24, 2019 at 05:24:37PM +0300, Dan Carpenter wrote:
>> We already dereferenced "dev" when we called get_dma_ops() so this NULL
>> check is too late.  We're not supposed to pass NULL "dev" pointers to
>> dma_alloc_attrs().
> 
> Thanks, applied to the dma-mapping for-next tree.
> 
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>> There are still at least two drivers which do pass a NULL unfortunately.
>>
>> drivers/staging/comedi/drivers/comedi_isadma.c:195 comedi_isadma_alloc() error: NULL dereference inside function 'dma_alloc_coherent()'
>> drivers/staging/comedi/drivers/comedi_isadma.c:227 comedi_isadma_free() error: NULL dereference inside function 'dma_free_coherent()'
> 
> This is staging code.  Per official decree from Linus we can just
> ignore it, and I tend to do so to keep my sanity.

So for comedi_isadma, we can just replace the NULL with a pointer to a 
static dummy device with a 24-bit coherent mask?

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
