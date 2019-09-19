Return-Path: <SRS0=51CA=XO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBE2C49ED7
	for <iommu@archiver.kernel.org>; Thu, 19 Sep 2019 20:00:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DABE2053B
	for <iommu@archiver.kernel.org>; Thu, 19 Sep 2019 20:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G1NZg1so"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DABE2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 044A5C3E;
	Thu, 19 Sep 2019 20:00:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BBD85C3A
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 20:00:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
	[209.85.210.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 61A6F86E
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 20:00:53 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id b128so3018794pfa.1
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 13:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=message-id:mime-version:content-transfer-encoding:in-reply-to
	:references:cc:to:from:subject:user-agent:date;
	bh=9iE/fQwbEI86AAV9fsy+eA8BJHdmoZczt8XRdjCLHVg=;
	b=G1NZg1so9GgzKFvCHvGKBM6Uc4u9SKeSlJSkKxRygJVib/OfcZHo2nZFnsvMQCGhKs
	zycvLxKiQtN/TrkUGZwgdntuLhr6vO5k3GEAD9K3Xfru0BX8RkKNsO9BFGf35dgqR5FN
	Z6pEiyu730ZfZOy9JH94iiwYN4KD5MkuQb92I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:mime-version
	:content-transfer-encoding:in-reply-to:references:cc:to:from:subject
	:user-agent:date;
	bh=9iE/fQwbEI86AAV9fsy+eA8BJHdmoZczt8XRdjCLHVg=;
	b=cCxYTVr2i+0Lul0JitbbqBMm/QXzFUjGebySnnd7pcivuofLSLHHYXhbwRj1mZs6lI
	FURqK8Ssm7FIA1Vo0UdJe3vi+S51hL9LpSfdUYECj5OW60Yv8KHCA3ey6HaYEJo76zqv
	d409FmE1i23DWdUXHvugps8aLm5GQHE2Q/A3Rn+RFg2FYQ0XH4spiVYdABzngDhaZ8m/
	mYLWU3Gk2AY1bXwpzCMIWnnYdbRShvsek1cM/+/qqPrKTUXF9wnbs+cwxGJ3/edPLbDd
	SjMZp/0sU4Q4UIMsly8dJcEoxy0SIa43/il0PX4Mq9P3smWMSfpRfC4MmYtd8dq+UDLU
	Lv/A==
X-Gm-Message-State: APjAAAW/2NW+IdQOjPFrImPOCOtwixfNANgJQSjUi3XUO6q8+KKP/NuI
	9c/JrHrQdVnEp3v4WbvmtpuVgQ==
X-Google-Smtp-Source: APXvYqwblG8awSx8tqE4wTapKOkBur/6RwrbMVL74XUWHvi/ehVchoyA2iAuuT8W5diexnCOtr3PpQ==
X-Received: by 2002:a62:cf82:: with SMTP id
	b124mr12123966pfg.159.1568923252840; 
	Thu, 19 Sep 2019 13:00:52 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
	by smtp.gmail.com with ESMTPSA id
	r28sm13572503pfg.62.2019.09.19.13.00.51
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 19 Sep 2019 13:00:52 -0700 (PDT)
Message-ID: <5d83de74.1c69fb81.71c0f.f162@mx.google.com>
MIME-Version: 1.0
In-Reply-To: <081fff2f5dacfa7b6f5df6364f088045@codeaurora.org>
References: <cover.1568712606.git.saiprakash.ranjan@codeaurora.org>
	<1513424ecec891d19c1aa3c599ec67db7964b6b2.1568712606.git.saiprakash.ranjan@codeaurora.org>
	<20190919002501.GA20859@builder>
	<a45e8fb6fe1a8cc914fedbfac65af009@codeaurora.org>
	<081fff2f5dacfa7b6f5df6364f088045@codeaurora.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
	Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCHv6 3/3] iommu: arm-smmu-impl: Add sdm845 implementation hook
User-Agent: alot/0.8.1
Date: Thu, 19 Sep 2019 13:00:51 -0700
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
	Will Deacon <will@kernel.org>, linux-arm-msm-owner@vger.kernel.org
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

Quoting Sai Prakash Ranjan (2019-09-19 11:54:27)
> On 2019-09-19 08:48, Sai Prakash Ranjan wrote:
> > On 2019-09-19 05:55, Bjorn Andersson wrote:
> >> In the transition to this new design we lost the ability to
> >> enable/disable the safe toggle per board, which according to Vivek
> >> would result in some issue with Cheza.
> >> 
> >> Can you confirm that this is okay? (Or introduce the DT property for
> >> enabling the safe_toggle logic?)
> >> 
> > 
> > Hmm, I don't remember Vivek telling about any issue on Cheza because
> > of this logic.
> > But I will test this on Cheza and let you know.
> > 
> 
> I tested this on Cheza and no perf degradation nor any other issue is 
> seen
> atleast openly, although I see this below stack dump always with 
> cant_sleep change added.

The usage of cant_sleep() here is wrong then, and the comment should be
removed from the scm API as well because it looks like it's perfectly OK
to call the function from a context that can sleep.

> 
> [    5.048860] BUG: assuming atomic context at 
> /mnt/host/source/src/third_party/kernel/v5.3/drivers/firmware/qcom_scm-64.c:206
> [    5.060303] in_atomic(): 0, irqs_disabled(): 0, pid: 1, name: 
> swapper/0
> [    5.067118] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.3.0 #102
> [    5.073299] Hardware name: Google Cheza (rev3+) (DT)
> [    5.078416] Call trace:
> [    5.080953]  dump_backtrace+0x0/0x16c
> [    5.084727]  show_stack+0x20/0x2c
> [    5.088156]  dump_stack+0x90/0xcc
> [    5.091585]  __cant_sleep+0xb4/0xc4
> [    5.095192]  __qcom_scm_qsmmu500_wait_safe_toggle+0x5c/0xa0
> [    5.100929]  qcom_scm_qsmmu500_wait_safe_toggle+0x28/0x34
> [    5.106491]  qcom_sdm845_smmu500_reset+0x24/0x50
> [    5.111249]  arm_smmu_device_reset+0x1a4/0x25c
> [    5.115827]  arm_smmu_device_probe+0x418/0x50c
> [    5.120406]  platform_drv_probe+0x90/0xb0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
