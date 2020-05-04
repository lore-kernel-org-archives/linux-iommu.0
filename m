Return-Path: <SRS0=OemM=6S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89325C3A5A9
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 19:59:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44AC6206A5
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 19:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44AC6206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1162086B7B;
	Mon,  4 May 2020 19:59:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oenGlG8iJLmQ; Mon,  4 May 2020 19:59:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3BF2286AE0;
	Mon,  4 May 2020 19:59:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 303B0C088A;
	Mon,  4 May 2020 19:59:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3812AC0175
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 19:59:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 23B2D20364
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 19:59:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IfD32L5850qj for <iommu@lists.linux-foundation.org>;
 Mon,  4 May 2020 19:59:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from smtprelay.hostedemail.com (smtprelay0230.hostedemail.com
 [216.40.44.230])
 by silver.osuosl.org (Postfix) with ESMTPS id CDB581FD90
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 19:59:12 +0000 (UTC)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 46C9C18008231
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 19:42:53 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay04.hostedemail.com (Postfix) with ESMTP id B7990180AA4EE;
 Mon,  4 May 2020 19:42:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cream19_35bf089570f11
X-Filterd-Recvd-Size: 3477
Received: from XPS-9350.home (unknown [47.151.136.130])
 (Authenticated sender: joe@perches.com)
 by omf07.hostedemail.com (Postfix) with ESMTPA;
 Mon,  4 May 2020 19:42:49 +0000 (UTC)
Message-ID: <695919ca3010be4f2087c62530cf7b6ee4e01971.camel@perches.com>
Subject: Re: [PATCH 5.6 61/73] iommu/vt-d: Use right Kconfig option name
From: Joe Perches <joe@perches.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-kernel@vger.kernel.org
Date: Mon, 04 May 2020 12:42:48 -0700
In-Reply-To: <20200504165509.860520707@linuxfoundation.org>
References: <20200504165501.781878940@linuxfoundation.org>
 <20200504165509.860520707@linuxfoundation.org>
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Cc: Joerg Roedel <jroedel@suse.de>, Ashok Raj <ashok.raj@intel.com>,
 Sanjay K <sanjay.k.kumar@intel.com>, stable@vger.kernel.org,
 iommu <iommu@lists.linux-foundation.org>,
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

On Mon, 2020-05-04 at 19:58 +0200, Greg Kroah-Hartman wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> commit ba61c3da00f4a5bf8805aeca1ba5ac3c9bd82e96 upstream.
> 
> The CONFIG_ prefix should be added in the code.
> 
> Fixes: 046182525db61 ("iommu/vt-d: Add Kconfig option to enable/disable scalable mode")
> Reported-and-tested-by: Kumar, Sanjay K <sanjay.k.kumar@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Link: https://lore.kernel.org/r/20200501072427.14265-1-baolu.lu@linux.intel.com
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  drivers/iommu/intel-iommu.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -371,11 +371,11 @@ int dmar_disabled = 0;
>  int dmar_disabled = 1;
>  #endif /* CONFIG_INTEL_IOMMU_DEFAULT_ON */
>  
> -#ifdef INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
> +#ifdef CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
>  int intel_iommu_sm = 1;
>  #else
>  int intel_iommu_sm;
> -#endif /* INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON */
> +#endif /* CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON */

Perhaps simpler as

int intel_iommu_sm = IS_BUILTIN(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);

So perhaps:
---
 drivers/iommu/intel-iommu.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0182cff2c7ac..ab8552c48391 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -365,17 +365,8 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 					    dma_addr_t iova);
 
-#ifdef CONFIG_INTEL_IOMMU_DEFAULT_ON
-int dmar_disabled = 0;
-#else
-int dmar_disabled = 1;
-#endif /* CONFIG_INTEL_IOMMU_DEFAULT_ON */
-
-#ifdef CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
-int intel_iommu_sm = 1;
-#else
-int intel_iommu_sm;
-#endif /* CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON */
+int dmar_disabled = !IS_BUILTIN(CONFIG_INTEL_IOMMU_DEFAULT_ON);
+int intel_iommu_sm = IS_BUILTIN(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
 
 int intel_iommu_enabled = 0;
 EXPORT_SYMBOL_GPL(intel_iommu_enabled);

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
