Return-Path: <SRS0=HkIk=5M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FBCC2D0E5
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 22:25:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6042073B
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 22:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6042073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C32838867E;
	Fri, 27 Mar 2020 22:25:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hiO7Vzx+0T0O; Fri, 27 Mar 2020 22:25:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 10B2E88673;
	Fri, 27 Mar 2020 22:25:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB3CDC1D8A;
	Fri, 27 Mar 2020 22:25:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53219C0177
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 22:25:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4236E20478
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 22:25:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J6RqUL4oLzeG for <iommu@lists.linux-foundation.org>;
 Fri, 27 Mar 2020 22:25:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by silver.osuosl.org (Postfix) with ESMTPS id 08C112107D
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 22:25:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: ezequiel) with ESMTPSA id A3857296825
Message-ID: <761b5165f6708bb707148cfdee13d9b710eef29c.camel@collabora.com>
Subject: Re: [PATCH] iommu: Lower severity of add/remove device messages
From: Ezequiel Garcia <ezequiel@collabora.com>
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Date: Fri, 27 Mar 2020 19:25:27 -0300
In-Reply-To: <6db3bcfb-c778-7190-a936-836eaba4bb73@arm.com>
References: <20200323214956.30165-1-ezequiel@collabora.com>
 <20200327095029.GB11538@8bytes.org>
 <9e863f96cd9a188db84ae8bc5a0d49287b4b4922.camel@collabora.com>
 <6db3bcfb-c778-7190-a936-836eaba4bb73@arm.com>
Organization: Collabora
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, kernel@collabora.com,
 linux-kernel@vger.kernel.org
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

On Fri, 2020-03-27 at 18:04 +0000, Robin Murphy wrote:
> On 2020-03-27 1:02 pm, Ezequiel Garcia wrote:
> > Hello Joerg,
> > 
> > Thanks for reviewing.
> > 
> > I understand this change bears some controversy
> > for IOMMU, as developers are probably used to see these
> > messages.
> > 
> > On Fri, 2020-03-27 at 10:50 +0100, Joerg Roedel wrote:
> > > On Mon, Mar 23, 2020 at 06:49:56PM -0300, Ezequiel Garcia wrote:
> > > > These user messages are not really informational,
> > > > but mostly of debug nature. Lower their severity.
> > > 
> > > Like most other messages in the kernel log, that is not a reason to
> > > lower the severity.
> > > 
> > > These messages are the first thing to look at when
> > > looking into IOMMU related issues.
> > > 
> > 
> > Sure, but the messages are still here, you can
> > always enable them when you are looking at IOMMU issues :-)
> 
> That still begs the question of who "you" is and how they know they're 
> debugging an IOMMU issue in the first place. When all the developer has 
> to go on is a third-hand bugzilla attachment from a distro user's vague 
> report of graphics corruption/poor I/O performance/boot 
> failure/whatever, being able to tell straight away from a standard dmesg 
> dump whether an IOMMU is even in the picture or not saves a lot of 
> protracted back-and-forth for everyone involved.
> > The idea is to reduce the amount of verbosity in the kernel.
> 
> Under what justification? Users with slow consoles or who just want a 
> quiet boot are already free to turn down the loglevel; a handful of 
> messages at boot-time and device hotplug seem hardly at risk of drowning 
> out all the systemd audit spam anyway. Note that the IOMMU subsystem is 
> by nature a little atypical as a lot of what it does is only visible as 
> secondary effects on other drivers and subsystems, without their 
> explicit involvement or knowledge. In that respect, hiding its activity 
> can arguably lead to more non-obvious situations than many other subsystems.
> 
> > If all subsystems would print messages that are useful
> > when looking at issues, things would be quite nasty verbose.
> 
>  From a personal standpoint, can we at least eradicate all the "Hi! I'm 
> a driver/subsystem you don't even have the hardware for!" messages 
> first, then maybe come back and reconsider the ones that convey actual 
> information later?
> 

Do we really still have those???

Thanks,
Ezequiel

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
