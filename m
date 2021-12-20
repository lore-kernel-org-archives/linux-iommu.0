Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E0FC433F5
	for <iommu@archiver.kernel.org>; Mon, 20 Dec 2021 11:23:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25F938291A;
	Mon, 20 Dec 2021 11:23:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Tpu_eLu5oD6; Mon, 20 Dec 2021 11:23:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E04AC82884;
	Mon, 20 Dec 2021 11:23:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE01CC001E;
	Mon, 20 Dec 2021 11:23:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDC63C0012
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 11:23:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E359C60899
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 11:23:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VpADQBGaBf8x for <iommu@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 11:23:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2D607605A5
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 11:23:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21E8E11FB;
 Mon, 20 Dec 2021 03:23:00 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 481643F718;
 Mon, 20 Dec 2021 03:22:58 -0800 (PST)
Message-ID: <1d3d4486-1fe0-372c-f702-30da7cf86b5a@arm.com>
Date: Mon, 20 Dec 2021 11:22:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/1] drm/nouveau/device: Get right pgsize_bitmap of
 iommu_domain
Content-Language: en-GB
To: Lu Baolu <baolu.lu@linux.intel.com>, Ben Skeggs <bskeggs@redhat.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>
References: <20211218074546.1772553-1-baolu.lu@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211218074546.1772553-1-baolu.lu@linux.intel.com>
Cc: nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-tegra@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-12-18 07:45, Lu Baolu wrote:
> The suported page sizes of an iommu_domain are saved in the pgsize_bitmap
> field. Retrieve the value from the right place.
> 
> Fixes: 58fd9375c2c534 ("drm/nouveau/platform: probe IOMMU if present")

...except domain->pgsize_bitmap was introduced more than a year after 
that commit ;)

As an improvement rather than a fix, though,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
> index d0d52c1d4aee..992cc285f2fe 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
> @@ -133,7 +133,7 @@ nvkm_device_tegra_probe_iommu(struct nvkm_device_tegra *tdev)
>   		 * or equal to the system's PAGE_SIZE, with a preference if
>   		 * both are equal.
>   		 */
> -		pgsize_bitmap = tdev->iommu.domain->ops->pgsize_bitmap;
> +		pgsize_bitmap = tdev->iommu.domain->pgsize_bitmap;
>   		if (pgsize_bitmap & PAGE_SIZE) {
>   			tdev->iommu.pgshift = PAGE_SHIFT;
>   		} else {
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
