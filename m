Return-Path: <SRS0=HkIk=5M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F88AC43331
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 10:16:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70FD620705
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 10:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FD620705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4A14087550;
	Fri, 27 Mar 2020 10:16:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iOsuHvSw8U-W; Fri, 27 Mar 2020 10:16:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CC9C287534;
	Fri, 27 Mar 2020 10:16:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3DECC18DA;
	Fri, 27 Mar 2020 10:16:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C58DAC0177
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 10:16:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AFAC2886E3
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 10:16:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tx0b6BpmMcaH for <iommu@lists.linux-foundation.org>;
 Fri, 27 Mar 2020 10:16:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 27ED0886D8
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 10:16:09 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 8F9B42C8; Fri, 27 Mar 2020 11:16:06 +0100 (CET)
Date: Fri, 27 Mar 2020 11:16:05 +0100
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org
Subject: Re: [PATCH v4 00/16] iommu: Move iommu_fwspec out of 'struct device'
Message-ID: <20200327101605.GB3103@8bytes.org>
References: <20200326150841.10083-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200326150841.10083-1-joro@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, guohanjun@huawei.com,
 linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org,
 Andy Gross <agross@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Sean Paul <sean@poorly.run>,
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

On Thu, Mar 26, 2020 at 04:08:25PM +0100, Joerg Roedel wrote:
> Joerg Roedel (15):
>   iommu: Define dev_iommu_fwspec_get() for !CONFIG_IOMMU_API
>   ACPI/IORT: Remove direct access of dev->iommu_fwspec
>   drm/msm/mdp5: Remove direct access of dev->iommu_fwspec
>   iommu/tegra-gart: Remove direct access of dev->iommu_fwspec
>   iommu: Rename struct iommu_param to dev_iommu
>   iommu: Move iommu_fwspec to struct dev_iommu
>   iommu/arm-smmu: Fix uninitilized variable warning
>   iommu: Introduce accessors for iommu private data
>   iommu/arm-smmu-v3: Use accessor functions for iommu private data
>   iommu/arm-smmu: Use accessor functions for iommu private data
>   iommu/renesas: Use accessor functions for iommu private data
>   iommu/mediatek: Use accessor functions for iommu private data
>   iommu/qcom: Use accessor functions for iommu private data
>   iommu/virtio: Use accessor functions for iommu private data
>   iommu: Move fwspec->iommu_priv to struct dev_iommu

Applied.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
