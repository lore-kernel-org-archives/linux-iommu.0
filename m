Return-Path: <SRS0=qNYd=BA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D410C433E3
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 00:45:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B7BD21702
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 00:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7BD21702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2C49888306;
	Tue, 21 Jul 2020 00:45:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vb+RDUQl9DZn; Tue, 21 Jul 2020 00:45:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A04E5882FB;
	Tue, 21 Jul 2020 00:45:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EA56C0894;
	Tue, 21 Jul 2020 00:45:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76413C016F
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 00:44:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6893E879AE
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 00:44:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5xlg03aJQQlR for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jul 2020 00:44:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5F21387AB6
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 00:44:57 +0000 (UTC)
Received: from dggemi405-hub.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id 64B9F1A9C7F0854BB155;
 Tue, 21 Jul 2020 08:44:51 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.52]) by
 dggemi405-hub.china.huawei.com ([10.3.17.143]) with mapi id 14.03.0487.000;
 Tue, 21 Jul 2020 08:44:42 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH] iommu/arm-smmu-v3: remove the approach of MSI polling
 for CMD SYNC
Thread-Topic: [PATCH] iommu/arm-smmu-v3: remove the approach of MSI polling
 for CMD SYNC
Thread-Index: AQHWW8YiwSsIgpwKv0qM0ZdQNf6ByakK8iGAgACG1CCABb020A==
Date: Tue, 21 Jul 2020 00:44:41 +0000
Message-ID: <B926444035E5E2439431908E3842AFD259BC6B@DGGEMI525-MBS.china.huawei.com>
References: <20200716230709.32820-1-song.bao.hua@hisilicon.com>
 <35b54698-bd43-a8fc-00db-94ee0dfc789f@arm.com> 
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.37]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linuxarm <linuxarm@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 "will@kernel.org" <will@kernel.org>,
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
> From: Song Bao Hua (Barry Song)
> Sent: Friday, July 17, 2020 9:06 PM
> To: 'Robin Murphy' <robin.murphy@arm.com>; will@kernel.org;
> joro@8bytes.org
> Cc: linux-kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>;
> linux-arm-kernel@lists.infradead.org; iommu@lists.linux-foundation.org;
> Zengtao (B) <prime.zeng@hisilicon.com>
> Subject: RE: [PATCH] iommu/arm-smmu-v3: remove the approach of MSI
> polling for CMD SYNC
> 
> 
> 
> > -----Original Message-----
> > From: Robin Murphy [mailto:robin.murphy@arm.com]
> > Sent: Friday, July 17, 2020 8:55 PM
> > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> will@kernel.org;
> > joro@8bytes.org
> > Cc: linux-kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>;
> > linux-arm-kernel@lists.infradead.org; iommu@lists.linux-foundation.org;
> > Zengtao (B) <prime.zeng@hisilicon.com>
> > Subject: Re: [PATCH] iommu/arm-smmu-v3: remove the approach of MSI
> > polling for CMD SYNC
> >
> > On 2020-07-17 00:07, Barry Song wrote:
> > > Before commit 587e6c10a7ce ("iommu/arm-smmu-v3: Reduce contention
> > during
> > > command-queue insertion"), msi polling perhaps performed better since
> > > it could run outside the spin_lock_irqsave() while the code polling cons
> > > reg was running in the lock.
> > >
> > > But after the great reorganization of smmu queue, neither of these two
> > > polling methods are running in a spinlock. And real tests show polling
> > > cons reg via sev means smaller latency. It is probably because polling
> > > by msi will ask hardware to write memory but sev polling depends on the
> > > update of register only.
> > >
> > > Using 16 threads to run netperf on hns3 100G NIC with UDP packet size
> > > in 32768bytes and set iommu to strict, TX throughput can improve from
> > > 25227.74Mbps to 27145.59Mbps by this patch. In this case, SMMU is
> super
> > > busy as hns3 sends map/unmap requests extremely frequently.
> >
> > How many different systems and SMMU implementations are those numbers
> > representative of? Given that we may have cases where the SMMU can use
> > MSIs but can't use SEV, so would have to fall back to inefficient
> > busy-polling, I'd be wary of removing this entirely. Allowing particular
> > platforms or SMMU implementations to suppress MSI functionality if they
> > know for sure it makes sense seems like a safer bet.
> >
> Hello Robin,
> 
> Thanks for taking a look. Actually I was really struggling with the good way to
> make every platform happy.
> And I don't have other platforms to test and check if those platforms run
> better by sev polling. Even two
> platforms have completely same SMMU features, it is still possible they
> behave differently.
> So I simply sent this patch to get the discussion started to get opinions.
> 
> At the first beginning, I wanted to have a module parameter for users to decide
> if msi polling should be disabled.
> But the module parameter might be totally ignored by linux distro.
> 
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -418,6 +418,11 @@ module_param_named(disable_bypass,
> disable_bypass, bool, S_IRUGO);  MODULE_PARM_DESC(disable_bypass,
>  	"Disable bypass streams such that incoming transactions from devices
> that are not attached to an iommu domain will report an abort back to the
> device and will not be allowed to pass through the SMMU.");
> 
> +static bool disable_msipolling = 1;
> +module_param_named(disable_msipolling, disable_msipolling, bool,
> +S_IRUGO); MODULE_PARM_DESC(disable_msipolling,
> +	"Don't use MSI to poll the completion of CMD_SYNC if it is slower than
> +SEV");
> +
>  enum pri_resp {
>  	PRI_RESP_DENY = 0,
>  	PRI_RESP_FAIL = 1,
> @@ -992,7 +997,7 @@ static void arm_smmu_cmdq_build_sync_cmd(u64
> *cmd, struct arm_smmu_device *smmu,
>  	 * Beware that Hi16xx adds an extra 32 bits of goodness to its MSI
>  	 * payload, so the write will zero the entire command on that platform.
>  	 */
> -	if (smmu->features & ARM_SMMU_FEAT_MSI &&
> +	if (!disable_msipolling && smmu->features & ARM_SMMU_FEAT_MSI &&
>  	    smmu->features & ARM_SMMU_FEAT_COHERENCY) {
>  		ent.sync.msiaddr = q->base_dma + Q_IDX(&q->llq, prod) *
>  				   q->ent_dwords * 8;
> @@ -1332,7 +1337,7 @@ static int
> __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
> static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
>  					 struct arm_smmu_ll_queue *llq)
>  {
> -	if (smmu->features & ARM_SMMU_FEAT_MSI &&
> +	if (!disable_msipolling && smmu->features & ARM_SMMU_FEAT_MSI &&
>  	    smmu->features & ARM_SMMU_FEAT_COHERENCY)
>  		return __arm_smmu_cmdq_poll_until_msi(smmu, llq);
> 
> 
> Another option is that we don't use module parameter, alternatively, we check
> the vendor/chip ID,
> if the chip has better performance on sev polling, it may set disable_msipolling
> to true.
> 
> You are very welcome to give your suggestions.

A possible way to do some chip-specific configuration would be setting smmu->options according to model ID:

static void acpi_smmu_get_options(u32 model, struct arm_smmu_device *smmu)
{
	switch (model) {
	case ACPI_IORT_SMMU_V3_CAVIUM_CN99XX:
		smmu->options |= ARM_SMMU_OPT_PAGE0_REGS_ONLY;
		break;
	case ACPI_IORT_SMMU_V3_HISILICON_HI161X:
		smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
		break;
+	case ACPI_IORT_SMMU_V3_HISILICON_HI162X:
+		smmu->options |= ARM_SMMU_OPT_DISABLE_MSIPOLL;
+		break;
	}

	dev_notice(smmu->dev, "option mask 0x%x\n", smmu->options);
}

I dumped the model id, but unluckily the id is just zero.

#define ACPI_IORT_SMMU_V3_GENERIC           0x00000000	/* Generic SMMUv3 */

Robin, 
would you like to think applying for a new model ID is a right way to set this chip-specific option?

Thanks
Barry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
