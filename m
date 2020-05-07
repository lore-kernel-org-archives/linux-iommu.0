Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6D7C38A2A
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 10:28:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB8132075E
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 10:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="jfea2WQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8132075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8370787100;
	Thu,  7 May 2020 10:28:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gq-2ieF9B69z; Thu,  7 May 2020 10:28:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CECFF89350;
	Thu,  7 May 2020 10:28:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF657C0859;
	Thu,  7 May 2020 10:28:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EC99C07FF
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 10:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 21FE726016
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 10:28:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r0QTODGvzLw7 for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 10:28:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by silver.osuosl.org (Postfix) with ESMTPS id 64FE220421
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 10:28:13 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1588847295; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=505A69X26wFMczjQPH01/FWDBb9GRlXXRfy7TtInLmg=;
 b=jfea2WQeGE3vAcxiLtRRQM9CtwMBF+PbswlaTV/NeGU2njXiGSVLu6jmMMKBHbTooInJ3/0k
 Y9gviSyOl9BXx5BKcRigIjw13qCYTjNWxXLuv5Xhe0H9xdNyK12IPQMbHdZM0zs8630xpSuN
 icfaWIKcf70CNci5lHEkGNgir4A=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb3e2b8.7f79b72fe7a0-smtp-out-n03;
 Thu, 07 May 2020 10:28:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id C2027C4478F; Thu,  7 May 2020 10:28:07 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id E36D5C433F2;
 Thu,  7 May 2020 10:28:06 +0000 (UTC)
MIME-Version: 1.0
Date: Thu, 07 May 2020 15:58:06 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Sibi Sankar <sibis@codeaurora.org>, Bjorn
 Andersson <bjorn.andersson@linaro.org>, Jordan Crouse
 <jcrouse@codeaurora.org>, Rob Clark <robdclark@gmail.com>, jroedel@suse.de
Subject: Re: [PATCHv4 0/6] iommu/arm-smmu: Allow client devices to select
 identity mapping
In-Reply-To: <cover.1587407458.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1587407458.git.saiprakash.ranjan@codeaurora.org>
Message-ID: <aa54fd00a6d353c72664e41b7a4a4e3d@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Stephen Boyd <swboyd@chromium.org>,
 iommu@lists.linux-foundation.org, Matthias Kaehlcke <mka@chromium.org>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Will, Joerg

On 2020-04-21 00:03, Sai Prakash Ranjan wrote:
> This series allows DRM, Modem devices to set a default
> identity mapping in qcom smmu implementation.
> 
> Patch 1 is cleanup to support other SoCs to call into
> QCOM specific  implementation.
> Patch 2 sets the default identity domain for DRM devices.
> Patch 3 implements def_domain_type callback for arm-smmu.
> Patch 4 sets the default identity domain for modem device.
> Patch 5-6 adds the iommus property for mss pil.
> 
> This is based on Joerg's tree:
>  -
> https://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git/log/?h=iommu-probe-device-v2
> 
> v4:
>  * Updated commit msg for mss pil requesting direct mapping
> 
> v3:
>  * Use arm_smmu_master_cfg to get impl instead of long way as per 
> Robin.
>  * Use def_domain_type name for the callback in arm_smmu_imp as per 
> Robin
> 
> Jordan Crouse (1):
>   iommu/arm-smmu: Allow client devices to select direct mapping
> 
> Sai Prakash Ranjan (2):
>   iommu: arm-smmu-impl: Convert to a generic reset implementation
>   iommu/arm-smmu: Implement iommu_ops->def_domain_type call-back
> 
> Sibi Sankar (3):
>   iommu/arm-smmu-qcom: Request direct mapping for modem device
>   dt-bindings: remoteproc: qcom: Add iommus property
>   arm64: dts: qcom: sdm845-cheza: Add iommus property
> 
>  .../bindings/remoteproc/qcom,q6v5.txt         |  3 ++
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    |  5 +++
>  drivers/iommu/arm-smmu-impl.c                 |  8 ++--
>  drivers/iommu/arm-smmu-qcom.c                 | 37 +++++++++++++++++--
>  drivers/iommu/arm-smmu.c                      | 12 ++++++
>  drivers/iommu/arm-smmu.h                      |  1 +
>  6 files changed, 60 insertions(+), 6 deletions(-)

This series is reviewed by Robin.
Any chance this series can make it to 5.8?

Thanks,
Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
