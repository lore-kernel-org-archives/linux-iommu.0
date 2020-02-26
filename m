Return-Path: <SRS0=g0Sk=4O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DA0C4BA0A
	for <iommu@archiver.kernel.org>; Wed, 26 Feb 2020 07:31:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0C5F2084E
	for <iommu@archiver.kernel.org>; Wed, 26 Feb 2020 07:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z+L1wubO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C5F2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C234D20418;
	Wed, 26 Feb 2020 07:31:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fTraEKQhU8i9; Wed, 26 Feb 2020 07:31:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 610E520417;
	Wed, 26 Feb 2020 07:31:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32B21C08A0;
	Wed, 26 Feb 2020 07:31:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AC40C0177
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 07:31:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6C91220418
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 07:31:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LcR7hoY5H+1p for <iommu@lists.linux-foundation.org>;
 Wed, 26 Feb 2020 07:31:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 8F39B20417
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 07:31:35 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id j7so1589981wrp.13
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 23:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=hxZUYP0cQ4s+D1GPGSIg13NXENyBceeLiQgMnelW0Co=;
 b=Z+L1wubOJ3gGRnqhuT1ZwDooxjKXaCTM3VWsZWLORPJqa9xxtrRYrmREYRwCw2YgO8
 HKl4+knUWCmhZWZozBrcMIJxyqPx5GGSKZnevRzh1xx0OnU/NP6lHxYJfz5lWO3sNl50
 iCRv3J5KH6YTeU5Jc1PD1pzvs4WdjkRnoRVGoOXrX1eH4VtS+U69d210rHLWlJB9C4wQ
 B522/8AkfM69ES4+RnCqMnsj+cefCm9/rN54vriduVWNm+Iro0L+qHn63iB2Y2WutZyr
 PCzo0LYEIiYvMJ4ZOsuGTEbSHq3w9FkXCz6rM11iGmi05xhHj526rEq3R+XF8Vw35qkN
 XvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hxZUYP0cQ4s+D1GPGSIg13NXENyBceeLiQgMnelW0Co=;
 b=uVllJ4gmI2Q1XFivBqLAHIDxVuMefYnnEPH+UMAM8ncoNVvM0Es09Ph/f2fa4B4BGw
 +zBTZNHLDJRAkHT2trxsh3TYxPMDDKlUUipb+Afiuxij8yHpHp4N4d1wCBHIO0PMDeGi
 r2Hr+tg8QcodFsuFftMP9pjpq39BpVUqXY1mLt7nZhEASpel46BmRmghuklwJxjQDLAC
 FhHLFnMWKjvI+4NhqLiNVGo0wM0GFUICbeLFNsKtFKnb1G8HfePAXvPUpk0GHwxk5Q+n
 R3Kbhm9zpsmniQylLVzSVumKeovyaOQafHljJ4aIf7LAaATCR77WfmBk9QpwG5c88fst
 +JzQ==
X-Gm-Message-State: APjAAAWNyEvGDle6SLH9lwMspwUwY0sG2oW+MoKKY5PeI/fZPiGNPRAU
 Np1gmfUoJ+ZrSfcCzyS9kP4eJw==
X-Google-Smtp-Source: APXvYqymA4NRK8kSBnwzL1y5IBNFVoBdWsFFIcv2KQ0MszGN1eA/UpfEau7j9Zkxfu5RLu4gn4+TSw==
X-Received: by 2002:adf:e884:: with SMTP id d4mr3961692wrm.12.1582702293931;
 Tue, 25 Feb 2020 23:31:33 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id t187sm1820680wmt.25.2020.02.25.23.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 23:31:33 -0800 (PST)
Date: Wed, 26 Feb 2020 08:31:27 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] iommu/vt-d: Replace intel SVM APIs with generic SVA
 APIs
Message-ID: <20200226073127.GA438595@myrica>
References: <1582586797-61697-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1582586797-61697-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200225191034.GA29045@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200225191034.GA29045@infradead.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>
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

On Tue, Feb 25, 2020 at 11:10:34AM -0800, Christoph Hellwig wrote:
> On Mon, Feb 24, 2020 at 03:26:37PM -0800, Jacob Pan wrote:
> > This patch is an initial step to replace Intel SVM code with the
> > following IOMMU SVA ops:
> > intel_svm_bind_mm() => iommu_sva_bind_device()
> > intel_svm_unbind_mm() => iommu_sva_unbind_device()
> > intel_svm_is_pasid_valid() => iommu_sva_get_pasid()
> 
> How did either set APIs end up being added to the kernel without users
> to start with?
> 
> Please remove both the old intel and the iommu ones given that neither
> has any users.

The hisilicon crypto accelerator will be using the new API in v5.7
https://lore.kernel.org/linux-iommu/1581407665-13504-1-git-send-email-zhangfei.gao@linaro.org/

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
