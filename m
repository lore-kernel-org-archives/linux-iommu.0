Return-Path: <SRS0=x0pP=PB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EC4C433FE
	for <iommu@archiver.kernel.org>; Wed, 13 Oct 2021 16:20:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC5D4610C9
	for <iommu@archiver.kernel.org>; Wed, 13 Oct 2021 16:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AC5D4610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D52E60AC6;
	Wed, 13 Oct 2021 16:20:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L9uRWbIxRYmg; Wed, 13 Oct 2021 16:20:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4F4F86060D;
	Wed, 13 Oct 2021 16:20:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22758C000F;
	Wed, 13 Oct 2021 16:20:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99FFFC000D
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 16:20:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 89B8D4035C
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 16:20:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hkl3EepDX-WR for <iommu@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 16:20:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C793D4033F
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 16:20:30 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 228A860E96;
 Wed, 13 Oct 2021 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634142030;
 bh=q1ptrLrC6qidLtEaA8q3rDKJGyevclNAp0SRbFWUJrE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vi4MyLFV+WA6r1aarNq1pL+TdDzqHkLeCPRw3GzArSh0ZbHYhKxqSN2Z8xphPwxnO
 ThMXThfL0DNa8cTNdCu22rhhFVkPXy60kvmEkp8NLo5+DRg69vBmIDFqy/wXcdhlx1
 Eu44sahlBMVWEm7yzE16riTI3vxHc9t3hiyhUk5CCXrv4ktDlAnQZJ26U5Nlh6PUC/
 2tm4Kluc2HCxgFozhL9fF2icYOLnpyQ8nQDu8b5F6RCjndUXUBSNFYMjzmLHrrmtbm
 ImM8urfLMUrKqsiqUfTBgALN4UZme/QYwcMunWLmI1CVWDvU/oi9ggN+NQDb62RORn
 HOIveP4jTxM0Q==
Date: Wed, 13 Oct 2021 17:20:24 +0100
From: Will Deacon <will@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] iommu/arm: fix ARM_SMMU_QCOM compilation
Message-ID: <20211013162024.GA7134@willie-the-truck>
References: <20211012151841.2639732-1-arnd@kernel.org>
 <20211013075803.GB6701@willie-the-truck>
 <CAK8P3a1GaQ1kjkjOP09eTUu6MR+RjhSDU9s-49MPQ1FSOMUDEg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a1GaQ1kjkjOP09eTUu6MR+RjhSDU9s-49MPQ1FSOMUDEg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Alex Elder <elder@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 John Stultz <john.stultz@linaro.org>, Kalle Valo <kvalo@codeaurora.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>
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

Hi Arnd,

On Wed, Oct 13, 2021 at 10:33:55AM +0200, Arnd Bergmann wrote:
> On Wed, Oct 13, 2021 at 9:58 AM Will Deacon <will@kernel.org> wrote:
> > On Tue, Oct 12, 2021 at 05:18:00PM +0200, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > My previous bugfix ended up making things worse for the QCOM IOMMU
> > > driver when it forgot to add the Kconfig symbol that is getting used to
> > > control the compilation of the SMMU implementation specific code
> > > for Qualcomm.
> > >
> > > Fixes: 424953cf3c66 ("qcom_scm: hide Kconfig symbol")
> > > Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > Reported-by: John Stultz <john.stultz@linaro.org>
> > > Link: https://lore.kernel.org/lkml/20211010023350.978638-1-dmitry.baryshkov@linaro.org/
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > > In case we want fix it this way after all, here is the patch
> > > I made. Either this one or Dmitry patch from the link above
> > > is required for v5.15
> > > ---
> > >  drivers/iommu/Kconfig | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > > index c5c71b7ab7e8..3eb68fa1b8cc 100644
> > > --- a/drivers/iommu/Kconfig
> > > +++ b/drivers/iommu/Kconfig
> > > @@ -355,6 +355,14 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
> > >         'arm-smmu.disable_bypass' will continue to override this
> > >         config.
> > >
> > > +config ARM_SMMU_QCOM
> > > +     def_tristate y
> > > +     depends on ARM_SMMU && ARCH_QCOM
> > > +     select QCOM_SCM
> > > +     help
> > > +       When running on a Qualcomm platform that has the custom variant
> > > +       of the ARM SMMU, this needs to be built into the SMMU driver.
> > > +
> >
> > FWIW, I prefer this solution over changing the driver code, so:
> >
> > Acked-by: Will Deacon <will@kernel.org>
> >
> > I assume you'll be getting this fixed for 5.15?
> 
> I was hoping you and Joerg could just pick your preferred patch
> into the iommu fixes tree for v5.15.
> 
> I currently have nothing else pending for my asm-generic tree that
> introduced the regression, but I can take it through there if that helps
> you.

I also don't have any fixes pending, and I don't see any in Joerg's tree so
it's probably quickest if you send it on yourself. Is that ok?

Cheers,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
