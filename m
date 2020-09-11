Return-Path: <SRS0=FRM4=CU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E729C433E2
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 08:18:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E92C0221E3
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 08:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WW3OvRjH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Jv3aVm0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92C0221E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7224985E9B;
	Fri, 11 Sep 2020 08:18:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C_UBpklRRKZp; Fri, 11 Sep 2020 08:18:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6AF4285640;
	Fri, 11 Sep 2020 08:18:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3667BC0859;
	Fri, 11 Sep 2020 08:18:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 681AFC0051
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 08:18:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5345E877C1
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 08:18:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dfrS21llXEww for <iommu@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 08:18:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from a27-11.smtp-out.us-west-2.amazonses.com
 (a27-11.smtp-out.us-west-2.amazonses.com [54.240.27.11])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A93C8877B2
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 08:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599812325;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
 bh=HSaJciWnCPvyHhxhEaupZz5L45ElMcl2+afaqaEiPDE=;
 b=WW3OvRjH9YCPQBNSIpGypLqN/LHGYs4sgtn3FPDrnHm6SyiyHTGLGpKJkeYOMC/x
 +1WD4cbP5i3heRhMjx8hlYuFvwa2qmZ8IzlUJMw++Wh81SCCWD+frRG+cst2OA1jFjp
 vHBn7dxxxdQEE8cpfuVAd5CLMxTamutSe+z+FojA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599812325;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
 bh=HSaJciWnCPvyHhxhEaupZz5L45ElMcl2+afaqaEiPDE=;
 b=Jv3aVm0qVZ83i4QlWkoTANuYbdDkmIksfQ/8p7AZ2HNeq/wP6qGAMZ8WIH2A4Z2/
 WonsXUlmsO3yCZZt2116Z/EP5UJDB9j6Der4rWybNeLOWvKqF7bUkvrZxHEmu0WLNMF
 6Na/y7n9TOVF1U5B1Xm1VdbnYQhUNYwOrlxSRD0k=
MIME-Version: 1.0
Date: Fri, 11 Sep 2020 08:18:45 +0000
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v3 1/8] iommu/arm-smmu: Refactor context bank allocation
In-Reply-To: <20200904155513.282067-2-bjorn.andersson@linaro.org>
References: <20200904155513.282067-1-bjorn.andersson@linaro.org>
 <20200904155513.282067-2-bjorn.andersson@linaro.org>
Message-ID: <010101747c3ece1b-c0a1bdaf-73e7-4927-894c-6c0ea90322dd-000000@us-west-2.amazonses.com>
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
> Extract the conditional invocation of the platform defined
> alloc_context_bank() to a separate function to keep
> arm_smmu_init_domain_context() cleaner.
> 
> Instead pass a reference to the arm_smmu_device as parameter to the
> call. Also remove the count parameter, as this can be read from the
> newly passed object.
> 
> This allows us to not assign smmu_domain->smmu before attempting to
> allocate the context bank and as such we don't need to roll back this
> assignment on failure.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

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
