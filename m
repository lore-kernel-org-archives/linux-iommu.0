Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0D6C4724C
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 11:08:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C56820736
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 11:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="InrC29/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C56820736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0F59A887D1;
	Thu,  7 May 2020 11:08:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IJtm3Q1uQyyz; Thu,  7 May 2020 11:08:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 638DE88757;
	Thu,  7 May 2020 11:08:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44AE8C0859;
	Thu,  7 May 2020 11:08:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 182B8C07FF
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 11:08:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F33BB2076E
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 11:08:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mr3NVfwQFDLt for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 11:08:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by silver.osuosl.org (Postfix) with ESMTPS id 7A9972045A
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 11:08:14 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1588849697; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=gMmW7XurMTP82sFXTk8ae/eelAs13yx3uauX9ImYmK0=;
 b=InrC29/JK0KURCw7CTclTfPuuooZ2aw+6PSq4e/9zoo5JKqJAZ6pJtQyvkishmBVKEHl3cYh
 vHZ7gnOEuj2LTsvOddVrhPBjAwqvVHyfHKeyxCMgbdwdrt4NgWG3GMRjpq8cDzR35hznvS75
 Pn+BlryRMXAoeHhlhsX3WzwjIm4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb3ec13.7ff0eebccd88-smtp-out-n03;
 Thu, 07 May 2020 11:08:03 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id C24A3C44792; Thu,  7 May 2020 11:08:01 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id BAB7DC433F2;
 Thu,  7 May 2020 11:08:00 +0000 (UTC)
MIME-Version: 1.0
Date: Thu, 07 May 2020 16:38:00 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCHv4 0/6] iommu/arm-smmu: Allow client devices to select
 identity mapping
In-Reply-To: <20200507103129.GA29541@willie-the-truck>
References: <cover.1587407458.git.saiprakash.ranjan@codeaurora.org>
 <aa54fd00a6d353c72664e41b7a4a4e3d@codeaurora.org>
 <20200507103129.GA29541@willie-the-truck>
Message-ID: <84efe9b60e1d7d440e0b5c1777d4eec6@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Will,

On 2020-05-07 16:01, Will Deacon wrote:
> On Thu, May 07, 2020 at 03:58:06PM +0530, Sai Prakash Ranjan wrote:
>> Hi Will, Joerg
>> 
>> On 2020-04-21 00:03, Sai Prakash Ranjan wrote:
>> > This series allows DRM, Modem devices to set a default
>> > identity mapping in qcom smmu implementation.
>> >
>> > Patch 1 is cleanup to support other SoCs to call into
>> > QCOM specific  implementation.
>> > Patch 2 sets the default identity domain for DRM devices.
>> > Patch 3 implements def_domain_type callback for arm-smmu.
>> > Patch 4 sets the default identity domain for modem device.
>> > Patch 5-6 adds the iommus property for mss pil.
>> >
>> > This is based on Joerg's tree:
>> >  -
>> > https://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git/log/?h=iommu-probe-device-v2
>> >
>> > v4:
>> >  * Updated commit msg for mss pil requesting direct mapping
>> >
>> > v3:
>> >  * Use arm_smmu_master_cfg to get impl instead of long way as per Robin.
>> >  * Use def_domain_type name for the callback in arm_smmu_imp as per
>> > Robin
>> >
>> > Jordan Crouse (1):
>> >   iommu/arm-smmu: Allow client devices to select direct mapping
>> >
>> > Sai Prakash Ranjan (2):
>> >   iommu: arm-smmu-impl: Convert to a generic reset implementation
>> >   iommu/arm-smmu: Implement iommu_ops->def_domain_type call-back
>> >
>> > Sibi Sankar (3):
>> >   iommu/arm-smmu-qcom: Request direct mapping for modem device
>> >   dt-bindings: remoteproc: qcom: Add iommus property
>> >   arm64: dts: qcom: sdm845-cheza: Add iommus property
>> >
>> >  .../bindings/remoteproc/qcom,q6v5.txt         |  3 ++
>> >  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    |  5 +++
>> >  drivers/iommu/arm-smmu-impl.c                 |  8 ++--
>> >  drivers/iommu/arm-smmu-qcom.c                 | 37 +++++++++++++++++--
>> >  drivers/iommu/arm-smmu.c                      | 12 ++++++
>> >  drivers/iommu/arm-smmu.h                      |  1 +
>> >  6 files changed, 60 insertions(+), 6 deletions(-)
>> 
>> This series is reviewed by Robin.
>> Any chance this series can make it to 5.8?
> 
> I'm planning to queue smmu stuff next week, been busy with arm64 stuff
> so far, sorry.
> 

No problem at all, thought of reminding once just in case.

Thanks
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
