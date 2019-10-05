Return-Path: <SRS0=kiHz=X6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DBFC47404
	for <iommu@archiver.kernel.org>; Sat,  5 Oct 2019 05:03:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EC7C222C7
	for <iommu@archiver.kernel.org>; Sat,  5 Oct 2019 05:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FL3Zwdse"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC7C222C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 30427A7A;
	Sat,  5 Oct 2019 05:03:14 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A977E40B
	for <iommu@lists.linux-foundation.org>;
	Sat,  5 Oct 2019 05:03:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
	[209.85.210.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7BDAFD3
	for <iommu@lists.linux-foundation.org>;
	Sat,  5 Oct 2019 05:03:12 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id y72so5098967pfb.12
	for <iommu@lists.linux-foundation.org>;
	Fri, 04 Oct 2019 22:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=5mOmufgrQN1rMhu5F69YwBqIp2cym8oND1sseJBaP6I=;
	b=FL3Zwdsefzn0O38UddZ5LFJOf8D/gvG49aVGx0X2+6R/UbUrFfgl9MQQLUL0efRw2+
	YoJmh8OB9frp1/yZ/hphQzTvsvMv35uIXnhK8e5mkHY+c/FiFr9psd5FB5nbsiC4szbK
	8ESmmvdcudPNIUBgRit7AxOeugy2FWN3AmEgrVA2caVnp0fYlFr7+24LKay6XbV1JVxA
	hPKa6s9y1Wk2eDIVAscqJ00IMJMn+PN1BN6pi0fmRlk0Bnlr0TIBGCiF8IYIBU7pkyGr
	Ue6PLfEUhSRZdI4MIkVrltFohx9gyWwpF39WVHMsgQJ2RLsYWnFdHwVGBMGZZxXlPi0Q
	LeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=5mOmufgrQN1rMhu5F69YwBqIp2cym8oND1sseJBaP6I=;
	b=EpRI4KltlkuRPv7tAEAf7sgENJks4WYtwFKZytAhQPsx+d0d39yl0edaGYqGQB9Wyp
	0laJfvY7kaBYNXElISqaqTcfNlFufF/Sr8MItLJWMVdJlfxvmEBM0ORdISfXPBre+8zH
	BOPFJQQOMLOdya/UdZHH+66ajYEaFe+YAXubKr64384BD4q3llcdpfh9YbHumxaAnxLX
	HALfBckcVJbYD1UamhsBp52YTD1maWTAbgQY6qvRSyDN+AL3qSw3qWCWplSiZgGPIw+h
	3GBvCJmCGJEoEZ43cZeALnJPhIkRfcUs/DMtVz3zRneK6WrjoGE46QliQGHMVxbOvAed
	6FVA==
X-Gm-Message-State: APjAAAU9VduyW3/0zZu5mgnYPEWlSts92dBU4BDDF+vmr+IJ2lkORRSf
	/Jt/OaaPNl+LMKJ0CTdXnCaW+w==
X-Google-Smtp-Source: APXvYqyi5uG8TZbJF1LNo04wER1bRKiD/ShWLANGjRAO1qPp/v3//uX4jbpbmNjw2n54JQbt5cK5HA==
X-Received: by 2002:a17:90a:c501:: with SMTP id
	k1mr20977446pjt.37.1570251791789; 
	Fri, 04 Oct 2019 22:03:11 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
	[104.188.17.28])
	by smtp.gmail.com with ESMTPSA id k9sm8426399pfk.72.2019.10.04.22.03.10
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 04 Oct 2019 22:03:11 -0700 (PDT)
Date: Fri, 4 Oct 2019 22:03:08 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv7 3/3] iommu: arm-smmu-impl: Add sdm845 implementation hook
Message-ID: <20191005050308.GG6390@tuxbook-pro>
References: <cover.1568966170.git.saiprakash.ranjan@codeaurora.org>
	<3ed0de38b57fda1995d0f231cbcec38c16387a2a.1568966170.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3ed0de38b57fda1995d0f231cbcec38c16387a2a.1568966170.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
	iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
	Vivek Gautam <vivek.gautam@codeaurora.org>,
	linux-arm-msm@vger.kernel.org, Will Deacon <will@kernel.org>
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

On Fri 20 Sep 01:04 PDT 2019, Sai Prakash Ranjan wrote:

> From: Vivek Gautam <vivek.gautam@codeaurora.org>
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
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/iommu/Makefile        |  2 +-
>  drivers/iommu/arm-smmu-impl.c |  5 +++-
>  drivers/iommu/arm-smmu-qcom.c | 51 +++++++++++++++++++++++++++++++++++
>  drivers/iommu/arm-smmu.h      |  3 +++
>  4 files changed, 59 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/iommu/arm-smmu-qcom.c
> 
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 4f405f926e73..86dadd13b2e6 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -13,7 +13,7 @@ obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
>  obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o amd_iommu_quirks.o
>  obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd_iommu_debugfs.o
>  obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
> -obj-$(CONFIG_ARM_SMMU) += arm-smmu.o arm-smmu-impl.o
> +obj-$(CONFIG_ARM_SMMU) += arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o
>  obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
>  obj-$(CONFIG_DMAR_TABLE) += dmar.o
>  obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o intel-pasid.o
> diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
> index 5c87a38620c4..b2fe72a8f019 100644
> --- a/drivers/iommu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm-smmu-impl.c
> @@ -109,7 +109,7 @@ static struct arm_smmu_device *cavium_smmu_impl_init(struct arm_smmu_device *smm
>  #define ARM_MMU500_ACR_S2CRB_TLBEN	(1 << 10)
>  #define ARM_MMU500_ACR_SMTNMB_TLBEN	(1 << 8)
>  
> -static int arm_mmu500_reset(struct arm_smmu_device *smmu)
> +int arm_mmu500_reset(struct arm_smmu_device *smmu)
>  {
>  	u32 reg, major;
>  	int i;
> @@ -170,5 +170,8 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>  				  "calxeda,smmu-secure-config-access"))
>  		smmu->impl = &calxeda_impl;
>  
> +	if (of_device_is_compatible(smmu->dev->of_node, "qcom,sdm845-smmu-500"))
> +		return qcom_smmu_impl_init(smmu);
> +
>  	return smmu;
>  }
> diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
> new file mode 100644
> index 000000000000..24c071c1d8b0
> --- /dev/null
> +++ b/drivers/iommu/arm-smmu-qcom.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/qcom_scm.h>
> +
> +#include "arm-smmu.h"
> +
> +struct qcom_smmu {
> +	struct arm_smmu_device smmu;
> +};
> +
> +static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
> +{
> +	int ret;
> +
> +	arm_mmu500_reset(smmu);
> +
> +	/*
> +	 * To address performance degradation in non-real time clients,
> +	 * such as USB and UFS, turn off wait-for-safe on sdm845 based boards,
> +	 * such as MTP and db845, whose firmwares implement secure monitor
> +	 * call handlers to turn on/off the wait-for-safe logic.
> +	 */
> +	ret = qcom_scm_qsmmu500_wait_safe_toggle(0);
> +	if (ret)
> +		dev_warn(smmu->dev, "Failed to turn off SAFE logic\n");
> +
> +	return ret;
> +}
> +
> +static const struct arm_smmu_impl qcom_smmu_impl = {
> +	.reset = qcom_sdm845_smmu500_reset,
> +};
> +
> +struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
> +{
> +	struct qcom_smmu *qsmmu;
> +
> +	qsmmu = devm_kzalloc(smmu->dev, sizeof(*qsmmu), GFP_KERNEL);
> +	if (!qsmmu)
> +		return ERR_PTR(-ENOMEM);
> +
> +	qsmmu->smmu = *smmu;
> +
> +	qsmmu->smmu.impl = &qcom_smmu_impl;
> +	devm_kfree(smmu->dev, smmu);
> +
> +	return &qsmmu->smmu;
> +}
> diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> index b19b6cae9b5e..de99a85e140a 100644
> --- a/drivers/iommu/arm-smmu.h
> +++ b/drivers/iommu/arm-smmu.h
> @@ -398,5 +398,8 @@ static inline void arm_smmu_writeq(struct arm_smmu_device *smmu, int page,
>  	arm_smmu_writeq((s), ARM_SMMU_CB((s), (n)), (o), (v))
>  
>  struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu);
> +struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu);
> +
> +int arm_mmu500_reset(struct arm_smmu_device *smmu);
>  
>  #endif /* _ARM_SMMU_H */
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
