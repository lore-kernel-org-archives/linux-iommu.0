Return-Path: <SRS0=unsG=4I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEA9C11D04
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 08:46:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE180207FD
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 08:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lI95RFO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE180207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C10B986566;
	Thu, 20 Feb 2020 08:46:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id amT2VmrOmXhy; Thu, 20 Feb 2020 08:46:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2AB4A846EE;
	Thu, 20 Feb 2020 08:46:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11651C1D81;
	Thu, 20 Feb 2020 08:46:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C500C013E
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 08:45:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8594B20008
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 08:45:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z80vrgOs76-X for <iommu@lists.linux-foundation.org>;
 Thu, 20 Feb 2020 08:45:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 677B91FFFE
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 08:45:57 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BBBD9207FD;
 Thu, 20 Feb 2020 08:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582188357;
 bh=M6GGXuQ/D6jiRe6KPYbT3GWIqkyMWWqU9w9MfTEu9pc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lI95RFO8JMLFC9bEmf1jbUprqiB7R/md/sR6FxYDha9JFtReCPlJ8MzUa8NB4H7yn
 elIzgxmFyp4jHkujurvO69MXlPwSkJHAxULUB0mTK8rEzCAJqLKDq/eGxbqzbVYOX1
 75GGZ4a4pc3c6KF0Jp8wmYBF1HTwpHWB98LbtTNU=
Date: Thu, 20 Feb 2020 08:45:52 +0000
From: Will Deacon <will@kernel.org>
To: isaacm@codeaurora.org
Subject: Re: [RFC PATCH] iommu/dma: Allow drivers to reserve an iova range
Message-ID: <20200220084552.GB11827@willie-the-truck>
References: <1581721096-16235-1-git-send-email-isaacm@codeaurora.org>
 <20200217080138.GB10342@infradead.org>
 <c58fd502-52a4-cb0f-6e7f-e9cc00627313@arm.com>
 <fc6e1b6689bca7a00e6b12d2bc877d20@codeaurora.org>
 <20200219111501.GA19400@willie-the-truck>
 <d8b70a579f07c688b264e83a0ec0b6d6@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d8b70a579f07c688b264e83a0ec0b6d6@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel-team@android.com, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, Liam Mark <lmark@codeaurora.org>,
 iommu@lists.linux-foundation.org, pratikp@codeaurora.org
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

On Wed, Feb 19, 2020 at 12:06:28PM -0800, isaacm@codeaurora.org wrote:
> On 2020-02-19 03:15, Will Deacon wrote:
> > On Tue, Feb 18, 2020 at 05:57:18PM -0800, isaacm@codeaurora.org wrote:
> > > Does this mean that the driver should be managing the IOVA space and
> > > mappings for this device using the IOMMU API? If so, is the
> > > rationale for
> > > this because the device driver can have the information of what IOVA
> > > ranges
> > > can and cannot be used? Shouldn't there be a generic way of
> > > informing an
> > > IOMMU driver about these reserved ranges? Perhaps through a device
> > > tree
> > > property, instead of deferring this type of management to the driver?
> > 
> > Before we dive into designing that, can you please clarify whether the
> > reserved IOVA range applies to all DMA masters mastering through a
> > particular SMMU, or whether it's just about one specific master? I was
> > assuming the former, but wanted to be sure.
> > 
> This situation currently applies to one master.

Interesting. Is it problematic if the range is reserved for all masters
sharing that SMMU?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
