Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCCCC433EF
	for <iommu@archiver.kernel.org>; Thu, 19 May 2022 10:37:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26A86419C5;
	Thu, 19 May 2022 10:37:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GgNY5KSgdauy; Thu, 19 May 2022 10:37:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D09BF419A4;
	Thu, 19 May 2022 10:37:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB6B3C0039;
	Thu, 19 May 2022 10:37:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27855C002D
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 10:37:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F41C460E9D
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 10:37:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VkFev-FD85a6 for <iommu@lists.linux-foundation.org>;
 Thu, 19 May 2022 10:37:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 49BBC60E4E
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 10:37:52 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id v65so5929247oig.10
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 03:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=91RlCk313r8m40bIa9yHP69AdJe8s0O90hAGX9tfpQo=;
 b=IGROSZ9snA0E8moJpPnXXlZ+dVvo7Pn7LrcuG45gT2NMj0Ft/xuwojMxSci6m30Tpb
 /+VVqblq/P9RPYJr4EEmwIU97Qi6+E+yf3v4QCvn8OqlhyIAXXcNOcV5K4t6/w4G1uvM
 uEmQnlU2XcVwe/ZGt0z1yg6STGpDIjMg+qPFFfwAsg3K2NKtCuJW7jvqlLXGNCoahT2/
 NGDeqP7vUbd8MLT7ZPqZUmIwLxHVVF9dSSXYfUoUhTPDYL5mcFXQX1Q8mdpM0FckoFoE
 qBh+ed3PA9GGqzt4MmB7FjdMVUAOtRNTf7o+LN2mg0u/lZBWQ3NWKmSwIfUjvW2WYtQQ
 8dnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=91RlCk313r8m40bIa9yHP69AdJe8s0O90hAGX9tfpQo=;
 b=oD8VBa117LPm0S7BKpLdpUXe0vTnTXyQkGq5OmS56Y5uYcCJ/pRx9QFOG8qlkC9KEg
 Oc7nIKQJXJCNLTJM8fRP8DhTPdP7lrSBb56uCTxfMZmw/H9IOxFKLMA6GldeGnI44UHR
 zBJMAPp2C/GwqEAJsLRSM8x0H7ss4W319/ogGFZEIsNmNeOSjYujHKnbpkP4gBalaAjC
 mC83XFV3PIEh/1Occzv7yHfaKLoVhrnm0p7n40CTJmd/GtbI25DJDN93nw4wIpuu7Czi
 2ByoPeHUy4IISXZvSlTUPlIbA08tvGz/A7SWqoidRlxTz9WG+YifGNCa++HHd7TeS9h3
 +SAg==
X-Gm-Message-State: AOAM533IUcCwMknRkgEVc3+XBRLhaw3m0Erma8Wn6NEgZAK6Yt3CUUIB
 oD0rMi4028ckOhSifgZMlhC0lA==
X-Google-Smtp-Source: ABdhPJzWa11doL7m+tx0uyc5KHyJXn8YmWpHNRBuh1zqQCcw7Ad9yphafujN9GeExD/pkeAAoJznEw==
X-Received: by 2002:a54:4513:0:b0:325:5f69:19ea with SMTP id
 l19-20020a544513000000b003255f6919eamr2197507oil.111.1652956671191; 
 Thu, 19 May 2022 03:37:51 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 i62-20020aca3b41000000b00325cda1ff8esm1726727oia.13.2022.05.19.03.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 May 2022 03:37:50 -0700 (PDT)
Date: Thu, 19 May 2022 11:37:23 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v7 01/10] iommu: Add pasids field in struct iommu_device
Message-ID: <YoYd43JFXJcqngby@myrica>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220519072047.2996983-2-baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
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

Hi Baolu,

On Thu, May 19, 2022 at 03:20:38PM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 88817a3376ef..6e2cd082c670 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3546,6 +3546,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  	/* SID/SSID sizes */
>  	smmu->ssid_bits = FIELD_GET(IDR1_SSIDSIZE, reg);
>  	smmu->sid_bits = FIELD_GET(IDR1_SIDSIZE, reg);
> +	smmu->iommu.pasids = smmu->ssid_bits;

This should be 1UL << smmu->ssid_bits

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
