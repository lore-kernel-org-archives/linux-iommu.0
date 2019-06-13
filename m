Return-Path: <SRS0=dZmg=UM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92675C31E45
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 23:19:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 583162133D
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 23:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7CW3kEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583162133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0E0BCE6C;
	Thu, 13 Jun 2019 23:19:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6EEC1E75
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 23:01:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 89395711
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 23:01:06 +0000 (UTC)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net
	[24.9.64.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id C71622147A;
	Thu, 13 Jun 2019 23:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560466866;
	bh=ijAoTvben3xHdJwjFjc2JVq20l3k6CT0SJjNIni16EE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
	b=l7CW3kEbIEfMPyQKq84ka0PeuSuwdqPEd/rBwzyb+r1FqLLqyErPP9Iw42L52TmB5
	2Uy1rIkSbsHxHYYCWBq3FZuNZTXRsZ2QRyHKWJRpBXggeBKNkX5qMpxYhhmmT5vXeb
	r3sXe5wfp6Fftm3kLieDRdFmX+o6d0kmUyHdR3fc=
Subject: Re: How to resolve an issue in swiotlb environment?
To: Alan Stern <stern@rowland.harvard.edu>, Christoph Hellwig <hch@lst.de>,
	Valentina Manea <valentina.manea.m@gmail.com>
References: <Pine.LNX.4.44L0.1906131306580.1307-100000@iolanthe.rowland.org>
From: shuah <shuah@kernel.org>
Message-ID: <41caad16-3fa1-413b-0d49-594d48b88de4@kernel.org>
Date: Thu, 13 Jun 2019 17:01:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1906131306580.1307-100000@iolanthe.rowland.org>
Content-Language: en-US
X-Mailman-Approved-At: Thu, 13 Jun 2019 23:19:01 +0000
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	shuah <shuah@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 6/13/19 11:16 AM, Alan Stern wrote:
> On Thu, 13 Jun 2019, Christoph Hellwig wrote:
> 
>> On Wed, Jun 12, 2019 at 10:43:11AM -0400, Alan Stern wrote:
>>> Would it be okay to rely on the assumption that USB block devices never
>>> have block size < 512?  (We could even add code to the driver to
>>> enforce this, although refusing to handle such devices at all might be
>>> worse than getting an occasional error.)
>>
>> sd.c only supports a few specific sector size, and none of them is
>> < 512 bytes:
>>
>> 	if (sector_size != 512 &&
>> 	    sector_size != 1024 &&
>> 	    sector_size != 2048 &&
>> 	    sector_size != 4096) {
>> 	    	...
>> 		sdkp->capacity = 0;
> 
> Great!  So all we have to do is fix vhci-hcd.  Then we can remove all
> the virt_boundary_mask stuff from usb-storage and uas entirely.
> 
> (I'm assuming wireless USB isn't a genuine issue.  As far as I know, it
> is pretty much abandoned at this point.)
> 
> Valentina and Shua: Adding SG support to vhci-hcd shouldn't be too
> hard.  It ought to be possible even without changing the network
> protocol.
> 

I will start taking a look at this. Is there a target release in plan
to drop virt_boundary_mask stuff?

thanks,
-- Shuah

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
