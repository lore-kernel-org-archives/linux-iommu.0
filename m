Return-Path: <SRS0=FRM4=CU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5846C43461
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 08:21:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32BA7206B7
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 08:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OmawdcbI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Tz4iTmSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32BA7206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DE55787403;
	Fri, 11 Sep 2020 08:21:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o3hv1NV3Jam6; Fri, 11 Sep 2020 08:21:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 69A928730E;
	Fri, 11 Sep 2020 08:21:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46799C0859;
	Fri, 11 Sep 2020 08:21:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1291EC0051
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 08:21:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EFD1820780
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 08:21:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vYStt2FgX4AA for <iommu@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 08:21:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from a27-11.smtp-out.us-west-2.amazonses.com
 (a27-11.smtp-out.us-west-2.amazonses.com [54.240.27.11])
 by silver.osuosl.org (Postfix) with ESMTPS id 1937520488
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 08:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599812509;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
 bh=qsGVIC41HDalGoHN3eDwDtBTI6dMXbAdP5OWRu78vaU=;
 b=OmawdcbIQKrj7Wdd2ph/uWF7qvIPOgqm5YF38xXCcMpmiaMa+QUCuu99x4/mw3et
 Wr7PWpevHFXvuVlWuDDc0cBWsNVpOpsoEGHikaZv7z+yqrgYVxxzUPZUxCB9KbEhNAm
 UQQE43BoVX8TJ0mxmzdopbSOct1pE+3v40rr0kCI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599812509;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
 bh=qsGVIC41HDalGoHN3eDwDtBTI6dMXbAdP5OWRu78vaU=;
 b=Tz4iTmSbQSTev/nw1FXGn3P3EKPOE1y4x537ajUzK11HVXFF5gcctv9islOs0PQ5
 WbSxhYnT30WACpNs6Xi0ZmW52yYQPqc6HfkAizHwXvXnWAu7TE9ZVHscw9PeymVYMkw
 LgXoKPpeS4G4a/kQ/clEOrYOrsosGtHr3g4SgHl8=
MIME-Version: 1.0
Date: Fri, 11 Sep 2020 08:21:49 +0000
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v3 3/8] iommu/arm-smmu: Consult context bank allocator for
 identify domains
In-Reply-To: <20200904155513.282067-4-bjorn.andersson@linaro.org>
References: <20200904155513.282067-1-bjorn.andersson@linaro.org>
 <20200904155513.282067-4-bjorn.andersson@linaro.org>
Message-ID: <010101747c419f77-892093cb-dd9f-4db4-8337-8f2b695882ae-000000@us-west-2.amazonses.com>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.11-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Cc: Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Sibi Sankar <sibis@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On 2020-09-04 21:25, Bjorn Andersson wrote:
> For implementations of the ARM SMMU where stream mappings of bypass 
> type
> are prohibited identity domains can be implemented by using context
> banks with translation disabled.
> 
> Postpone the decision to skip allocating a context bank until the
> implementation specific context bank allocator has been consulted and 
> if
> it decides to use a context bank for the identity map, don't enable
> translation (i.e. omit ARM_SMMU_SCTLR_M).
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 

Minor nit in the subject: identify -> identity

Reviewed-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
