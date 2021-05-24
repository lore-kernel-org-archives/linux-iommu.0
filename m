Return-Path: <SRS0=7UOM=KT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6218AC2B9F8
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 18:51:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0384E61413
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 18:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0384E61413
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B372182A4E;
	Mon, 24 May 2021 18:51:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HFZxI8jN9B1f; Mon, 24 May 2021 18:51:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B708835EF;
	Mon, 24 May 2021 18:51:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7302DC000D;
	Mon, 24 May 2021 18:51:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE6B6C0001
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 18:51:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB5F14044C
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 18:51:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VVyJ5XIdqbf0 for <iommu@lists.linux-foundation.org>;
 Mon, 24 May 2021 18:51:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E28FA4044A
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 18:51:30 +0000 (UTC)
IronPort-SDR: AHWkgsB/j6rpAI+6fVRwlBlsGmimBwH0yqC5gon2TjFHoD2qBTxf7sEz+Va0KJc+fgKXPngXRO
 ePs5RFhWJhMQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="263214888"
X-IronPort-AV: E=Sophos;i="5.82,325,1613462400"; d="scan'208";a="263214888"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2021 11:51:29 -0700
IronPort-SDR: RNZ8k4y7Dqu3VMsWlUlKIJhsjK32Ac+Vjq5htQ4XbAxZ7FPuAoF4iIVMPRWMABZtl/e+i4ERa4
 xDq5jozJnwAg==
X-IronPort-AV: E=Sophos;i="5.82,325,1613462400"; d="scan'208";a="546467113"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2021 11:51:28 -0700
Date: Mon, 24 May 2021 11:54:00 -0700
From: Jacob Pan <jacob.jun.pan@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 01/11] iommu/vt-d: Add pasid private data helpers
Message-ID: <20210524115400.52df4d97@jacob-builder>
In-Reply-To: <15bdf989-40c9-2b45-0fb6-273a43479789@linux.intel.com>
References: <20210520031531.712333-1-baolu.lu@linux.intel.com>
 <20210520031531.712333-2-baolu.lu@linux.intel.com>
 <20210521142518.25087d34@jacob-builder>
 <15bdf989-40c9-2b45-0fb6-273a43479789@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
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

Hi Lu,

On Mon, 24 May 2021 10:16:18 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> Hi Jacob,
> 
> Thanks for reviewing my patch.
> 
> On 5/22/21 5:25 AM, Jacob Pan wrote:
> > Hi BaoLu,
> > 
> > On Thu, 20 May 2021 11:15:21 +0800, Lu Baolu <baolu.lu@linux.intel.com>
> > wrote:
> >   
> >> We are about to use iommu_sva_alloc/free_pasid() helpers in iommu core.
> >> That means the pasid life cycle will be managed by iommu core. Use a
> >> local array to save the per pasid private data instead of attaching it
> >> the real pasid.
> >>  
> > I feel a little awkward to have a separate xarray for storing per IOASID
> > data. Seems duplicated.
> > Jason suggested in another thread that we can make ioasid_data public
> > and embeded in struct intel_svm, then we can get rid of the private data
> > pointer. ioasid_find will return the ioasid_data, then we can retrieve
> > the private data with container_of.  
> 
> The problem that this patch wants to solve is that the
> iommu_sva_alloc_pasid() will attach the mm pointer to the sva pasid.
> 
>          pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> 
> Assuming that each sva pasid can have only a single private data
> pointer, the vendor iommu driver shouldn't set the private data again.
> 
You are right. I got confused with vSVM, the guest will have the private
data assigned after the bind.

> > 
> > roughly,
> > 
> > struct intel_svm {
> > 	...
> > 	struct ioasid_data;
> > };
> > 
> > struct ioasid_data {
> > 	ioasid_t id;
> > 	refcount_t refs;
> > 	struct mm_struct *mm;
> > };
> > 
> > This can be a separate patch/effort if it make sense to you.  
> 
> Yes if we have a better solution.
> 
Will be part of the IOASID core change.

Thanks,
> Best regards,
> baolu


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
