Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F147DC433F5
	for <iommu@archiver.kernel.org>; Sun, 10 Apr 2022 19:52:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 695C9415C7;
	Sun, 10 Apr 2022 19:52:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kh-_0U8omvAl; Sun, 10 Apr 2022 19:52:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F2F0D415C6;
	Sun, 10 Apr 2022 19:52:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C21DDC0033;
	Sun, 10 Apr 2022 19:52:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13F14C002C
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 19:52:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DF84D60F80
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 19:52:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XECsfgJiY43X for <iommu@lists.linux-foundation.org>;
 Sun, 10 Apr 2022 19:52:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ED3AA60F77
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 19:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649620344; x=1681156344;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=EF5s5J7GPdqeiz1pEHQ/PowHu/TjKguTo2H6OD1EN7Q=;
 b=bhO3jBMoQBJj79oZoo3KxdtcY/2c2NeEmQeGhvDmg7ODQ23i15dVKVIY
 jAZopaVTOo8joH5bLaBCDl5IO2p4H5DGz7JpZVNWmBQ+Zw3y/P5CRztDy
 oocY+rjaHz7WNjW67PAomN5AbaovM4U2cfAZyVKJPuNJRjDCKCvZrYIPv
 sB4Cm1miAUQAdjGCVr5WgA82vhAhq9FiSXtSwkNN+2hU5A2yOP7mvi1nB
 ybqoTEzLsE9hrsz3yKleuhmGbiG5yMvIOtYrJQs/t1rj6rxbirVeM2q0h
 TCyXDhc//rkx/FjkilPJdV4o0naS4SsLxRl5A7VrHMEKUknxXqnGIxw4t Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="286998437"
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; d="scan'208";a="286998437"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2022 12:52:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; d="scan'208";a="571814308"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314)
 ([10.237.222.76])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2022 12:52:21 -0700
Date: Sun, 10 Apr 2022 20:52:14 +0100
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] crypto: qat - stop using iommu_present()
Message-ID: <YlM1bmo8M80Wjnov@silpixa00400314>
References: <ef01fbd7d2c60d56a0b8e8847a08ccb3ee5132af.1649161511.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ef01fbd7d2c60d56a0b8e8847a08ccb3ee5132af.1649161511.git.robin.murphy@arm.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Cc: herbert@gondor.apana.org.au, qat-linux@intel.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org, davem@davemloft.net
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

On Tue, Apr 05, 2022 at 01:25:11PM +0100, Robin Murphy wrote:
> Even if an IOMMU might be present for some PCI segment in the system,
> that doesn't necessarily mean it provides translation for the device
> we care about. Replace iommu_present() with a more appropriate check.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/crypto/qat/qat_common/adf_sriov.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/qat/qat_common/adf_sriov.c b/drivers/crypto/qat/qat_common/adf_sriov.c
> index b960bca1f9d2..7f9c18dc4540 100644
> --- a/drivers/crypto/qat/qat_common/adf_sriov.c
> +++ b/drivers/crypto/qat/qat_common/adf_sriov.c
> @@ -3,7 +3,6 @@
>  #include <linux/workqueue.h>
>  #include <linux/pci.h>
>  #include <linux/device.h>
> -#include <linux/iommu.h>
>  #include "adf_common_drv.h"
>  #include "adf_cfg.h"
>  #include "adf_pfvf_pf_msg.h"
> @@ -176,7 +175,7 @@ int adf_sriov_configure(struct pci_dev *pdev, int numvfs)
>  		return -EFAULT;
>  	}
>  
> -	if (!iommu_present(&pci_bus_type))
> +	if (!device_iommu_mapped(&pdev->dev))
>  		dev_warn(&pdev->dev, "IOMMU should be enabled for SR-IOV to work correctly\n");
>  
>  	if (accel_dev->pf.vf_info) {
> -- 
> 2.28.0.dirty
> 
I tried this patch and it appears to work as expected.

Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

Regards,

-- 
Giovanni
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
