Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C97C433F5
	for <iommu@archiver.kernel.org>; Fri, 21 Jan 2022 08:40:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 949A14058A;
	Fri, 21 Jan 2022 08:40:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cgqWk9_cWvnE; Fri, 21 Jan 2022 08:40:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EB35F4034B;
	Fri, 21 Jan 2022 08:40:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5C08C0031;
	Fri, 21 Jan 2022 08:40:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A03EBC002F
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 08:40:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8BFF2404FB
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 08:40:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EDjZdEPsBNGw for <iommu@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 08:40:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2D0364034B
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 08:40:29 +0000 (UTC)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 38BE93FFDE
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 08:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1642754427;
 bh=xUftNJDaok3Pg41c/BkGehEh6TjX1iR0pvhLTmUxMyU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=P0GXHdqDExLS+ftuK8KIM2Pu2KmZACMk45CMAX1CcTrKsHigEmwqjiFpgTajxpyz8
 NI7mkpxH9iXkzqxg44JuUeRf6F2TD7+axU11uw6dTRRg6N05nlA46CARaSjWBUIXeC
 bjSQzKLpLG/pVsRQjusZ4hTCSG5MqzLc4EJi+2MTB2aiyQfkeEKddOwcpNIlWkTMSS
 /hiFmQoJWDzQqxWKdkoCGWWqG2XtENSpnI/22uivqGwtLuA/N5WvUQX1/JU2gd/XFf
 9IxvQKVoberxn2E4i/MWCkiKlX6Eu4poq/wGTrt8IzP0akiq69llIolf9SGKT5fJ2Q
 J5/Khq4DSQt4w==
Received: by mail-ed1-f71.google.com with SMTP id
 o10-20020a056402438a00b00403212b6b1aso8371387edc.13
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 00:40:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=xUftNJDaok3Pg41c/BkGehEh6TjX1iR0pvhLTmUxMyU=;
 b=f+1pF3CWbfT98/uwQRYJ2uA7q1sJzmV5zuM3KlN04WUHgbzdoXBrWezcNTGt79punD
 kzcy/yvixGe3zs93nkfW7aDvXf63nYzGNEIvqMlBGmUXniyXYDHTkrI2P2n+VlYXdaA7
 Q7AJMVLm+s/DN4T8SZwFUNPbrdiAG3dqcsb2eh3adTzpytncPEzi0LSB+cPXKQKTlchL
 JpLwssxZb3OVOsemINHOe+GpTH2bPG32a9l2a8pdG7RCkku3oj2zY9gNpoMkNOLUZIo5
 sFCl/Bry/3YkZ+U3gNjHLJJJV2GtCwhWGXsmRZgUadD2z6s/uFRS0bWzvL5GvpkGRFDB
 z1mg==
X-Gm-Message-State: AOAM530HCESYyVjadlfv39UL7tc0AX4wBdZVzO56C/mMf8+51vNPL5t7
 qeKWPcwKsq85FmbmQG6wpBbpIL8cB/tzfV9JIS68JnO2o+VwT2MkOEi7i9JJHwREYUq+Q5zBSPC
 SOCF6W8il9nxrmY8+ZDVJFrevjVm3s7+duIASzqHSw4gFbTo=
X-Received: by 2002:a05:6402:905:: with SMTP id
 g5mr3321706edz.30.1642754426513; 
 Fri, 21 Jan 2022 00:40:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwUR+qQwnaFqphzLPwNcsoopVP4IbcqehJyUyMLY3yPSHFzVCOe0UwMbO/5cpPjAgxFJA9sQ==
X-Received: by 2002:a05:6402:905:: with SMTP id
 g5mr3321679edz.30.1642754426297; 
 Fri, 21 Jan 2022 00:40:26 -0800 (PST)
Received: from [192.168.0.50] (xdsl-188-155-168-84.adslplus.ch.
 [188.155.168.84])
 by smtp.gmail.com with ESMTPSA id e19sm787750ejl.225.2022.01.21.00.40.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jan 2022 00:40:25 -0800 (PST)
Message-ID: <a111932a-6685-2a9d-abce-87af26b121a4@canonical.com>
Date: Fri, 21 Jan 2022 09:40:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [RFC 2/3] iommu/samsung: Introduce Exynos sysmmu-v8 driver
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <20220120201958.2649-1-semen.protsenko@linaro.org>
 <20220120201958.2649-3-semen.protsenko@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220120201958.2649-3-semen.protsenko@linaro.org>
Cc: Janghyuck Kim <janghyuck.kim@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Carlos Llamas <cmllamas@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-samsung-soc@vger.kernel.org,
 Mark Salyzyn <salyzyn@google.com>, Jinkyu Yang <jinkyu1.yang@samsung.com>,
 Thierry Strudel <tstrudel@google.com>, Will McVicker <willmcvicker@google.com>,
 Cho KyongHo <pullip.cho@samsung.com>, linux-arm-kernel@lists.infradead.org,
 Jonglin Lee <jonglin@google.com>, "J . Avila" <elavila@google.com>,
 Alex <acnwigwe@google.com>, linux-kernel@vger.kernel.org,
 Hyesoo Yu <hyesoo.yu@samsung.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
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

On 20/01/2022 21:19, Sam Protsenko wrote:
> Introduce new driver for modern Exynos ARMv8 SoCs, e.g. Exynos850. Also
> it's used for Google's GS101 SoC.
> 
> This is squashed commit, contains next patches of different authors. See
> `iommu-exynos850-dev' branch for details: [1].
> 
> Original authors (Samsung):
> 
>  - Cho KyongHo <pullip.cho@samsung.com>
>  - Hyesoo Yu <hyesoo.yu@samsung.com>
>  - Janghyuck Kim <janghyuck.kim@samsung.com>
>  - Jinkyu Yang <jinkyu1.yang@samsung.com>
> 
> Some improvements were made by Google engineers:
> 
>  - Alex <acnwigwe@google.com>
>  - Carlos Llamas <cmllamas@google.com>
>  - Daniel Mentz <danielmentz@google.com>
>  - Erick Reyes <erickreyes@google.com>
>  - J. Avila <elavila@google.com>
>  - Jonglin Lee <jonglin@google.com>
>  - Mark Salyzyn <salyzyn@google.com>
>  - Thierry Strudel <tstrudel@google.com>
>  - Will McVicker <willmcvicker@google.com>
> 
> [1] https://github.com/joe-skb7/linux/tree/iommu-exynos850-dev
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/iommu/Kconfig               |   13 +
>  drivers/iommu/Makefile              |    3 +
>  drivers/iommu/samsung-iommu-fault.c |  617 +++++++++++
>  drivers/iommu/samsung-iommu-group.c |   50 +
>  drivers/iommu/samsung-iommu.c       | 1521 +++++++++++++++++++++++++++
>  drivers/iommu/samsung-iommu.h       |  216 ++++
>  6 files changed, 2420 insertions(+)
>  create mode 100644 drivers/iommu/samsung-iommu-fault.c
>  create mode 100644 drivers/iommu/samsung-iommu-group.c
>  create mode 100644 drivers/iommu/samsung-iommu.c
>  create mode 100644 drivers/iommu/samsung-iommu.h
> 

Existing driver supports several different Exynos SysMMU IP block
versions. Several. Please explain why it cannot support one more version?

Similarity of vendor driver with mainline is not an argument.


> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 3eb68fa1b8cc..78e7039f18aa 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -452,6 +452,19 @@ config QCOM_IOMMU
>  	help
>  	  Support for IOMMU on certain Qualcomm SoCs.
>  
> +config SAMSUNG_IOMMU
> +	tristate "Samsung IOMMU Support"
> +	select ARM_DMA_USE_IOMMU
> +	select IOMMU_DMA
> +	select SAMSUNG_IOMMU_GROUP
> +	help
> +	  Support for IOMMU on Samsung Exynos SoCs.
> +
> +config SAMSUNG_IOMMU_GROUP
> +	tristate "Samsung IOMMU Group Support"
> +	help
> +	  Support for IOMMU group on Samsung Exynos SoCs.
> +
>  config HYPERV_IOMMU
>  	bool "Hyper-V x2APIC IRQ Handling"
>  	depends on HYPERV && X86
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index bc7f730edbb0..a8bdf449f1d4 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -27,6 +27,9 @@ obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
>  obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
>  obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
>  obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
> +obj-$(CONFIG_SAMSUNG_IOMMU) += samsung_iommu.o
> +samsung_iommu-objs += samsung-iommu.o samsung-iommu-fault.o
> +obj-$(CONFIG_SAMSUNG_IOMMU_GROUP) += samsung-iommu-group.o
>  obj-$(CONFIG_IOMMU_SVA_LIB) += iommu-sva-lib.o io-pgfault.o
>  obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
>  obj-$(CONFIG_APPLE_DART) += apple-dart.o
> diff --git a/drivers/iommu/samsung-iommu-fault.c b/drivers/iommu/samsung-iommu-fault.c
> new file mode 100644
> index 000000000000..c6b4259976c4
> --- /dev/null
> +++ b/drivers/iommu/samsung-iommu-fault.c
> @@ -0,0 +1,617 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2020 Samsung Electronics Co., Ltd.
> + */
> +
> +#define pr_fmt(fmt) "sysmmu: " fmt
> +
> +#include <linux/smc.h>
> +#include <linux/arm-smccc.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "samsung-iommu.h"
> +
> +#define MMU_TLB_INFO(n)			(0x2000 + ((n) * 0x20))
> +#define MMU_CAPA1_NUM_TLB_SET(reg)	(((reg) >> 16) & 0xFF)
> +#define MMU_CAPA1_NUM_TLB_WAY(reg)	((reg) & 0xFF)
> +#define MMU_CAPA1_SET_TLB_READ_ENTRY(tid, set, way, line)		\
> +					((set) | ((way) << 8) |		\
> +					 ((line) << 16) | ((tid) << 20))
> +
> +#define MMU_TLB_ENTRY_VALID(reg)	((reg) >> 28)
> +#define MMU_SBB_ENTRY_VALID(reg)	((reg) >> 28)
> +#define MMU_VADDR_FROM_TLB(reg, idx)	((((reg) & 0xFFFFC) | ((idx) & 0x3)) << 12)
> +#define MMU_VID_FROM_TLB(reg)		(((reg) >> 20) & 0x7U)
> +#define MMU_PADDR_FROM_TLB(reg)		((phys_addr_t)((reg) & 0xFFFFFF) << 12)
> +#define MMU_VADDR_FROM_SBB(reg)		(((reg) & 0xFFFFF) << 12)
> +#define MMU_VID_FROM_SBB(reg)		(((reg) >> 20) & 0x7U)
> +#define MMU_PADDR_FROM_SBB(reg)		((phys_addr_t)((reg) & 0x3FFFFFF) << 10)
> +
> +#define REG_MMU_INT_STATUS		0x060
> +#define REG_MMU_INT_CLEAR		0x064
> +#define REG_MMU_FAULT_RW_MASK		GENMASK(20, 20)
> +#define IS_READ_FAULT(x)		(((x) & REG_MMU_FAULT_RW_MASK) == 0)
> +
> +#define SYSMMU_FAULT_PTW_ACCESS   0
> +#define SYSMMU_FAULT_PAGE_FAULT   1
> +#define SYSMMU_FAULT_ACCESS       2
> +#define SYSMMU_FAULT_RESERVED     3
> +#define SYSMMU_FAULT_UNKNOWN      4
> +
> +#define SYSMMU_SEC_FAULT_MASK		(BIT(SYSMMU_FAULT_PTW_ACCESS) | \
> +					 BIT(SYSMMU_FAULT_PAGE_FAULT) | \
> +					 BIT(SYSMMU_FAULT_ACCESS))
> +
> +#define SYSMMU_FAULTS_NUM         (SYSMMU_FAULT_UNKNOWN + 1)
> +
> +#if IS_ENABLED(CONFIG_EXYNOS_CONTENT_PATH_PROTECTION)

You just copy-pasted vendor stuff, without actually going through it.

It is very disappointing because instead of putting your own effort, you
expect community to do your job.

What the hell is CONFIG_EXYNOS_CONTENT_PATH_PROTECTION?

I'll stop reviewing. Please work on extending existing driver. If you
submitted something nice and clean, ready for upstream, instead of
vendor junk, you could get away with separate driver. But you did not.
It looks really bad.

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
