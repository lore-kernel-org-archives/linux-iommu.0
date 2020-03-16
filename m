Return-Path: <SRS0=N4Nm=5B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C54C18E5B
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 16:37:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2534720719
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 16:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="VOa+yZQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2534720719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EAE0888423;
	Mon, 16 Mar 2020 16:37:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v-WTVjx3v-TB; Mon, 16 Mar 2020 16:37:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4D2C687E90;
	Mon, 16 Mar 2020 16:37:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A4A5C18DA;
	Mon, 16 Mar 2020 16:37:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCBFDC013E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 16:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A5B5C88046
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 16:37:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AfB7-ZKD-W-y for <iommu@lists.linux-foundation.org>;
 Mon, 16 Mar 2020 16:37:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BE6FE87697
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 16:37:08 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1584376628; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Z4SetJr+WVQFYQOeb4040xyBonyw20d7MV9fV+K7/JQ=;
 b=VOa+yZQfJn/HFn4skspufLuR0w7C9FtwT+wvxCyeW9w6HpI2Ae5py8ejuJ1Vih0CoQQT6xmi
 4ygbtmBnOHnnE0Bw9FI19HYX0qNH3fVZRKY6ycu0CTfzGHUVvRF/svGDPVMwIE/kya9e/aco
 BMXHVfz5oUR4+jel3v0wsWOfZwo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6fab33.7f78a9679458-smtp-out-n05;
 Mon, 16 Mar 2020 16:37:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 994A5C44788; Mon, 16 Mar 2020 16:37:06 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: sibis)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id F3B31C432C2;
 Mon, 16 Mar 2020 16:37:04 +0000 (UTC)
MIME-Version: 1.0
Date: Mon, 16 Mar 2020 22:07:04 +0530
From: Sibi Sankar <sibis@codeaurora.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/3] Request direct mapping for modem firmware subdevice
In-Reply-To: <20200316155028.GB18704@infradead.org>
References: <20200309182255.20142-1-sibis@codeaurora.org>
 <20200316155028.GB18704@infradead.org>
Message-ID: <8cfddb6cbc424b131c9ab823c0c0f3f1@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: ohad@wizery.com, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, agross@kernel.org, linux-arm-msm-owner@vger.kernel.org
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

Hey Christoph,
Thanks for taking time to review
the series.

On 2020-03-16 21:20, Christoph Hellwig wrote:
> On Mon, Mar 09, 2020 at 11:52:52PM +0530, Sibi Sankar wrote:
>> The Q6 modem sub-system has direct access to DDR through memnoc and
>> an indirect access routed through a SMMU which MSS CE (crypto engine
>> sub-component of MSS) uses during out of reset sequence. Request 
>> direct
>> mapping for the modem-firmware subdevice since smmu is not expected
>> to provide access control/translation for these SIDs (sandboxing of 
>> the
>> modem is achieved through XPUs engaged using SMC calls).
> 
> Please fix your device tree so that the device isn't bound to an
> IOMMU.

the bindings proposed in the series
would add a sub-device with an iommu
property.

modem_pil: remoteproc@xxxxx {
...
    modem-firmware {
         iommus = <&apps_smmu 0x460 0x1>;
    };
...
};

Remoteproc device will not have a iommu
property but modem-firmware sub-device
will.

With ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT y,
we would want to configure the SID either
in direct mapping or bypass (either will
do since protection is achieved through
other means)

https://lore.kernel.org/lkml/497e40b8-300f-1b83-4312-93a58c459d1d@arm.com/

Currently the restructuring is trending
towards whats discussed in the ^^ thread.
i.e either direct mapping/bypass will be
done in the SoC specific corner of the
SMMU driver.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
