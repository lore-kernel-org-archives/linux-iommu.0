Return-Path: <SRS0=HAoA=WF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54720C433FF
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 05:37:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E4522089E
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 05:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4522089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C0C5FC6A;
	Fri,  9 Aug 2019 05:37:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2919BB9E
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 05:37:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AE9FF67F
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 05:37:52 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	08 Aug 2019 22:37:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,364,1559545200"; d="scan'208";a="169215317"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga008.jf.intel.com with ESMTP; 08 Aug 2019 22:37:49 -0700
Subject: Re: [PATCH 1/1] iommu/vt-d: Correctly check format of page table in
	debugfs
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
References: <20190720020126.9974-1-baolu.lu@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f5740e9e-cdd0-8aee-a099-f32b6c6da498@linux.intel.com>
Date: Fri, 9 Aug 2019 13:36:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190720020126.9974-1-baolu.lu@linux.intel.com>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Joerg,

Just a friendly reminder. What do you think of this fix?

Best regards,
Lu Baolu

On 7/20/19 10:01 AM, Lu Baolu wrote:
> PASID support and enable bit in the context entry isn't the right
> indicator for the type of tables (legacy or scalable mode). Check
> the DMA_RTADDR_SMT bit in the root context pointer instead.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Sai Praneeth <sai.praneeth.prakhya@intel.com>
> Fixes: dd5142ca5d24b ("iommu/vt-d: Add debugfs support to show scalable mode DMAR table internals")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel-iommu-debugfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu-debugfs.c b/drivers/iommu/intel-iommu-debugfs.c
> index 73a552914455..e31c3b416351 100644
> --- a/drivers/iommu/intel-iommu-debugfs.c
> +++ b/drivers/iommu/intel-iommu-debugfs.c
> @@ -235,7 +235,7 @@ static void ctx_tbl_walk(struct seq_file *m, struct intel_iommu *iommu, u16 bus)
>   		tbl_wlk.ctx_entry = context;
>   		m->private = &tbl_wlk;
>   
> -		if (pasid_supported(iommu) && is_pasid_enabled(context)) {
> +		if (dmar_readq(iommu->reg + DMAR_RTADDR_REG) & DMA_RTADDR_SMT) {
>   			pasid_dir_ptr = context->lo & VTD_PAGE_MASK;
>   			pasid_dir_size = get_pasid_dir_size(context);
>   			pasid_dir_walk(m, pasid_dir_ptr, pasid_dir_size);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
