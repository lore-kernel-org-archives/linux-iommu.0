Return-Path: <SRS0=FRM4=CU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FD9C433E2
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 08:28:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A91221E3
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 08:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P2E1Q5s1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="klbQWUjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A91221E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 183ED87705;
	Fri, 11 Sep 2020 08:28:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xMmrvYaCCihW; Fri, 11 Sep 2020 08:28:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 963C287701;
	Fri, 11 Sep 2020 08:28:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80F0BC0859;
	Fri, 11 Sep 2020 08:28:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5F05C0051
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 08:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D4BA8859D2
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 08:28:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lUog3Zl6-d2I for <iommu@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 08:28:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from a27-55.smtp-out.us-west-2.amazonses.com
 (a27-55.smtp-out.us-west-2.amazonses.com [54.240.27.55])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7A8EB85932
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 08:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599812908;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
 bh=AF0aaEeeABMRiaod41CZl6nU6jmhklN/FTm5KGi6onI=;
 b=P2E1Q5s1//2GPCGu67PMUFj+sYHkSiYTOiAa6UOyYaSZQWBaMLEWLaTxBxRDZ4mC
 GcI65NMOy4Eq06DC3XS9iwyT3rMWc6X5PonxDI0Fjz1ML3+PpQKdlL6zgbBj9PAZyy2
 WITDsk7bKXZdRKw8JRfEnoQ2XFSvrJPcolFqU6s4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599812908;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
 bh=AF0aaEeeABMRiaod41CZl6nU6jmhklN/FTm5KGi6onI=;
 b=klbQWUjjOfvBqiVzFoZAsIgVgB8wBWSPlbTpU6aSU5cwSnJAE15hHpY5GtLBy5dB
 ponTxiMqgHpblR0EoCX/YoQ0QXIKfZptxVCHAW3uzGqdprVhY/iO/af1sX9MoAvagMQ
 bIdN0wQLZ3t8nXoTELrB33L5ZYO0BokWUf3PSBvA=
MIME-Version: 1.0
Date: Fri, 11 Sep 2020 08:28:28 +0000
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v3 7/8] iommu/arm-smmu: Provide helper for allocating
 identity domain
In-Reply-To: <20200904155513.282067-8-bjorn.andersson@linaro.org>
References: <20200904155513.282067-1-bjorn.andersson@linaro.org>
 <20200904155513.282067-8-bjorn.andersson@linaro.org>
Message-ID: <010101747c47b44c-8b3792e0-31a2-4256-b8bd-efa847bedfef-000000@us-west-2.amazonses.com>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.11-54.240.27.55
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
> Some platform implementations needs to be able to allocate a domain for
> emulating identity mappings using a context bank without translation.
> Provide a helper function to allocate such a domain.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 

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
