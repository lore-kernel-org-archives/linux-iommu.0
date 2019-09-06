Return-Path: <SRS0=rqG6=XB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB77EC43331
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 06:32:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F7612081B
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 06:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J1FNAPpw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L2k1UUSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7612081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 396451CEC;
	Fri,  6 Sep 2019 06:32:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EE03C1C4E
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 06:32:24 +0000 (UTC)
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 613F9623
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 06:32:24 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1BB116118E; Fri,  6 Sep 2019 06:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1567751544;
	bh=5IXWL13z0uCkCyyzyvjNDyApKQDm84iOFMXdY5wj5TU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J1FNAPpwWiwIuRFAOOaK+pKm7+gBb9GpefDZM2EZwXh8pGpde5fNUyLZIuASW906r
	XbeIM2eOf+bAoFyIf7Mx5pkTQb5welcJXozRCdOqQ2qsnQVxJSR9Ud5D5N8o8b7SoM
	lLtfGp2w3oCB8a5DLLJQPDf6YFEElXtDEvHnL9+M=
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
	[209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: vivek.gautam@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D3DF602DC
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 06:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1567751542;
	bh=5IXWL13z0uCkCyyzyvjNDyApKQDm84iOFMXdY5wj5TU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L2k1UUSvzUgdwxzCeYWIA79dtybw/Z80BH7HpaRR6mcnwq3o8C03rZSAq2KJc9h11
	RQ3XzgKGRRDRdNi3m3v1pzmvm7kYCib0K575C+Ubw7V/0Wv3y2C7nvzTHty1hdcAK5
	rJVEuJkcrQ1JF30bqgoWmauTLJwXAZZtPMVx1cQo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D3DF602DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f46.google.com with SMTP id i8so5202335edn.13
	for <iommu@lists.linux-foundation.org>;
	Thu, 05 Sep 2019 23:32:22 -0700 (PDT)
X-Gm-Message-State: APjAAAVb3qphCRDcc6X22OSrB+WYnW0NviVTcnmIIOxcCPOV7fOtCJ6d
	AGh23cZd9+U6kDeQgxcHax6X+ehuSKuuJ1FJfJ4=
X-Google-Smtp-Source: APXvYqwU+hPH/XbLx216IUjOvcURat+MDJLla19fyLxpNuL7iBDeofqIDCk3Hji3Toa0pQw92b5brzKXTj7t9HHhEbY=
X-Received: by 2002:a50:ce53:: with SMTP id k19mr7907098edj.2.1567751541265;
	Thu, 05 Sep 2019 23:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190823063248.13295-1-vivek.gautam@codeaurora.org>
	<20190823063248.13295-4-vivek.gautam@codeaurora.org>
In-Reply-To: <20190823063248.13295-4-vivek.gautam@codeaurora.org>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Fri, 6 Sep 2019 12:02:10 +0530
X-Gmail-Original-Message-ID: <CAFp+6iE05p-UM=pJ-JwbmTb98sAN5B9c980Qv6ZBX89T8Jeofw@mail.gmail.com>
Message-ID: <CAFp+6iE05p-UM=pJ-JwbmTb98sAN5B9c980Qv6ZBX89T8Jeofw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] iommu: arm-smmu-impl: Add sdm845 implementation
	hook
To: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <joro@8bytes.org>,
	Andy Gross <agross@kernel.org>, 
	Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, 
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Aug 23, 2019 at 12:03 PM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> Add reset hook for sdm845 based platforms to turn off
> the wait-for-safe sequence.
>
> Understanding how wait-for-safe logic affects USB and UFS performance
> on MTP845 and DB845 boards:
>
> Qcom's implementation of arm,mmu-500 adds a WAIT-FOR-SAFE logic
> to address under-performance issues in real-time clients, such as
> Display, and Camera.
> On receiving an invalidation requests, the SMMU forwards SAFE request
> to these clients and waits for SAFE ack signal from real-time clients.
> The SAFE signal from such clients is used to qualify the start of
> invalidation.
> This logic is controlled by chicken bits, one for each - MDP (display),
> IFE0, and IFE1 (camera), that can be accessed only from secure software
> on sdm845.
>
> This configuration, however, degrades the performance of non-real time
> clients, such as USB, and UFS etc. This happens because, with wait-for-safe
> logic enabled the hardware tries to throttle non-real time clients while
> waiting for SAFE ack signals from real-time clients.
>
> On mtp845 and db845 devices, with wait-for-safe logic enabled by the
> bootloaders we see degraded performance of USB and UFS when kernel
> enables the smmu stage-1 translations for these clients.
> Turn off this wait-for-safe logic from the kernel gets us back the perf
> of USB and UFS devices until we re-visit this when we start seeing perf
> issues on display/camera on upstream supported SDM845 platforms.
> The bootloaders on these boards implement secure monitor callbacks to
> handle a specific command - QCOM_SCM_SVC_SMMU_PROGRAM with which the
> logic can be toggled.
>
> There are other boards such as cheza whose bootloaders don't enable this
> logic. Such boards don't implement callbacks to handle the specific SCM
> call so disabling this logic for such boards will be a no-op.
>
> This change is inspired by the downstream change from Patrick Daly
> to address performance issues with display and camera by handling
> this wait-for-safe within separte io-pagetable ops to do TLB
> maintenance. So a big thanks to him for the change and for all the
> offline discussions.
>
> Without this change the UFS reads are pretty slow:
> $ time dd if=/dev/sda of=/dev/zero bs=1048576 count=10 conv=sync
> 10+0 records in
> 10+0 records out
> 10485760 bytes (10.0MB) copied, 22.394903 seconds, 457.2KB/s
> real    0m 22.39s
> user    0m 0.00s
> sys     0m 0.01s
>
> With this change they are back to rock!
> $ time dd if=/dev/sda of=/dev/zero bs=1048576 count=300 conv=sync
> 300+0 records in
> 300+0 records out
> 314572800 bytes (300.0MB) copied, 1.030541 seconds, 291.1MB/s
> real    0m 1.03s
> user    0m 0.00s
> sys     0m 0.54s
>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu-impl.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
> index 3f88cd078dd5..0aef87c41f9c 100644
> --- a/drivers/iommu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm-smmu-impl.c
> @@ -6,6 +6,7 @@
>
>  #include <linux/bitfield.h>
>  #include <linux/of.h>
> +#include <linux/qcom_scm.h>
>
>  #include "arm-smmu.h"
>
> @@ -102,7 +103,6 @@ static struct arm_smmu_device *cavium_smmu_impl_init(struct arm_smmu_device *smm
>         return &cs->smmu;
>  }
>
> -
>  #define ARM_MMU500_ACTLR_CPRE          (1 << 1)
>
>  #define ARM_MMU500_ACR_CACHE_LOCK      (1 << 26)
> @@ -147,6 +147,28 @@ static const struct arm_smmu_impl arm_mmu500_impl = {
>         .reset = arm_mmu500_reset,
>  };
>
> +static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
> +{
> +       int ret;
> +
> +       arm_mmu500_reset(smmu);
> +
> +       /*
> +        * To address performance degradation in non-real time clients,
> +        * such as USB and UFS, turn off wait-for-safe on sdm845 based boards,
> +        * such as MTP and db845, whose firmwares implement secure monitor
> +        * call handlers to turn on/off the wait-for-safe logic.
> +        */
> +       ret = qcom_scm_qsmmu500_wait_safe_toggle(0);
> +       if (ret)
> +               dev_warn(smmu->dev, "Failed to turn off SAFE logic\n");
> +
> +       return 0;
> +}
> +
> +const struct arm_smmu_impl qcom_sdm845_smmu500_impl = {
> +       .reset = qcom_sdm845_smmu500_reset,
> +};
>
>  struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>  {
> @@ -170,5 +192,8 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>                                   "calxeda,smmu-secure-config-access"))
>                 smmu->impl = &calxeda_impl;
>
> +       if (of_device_is_compatible(smmu->dev->of_node, "qcom,sdm845-smmu-500"))
> +               smmu->impl = &qcom_sdm845_smmu500_impl;
> +
>         return smmu;
>  }

Hi Robin,

How does this change look now? Let me know if there are any concerns.
I will be happy to incorporate them.

Thanks & Regards
Vivek
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
