Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53B9C4724C
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 12:54:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A44132070B
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 12:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQWnluLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44132070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7AAE9873A3;
	Thu,  7 May 2020 12:54:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yJD0Pa19h6ei; Thu,  7 May 2020 12:54:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8DC02870A7;
	Thu,  7 May 2020 12:54:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7391EC0859;
	Thu,  7 May 2020 12:54:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0FC7C0859
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 12:54:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DF09986BB9
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 12:54:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LZatfCG-Z3K3 for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 12:54:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 676628689B
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 12:54:03 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AEE472082E;
 Thu,  7 May 2020 12:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588856043;
 bh=ejai9cTPU/wXSWdxchfGt1itA5yy8fQdOCXV1pCVHB8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RQWnluLJiArcmPu9fOV36aetvJ89LlV4OkXKlOag7m8wEFYv8k8CmgXArbDzu6Wsq
 pswbvEeTfFU5iF88PS7C3PtcspXniovK40FRu2E7ppNmm6cyjd3Iso9XksHltSy6+K
 p+BGlBgqY06MAoY6CKRIfJ85jBPtzde5OXgykwOI=
Date: Thu, 7 May 2020 13:53:58 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iomm/arm-smmu: Add stall implementation hook
Message-ID: <20200507125357.GA31783@willie-the-truck>
References: <20200421202004.11686-1-saiprakash.ranjan@codeaurora.org>
 <b491e02ad790a437115fdeab6b21bc48@codeaurora.org>
 <1ced023b-157c-21a0-ac75-1adef7f029f0@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1ced023b-157c-21a0-ac75-1adef7f029f0@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, May 07, 2020 at 11:55:54AM +0100, Robin Murphy wrote:
> On 2020-05-07 11:14 am, Sai Prakash Ranjan wrote:
> > On 2020-04-22 01:50, Sai Prakash Ranjan wrote:
> > > Add stall implementation hook to enable stalling
> > > faults on QCOM platforms which supports it without
> > > causing any kind of hardware mishaps. Without this
> > > on QCOM platforms, GPU faults can cause unrelated
> > > GPU memory accesses to return zeroes. This has the
> > > unfortunate result of command-stream reads from CP
> > > getting invalid data, causing a cascade of fail.
> =

> I think this came up before, but something about this rationale doesn't a=
dd
> up - we're not *using* stalls at all, we're still terminating faulting
> transactions unconditionally; we're just using CFCFG to terminate them wi=
th
> a slight delay, rather than immediately. It's really not clear how or why
> that makes a difference. Is it a GPU bug? Or an SMMU bug? Is this reliable
> (or even a documented workaround for something), or might things start
> blowing up again if any other behaviour subtly changes? I'm not dead set
> against adding this, but I'd *really* like to have a lot more confidence =
in
> it.

Rob mentioned something about the "bus returning zeroes" before, but I agree
that we need more information so that we can reason about this and maintain
the code as the driver continues to change. That needs to be a comment in
the driver, and I don't think "but android seems to work" is a good enough
justification. There was some interaction with HUPCF as well.

As a template, I'd suggest:

> > > diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> > > index 8d1cd54d82a6..d5134e0d5cce 100644
> > > --- a/drivers/iommu/arm-smmu.h
> > > +++ b/drivers/iommu/arm-smmu.h
> > > @@ -386,6 +386,7 @@ struct arm_smmu_impl {
> > > =A0=A0=A0=A0 int (*init_context)(struct arm_smmu_domain *smmu_domain);
> > > =A0=A0=A0=A0 void (*tlb_sync)(struct arm_smmu_device *smmu, int page,=
 int sync,
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int status);

/*
 * Stall transactions on a context fault, where they will be terminated
 * in response to the resulting IRQ rather than immediately. This should
 * pretty much always be set to "false" as stalling can introduce the
 * potential for deadlock in most SoCs, however it is needed on Qualcomm
 * XXXX because YYYY.
 */

> > > +=A0=A0=A0 bool stall;

Hmm, the more I think about this, the more I think this is an erratum
workaround in disguise, in which case this could be better named...

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
