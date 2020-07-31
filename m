Return-Path: <SRS0=v9UM=BK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B955C433DF
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 12:30:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D737206FA
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 12:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D737206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C721D88677;
	Fri, 31 Jul 2020 12:30:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id guqHE8bWwEoa; Fri, 31 Jul 2020 12:30:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A31848866F;
	Fri, 31 Jul 2020 12:30:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7EC4AC004F;
	Fri, 31 Jul 2020 12:30:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 985A8C004D
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 12:30:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8531B88672
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 12:30:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aLSoh7W15NZV for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 12:30:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by whitealder.osuosl.org (Postfix) with ESMTPS id AA3378866F
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 12:30:38 +0000 (UTC)
Received: from dggemi404-hub.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id CB381A90D0710C76F342;
 Fri, 31 Jul 2020 20:30:34 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.120]) by
 dggemi404-hub.china.huawei.com ([10.3.17.142]) with mapi id 14.03.0487.000;
 Fri, 31 Jul 2020 20:30:27 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Will Deacon <will@kernel.org>
Subject: RE: [PATCH v2] iommu/arm-smmu-v3: disable MSI polling if SEV
 polling is faster
Thread-Topic: [PATCH v2] iommu/arm-smmu-v3: disable MSI polling if SEV
 polling is faster
Thread-Index: AQHWZxWmNQkz6uwX10qDXyIfMcuen6kg9FsAgACJfxD//5gzAIAAhubA
Date: Fri, 31 Jul 2020 12:30:27 +0000
Message-ID: <B926444035E5E2439431908E3842AFD25D003C@DGGEMI525-MBS.china.huawei.com>
References: <20200731083343.18152-1-song.bao.hua@hisilicon.com>
 <a425bd85-4872-bf1a-d273-c605c68fa9e1@huawei.com>
 <B926444035E5E2439431908E3842AFD25CFDC3@DGGEMI525-MBS.china.huawei.com>
 <20200731122149.GA26817@willie-the-truck>
In-Reply-To: <20200731122149.GA26817@willie-the-truck>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.221]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: Linuxarm <linuxarm@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
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
> From: Will Deacon [mailto:will@kernel.org]
> Sent: Saturday, August 1, 2020 12:22 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: John Garry <john.garry@huawei.com>; robin.murphy@arm.com;
> joro@8bytes.org; iommu@lists.linux-foundation.org; Zengtao (B)
> <prime.zeng@hisilicon.com>; Linuxarm <linuxarm@huawei.com>;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v2] iommu/arm-smmu-v3: disable MSI polling if SEV
> polling is faster
> 
> On Fri, Jul 31, 2020 at 10:48:33AM +0000, Song Bao Hua (Barry Song) wrote:
> > > -----Original Message-----
> > > From: John Garry
> > > Sent: Friday, July 31, 2020 10:21 PM
> > > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> will@kernel.org;
> > > robin.murphy@arm.com; joro@8bytes.org;
> iommu@lists.linux-foundation.org
> > > Cc: Zengtao (B) <prime.zeng@hisilicon.com>; Linuxarm
> > > <linuxarm@huawei.com>; linux-arm-kernel@lists.infradead.org
> > > Subject: Re: [PATCH v2] iommu/arm-smmu-v3: disable MSI polling if SEV
> > > polling is faster
> > >
> > > On 31/07/2020 09:33, Barry Song wrote:
> > > > Different implementations may show different performance by using SEV
> > > > polling or MSI polling.
> > > > On the implementation of hi1620, tests show disabling MSI polling can
> > > > bring performance improvement.
> > > > Using 16 threads to run netperf on hns3 100G NIC with UDP packet size
> > > > in 32768bytes and set iommu to strict, TX throughput can improve from
> > > > 25Gbps to 27Gbps by this patch.
> > > > This patch adds a generic function to support implementation options
> > > > based on IIDR and disables MSI polling if IIDR matches the specific
> > > > implementation tested.
> > > Not sure if we should do checks like this on an implementation basis.
> > > I'm sure maintainers will decide.
> >
> > Yes, maintainers will decide. I guess Will won't object to IIDR-based solution
> according to
> > previous discussion threads:
> > https://lore.kernel.org/patchwork/patch/783718/
> >
> > Am I right, Will?
> 
> Honestly, I object to the whole idea that we should turn off optional
> hardware features just because they're slow. Did nobody take time to look at
> the design and check that it offered some benefit, or where they in too much
> of a hurry to tick the checkbox to say they had the new feature? I really
> dislike the pick and mix nature that some of this IP is heading in, where
> the marketing folks want a slice of everything for the branding, instead of
> doing a few useful things well. Anyway, that's not your fault, so I'll stop
> moaning. *sigh*
> 
> Given that you've baked this thing now, then if we have to support it I
> would prefer the command-line option. At least that means that people can
> compare the performance with it on and off (and hopefully make sure the
> hardware doesn't suck). It also means it's not specific to ACPI.

Hi Will,
Thanks for your comment. I had a patch with command line option as below.
If it is what you prefer, I'd refine this one and send.

[PATCH] iommu/arm-smmu-v3: permit users to disable msi polling
---
 drivers/iommu/arm-smmu-v3.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f578677a5c41..4fb1681308e4 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -418,6 +418,11 @@ module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_bypass,
 	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
 
+static bool disable_msipolling = 1;
+module_param_named(disable_msipolling, disable_msipolling, bool, S_IRUGO);
+MODULE_PARM_DESC(disable_msipolling,
+	"Don't use MSI to poll the completion of CMD_SYNC if it is slower than SEV");
+
 enum pri_resp {
 	PRI_RESP_DENY = 0,
 	PRI_RESP_FAIL = 1,
@@ -992,7 +997,7 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 	 * Beware that Hi16xx adds an extra 32 bits of goodness to its MSI
 	 * payload, so the write will zero the entire command on that platform.
 	 */
-	if (smmu->features & ARM_SMMU_FEAT_MSI &&
+	if (!disable_msipolling && smmu->features & ARM_SMMU_FEAT_MSI &&
 	    smmu->features & ARM_SMMU_FEAT_COHERENCY) {
 		ent.sync.msiaddr = q->base_dma + Q_IDX(&q->llq, prod) *
 				   q->ent_dwords * 8;
@@ -1332,7 +1337,7 @@ static int __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
 static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
 					 struct arm_smmu_ll_queue *llq)
 {
-	if (smmu->features & ARM_SMMU_FEAT_MSI &&
+	if (!disable_msipolling && smmu->features & ARM_SMMU_FEAT_MSI &&
 	    smmu->features & ARM_SMMU_FEAT_COHERENCY)
 		return __arm_smmu_cmdq_poll_until_msi(smmu, llq);
 
-- 
2.27.0

Thanks
Barry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
