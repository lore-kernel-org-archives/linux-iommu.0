Return-Path: <SRS0=MQAj=7J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7026FC433DF
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 09:39:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35EFA207E8
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 09:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WXjQEVV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EFA207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 20A8887E6E;
	Wed, 27 May 2020 09:39:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vgNSNRWspEh9; Wed, 27 May 2020 09:39:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8CF3887FB5;
	Wed, 27 May 2020 09:39:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64C88C088D;
	Wed, 27 May 2020 09:39:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4424FC016F
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 09:39:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2CA9086C2D
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 09:39:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mN0YJylSGvrU for <iommu@lists.linux-foundation.org>;
 Wed, 27 May 2020 09:39:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4525E86C15
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 09:39:05 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id r15so2347386wmh.5
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 02:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ma4u4XMWVxhpm3lD4oFGEfaNlly6DyjC8Gxwotb9TKs=;
 b=WXjQEVV83bRPYCR6LgwSP7gKE0qWLHR4Mnqw7P8noGQQ24OMhB75T8jRtIYlWMpWHY
 MySHznY6zRSBwHKVYmHsysbE+174PlXCVINNqJQjYg/72BEdEN0K/YKDNyN2QBDIuFxt
 R0Oq37rjAYoXARsBmbhgrlZSfqvOCc9gdGAOg9wpUOynvLbCDDIhxm3cCxh1xAWM53Kj
 /qMG3/aahORuZGKeMGZO2hruY7t1qM0Ejp5rLqR+i+9f80Efp9dXuIIn0b0rnCOeFxCi
 Q4RCOaOgvO5K4/5OBdHDdj2Yo2pvfTSwcO3cdr45feco2zONM3j9uMw4Ntt8RCKXreoL
 IzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ma4u4XMWVxhpm3lD4oFGEfaNlly6DyjC8Gxwotb9TKs=;
 b=D0/V1i71mEIUSXEWwbP8/oawQ4kOkmd6Z2Inamq3HshqAH+1DCNDgRQXa3ElSW45oY
 nNSKAE9CUQm3wxDb1KrFPliyXa0f9OuM3+IZkGt9eqMi/RQbfabqgJBcPf523pdjGyxs
 TnoIQWTg8ZlTaavgzwky1wAU9SJ4VQz/YXDAtgE6UH41UvgZ6jnPZD9PbGCtT5tT7w5s
 Fnj3umMpfLnVK0h94MVKC1RCMo2SGIBlDAnrbZ9QDM81n+PQObGtwKLkPv0lIRs2RtXQ
 fo60Vacxmfxn3mm07NNtuSiVYvMa2QS7RwcZoj0h4Rx5Y/bMvxmqAcpO9SlpPLr4pITe
 pWgg==
X-Gm-Message-State: AOAM531XEVl9kwuxM3IKJCko/lCE7VJ7y4lXJtFF7ZTAbpDoZ2U8OVGO
 u7d6n66gXLgzXzngmUCetejr1Q==
X-Google-Smtp-Source: ABdhPJwRHl1VsOw+wNkIidN7cnKb04trFlt4YsFqaYnPmLrEQw89lrhHnt4yDc5lSDmieVnQqqyCXA==
X-Received: by 2002:a1c:b354:: with SMTP id c81mr3432193wmf.136.1590572343528; 
 Wed, 27 May 2020 02:39:03 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id h20sm2275362wma.6.2020.05.27.02.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 02:39:03 -0700 (PDT)
Date: Wed, 27 May 2020 11:38:52 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, joro@8bytes.org, bhelgaas@google.com
Subject: Re: [PATCH v2 0/4] PCI, iommu: Factor 'untrusted' check for ATS
 enablement
Message-ID: <20200527093852.GC265288@myrica>
References: <20200520152201.3309416-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200520152201.3309416-1-jean-philippe@linaro.org>
Cc: ashok.raj@intel.com, will@kernel.org, hch@infradead.org,
 alex.williamson@redhat.com, robin.murphy@arm.com, dwmw2@infradead.org
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

Hi Joerg, Bjorn,

On Wed, May 20, 2020 at 05:21:59PM +0200, Jean-Philippe Brucker wrote:
> IOMMU drivers currently check themselves if a device is untrusted
> (plugged into an external-facing port) before enabling ATS. Move the
> check to drivers/pci. The only functional change should be to the AMD
> IOMMU driver. With this change all IOMMU drivers block 'Translated' PCIe
> transactions and Translation Requests from untrusted devices.

This seems ready for v5.8. I guess it could go through the IOMMU tree
since there are a little more IOMMU changes?

Thanks,
Jean
> 
> Since v1 [1] I added tags, addressed comments on patches 1 and 3, and
> fixed a regression in patch 3.
> 
> [1] https://lore.kernel.org/linux-iommu/20200515104359.1178606-1-jean-philippe@linaro.org/
> 
> Jean-Philippe Brucker (4):
>   PCI/ATS: Only enable ATS for trusted devices
>   iommu/amd: Use pci_ats_supported()
>   iommu/arm-smmu-v3: Use pci_ats_supported()
>   iommu/vt-d: Use pci_ats_supported()
> 
>  include/linux/pci-ats.h     |  3 +++
>  drivers/iommu/amd_iommu.c   | 12 ++++--------
>  drivers/iommu/arm-smmu-v3.c | 20 +++++++-------------
>  drivers/iommu/intel-iommu.c |  9 +++------
>  drivers/pci/ats.c           | 18 +++++++++++++++++-
>  5 files changed, 34 insertions(+), 28 deletions(-)
> 
> -- 
> 2.26.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
