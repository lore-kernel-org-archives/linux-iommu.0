Return-Path: <SRS0=WqUy=VV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69091C7618B
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 12:20:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358FB22ADC
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 12:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfPCR8OU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358FB22ADC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0291FE47;
	Wed, 24 Jul 2019 12:20:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 58670E47
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 12:20:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 09404FE
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 12:20:25 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id A275A22ADA;
	Wed, 24 Jul 2019 12:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563970824;
	bh=pgcJEKrwdYRgXicBh7NyaBZUa1rW+2Kry3AR4eLbdjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lfPCR8OUqnOPOzvlRca2gkMwvCYmLlHw2WMRpZKMfO3rMikY3GuoVPQlvlrgZCGi1
	RTheLkEiOTWM6PskBOr7a3bfQU0jxclmeSFL4/LWH34UXL+cGRjR9rw/fq35ohkyDg
	vRmB/ZU8Ubi8ae8kMAmCLLOMUW8ZnitZXRTfZGx4=
Date: Wed, 24 Jul 2019 13:20:19 +0100
From: Will Deacon <will@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [RFC PATCH v2 00/19] Try to reduce lock contention on the SMMUv3
	command queue
Message-ID: <20190724122019.tzllwvqzy5ptfz6c@willie-the-truck>
References: <20190711171927.28803-1-will@kernel.org>
	<c8dcc53f-8afa-0966-dcfd-ca79b099893f@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c8dcc53f-8afa-0966-dcfd-ca79b099893f@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: Vijay Kilary <vkilari@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Jon Masters <jcm@redhat.com>, Jan Glauber <jglauber@marvell.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Wed, Jul 24, 2019 at 10:58:26AM +0100, John Garry wrote:
> On 11/07/2019 18:19, Will Deacon wrote:
> > This is a significant rework of the RFC I previously posted here:
> > 
> >   https://lkml.kernel.org/r/20190611134603.4253-1-will.deacon@arm.com
> > 
> > But this time, it looks like it might actually be worthwhile according
> > to my perf profiles, where __iommu_unmap() falls a long way down the
> > profile for a multi-threaded netperf run. I'm still relying on others to
> > confirm this is useful, however.
> > 
> > Some of the changes since last time are:
> > 
> >   * Support for constructing and submitting a list of commands in the
> >     driver
> > 
> >   * Numerous changes to the IOMMU and io-pgtable APIs so that we can
> >     submit commands in batches
> > 
> >   * Removal of cmpxchg() from cmdq_shared_lock() fast-path
> > 
> >   * Code restructuring and cleanups
> > 
> > This current applies against my iommu/devel branch that Joerg has pulled
> > for 5.3. If you want to test it out, I've put everything here:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=iommu/cmdq
> > 
> > Feedback welcome. I appreciate that we're in the merge window, but I
> > wanted to get this on the list for people to look at as an RFC.
> > 
> 
> I tested storage performance on this series, which I think is a better
> scenario to test than network performance, that being generally limited by
> the network link speed.

Interesting, thanks for sharing. Do you also see a similar drop in CPU time
to the one reported by Ganapat?

> Baseline performance (will/iommu/devel, commit 9e6ea59f3)
> 8x SAS disks D05	839K IOPS
> 1x NVMe D05		454K IOPS
> 1x NVMe D06		442k IOPS
> 
> Patchset performance (will/iommu/cmdq)
> 8x SAS disk D05		835K IOPS
> 1x NVMe D05		472K IOPS
> 1x NVMe D06		459k IOPS
> 
> So we see a bit of an NVMe boost, but about the same for 8x disks. No iommu
> performance is about 918K IOPs for 8x disks, so it is not limited by the
> medium.

It would be nice to know if this performance gap is because of Linux, or
simply because of the translation overhead in the SMMU hardware. Are you
able to get a perf profile to see where we're spending time?

Thanks,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
