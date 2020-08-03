Return-Path: <SRS0=54Vi=BN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57149C433E0
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 20:40:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5147C2086A
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 20:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5147C2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DE98C85D50;
	Mon,  3 Aug 2020 20:40:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SO-wKOkUlWt9; Mon,  3 Aug 2020 20:40:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C6CED85C2E;
	Mon,  3 Aug 2020 20:40:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9D92C0050;
	Mon,  3 Aug 2020 20:40:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F01DC004C
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 20:40:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 63D90863A8
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 20:40:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YiynZioB5bQJ for <iommu@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:40:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by whitealder.osuosl.org (Postfix) with ESMTPS id AA22C86397
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 20:40:20 +0000 (UTC)
Received: from dggemi402-hub.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 6BCB6EA8B5711CE6AE3B;
 Tue,  4 Aug 2020 04:40:17 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.120]) by
 dggemi402-hub.china.huawei.com ([10.3.17.135]) with mapi id 14.03.0487.000;
 Tue, 4 Aug 2020 04:40:08 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: John Garry <john.garry@huawei.com>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
 <joro@8bytes.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v3] iommu/arm-smmu-v3: permit users to disable MSI polling
Thread-Topic: [PATCH v3] iommu/arm-smmu-v3: permit users to disable MSI polling
Thread-Index: AQHWZ9hLS5n14lsQJ0+MKOr5HNSXxKkmARMAgADRXcA=
Date: Mon, 3 Aug 2020 20:40:07 +0000
Message-ID: <B926444035E5E2439431908E3842AFD25D6826@DGGEMI525-MBS.china.huawei.com>
References: <20200801074703.17108-1-song.bao.hua@hisilicon.com>
 <494d71d4-7718-d09e-9171-b78d6a046cb6@huawei.com>
In-Reply-To: <494d71d4-7718-d09e-9171-b78d6a046cb6@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.45]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
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
> Sent: Tuesday, August 4, 2020 3:34 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; will@kernel.org;
> robin.murphy@arm.com; joro@8bytes.org; iommu@lists.linux-foundation.org
> Cc: Zengtao (B) <prime.zeng@hisilicon.com>;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v3] iommu/arm-smmu-v3: permit users to disable MSI
> polling
> 
> On 01/08/2020 08:47, Barry Song wrote:
> > Polling by MSI isn't necessarily faster than polling by SEV. Tests on
> > hi1620 show hns3 100G NIC network throughput can improve from 25G to
> > 27G if we disable MSI polling while running 16 netperf threads sending
> > UDP packets in size 32KB.
> 
> BTW, Do we have any more results than this? This is just one scenario.
> 

John, it is more than a scenario. Micro-benchmark shows polling by SEV has less latency
than MSI. This motivated me to use a real scenario to verify. For this network case, if we set
thread to 1 rather than 16, network TX through can improve from 7Gbps to 7.7Gbps

> How about your micro-benchmark, which allows you to set the number of
> CPUs?

The micro-benchmark is working like this:
Sending A CMD_SYNC in an empty command queue
Polling the completion of this CMD_SYNC by MSI or SEV.

I have seen the polling latency can decrease by about 80ns. Without this patch,
the latency was about ~270ns, after this patch, it would be about
~190ns.

> 
> Thanks,
> John
> 
> > This patch provides a command line option so that users can decide to
> > use MSI polling or not based on their tests.
> >
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > ---
> >   -v3:
> >    * rebase on top of linux-next as arm-smmu-v3.c has moved;
> >    * provide a command line option
> >
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18
> ++++++++++++++----
> >   1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 7196207be7ea..89d3cb391fef 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -418,6 +418,11 @@ module_param_named(disable_bypass,
> disable_bypass, bool, S_IRUGO);
> >   MODULE_PARM_DESC(disable_bypass,
> >   	"Disable bypass streams such that incoming transactions from devices
> that are not attached to an iommu domain will report an abort back to the
> device and will not be allowed to pass through the SMMU.");
> >
> > +static bool disable_msipolling;
> > +module_param_named(disable_msipolling, disable_msipolling, bool,
> S_IRUGO);
> > +MODULE_PARM_DESC(disable_msipolling,
> > +	"Disable MSI-based polling for CMD_SYNC completion.");
> > +
> >   enum pri_resp {
> >   	PRI_RESP_DENY = 0,
> >   	PRI_RESP_FAIL = 1,
> > @@ -980,6 +985,13 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd,
> struct arm_smmu_cmdq_ent *ent)
> >   	return 0;
> >   }
> >
> > +static bool arm_smmu_use_msipolling(struct arm_smmu_device *smmu)
> > +{
> > +	return !disable_msipolling &&
> > +	       smmu->features & ARM_SMMU_FEAT_COHERENCY &&
> > +	       smmu->features & ARM_SMMU_FEAT_MSI;
> > +}
> > +
> >   static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct
> arm_smmu_device *smmu,
> >   					 u32 prod)
> >   {
> > @@ -992,8 +1004,7 @@ static void arm_smmu_cmdq_build_sync_cmd(u64
> *cmd, struct arm_smmu_device *smmu,
> >   	 * Beware that Hi16xx adds an extra 32 bits of goodness to its MSI
> >   	 * payload, so the write will zero the entire command on that platform.
> >   	 */
> > -	if (smmu->features & ARM_SMMU_FEAT_MSI &&
> > -	    smmu->features & ARM_SMMU_FEAT_COHERENCY) {
> > +	if (arm_smmu_use_msipolling(smmu)) {
> >   		ent.sync.msiaddr = q->base_dma + Q_IDX(&q->llq, prod) *
> >   				   q->ent_dwords * 8;
> >   	}
> > @@ -1332,8 +1343,7 @@ static int
> __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
> >   static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device
> *smmu,
> >   					 struct arm_smmu_ll_queue *llq)
> >   {
> > -	if (smmu->features & ARM_SMMU_FEAT_MSI &&
> > -	    smmu->features & ARM_SMMU_FEAT_COHERENCY)
> > +	if (arm_smmu_use_msipolling(smmu))
> >   		return __arm_smmu_cmdq_poll_until_msi(smmu, llq);
> >
> >   	return __arm_smmu_cmdq_poll_until_consumed(smmu, llq);
> >

Thanks
Barry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
