Return-Path: <SRS0=JfOd=4H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD32EC3404C
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 01:57:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F3E920659
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 01:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="rVB5SHBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3E920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4DA5F204C9;
	Wed, 19 Feb 2020 01:57:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3hyXGowKGfcY; Wed, 19 Feb 2020 01:57:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 26470203F5;
	Wed, 19 Feb 2020 01:57:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18EB4C08A0;
	Wed, 19 Feb 2020 01:57:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FB97C013E
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 01:57:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8F51A86D82
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 01:57:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2B9aHKdSoDSn for <iommu@lists.linux-foundation.org>;
 Wed, 19 Feb 2020 01:57:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B616A865B8
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 01:57:20 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1582077440; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=YcNZbJFJfQvxvpBXUgrKzCwdLhDCfSRbsPpwRd/fJ3g=;
 b=rVB5SHBMR3qzarh3ksq2jvTSUozZsnfSlv9D8AGykW2nJghlYGqG1n/NbFcxc+FZuIJKrhUt
 v/LnieLUA/Xc7bvDtnDyJWrTpOIsbBtSC1zG1+O1clpRFoEuibVRr5UKeUXBli4YwF8OYjHr
 C1H2ScNoNKrPwcL1cDkDYr9vJQQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4c95ff.7fcf28a38df8-smtp-out-n02;
 Wed, 19 Feb 2020 01:57:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 979B1C4479F; Wed, 19 Feb 2020 01:57:19 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id E6337C43383;
 Wed, 19 Feb 2020 01:57:18 +0000 (UTC)
MIME-Version: 1.0
Date: Tue, 18 Feb 2020 17:57:18 -0800
From: isaacm@codeaurora.org
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] iommu/dma: Allow drivers to reserve an iova range
In-Reply-To: <c58fd502-52a4-cb0f-6e7f-e9cc00627313@arm.com>
References: <1581721096-16235-1-git-send-email-isaacm@codeaurora.org>
 <20200217080138.GB10342@infradead.org>
 <c58fd502-52a4-cb0f-6e7f-e9cc00627313@arm.com>
Message-ID: <fc6e1b6689bca7a00e6b12d2bc877d20@codeaurora.org>
X-Sender: isaacm@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: pratikp@codeaurora.org, linux-kernel@vger.kernel.org,
 Liam Mark <lmark@codeaurora.org>, iommu@lists.linux-foundation.org,
 kernel-team@android.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-02-17 07:50, Robin Murphy wrote:
> On 17/02/2020 8:01 am, Christoph Hellwig wrote:
>> On Fri, Feb 14, 2020 at 02:58:16PM -0800, Isaac J. Manjarres wrote:
>>> From: Liam Mark <lmark@codeaurora.org>
>>> 
>>> Some devices have a memory map which contains gaps or holes.
>>> In order for the device to have as much IOVA space as possible,
>>> allow its driver to inform the DMA-IOMMU layer that it should
>>> not allocate addresses from these holes.
>> 
>> Layering violation.  dma-iommu is the translation layer between the
>> DMA API and the IOMMU API.  And calls into it from drivers performing
>> DMA mappings need to go through the DMA API (and be documented there).
> 
> +1
> 
> More than that, though, we already have "holes in the address space"
> support for the sake of PCI host bridge windows - assuming this is the
> same kind of thing (i.e. the holes are between memory regions and
> other resources in PA space, so are only relevant once address
> translation comes into the picture), then this is IOMMU API level
To make sure that we're on the same page, this support alludes to the 
handling in
dma-iommu.c that reserves portions of the IOVA space for the PCI host 
bridge windows,
correct? If so, then yes, this is similar.
> stuff, so even a DMA API level interface would be inappropriate.
Does this mean that the driver should be managing the IOVA space and 
mappings for this device using the IOMMU API? If so, is the rationale 
for this because the device driver can have the information of what IOVA 
ranges can and cannot be used? Shouldn't there be a generic way of 
informing an IOMMU driver about these reserved ranges? Perhaps through a 
device tree property, instead of deferring this type of management to 
the driver?
> 
> Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
