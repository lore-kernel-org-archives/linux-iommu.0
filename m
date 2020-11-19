Return-Path: <SRS0=wYjh=EZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944AFC2D0E4
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 09:34:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B77246DC
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 09:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuBYtJZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B77246DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5C15287346;
	Thu, 19 Nov 2020 09:33:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id puw7NSsGEAK9; Thu, 19 Nov 2020 09:33:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 980E98729A;
	Thu, 19 Nov 2020 09:33:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C6A6C163C;
	Thu, 19 Nov 2020 09:33:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99AE2C0891
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 09:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7FFC086A91
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 09:33:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zcx4Cu-eBGcL for <iommu@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 09:33:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BD1FA86A8F
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 09:33:56 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 74D2422259;
 Thu, 19 Nov 2020 09:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605778436;
 bh=qXHuW+5mvL0kkht9BzXP9H3dcimpEpohk7274SXiPt0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KuBYtJZnGXqY8JeIjLYwLEryyq/LFfBzf5DYNN5SW85VfI+kaKGbMGUzrSnqk2j0D
 LUlfV5i8/QByFuaWLyF9oZn0/7DWUdcAK4bPIfrg8X5L33e2/vwHHXGGVNtNaL5FIZ
 cPyAosIpV4VK+9atwS0PHWoHObpNFihK+s9u8lqY=
Date: Thu, 19 Nov 2020 09:33:48 +0000
From: Will Deacon <will@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v6 3/3] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
Message-ID: <20201119093348.GF3599@willie-the-truck>
References: <20201106042710.55979-1-john.stultz@linaro.org>
 <20201106042710.55979-3-john.stultz@linaro.org>
 <20201116155936.GE2224373@ulmo>
 <20201116163603.GA30507@willie-the-truck>
 <CALAqxLVDm923WRSB+DVxFacmEtmEPS7Qeq+rW_jbCDMNMWw9PQ@mail.gmail.com>
 <20201117134754.GB2589875@ulmo>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201117134754.GB2589875@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, lkml <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
 John Stultz <john.stultz@linaro.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jon Hunter <jonathanh@nvidia.com>,
 Kalle Valo <kvalo@codeaurora.org>, Todd Kjos <tkjos@google.com>
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

On Tue, Nov 17, 2020 at 02:47:54PM +0100, Thierry Reding wrote:
> On Mon, Nov 16, 2020 at 11:48:39AM -0800, John Stultz wrote:
> > On Mon, Nov 16, 2020 at 8:36 AM Will Deacon <will@kernel.org> wrote:
> > > On Mon, Nov 16, 2020 at 04:59:36PM +0100, Thierry Reding wrote:
> > > > On Fri, Nov 06, 2020 at 04:27:10AM +0000, John Stultz wrote:
> > > > Unfortunately, the ARM SMMU module will eventually end up being loaded
> > > > once the root filesystem has been mounted (for example via SDHCI or
> > > > Ethernet, both with using just plain, non-IOMMU-backed DMA API) and then
> > > > initialize, configuring as "fault by default", which then results from a
> > > > slew of SMMU faults from all the devices that have previously configured
> > > > themselves without IOMMU support.
> > >
> > > I wonder if fw_devlink=on would help here?
> > >
> > > But either way, I'd be more inclined to revert this change if it's causing
> > > problems for !QCOM devices.
> > >
> > > Linus -- please can you drop this one (patch 3/3) for now, given that it's
> > > causing problems?
> > 
> > Agreed. Apologies again for the trouble.
> > 
> > I do feel like the probe timeout to handle optional links is causing a
> > lot of the trouble here. I expect fw_devlink would solve this, but it
> > may be awhile before it can be always enabled.  I may see about
> > pushing the default probe timeout value to be a little further out
> > than init (I backed away from my last attempt as I didn't want to
> > cause long (30 second) delays for cases like NFS root, but maybe 2-5
> > seconds would be enough to make things work better for everyone).
> 
> I think there are two problems here: 1) the deferred probe timeout can
> cause a mismatch between what SMMU masters and the SMMU think is going
> on and 2) a logistical problem of dealing with the SMMU driver being a
> loadable module.
> 
> The second problem can be dealt with by shipping the module in the
> initial ramdisk. That's a bit annoying, but perhaps the right thing to
> do. At least on Tegra we need this because all the devices that carry
> the root filesystem (Ethernet for NFS and SDHCI/USB/SATA/PCI for disk
> boot) are SMMU masters and will start to fault once the SMMU driver is
> loaded.

Realistically, if you're building an IOMMU driver as a module then it needs
to be part of the initrd and fw_devlink needs to be enabled. Relying on
timeouts and the phase of the moon is not going to be reliable.

But back to the original issue, I think we should revert the Kconfig patch
from Linus' tree. Please can you send a revert for that?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
