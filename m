Return-Path: <SRS0=xf59=C2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705D8C43461
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 14:40:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02BEC206DB
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 14:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pw7lFDe/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BEC206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 645B1273CF;
	Thu, 17 Sep 2020 14:40:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7p2gBI+jxIiX; Thu, 17 Sep 2020 14:40:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 21D4620416;
	Thu, 17 Sep 2020 14:40:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDA2DC0864;
	Thu, 17 Sep 2020 14:40:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0F5CC0051
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 14:40:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9F71F87073
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 14:40:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BgigU45Q1wV3 for <iommu@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 14:40:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F111B87035
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 14:40:46 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id l9so2319678wme.3
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 07:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=NfuxW03LdCfyu123mz8qqvZXszWQ36KrgKMs1l6w+jU=;
 b=Pw7lFDe/iuIFOKG8HYdH0T5Je/lHJcwoYZXd9JsVUQKV0JnlFx1gQvK6qy09NSzZVl
 bu64Hjpgpe3Vrgqerl2AoKKS6qujF4ZdrJiCs96fUkFTfwsIqgl3n1076bGMYkl7rPic
 EZTdHLGhNQt3/MCDeZs0MtaDmIpMfz4WGrsZ2RPDfxdPdoKjg+hpTDDlplZWn0rRjZTd
 tlsEJjZjJdfribTDMoqk8595+MgbWZ0YMJWjMW2rtmx/rqMFkekBUacFxOyB2whcNC1g
 av/vDgbZ7RiwidQqOrcScnyA5dLr2c85iXMLxlSkI37oRlChKVCZGB34ebAakj27c6LZ
 BXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NfuxW03LdCfyu123mz8qqvZXszWQ36KrgKMs1l6w+jU=;
 b=pi7cy2C5UA6hWQMMFYE/0TrKXCU8XaTvPtX4nvR5J/jGj5vHLhndJ6D+97+jHSIMf8
 Yr1KiBgxrcQJzdfevSaPD+H+yQqBUnNCwjtY2oabl7h9x7ThWNSPXYQMhhno8RNdxjkW
 zK15SxP2wvlsdoIagkogmDnC0Nso1/Sm8SEzME+CKJE8LMGWDKQuBEyPtLAmc7AKa4Ti
 7tsxgiCzzh8xz23hFrG12aSY+auZeOD/RDRFWKWrZn3QsJiY9A+i1uMUowbYR+3h/vuj
 D/BNYtPVxm2LCdC55yaV5oHOWyD8H1ZZLlgdq3lWOudnIhJJe2c3w6y5j93BonxA9pLw
 GAQQ==
X-Gm-Message-State: AOAM533JvzCtaEZudRAUXlkly4LcXCjEtRt7hqA8WOm2Ho9VH406951b
 yWgIqCzy4s9QqJM/OYO+cCZRFg==
X-Google-Smtp-Source: ABdhPJyfxHyZxOt4YbdBvfOSV8C72mWMQCAXz9I03AvrY1stShy53TwxJvotM04L539YIqw2stYthA==
X-Received: by 2002:a1c:7716:: with SMTP id t22mr9922760wmi.64.1600353645445; 
 Thu, 17 Sep 2020 07:40:45 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id w21sm11840904wmk.34.2020.09.17.07.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 07:40:44 -0700 (PDT)
Date: Thu, 17 Sep 2020 16:40:25 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH RESEND v9 11/13] iommu/arm-smmu-v3: Add SVA device feature
Message-ID: <20200917144025.GF134903@myrica>
References: <20200817171558.325917-1-jean-philippe@linaro.org>
 <20200817171558.325917-12-jean-philippe@linaro.org>
 <e77d3f31-020c-d5cf-1af2-d584e62112b2@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e77d3f31-020c-d5cf-1af2-d584e62112b2@redhat.com>
Cc: fenghua.yu@intel.com, will@kernel.org, catalin.marinas@arm.com,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org, zhangfei.gao@linaro.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Sep 08, 2020 at 11:46:05AM +0200, Auger Eric wrote:
> Hi Jean,
> 
> On 8/17/20 7:15 PM, Jean-Philippe Brucker wrote:
> > Implement the IOMMU device feature callbacks to support the SVA feature.
> > At the moment dev_has_feat() returns false since I/O Page Faults isn't
> > yet implemented.
> and because we don't advertise BTM, isn't it?

Right, adding it to the commit log

> Besides
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks for the reviews!

Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
