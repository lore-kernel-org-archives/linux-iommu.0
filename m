Return-Path: <SRS0=HkIk=5M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44822C43331
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 15:10:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C192072F
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 15:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ChNdvKcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C192072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C907B2152C;
	Fri, 27 Mar 2020 15:10:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mv2t+dlu3JF6; Fri, 27 Mar 2020 15:10:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0E91B20780;
	Fri, 27 Mar 2020 15:10:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAD50C1D7C;
	Fri, 27 Mar 2020 15:10:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DF5AC0177
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 15:10:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DE3972152C
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 15:10:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FAIPLeRSeW-u for <iommu@lists.linux-foundation.org>;
 Fri, 27 Mar 2020 15:10:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by silver.osuosl.org (Postfix) with ESMTPS id 4F6EB20780
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 15:10:04 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1585321806; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=8L+aqMqfHrTgXBDzMaiX/dTs4tE5Ws3f3P4pNDyIQpM=;
 b=ChNdvKcThrC5b49rb/DafiekUINLvt7HjhPTBt8dGVARhOx3VskYU/0/Qqt0eBYTj8AnQ/ua
 JfO5QLFQxyXgcxUHmC0O94+wq1ByIgQ1XzM6hCILnuC84wlymmc6VWK/lnnP81YiBI8mgR4C
 P8kAXP8TsvFjvd95mNgnvnGvHww=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7e173c.7f69053bf5e0-smtp-out-n05;
 Fri, 27 Mar 2020 15:09:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id DA6AAC4478C; Fri, 27 Mar 2020 15:09:47 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id A3E0BC433D2;
 Fri, 27 Mar 2020 15:09:46 +0000 (UTC)
MIME-Version: 1.0
Date: Fri, 27 Mar 2020 20:39:46 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/arm-smmu: Demote error messages to debug in
 shutdown callback
In-Reply-To: <0023bc68-45fb-4e80-00c8-01fd0369243f@arm.com>
References: <20200327132852.10352-1-saiprakash.ranjan@codeaurora.org>
 <0023bc68-45fb-4e80-00c8-01fd0369243f@arm.com>
Message-ID: <37db9a4d524aa4d7529ae47a8065c9e0@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Douglas Anderson <dianders@chromium.org>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>
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

Hi Robin,

Thanks for taking a look at this.

On 2020-03-27 19:42, Robin Murphy wrote:
> On 2020-03-27 1:28 pm, Sai Prakash Ranjan wrote:
>> Currently on reboot/shutdown, the following messages are
>> displayed on the console as error messages before the
>> system reboots/shutdown.
>> 
>> On SC7180:
>> 
>>    arm-smmu 15000000.iommu: removing device with active domains!
>>    arm-smmu 5040000.iommu: removing device with active domains!
>> 
>> Demote the log level to debug since it does not offer much
>> help in identifying/fixing any issue as the system is anyways
>> going down and reduce spamming the kernel log.
> 
> I've gone back and forth on this pretty much ever since we added the
> shutdown hook - on the other hand, if any devices *are* still running
> in those domains at this point, then once we turn off the SMMU and let
> those IOVAs go out on the bus as physical addresses, all manner of
> weirdness may ensue. Thus there is an argument for *some* indication
> that this may happen, although IMO it could be downgraded to at least
> dev_warn().
> 

Any pointers to the weirdness here after SMMU is turned off?
Because if we look at the call sites, device_shutdown is called
from kernel_restart_prepare or kernel_shutdown_prepare which would
mean system is going down anyways, so do we really care about these
error messages or warnings from SMMU?

  arm_smmu_device_shutdown
   platform_drv_shutdown
    device_shutdown
     kernel_restart_prepare
      kernel_restart


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
