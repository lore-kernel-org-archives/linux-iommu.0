Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FC3C31E44
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 04:04:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7BB20851
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 04:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dRK6J7+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7BB20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A03F7CDE;
	Fri, 14 Jun 2019 04:04:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 437B3A55
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 04:04:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
	[209.85.214.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9BAF7E5
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 04:04:36 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id t7so411918plr.11
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 21:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=082jHmlkjhAh9IaesAziT6qv866KrYluo7FPcaARnBI=;
	b=dRK6J7+JL1mDleO5i0AEvED6xGKT1Z2ZzWolFQimSWfA9AxSgg1Jsvw8+Vc+nL1lI1
	3G+qaiMYOXPJQsfdCnQynGy6ffboDMbkJCjy8uhc6tkJMPHn7Wq0tw9pje6BAQbtONlV
	GAXWF5LELTA75E3tsSNJfB9FOfMuVigafVaD6oG6Nm7yk2yH/BEabvEpa35UCE4cWowQ
	H4MMDI2ZiGoVG+3/0vhZuiCygLm1gTeTBcQQsdfjeOewVsc+Nvc6onajggsmDqe9IEYT
	/fbItZ5GsntxotXFAQzEfu/q5+XPm41g5qSpOwMBKAi7TggWRj+UoY07LvpxN8WQw3C1
	NBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=082jHmlkjhAh9IaesAziT6qv866KrYluo7FPcaARnBI=;
	b=UOImGXqT/QHeqS4L1NTvWVTE0/Rf6pA4UckomNmo12rPeuh83IVIk0n97ZD7qMGoSE
	V2Uu+ZcWZTxf5XzPSz6lfrzh9N1kU3kLKqHzwTF/uf4pCGt/dlZk+qi7NscQx1XCXk+R
	ffAYXziqAZHON9ckYc+WHxm79qvu+2g3EdXV/0wDk32aSspgq5t0HaBnayHO8ayM474e
	/qdvoMwL53/waJ/X/6rUh3MOW87y0z3ho/LTRE+f1HfKUB0LRG4cYuCRxswpRSuseDjX
	Qf5s3arykg5sSaLRjSFTG5iXtgPVJojSEQFo/T/NRc26pN2TB3OSciqf/4PaYMIXkeVw
	+dsA==
X-Gm-Message-State: APjAAAVo7aHvxtyz2eLNz608QTr83qkYHEqvSQUDXs2vPJFligtWErtx
	6zbZoPELXtoJaJUO6NMGGXKaFw==
X-Google-Smtp-Source: APXvYqwGsFpWofl9vL6LfAjmRMNFnjycFiWNIAapWNnWiOW+6oPOAJjd+EKpPBPWOXACVFe7ktebvQ==
X-Received: by 2002:a17:902:76c6:: with SMTP id
	j6mr66236784plt.263.1560485075890; 
	Thu, 13 Jun 2019 21:04:35 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
	[104.188.17.28]) by smtp.gmail.com with ESMTPSA id
	k11sm1111403pfi.168.2019.06.13.21.04.33
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 13 Jun 2019 21:04:34 -0700 (PDT)
Date: Thu, 13 Jun 2019 21:05:20 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH v3 3/4] iommu/arm-smmu: Add support to handle Qcom's
	wait-for-safe logic
Message-ID: <20190614040520.GK22737@tuxbook-pro>
References: <20190612071554.13573-1-vivek.gautam@codeaurora.org>
	<20190612071554.13573-4-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190612071554.13573-4-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	will.deacon@arm.com, linux-kernel@vger.kernel.org,
	robh+dt@kernel.org, david.brown@linaro.org,
	iommu@lists.linux-foundation.org, agross@kernel.org, robin.murphy@arm.com
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

On Wed 12 Jun 00:15 PDT 2019, Vivek Gautam wrote:

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
> On MTP sdm845 devices, with wait-for-safe logic enabled at the boot time
> by the bootloaders we see degraded performance of USB and UFS when kernel
> enables the smmu stage-1 translations for these clients.
> Turn off this wait-for-safe logic from the kernel gets us back the perf
> of USB and UFS devices until we re-visit this when we start seeing perf
> issues on display/camera on upstream supported SDM845 platforms.
> 
> Now, different bootloaders with their access control policies allow this
> register access differently through secure monitor calls -
> 1) With one we can issue io-read/write secure monitor call (qcom-scm)
>    to update the register, while,
> 2) With other, such as one on MTP sdm845 we should use the specific
>    qcom-scm command to send request to do the complete register
>    configuration.
> Adding a separate device tree flag for arm-smmu to identify which
> firmware configuration of the two mentioned above we use.
> Not adding code change to allow type-(1) bootloaders to toggle the
> safe using io-read/write qcom-scm call.
> 
> This change is inspired by the downstream change from Patrick Daly
> to address performance issues with display and camera by handling
> this wait-for-safe within separte io-pagetable ops to do TLB
> maintenance. So a big thanks to him for the change.
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
>  drivers/iommu/arm-smmu.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 0ad086da399c..3c3ad43eda97 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -39,6 +39,7 @@
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/qcom_scm.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  
> @@ -177,6 +178,7 @@ struct arm_smmu_device {
>  	u32				features;
>  
>  #define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
> +#define ARM_SMMU_OPT_QCOM_FW_IMPL_SAFE_ERRATA (1 << 1)
>  	u32				options;
>  	enum arm_smmu_arch_version	version;
>  	enum arm_smmu_implementation	model;
> @@ -262,6 +264,7 @@ static bool using_legacy_binding, using_generic_binding;
>  
>  static struct arm_smmu_option_prop arm_smmu_options[] = {
>  	{ ARM_SMMU_OPT_SECURE_CFG_ACCESS, "calxeda,smmu-secure-config-access" },
> +	{ ARM_SMMU_OPT_QCOM_FW_IMPL_SAFE_ERRATA, "qcom,smmu-500-fw-impl-safe-errata" },

This should be added to the DT binding as well.

>  	{ 0, NULL},
>  };
>  
> @@ -2292,6 +2295,19 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	arm_smmu_device_reset(smmu);
>  	arm_smmu_test_smr_masks(smmu);
>  
> +	/*
> +	 * To address performance degradation in non-real time clients,
> +	 * such as USB and UFS, turn off wait-for-safe on sdm845 platforms,
> +	 * such as MTP, whose firmwares implement corresponding secure monitor
> +	 * call handlers.
> +	 */
> +	if (of_device_is_compatible(smmu->dev->of_node, "qcom,sdm845-smmu-500") &&
> +	    smmu->options & ARM_SMMU_OPT_QCOM_FW_IMPL_SAFE_ERRATA) {
> +		err = qcom_scm_qsmmu500_wait_safe_toggle(0);
> +		if (err)
> +			dev_warn(dev, "Failed to turn off SAFE logic\n");
> +	}
> +

This looks good, I presume at some point we can profile things and
review if it's worth toggling this on the fly, but given that this is
conditioned on smmu->options that should be an implementation detail..

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

>  	/*
>  	 * We want to avoid touching dev->power.lock in fastpaths unless
>  	 * it's really going to do something useful - pm_runtime_enabled()
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
