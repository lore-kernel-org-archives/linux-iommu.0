Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845CCC433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 01:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0381860E19;
	Wed, 22 Jun 2022 01:36:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0381860E19
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T84QlbF+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c_pVx9ABmTJ7; Wed, 22 Jun 2022 01:36:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BD2F060F01;
	Wed, 22 Jun 2022 01:36:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BD2F060F01
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68041C0039;
	Wed, 22 Jun 2022 01:36:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96ADEC002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 01:36:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7070041878
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 01:36:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7070041878
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=T84QlbF+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xk214_fhC2qz for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 01:36:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 10194417CA
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 10194417CA
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 01:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655861814; x=1687397814;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=zqCWDRHMK5Aix9ertSDJIJ+yaJFXeDzuTdpljbqYeik=;
 b=T84QlbF+JAyheU7ASgx94Bj8v8NZ8ngXdP2DH6f5Bt7Hhmrwu0ws1Js9
 YhyDEvuQuy4g4qXXtsOrgJNJzmenmy4nvVs28Z1ag1ADMPs+XXUIF101t
 woeFLyoPlg30BmsKvEtNMkJn5ADmO7OHu8OvvEqygJ2WTWqGEzTn1ee3+
 LoXVnI0LuQ3huifEgTa1TTX3gZojKRvQy/UIx/bHuAjKherVrokZc7MkW
 tKOOxxZvhoqrdKGXVSQlngGJJdAipNUo6ATPTodL1qvNIny6PU5j00qYK
 9+DCmBW/ibKALSjAS4EeEvf1DVOonFnf0k8CDrFD7MFW8uN5AsaLcreu2 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="281356017"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; d="scan'208";a="281356017"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2022 18:36:41 -0700
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; d="scan'208";a="833849548"
Received: from xzhan99-mobl1.ccr.corp.intel.com (HELO [10.249.172.26])
 ([10.249.172.26])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2022 18:36:39 -0700
Message-ID: <59002dbd-d72a-4f9c-7ad8-808ee8d2ff05@linux.intel.com>
Date: Wed, 22 Jun 2022 09:36:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] iommu: Clean up release_device checks
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1655822151.git.robin.murphy@arm.com>
 <02671dbfad7a3343fc25a44222350efcb455fe3c.1655822151.git.robin.murphy@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <02671dbfad7a3343fc25a44222350efcb455fe3c.1655822151.git.robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
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

On 2022/6/21 23:14, Robin Murphy wrote:
> Since .release_device is now called through per-device ops, any call
> which gets as far as a driver definitely*is*  for that driver, for a
> device which has successfully passed .probe_device, so all the checks to
> that effect are now redundant and can be removed. In the same vein we
> can also skip freeing fwspecs which are now managed by core code.

Does this depend on any other series? I didn't see iommu_fwspec_free()
called in the core code. Or I missed anything?

> 
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>
> ---
>   drivers/iommu/apple-dart.c                  |  3 ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  8 +-------
>   drivers/iommu/arm/arm-smmu/arm-smmu.c       | 14 +++-----------
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 11 -----------
>   drivers/iommu/exynos-iommu.c                |  3 ---
>   drivers/iommu/mtk_iommu.c                   |  5 -----
>   drivers/iommu/mtk_iommu_v1.c                |  5 -----
>   drivers/iommu/sprd-iommu.c                  | 11 -----------
>   drivers/iommu/virtio-iommu.c                |  8 +-------
>   9 files changed, 5 insertions(+), 63 deletions(-)

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
