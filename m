Return-Path: <SRS0=HAoA=WF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD44C433FF
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 16:50:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54CC2086A
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 16:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b6QFH4EL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54CC2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A0E42D09;
	Fri,  9 Aug 2019 16:50:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EFCFCCA8
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 16:50:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7779D82D
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 16:50:44 +0000 (UTC)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x79Gocvi105177;
	Fri, 9 Aug 2019 11:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1565369438;
	bh=+yB5xUDLgEEDZQOhBDY2+WALcirCl+lmAN0finFGolg=;
	h=Subject:To:CC:References:From:Date:In-Reply-To;
	b=b6QFH4ELgyR9WSshTPt7etxKHlDQoRRsTVXznk86nFb2suCkiqx8rccAsbt/xIiay
	+GQr7EfG0AqRHKzPHrw6GmXNNcfLkChg0ApuPF4fQ7b3LjLXE3fUu3xfxkyj9hjJKM
	evKs+oWcQu0P0Wo76HAWXAiYcdlCJ9hFFOuBWwXM=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x79Goc7g077128
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Aug 2019 11:50:38 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
	(10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5;
	Fri, 9 Aug 2019 11:50:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
	(10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
	Frontend Transport; Fri, 9 Aug 2019 11:50:37 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
	by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x79Gob1e006180;
	Fri, 9 Aug 2019 11:50:37 -0500
Subject: Re: [PATCH] iommu/omap: Fix compilation warnings suspend/resume
	control
To: Joerg Roedel <joro@8bytes.org>, Tero Kristo <t-kristo@ti.com>
References: <1565166412-31195-1-git-send-email-t-kristo@ti.com>
	<1565166412-31195-7-git-send-email-t-kristo@ti.com>
	<20190809161305.GA1213@8bytes.org>
Message-ID: <1badc776-f0d9-2f21-fa14-472cf3624db2@ti.com>
Date: Fri, 9 Aug 2019 11:50:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190809161305.GA1213@8bytes.org>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
From: Suman Anna via iommu <iommu@lists.linux-foundation.org>
Reply-To: Suman Anna <s-anna@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 8/9/19 11:13 AM, Joerg Roedel wrote:
> On Wed, Aug 07, 2019 at 11:26:50AM +0300, Tero Kristo wrote:
>> +static inline int omap_iommu_domain_deactivate(struct iommu_domain *domain) {}
>> +static inline int omap_iommu_domain_activate(struct iommu_domain *domain) {}
> 
> This caused compilation warnings, I queued the fix below.
> 
> From 70c8a42adf482fba35e9e39ccd441a5ff8ffb657 Mon Sep 17 00:00:00 2001
> From: Joerg Roedel <jroedel@suse.de>
> Date: Fri, 9 Aug 2019 18:09:13 +0200
> Subject: [PATCH] iommu/omap: Fix compilation warnings
> 
> A recent patches introduced a new compiler warning because
> two functions with non-void return type have no return
> statement in omap-iommu.h for CONFIG_OMAP_IOMMU=n.
> 
> Fix this by adding return statements to these functions.

Thanks Joerg, looks like Tero missed them when he forward-ported the
patches.

regards
Suman

> 
> Fixes: d9c4d8a6cc0f8 ('iommu/omap: introduce new API for runtime suspend/resume control')
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  include/linux/omap-iommu.h | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/omap-iommu.h b/include/linux/omap-iommu.h
> index 36b645726813..2c32ca09df02 100644
> --- a/include/linux/omap-iommu.h
> +++ b/include/linux/omap-iommu.h
> @@ -22,8 +22,15 @@ int omap_iommu_domain_activate(struct iommu_domain *domain);
>  static inline void omap_iommu_save_ctx(struct device *dev) {}
>  static inline void omap_iommu_restore_ctx(struct device *dev) {}
>  
> -static inline int omap_iommu_domain_deactivate(struct iommu_domain *domain) {}
> -static inline int omap_iommu_domain_activate(struct iommu_domain *domain) {}
> +static inline int omap_iommu_domain_deactivate(struct iommu_domain *domain)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int omap_iommu_domain_activate(struct iommu_domain *domain)
> +{
> +	return -ENODEV;
> +}
>  #endif
>  
>  #endif
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
