Return-Path: <SRS0=xT8t=45=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E82C10DCE
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 12:02:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93223206E7
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 12:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93223206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6690E88B32;
	Thu, 12 Mar 2020 12:02:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ThhqSC21ZIIK; Thu, 12 Mar 2020 12:02:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A961E88B0B;
	Thu, 12 Mar 2020 12:02:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 923D4C18D3;
	Thu, 12 Mar 2020 12:02:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEA3AC0177
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 12:02:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C8BDD26735
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 12:02:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id veiGZLSY5wHF for <iommu@lists.linux-foundation.org>;
 Thu, 12 Mar 2020 12:02:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by silver.osuosl.org (Postfix) with ESMTPS id 871062663D
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 12:02:45 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Mar 2020 05:02:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; d="scan'208";a="442027339"
Received: from unknown (HELO [10.254.208.137]) ([10.254.208.137])
 by fmsmga005.fm.intel.com with ESMTP; 12 Mar 2020 05:02:42 -0700
Subject: Re: [PATCH] iommu/vt-d: Unlock on error paths
To: Dan Carpenter <dan.carpenter@oracle.com>,
 David Woodhouse <dwmw2@infradead.org>, Megha Dey <megha.dey@linux.intel.com>
References: <20200312113730.GF20562@mwanda>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0f0dcaca-5c33-c78c-6d38-2bbae26cbff2@linux.intel.com>
Date: Thu, 12 Mar 2020 20:02:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312113730.GF20562@mwanda>
Content-Language: en-US
Cc: kernel-janitors@vger.kernel.org, iommu@lists.linux-foundation.org
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

On 2020/3/12 19:37, Dan Carpenter wrote:
> There were a couple places where we need to unlock before returning.
> 
> Fixes: 91391b919e19 ("iommu/vt-d: Populate debugfs if IOMMUs are detected")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   drivers/iommu/intel-iommu-debugfs.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu-debugfs.c b/drivers/iommu/intel-iommu-debugfs.c
> index 8d24c4d85cc2..6a495b103972 100644
> --- a/drivers/iommu/intel-iommu-debugfs.c
> +++ b/drivers/iommu/intel-iommu-debugfs.c
> @@ -289,11 +289,12 @@ static int dmar_translation_struct_show(struct seq_file *m, void *unused)
>   		sts = dmar_readl(iommu->reg + DMAR_GSTS_REG);
>   		if (!(sts & DMA_GSTS_TES)) {
>   			seq_puts(m, "DMA Remapping is not enabled\n");
> -			return 0;
> +			goto unlock;
>   		}
>   		root_tbl_walk(m, iommu);
>   		seq_putc(m, '\n');
>   	}
> +unlock:
>   	rcu_read_unlock();
>   
>   	return 0;
> @@ -444,7 +445,7 @@ static int ir_translation_struct_show(struct seq_file *m, void *unused)
>   		sts = dmar_readl(iommu->reg + DMAR_GSTS_REG);
>   		if (!(sts & DMA_GSTS_IRES)) {
>   			seq_puts(m, "Interrupt Remapping is not enabled\n");
> -			return 0;
> +			goto unlock;
>   		}
>   
>   		if (iommu->ir_table) {
> @@ -475,6 +476,7 @@ static int ir_translation_struct_show(struct seq_file *m, void *unused)
>   		}
>   		seq_putc(m, '\n');
>   	}
> +unlock:
>   	rcu_read_unlock();
>   
>   	return 0;
> 

Thanks a lot for the catch. I think it could be further cleanup. How
about below changes?

index 8d24c4d85cc2..2583a6743dd0 100644
--- a/drivers/iommu/intel-iommu-debugfs.c
+++ b/drivers/iommu/intel-iommu-debugfs.c
@@ -288,8 +288,9 @@ static int dmar_translation_struct_show(struct 
seq_file *m, void *unused)
         for_each_active_iommu(iommu, drhd) {
                 sts = dmar_readl(iommu->reg + DMAR_GSTS_REG);
                 if (!(sts & DMA_GSTS_TES)) {
-                       seq_puts(m, "DMA Remapping is not enabled\n");
-                       return 0;
+                       seq_printf(m, "DMA Remapping is not enabled on 
%s\n",
+                                  iommu->name);
+                       continue;
                 }
                 root_tbl_walk(m, iommu);
                 seq_putc(m, '\n');
@@ -431,7 +432,6 @@ static int ir_translation_struct_show(struct 
seq_file *m, void *unused)
         struct dmar_drhd_unit *drhd;
         struct intel_iommu *iommu;
         u64 irta;
-       u32 sts;

         rcu_read_lock();
         for_each_active_iommu(iommu, drhd) {
@@ -441,12 +441,6 @@ static int ir_translation_struct_show(struct 
seq_file *m, void *unused)
                 seq_printf(m, "Remapped Interrupt supported on IOMMU: 
%s\n",
                            iommu->name);

-               sts = dmar_readl(iommu->reg + DMAR_GSTS_REG);
-               if (!(sts & DMA_GSTS_IRES)) {
-                       seq_puts(m, "Interrupt Remapping is not enabled\n");
-                       return 0;
-               }
-
                 if (iommu->ir_table) {
                         irta = virt_to_phys(iommu->ir_table->base);
                         seq_printf(m, " IR table address:%llx\n", irta);

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
