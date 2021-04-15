Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606C6C433B4
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 15:14:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1DB96137D
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 15:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DB96137D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C02E240241;
	Thu, 15 Apr 2021 15:14:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d-JOFJWPkrnO; Thu, 15 Apr 2021 15:14:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id C983B40235;
	Thu, 15 Apr 2021 15:14:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E25DC0014;
	Thu, 15 Apr 2021 15:14:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0ED3EC000B
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 15:14:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E45CA40236
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 15:14:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9nhbse6Y6EWg for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 15:14:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BACE340235
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 15:14:35 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id r9so37406589ejj.3
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=jqtDHjyGp8glZULp1bf2Fq7JNPjH6B0xPTqIRRY0Vf8=;
 b=Su9JjJ2DVw939t0pkGaDodcmBB0LfGVIA7EqtWYA+JDZL6IUJt9WzpYd+TVbmfGDve
 Xkc9Qc/sx3wCD57Q8wezmrLxxOmL+TuVAH5BzBdSAOAeC1i+T5aZpMHxTD2QThxvDVtN
 FAXHpjYdJCn861GPL+yEilgLS3Jpz2bN2Uk/ZDt2SYqWMxe9ar88zoEGdxu1bhEKppM9
 8bqqS4l6VToBIZ1oCDVBICa4D4T/EfL52whwC2FwHEqT4YXTGol3Qdeegdf4qo7UdEF3
 qdcRJRUXT9fzTVuPEiT10aLKkglzTkWbDr3WULjFvShmtcHyMv6QCIok0VlZ+ZjXgidt
 gsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jqtDHjyGp8glZULp1bf2Fq7JNPjH6B0xPTqIRRY0Vf8=;
 b=id4TPZQuyGmPElklMfDrPMpUGfEyHzkg3vhXG1sSESLL+2o6dwJN8fL6sm9GPiATFZ
 96mf1JCFBgE6vJ47p1RiAS/kC9Lq/xHkvkEiZp7tEXwoyv3bkUoMQFlOqmBFuw+qB/0W
 raMMyyPKPbn0yq7UFUdyKW/xXJsqiyS2jGcRvPC5BhlmzBdryL4qagzTLVR/Gw4uLcWA
 iPC/VMYKY3BdJ0ydeUI0lfcIEKZfxn91MQceBMkBR/WEyGCDs8JINJKwzg/TAQGoYhvu
 JnZs3xcke7XN5sI8w2lsuGGRDpIvmoog55e+e7BAJDSf2H+v4PpsqstpZT17x7uEi+ou
 MK1w==
X-Gm-Message-State: AOAM531x63V+FD+GLNckT2FBnb0v+Galnf1V1ufONceB6awrXaEPfUFh
 kioDNA/7bPjerH/L/mk1f3ivrw==
X-Google-Smtp-Source: ABdhPJzHQ/B5VFA6RKe5yV0g+kYRtxE0OHiWFPsrsA4mNSUD1awk9FIgvIDi9Gm/28MC3cEU5uG19A==
X-Received: by 2002:a17:906:6dd9:: with SMTP id
 j25mr3863285ejt.507.1618499673911; 
 Thu, 15 Apr 2021 08:14:33 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id m5sm2783111edi.52.2021.04.15.08.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Apr 2021 08:14:33 -0700 (PDT)
Date: Thu, 15 Apr 2021 17:14:13 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/3] iommu/virtio: Enable x86 support
Message-ID: <YHhYRQlDdCLfmDnf@myrica>
References: <20210316191652.3401335-1-jean-philippe@linaro.org>
 <20210316191652.3401335-4-jean-philippe@linaro.org>
 <2d57860b-8a1c-f345-1105-62680c003fb5@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2d57860b-8a1c-f345-1105-62680c003fb5@arm.com>
Cc: kevin.tian@intel.com, mst@redhat.com, rjw@rjwysocki.net,
 virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com, will@kernel.org,
 lenb@kernel.org
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

On Thu, Mar 18, 2021 at 11:43:38AM +0000, Robin Murphy wrote:
> On 2021-03-16 19:16, Jean-Philippe Brucker wrote:
> > With the VIOT support in place, x86 platforms can now use the
> > virtio-iommu.
> > 
> > The arm64 Kconfig selects IOMMU_DMA, while x86 IOMMU drivers select it
> > themselves.
> 
> Actually, now that both AMD and Intel are converted over, maybe it's finally
> time to punt that to x86 arch code to match arm64?

x86 also has CONFIG_HYPERV_IOMMU that doesn't use IOMMU_DMA, and might not
want to pull in dma-iommu.o + iova.o (don't know if they care about guest
size). There also is the old gart driver, but that doesn't select
IOMMU_SUPPORT. 

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
