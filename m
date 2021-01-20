Return-Path: <SRS0=oIyp=GY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB46CC433E0
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 08:22:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C19D23976
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 08:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C19D23976
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7147E203A0;
	Thu, 21 Jan 2021 08:22:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TpwkNrQdGrz7; Thu, 21 Jan 2021 08:22:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 58A851FE2F;
	Thu, 21 Jan 2021 08:22:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B7A1C08A1;
	Thu, 21 Jan 2021 08:22:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3117AC013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 16:09:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B28272010B
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 16:09:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gU5+2MJkMv0S for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 16:09:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by silver.osuosl.org (Postfix) with ESMTPS id A40ED20000
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 16:09:11 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id n6so11307424edt.10
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 08:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uFPoWmdT1E7447c/foHDjqNJuO8UPeUXJAj8ZTCeNuI=;
 b=bNp4m8GXBuiU/FXyjO9D9cA/C4gIGIPznUcpKtSxPEKyebwvVQ+aRwdeBURGW60Aqn
 LWDM8IY14JaXyGVpmy9pspE7lfObh3UXUk1T9JUoE9m742jY/UWqwZOuCBJ1bPyIODGl
 UnlPbfbmqFegwGszXH5A2WM1t7WLON4F/hTTf41tPfVOHi9uvgUn8pBT7w/CdD4OSxCR
 Pj4XoIeByZmeoQNQ4FhMnueL2wZ9/ttGENz2s0DHc9xIW18UNCzE7rgOV30lEB4IWM6K
 z43ISZVwDPuNuqM8j3RZAlGmRUAK0i/ai2ThrTF7kmw/zPRYVf/biTfeZ/ArEDWa+95U
 iDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uFPoWmdT1E7447c/foHDjqNJuO8UPeUXJAj8ZTCeNuI=;
 b=pY0Q2nFRJMNwsu50ytcFMnPoSqfLmAb2lbQablE0m7QQgtnFNyiTDFFb96i8g59oGj
 CUVyts80uOwrB1vt0aOJFAv99slbtT01E3hCDmYTNkaYn/4yRpopQG8vDx9IiqUfQBMn
 ihsF6LE1qz321Qk/yuMlE2HzAtl3TiB0xFRaCCPz9pTSC0vGpCeb89xmK0s+tX9gP6A5
 Sysv23oAbZ1ST83O7YaU/9fmQ2wtl9/5XnsUEcw9f4ERg75DdKdRezVdoFnJOb/e8Ve0
 3b/0X23WlbBSUYOgEDnpI3Pnk0d+vcBZ6KjWrSrPGcDgorksOST7kmaOjiDzcaMQ7IU7
 SBgg==
X-Gm-Message-State: AOAM533ToZYNUzhabr4W5zXZCAPb53nSOLch/RNz7aiwxzsI0/OnplHT
 dHA8IuwOkPie+2n8VEluoxxsfelR+kesQBGkgViyVg==
X-Google-Smtp-Source: ABdhPJzzrx43U/MRM+U+2IS6fjT5/s61ISkHSJJW/uV0YTHN3o25ui9xpDMoE2/qruoEGyRFVzUk7yyVBnemuDxnOFQ=
X-Received: by 2002:aa7:d803:: with SMTP id v3mr7685979edq.153.1611158950213; 
 Wed, 20 Jan 2021 08:09:10 -0800 (PST)
MIME-Version: 1.0
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-5-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-5-wei.liu@kernel.org>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 20 Jan 2021 11:08:34 -0500
Message-ID: <CA+CK2bByGvCr_H3_wv_3-vAOONhRenonFNeHff5UdeFLDxSoUw@mail.gmail.com>
Subject: Re: [PATCH v5 04/16] iommu/hyperv: don't setup IRQ remapping when
 running as root
To: Wei Liu <wei.liu@kernel.org>
X-Mailman-Approved-At: Thu, 21 Jan 2021 08:22:03 +0000
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Joerg Roedel <jroedel@suse.de>, Stephen Hemminger <sthemmin@microsoft.com>,
 Will Deacon <will@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Vineeth Pillai <viremana@linux.microsoft.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>
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

On Wed, Jan 20, 2021 at 7:01 AM Wei Liu <wei.liu@kernel.org> wrote:
>
> The IOMMU code needs more work. We're sure for now the IRQ remapping
> hooks are not applicable when Linux is the root partition.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Acked-by: Joerg Roedel <jroedel@suse.de>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/iommu/hyperv-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> index 1d21a0b5f724..b7db6024e65c 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -20,6 +20,7 @@
>  #include <asm/io_apic.h>
>  #include <asm/irq_remapping.h>
>  #include <asm/hypervisor.h>
> +#include <asm/mshyperv.h>
>
>  #include "irq_remapping.h"
>
> @@ -122,7 +123,7 @@ static int __init hyperv_prepare_irq_remapping(void)
>
>         if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
>             x86_init.hyper.msi_ext_dest_id() ||
> -           !x2apic_supported())
> +           !x2apic_supported() || hv_root_partition)
>                 return -ENODEV;

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
