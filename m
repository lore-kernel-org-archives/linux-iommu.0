Return-Path: <SRS0=+KdK=3D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FA7C33CA9
	for <iommu@archiver.kernel.org>; Tue, 14 Jan 2020 00:12:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A23B2084D
	for <iommu@archiver.kernel.org>; Tue, 14 Jan 2020 00:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1hYEJgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A23B2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1623F20415;
	Tue, 14 Jan 2020 00:12:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dtr1HIYdy8jG; Tue, 14 Jan 2020 00:12:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C7A5C2046E;
	Tue, 14 Jan 2020 00:12:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9788C18DD;
	Tue, 14 Jan 2020 00:12:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60F27C077D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 00:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 49BEE204A8
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 00:12:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yLjeR82t2hUy for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jan 2020 00:11:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by silver.osuosl.org (Postfix) with ESMTPS id B671620415
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 00:11:59 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id a6so4487555plm.3
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jan 2020 16:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=YszI0U18pHqA+Y3QA9OqnxsfwdnvOec+C4YDrgbYg80=;
 b=L1hYEJgKHWr/Gyj0fmCj7zWsybXM9yORn6pBPtcxw9h9s5Yc5uArF4pWiVeuaFNJh7
 bOs01G47TpIetL9Cm8U/+cR5pzygAPrZMi0vBO1wMFgujDbKFJ22wHFjmelcJuhTmW4X
 BslhLglhFFClkDef6TUGLTFzZSANH83yE8R3N7XECv4QWqwCGbk32JT1DUl0/snxiND/
 0QqZB6DUK59jjjySpgRm0l/IRe5Q7qi9yFoQQ9L7IgYfLHoJYaAdliaIj6+4BjrWXttw
 MXZSqAp05ZG1ov8wVSmIa883+mziVqos9f58MCtbquB/HmY8Kgq3wNtRljjWXu9bTX2U
 cvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YszI0U18pHqA+Y3QA9OqnxsfwdnvOec+C4YDrgbYg80=;
 b=mCBbF6tYE27VT8vCDIgsCAnR2lvWZGoOtOxcrVOnvRXoT4ZJirYnSr0OCM+WSxPhWb
 YcblNhd9fJOS12YchPxqnKGrmqvNNdktee4yx3Ftguqe4WVHbUpU6Fm6f5R3ZoywP7Kb
 xZZx5QaPAp6t425SjzuqQEImEVqzaxeaF13pSGpd8DulWReoNrtF5y0M6jwDvSGXnZld
 ydXMIvyKuwGsrRSMEobHWgIWb9+zSnPZidrXWy1lBHAvrypbKn17+yuHMF7zKK/potcn
 6M7VhjUys9laK2RDt90nEdezU0oaJOhsHQMAiVBtJnE7Aye1olfaKDI3WFeneLu17xkg
 gBqw==
X-Gm-Message-State: APjAAAXKrTVfbr3uKcO0I2qZ7P0zLPlQNg+rqfaRM+e3/JmwJL4KLblk
 WXWytDFuezNCMLvGljEQbP8+HA==
X-Google-Smtp-Source: APXvYqxx7U9QSEOfywuAVGzjNyUg0PYvYeG8HS4oMuifbJvLl3PcMnddxE7pxUtrCTCrnOSPk2maZQ==
X-Received: by 2002:a17:902:6501:: with SMTP id
 b1mr17177997plk.121.1578960719070; 
 Mon, 13 Jan 2020 16:11:59 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id 12sm15676997pfn.177.2020.01.13.16.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 16:11:58 -0800 (PST)
Date: Mon, 13 Jan 2020 16:11:55 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Saravana Kannan <saravanak@google.com>
Subject: Re: [RFC 0/2] iommu: arm-smmu: Add support for early direct mappings
Message-ID: <20200114001155.GJ1214176@minitux>
References: <20191209150748.2471814-1-thierry.reding@gmail.com>
 <20200111045639.210486-1-saravanak@google.com>
 <20200113140751.GA2436168@ulmo>
 <CAGETcx8YAXOdr1__gTCT2xCPq47Cg9vGj+5HJ_ZLzy4mHxU2xA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGETcx8YAXOdr1__gTCT2xCPq47Cg9vGj+5HJ_ZLzy4mHxU2xA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: Android Kernel Team <kernel-team@android.com>,
 Patrick Daly <pdaly@codeaurora.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Pratik Patel <pratikp@codeaurora.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon 13 Jan 14:01 PST 2020, Saravana Kannan wrote:

> I added everyone from the other thread, but somehow managed to miss
> the Bjorn who sent the emails! Fixing that now.
> 

Thanks for looping me in Saravana.

> On Mon, Jan 13, 2020 at 6:07 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> >
> > On Fri, Jan 10, 2020 at 08:56:39PM -0800, Saravana Kannan wrote:
[..]
> > In the case where you're trying to inherit the bootloader configuration
> > of the SMMU, how do you solve the problem of passing the page tables to
> > the kernel? You must have some way of reserving that memory in order to
> > prevent the kernel from reusing it.
> 
> Maybe "inherit" makes it sound a lot more complicated than it is?
> Bjorn will know the details of what the bootloader sets up. But
> AFAICT, it looks like a simple "bypass"/identity mapping too. I don't
> think it actually sets up page tables.
> 

In the Qualcomm case we have a number of stream mappings installed when
the bootloader jumps to the OS, each one with SMR/S2CR referring to a CB
with SMMU_CBn_SCTLR.M not set.

As such the relevant hardware is able to access (without translation)
DDR even with SMMU_CR0.USFCFG being set.

The one case where this causes issues is that upon attaching a device to
a context we'll set SMMU_CBn_SCTLR.M, so until we actually have a
translation installed we do get faults - the difference is that these
are not picked up as fatal faults by the secure firmware, so they are
simply reported in Linux.

[..]
> > > > One option that I can think of would be to create an early identity
> > > > domain for each master and inherit it when that master is attached to
> > > > the domain later on, but that seems rather complicated from an book-
> > > > keeping point of view and tricky because we need to be careful not to
> > > > map regions twice, etc.
> > > >
> > > > Any good ideas on how to solve this? It'd also be interesting to see if
> > > > there's a more generic way of doing this. I know that something like
> > > > this isn't necessary on earlier Tegra SoCs with the custom Tegra SMMU
> > > > because translations are only enabled when the devices are attached to a
> > > > domain.
> > >
> > > Good foresight. As [1] shows, identity mapping doesn't solve it in a
> > > generic way.
> >
> > I think your [1] is a special case of identity mappings where the
> > mappings are already active. If you pass the information about the
> > mappings via memory-region properties, then you should be able to
> > reconstruct the identity mapping in the kernel before switching the
> > SMMU over to the new mapping for a seamless transition.
> 
> Ok, makes sense. But I don't have the full details here. So I'll let
> Bjorn comment here.
> 

It might be possible that we can install page tables and setup 1:1
mappings for the necessary resources, but it's not all devices with a
memory-region and a iommu context defined that should have this.

I will have to discuss this in more detail with the Qualcomm engineers.

PS. One detail that I did notice while distilling the downstream patches
is that unused mappings must have SMMU_S2CRx.CBNDX = 255 or I get odd
crashes when the display (CBNDX = 0) is active. I've yet to conclude
why this is.

Regards,
Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
