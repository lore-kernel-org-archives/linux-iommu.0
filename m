Return-Path: <SRS0=6vqp=5Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F22C43331
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 07:54:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 154D7206F5
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 07:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="lbQAkV5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154D7206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 08004883C0;
	Tue, 31 Mar 2020 07:54:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uvrg3lwhmFLu; Tue, 31 Mar 2020 07:54:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 39E758843E;
	Tue, 31 Mar 2020 07:54:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26793C1D8A;
	Tue, 31 Mar 2020 07:54:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2398FC07FF
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 07:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0850780666
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 07:53:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tUH3Oc0wvKcU for <iommu@lists.linux-foundation.org>;
 Tue, 31 Mar 2020 07:53:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C1A1F85F67
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 07:53:41 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1585641225; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=y+g2aIRUiXN9G3r1jVBnLvDDqFYXx0VUiwFi2S/Qu/A=;
 b=lbQAkV5+VvbZqQUXGKN13koF4o08TeibUm00gJF4CPe7yKMn4xfiSSyJlDUuQpeUlBdLAFPH
 Kgn33Doedb/3yv+8aqKedy8KwljSjzEum7czZEkQOPgQ0ATNfWEELZbs7JOeLfge3qGTWq9m
 d3Zq8KzYDsvqfh+Pn3J0qlBsrgY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e82f6fe.7fa0e3408730-smtp-out-n03;
 Tue, 31 Mar 2020 07:53:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id DB692C433D2; Tue, 31 Mar 2020 07:53:33 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 31674C433F2;
 Tue, 31 Mar 2020 07:53:33 +0000 (UTC)
MIME-Version: 1.0
Date: Tue, 31 Mar 2020 13:23:33 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu: Demote error messages to debug in
 shutdown callback
In-Reply-To: <20200331074400.GB25612@willie-the-truck>
References: <20200327132852.10352-1-saiprakash.ranjan@codeaurora.org>
 <0023bc68-45fb-4e80-00c8-01fd0369243f@arm.com>
 <37db9a4d524aa4d7529ae47a8065c9e0@codeaurora.org>
 <5858bdac-b7f9-ac26-0c0d-c9653cef841d@arm.com>
 <d60196b548e1241b8334fadd0e8c2fb5@codeaurora.org>
 <CAD=FV=WXTN6xxqtL6d6MHxG8Epuo6FSQERRPfnoSCskhjh1KeQ@mail.gmail.com>
 <890456524e2df548ba5d44752513a62c@codeaurora.org>
 <20200331074400.GB25612@willie-the-truck>
Message-ID: <1bf04938249bcd5b2111c1921facfd25@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Doug Anderson <dianders@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU
 DRIVERS , Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Will,

On 2020-03-31 13:14, Will Deacon wrote:
> On Tue, Mar 31, 2020 at 01:06:11PM +0530, Sai Prakash Ranjan wrote:
>> On 2020-03-30 23:54, Doug Anderson wrote:
>> > On Sat, Mar 28, 2020 at 12:35 AM Sai Prakash Ranjan
>> > <saiprakash.ranjan@codeaurora.org> wrote:
>> > >
>> > > > Of course the fact that in practice we'll *always* see the warning
>> > > > because there's no way to tear down the default DMA domains, and even
>> > > > if all devices *have* been nicely quiesced there's no way to tell, is
>> > > > certainly less than ideal. Like I say, it's not entirely clear-cut
>> > > > either way...
>> > > >
>> > >
>> > > Thanks for these examples, good to know these scenarios in case we
>> > > come
>> > > across these.
>> > > However, if we see these error/warning messages appear everytime then
>> > > what will be
>> > > the credibility of these messages? We will just ignore these messages
>> > > when
>> > > these issues you mention actually appears because we see them
>> > > everytime
>> > > on
>> > > reboot or shutdown.
>> >
>> > I would agree that if these messages are expected to be seen every
>> > time, there's no way to fix them, and they're not indicative of any
>> > problem then something should be done.  Seeing something printed at
>> > "dev_error" level with an exclamation point (!) at the end makes me
>> > feel like this is something that needs immediate action on my part.
>> >
>> > If we really can't do better but feel that the messages need to be
>> > there, at least make them dev_info and less scary like:
>> >
>> >   arm-smmu 15000000.iommu: turning off; DMA should be quiesced before
>> > now
>> >
>> > ...that would still give you a hint in the logs that if you saw a DMA
>> > transaction after the message that it was a bug but also wouldn't
>> > sound scary to someone who wasn't seeing any other problems.
>> >
>> 
>> We can do this if Robin is OK?
> 
> It would be nice if you could figure out which domains are still live 
> when
> the SMMU is being shut down in your case and verify that it *is* infact
> benign before we start making the message more friendly. As Robin said
> earlier, rogue DMA is a real nightmare to debug.
> 

I could see this error message for all the clients of apps_smmu.
I checked manually enabling bypass and removing iommus dt property
for each client of apps_smmu.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
