Return-Path: <SRS0=Kmd8=UQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A43DC31E5B
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 18:15:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CAF8208C0
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 18:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CAF8208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 21543D9E;
	Mon, 17 Jun 2019 18:15:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0EF1BB8F
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 18:15:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id A3049822
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 18:15:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 332862B;
	Mon, 17 Jun 2019 11:15:52 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB6CE3F246;
	Mon, 17 Jun 2019 11:15:50 -0700 (PDT)
Date: Mon, 17 Jun 2019 19:15:48 +0100
From: Will Deacon <will.deacon@arm.com>
To: John Garry <john.garry@huawei.com>
Subject: Re: [RFC CFT 0/6] Try to reduce lock contention on the SMMUv3
	command queue
Message-ID: <20190617181548.GO30800@fuggles.cambridge.arm.com>
References: <20190611134603.4253-1-will.deacon@arm.com>
	<7c5a590c-dd7f-2e17-6c99-ac95ff59af07@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7c5a590c-dd7f-2e17-6c99-ac95ff59af07@huawei.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Cc: Vijay Kilary <vkilari@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Jon Masters <jcm@redhat.com>, Jan Glauber <jglauber@marvell.com>,
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

Hi John,

On Mon, Jun 17, 2019 at 02:38:59PM +0100, John Garry wrote:
> On 11/06/2019 14:45, Will Deacon wrote:
> > Hi all,
> > 
> > This patch series is an attempt to reduce lock contention when inserting
> > commands into the Arm SMMUv3 command queue. Unfortunately, our initial
> > benchmarking has shown mixed results across the board and the changes in
> > the last patch don't appear to justify their complexity. Based on that,
> > I only plan to queue the first patch for the time being.
> > 
> > Anyway, before I park this series, I thought it was probably worth
> > sharing it in case it's useful to somebody. If you have a system where
> > you believe I/O performance to be limited by the SMMUv3 command queue
> > then please try these patches and let me know what happens, even if it's
> > just more bad news.
> > 
> > Patches based on 5.2-rc3. I've also pushed them out to my iommu/devel
> > branch for the moment:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=iommu/devel
> > 
> 
> For command queue lock contention, we had this series previously:
> https://lore.kernel.org/linux-iommu/61b4c3e5f1322dfe96ca2062a7fe058298340996.1539782799.git.robin.murphy@arm.com/#t
> 
> I am just wondering does this have any future?

The functionality of that series is subsumed by the patches I've posted
here, although if I can't get the cmpxchg() loop working well here then
we could revisit just making the change proposed by Robin. The problem is
that we'll still have serialisation on access to the command queue, and
therefore it will remain a scalability bottleneck as long as the fast-path
needs to queue for a lock.

However, I've still got a few tricks up my sleeve so I'm hoping to get a
new version of this lot out in the coming weeks.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
