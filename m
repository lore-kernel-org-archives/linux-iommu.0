Return-Path: <SRS0=x0pP=PB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33857C433EF
	for <iommu@archiver.kernel.org>; Wed, 13 Oct 2021 08:34:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E421361074
	for <iommu@archiver.kernel.org>; Wed, 13 Oct 2021 08:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E421361074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7093B80D17;
	Wed, 13 Oct 2021 08:34:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KoP47UCPw3qI; Wed, 13 Oct 2021 08:34:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4C59C80C88;
	Wed, 13 Oct 2021 08:34:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19F59C000F;
	Wed, 13 Oct 2021 08:34:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 944E4C000D
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 08:34:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77A484062B
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 08:34:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vjiuD4nmJKki for <iommu@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 08:34:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A79E640490
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 08:34:14 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BCB8610CE
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 08:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634114054;
 bh=im3WaSeib0gC+BjVK6fK56Be/lOGMJAnXEQ2iB8iVdE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=TcUGpIjnlHOUzg3n1yWPCQ6KtkLgfaK3Oakk1OXUyCPCdC1Rh3p1H9J3RbvY4IAdd
 xQw6C4LOxaSbMIe7OdhFau6OZIxdAW4Lj0FEEGe2C8nZCp7guRuLT+F+9ZZEsfYAzh
 C2mVRPJP9wsKCkPjhn9K1ArEYbT7VXSsy62eCS6IYTonEr4DF9lUSiEtYfVFxkPjfy
 DNp/fuIMywwW54i1AvEdJQ7+CtiiJjD7TVKdOiCEyYOSAV888zMGPp0t934nE0C25R
 iGrZCfBL1nYNM6iOTGCwYHPEYskIt2vb8xSowLYHsu2K11usQrL1NYu5MfcbVEi0Pk
 xiUNKSJ2TeWDw==
Received: by mail-wr1-f50.google.com with SMTP id i12so5554265wrb.7
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 01:34:14 -0700 (PDT)
X-Gm-Message-State: AOAM530MI+FzoqONNvWbNww8C1KfFiGn7deXRsb3K9YPy58MYNuXbtct
 qCqkp5V8VHRNCPkQhwqAxjvZfmkNifv6K01hqaw=
X-Google-Smtp-Source: ABdhPJzVNkCgV6mIZ2XLUuFLhH41TCPlTJKGbX2haLXegUVQFo0cnrLHPg78K9gOMcaWbT209IvfuMEdRMlTosZ1lcM=
X-Received: by 2002:adf:f481:: with SMTP id l1mr37302953wro.411.1634114052610; 
 Wed, 13 Oct 2021 01:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211012151841.2639732-1-arnd@kernel.org>
 <20211013075803.GB6701@willie-the-truck>
In-Reply-To: <20211013075803.GB6701@willie-the-truck>
From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 13 Oct 2021 10:33:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1GaQ1kjkjOP09eTUu6MR+RjhSDU9s-49MPQ1FSOMUDEg@mail.gmail.com>
Message-ID: <CAK8P3a1GaQ1kjkjOP09eTUu6MR+RjhSDU9s-49MPQ1FSOMUDEg@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm: fix ARM_SMMU_QCOM compilation
To: Will Deacon <will@kernel.org>
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

On Wed, Oct 13, 2021 at 9:58 AM Will Deacon <will@kernel.org> wrote:
> On Tue, Oct 12, 2021 at 05:18:00PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > My previous bugfix ended up making things worse for the QCOM IOMMU
> > driver when it forgot to add the Kconfig symbol that is getting used to
> > control the compilation of the SMMU implementation specific code
> > for Qualcomm.
> >
> > Fixes: 424953cf3c66 ("qcom_scm: hide Kconfig symbol")
> > Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Reported-by: John Stultz <john.stultz@linaro.org>
> > Link: https://lore.kernel.org/lkml/20211010023350.978638-1-dmitry.baryshkov@linaro.org/
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > In case we want fix it this way after all, here is the patch
> > I made. Either this one or Dmitry patch from the link above
> > is required for v5.15
> > ---
> >  drivers/iommu/Kconfig | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index c5c71b7ab7e8..3eb68fa1b8cc 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -355,6 +355,14 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
> >         'arm-smmu.disable_bypass' will continue to override this
> >         config.
> >
> > +config ARM_SMMU_QCOM
> > +     def_tristate y
> > +     depends on ARM_SMMU && ARCH_QCOM
> > +     select QCOM_SCM
> > +     help
> > +       When running on a Qualcomm platform that has the custom variant
> > +       of the ARM SMMU, this needs to be built into the SMMU driver.
> > +
>
> FWIW, I prefer this solution over changing the driver code, so:
>
> Acked-by: Will Deacon <will@kernel.org>
>
> I assume you'll be getting this fixed for 5.15?

I was hoping you and Joerg could just pick your preferred patch
into the iommu fixes tree for v5.15.

I currently have nothing else pending for my asm-generic tree that
introduced the regression, but I can take it through there if that helps
you.

         Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
