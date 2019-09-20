Return-Path: <SRS0=xPYy=XP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59C2C3A5A2
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 21:07:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C2342080F
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 21:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b2M0SMWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2342080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 37AFADCE;
	Fri, 20 Sep 2019 21:07:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D59B6D89
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 21:07:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
	[209.85.210.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 48B80711
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 21:07:30 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id y72so5294169pfb.12
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 14:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=message-id:mime-version:content-transfer-encoding:in-reply-to
	:references:cc:to:from:subject:user-agent:date;
	bh=lPIgzmO/aPJJEw9pL/CRSzhyVtzs0JpO8UpzUFEOaBQ=;
	b=b2M0SMWw96aMNTsOlmWo8NW6A6GBgxj00yVxoie2lvcFcImFjACQ5a6NVxXmBr1fZ3
	KcXfxvujifhSx74q2XGy3QX2C1PtePSqzBOgzegWIMspO1BvCQI3jqQ1F9mHe79PHfyw
	kXiu5/W/2czx7NlzaTVvv774NlIsaW+Tu0Bto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:mime-version
	:content-transfer-encoding:in-reply-to:references:cc:to:from:subject
	:user-agent:date;
	bh=lPIgzmO/aPJJEw9pL/CRSzhyVtzs0JpO8UpzUFEOaBQ=;
	b=oErNuXDv0E0+Jzu4vfD2q/hEck8BFUE4kCoAU45+LNnUGxNX9FebOnBcXfoInyxYCT
	ge0w0NuVi3gI8L3gcpJ6P6D2bodsA6rjwVa1cZ+cxQoUSflx8e+rIWtAWmp15BbwF/T7
	INgxTmi8Gzws/WoB1UlFuC0LHo96CMDNJCA97K9depSuiw1l2bkjMOMNux73gja1y4ST
	QJCwAQwEgtSP6wz0djPIsN7re/DXlp0Cd0Ap5D/6Uj0EjzGZGzuc1ubM+mGx762uHIc0
	E+ZoD29aqvpw6aujmfdanEcemuP6KgvnNDoYC4S4FLMoSrhA5v4aZ4pdOEIVgsMrigpz
	6eaQ==
X-Gm-Message-State: APjAAAXWJA1+NqC77RpZJFL8PuMoQEr2VDr0GMY8wilA12BNX2Q5n1lE
	TOITo1y+0VcVNk6rDj9Wct6p1A==
X-Google-Smtp-Source: APXvYqyAWN51mb5bwvg5tMBgXdaWqe6d1zPHJiWwX3nmpCkKnqqQBzcRed7PrS5FMAE8YAwI65K7Cg==
X-Received: by 2002:a62:e21a:: with SMTP id a26mr20135657pfi.80.1569013649984; 
	Fri, 20 Sep 2019 14:07:29 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
	by smtp.gmail.com with ESMTPSA id
	a11sm3742571pfg.94.2019.09.20.14.07.29
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 20 Sep 2019 14:07:29 -0700 (PDT)
Message-ID: <5d853f91.1c69fb81.a630b.98dd@mx.google.com>
MIME-Version: 1.0
In-Reply-To: <3ed0de38b57fda1995d0f231cbcec38c16387a2a.1568966170.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1568966170.git.saiprakash.ranjan@codeaurora.org>
	<3ed0de38b57fda1995d0f231cbcec38c16387a2a.1568966170.git.saiprakash.ranjan@codeaurora.org>
To: Andy Gross <agross@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
	Vivek Gautam <vivek.gautam@codeaurora.org>,
	Will Deacon <will@kernel.org>, bjorn.andersson@linaro.org,
	iommu@lists.linux-foundation.org
From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCHv7 3/3] iommu: arm-smmu-impl: Add sdm845 implementation hook
User-Agent: alot/0.8.1
Date: Fri, 20 Sep 2019 14:07:28 -0700
Cc: linux-arm-msm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
	linux-kernel@vger.kernel.org
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

Quoting Sai Prakash Ranjan (2019-09-20 01:04:29)
> From: Vivek Gautam <vivek.gautam@codeaurora.org>
> 
> Add reset hook for sdm845 based platforms to turn off
> the wait-for-safe sequence.
> 
> Understanding how wait-for-safe logic affects USB and UFS performance
> on MTP845 and DB845 boards:
> 
> Qcom's implementation of arm,mmu-500 adds a WAIT-FOR-SAFE logic
> to address under-performance issues in real-time clients, such as
> Display, and Camera.
> On receiving an invalidation requests, the SMMU forwards SAFE request
> to these clients and waits for SAFE ack signal from real-time clients.
> The SAFE signal from such clients is used to qualify the start of
> invalidation.
> This logic is controlled by chicken bits, one for each - MDP (display),
> IFE0, and IFE1 (camera), that can be accessed only from secure software
> on sdm845.
> 
> This configuration, however, degrades the performance of non-real time
> clients, such as USB, and UFS etc. This happens because, with wait-for-safe
> logic enabled the hardware tries to throttle non-real time clients while
> waiting for SAFE ack signals from real-time clients.
> 
> On mtp845 and db845 devices, with wait-for-safe logic enabled by the
> bootloaders we see degraded performance of USB and UFS when kernel
> enables the smmu stage-1 translations for these clients.
> Turn off this wait-for-safe logic from the kernel gets us back the perf
> of USB and UFS devices until we re-visit this when we start seeing perf
> issues on display/camera on upstream supported SDM845 platforms.
> The bootloaders on these boards implement secure monitor callbacks to
> handle a specific command - QCOM_SCM_SVC_SMMU_PROGRAM with which the
> logic can be toggled.
> 
> There are other boards such as cheza whose bootloaders don't enable this
> logic. Such boards don't implement callbacks to handle the specific SCM
> call so disabling this logic for such boards will be a no-op.
> 
> This change is inspired by the downstream change from Patrick Daly
> to address performance issues with display and camera by handling
> this wait-for-safe within separte io-pagetable ops to do TLB
> maintenance. So a big thanks to him for the change and for all the
> offline discussions.
> 
> Without this change the UFS reads are pretty slow:
> $ time dd if=/dev/sda of=/dev/zero bs=1048576 count=10 conv=sync
> 10+0 records in
> 10+0 records out
> 10485760 bytes (10.0MB) copied, 22.394903 seconds, 457.2KB/s
> real    0m 22.39s
> user    0m 0.00s
> sys     0m 0.01s
> 
> With this change they are back to rock!
> $ time dd if=/dev/sda of=/dev/zero bs=1048576 count=300 conv=sync
> 300+0 records in
> 300+0 records out
> 314572800 bytes (300.0MB) copied, 1.030541 seconds, 291.1MB/s
> real    0m 1.03s
> user    0m 0.00s
> sys     0m 0.54s
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
