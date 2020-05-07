Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DC4C38A2A
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 10:31:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C00820CC7
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 10:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zrL54q9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C00820CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 27EB984F0F;
	Thu,  7 May 2020 10:31:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ahQ2VsyG-xPF; Thu,  7 May 2020 10:31:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 986BC81B42;
	Thu,  7 May 2020 10:31:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72163C0859;
	Thu,  7 May 2020 10:31:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC47BC07FF
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 10:31:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D0A5E8846A
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 10:31:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eu0ZnmqwlZfC for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 10:31:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3921B8845F
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 10:31:36 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3EE15207DD;
 Thu,  7 May 2020 10:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588847495;
 bh=RTSm4kdRgeWc+RyZlG1E78GC90cFNav4NdQnUzi52rQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zrL54q9y/iG40sCchowlpbj1cSUFUrH4BmLWyfzvLXO5aO9nI4q/SkI51IEcOqNP3
 REymdcG4+Skc3w+VdctU0Dns+1uaZrLY+de4e0oZemLRLd6awdttfqf2n8kml7QTan
 ELNMyjNlcCI1CWldZ/TGq3q7px8vHbuEk/VTjnJA=
Date: Thu, 7 May 2020 11:31:29 +0100
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv4 0/6] iommu/arm-smmu: Allow client devices to select
 identity mapping
Message-ID: <20200507103129.GA29541@willie-the-truck>
References: <cover.1587407458.git.saiprakash.ranjan@codeaurora.org>
 <aa54fd00a6d353c72664e41b7a4a4e3d@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aa54fd00a6d353c72664e41b7a4a4e3d@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jroedel@suse.de, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Matthias Kaehlcke <mka@chromium.org>, Evan Green <evgreen@chromium.org>,
 Sibi Sankar <sibis@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Stephen Boyd <swboyd@chromium.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-msm-owner@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On Thu, May 07, 2020 at 03:58:06PM +0530, Sai Prakash Ranjan wrote:
> Hi Will, Joerg
> 
> On 2020-04-21 00:03, Sai Prakash Ranjan wrote:
> > This series allows DRM, Modem devices to set a default
> > identity mapping in qcom smmu implementation.
> > 
> > Patch 1 is cleanup to support other SoCs to call into
> > QCOM specific  implementation.
> > Patch 2 sets the default identity domain for DRM devices.
> > Patch 3 implements def_domain_type callback for arm-smmu.
> > Patch 4 sets the default identity domain for modem device.
> > Patch 5-6 adds the iommus property for mss pil.
> > 
> > This is based on Joerg's tree:
> >  -
> > https://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git/log/?h=iommu-probe-device-v2
> > 
> > v4:
> >  * Updated commit msg for mss pil requesting direct mapping
> > 
> > v3:
> >  * Use arm_smmu_master_cfg to get impl instead of long way as per Robin.
> >  * Use def_domain_type name for the callback in arm_smmu_imp as per
> > Robin
> > 
> > Jordan Crouse (1):
> >   iommu/arm-smmu: Allow client devices to select direct mapping
> > 
> > Sai Prakash Ranjan (2):
> >   iommu: arm-smmu-impl: Convert to a generic reset implementation
> >   iommu/arm-smmu: Implement iommu_ops->def_domain_type call-back
> > 
> > Sibi Sankar (3):
> >   iommu/arm-smmu-qcom: Request direct mapping for modem device
> >   dt-bindings: remoteproc: qcom: Add iommus property
> >   arm64: dts: qcom: sdm845-cheza: Add iommus property
> > 
> >  .../bindings/remoteproc/qcom,q6v5.txt         |  3 ++
> >  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    |  5 +++
> >  drivers/iommu/arm-smmu-impl.c                 |  8 ++--
> >  drivers/iommu/arm-smmu-qcom.c                 | 37 +++++++++++++++++--
> >  drivers/iommu/arm-smmu.c                      | 12 ++++++
> >  drivers/iommu/arm-smmu.h                      |  1 +
> >  6 files changed, 60 insertions(+), 6 deletions(-)
> 
> This series is reviewed by Robin.
> Any chance this series can make it to 5.8?

I'm planning to queue smmu stuff next week, been busy with arm64 stuff
so far, sorry.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
