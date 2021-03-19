Return-Path: <SRS0=1/OX=IR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384FDC43381
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 00:20:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9FF64E41
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 00:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9FF64E41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 68CF1400F7;
	Fri, 19 Mar 2021 00:20:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EEEoduoj38YK; Fri, 19 Mar 2021 00:20:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id D5871400F2;
	Fri, 19 Mar 2021 00:20:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A93FFC000A;
	Fri, 19 Mar 2021 00:20:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 517F6C0001
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 00:20:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 26DBD82F77
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 00:20:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5OBdTtBDUp9X for <iommu@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 00:20:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4D2A782EAD
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 00:20:13 +0000 (UTC)
IronPort-SDR: ifsMLt1OPZ4kHFnEOIrcTmpsE4GwTZT01ZXe1uQJe0m9QKY61KEdpFZI88IMedhuHkU5Ys+mHP
 0yZ3k99iljKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="169092374"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; d="scan'208";a="169092374"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2021 17:20:10 -0700
IronPort-SDR: vm0vhQeTnExLKln4ENqx3VU3gCMCBEb+VB9rFh8sV4Mo/w2VhojiBHVFosZE2BZUKHctyGKo/S
 rjkWZc8chQHw==
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; d="scan'208";a="413299077"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2021 17:20:10 -0700
Date: Thu, 18 Mar 2021 17:22:34 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, "Lu
 Baolu" <baolu.lu@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux-foundation.org, cgroups@vger.kernel.org, Tejun Heo
 <tj@kernel.org>, Li Zefan <lizefan@huawei.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210318172234.3e8c34f7@jacob-builder>
In-Reply-To: <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Alex Williamson <alex.williamson@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Wu Hao <hao.wu@intel.com>
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

Hi Jean,

Slightly off the title. As we are moving to use cgroup to limit PASID
allocations, it would be much simpler if we enforce on the current task.

However, iommu_sva_alloc_pasid() takes an mm_struct pointer as argument
which implies it can be something other the the current task mm. So far all
kernel callers use current task mm. Is there a use case for doing PASID
allocation on behalf of another mm? If not, can we remove the mm argument?

Thanks,

Jacob

>  /**
>   * iommu_sva_alloc_pasid - Allocate a PASID for the mm
> @@ -35,11 +44,11 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm,
> ioasid_t min, ioasid_t max) mutex_lock(&iommu_sva_lock);
>  	if (mm->pasid) {
>  		if (mm->pasid >= min && mm->pasid <= max)
> -			ioasid_get(mm->pasid);
> +			ioasid_get(iommu_sva_pasid, mm->pasid);
>  		else
>  			ret = -EOVERFLOW;
>  	} else {
> -		pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> +		pasid = ioasid_alloc(iommu_sva_pasid, min, max, mm);
>  		if (pasid == INVALID_IOASID)
>  			ret = -ENOMEM;

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
