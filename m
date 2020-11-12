Return-Path: <SRS0=2i4G=ES=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC31C56201
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 17:37:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3102622201
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 17:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUCznGRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3102622201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A5B6D8726A;
	Thu, 12 Nov 2020 17:37:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YeZxZPzVXAz8; Thu, 12 Nov 2020 17:37:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 403C48723D;
	Thu, 12 Nov 2020 17:37:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CF82C088B;
	Thu, 12 Nov 2020 17:37:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3AE3C016F
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 17:37:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 91B3387839
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 17:37:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TXu08Lm-WlTJ for <iommu@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 17:37:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DBC8087838
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 17:37:29 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DD0C021D40;
 Thu, 12 Nov 2020 17:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605202649;
 bh=OpMVTIHp5xtXn9ioPR7A/G7DjaB4pvaonJfkTOta0JM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jUCznGRlc+VHYYw1MdvpmdeeJV7ioBUPoWwhFvMHgXduVEjM410PYXovDx+8g1Q25
 Bppux+CBwlFKPI8Wlk4fcsCSvhX5JE7Zbp2PszkU1tHqQaeylp/mVyHW2wDQ6RBFY/
 XkOwmmWRVxE4OIld1aqrLQBTkXON8YmwLEabZe0w=
Date: Thu, 12 Nov 2020 17:37:22 +0000
From: Will Deacon <will@kernel.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v6 3/3] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
Message-ID: <20201112173721.GB20000@willie-the-truck>
References: <20201106042710.55979-1-john.stultz@linaro.org>
 <20201106042710.55979-3-john.stultz@linaro.org>
 <CACRpkdYhfjRBz8GwMyCrOTzjd-Y6-G16xPjH6xhwSHcnaJfuXA@mail.gmail.com>
 <CALAqxLXigwvauJgvN5FxoND60zybYw1L78POHY6KoxP2_gpkFA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALAqxLXigwvauJgvN5FxoND60zybYw1L78POHY6KoxP2_gpkFA@mail.gmail.com>
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
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Kalle Valo <kvalo@codeaurora.org>,
 Todd Kjos <tkjos@google.com>
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

On Tue, Nov 10, 2020 at 10:51:46AM -0800, John Stultz wrote:
> On Tue, Nov 10, 2020 at 5:35 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Fri, Nov 6, 2020 at 5:27 AM John Stultz <john.stultz@linaro.org> wrote:
> >
> > > Allow the qcom_scm driver to be loadable as a permenent module.
> > >
> ...
> > I applied this patch to the pinctrl tree as well, I suppose
> > that was the intention. If someone gets upset I can always
> > pull it out.
> 
> Will: You ok with this?

We didn't come up with something better, so I can live with it. Not sure
about the otehr issues that were reported by Robin though -- your RFC for
fixing those looked a bit more controversial ;)

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
