Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDA9C31E44
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 09:01:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91F620866
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 09:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="a5x7Q5fE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dTdmPSgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91F620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9F9A3E76;
	Fri, 14 Jun 2019 09:01:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AED92DD6
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 09:01:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 95FD7174
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 09:01:13 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 58EC260A33; Fri, 14 Jun 2019 09:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1560502873;
	bh=CEPg9SjCJWxoxlllbshGhQypKWjlbh7i11o4DsbvNb8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
	b=a5x7Q5fEklM2XCBFzFCzeUDk6RONP1hA4PTtFOSpxG+YS+p3xX5WKE0iTFtwCxOMA
	e1Vcm7dU6HmZ+xwhfQKLSnaPRTG1N4V+O9hbORhifHiA1WCBYyBfLPfp5ysGUVTZ8S
	nu1VTCR7vgBS8T2CkCMGQJP8VJ+wKuV50Y0k9PR8=
Received: from [10.79.128.120]
	(blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com
	[103.229.18.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: vivek.gautam@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id F0BDE60254;
	Fri, 14 Jun 2019 09:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1560502872;
	bh=CEPg9SjCJWxoxlllbshGhQypKWjlbh7i11o4DsbvNb8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
	b=dTdmPSgyegTwDKNrKINqZdX5vcdA0AXS/1DcJM5O/+fOp4+IeiuZ5LJiENp/7V6MW
	wHjQBVtsCVlk3u0dQMgAki0dfAGQoXUlDjcaP56Mg99dpzbhYZBEJvpEQIv4Gn71tR
	TKTbvwRRBxNU/eLIeiyk0vAWO8tqZUihWnSTLYdg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F0BDE60254
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v3 4/4] arm64: dts/sdm845: Enable FW implemented safe
	sequence handler on MTP
To: Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20190612071554.13573-1-vivek.gautam@codeaurora.org>
	<20190612071554.13573-5-vivek.gautam@codeaurora.org>
	<20190614040659.GL22737@tuxbook-pro>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <eaa8abc7-07a1-9c52-685c-25883cba67b9@codeaurora.org>
Date: Fri, 14 Jun 2019 14:31:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614040659.GL22737@tuxbook-pro>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org



On 6/14/2019 9:36 AM, Bjorn Andersson wrote:
> On Wed 12 Jun 00:15 PDT 2019, Vivek Gautam wrote:
>
>> Indicate on MTP SDM845 that firmware implements handler to
>> TLB invalidate erratum SCM call where SAFE sequence is toggled
>> to achieve optimum performance on real-time clients, such as
>> display and camera.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks Bjorn for reviewing this.

Best regards
Vivek

[snip]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
