Return-Path: <SRS0=3WiH=XL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB7AC49ED7
	for <iommu@archiver.kernel.org>; Mon, 16 Sep 2019 09:48:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E063206A4
	for <iommu@archiver.kernel.org>; Mon, 16 Sep 2019 09:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PO5YnYLq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="C+cuGUnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E063206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 75B211396;
	Mon, 16 Sep 2019 09:48:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C40EE1385
	for <iommu@lists.linux-foundation.org>;
	Mon, 16 Sep 2019 09:48:47 +0000 (UTC)
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3FAF68C2
	for <iommu@lists.linux-foundation.org>;
	Mon, 16 Sep 2019 09:48:47 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A4A4A611FD; Mon, 16 Sep 2019 09:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1568627326;
	bh=gSMHSxm7daISBqRTn/P76XW22BqHURNzjdMI5TSKy5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PO5YnYLqzvsQGgu7hyceLyHkARSSVKLpBkGh7AinMNy+B/n5jamfrIAy4ufdsFLmu
	/jNMm69Gkcg7xa6yCUKuCz+aGRagfUwuqIvw2hJq6v+ZgduXZYO4mkY8Z5Yo5pDjsU
	ul9NTbNdk4sBk9ZD0WltKZUaMmv7vN/qDzfPBfg4=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4627B60364;
	Mon, 16 Sep 2019 09:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1568627323;
	bh=gSMHSxm7daISBqRTn/P76XW22BqHURNzjdMI5TSKy5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C+cuGUnkMSTI/eocGSGpoKbL9csPsW2566HwUgIrrDFAE4LaAWkOj9DD7tzTE0otv
	AHtfOd0FrHTaAuUb39Shpe+RQUIl1WSyvprmdMuSPmpAMChnFsdY5znpME9V1rsixX
	WXA9i4lwXgp9mAklqvq8YMzSuPFkI72UJS7aLFhI=
MIME-Version: 1.0
Date: Mon, 16 Sep 2019 15:18:43 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v4 1/3] firmware: qcom_scm-64: Add atomic version of
	qcom_scm_call
In-Reply-To: <5d727770.1c69fb81.c9062.ce60@mx.google.com>
References: <20190823063248.13295-1-vivek.gautam@codeaurora.org>
	<20190823063248.13295-2-vivek.gautam@codeaurora.org>
	<5d727770.1c69fb81.c9062.ce60@mx.google.com>
Message-ID: <56234ab589c9a140a0aeab722da9503a@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Cc: linux-arm-msm@vger.kernel.org, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
	iommu@lists.linux-foundation.org, agross@kernel.org,
	robin.murphy@arm.com, linux-arm-msm-owner@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Stephen,

On 2019-09-06 20:42, Stephen Boyd wrote:
> Quoting Vivek Gautam (2019-08-22 23:32:46)
>> There are scnenarios where drivers are required to make a
>> scm call in atomic context, such as in one of the qcom's
>> arm-smmu-500 errata [1].
>> 
>> [1] ("https://source.codeaurora.org/quic/la/kernel/msm-4.9/
>>       tree/drivers/iommu/arm-smmu.c?h=msm-4.9#n4842")
>> 
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> ---
>>  drivers/firmware/qcom_scm-64.c | 136 
>> ++++++++++++++++++++++++++++-------------
>>  1 file changed, 92 insertions(+), 44 deletions(-)
>> 
>> diff --git a/drivers/firmware/qcom_scm-64.c 
>> b/drivers/firmware/qcom_scm-64.c
>> index 91d5ad7cf58b..b6dca32c5ac4 100644
>> --- a/drivers/firmware/qcom_scm-64.c
>> +++ b/drivers/firmware/qcom_scm-64.c
>> @@ -62,32 +62,71 @@ static DEFINE_MUTEX(qcom_scm_lock);
>>  #define FIRST_EXT_ARG_IDX 3
>>  #define N_REGISTER_ARGS (MAX_QCOM_SCM_ARGS - N_EXT_QCOM_SCM_ARGS + 1)
>> 
>> -/**
>> - * qcom_scm_call() - Invoke a syscall in the secure world
>> - * @dev:       device
>> - * @svc_id:    service identifier
>> - * @cmd_id:    command identifier
>> - * @desc:      Descriptor structure containing arguments and return 
>> values
>> - *
>> - * Sends a command to the SCM and waits for the command to finish 
>> processing.
>> - * This should *only* be called in pre-emptible context.
>> -*/
>> -static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
>> -                        const struct qcom_scm_desc *desc,
>> -                        struct arm_smccc_res *res)
>> +static void __qcom_scm_call_do(const struct qcom_scm_desc *desc,
>> +                              struct arm_smccc_res *res, u32 fn_id,
>> +                              u64 x5, u32 type)
>> +{
>> +       u64 cmd;
>> +       struct arm_smccc_quirk quirk = {.id = 
>> ARM_SMCCC_QUIRK_QCOM_A6};
> 
> Nitpick: Put spaces around braces please.
> 
>> +
>> +       cmd = ARM_SMCCC_CALL_VAL(type, qcom_smccc_convention,
>> +                                ARM_SMCCC_OWNER_SIP, fn_id);
>> +
>> +       quirk.state.a6 = 0;
>> +
>> +       do {
>> +               arm_smccc_smc_quirk(cmd, desc->arginfo, desc->args[0],
>> +                                   desc->args[1], desc->args[2], x5,
>> +                                   quirk.state.a6, 0, res, &quirk);
>> +
>> +               if (res->a0 == QCOM_SCM_INTERRUPTED)
>> +                       cmd = res->a0;
>> +
>> +       } while (res->a0 == QCOM_SCM_INTERRUPTED);
>> +}
>> +
>> +static void qcom_scm_call_do(const struct qcom_scm_desc *desc,
>> +                            struct arm_smccc_res *res, u32 fn_id,
>> +                            u64 x5, bool atomic)
>> +{
>> +       int retry_count = 0;
>> +
>> +       if (!atomic) {
>> +               do {
>> +                       mutex_lock(&qcom_scm_lock);
>> +
>> +                       __qcom_scm_call_do(desc, res, fn_id, x5,
>> +                                          ARM_SMCCC_STD_CALL);
>> +
>> +                       mutex_unlock(&qcom_scm_lock);
>> +
>> +                       if (res->a0 == QCOM_SCM_V2_EBUSY) {
>> +                               if (retry_count++ > 
>> QCOM_SCM_EBUSY_MAX_RETRY)
>> +                                       break;
>> +                               msleep(QCOM_SCM_EBUSY_WAIT_MS);
>> +                       }
>> +               }  while (res->a0 == QCOM_SCM_V2_EBUSY);
>> +       } else {
>> +               __qcom_scm_call_do(desc, res, fn_id, x5, 
>> ARM_SMCCC_FAST_CALL);
>> +       }
> 
> To save on some indentation maybe you could write it like:
> 
> 	if (atomic) {
> 		__qcom_scm_call_do(..)
> 		return;
> 	}
> 
> 	do {
> 		mutex_lock(..)
> 		...
> 	} while (..);
> 
>> +}
>> +
>> +static int ___qcom_scm_call(struct device *dev, u32 svc_id, u32 
>> cmd_id,
>> +                           const struct qcom_scm_desc *desc,
>> +                           struct arm_smccc_res *res, bool atomic)
>>  {
>>         int arglen = desc->arginfo & 0xf;
>> -       int retry_count = 0, i;
>> +       int i;
>>         u32 fn_id = QCOM_SCM_FNID(svc_id, cmd_id);
>> -       u64 cmd, x5 = desc->args[FIRST_EXT_ARG_IDX];
>> +       u64 x5 = desc->args[FIRST_EXT_ARG_IDX];
>>         dma_addr_t args_phys = 0;
>>         void *args_virt = NULL;
>>         size_t alloc_len;
>> -       struct arm_smccc_quirk quirk = {.id = 
>> ARM_SMCCC_QUIRK_QCOM_A6};
>> +       gfp_t flag = atomic ? GFP_ATOMIC : GFP_KERNEL;
>> 
>>         if (unlikely(arglen > N_REGISTER_ARGS)) {
>>                 alloc_len = N_EXT_QCOM_SCM_ARGS * sizeof(u64);
>> -               args_virt = kzalloc(PAGE_ALIGN(alloc_len), 
>> GFP_KERNEL);
>> +               args_virt = kzalloc(PAGE_ALIGN(alloc_len), flag);
>> 
>>                 if (!args_virt)
>>                         return -ENOMEM;
>> @@ -156,6 +169,41 @@ static int qcom_scm_call(struct device *dev, u32 
>> svc_id, u32 cmd_id,
>>         return 0;
>>  }
>> 
>> +/**
>> + * qcom_scm_call() - Invoke a syscall in the secure world
>> + * @dev:       device
>> + * @svc_id:    service identifier
>> + * @cmd_id:    command identifier
>> + * @desc:      Descriptor structure containing arguments and return 
>> values
>> + *
>> + * Sends a command to the SCM and waits for the command to finish 
>> processing.
>> + * This should *only* be called in pre-emptible context.
> 
> Add a might_sleep() then?
> 
>> + */
>> +static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
>> +                        const struct qcom_scm_desc *desc,
>> +                        struct arm_smccc_res *res)
>> +{
>> +       return ___qcom_scm_call(dev, svc_id, cmd_id, desc, res, 
>> false);
>> +}
>> +
>> +/**
>> + * qcom_scm_call_atomic() - atomic variation of qcom_scm_call()
>> + * @dev:       device
>> + * @svc_id:    service identifier
>> + * @cmd_id:    command identifier
>> + * @desc:      Descriptor structure containing arguments and return 
>> values
>> + * @res:       Structure containing results from SMC/HVC call
>> + *
>> + * Sends a command to the SCM and waits for the command to finish 
>> processing.
>> + * This should be called in atomic context only.
> 
> Maybe add a cant_sleep()?
> 
>> + */
>> +static int qcom_scm_call_atomic(struct device *dev, u32 svc_id, u32 
>> cmd_id,
>> +                               const struct qcom_scm_desc *desc,
>> +                               struct arm_smccc_res *res)
>> +{
>> +       return ___qcom_scm_call(dev, svc_id, cmd_id, desc, res, true);
>> +}
>> +

Have addressed all your comments in v5.

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
