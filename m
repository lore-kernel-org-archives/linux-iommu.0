Return-Path: <SRS0=rqG6=XB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B922C43140
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 15:12:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B3820842
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 15:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZHOv+RZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B3820842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1A49824A5;
	Fri,  6 Sep 2019 15:12:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 40CEB2356
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 15:12:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
	[209.85.215.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AAEDE756
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 15:12:49 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id d1so3676313pgp.4
	for <iommu@lists.linux-foundation.org>;
	Fri, 06 Sep 2019 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=message-id:mime-version:content-transfer-encoding:in-reply-to
	:references:to:from:cc:subject:user-agent:date;
	bh=Xb6VwDjoplmWmuetAQCvzqk0SmPHJLjBpgM4hHIYCII=;
	b=ZHOv+RZQ3aLmqgmsd5zyET7umQYE10jQO9DyLmBi7gmXaBD/zsKVo+gYs46PZcAdJX
	TM3rMdk2kGkm9oV51CI9U1unCD6cNDTNdjaApnOAqojhXZp71CwST9cw1aBWzIZauQxK
	RpsP1NITVP9z8h6SB0dNNBxLbHKkMZvZr94+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:mime-version
	:content-transfer-encoding:in-reply-to:references:to:from:cc:subject
	:user-agent:date;
	bh=Xb6VwDjoplmWmuetAQCvzqk0SmPHJLjBpgM4hHIYCII=;
	b=cm2MzJIHJ+ap8JHCTGtVzZyljTGFoxBIxzI8ar7NOfHQb5UTRZ8QblIEX21TG79y6K
	e3cMFm9fJZWwCtu0coefeSgMoz2zj7gwRA+NhWi4wUgZG6tjgAowFCs4ZMBu1QddtIEp
	GVSpY+lD9md3bn9jZUJ24lfwWKe8AJbvsXYcjsh7fpXZFL8wmme1B1BC1kX7me8lLf3A
	ehfIVdcEYrLu6IywDFfirJE+cMo64pd4+i4mAETxZbficLLapDUg0na/aGD6c2wHOaXa
	JyvZDCLFyJjfxnhe1svwZdocXx+kvqbkvwz169MziAA7Bj653N6MK1wusk+n9qOWgOLd
	5V/A==
X-Gm-Message-State: APjAAAWf7U+aWbkm11SgpB/Q8y/kFmCqf0U7hCgyctKQTJvif2gnIl7M
	DzhOAVQgUfr2rh+pMQb1VclzKQ==
X-Google-Smtp-Source: APXvYqx5APO82PFexcy027FfVJXJBg/BMStPKFD+PoK1ECUmgX6ZblpH7mM8DpzNko7+Kif7xTbz/Q==
X-Received: by 2002:a63:a302:: with SMTP id s2mr8404939pge.125.1567782768983; 
	Fri, 06 Sep 2019 08:12:48 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
	by smtp.gmail.com with ESMTPSA id u5sm5336849pfl.25.2019.09.06.08.12.48
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 06 Sep 2019 08:12:48 -0700 (PDT)
Message-ID: <5d727770.1c69fb81.c9062.ce60@mx.google.com>
MIME-Version: 1.0
In-Reply-To: <20190823063248.13295-2-vivek.gautam@codeaurora.org>
References: <20190823063248.13295-1-vivek.gautam@codeaurora.org>
	<20190823063248.13295-2-vivek.gautam@codeaurora.org>
To: Vivek Gautam <vivek.gautam@codeaurora.org>, agross@kernel.org,
	iommu@lists.linux-foundation.org, joro@8bytes.org,
	robin.murphy@arm.com, will.deacon@arm.com
From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v4 1/3] firmware: qcom_scm-64: Add atomic version of
	qcom_scm_call
User-Agent: alot/0.8.1
Date: Fri, 06 Sep 2019 08:12:47 -0700
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	bjorn.andersson@linaro.org
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

Quoting Vivek Gautam (2019-08-22 23:32:46)
> There are scnenarios where drivers are required to make a
> scm call in atomic context, such as in one of the qcom's
> arm-smmu-500 errata [1].
> 
> [1] ("https://source.codeaurora.org/quic/la/kernel/msm-4.9/
>       tree/drivers/iommu/arm-smmu.c?h=msm-4.9#n4842")
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/firmware/qcom_scm-64.c | 136 ++++++++++++++++++++++++++++-------------
>  1 file changed, 92 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
> index 91d5ad7cf58b..b6dca32c5ac4 100644
> --- a/drivers/firmware/qcom_scm-64.c
> +++ b/drivers/firmware/qcom_scm-64.c
> @@ -62,32 +62,71 @@ static DEFINE_MUTEX(qcom_scm_lock);
>  #define FIRST_EXT_ARG_IDX 3
>  #define N_REGISTER_ARGS (MAX_QCOM_SCM_ARGS - N_EXT_QCOM_SCM_ARGS + 1)
>  
> -/**
> - * qcom_scm_call() - Invoke a syscall in the secure world
> - * @dev:       device
> - * @svc_id:    service identifier
> - * @cmd_id:    command identifier
> - * @desc:      Descriptor structure containing arguments and return values
> - *
> - * Sends a command to the SCM and waits for the command to finish processing.
> - * This should *only* be called in pre-emptible context.
> -*/
> -static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
> -                        const struct qcom_scm_desc *desc,
> -                        struct arm_smccc_res *res)
> +static void __qcom_scm_call_do(const struct qcom_scm_desc *desc,
> +                              struct arm_smccc_res *res, u32 fn_id,
> +                              u64 x5, u32 type)
> +{
> +       u64 cmd;
> +       struct arm_smccc_quirk quirk = {.id = ARM_SMCCC_QUIRK_QCOM_A6};

Nitpick: Put spaces around braces please.

> +
> +       cmd = ARM_SMCCC_CALL_VAL(type, qcom_smccc_convention,
> +                                ARM_SMCCC_OWNER_SIP, fn_id);
> +
> +       quirk.state.a6 = 0;
> +
> +       do {
> +               arm_smccc_smc_quirk(cmd, desc->arginfo, desc->args[0],
> +                                   desc->args[1], desc->args[2], x5,
> +                                   quirk.state.a6, 0, res, &quirk);
> +
> +               if (res->a0 == QCOM_SCM_INTERRUPTED)
> +                       cmd = res->a0;
> +
> +       } while (res->a0 == QCOM_SCM_INTERRUPTED);
> +}
> +
> +static void qcom_scm_call_do(const struct qcom_scm_desc *desc,
> +                            struct arm_smccc_res *res, u32 fn_id,
> +                            u64 x5, bool atomic)
> +{
> +       int retry_count = 0;
> +
> +       if (!atomic) {
> +               do {
> +                       mutex_lock(&qcom_scm_lock);
> +
> +                       __qcom_scm_call_do(desc, res, fn_id, x5,
> +                                          ARM_SMCCC_STD_CALL);
> +
> +                       mutex_unlock(&qcom_scm_lock);
> +
> +                       if (res->a0 == QCOM_SCM_V2_EBUSY) {
> +                               if (retry_count++ > QCOM_SCM_EBUSY_MAX_RETRY)
> +                                       break;
> +                               msleep(QCOM_SCM_EBUSY_WAIT_MS);
> +                       }
> +               }  while (res->a0 == QCOM_SCM_V2_EBUSY);
> +       } else {
> +               __qcom_scm_call_do(desc, res, fn_id, x5, ARM_SMCCC_FAST_CALL);
> +       }

To save on some indentation maybe you could write it like:

	if (atomic) {
		__qcom_scm_call_do(..)
		return;
	}

	do {
		mutex_lock(..)
		...
	} while (..);

> +}
> +
> +static int ___qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
> +                           const struct qcom_scm_desc *desc,
> +                           struct arm_smccc_res *res, bool atomic)
>  {
>         int arglen = desc->arginfo & 0xf;
> -       int retry_count = 0, i;
> +       int i;
>         u32 fn_id = QCOM_SCM_FNID(svc_id, cmd_id);
> -       u64 cmd, x5 = desc->args[FIRST_EXT_ARG_IDX];
> +       u64 x5 = desc->args[FIRST_EXT_ARG_IDX];
>         dma_addr_t args_phys = 0;
>         void *args_virt = NULL;
>         size_t alloc_len;
> -       struct arm_smccc_quirk quirk = {.id = ARM_SMCCC_QUIRK_QCOM_A6};
> +       gfp_t flag = atomic ? GFP_ATOMIC : GFP_KERNEL;
>  
>         if (unlikely(arglen > N_REGISTER_ARGS)) {
>                 alloc_len = N_EXT_QCOM_SCM_ARGS * sizeof(u64);
> -               args_virt = kzalloc(PAGE_ALIGN(alloc_len), GFP_KERNEL);
> +               args_virt = kzalloc(PAGE_ALIGN(alloc_len), flag);
>  
>                 if (!args_virt)
>                         return -ENOMEM;
> @@ -156,6 +169,41 @@ static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
>         return 0;
>  }
>  
> +/**
> + * qcom_scm_call() - Invoke a syscall in the secure world
> + * @dev:       device
> + * @svc_id:    service identifier
> + * @cmd_id:    command identifier
> + * @desc:      Descriptor structure containing arguments and return values
> + *
> + * Sends a command to the SCM and waits for the command to finish processing.
> + * This should *only* be called in pre-emptible context.

Add a might_sleep() then?

> + */
> +static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
> +                        const struct qcom_scm_desc *desc,
> +                        struct arm_smccc_res *res)
> +{
> +       return ___qcom_scm_call(dev, svc_id, cmd_id, desc, res, false);
> +}
> +
> +/**
> + * qcom_scm_call_atomic() - atomic variation of qcom_scm_call()
> + * @dev:       device
> + * @svc_id:    service identifier
> + * @cmd_id:    command identifier
> + * @desc:      Descriptor structure containing arguments and return values
> + * @res:       Structure containing results from SMC/HVC call
> + *
> + * Sends a command to the SCM and waits for the command to finish processing.
> + * This should be called in atomic context only.
 
Maybe add a cant_sleep()?

> + */
> +static int qcom_scm_call_atomic(struct device *dev, u32 svc_id, u32 cmd_id,
> +                               const struct qcom_scm_desc *desc,
> +                               struct arm_smccc_res *res)
> +{
> +       return ___qcom_scm_call(dev, svc_id, cmd_id, desc, res, true);
> +}
> +
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
