Return-Path: <SRS0=cOz4=6E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63A3C3815B
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 18:10:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEDCF2071C
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 18:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="skKKXCwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEDCF2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7F4A32083F;
	Mon, 20 Apr 2020 18:10:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zgOSkTVqNXLw; Mon, 20 Apr 2020 18:10:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B57D2203C8;
	Mon, 20 Apr 2020 18:10:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98E21C07FF;
	Mon, 20 Apr 2020 18:10:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B980EC0177
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 18:10:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A876C86D13
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 18:10:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qi3AZ50M2DJg for <iommu@lists.linux-foundation.org>;
 Mon, 20 Apr 2020 18:10:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by whitealder.osuosl.org (Postfix) with ESMTPS id AD294838CD
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 18:10:49 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1587406251; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=wos3Ak73xOXHzWR83+yksTYRpe5mwIS/buxq9eAwCz8=;
 b=skKKXCwIIq7FtHwZW7dWvfYo+IUVz3bi2X9WhQWPy5Nc91+e2ba4dsJzS2DCwYep81GbuXgJ
 3SOki5nNa6CTkCwALQYtDq89Lm2CYKvK5t76iAXFLZ9GTGjwFfN65SKFKjSsjH0y8un6KEC7
 6AnsmdbUgsOCsbPTvLz+JoRXM50=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9de5a4.7ff15caf0c00-smtp-out-n02;
 Mon, 20 Apr 2020 18:10:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id BECADC43637; Mon, 20 Apr 2020 18:10:43 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 5DCECC433D2;
 Mon, 20 Apr 2020 18:10:42 +0000 (UTC)
MIME-Version: 1.0
Date: Mon, 20 Apr 2020 23:40:42 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCHv3 4/6] iommu/arm-smmu-qcom: Request direct mapping for
 modem device
In-Reply-To: <49c8c377-961b-3f95-a99c-08528def4cb7@arm.com>
References: <cover.1587400573.git.saiprakash.ranjan@codeaurora.org>
 <509d88fbe7592aa15f867933c177b61bc7ba8efa.1587400573.git.saiprakash.ranjan@codeaurora.org>
 <49c8c377-961b-3f95-a99c-08528def4cb7@arm.com>
Message-ID: <98fa2940456ade2bd0998dfaa6386653@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: Evan Green <evgreen@chromium.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Matthias Kaehlcke <mka@chromium.org>, Sibi Sankar <sibis@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On 2020-04-20 22:39, Robin Murphy wrote:
> On 2020-04-20 5:42 pm, Sai Prakash Ranjan wrote:
>> From: Sibi Sankar <sibis@codeaurora.org>
>> 
>> Request direct mapping for modem on platforms which don't have 
>> TrustZone
>> (which programs the modem SIDs) to prevent the following global faults 
>> seen
>> on Cheza/Trogdor:
> 
> Not strictly true - it's patch #6/6 that prevents *those* faults (and
> these days the driver should be reporting unmatched streams a little
> more helpfully). This change would resolve the context faults and/or
> weird memory corruption that might result from applying patch #6 alone
> - this is the crazy thing where transactions sometimes go directly to
> DRAM round the side of the SMMU so we can never safely remap anything,
> right?
> 

True this doesnt prevent global faults, the fault details should go to 
patch6.
I'll update the commit msg something like below:

The Q6 modem sub-system has direct access to DDR through memnoc.
Also SMMU is not expected to provide access control/translation for 
these SIDs
(sandboxing of the modem is achieved through XPUs engaged using SMC 
calls).

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
