Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5A4C433B4
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 18:51:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B53A610CE
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 18:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B53A610CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3784640240;
	Thu, 15 Apr 2021 18:51:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hzFTLLu2JJ5x; Thu, 15 Apr 2021 18:51:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 189FF400C3;
	Thu, 15 Apr 2021 18:51:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1E5EC000C;
	Thu, 15 Apr 2021 18:51:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0909C000A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 18:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 87919400C3
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 18:51:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9pcWYz-JnFDN for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 18:51:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EA72C401DD
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 18:51:10 +0000 (UTC)
IronPort-SDR: Q8/qtCDWTWyS9XGGsgirf1m+kldvX52xGzl4FK3TIOuaPSxe1hCgoC5WJxIIySyzxJF6iKDoBp
 ylBLGFXhURog==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="175026850"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; d="scan'208";a="175026850"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2021 11:51:09 -0700
IronPort-SDR: 7mVjtdxduOhFD/qaBlx9o4lynInMuvOEE55/fJFzvq8O3LoZz3ue7rXJ2xgmFz8gjZXlaOAAMM
 HquB5oNUgcIQ==
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; d="scan'208";a="384108451"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2021 11:51:09 -0700
Date: Thu, 15 Apr 2021 11:53:48 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/2] iommu/sva: Tighten SVA bind API with explicit flags
Message-ID: <20210415115348.107554aa@jacob-builder>
In-Reply-To: <20210415064033.GA1938497@infradead.org>
References: <1618414077-28808-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1618414077-28808-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210415064033.GA1938497@infradead.org>
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

Hi Christoph,

Thanks for the review.

On Thu, 15 Apr 2021 07:40:33 +0100, Christoph Hellwig <hch@infradead.org>
wrote:

> On Wed, Apr 14, 2021 at 08:27:56AM -0700, Jacob Pan wrote:
> >  static int idxd_enable_system_pasid(struct idxd_device *idxd)
> >  {
> > -	int flags;
> > +	unsigned int flags;
> >  	unsigned int pasid;
> >  	struct iommu_sva *sva;
> >  
> > -	flags = SVM_FLAG_SUPERVISOR_MODE;
> > +	flags = IOMMU_SVA_BIND_SUPERVISOR;
> >  
> > -	sva = iommu_sva_bind_device(&idxd->pdev->dev, NULL, &flags);
> > +	sva = iommu_sva_bind_device(&idxd->pdev->dev, NULL, flags);  
> 
> Please also remove the now pointless flags variable.
> 
Good catch.

> > +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm,
> > unsigned int flags)  
> 
> Pleae avoid the pointless overly long line.
> 
> > -#define SVM_FLAG_GUEST_PASID		(1<<3)
> > +#define SVM_FLAG_GUEST_PASID		(1<<2)  
> 
> This flag is entirely unused, please just remove it in a prep patch
> rather than renumbering it.
> 
You are right. The flag was set and intended to be used by the guest IO
page request patches by Baolu.

As you might be aware, we are restructuring the guest SVA uAPI according to
Jason's proposal, can we wait until we have a clear solution? We may
refactor lots of code.

> >  static inline struct iommu_sva *
> > -iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void
> > *drvdata) +iommu_sva_bind_device(struct device *dev, struct mm_struct
> > *mm, unsigned int flags)  
> 
> Same overy long line here.
This is temporary as the mm parameter will be removed in the next patch.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
