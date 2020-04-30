Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B78AC8300A
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 11:02:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 212862078D
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 11:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="l6IVZ5Pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212862078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DA527886AD;
	Thu, 30 Apr 2020 11:02:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IJ60pDYZL6Gd; Thu, 30 Apr 2020 11:02:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 551778869D;
	Thu, 30 Apr 2020 11:02:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32AE3C088F;
	Thu, 30 Apr 2020 11:02:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1979AC088D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 11:02:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E50D2886A7
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 11:02:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2wDtg4L8Zg7X for <iommu@lists.linux-foundation.org>;
 Thu, 30 Apr 2020 11:02:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BC690886B9
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 11:02:17 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1588244539; h=In-Reply-To: Content-Type: MIME-Version:
 References: Reply-To: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=6O+7YgQwWnlvumFVVWc+1u34+7IdYtJxCQ6pA3ekUCE=;
 b=l6IVZ5PaQ4fi7dzy7GUFcT+jRY3Dma7KD7csh4D+V9HAlhIFP7Kzfv+lQc3D6o7BGjmKNewn
 ck+kryLW/A2zlj6BIfmanGE+DtBiirKqB/fqP1WicrlPCyh22nhU25P9C+1UdlfHV+tlx5YR
 hi1k765vmvBfvSi8av+0GO14erM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eaab037.7f7d8c9b77d8-smtp-out-n02;
 Thu, 30 Apr 2020 11:02:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 59646C4478C; Thu, 30 Apr 2020 11:02:14 +0000 (UTC)
Received: from quicinc.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: svaddagi)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 6F10AC433D2;
 Thu, 30 Apr 2020 11:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6F10AC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=vatsa@codeaurora.org
Date: Thu, 30 Apr 2020 16:32:06 +0530
From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [RFC/PATCH 0/1] virtio_mmio: hypervisor specific interfaces for
 MMIO
Message-ID: <20200430110206.GB3204@quicinc.com>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <20200430100821.GC19932@willie-the-truck>
 <20200430102939.GG5097@quicinc.com>
 <20200430103919.GF19932@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200430103919.GF19932@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org, mst@redhat.com,
 jan.kiszka@siemens.com, jasowang@redhat.com, konrad.wilk@oracle.com,
 christoffer.dall@arm.com, virtualization@lists.linux-foundation.org,
 alex.bennee@linaro.org, iommu@lists.linux-foundation.org,
 stefano.stabellini@xilinx.com, pratikp@codeaurora.org,
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
Reply-To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

* Will Deacon <will@kernel.org> [2020-04-30 11:39:19]:

> Hi Vatsa,
> 
> On Thu, Apr 30, 2020 at 03:59:39PM +0530, Srivatsa Vaddagiri wrote:
> > > What's stopping you from implementing the trapping support in the
> > > hypervisor? Unlike the other patches you sent out, where the guest memory
> > > is not accessible to the host, there doesn't seem to be any advantage to
> > > not having trapping support, or am I missing something here?
> > 
> > 	I have had this discussion with hypervisor folks. They seem to be
> > concerned about complexity of having a VM's fault be handled in another
> > untrusted VM. They are not keen to add MMIO support.
> 
> Right, but I'm concerned about forking the implementation from the spec
> and I'm not keen to add these hooks ;)
> 
> What does your hook actually do? I'm assuming an HVC? 

Yes, it will issue message-queue related hypercalls

> If so, then where the
> fault is handled seems to be unrelated and whether the guest exit is due to
> an HVC or a stage-2 fault should be immaterial. 

A stage-2 fault would be considered fatal normally and result in termination of
guest. Modifying that behavior to allow resumption in case of virtio config
space access, especially including the untrusted VM in this flow, is
perhaps the concern. HVC calls OTOH are more vetted interfaces that the
hypervisor has to do nothing additional to handle.

> In other words, I don't
> follow why the trapping mechanism necessitates the way in which the fault is
> handled.

Let me check with our hypervisor folks again. Thanks for your inputs.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
