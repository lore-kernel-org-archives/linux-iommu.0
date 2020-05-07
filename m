Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B5CC38A24
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 16:41:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1150E20936
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 16:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1150E20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D6919885D4;
	Thu,  7 May 2020 16:41:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7vUwHeS13DWL; Thu,  7 May 2020 16:41:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D07578839A;
	Thu,  7 May 2020 16:41:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA210C0865;
	Thu,  7 May 2020 16:41:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAA45C07FF
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 16:41:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A375320491
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 16:41:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qHGSmIUiG3xO for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 16:41:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by silver.osuosl.org (Postfix) with ESMTPS id A7CCE20469
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 16:41:01 +0000 (UTC)
IronPort-SDR: NuBB9MbQF5dZurXsDXfuT+ktxqaLvxV15LhF/YbyPhC7ZHo/1jm3yI+Dfi+Is8vrj5E6m67xxT
 mqHwBMs0mIxw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2020 09:41:00 -0700
IronPort-SDR: y/fdpHUpuRWavjaCIWw/VG9lnFOMSx4/mDNd/RiY3KqeeUtX9aU7JBbcyzHWw5kNUzNIfcmL29
 7V3gnCOklWRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,364,1583222400"; d="scan'208";a="407699732"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga004.jf.intel.com with ESMTP; 07 May 2020 09:40:59 -0700
Date: Thu, 7 May 2020 09:47:06 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 2/5] iommu/vt-d: debugfs: Add support to show inv
 queue internals
Message-ID: <20200507094706.6f6a605f@jacob-builder>
In-Reply-To: <20200507005534.3080-3-baolu.lu@linux.intel.com>
References: <20200507005534.3080-1-baolu.lu@linux.intel.com>
 <20200507005534.3080-3-baolu.lu@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
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

Hi Baolu,

Very helpful feature, thanks for doing this. Just a small suggestion.

On Thu,  7 May 2020 08:55:31 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Export invalidation queue internals of each iommu device through the
> debugfs.
> 
> Example of such dump on a Skylake machine:
> 
> $ sudo cat /sys/kernel/debug/iommu/intel/invalidation_queue
> Invalidation queue on IOMMU: dmar1
>  Base: 0x1672c9000      Head: 80        Tail: 80
> Index           qw0                     qw1                     status
>     0   0000000000000004        0000000000000000
> 0000000000000000 1   0000000200000025        00000001672be804
> 0000000000000000 2   0000000000000011        0000000000000000
> 0000000000000000 3   0000000200000025        00000001672be80c
> 0000000000000000 4   00000000000000d2        0000000000000000
> 0000000000000000 5   0000000200000025        00000001672be814
> 0000000000000000 6   0000000000000014        0000000000000000
> 0000000000000000 7   0000000200000025        00000001672be81c
> 0000000000000000 8   0000000000000014        0000000000000000
> 0000000000000000 9   0000000200000025        00000001672be824
> 0000000000000000
> 
Head and Tail shows the offset, and queue is dump with index. Would it
be nice to mark where the Head and Tail is in the list?
In your example, the queue is empty (H=T), would be nice to see where
the previous entry is if there were any faults.

> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu-debugfs.c | 62
> +++++++++++++++++++++++++++++ 1 file changed, 62 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu-debugfs.c
> b/drivers/iommu/intel-iommu-debugfs.c index
> 3eb1fe240fb0..e3089865b8f3 100644 ---
> a/drivers/iommu/intel-iommu-debugfs.c +++
> b/drivers/iommu/intel-iommu-debugfs.c @@ -372,6 +372,66 @@ static int
> domain_translation_struct_show(struct seq_file *m, void *unused) }
>  DEFINE_SHOW_ATTRIBUTE(domain_translation_struct);
>  
> +static void invalidation_queue_entry_show(struct seq_file *m,
> +					  struct intel_iommu *iommu)
> +{
> +	int index, shift = qi_shift(iommu);
> +	struct qi_desc *desc;
> +	int offset;
> +
> +	if (ecap_smts(iommu->ecap))
> +		seq_puts(m,
> "Index\t\tqw0\t\t\tqw1\t\t\tqw2\t\t\tqw3\t\t\tstatus\n");
> +	else
> +		seq_puts(m, "Index\t\tqw0\t\t\tqw1\t\t\tstatus\n");
> +
> +	for (index = 0; index < QI_LENGTH; index++) {
> +		offset = index << shift;
> +		desc = iommu->qi->desc + offset;
> +		if (ecap_smts(iommu->ecap))
> +			seq_printf(m,
> "%5d\t%016llx\t%016llx\t%016llx\t%016llx\t%016x\n",
> +				   index, desc->qw0, desc->qw1,
> +				   desc->qw2, desc->qw3,
> +				   iommu->qi->desc_status[index]);
> +		else
> +			seq_printf(m,
> "%5d\t%016llx\t%016llx\t%016x\n",
> +				   index, desc->qw0, desc->qw1,
> +				   iommu->qi->desc_status[index]);
> +	}
> +}
> +
> +static int invalidation_queue_show(struct seq_file *m, void *unused)
> +{
> +	struct dmar_drhd_unit *drhd;
> +	struct intel_iommu *iommu;
> +	unsigned long flags;
> +	struct q_inval *qi;
> +	int shift;
> +
> +	rcu_read_lock();
> +	for_each_active_iommu(iommu, drhd) {
> +		qi = iommu->qi;
> +		shift = qi_shift(iommu);
> +
> +		if (!qi || !ecap_qis(iommu->ecap))
> +			continue;
> +
> +		seq_printf(m, "Invalidation queue on IOMMU: %s\n",
> iommu->name); +
> +		raw_spin_lock_irqsave(&qi->q_lock, flags);
> +		seq_printf(m, " Base: 0x%llx\tHead: %lld\tTail:
> %lld\n",
> +			   virt_to_phys(qi->desc),
> +			   dmar_readq(iommu->reg + DMAR_IQH_REG) >>
> shift,
> +			   dmar_readq(iommu->reg + DMAR_IQT_REG) >>
> shift);
> +		invalidation_queue_entry_show(m, iommu);
> +		raw_spin_unlock_irqrestore(&qi->q_lock, flags);
> +		seq_putc(m, '\n');
> +	}
> +	rcu_read_unlock();
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(invalidation_queue);
> +
>  #ifdef CONFIG_IRQ_REMAP
>  static void ir_tbl_remap_entry_show(struct seq_file *m,
>  				    struct intel_iommu *iommu)
> @@ -490,6 +550,8 @@ void __init intel_iommu_debugfs_init(void)
>  	debugfs_create_file("domain_translation_struct", 0444,
>  			    intel_iommu_debug, NULL,
>  			    &domain_translation_struct_fops);
> +	debugfs_create_file("invalidation_queue", 0444,
> intel_iommu_debug,
> +			    NULL, &invalidation_queue_fops);
>  #ifdef CONFIG_IRQ_REMAP
>  	debugfs_create_file("ir_translation_struct", 0444,
> intel_iommu_debug, NULL, &ir_translation_struct_fops);

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
