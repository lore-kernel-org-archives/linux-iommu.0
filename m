Return-Path: <SRS0=zE+z=V2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627EBC7618B
	for <iommu@archiver.kernel.org>; Mon, 29 Jul 2019 16:51:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DBC2206DD
	for <iommu@archiver.kernel.org>; Mon, 29 Jul 2019 16:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBC2206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E72881AFC;
	Mon, 29 Jul 2019 16:51:47 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8211818B9
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Jul 2019 16:47:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 05B90604
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Jul 2019 16:47:49 +0000 (UTC)
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.106])
	by Forcepoint Email with ESMTP id AD4F9D3B7A023EB9BF37;
	Mon, 29 Jul 2019 17:47:46 +0100 (IST)
Received: from LHREML524-MBB.china.huawei.com ([169.254.3.194]) by
	lhreml704-cah.china.huawei.com ([10.201.108.45]) with mapi id
	14.03.0415.000; Mon, 29 Jul 2019 17:47:40 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH] iommu/dma: Handle MSI mappings separately
Thread-Topic: [PATCH] iommu/dma: Handle MSI mappings separately
Thread-Index: AQHVRiMH3D2dEh8WTkKwpJamrpncmabhzStg
Date: Mon, 29 Jul 2019 16:47:39 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F32AC6A@lhreml524-mbb.china.huawei.com>
References: <2b2595de703c60a772ebcffe248d0cf036143e6a.1564414114.git.robin.murphy@arm.com>
In-Reply-To: <2b2595de703c60a772ebcffe248d0cf036143e6a.1564414114.git.robin.murphy@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "maz@kernel.org" <maz@kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Andre Przywara <andre.przywara@arm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org



> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.org]
> On Behalf Of Robin Murphy
> Sent: 29 July 2019 16:33
> To: joro@8bytes.org
> Cc: maz@kernel.org; iommu@lists.linux-foundation.org; Shameerali Kolothum
> Thodi <shameerali.kolothum.thodi@huawei.com>;
> linux-arm-kernel@lists.infradead.org; Andre Przywara
> <andre.przywara@arm.com>
> Subject: [PATCH] iommu/dma: Handle MSI mappings separately
> 
> MSI pages must always be mapped into a device's *current* domain, which
> *might* be the default DMA domain, but might instead be a VFIO domain
> with its own MSI cookie. This subtlety got accidentally lost in the
> streamlining of __iommu_dma_map(), but rather than reintroduce more
> complexity and/or special-casing, it turns out neater to just split this
> path out entirely.
> 
> Since iommu_dma_get_msi_page() already duplicates much of what
> __iommu_dma_map() does, it can easily just make the allocation and
> mapping calls directly as well. That way we can further streamline the
> helper back to exclusively operating on DMA domains.
> 
> Fixes: b61d271e59d7 ("iommu/dma: Move domain lookup into
> __iommu_dma_{map,unmap}")
> Reported-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reported-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Thanks. This fixes the vf assignment issue on D06 as well. FWIW,

Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Shameer

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
