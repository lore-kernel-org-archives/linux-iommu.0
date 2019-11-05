Return-Path: <SRS0=ZmA0=Y5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415F7CA9ED4
	for <iommu@archiver.kernel.org>; Tue,  5 Nov 2019 02:29:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A539214E0
	for <iommu@archiver.kernel.org>; Tue,  5 Nov 2019 02:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KMrEoYr7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nOZWF/Ro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A539214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B4A57EB0;
	Tue,  5 Nov 2019 02:29:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C024DEAF
	for <iommu@lists.linux-foundation.org>;
	Tue,  5 Nov 2019 02:29:18 +0000 (UTC)
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 51228189
	for <iommu@lists.linux-foundation.org>;
	Tue,  5 Nov 2019 02:29:18 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1ECDD60A50; Tue,  5 Nov 2019 02:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1572920958;
	bh=Yz5Pb8QULVWB/wXiv94o8i3LmKowXMZZDYSjNSX+YYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KMrEoYr7M6bHTfQlUE95lDjwsoTzyLiP5R3gkcrVa1m4egtX/F0oemWDJVsxvY/hK
	55B4UwnHgdG6cI8cHTOsd44mnaHy47UJRf3X79lQF5/H8POiJjFl5Q9ll4Go7gM45g
	oO+gY50kDBXYlaUr4EkVgjxco1XG90Y7bWA9rWXg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id D7C0A60A50;
	Tue,  5 Nov 2019 02:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1572920956;
	bh=Yz5Pb8QULVWB/wXiv94o8i3LmKowXMZZDYSjNSX+YYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nOZWF/RoEvUPPAGGW4QIZHLAQSS4OIBQOQLn7EYM2wnXbIbZKtcSskHUMqdzsXoQA
	yydh3m/fcShh8F6O9tE18yXu/3en+U+vhsoNEvU+v8+h1q0yMoaY/pIBhTIcHGR+bw
	ICPY3t+Qoie730Vb298af7ROBz0NB3l1zniDWxUw=
MIME-Version: 1.0
Date: Tue, 05 Nov 2019 07:59:16 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCHv7 0/3] QCOM smmu-500 wait-for-safe handling for sdm845
In-Reply-To: <20191104162339.GD24909@willie-the-truck>
References: <cover.1568966170.git.saiprakash.ranjan@codeaurora.org>
	<20191101163136.GC3603@willie-the-truck>
	<af7e9a14ae7512665f0cae32e08c8b06@codeaurora.org>
	<20191101172508.GB3983@willie-the-truck>
	<119d4bcf5989d1aa0686fd674c6a3370@codeaurora.org>
	<20191104051925.GC5299@hector.lan>
	<20191104151506.GB24909@willie-the-truck>
	<20191104162339.GD24909@willie-the-truck>
Message-ID: <8d20a6af33b80191d44db97b757d0dfa@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Cc: Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
	iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
	Vivek Gautam <vivek.gautam@codeaurora.org>,
	bjorn.andersson@linaro.org, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-msm-owner@vger.kernel.org
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

On 2019-11-04 21:53, Will Deacon wrote:
> On Mon, Nov 04, 2019 at 03:15:06PM +0000, Will Deacon wrote:
>> On Sun, Nov 03, 2019 at 11:19:25PM -0600, Andy Gross wrote:
>> > On Fri, Nov 01, 2019 at 11:01:59PM +0530, Sai Prakash Ranjan wrote:
>> > > >>> What's the plan for getting this merged? I'm not happy taking the
>> > > >>> firmware
>> > > >>> bits without Andy's ack, but I also think the SMMU changes should go via
>> > > >>> the IOMMU tree to avoid conflicts.
>> > > >>>
>> > > >>> Andy?
>> > > >>>
>> > > >>
>> > > >>Bjorn maintains QCOM stuff now if I am not wrong and he has already
>> > > >>reviewed
>> > > >>the firmware bits. So I'm hoping you could take all these through IOMMU
>> > > >>tree.
>> > > >
>> > > >Oh, I didn't realise that. Is there a MAINTAINERS update someplace? If I
>> > > >run:
>> > > >
>> > > >$ ./scripts/get_maintainer.pl -f drivers/firmware/qcom_scm-64.c
>> > > >
>> > > >in linux-next, I get:
>> > > >
>> > > >Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
>> > > >linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
>> > > >linux-kernel@vger.kernel.org (open list)
>> > > >
>> > >
>> > > It hasn't been updated yet then. I will leave it to Bjorn or Andy to comment
>> > > on this.
>> >
>> > The rumors of my demise have been greatly exaggerated.  All kidding aside, I
>> > ack'ed both.  Bjorn will indeed be coming on as a co-maintener at some point.
>> > He has already done a lot of yeomans work in helping me out the past 3 months.
>> 
>> Cheers Andy, and I'm pleased to hear that you're still with us! I've 
>> queued
>> this lot for 5.5 and I'll send to Joerg this week.
> 
> Bah, in doing so I spotted that the existing code doesn't handle error 
> codes
> properly because 'a0' is unsigned. I'll queue the patch below at the 
> start
> of the series.
> 
> Will
> 
> --->8
> 
> From a9a1047f08de0eff249fb65e2d5d6f6f8b2a87f0 Mon Sep 17 00:00:00 2001
> From: Will Deacon <will@kernel.org>
> Date: Mon, 4 Nov 2019 15:58:15 +0000
> Subject: [PATCH] firmware: qcom: scm: Ensure 'a0' status code is 
> treated as
>  signed
> 
> The 'a0' member of 'struct arm_smccc_res' is declared as 'unsigned 
> long',
> however the Qualcomm SCM firmware interface driver expects to receive
> negative error codes via this field, so ensure that it's cast to 'long'
> before comparing to see if it is less than 0.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/firmware/qcom_scm-64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/qcom_scm-64.c 
> b/drivers/firmware/qcom_scm-64.c
> index 91d5ad7cf58b..25e0f60c759a 100644
> --- a/drivers/firmware/qcom_scm-64.c
> +++ b/drivers/firmware/qcom_scm-64.c
> @@ -150,7 +150,7 @@ static int qcom_scm_call(struct device *dev, u32
> svc_id, u32 cmd_id,
>  		kfree(args_virt);
>  	}
> 
> -	if (res->a0 < 0)
> +	if ((long)res->a0 < 0)
>  		return qcom_scm_remap_error(res->a0);
> 
>  	return 0;

Fixes: 6b1751a86ce2 ("firmware: qcom: scm: Add support for ARM64 SoCs") 
?

FWIW, Reviewed-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

-Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
