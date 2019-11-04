Return-Path: <SRS0=uwQI=Y4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A998CA9EB5
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 16:23:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF9320848
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 16:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/rTSMP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF9320848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D3FD2F7A;
	Mon,  4 Nov 2019 16:23:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DD213F78
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 16:23:45 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 65A1067F
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 16:23:45 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 4BF922089C;
	Mon,  4 Nov 2019 16:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572884625;
	bh=P2/hAu6NNY+cjTFhjvZ4bPAmXxxRjGf1KyyYpDXKzSA=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=s/rTSMP7Roq4fVQZaSrLiaBxNurgYto8bR1HNyD6jophzl/s9U18Bbd+Bk9gA6aT4
	/OQryltJXB8bd3HxxomMbpo7Tmab4aDQosybNQ3UKTvdAHBU9FQI6K/u3gkD9MryQN
	KVPF6v9BrHMP4wDJqLlJYFiBNmnvwjmh4ByVoqqA=
Date: Mon, 4 Nov 2019 16:23:39 +0000
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
	bjorn.andersson@linaro.org, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
	Stephen Boyd <swboyd@chromium.org>,
	Vivek Gautam <vivek.gautam@codeaurora.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCHv7 0/3] QCOM smmu-500 wait-for-safe handling for sdm845
Message-ID: <20191104162339.GD24909@willie-the-truck>
References: <cover.1568966170.git.saiprakash.ranjan@codeaurora.org>
	<20191101163136.GC3603@willie-the-truck>
	<af7e9a14ae7512665f0cae32e08c8b06@codeaurora.org>
	<20191101172508.GB3983@willie-the-truck>
	<119d4bcf5989d1aa0686fd674c6a3370@codeaurora.org>
	<20191104051925.GC5299@hector.lan>
	<20191104151506.GB24909@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191104151506.GB24909@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Mon, Nov 04, 2019 at 03:15:06PM +0000, Will Deacon wrote:
> On Sun, Nov 03, 2019 at 11:19:25PM -0600, Andy Gross wrote:
> > On Fri, Nov 01, 2019 at 11:01:59PM +0530, Sai Prakash Ranjan wrote:
> > > >>> What's the plan for getting this merged? I'm not happy taking the
> > > >>> firmware
> > > >>> bits without Andy's ack, but I also think the SMMU changes should go via
> > > >>> the IOMMU tree to avoid conflicts.
> > > >>>
> > > >>> Andy?
> > > >>>
> > > >>
> > > >>Bjorn maintains QCOM stuff now if I am not wrong and he has already
> > > >>reviewed
> > > >>the firmware bits. So I'm hoping you could take all these through IOMMU
> > > >>tree.
> > > >
> > > >Oh, I didn't realise that. Is there a MAINTAINERS update someplace? If I
> > > >run:
> > > >
> > > >$ ./scripts/get_maintainer.pl -f drivers/firmware/qcom_scm-64.c
> > > >
> > > >in linux-next, I get:
> > > >
> > > >Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
> > > >linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
> > > >linux-kernel@vger.kernel.org (open list)
> > > >
> > > 
> > > It hasn't been updated yet then. I will leave it to Bjorn or Andy to comment
> > > on this.
> > 
> > The rumors of my demise have been greatly exaggerated.  All kidding aside, I
> > ack'ed both.  Bjorn will indeed be coming on as a co-maintener at some point.
> > He has already done a lot of yeomans work in helping me out the past 3 months.
> 
> Cheers Andy, and I'm pleased to hear that you're still with us! I've queued
> this lot for 5.5 and I'll send to Joerg this week.

Bah, in doing so I spotted that the existing code doesn't handle error codes
properly because 'a0' is unsigned. I'll queue the patch below at the start
of the series.

Will

--->8

From a9a1047f08de0eff249fb65e2d5d6f6f8b2a87f0 Mon Sep 17 00:00:00 2001
From: Will Deacon <will@kernel.org>
Date: Mon, 4 Nov 2019 15:58:15 +0000
Subject: [PATCH] firmware: qcom: scm: Ensure 'a0' status code is treated as
 signed

The 'a0' member of 'struct arm_smccc_res' is declared as 'unsigned long',
however the Qualcomm SCM firmware interface driver expects to receive
negative error codes via this field, so ensure that it's cast to 'long'
before comparing to see if it is less than 0.

Cc: <stable@vger.kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/firmware/qcom_scm-64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
index 91d5ad7cf58b..25e0f60c759a 100644
--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-64.c
@@ -150,7 +150,7 @@ static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
 		kfree(args_virt);
 	}
 
-	if (res->a0 < 0)
+	if ((long)res->a0 < 0)
 		return qcom_scm_remap_error(res->a0);
 
 	return 0;
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
