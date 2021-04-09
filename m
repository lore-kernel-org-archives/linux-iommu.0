Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D6BC433ED
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 18:05:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88CA06108B
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 18:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CA06108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5114960710;
	Fri,  9 Apr 2021 18:05:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SK-ou1SF5Hyt; Fri,  9 Apr 2021 18:05:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E56E607E1;
	Fri,  9 Apr 2021 18:05:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27781C000C;
	Fri,  9 Apr 2021 18:05:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69662C000A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 18:05:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6494883EAE
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 18:05:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xYNXl022LQ9w for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 18:05:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F390183EAD
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 18:05:34 +0000 (UTC)
IronPort-SDR: rWaSmTO2BmEluX3O/Jld485QzykFflobEV/fMGSuxdjXYgKk9vUA1hB1FoQBPzGloGOdaeCeCG
 /2qrLSUCI7zQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="191666273"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; d="scan'208";a="191666273"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2021 11:05:34 -0700
IronPort-SDR: L1/U4YPgSSizYdUR951ccnL+di8YpAqnU3aL/5HnFUPuDbedxXKf+CzAXn80Pc2Z6qs/YcH+Y4
 If7uo2XhNMRQ==
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; d="scan'208";a="449158863"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2021 11:05:33 -0700
Date: Fri, 9 Apr 2021 11:08:08 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/2] iommu/sva: Remove mm parameter from SVA bind API
Message-ID: <20210409110808.58f22606@jacob-builder>
In-Reply-To: <f29495e1-e3a0-8c45-bfca-067c1e996eca@linux.intel.com>
References: <1617901736-24788-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1617901736-24788-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <f29495e1-e3a0-8c45-bfca-067c1e996eca@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, zhangfei.gao@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

On Fri, 9 Apr 2021 20:45:22 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> > -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t
> > max) +int iommu_sva_alloc_pasid(ioasid_t min, ioasid_t max)
> >   {
> >   	int ret = 0;
> >   	ioasid_t pasid;
> > +	struct mm_struct *mm;
> >   
> >   	if (min == INVALID_IOASID || max == INVALID_IOASID ||
> >   	    min == 0 || max < min)
> >   		return -EINVAL;
> >   
> >   	mutex_lock(&iommu_sva_lock);
> > +	mm = get_task_mm(current);  
> 
> How could we allocate a supervisor PASID through iommu_sva_alloc_pasid()
> if we always use current->mm here?
I don't think you can. But I guess the current callers of this function do
not need supervisor PASID.
In reply to Jean, I suggest we split this function into mm->pasid
assignment and keep using ioasid_alloc() directly, then supervisor PASID is
caller's bind choice.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
