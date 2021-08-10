Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33323C4338F
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 10:36:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43E860720
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 10:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D43E860720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CFB283051;
	Tue, 10 Aug 2021 10:36:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hqXUoYUvuN6C; Tue, 10 Aug 2021 10:36:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 221088355F;
	Tue, 10 Aug 2021 10:36:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEFE4C001A;
	Tue, 10 Aug 2021 10:36:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B739C000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 10:36:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1B4106087E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 10:36:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fjBuhfyHpX6Z for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 10:36:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 30E0760645
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 10:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628591761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8MKdVxhmWHkSF7Qc4zBZXEqJWUbfI37hUIq+4sHXK5w=;
 b=e8zqrthseXpaRUVLS4s2wHOlkI0YdLsuDLzzZdnTeumgjvt1wYkrfaROcfsW4KCtC6v56Y
 XvSZhMT2rjG6ncxWTY2/oBcWAqTb3SBPBh/eeb8gU49qrJ8Wh6Ip/SN1HtUA+mJtq+MfMH
 JRUT6qhIT6kpJ2LUMh6AiF3g3F/B+ek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-SLez8Vj3PA270oq6Eepj1A-1; Tue, 10 Aug 2021 06:35:58 -0400
X-MC-Unique: SLez8Vj3PA270oq6Eepj1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4B591008060;
 Tue, 10 Aug 2021 10:35:56 +0000 (UTC)
Received: from T590 (ovpn-13-190.pek2.redhat.com [10.72.13.190])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC8415C232;
 Tue, 10 Aug 2021 10:35:50 +0000 (UTC)
Date: Tue, 10 Aug 2021 18:35:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.garry@huawei.com>
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
Message-ID: <YRJWgU5VhzBe1JP4@T590>
References: <YPlGOOMSdm6Bcyy/@T590>
 <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com>
 <YPmUoBk9u+tU2rbS@T590>
 <0adbe03b-ce26-e4d3-3425-d967bc436ef5@arm.com>
 <YPqYDY9/VAhfHNfU@T590>
 <6ceab844-465f-3bf3-1809-5df1f1dbbc5c@huawei.com>
 <CAFj5m9J+9vO=CK3uPP+va5EoWffZj9ruSRe2fDDLXn+AE971CQ@mail.gmail.com>
 <ead87bf2-ddfa-eb67-db44-9619c6cdb714@huawei.com>
 <YQF1AKS6Y14dLU/A@T590>
 <dfdd16e8-278f-3bc9-da97-a91264aec909@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dfdd16e8-278f-3bc9-da97-a91264aec909@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Tue, Aug 10, 2021 at 10:36:47AM +0100, John Garry wrote:
> On 28/07/2021 16:17, Ming Lei wrote:
> > > > > Have you tried turning off the IOMMU to ensure that this is really just
> > > > > an IOMMU problem?
> > > > > 
> > > > > You can try setting CONFIG_ARM_SMMU_V3=n in the defconfig or passing
> > > > > cmdline param iommu.passthrough=1 to bypass the the SMMU (equivalent to
> > > > > disabling for kernel drivers).
> > > > Bypassing SMMU via iommu.passthrough=1 basically doesn't make a difference
> > > > on this issue.
> > > A ~90% throughput drop still seems to me to be too high to be a software
> > > issue. More so since I don't see similar on my system. And that throughput
> > > drop does not lead to a total CPU usage drop, from the fio log.
> > > 
> > > Do you know if anyone has run memory benchmark tests on this board to find
> > > out NUMA effect? I think lmbench or stream could be used for this.
> > https://lore.kernel.org/lkml/YOhbc5C47IzC893B@T590/
> 
> Hi Ming,
> 
> Out of curiosity, did you investigate this topic any further?

IMO, the issue is probably in device/system side, since completion latency is
increased a lot, meantime submission latency isn't changed.

Either the submission isn't committed to hardware in time, or the
completion status isn't updated to HW in time from viewpoint of CPU.

We have tried to update to new FW, but not see difference made.

> 
> And you also asked about my results earlier:
> 
> On 22/07/2021 16:54, Ming Lei wrote:
> >> [   52.035895] nvme 0000:81:00.0: Adding to iommu group 5
> >> [   52.047732] nvme nvme0: pci function 0000:81:00.0
> >> [   52.067216] nvme nvme0: 22/0/2 default/read/poll queues
> >> [   52.087318]  nvme0n1: p1
> >>
> >> So I get these results:
> >> cpu0 335K
> >> cpu32 346K
> >> cpu64 300K
> >> cpu96 300K
> >>
> >> So still not massive changes.
> > In your last email, the results are the following with irq mode io_uring:
> >
> >   cpu0  497K
> >   cpu4  307K
> >   cpu32 566K
> >   cpu64 488K
> >   cpu96 508K
> >
> > So looks you get much worse result with real io_polling?
> >
> 
> Would the expectation be that at least I get the same performance with
> io_polling here?

io_polling is supposed to improve IO latency a lot compared with irq
mode, and the perf data shows that clearly on x86_64.

> Anything else to try which you can suggest to investigate
> this lower performance?

You may try to compare irq mode and polling and narrow down the possible
reasons, no exact suggestion on how to investigate it, :-(


Thanks,
Ming

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
