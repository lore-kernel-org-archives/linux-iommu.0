Return-Path: <SRS0=1rIG=YL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82665CA9EA0
	for <iommu@archiver.kernel.org>; Fri, 18 Oct 2019 15:48:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F0582064B
	for <iommu@archiver.kernel.org>; Fri, 18 Oct 2019 15:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0582064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E7A1CC58;
	Fri, 18 Oct 2019 15:48:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 02FB0900
	for <iommu@lists.linux-foundation.org>;
	Fri, 18 Oct 2019 15:48:00 +0000 (UTC)
X-Greylist: delayed 00:05:56 by SQLgrey-1.7.6
Received: from muru.com (muru.com [72.249.23.125])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 6FAF2608
	for <iommu@lists.linux-foundation.org>;
	Fri, 18 Oct 2019 15:47:59 +0000 (UTC)
Received: from atomide.com (localhost [127.0.0.1])
	by muru.com (Postfix) with ESMTPS id D53E8809F;
	Fri, 18 Oct 2019 15:42:35 +0000 (UTC)
Date: Fri, 18 Oct 2019 08:41:58 -0700
From: Tony Lindgren <tony@atomide.com>
To: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 0/2] OMAP IOMMU fixes to go with 5.4 OMAP IOMMU changes
Message-ID: <20191018154158.GQ5610@atomide.com>
References: <20190827001452.31930-1-s-anna@ti.com>
	<68474455-c997-a40e-74c4-ea3e0faa6c24@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <68474455-c997-a40e-74c4-ea3e0faa6c24@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: Tero Kristo <t-kristo@ti.com>, iommu@lists.linux-foundation.org,
	Sakari Ailus <sakari.ailus@iki.fi>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-omap@vger.kernel.org
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

* Suman Anna <s-anna@ti.com> [191017 23:00]:
> Hi Tony,
> 
> On 8/26/19 7:14 PM, Suman Anna wrote:
> > Hi Tony,
> > 
> > The following 2 patches need to go along with the recent "iommu/omap: misc
> > fixes" series [1] that is currently staged [2] for a 5.4 merge and available
> > in linux-next. That series added runtime pm callbacks in preparation for
> > the ti-sysc migration, but without adding the necessary platform data
> > callbacks for the existing functional MMUs on OMAP3, OMAP4 and OMAP5 SoCs.
> > These 2 patches add the same to maintain the functionality (l3_noc errors
> > are the visible symptom while enabling the MMUs without these patches).
> > 
> > OMAP4 and OMAP5 would also need another set of fixes related to the
> > breakage caused by the switch to clkctrl clocks as seen in [3].
> > 
> > These patches do have a dependency on the staged patches, so either you
> > submit a pull-request towards 5.4-rc2 using 5.4-rc1 baseline, or let
> > Joerg pick these through the arm/omap IOMMU branch for 5.4-rc1 itself.
> > 
> > Sakari/Laurent,
> > Appreciate it if you can check the OMAP3 ISP functionality on latest
> > linux-next with the second patch. I have verified the ISP MMU programming
> > only through an unit-test.
> > 
> > Tero,
> > I will be submitting another patch against OMAP IOMMU driver to skip the
> > pdata callbacks for ti-sysc in the next couple of days.
> > 
> > regards
> > Suman
> > 
> > [1] https://lore.kernel.org/linux-iommu/20190809153730.GF12930@8bytes.org/T/#mec99f8e8ed351689f4fcc76f4f000f9144a02b51
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/log/?h=arm/omap
> > [3] https://patchwork.kernel.org/patch/11082125/#22829477
> > 
> > Suman Anna (2):
> >   ARM: OMAP2+: Plug in device_enable/idle ops for IOMMUs
> >   ARM: OMAP2+: Add pdata for OMAP3 ISP IOMMU
> 
> Can you please pick these patches up for 5.4-rc cycle? The OMAP IOMMU
> changes that went in for 5.4-rc1 need the pdata to be plugged in.

Oh OK. Sorry for missing these, I untagged them earlier as they
produced kbuilder test failures as the dependencies were
missing earlier.

Applying both into fixes.

Regards,

Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
