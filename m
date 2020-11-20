Return-Path: <SRS0=3eTK=E2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B34C56201
	for <iommu@archiver.kernel.org>; Fri, 20 Nov 2020 16:53:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573CC2225B
	for <iommu@archiver.kernel.org>; Fri, 20 Nov 2020 16:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573CC2225B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C166F875FD;
	Fri, 20 Nov 2020 16:53:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 15rQ58cqYtwP; Fri, 20 Nov 2020 16:53:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8DECF87600;
	Fri, 20 Nov 2020 16:53:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 756BBC163C;
	Fri, 20 Nov 2020 16:53:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA864C0891
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 16:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B712886DC0
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 16:53:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PXoYiPy6Wpyk for <iommu@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 16:53:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2236A86DB6
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 16:53:51 +0000 (UTC)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cd2dl0PVGz67DPK;
 Sat, 21 Nov 2020 00:52:11 +0800 (CST)
Received: from lhreml714-chm.china.huawei.com (10.201.108.65) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 20 Nov 2020 17:53:48 +0100
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml714-chm.china.huawei.com (10.201.108.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 20 Nov 2020 16:53:48 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1913.007; Fri, 20 Nov 2020 16:53:48 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Subject: RE: [PATCH] iommu: Check return of __iommu_attach_device()
Thread-Topic: [PATCH] iommu: Check return of __iommu_attach_device()
Thread-Index: AQHWvpWDFOlCvhbm1kiI932Tcvk2j6nQ358AgAAwKACAACcb8A==
Date: Fri, 20 Nov 2020 16:53:47 +0000
Message-ID: <6375e8511bcb48209fffa0c02833e27b@huawei.com>
References: <20201119165846.34180-1-shameerali.kolothum.thodi@huawei.com>
 <20201120111503.GB6151@willie-the-truck>
 <337ffd34-a606-4fb1-adb0-49367c136170@arm.com>
In-Reply-To: <337ffd34-a606-4fb1-adb0-49367c136170@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.210.172.192]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Linuxarm <linuxarm@huawei.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy@arm.com]
> Sent: 20 November 2020 14:07
> To: Will Deacon <will@kernel.org>; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>
> Cc: linux-arm-kernel@lists.infradead.org; iommu@lists.linux-foundation.org;
> Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH] iommu: Check return of __iommu_attach_device()
> 
> On 2020-11-20 11:15, Will Deacon wrote:
> > On Thu, Nov 19, 2020 at 04:58:46PM +0000, Shameer Kolothum wrote:
> >> Currently iommu_create_device_direct_mappings() is called
> >> without checking the return of __iommu_attach_device(). This
> >> may result in failures in iommu driver if dev attach returns
> >> error.
> >>
> >> Fixes: ce574c27ae27("iommu: Move
> iommu_group_create_direct_mappings() out of iommu_group_add_device()")
> >> Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
> >> ---
> >> Crash log:
> >> [   31.353605] hns3 0000:7d:00.3: Adding to iommu group 10
> >> [   31.358822] Unable to handle kernel NULL pointer dereference at virtual
> address 0000000000000018
> >> [   31.367567] Mem abort info:
> >> [   31.370350]   ESR = 0x96000004
> >> [   31.373391]   EC = 0x25: DABT (current EL), IL = 32 bits
> >> [   31.378680]   SET = 0, FnV = 0
> >> [   31.381720]   EA = 0, S1PTW = 0
> >> [   31.384847] Data abort info:
> >> [   31.387716]   ISV = 0, ISS = 0x00000004
> >> [   31.391535]   CM = 0, WnR = 0
> >> [   31.394491] [0000000000000018] user address but active_mm is
> swapper
> >> [   31.400818] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> >> [   31.406365] Modules linked in:
> >> [   31.409409] CPU: 21 PID: 1 Comm: swapper/0 Not tainted
> 5.10.0-rc4-00008-gdd5aba9d719-dirty #79
> >> [   31.417980] Hardware name: Huawei TaiShan 200 (Model
> 2280)/BC82AMDD, BIOS 2280-V2 CS V3.B220.01 03/19/2020
> >> [   31.427588] pstate: 00c00009 (nzcv daif +PAN +UAO -TCO BTYPE=--)
> >> [   31.433566] pc : arm_smmu_tlb_inv_range+0x178/0x1f0
> >> [   31.438422] lr : arm_smmu_tlb_inv_range+0x5c/0x1f0
> >> [   31.443190] sp : ffff80001043b4e0
> >> ...
> >> [   31.531175] Call trace:
> >> [   31.533613]  arm_smmu_tlb_inv_range+0x178/0x1f0
> >> [   31.538122]  arm_smmu_iotlb_sync+0x2c/0x38
> >> [   31.542200]  iommu_unmap+0x60/0x90
> >> [   31.545585]  __iommu_map+0x110/0x1f0
> >> [   31.549144]
> iommu_create_device_direct_mappings.isra.34+0x1ac/0x250
> >> [   31.555468]  iommu_probe_device+0x6c/0x110
> >> [   31.559551]  iort_iommu_configure_id+0x114/0x218
> >> [   31.564148]  acpi_dma_configure_id+0x94/0xe0
> >> [   31.568402]  pci_dma_configure+0xc8/0xf0
> >> [   31.572310]  really_probe+0xd4/0x3e0
> >> [   31.575871]  driver_probe_device+0x5c/0xc0
> >>
> >> ---
> >>   drivers/iommu/iommu.c | 10 ++++++----
> >>   1 file changed, 6 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> >> index b53446bb8c6b..0f4dc25d46c9 100644
> >> --- a/drivers/iommu/iommu.c
> >> +++ b/drivers/iommu/iommu.c
> >> @@ -264,16 +264,18 @@ int iommu_probe_device(struct device *dev)
> >>   	 */
> >>   	iommu_alloc_default_domain(group, dev);
> >>
> >> -	if (group->default_domain)
> >> +	if (group->default_domain) {
> >>   		ret = __iommu_attach_device(group->default_domain, dev);
> >> +		if (ret) {
> >> +			iommu_group_put(group);
> >> +			goto err_release;
> >> +		}
> >> +	}
> >
> > This looks sensible to me, but what I don't understand is where that
> > NULL pointer is coming from in the first place. iommu_map() operates
> > on the domain, so why does it matter if the attach fails? What is being
> > accessed at arm_smmu_tlb_inv_range+0x178/0x1f0 ?
> 
> Probably because the domain is a hollow fake until the first successful
> attach - even TLB maintenance depends on having decided a pagetable format.

I think, in this particular instance, what happens is, dev reports RMR
regions (IOMMU_RESV_DIRECT) but attach_dev() fails early without
setting, smmu_domain->smmu  =  smmu.

iommu_probe_device()
  __iommu_attach_dev()  -->return err, but carries on.
  iommu_create_device_direct_mappings()
    iommu_get_resv_regions()  --> dev has IOMMU_RESV_DIRECT regions
    iommu_map()  
      __iommu_map()   
        arm_smmu_map()  -->return err
      iommu_unmap()    --> unroll on map failure
        __iommu_unmap()  --> size is zero. So returns.
        iommu_iotlb_sync()
          arm_smmu_iotlb_sync()
            arm_smmu_tlb_inv_range()  --> smmu is NULL

Thanks,
Shameer 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
