Return-Path: <SRS0=TfYV=XM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8A1C4CECD
	for <iommu@archiver.kernel.org>; Tue, 17 Sep 2019 13:36:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7387D218AE
	for <iommu@archiver.kernel.org>; Tue, 17 Sep 2019 13:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sar6QHXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7387D218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5572B1521;
	Tue, 17 Sep 2019 13:36:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 039651505
	for <iommu@lists.linux-foundation.org>;
	Tue, 17 Sep 2019 13:36:47 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A067C81A
	for <iommu@lists.linux-foundation.org>;
	Tue, 17 Sep 2019 13:36:46 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id EBE97206C2;
	Tue, 17 Sep 2019 13:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568727406;
	bh=Ql3S5LeLxQu05wGmhaTM95fv1AHLxdIM1bfELOE4N7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sar6QHXnAAyU7CqcX6S4XEMZKCw1XqlFh7JOPCZcEm7NSSw7o9n4M4YTyIEluCTr+
	PlHd+kmgg4Vr/dK3w6I2fdh2OfNlJWZ1RrBSnCix074v+q0zWCpWT1ivxI6TO8Oge1
	wto9mDPRvI0UPcufLj8FL+blmnWYDbjxJUHoo8rI=
Date: Tue, 17 Sep 2019 14:36:37 +0100
From: Will Deacon <will@kernel.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v3 0/2] iommu: handle drivers that manage iommu directly
Message-ID: <20190917133637.urqphz5drzmugern@willie-the-truck>
References: <20190906214409.26677-1-robdclark@gmail.com>
	<c43de10f-7768-592c-0fd8-6fb64b3fd43e@arm.com>
	<CAF6AEGv5WtwOuUE-+koL3SxuoXxcT5n=EooD7G_4YRh34HFTwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF6AEGv5WtwOuUE-+koL3SxuoXxcT5n=EooD7G_4YRh34HFTwQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Clark <robdclark@chromium.org>,
	Jonathan Marek <jonathan@marek.ca>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mamta Shukla <mamtashukla555@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Joerg Roedel <jroedel@suse.de>, Arnd Bergmann <arnd@arndb.de>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Abhinav Kumar <abhinavk@codeaurora.org>, Bruce Wang <bzwang@chromium.org>,
	Alexios Zavras <alexios.zavras@intel.com>,
	Sean Paul <seanpaul@chromium.org>,
	Jeykumar Sankaran <jsanka@codeaurora.org>,
	Allison Randal <allison@lohutok.net>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	open list <linux-kernel@vger.kernel.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	Sudeep Holla <sudeep.holla@arm.com>, Joe Perches <joe@perches.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"open list:DRM DRIVER FOR MSM ADRENO GPU"
	<freedreno@lists.freedesktop.org>,
	Georgi Djakov <georgi.djakov@linaro.org>,
	Sravanthi Kollukuduru <skolluku@codeaurora.org>
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

On Tue, Sep 10, 2019 at 10:10:49AM -0700, Rob Clark wrote:
> On Tue, Sep 10, 2019 at 9:34 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > On 06/09/2019 22:44, Rob Clark wrote:
> > > NOTE that in discussion of previous revisions, RMRR came up.  This is
> > > not really a replacement for RMRR (nor does RMRR really provide any
> > > more information than we already get from EFI GOP, or DT in the
> > > simplefb case).  I also don't see how RMRR could help w/ SMMU handover
> > > of CB/SMR config (Bjorn's patchset[1]) without defining new tables.
> >
> > The point of RMRR-like-things is that they identify not just the memory
> > region but also the specific device accessing them, which means the
> > IOMMU driver knows up-front which IDs etc. it must be careful not to
> > disrupt. Obviously for SMMU that *would* be some new table (designed to
> > encompass everything relevant) since literal RMRRs are specifically an
> > Intel VT-d thing.
> 
> Perhaps I'm not looking in the right place, but the extent of what I
> could find about RMRR tables was:
> 
> https://github.com/tianocore/edk2/blob/master/MdePkg/Include/IndustryStandard/DmaRemappingReportingTable.h#L122
> 
> I couldn't really see how that specifies the device.  But entirely
> possible that I'm not seeing the whole picture.

I don't think anybody was planning to implement RMRR "as-is" for arm64, so
you might be better off looking at the proposal from Thierry, although it
has some issues that are still to be resolved:

http://lkml.kernel.org/r/20190829111407.17191-1-thierry.reding@gmail.com

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
