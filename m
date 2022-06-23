Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F0CC433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 01:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E96940891;
	Thu, 23 Jun 2022 01:47:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E96940891
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JAF6n2F8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YOWVZcute2dv; Thu, 23 Jun 2022 01:47:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C3F3240922;
	Thu, 23 Jun 2022 01:47:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C3F3240922
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B285C0032;
	Thu, 23 Jun 2022 01:47:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC41FC002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 01:47:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C33DB829DC
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 01:47:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C33DB829DC
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=JAF6n2F8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Eam981u6ZX-M for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 01:47:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5FC4A8299E
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5FC4A8299E
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 01:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655948837; x=1687484837;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5aSD0DjHyYnzIIUB6IzUxLlam0GmvLF8zHoN0ofDDZ0=;
 b=JAF6n2F8+FCAJxxzYUpaJKAkONZOmV5Dag6l+N4UMqrE9PIfeyNfz8fm
 hNusvpbQP3fBE2kqL3vvgkMQQcuO+0wUlRFmo0CnGyhfEKvJVrTJjbk2f
 avX7I2UfH/U7q7DdhDA6CoBf/6Yb49IW03x0KYcFcY00jdAacwCaf0YaX
 w1YuoECzSyyOfmcW78dO8nIDX+K1VCbxEggg9lZmKHjH7kW7DgZCFZ5/F
 WKgylMAvH1LRQlBmpMI8OJsRmTgPdBiHW9eA3I1PynNMZh4vr33inWYYi
 C/sIWovy0nWww6Igncr++RgzH+tOAliFLjQ17dat5EnyP+TXU6XP0pO89 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="342279692"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; d="scan'208";a="342279692"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2022 18:47:06 -0700
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; d="scan'208";a="644487288"
Received: from yutaoxu-mobl.ccr.corp.intel.com (HELO [10.249.172.190])
 ([10.249.172.190])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2022 18:47:04 -0700
Message-ID: <809315c8-67b3-c4ce-a1de-bddbe7ec9770@linux.intel.com>
Date: Thu, 23 Jun 2022 09:47:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/2] vfio: Use device_iommu_capable()
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, alex.williamson@redhat.com,
 cohuck@redhat.com
References: <b1d13cade281a7d8acbfd0f6a33dcd086207952c.1655898523.git.robin.murphy@arm.com>
 <910aef11138e3b6702b29a3e78415235aa4bf773.1655898523.git.robin.murphy@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <910aef11138e3b6702b29a3e78415235aa4bf773.1655898523.git.robin.murphy@arm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, iommu@lists.linux.dev, jgg@nvidia.com
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

On 2022/6/22 20:04, Robin Murphy wrote:
> Use the new interface to check the capabilities for our device
> specifically.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/vfio/vfio.c             | 2 +-
>   drivers/vfio/vfio_iommu_type1.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index 73bab04880d0..765d68192c88 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -621,7 +621,7 @@ int vfio_register_group_dev(struct vfio_device *device)
>   	 * VFIO always sets IOMMU_CACHE because we offer no way for userspace to
>   	 * restore cache coherency.
>   	 */
> -	if (!iommu_capable(device->dev->bus, IOMMU_CAP_CACHE_COHERENCY))
> +	if (!device_iommu_capable(device->dev, IOMMU_CAP_CACHE_COHERENCY))
>   		return -EINVAL;
>   
>   	return __vfio_register_dev(device,
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index e38b8bfde677..2107e95eb743 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2247,7 +2247,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>   	list_add(&group->next, &domain->group_list);
>   
>   	msi_remap = irq_domain_check_msi_remap() ||
> -		    iommu_capable(iommu_api_dev->dev->bus, IOMMU_CAP_INTR_REMAP);
> +		    device_iommu_capable(iommu_api_dev->dev, IOMMU_CAP_INTR_REMAP);
>   
>   	if (!allow_unsafe_interrupts && !msi_remap) {
>   		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
