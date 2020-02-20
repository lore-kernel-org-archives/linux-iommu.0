Return-Path: <SRS0=unsG=4I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9558DC11D0C
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 19:43:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C009206F4
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 19:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="QAn63XpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C009206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EB4DD85707;
	Thu, 20 Feb 2020 19:43:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Da1sm4dJZsDz; Thu, 20 Feb 2020 19:43:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5FCE1850ED;
	Thu, 20 Feb 2020 19:43:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 484E4C1D84;
	Thu, 20 Feb 2020 19:43:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEDE3C013E
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 18:57:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9E012860C6
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 18:57:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EEmo6nN4TmIe for <iommu@lists.linux-foundation.org>;
 Thu, 20 Feb 2020 18:57:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B99718485A
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 18:57:33 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1582225055; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=vvYcgKLiQoRaBLEmDopEG/p1yFw3UjwbMybQGfgcmIs=;
 b=QAn63XpO+s4x6BI6KWAIeLC1psd9q2/6yt74D/yvSA8kHTqNJlLFnhJEjjf4D/qleltPZ1hK
 rG1yg1gndEWILiikq7AagL28hd2CQxP9AdONN/Xb24DYPK/mJJiwXmYO/QUNvDN3xVmD8gIo
 E/U7ICYqSmTfcmz/sspXcwRqrdQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4ed69a.7f32dd5bd2d0-smtp-out-n03;
 Thu, 20 Feb 2020 18:57:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 66ADFC447A2; Thu, 20 Feb 2020 18:57:29 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pratikp)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id BC218C43383;
 Thu, 20 Feb 2020 18:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC218C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=pratikp@codeaurora.org
Date: Thu, 20 Feb 2020 10:57:28 -0800
From: Pratik Patel <pratikp@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH] iommu/dma: Allow drivers to reserve an iova range
Message-ID: <20200220185728.GA32137@pratikp-lnx>
References: <1581721096-16235-1-git-send-email-isaacm@codeaurora.org>
 <20200217080138.GB10342@infradead.org>
 <c58fd502-52a4-cb0f-6e7f-e9cc00627313@arm.com>
 <fc6e1b6689bca7a00e6b12d2bc877d20@codeaurora.org>
 <20200219111501.GA19400@willie-the-truck>
 <d8b70a579f07c688b264e83a0ec0b6d6@codeaurora.org>
 <20200220084552.GB11827@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200220084552.GB11827@willie-the-truck>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-Mailman-Approved-At: Thu, 20 Feb 2020 19:43:34 +0000
Cc: isaacm@codeaurora.org, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Liam Mark <lmark@codeaurora.org>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

On 02/20  08:45 am, Will Deacon wrote:
> On Wed, Feb 19, 2020 at 12:06:28PM -0800, isaacm@codeaurora.org wrote:
> > On 2020-02-19 03:15, Will Deacon wrote:
> > > On Tue, Feb 18, 2020 at 05:57:18PM -0800, isaacm@codeaurora.org wrote:
> > > > Does this mean that the driver should be managing the IOVA space and
> > > > mappings for this device using the IOMMU API? If so, is the
> > > > rationale for
> > > > this because the device driver can have the information of what IOVA
> > > > ranges
> > > > can and cannot be used? Shouldn't there be a generic way of
> > > > informing an
> > > > IOMMU driver about these reserved ranges? Perhaps through a device
> > > > tree
> > > > property, instead of deferring this type of management to the driver?
> > > 
> > > Before we dive into designing that, can you please clarify whether the
> > > reserved IOVA range applies to all DMA masters mastering through a
> > > particular SMMU, or whether it's just about one specific master? I was
> > > assuming the former, but wanted to be sure.
> > > 
> > This situation currently applies to one master.
> 
> Interesting. Is it problematic if the range is reserved for all masters
> sharing that SMMU?
> 
Yes, that would be an overkill. It certainly is useful and in
some cases quite helpful to not waste that range of IOVA space for
other masters on the same SMMU that can use it.

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
