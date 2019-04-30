Return-Path: <SRS0=Kg+4=TA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0F7C43219
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 17:58:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04CA221670
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 17:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CA221670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AC2FC1EF8;
	Tue, 30 Apr 2019 17:58:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 96FE21EF2
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 17:58:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 449F25F4
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 17:58:23 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	30 Apr 2019 10:58:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,414,1549958400"; d="scan'208";a="166347217"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by fmsmga002.fm.intel.com with ESMTP; 30 Apr 2019 10:58:22 -0700
Date: Tue, 30 Apr 2019 11:01:08 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH] iommu/vt-d: Fix intel_pasid_max_id
Message-ID: <20190430110108.7c751195@jacob-builder>
In-Reply-To: <20190430072940.10467-1-eric.auger@redhat.com>
References: <20190430072940.10467-1-eric.auger@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	dwmw2@infradead.org, eric.auger.pro@gmail.com
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190430180108.nXnGHP0JVMKPrYLufrXGKCBcv6dfygSTZxt4kT10su8@z>

On Tue, 30 Apr 2019 09:29:40 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Extended Capability Register PSS field (PASID Size Supported)
> corresponds to the PASID bit size -1.
> 
> "A value of N in this field indicates hardware supports PASID
> field of N+1 bits (For example, value of 7 in this field,
> indicates 8-bit PASIDs are supported)".
> 
> Fix the computation of intel_pasid_max_id accordingly.
> 
> Fixes: 562831747f62 ("iommu/vt-d: Global PASID name space")
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/iommu/intel-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 28cb713d728c..c3f1bfc81d2e 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3331,7 +3331,7 @@ static int __init init_dmars(void)
>  		 * than the smallest supported.
>  		 */
>  		if (pasid_supported(iommu)) {
> -			u32 temp = 2 << ecap_pss(iommu->ecap);
> +			u32 temp = 2 << (ecap_pss(iommu->ecap) + 1);
here it is "2 << bits" not "1 << bits", so the original code is correct.

But I agree it would be more clear to the spec. if we do:
1 << (ecap_pss(iommu->ecap) + 1);
>  
>  			intel_pasid_max_id = min_t(u32, temp,
>  						   intel_pasid_max_id);

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
