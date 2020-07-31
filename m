Return-Path: <SRS0=v9UM=BK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2392C433E0
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 10:48:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B724C20838
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 10:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B724C20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9423A88738;
	Fri, 31 Jul 2020 10:48:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8NOsTUm-eceN; Fri, 31 Jul 2020 10:48:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D3B0B886FE;
	Fri, 31 Jul 2020 10:48:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C74D3C004F;
	Fri, 31 Jul 2020 10:48:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2481C004D
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 10:48:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C0B4F88640
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 10:48:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HhJRVJcEM2Sn for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 10:48:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B8A8288423
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 10:48:47 +0000 (UTC)
Received: from dggemi401-hub.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 63CFF7CDCE33473D0FFC;
 Fri, 31 Jul 2020 18:48:42 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.120]) by
 dggemi401-hub.china.huawei.com ([10.3.17.134]) with mapi id 14.03.0487.000;
 Fri, 31 Jul 2020 18:48:33 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: John Garry <john.garry@huawei.com>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
 <joro@8bytes.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v2] iommu/arm-smmu-v3: disable MSI polling if SEV
 polling is faster
Thread-Topic: [PATCH v2] iommu/arm-smmu-v3: disable MSI polling if SEV
 polling is faster
Thread-Index: AQHWZxWmNQkz6uwX10qDXyIfMcuen6kg9FsAgACJfxA=
Date: Fri, 31 Jul 2020 10:48:33 +0000
Message-ID: <B926444035E5E2439431908E3842AFD25CFDC3@DGGEMI525-MBS.china.huawei.com>
References: <20200731083343.18152-1-song.bao.hua@hisilicon.com>
 <a425bd85-4872-bf1a-d273-c605c68fa9e1@huawei.com>
In-Reply-To: <a425bd85-4872-bf1a-d273-c605c68fa9e1@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.132]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Linuxarm <linuxarm@huawei.com>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>
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
> From: John Garry
> Sent: Friday, July 31, 2020 10:21 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; will@kernel.org;
> robin.murphy@arm.com; joro@8bytes.org; iommu@lists.linux-foundation.org
> Cc: Zengtao (B) <prime.zeng@hisilicon.com>; Linuxarm
> <linuxarm@huawei.com>; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v2] iommu/arm-smmu-v3: disable MSI polling if SEV
> polling is faster
> 
> On 31/07/2020 09:33, Barry Song wrote:
> > Different implementations may show different performance by using SEV
> > polling or MSI polling.
> > On the implementation of hi1620, tests show disabling MSI polling can
> > bring performance improvement.
> > Using 16 threads to run netperf on hns3 100G NIC with UDP packet size
> > in 32768bytes and set iommu to strict, TX throughput can improve from
> > 25Gbps to 27Gbps by this patch.
> > This patch adds a generic function to support implementation options
> > based on IIDR and disables MSI polling if IIDR matches the specific
> > implementation tested.
> Not sure if we should do checks like this on an implementation basis.
> I'm sure maintainers will decide.

Yes, maintainers will decide. I guess Will won't object to IIDR-based solution according to
previous discussion threads:
https://lore.kernel.org/patchwork/patch/783718/

Am I right, Will?

> 
> >
> > Cc: Prime Zeng <prime.zeng@hisilicon.com>
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > ---
> >   -v2: rather than disabling msipolling globally, only disable it for
> >   specific implementation based on IIDR
> >
> >   drivers/iommu/arm-smmu-v3.c | 31 +++++++++++++++++++++++++++++--
> 
> this file has moved, check linux-next

Thanks for reminding. Hopefully Will or Robin can give some feedback so that the v3 can come to fix this
as well as other issues they might point out.

> 
> >   1 file changed, 29 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > index f578677a5c41..ed5a6774eb45 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -88,6 +88,12 @@
> >   #define IDR5_VAX			GENMASK(11, 10)
> >   #define IDR5_VAX_52_BIT			1
> >
> > +#define ARM_SMMU_IIDR			0x18
> > +#define IIDR_VARIANT			GENMASK(19, 16)
> > +#define IIDR_REVISION			GENMASK(15, 12)
> > +#define IIDR_IMPLEMENTER		GENMASK(11, 0)
> > +#define IMPLEMENTER_HISILICON		0x736
> > +
> >   #define ARM_SMMU_CR0			0x20
> >   #define CR0_ATSCHK			(1 << 4)
> >   #define CR0_CMDQEN			(1 << 3)
> > @@ -652,6 +658,7 @@ struct arm_smmu_device {
> >
> >   #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> >   #define ARM_SMMU_OPT_PAGE0_REGS_ONLY	(1 << 1)
> > +#define ARM_SMMU_OPT_DISABLE_MSIPOLL    (1 << 2)
> >   	u32				options;
> >
> >   	struct arm_smmu_cmdq		cmdq;
> > @@ -992,7 +999,8 @@ static void arm_smmu_cmdq_build_sync_cmd(u64
> *cmd, struct arm_smmu_device *smmu,
> >   	 * Beware that Hi16xx adds an extra 32 bits of goodness to its MSI
> >   	 * payload, so the write will zero the entire command on that platform.
> >   	 */
> > -	if (smmu->features & ARM_SMMU_FEAT_MSI &&
> > +	if (!(smmu->options & ARM_SMMU_OPT_DISABLE_MSIPOLL) &&
> > +	    smmu->features & ARM_SMMU_FEAT_MSI &&
> 
> I don't know why you check MSIPOLL disabled and then MSI poll supported.
> Surely for native non-MSI poll (like hi1616), the ARM_SMMU_FEAT_MSI
> check first makes sense. This is fastpath, albeit fast to maybe wait..

I was thinking !(smmu->options & ARM_SMMU_OPT_DISABLE_MSIPOLL) is the fast path
for 1620 as it can jump out quickly.

But yes, you are right since there are many other SMMU not only 1620.


> 
> >   	    smmu->features & ARM_SMMU_FEAT_COHERENCY) {
> >   		ent.sync.msiaddr = q->base_dma + Q_IDX(&q->llq, prod) *
> >   				   q->ent_dwords * 8;
> > @@ -1332,7 +1340,8 @@ static int
> __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
> >   static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device
> *smmu,
> >   					 struct arm_smmu_ll_queue *llq)
> >   {
> > -	if (smmu->features & ARM_SMMU_FEAT_MSI &&
> > +	if (!(smmu->options & ARM_SMMU_OPT_DISABLE_MSIPOLL) &&
> > +	    smmu->features & ARM_SMMU_FEAT_MSI &&
> >   	    smmu->features & ARM_SMMU_FEAT_COHERENCY)
> >   		return __arm_smmu_cmdq_poll_until_msi(smmu, llq);
> >
> > @@ -3693,6 +3702,21 @@ static int arm_smmu_device_reset(struct
> arm_smmu_device *smmu, bool bypass)
> >   	return 0;
> >   }
> >
> > +static void acpi_smmu_get_implementation_options(struct
> arm_smmu_device *smmu)
> > +{
> > +	/*
> > +	 * IIDR provides information about the implementation and implementer
> of
> > +	 * the SMMU
> > +	 */
> > +	u32 iidr = readl_relaxed(smmu->base + ARM_SMMU_IIDR);
> > +	u32 implementer = FIELD_GET(IIDR_IMPLEMENTER, iidr);
> > +	u32 variant = FIELD_GET(IIDR_VARIANT, iidr);
> > +	u32 revision = FIELD_GET(IIDR_REVISION, iidr);
> 
> why not check the product ID also, i.e. the complete register contents?

Ideally, we can use variant and revision to differentiate all 1616, 1620, 1630 and so on.
All of them should get different values for the combination of variant and revision.
However, I will think more about other fields as you are suggesting.

> 
> > +
> > +	if (implementer == IMPLEMENTER_HISILICON && variant == 3 && revision
> == 0)
> > +		smmu->options |= ARM_SMMU_OPT_DISABLE_MSIPOLL;
> > +}
> > +
> >   static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
> >   {
> >   	u32 reg;
> > @@ -3892,6 +3916,9 @@ static int arm_smmu_device_hw_probe(struct
> arm_smmu_device *smmu)
> >
> >   	smmu->ias = max(smmu->ias, smmu->oas);
> >
> > +	/* set implementation-related options according to IIDR */
> > +	acpi_smmu_get_implementation_options(smmu);
> > +
> >   	dev_info(smmu->dev, "ias %lu-bit, oas %lu-bit (features 0x%08x)\n",
> >   		 smmu->ias, smmu->oas, smmu->features);
> >   	return 0;
> >

Thanks
Barry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
