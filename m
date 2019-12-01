Return-Path: <SRS0=pbQ6=ZX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1767AC432C0
	for <iommu@archiver.kernel.org>; Sun,  1 Dec 2019 12:48:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F5E215E5
	for <iommu@archiver.kernel.org>; Sun,  1 Dec 2019 12:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F5E215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lynxeye.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5DFF7862ED;
	Sun,  1 Dec 2019 12:48:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fjR8Iu+NG3eG; Sun,  1 Dec 2019 12:48:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 22DA5861E7;
	Sun,  1 Dec 2019 12:48:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0952BC1DDC;
	Sun,  1 Dec 2019 12:48:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69A59C087F
 for <iommu@lists.linux-foundation.org>; Sun,  1 Dec 2019 12:48:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5794C20011
 for <iommu@lists.linux-foundation.org>; Sun,  1 Dec 2019 12:48:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yJxT98we5z7h for <iommu@lists.linux-foundation.org>;
 Sun,  1 Dec 2019 12:48:20 +0000 (UTC)
X-Greylist: delayed 00:05:43 by SQLgrey-1.7.6
Received: from lynxeye.de (ns.lynxeye.de [87.118.118.114])
 by silver.osuosl.org (Postfix) with ESMTP id B253F1FEE0
 for <iommu@lists.linux-foundation.org>; Sun,  1 Dec 2019 12:48:19 +0000 (UTC)
Received: by lynxeye.de (Postfix, from userid 501)
 id 2F953E74222; Sun,  1 Dec 2019 13:42:33 +0100 (CET)
Received: from astat.fritz.box (a89-183-126-187.net-htp.de [89.183.126.187])
 by lynxeye.de (Postfix) with ESMTPSA id 93F73E7414D;
 Sun,  1 Dec 2019 13:42:31 +0100 (CET)
Message-ID: <5b2097e8c4172a8516fcfc8c56dc98e3d105ffe2.camel@lynxeye.de>
Subject: Re: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge systems
From: Lucas Stach <dev@lynxeye.de>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, joro@8bytes.org
Date: Sun, 01 Dec 2019 13:42:31 +0100
In-Reply-To: <20191129142154.29658-1-kai.heng.feng@canonical.com>
References: <20191129142154.29658-1-kai.heng.feng@canonical.com>
User-Agent: Evolution 3.34.1 (3.34.1-1.fc31) 
MIME-Version: 1.0
Cc: Alex Deucher <alexander.deucher@amd.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

Am Freitag, den 29.11.2019, 22:21 +0800 schrieb Kai-Heng Feng:
> Serious screen flickering when Stoney Ridge outputs to a 4K monitor.
> 
> According to Alex Deucher, IOMMU isn't enabled on Windows, so let's do
> the same here to avoid screen flickering on 4K monitor.

This doesn't seem like a good solution, especially if there isn't a
method for the user to opt-out.  Some users might prefer having the
IOMMU support to 4K display output.

But before using the big hammer of disabling or breaking one of those
features, we should take a look at what's the issue here. Screen
flickering caused by the IOMMU being active hints to the IOMMU not
being able to sustain the translation bandwidth required by the high-
bandwidth isochronous transfers caused by 4K scanout, most likely due
to insufficient TLB space.

As far as I know the framebuffer memory for the display buffers is
located in stolen RAM, and thus contigous in memory. I don't know the
details of the GPU integration on those APUs, but maybe there even is a
way to bypass the IOMMU for the stolen VRAM regions?

If there isn't and all GPU traffic passes through the IOMMU when
active, we should check if the stolen RAM is mapped with hugepages on
the IOMMU side. All the stolen RAM can most likely be mapped with a few
hugepage mappings, which should reduce IOMMU TLB demand by a large
margin.

Regards,
Lucas

> Cc: Alex Deucher <alexander.deucher@amd.com>
> Bug: https://gitlab.freedesktop.org/drm/amd/issues/961
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
> - Find Stoney graphics instead of host bridge.
> 
>  drivers/iommu/amd_iommu_init.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 568c52317757..139aa6fdadda 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -2516,6 +2516,7 @@ static int __init early_amd_iommu_init(void)
>  	struct acpi_table_header *ivrs_base;
>  	acpi_status status;
>  	int i, remap_cache_sz, ret = 0;
> +	u32 pci_id;
>  
>  	if (!amd_iommu_detected)
>  		return -ENODEV;
> @@ -2603,6 +2604,16 @@ static int __init early_amd_iommu_init(void)
>  	if (ret)
>  		goto out;
>  
> +	/* Disable IOMMU if there's Stoney Ridge graphics */
> +	for (i = 0; i < 32; i++) {
> +		pci_id = read_pci_config(0, i, 0, 0);
> +		if ((pci_id & 0xffff) == 0x1002 && (pci_id >> 16) == 0x98e4) {
> +			pr_info("Disable IOMMU on Stoney Ridge\n");
> +			amd_iommu_disabled = true;
> +			break;
> +		}
> +	}
> +
>  	/* Disable any previously enabled IOMMUs */
>  	if (!is_kdump_kernel() || amd_iommu_disabled)
>  		disable_iommus();
> @@ -2711,7 +2722,7 @@ static int __init state_next(void)
>  		ret = early_amd_iommu_init();
>  		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_ACPI_FINISHED;
>  		if (init_state == IOMMU_ACPI_FINISHED && amd_iommu_disabled) {
> -			pr_info("AMD IOMMU disabled on kernel command-line\n");
> +			pr_info("AMD IOMMU disabled\n");
>  			init_state = IOMMU_CMDLINE_DISABLED;
>  			ret = -EINVAL;
>  		}

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
