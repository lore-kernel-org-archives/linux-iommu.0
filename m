Return-Path: <SRS0=Zw9n=BL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B68C433E0
	for <iommu@archiver.kernel.org>; Sat,  1 Aug 2020 08:20:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E1AD206E9
	for <iommu@archiver.kernel.org>; Sat,  1 Aug 2020 08:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="PZieZ6vj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1AD206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1F4B38887D;
	Sat,  1 Aug 2020 08:20:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Rn-drnhEkPP; Sat,  1 Aug 2020 08:20:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D370C885C6;
	Sat,  1 Aug 2020 08:20:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7DE5C0050;
	Sat,  1 Aug 2020 08:20:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF876C004D
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 08:20:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A7AE486868
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 08:20:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ls--2ZLb2u7Q for <iommu@lists.linux-foundation.org>;
 Sat,  1 Aug 2020 08:20:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0F5C286435
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 08:20:10 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id g19so5876094plq.0
 for <iommu@lists.linux-foundation.org>; Sat, 01 Aug 2020 01:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=8RENuYfU6VoekqCWfDYvGJ4U5lreKaq14QhTP7HksQE=;
 b=PZieZ6vj5i7mvkTUvOphvHrjtLq9MgXPp3etqpWLcPuEEAtpaUHkGzE3o4MkR8zo9v
 86EHHCtiJd0b92xe3le0ZhCZV4Q4IVkgjIag89VbbWbbjlbV9THRKnK2dLZb9hHacXJv
 OedkPNVBcaTJENHn4qoFSIv+Pycu6suf7NwOZO1MqcRVmlhG2wNn6kOKxLh+dPm34hRc
 U+uXalXPoFBXvUd66dOBAcB8cypfuvKpHMTVO/PwIQJFgdjaNW0mELCuYagj0wz3JAwm
 e3RnAOZdIEWBStMdP2fh46ga7YpcBQWqsv7NyZt+nJ74UIsfmbBgZrunDXqmaQvf47QE
 2oDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=8RENuYfU6VoekqCWfDYvGJ4U5lreKaq14QhTP7HksQE=;
 b=QF1Nzh/G2VQsgpih0nLHpJJokGtx0peMPvry+Ziktd4+tIoHKyKUhfhfPNHxjCTLwX
 JJXeJKYnkdDBxOLbbvbQ5uj5lvHkV50ExAyy4SscVxLnKMB5XEVE94DMjksKmSqOyn4H
 JQ7r069fZ2sMmw7hX0xr4V8gFNOyxDU4jOqjCQ5nsXLFokqsS17iLdXlS4GKqOFvMp6T
 QhGiXZhMdrULUj59L6tqcMfHv/geWBpEyMshFi91aUBeMb10imHPkisJPdh/WPK2a7zm
 D9/vsNLWrnfNCMDKzTnX2ZF40JHK+xBplNcOENovZF4H4ovHAfu1cwZL6pnV9KsrwLGl
 fXAQ==
X-Gm-Message-State: AOAM532Rv16c1DwW3rtfeJkJ0FUvJmfFJbZWki83NxyYidEq7tteDTw1
 SQh10FEuc49gP6wnidRfl2C2uA==
X-Google-Smtp-Source: ABdhPJxxA/gbLWmTMh49aUGYstr65LbcwVpIv0Wux02L2Lf+RIFBskcCb5zKFsI3lmRJQlHa5BjCnQ==
X-Received: by 2002:a17:902:d206:: with SMTP id
 t6mr6830876ply.131.1596270009418; 
 Sat, 01 Aug 2020 01:20:09 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667]
 ([2620:15c:17:3:4a0f:cfff:fe51:6667])
 by smtp.gmail.com with ESMTPSA id t17sm12685532pgu.30.2020.08.01.01.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2020 01:20:08 -0700 (PDT)
Date: Sat, 1 Aug 2020 01:20:07 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>
Subject: Re: dma-pool fixes
In-Reply-To: <alpine.DEB.2.23.453.2007311204010.3836388@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.23.453.2008010105560.4078406@chino.kir.corp.google.com>
References: <20200728104742.422960-1-hch@lst.de>
 <CAMi1Hd3=6ZZykF1yx_CChqx71k6T-wj12TzJiz_uJZbwrEtTXw@mail.gmail.com>
 <20200728120716.GA2507@lst.de>
 <CAMi1Hd1c3cNMYg+S5Pwuv30QCdcWJw+QxkWmNP34s3nb+_yUuA@mail.gmail.com>
 <20200728124114.GA4865@lst.de>
 <CAMi1Hd0wpcLVJ41h6gs4H0WEDVpNEs7N=wx+KQ_yRKeSv0kQ9g@mail.gmail.com>
 <20200728153055.GA16701@lst.de>
 <18a3b93cc5ba3e0e39ae1b14759ce31121d54045.camel@suse.de>
 <CAMi1Hd3QNtZVEFUgDprT==wcVHKv6TsvpT3RurVJTDb1op2LnA@mail.gmail.com>
 <CAMi1Hd09EbzOgTU5P4EDS8BQ6J2jFntvyR49BePyAqJ15DBB0Q@mail.gmail.com>
 <20200731130903.GA31110@lst.de>
 <alpine.DEB.2.23.453.2007311204010.3836388@chino.kir.corp.google.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Cc: Amit Pundir <amit.pundir@linaro.org>, jeremy.linton@arm.com,
 iommu@lists.linux-foundation.org, linux-rpi-kernel@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, 31 Jul 2020, David Rientjes wrote:

> > > Hi Nicolas, Christoph,
> > > 
> > > Just out of curiosity, I'm wondering if we can restore the earlier
> > > behaviour and make DMA atomic allocation configured thru platform
> > > specific device tree instead?
> > > 
> > > Or if you can allow a more hackish approach to restore the earlier
> > > logic, using of_machine_is_compatible() just for my device for the
> > > time being. Meanwhile I'm checking with other developers running the
> > > mainline kernel on sdm845 phones like OnePlus 6/6T, if they see this
> > > issue too.
> > 
> > If we don't find a fix for your platform I'm going to send Linus a
> > last minute revert this weekend, to stick to the no regressions policy.
> > I still hope we can fix the issue for real.
> > 
> 
> What would be the scope of this potential revert?
> 

To follow-up on this, the introduction of the DMA atomic pools in 5.8 
fixes an issue for any AMD SEV enabled guest that has a driver that 
requires atomic DMA allocations (for us, nvme) because runtime decryption 
of memory allocated through the DMA API may block.  This manifests itself 
as "sleeping in invalid context" BUGs for any confidential VM user in 
cloud.

I unfortunately don't have Amit's device to be able to independently debug 
this issue and certainly could not have done a better job at working the 
bug than Nicolas and Christoph have done so far.  I'm as baffled by the 
results as anybody else.

I fully understand the no regressions policy.  I'd also ask that we 
consider that *all* SEV guests are currently broken if they use nvme or 
any other driver that does atomic DMA allocations.  It's an extremely 
serious issue for cloud.  If there is *anything* that I can do to make 
forward progress on this issue for 5.8, including some of the workarounds 
above that Amit requested, I'd be very happy to help.  Christoph will make 
the right decision for DMA in 5.8, but I simply wanted to state how 
critical working SEV guests are to users.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
