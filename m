Return-Path: <SRS0=oYak=EI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17991C388F2
	for <iommu@archiver.kernel.org>; Mon,  2 Nov 2020 17:08:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 715FD222BA
	for <iommu@archiver.kernel.org>; Mon,  2 Nov 2020 17:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Cscq/N21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715FD222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id F1DCA203A2;
	Mon,  2 Nov 2020 17:08:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vAQbVqLpSkXo; Mon,  2 Nov 2020 17:08:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F005920348;
	Mon,  2 Nov 2020 17:08:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2BB8C0889;
	Mon,  2 Nov 2020 17:08:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F81FC0051
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 17:08:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 82523872ED
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 17:08:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fxIWo5ncTg2I for <iommu@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 17:08:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from z5.mailgun.us (z5.mailgun.us [104.130.96.5])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D9EF7872E5
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 17:08:30 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1604336911; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=SAL9Z21PfWH8XRXmXiAkD5Twef6r/IdjwYPZ2uz0nHA=;
 b=Cscq/N21fwr5IekoJE6fgvUpdrW0QpqJUUEqwJq6GgSmykrtWrdSRvESYONSlttk+YRmLnHm
 wYvZsv0IgH2wO0q0d8txpDbSgPTCocIWkrNwDU8DIou3cbczSylkGNYfDApHzNGoxuDpE8uv
 EerrI5qwa8GPmzICyz2bHfDFjKI=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fa03d0dd8a9d167f3861313 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 02 Nov 2020 17:08:29
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 657C8C433F0; Mon,  2 Nov 2020 17:08:29 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id AF89DC433C8;
 Mon,  2 Nov 2020 17:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF89DC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=jcrouse@codeaurora.org
Date: Mon, 2 Nov 2020 10:08:23 -0700
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v18 0/4] iommu/arm-smmu: Add adreno-smmu implementation
 and bindings
Message-ID: <20201102170823.GA1032@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Will Deacon <will@kernel.org>,
 linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Krishna Reddy <vdumpa@nvidia.com>,
 Rob Clark <robdclark@chromium.org>,
 Rob Herring <robh+dt@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Sibi Sankar <sibis@codeaurora.org>,
 Stephen Boyd <swboyd@chromium.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201027223408.469893-1-jcrouse@codeaurora.org>
 <20201029172607.GA30745@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201029172607.GA30745@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Rob Clark <robdclark@chromium.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Andy Gross <agross@kernel.org>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Boyd <swboyd@chromium.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

On Thu, Oct 29, 2020 at 05:26:08PM +0000, Will Deacon wrote:
> On Tue, Oct 27, 2020 at 04:34:04PM -0600, Jordan Crouse wrote:
> > This short series adds support for the adreno-smmu implementation of the
> > arm-smmu driver and the device-tree bindings to turn on the implementation
> > for the sm845 and sc7180 GPUs. These changes are the last ones needed to enable
> > per-instance pagetables in the drm/msm driver.
> > 
> > No deltas in this patchset since the last go-around for 5.10 [1].
> > 
> > [1] https://patchwork.freedesktop.org/series/81393/
> > 
> > Jordan Crouse (3):
> >   iommu/arm-smmu-qcom: Add implementation for the adreno GPU SMMU
> >   dt-bindings: arm-smmu: Add compatible string for Adreno GPU SMMU
> >   arm: dts: qcom: sm845: Set the compatible string for the GPU SMMU
> > 
> > Rob Clark (1):
> >   iommu/arm-smmu: Add a way for implementations to influence SCTLR
> 
> FYI: this patch (patch 4/4) doesn't seem to have made it anywhere (I don't
> have it, and neither does the archive).
> 
> Will

Patch 4/4 was the bindings for sdm845 and I didn't explicitly add IOMMU to the
CC list and so patman did what patman does.

I'll resend.

Jordan
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
