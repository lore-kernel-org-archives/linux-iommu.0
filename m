Return-Path: <SRS0=r5As=AO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE62C433E0
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 12:49:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 122C620899
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 12:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0x5onKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122C620899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D4B76884CA;
	Fri,  3 Jul 2020 12:49:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SJJZ-lGiYkHa; Fri,  3 Jul 2020 12:49:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 508D88846E;
	Fri,  3 Jul 2020 12:49:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42E91C0888;
	Fri,  3 Jul 2020 12:49:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94872C0733
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 12:49:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7C3F888478
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 12:49:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Azvo4BWI1ywd for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jul 2020 12:49:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EB9048846E
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 12:49:20 +0000 (UTC)
Received: from localhost (unknown [122.182.251.219])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CE8D520899;
 Fri,  3 Jul 2020 12:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593780560;
 bh=+/21p5rQ6k7dd6nmGPMmmCDHBK6ejZw314j+mhRM2/A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z0x5onKcdtJbw5KpysufxQzolTSYRNWscUBkmrJIyVgHOUpN4EpEYuX8M/6MlvrEB
 pLC3Brtgq8rq8cNtRHsAW6nCIbTIxSoeeAEKEWkuMh8GhEggrx4G7bcxJgzjNMxq7D
 aLKqoFJhW8+9+7Yxoqi6EMs7/8vbQn0K+zONJh2Q=
Date: Fri, 3 Jul 2020 18:19:12 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Will Deacon <will@kernel.org>, John Stultz <john.stultz@linaro.org>
Subject: Re: [RFC][PATCH 5/5] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
Message-ID: <20200703124912.GM273932@vkoul-mobl>
References: <20200616061338.109499-1-john.stultz@linaro.org>
 <20200616061338.109499-6-john.stultz@linaro.org>
 <0be86735238a0f8b0c25934e2ed39eee@kernel.org>
 <CALAqxLUZBdiLBRcp1GW9rGxt1KhgNVQ86MuPXZcXdx2wFLZk6w@mail.gmail.com>
 <20200703122343.GB18652@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200703122343.GB18652@willie-the-truck>
Cc: Jason Cooper <jason@lakedaemon.net>, Saravana Kannan <saravanak@google.com>,
 Marc Zyngier <maz@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-gpio@vger.kernel.org, iommu@lists.linux-foundation.org,
 Andy Gross <agross@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, Todd Kjos <tkjos@google.com>
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

On 03-07-20, 13:23, Will Deacon wrote:
> On Tue, Jun 16, 2020 at 01:52:32PM -0700, John Stultz wrote:
> > On Tue, Jun 16, 2020 at 12:55 AM Marc Zyngier <maz@kernel.org> wrote:
> > > On 2020-06-16 07:13, John Stultz wrote:
> > > > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > > > index b510f67dfa49..714893535dd2 100644
> > > > --- a/drivers/iommu/Kconfig
> > > > +++ b/drivers/iommu/Kconfig
> > > > @@ -381,6 +381,7 @@ config SPAPR_TCE_IOMMU
> > > >  config ARM_SMMU
> > > >       tristate "ARM Ltd. System MMU (SMMU) Support"
> > > >       depends on (ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)) &&
> > > > MMU
> > > > +     depends on QCOM_SCM || !QCOM_SCM #if QCOM_SCM=m this can't be =y
> > >
> > > This looks a bit ugly. Could you explain why we need this at the SMMU
> > > level? I'd have expected the dependency to flow the other way around...
> > 
> > Yea, so the arm-smmu-qcom.c file calls directly into the qcom-scm code
> > via qcom_scm_qsmmu500_wait_safe_toggle()
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/arm-smmu-qcom.c?h=v5.8-rc1#n44
> > 
> > So if ARM_SMMU=y and QCOM_SCM=m we get:
> > drivers/iommu/arm-smmu-qcom.o: In function `qcom_smmu500_reset':
> > arm-smmu-qcom.c:(.text+0xb4): undefined reference to
> > `qcom_scm_qsmmu500_wait_safe_toggle'
> > 
> > Do you have a suggestion for an alternative approach?
> 
> Can you use symbol_get() or something like that? How are module dependencies
> handled by other drivers?

So drivers deal with this by making rules in Kconfig which will prohibit
this case. QCOM_SCM depends on ARM_SMMU with the caveat that if ARM_SMMU
is a module, QCOM_SCM cant be inbuilt.

This can be done by adding below line in Kconfig for QCOM_SCM:

        depends on ARM_SMMU || !ARM_SMMU

This is quite prevalent is drivers to ensure dependency like this

Thanks
-- 
~Vinod
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
