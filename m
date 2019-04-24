Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03824C10F11
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 19:38:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A032175B
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 19:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPlQwqKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A032175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 72A1E15F2;
	Wed, 24 Apr 2019 19:38:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 964351545
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 19:38:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
	[209.85.215.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2C7DC870
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 19:38:47 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id z16so5265519pgv.11
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 12:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=gt37LcZrQPa+TVFY3hiGvxib7Pgjtqj0YnN2XvJD4vw=;
	b=PPlQwqKk9Cano+RcLs4BXcQoNOMDz0ZTmEbFr3Dph4+TWcEyF2lHobLKPfUPc0guCL
	VuJKbYTLqPa6lUXqZqO9qqg/+dSBWdLiDcnCdnQs4V8O3pZm2cQ56dkRIJ4869w+znU+
	WGmPyIF/Gp7jO/KTOgVz5N2S7d9dv7nEAaV3iCzx+Hl9wYMuutYcHVomADdaofVr0tMl
	L8uDBWNLQ8TqxeKFsOppbGjDol51x5tT18wHHKdn0MmSzaMgLN/eMgdx0mRBuCDvFaNp
	zBcWBA3bKUc6ZZ6fkGQhdQIIvCiu4+aJXgu2RRb9V6gqz19DC6vWy1nkONy9VrPJYmD/
	614g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=gt37LcZrQPa+TVFY3hiGvxib7Pgjtqj0YnN2XvJD4vw=;
	b=avZJVPf3Xj7DvifFz9OzXvfTW2HguezESbNdO82C7r10rBAkvs2l2G4QywiPRj8GmI
	xh0+d0D39yuw69yjdh/r3JvmXk8AM5BkZxFQ2opU9pYziKgBpB9pbdlwAVIraivFCav1
	+0XNr/U5IUMCzPkJXaL9XoNRrS49cClZAtBU/5B5IP3RGtuXpWOVpN+7uG4Q40QZrZWU
	K6EdJArRIAyRjkKcKUTntVPr69W54zlawTTQhAhXaofNhaYhi0HOCP3sq25tNjzW3ZXI
	FhoX5l040Au/o7AwA10SvJaUVxNzK1qmi4W7gx6TQvdbmWmGx1x633lGpZnhAnKpxnQ/
	ngJQ==
X-Gm-Message-State: APjAAAVbW8XSlPqwZC8yTV6K0FUN2xFGYIKRIsm3cgUXuy7ucv7gL6/z
	Y51Z0GGd7YuaaAD+w6DlRpI=
X-Google-Smtp-Source: APXvYqy6dfj/Q7qcYcnC9q8nuVjXxrC9oFUtPdUS8oVrD9JdpSnWzoVJDDsr+eYqSVRCowjtUkZvvA==
X-Received: by 2002:a65:6201:: with SMTP id d1mr15539968pgv.28.1556134726459; 
	Wed, 24 Apr 2019 12:38:46 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	f87sm32296503pff.56.2019.04.24.12.38.45
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 12:38:45 -0700 (PDT)
Date: Wed, 24 Apr 2019 12:38:41 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 RFC/RFT 1/5] ARM: dma-mapping: Add fallback normal
	page allocations
Message-ID: <20190424193840.GA30240@Asurada-Nvidia.nvidia.com>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
	<20190326230131.16275-2-nicoleotsuka@gmail.com>
	<20190424150638.GA22191@lst.de>
	<20190424183310.GA6168@Asurada-Nvidia.nvidia.com>
	<20190424192652.GA29032@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190424192652.GA29032@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: tony@atomide.com, catalin.marinas@arm.com, will.deacon@arm.com,
	linux@armlinux.org.uk, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org
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
Message-ID: <20190424193841.klmAGs0nR2MePC1vDHtUaxyPLXOxguw-ZplP-J-d4M8@z>

On Wed, Apr 24, 2019 at 09:26:52PM +0200, Christoph Hellwig wrote:
> On Wed, Apr 24, 2019 at 11:33:11AM -0700, Nicolin Chen wrote:
> > I feel it's similar to my previous set, which did most of these
> > internally except the renaming part. But Catalin had a concern
> > that some platforms might have limits on CMA range [1]. Will it
> > be still okay to do the fallback internally?
> > 
> > [1: https://www.spinics.net/lists/arm-kernel/msg714295.html ]
> 
> Catalins statement is correct, but I don't see how it applies to
> your patch.  Your patch just ensures that the fallback we have
> in most callers is uniformly applied everywhere.  The non-iommu
> callers will still need to select a specific zone and/or retry
> just the page allocator with other flags if the CMA (or fallback)
> page doesn't match what they need.  dma-direct does this correctly
> and I think the arm32 allocator does as well, although it is a bit
> hard to follow sometimes.

Okay. I will revise and submit the patches then. I think we
can still discuss on this topic once we have the changes.

Thanks
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
