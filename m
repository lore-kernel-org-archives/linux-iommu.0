Return-Path: <SRS0=6vqp=5Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27513C2D0E8
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 07:44:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3213206DB
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 07:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONQSHuUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3213206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BD9AD85DF6;
	Tue, 31 Mar 2020 07:44:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wCU-c0YVaSGW; Tue, 31 Mar 2020 07:44:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4A85385E1A;
	Tue, 31 Mar 2020 07:44:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34513C1AE8;
	Tue, 31 Mar 2020 07:44:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84BD3C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 07:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 80CFB85E1A
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 07:44:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zDyQVpJNGVL4 for <iommu@lists.linux-foundation.org>;
 Tue, 31 Mar 2020 07:44:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 124D285DF6
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 07:44:05 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9C580206DB;
 Tue, 31 Mar 2020 07:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585640644;
 bh=gcID3GWYJF4NliAjI/RygRsNu+nFMEJc51AHKH/1rTo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ONQSHuUEmZ+odhOK6BHWTMjvoJJyQFhIkoDZb+4JR7DmTpAaX+uogyNRfTqsr7SFM
 iccP3zHdv6Bd5jRabUeqXtD1iADQvZpYV5NpZsBt974HT5Rx7z3OP/AaQwCaMy0G1P
 26nnVA/LXu6PVS9nsXxZFlNICiSvFelI+4PoLPZc=
Date: Tue, 31 Mar 2020 08:44:00 +0100
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH] iommu/arm-smmu: Demote error messages to debug in
 shutdown callback
Message-ID: <20200331074400.GB25612@willie-the-truck>
References: <20200327132852.10352-1-saiprakash.ranjan@codeaurora.org>
 <0023bc68-45fb-4e80-00c8-01fd0369243f@arm.com>
 <37db9a4d524aa4d7529ae47a8065c9e0@codeaurora.org>
 <5858bdac-b7f9-ac26-0c0d-c9653cef841d@arm.com>
 <d60196b548e1241b8334fadd0e8c2fb5@codeaurora.org>
 <CAD=FV=WXTN6xxqtL6d6MHxG8Epuo6FSQERRPfnoSCskhjh1KeQ@mail.gmail.com>
 <890456524e2df548ba5d44752513a62c@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <890456524e2df548ba5d44752513a62c@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Doug Anderson <dianders@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS , Joerg Roedel <joro@8bytes.org>,
 " <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>
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

On Tue, Mar 31, 2020 at 01:06:11PM +0530, Sai Prakash Ranjan wrote:
> On 2020-03-30 23:54, Doug Anderson wrote:
> > On Sat, Mar 28, 2020 at 12:35 AM Sai Prakash Ranjan
> > <saiprakash.ranjan@codeaurora.org> wrote:
> > > 
> > > > Of course the fact that in practice we'll *always* see the warning
> > > > because there's no way to tear down the default DMA domains, and even
> > > > if all devices *have* been nicely quiesced there's no way to tell, is
> > > > certainly less than ideal. Like I say, it's not entirely clear-cut
> > > > either way...
> > > >
> > > 
> > > Thanks for these examples, good to know these scenarios in case we
> > > come
> > > across these.
> > > However, if we see these error/warning messages appear everytime then
> > > what will be
> > > the credibility of these messages? We will just ignore these messages
> > > when
> > > these issues you mention actually appears because we see them
> > > everytime
> > > on
> > > reboot or shutdown.
> > 
> > I would agree that if these messages are expected to be seen every
> > time, there's no way to fix them, and they're not indicative of any
> > problem then something should be done.  Seeing something printed at
> > "dev_error" level with an exclamation point (!) at the end makes me
> > feel like this is something that needs immediate action on my part.
> > 
> > If we really can't do better but feel that the messages need to be
> > there, at least make them dev_info and less scary like:
> > 
> >   arm-smmu 15000000.iommu: turning off; DMA should be quiesced before
> > now
> > 
> > ...that would still give you a hint in the logs that if you saw a DMA
> > transaction after the message that it was a bug but also wouldn't
> > sound scary to someone who wasn't seeing any other problems.
> > 
> 
> We can do this if Robin is OK?

It would be nice if you could figure out which domains are still live when
the SMMU is being shut down in your case and verify that it *is* infact
benign before we start making the message more friendly. As Robin said
earlier, rogue DMA is a real nightmare to debug.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
