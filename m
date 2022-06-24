Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A47ACCA483
	for <iommu@archiver.kernel.org>; Fri, 24 Jun 2022 01:50:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D982260BBF;
	Fri, 24 Jun 2022 01:50:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D982260BBF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IZudH0y3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WfjywvlxmEkw; Fri, 24 Jun 2022 01:50:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 856BF60C06;
	Fri, 24 Jun 2022 01:50:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 856BF60C06
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60DDEC0039;
	Fri, 24 Jun 2022 01:50:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEC80C002D;
 Fri, 24 Jun 2022 01:50:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D6F2284825;
 Fri, 24 Jun 2022 01:50:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D6F2284825
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=IZudH0y3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Fv-OvKam7g7; Fri, 24 Jun 2022 01:50:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 135218481B
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 135218481B;
 Fri, 24 Jun 2022 01:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656035437; x=1687571437;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=IsvI1dwjNH7FPAzCwj0jEY++TlXnX8nTqkYbG4bsQ18=;
 b=IZudH0y3zHeGkgnl/oJgpPoOLGMfWCxkj+eiQwrJ64jCRyAjl198DJy/
 Sz5SzqSSzCzwgqUCi+cFZEjAk9xt6FzWju6rSLWoDOptDKz7dDFFlgtNt
 zFxbHVDPFEvjZAiezQjMyU90TitJqPh2SKWCbB58reAbXIhHCeGBEOlZj
 PxXz/82QWS05JK2SFwXNMnTQFXt3Nw1WfsYyBx/SS443GBQFmNCJyQ4O+
 gg/Hr0kTZXnVFmsP6eXlRM2XpADTFc2qO5Xi98tW00pfvR9MvbC14Uton
 mIAo7RsWRo9hM2/T4KxIpNvVqa4IF+OORBliyi5yE9cAMDZWQu6FIUSkG Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="306359524"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; d="scan'208";a="306359524"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2022 18:50:35 -0700
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; d="scan'208";a="645044417"
Received: from wenli3x-mobl.ccr.corp.intel.com (HELO [10.249.168.117])
 ([10.249.168.117])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2022 18:50:27 -0700
Message-ID: <450ce024-10c5-6626-c3dc-c2fd962fda61@linux.intel.com>
Date: Fri, 24 Jun 2022 09:50:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/5] vfio/iommu_type1: Prefer to reuse domains vs match
 enforced cache coherency
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org, will@kernel.org,
 marcan@marcan.st, sven@svenpeter.dev, robin.murphy@arm.com,
 robdclark@gmail.com, matthias.bgg@gmail.com, orsonzhai@gmail.com,
 baolin.wang7@gmail.com, zhang.lyra@gmail.com, jean-philippe@linaro.org,
 alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com
References: <20220623200029.26007-1-nicolinc@nvidia.com>
 <20220623200029.26007-3-nicolinc@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220623200029.26007-3-nicolinc@nvidia.com>
Cc: jordan@cosmicpenguin.net, thierry.reding@gmail.com, alyssa@rosenzweig.io,
 linux-s390@vger.kernel.org, kvm@vger.kernel.org, jonathanh@nvidia.com,
 yangyingliang@huawei.com, gerald.schaefer@linux.ibm.com,
 linux-arm-msm@vger.kernel.org, christophe.jaillet@wanadoo.fr,
 linux-tegra@vger.kernel.org, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, cohuck@redhat.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, dwmw2@infradead.org
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

On 2022/6/24 04:00, Nicolin Chen wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> The KVM mechanism for controlling wbinvd is based on OR of the coherency
> property of all devices attached to a guest, no matter whether those
> devices are attached to a single domain or multiple domains.
> 
> On the other hand, the benefit to using separate domains was that those
> devices attached to domains supporting enforced cache coherency always
> mapped with the attributes necessary to provide that feature, therefore
> if a non-enforced domain was dropped, the associated group removal would
> re-trigger an evaluation by KVM.
> 
> In practice however, the only known cases of such mixed domains included
> an Intel IGD device behind an IOMMU lacking snoop control, where such
> devices do not support hotplug, therefore this scenario lacks testing and
> is not considered sufficiently relevant to support.
> 
> After all, KVM won't take advantage of trying to push a device that could
> do enforced cache coherency to a dedicated domain vs re-using an existing
> domain, which is non-coherent.
> 
> Simplify this code and eliminate the test. This removes the only logic
> that needed to have a dummy domain attached prior to searching for a
> matching domain and simplifies the next patches.
> 
> It's unclear whether we want to further optimize the Intel driver to
> update the domain coherency after a device is detached from it, at
> least not before KVM can be verified to handle such dynamics in related
> emulation paths (wbinvd, vcpu load, write_cr0, ept, etc.). In reality
> we don't see an usage requiring such optimization as the only device
> which imposes such non-coherency is Intel GPU which even doesn't
> support hotplug/hot remove.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/vfio/vfio_iommu_type1.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index c13b9290e357..f4e3b423a453 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2285,9 +2285,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>   	 * testing if they're on the same bus_type.
>   	 */
>   	list_for_each_entry(d, &iommu->domain_list, next) {
> -		if (d->domain->ops == domain->domain->ops &&
> -		    d->enforce_cache_coherency ==
> -			    domain->enforce_cache_coherency) {
> +		if (d->domain->ops == domain->domain->ops) {
>   			iommu_detach_group(domain->domain, group->iommu_group);
>   			if (!iommu_attach_group(d->domain,
>   						group->iommu_group)) {

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
