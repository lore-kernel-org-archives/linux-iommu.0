Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3C2C433F5
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 18:28:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6735A60E2B;
	Tue,  3 May 2022 18:28:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vosW9ALH76so; Tue,  3 May 2022 18:28:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 202A1605EA;
	Tue,  3 May 2022 18:28:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFB01C0032;
	Tue,  3 May 2022 18:28:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE073C002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 18:28:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA3FD60625
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 18:28:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y21TBzGp5jHb for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 18:28:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC096605EA
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 18:28:47 +0000 (UTC)
Received: by mail-qk1-x733.google.com with SMTP id b20so11836761qkc.6
 for <iommu@lists.linux-foundation.org>; Tue, 03 May 2022 11:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=iFzlk+xOmTmM/Rg9uDKOcUmWuXtZUa3NXSFCcREp6dA=;
 b=VLAEGb/xxfXFOdK14PjW8BMKhVNfQ2mlyO22SQw42f+1nio4diX27liKNCU1qxLzyC
 W0pcdAVCm0R4VvXyf73HIBA2IdvUlbsG2ttkPo32xoY6eQNDthM0yl3R4uERQqzJocY0
 34ETDcQKarsLbshXTn5fp6uf39lflTa/T+RucHDsBjUGxe6pLDfuBBGr8l053CkgFMt9
 MfV88SN6/q00gvOBqTsX64/X3GT7Ra2JzDjgiA0emPTC4jLxHnPuOgF/aUeetZCl9UcE
 Vj1t9uGRHUWVdjq53ySUhVp6X9ba/xhzVZhIpy/yNbmSY6ZY/iqE8Rd314cVAPEjAnJw
 K1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iFzlk+xOmTmM/Rg9uDKOcUmWuXtZUa3NXSFCcREp6dA=;
 b=Nd+ahaTSTyGwFkukTgAgz1ZQ1R5WpcfDl07Bfwg3bY47RJrnOp5x+RPXeQgLWdlYSI
 iOi9GbINbqLKVsK4+LY8b2BsyyCTCfz5xi6pvZQAz24nW4zOn4ZdycsFQ27XZwPk6uMd
 f8PADVMTEeNjpPAqciROpfYXKtFK8KMrOogh532HIGpKC3xUWhz8ZjXfc8Im+6/RxTxX
 OwCcKWVzwfHGEANMop8WIyKlFBivwWMqd7NC/y4don+D8YvNuKduDXt9Q4vbdU9oredl
 AXd/4yYl7vjxnJmGizovb07G1j7x7WzkeQWrnHjoYKl+fvNRFzT1jb0g0SpVfMmQnXpT
 5kiw==
X-Gm-Message-State: AOAM532hx9/Il2Q4b3k2Ii9EnZkHwwKSAyDwANOvJu3U6bYyouxx4nsd
 QsFqYqbcDCe9t8HGNB6IA6gKiA==
X-Google-Smtp-Source: ABdhPJwg5NoW02Rs307zSADt1uOWE4ZSf3AUVJaY1yGF50Rm6gYq2Rh8F9YaWMhdhgT/Sq7hdr36tg==
X-Received: by 2002:a37:f516:0:b0:69f:83cd:f557 with SMTP id
 l22-20020a37f516000000b0069f83cdf557mr13568196qkk.555.1651602526714; 
 Tue, 03 May 2022 11:28:46 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 x19-20020a05620a12b300b0069fc13ce206sm6115930qki.55.2022.05.03.11.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 May 2022 11:28:46 -0700 (PDT)
Date: Tue, 3 May 2022 19:28:19 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 12/12] iommu: Rename iommu-sva-lib.{c,h}
Message-ID: <YnF0QwnndI6opJtb@myrica>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-13-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220502014842.991097-13-baolu.lu@linux.intel.com>
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

On Mon, May 02, 2022 at 09:48:42AM +0800, Lu Baolu wrote:
> Rename iommu-sva-lib.c[h] to iommu-sva.c[h] as it contains all code
> for SVA implementation in iommu core.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/{iommu-sva-lib.h => iommu-sva.h}  | 0
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 2 +-
>  drivers/iommu/intel/iommu.c                     | 2 +-
>  drivers/iommu/intel/svm.c                       | 2 +-
>  drivers/iommu/io-pgfault.c                      | 2 +-
>  drivers/iommu/{iommu-sva-lib.c => iommu-sva.c}  | 2 +-
>  drivers/iommu/Makefile                          | 2 +-
>  8 files changed, 7 insertions(+), 7 deletions(-)
>  rename drivers/iommu/{iommu-sva-lib.h => iommu-sva.h} (100%)
>  rename drivers/iommu/{iommu-sva-lib.c => iommu-sva.c} (99%)
> 
> diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva.h
> similarity index 100%
> rename from drivers/iommu/iommu-sva-lib.h
> rename to drivers/iommu/iommu-sva.h
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 0ace04b27d4b..73a336e17dc8 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -9,7 +9,7 @@
>  #include <linux/slab.h>
>  
>  #include "arm-smmu-v3.h"
> -#include "../../iommu-sva-lib.h"
> +#include "../../iommu-sva.h"
>  #include "../../io-pgtable-arm.h"
>  
>  struct arm_smmu_mmu_notifier {
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 543d3ef1c102..ca2bd17eec41 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -31,7 +31,7 @@
>  #include <linux/amba/bus.h>
>  
>  #include "arm-smmu-v3.h"
> -#include "../../iommu-sva-lib.h"
> +#include "../../iommu-sva.h"
>  
>  static bool disable_bypass = true;
>  module_param(disable_bypass, bool, 0444);
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 46e2eb15197b..b38f50810459 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -27,7 +27,7 @@
>  #include <linux/tboot.h>
>  
>  #include "../irq_remapping.h"
> -#include "../iommu-sva-lib.h"
> +#include "../iommu-sva.h"
>  #include "pasid.h"
>  #include "cap_audit.h"
>  
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 6084f960ba27..38c33cde177e 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -25,7 +25,7 @@
>  
>  #include "pasid.h"
>  #include "perf.h"
> -#include "../iommu-sva-lib.h"
> +#include "../iommu-sva.h"
>  
>  static irqreturn_t prq_event_thread(int irq, void *d);
>  static void intel_svm_drain_prq(struct device *dev, u32 pasid);
> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
> index 8a2bb56e1474..a9ecf6bf5500 100644
> --- a/drivers/iommu/io-pgfault.c
> +++ b/drivers/iommu/io-pgfault.c
> @@ -11,7 +11,7 @@
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
>  
> -#include "iommu-sva-lib.h"
> +#include "iommu-sva.h"
>  
>  /**
>   * struct iopf_queue - IO Page Fault queue
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva.c
> similarity index 99%
> rename from drivers/iommu/iommu-sva-lib.c
> rename to drivers/iommu/iommu-sva.c
> index ae3595d60f38..b631765fa8c0 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -7,7 +7,7 @@
>  #include <linux/slab.h>
>  #include <linux/sched/mm.h>
>  
> -#include "iommu-sva-lib.h"
> +#include "iommu-sva.h"
>  
>  static DEFINE_MUTEX(iommu_sva_lock);
>  static DECLARE_IOASID_SET(iommu_sva_pasid);
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 44475a9b3eea..c1763476162b 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -27,6 +27,6 @@ obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
>  obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
>  obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
>  obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
> -obj-$(CONFIG_IOMMU_SVA) += iommu-sva-lib.o io-pgfault.o
> +obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o io-pgfault.o
>  obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
>  obj-$(CONFIG_APPLE_DART) += apple-dart.o
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
