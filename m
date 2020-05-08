Return-Path: <SRS0=CQae=6W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECE1C38A2A
	for <iommu@archiver.kernel.org>; Fri,  8 May 2020 17:23:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E17BD206D3
	for <iommu@archiver.kernel.org>; Fri,  8 May 2020 17:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="k645KFjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17BD206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9A6D325E37;
	Fri,  8 May 2020 17:23:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7SA1GPz0Db5n; Fri,  8 May 2020 17:23:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 206992262E;
	Fri,  8 May 2020 17:23:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10632C0865;
	Fri,  8 May 2020 17:23:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE4B5C07FF
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 17:23:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A8622897ED
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 17:23:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KNsE76QzR0Ea for <iommu@lists.linux-foundation.org>;
 Fri,  8 May 2020 17:23:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0AF90897A6
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 17:23:32 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1588958615; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=/ShlGgt8pBZ07QCqgaBqW3lEITDpUemdyZJbqV+iVnw=;
 b=k645KFjmfxB+XO+/DMKOwzHKeaDGcIKtcqY3q29v3Ra1aGZgfi80e8izRhihuQixDa/c+xCx
 dEmSmZcXZe256kWn8AOKBTgvFj9IkL8dVZ9MUrqq0ez7TneicCW/vQfa5aMKMBU6VRoa7X/N
 xZJ/rhQOG81IWmZ5/jpXwY41lR8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb59589.7ffa9ad8bb58-smtp-out-n04;
 Fri, 08 May 2020 17:23:21 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id EA1DAC43637; Fri,  8 May 2020 17:23:20 +0000 (UTC)
Received: from [10.79.43.230]
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: sibis)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 5F3C0C433F2;
 Fri,  8 May 2020 17:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F3C0C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v5] iommu/arm-smmu-qcom: Request direct mapping for modem
 device
To: Stephen Boyd <swboyd@chromium.org>, joro@8bytes.org,
 robin.murphy@arm.com, will@kernel.org
References: <20200507192157.6831-1-sibis@codeaurora.org>
 <158888607765.26370.18078298627976225073@swboyd.mtv.corp.google.com>
From: Sibi Sankar <sibis@codeaurora.org>
Message-ID: <f22f0988-a965-d07b-1830-3f5eae42f299@codeaurora.org>
Date: Fri, 8 May 2020 22:53:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <158888607765.26370.18078298627976225073@swboyd.mtv.corp.google.com>
Content-Language: en-US
Cc: linux-arm-msm@vger.kernel.org, dianders@chromium.org, evgreen@chromium.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mka@chromium.org, bjorn.andersson@linaro.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hey Stephen,
Thanks for taking time to review the patch.

On 5/8/20 2:44 AM, Stephen Boyd wrote:
> Quoting Sibi Sankar (2020-05-07 12:21:57)
>> The modem remote processor has two modes of access to the DDR, a direct
>> mode and through a SMMU which requires direct mapping. The configuration
>> of the modem SIDs is handled in TrustZone.
> 
> Is it "The configuration of the modem SIDs is typically handled by
> code running in the ARM CPU's secure mode, i.e. secure EL1"? And is that
> even true? I though it was programmed by EL2.
What I meant to say was qcom implementation of TZ or qcom
proprietary bootloaders. I should have been more specific
and mentioned that the configuration is done at EL2 by QHEE
(Qualcomm's Hypervisor Execution Environment) before we enter
the kernel.

> 
>> On platforms where TrustZone
> 
> TrustZone is always there.
> 
>> is absent this needs to be explicitly done from kernel. Add compatibles
>> for modem to opt in for direct mapping on such platforms.
>>
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> Is Sai the author? Or does this need a co-developed-by tag?

I decided to include Sai's S-b just to show I took back
ownership of the patch from his patch series. I'll drop
it in the next re-spin.

> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>
>> V5
>>   * Reword commit message and drop unnecessary details
> 
> I don't see any improvement! Probably because I don't understand _why_
> the modem needs a direct mapping. The commit text basically says "we
> need to do it because it isn't done in secure world sometimes". This is
> probably wrong what I wrote below, but I'd like to clarify to confirm my
> understanding. Maybe the commit text should say:

Thanks for taking time to reword the commit message will use
the same with a few corrections.

> 
> The modem remote processor has two access paths to DDR. One path is
> directly connected to DDR and another path goes through an SMMU. The
> SMMU path is configured to be a direct mapping because it's used by
> various peripherals in the modem subsystem. 

I'll use ^^ as is.

> Typically this direct
> mapping is configured by programming modem SIDs into the SMMU when EL2
> responds to a hyp call from the code that loads the modem binary in the
> secure world.

Typically this direct mapping is configured statically at EL2
by QHEE (Qualcomm's Hypervisor Execution Environment) before
the kernel is entered.

> 
> In certain firmware configurations, especially when the kernel is
> entered at EL2, we don't want secure mode to make hyp calls to program
> the SMMU because the kernel is in full control of the SMMU. Let's add
> compatibles here so that we can have the kernel program the SIDs for the
> modem in these cases.

In certain firmware configuration, especially when the kernel is already 
in full control of the SMMU, defer programming the modem SIDs to the
kernel. Let's add compatibles here so that we can have the kernel
program the SIDs for the modem in these cases.

Will/Stephen,
Let me know if the above changes are okay? I'll re-spin the patch
based on your feedback.

> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
