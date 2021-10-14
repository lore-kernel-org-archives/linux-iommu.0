Return-Path: <SRS0=rAFC=PC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4C6C433F5
	for <iommu@archiver.kernel.org>; Thu, 14 Oct 2021 07:35:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F0F610F9
	for <iommu@archiver.kernel.org>; Thu, 14 Oct 2021 07:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 15F0F610F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC17B40722;
	Thu, 14 Oct 2021 07:35:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kWYR8emwnfKp; Thu, 14 Oct 2021 07:35:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D4811406F9;
	Thu, 14 Oct 2021 07:35:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6305C000F;
	Thu, 14 Oct 2021 07:35:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C480BC000D
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 07:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 98E78607E3
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 07:35:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mqEyRKqru4lB for <iommu@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 07:35:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 37603607BA
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 07:35:52 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7532460FDC;
 Thu, 14 Oct 2021 07:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634196951;
 bh=6uDUVmn+lPgae2Av9Y+lntZQNsMV/gFXI/gYxOwCBV8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XgpzG/u3e/hTVO+wbHSLmwfDQl3NUCabsXI4+bB3xA/OzBLT2F8Vnw5i1+CD/G1kP
 42UcHgZj+kypZJ6gacDQ5xwJFyN/03DwSfIdGD7E392XlJvYO7wzbaTdRvoEXICTyO
 ZhhXZ655jsYaoNRBKANDEKv+zE+mxVvBk4Kc1A1EEQDKCBysG+YMXyZcmYEPAGyRSR
 IRI5E9AHlxitx/upLlZx3f8eutCePXi0ro5BawBfTyLK1ahwxyVwAhgSXyrQiSlCxb
 Z88syAJtompnHJ/dqba8dAWl+w+xmji8Vn4ZyNMjJNCIjx35Ikizi9qNpgcacnlj4J
 094u1VQUxylMQ==
Date: Thu, 14 Oct 2021 08:35:45 +0100
From: Will Deacon <will@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] iommu/arm: fix ARM_SMMU_QCOM compilation
Message-ID: <20211014073545.GA7857@willie-the-truck>
References: <20211012151841.2639732-1-arnd@kernel.org>
 <20211013075803.GB6701@willie-the-truck>
 <CAK8P3a1GaQ1kjkjOP09eTUu6MR+RjhSDU9s-49MPQ1FSOMUDEg@mail.gmail.com>
 <20211013162024.GA7134@willie-the-truck>
 <CAK8P3a0aLKv76AjuLO4kMa3hDj8LwsGxGhGToX935pdfsr15KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a0aLKv76AjuLO4kMa3hDj8LwsGxGhGToX935pdfsr15KQ@mail.gmail.com>
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

On Wed, Oct 13, 2021 at 09:31:40PM +0200, Arnd Bergmann wrote:
> On Wed, Oct 13, 2021 at 6:20 PM Will Deacon <will@kernel.org> wrote:
> > On Wed, Oct 13, 2021 at 10:33:55AM +0200, Arnd Bergmann wrote:
> > > On Wed, Oct 13, 2021 at 9:58 AM Will Deacon <will@kernel.org> wrote:
> > > > On Tue, Oct 12, 2021 at 05:18:00PM +0200, Arnd Bergmann wrote:
> 
> > > I was hoping you and Joerg could just pick your preferred patch
> > > into the iommu fixes tree for v5.15.
> > >
> > > I currently have nothing else pending for my asm-generic tree that
> > > introduced the regression, but I can take it through there if that helps
> > > you.
> >
> > I also don't have any fixes pending, and I don't see any in Joerg's tree so
> > it's probably quickest if you send it on yourself. Is that ok?
> 
> Sure, no problem. I ended up adding it to the arm/fixes branch of the
> soc tree, as I just merged some other fixes there, and it seems as good
> as any of the other trees.

Thanks, Arnd!

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
