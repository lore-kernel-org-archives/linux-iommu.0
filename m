Return-Path: <SRS0=uwQI=Y4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FABCA9ED2
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 05:32:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC4F21D71
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 05:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g7CpLTam";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g7CpLTam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC4F21D71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8D6DCB1F;
	Mon,  4 Nov 2019 05:32:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6AAC3B0B
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 05:32:43 +0000 (UTC)
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 166605D0
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 05:32:43 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DBCCF60DD1; Mon,  4 Nov 2019 05:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1572845562;
	bh=ezbKezKlX4+zOTa+yc+p0BT6Tq9ZQetmePWMW9F7z9E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g7CpLTamjmunfR+2Jg8yFKzkSk8VhILq8RI/1T679wL4DuD6HZMr+Fsu0xrJk8CrC
	tLf0JxM7m2n2LswnqOFNng8eBxpxDWsCSzQi6yoR5bMbIFaebuHPRR1wwy9qcU6DHy
	XEewgw6Dfgjb5RMD3N/LaWfwbs/3zF8oGC8S5nQc=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id EF64760B69;
	Mon,  4 Nov 2019 05:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1572845562;
	bh=ezbKezKlX4+zOTa+yc+p0BT6Tq9ZQetmePWMW9F7z9E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g7CpLTamjmunfR+2Jg8yFKzkSk8VhILq8RI/1T679wL4DuD6HZMr+Fsu0xrJk8CrC
	tLf0JxM7m2n2LswnqOFNng8eBxpxDWsCSzQi6yoR5bMbIFaebuHPRR1wwy9qcU6DHy
	XEewgw6Dfgjb5RMD3N/LaWfwbs/3zF8oGC8S5nQc=
MIME-Version: 1.0
Date: Mon, 04 Nov 2019 11:02:41 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv7 0/3] QCOM smmu-500 wait-for-safe handling for sdm845
In-Reply-To: <20191104051925.GC5299@hector.lan>
References: <cover.1568966170.git.saiprakash.ranjan@codeaurora.org>
	<20191101163136.GC3603@willie-the-truck>
	<af7e9a14ae7512665f0cae32e08c8b06@codeaurora.org>
	<20191101172508.GB3983@willie-the-truck>
	<119d4bcf5989d1aa0686fd674c6a3370@codeaurora.org>
	<20191104051925.GC5299@hector.lan>
Message-ID: <be2935ad22caae57ee1d755a14a9f4eb@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
	iommu@lists.linux-foundation.org,
	Vivek Gautam <vivek.gautam@codeaurora.org>,
	linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-msm-owner@vger.kernel.org
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

On 2019-11-04 10:49, Andy Gross wrote:
> On Fri, Nov 01, 2019 at 11:01:59PM +0530, Sai Prakash Ranjan wrote:
>> >>> What's the plan for getting this merged? I'm not happy taking the
>> >>> firmware
>> >>> bits without Andy's ack, but I also think the SMMU changes should go via
>> >>> the IOMMU tree to avoid conflicts.
>> >>>
>> >>> Andy?
>> >>>
>> >>
>> >>Bjorn maintains QCOM stuff now if I am not wrong and he has already
>> >>reviewed
>> >>the firmware bits. So I'm hoping you could take all these through IOMMU
>> >>tree.
>> >
>> >Oh, I didn't realise that. Is there a MAINTAINERS update someplace? If I
>> >run:
>> >
>> >$ ./scripts/get_maintainer.pl -f drivers/firmware/qcom_scm-64.c
>> >
>> >in linux-next, I get:
>> >
>> >Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
>> >linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
>> >linux-kernel@vger.kernel.org (open list)
>> >
>> 
>> It hasn't been updated yet then. I will leave it to Bjorn or Andy to 
>> comment
>> on this.
> 
> The rumors of my demise have been greatly exaggerated.  All kidding 
> aside, I
> ack'ed both.  Bjorn will indeed be coming on as a co-maintener at some 
> point.
> He has already done a lot of yeomans work in helping me out the past 3 
> months.
> 

Thanks for the acks and sorry for that exaggeration :p

-Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
