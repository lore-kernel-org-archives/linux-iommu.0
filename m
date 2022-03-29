Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64F1C433EF
	for <iommu@archiver.kernel.org>; Tue, 29 Mar 2022 17:39:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8A93540385;
	Tue, 29 Mar 2022 17:39:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZUxBPGF-BZCr; Tue, 29 Mar 2022 17:38:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4AD164011D;
	Tue, 29 Mar 2022 17:38:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BA20C002C;
	Tue, 29 Mar 2022 17:38:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E3AAC0012
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 17:38:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 56AD760FEB
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 17:38:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7MdiP_WI7p2i for <iommu@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 17:38:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A44A760FCA
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 17:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648575537; x=1680111537;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BdPlvWarzhHsLaFQ8fFSDfcrHEVxYxEW9ZW8dC/aUMo=;
 b=iZur4f7kxSiyU+evCHG7FAcEVzMUII/yqfsjMNU8T1C8dFvxz2BNRzr+
 kIK6ZqnisgIgoXgSXKldSORFeum92jFLJ3+WDvfbAu/SbXJ/cuMJ5CV8a
 +Rfm9WQSk9alOagD7/bau6/t+/pA2ku8uzu0cEFfIxgdLHZrXGVLRQM3U
 +AFy05wLzbS7BCRBDTIT2RzvO1h1wYFSffWImVXyYrdBdWsGcywYP7EA3
 IlzBnoZATuDjh+RUPtvHL7KoamcJkbxqWj5TkrSz+gMYXlRQdH7JrbxXS
 gS76dEsOVU9ylgJJhtHQAUk5wu+CB8bNfpTeedp7jL0ey4PQZyh1ScKeS Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="258149234"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; d="scan'208";a="258149234"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2022 10:38:57 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; d="scan'208";a="694798153"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2022 10:38:56 -0700
Date: Tue, 29 Mar 2022 10:42:19 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v2 7/8] iommu/vt-d: Delete supervisor/kernel SVA
Message-ID: <20220329104219.4445af35@jacob-builder>
In-Reply-To: <BN9PR11MB5276B2AB27F5AD50BC18AE718C139@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-8-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB5276B2AB27F5AD50BC18AE718C139@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Luck,
 Tony" <tony.luck@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Jason
 Gunthorpe <jgg@nvidia.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
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

Hi Kevin,

On Fri, 18 Mar 2022 06:16:58 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Tuesday, March 15, 2022 1:07 PM
> > 
> > In-kernel DMA with PASID should use DMA API now, remove supervisor
> > PASID
> > SVA support. Remove special cases in bind mm and page request service.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  
> 
> so you removed all the references to SVM_FLAG_SUPERVISOR_MODE
> but the definition is still kept in include/linux/intel-svm.h...
> 
Good catch, will remove.

> > ---
> >  drivers/iommu/intel/svm.c | 42 ++++++++-------------------------------
> >  1 file changed, 8 insertions(+), 34 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> > index 2c53689da461..37d6218f173b 100644
> > --- a/drivers/iommu/intel/svm.c
> > +++ b/drivers/iommu/intel/svm.c
> > @@ -516,11 +516,10 @@ static void intel_svm_free_pasid(struct mm_struct
> > *mm)
> > 
> >  static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
> >  					   struct device *dev,
> > -					   struct mm_struct *mm,
> > -					   unsigned int flags)
> > +					   struct mm_struct *mm)
> >  {
> >  	struct device_domain_info *info = get_domain_info(dev);
> > -	unsigned long iflags, sflags;
> > +	unsigned long iflags, sflags = 0;
> >  	struct intel_svm_dev *sdev;
> >  	struct intel_svm *svm;
> >  	int ret = 0;
> > @@ -533,16 +532,13 @@ static struct iommu_sva
> > *intel_svm_bind_mm(struct intel_iommu *iommu,
> > 
> >  		svm->pasid = mm->pasid;
> >  		svm->mm = mm;
> > -		svm->flags = flags;
> >  		INIT_LIST_HEAD_RCU(&svm->devs);
> > 
> > -		if (!(flags & SVM_FLAG_SUPERVISOR_MODE)) {
> > -			svm->notifier.ops = &intel_mmuops;
> > -			ret = mmu_notifier_register(&svm->notifier,
> > mm);
> > -			if (ret) {
> > -				kfree(svm);
> > -				return ERR_PTR(ret);
> > -			}
> > +		svm->notifier.ops = &intel_mmuops;
> > +		ret = mmu_notifier_register(&svm->notifier, mm);
> > +		if (ret) {
> > +			kfree(svm);
> > +			return ERR_PTR(ret);
> >  		}
> > 
> >  		ret = pasid_private_add(svm->pasid, svm);
> > @@ -583,8 +579,6 @@ static struct iommu_sva *intel_svm_bind_mm(struct
> > intel_iommu *iommu,
> >  	}
> > 
> >  	/* Setup the pasid table: */
> > -	sflags = (flags & SVM_FLAG_SUPERVISOR_MODE) ?
> > -			PASID_FLAG_SUPERVISOR_MODE : 0;
> >  	sflags |= cpu_feature_enabled(X86_FEATURE_LA57) ?
> > PASID_FLAG_FL5LP : 0;
> >  	spin_lock_irqsave(&iommu->lock, iflags);
> >  	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm-  
> > >pasid,  
> > @@ -957,7 +951,7 @@ static irqreturn_t prq_event_thread(int irq, void
> > *d)
> >  			 * to unbind the mm while any page faults are
> > outstanding.
> >  			 */
> >  			svm = pasid_private_find(req->pasid);
> > -			if (IS_ERR_OR_NULL(svm) || (svm->flags &
> > SVM_FLAG_SUPERVISOR_MODE))
> > +			if (IS_ERR_OR_NULL(svm))
> >  				goto bad_req;
> >  		}
> > 
> > @@ -1011,29 +1005,9 @@ static irqreturn_t prq_event_thread(int irq, void
> > *d)
> >  struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct
> > *mm, void *drvdata)
> >  {
> >  	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
> > -	unsigned int flags = 0;
> >  	struct iommu_sva *sva;
> >  	int ret;
> > 
> > -	if (drvdata)
> > -		flags = *(unsigned int *)drvdata;
> > -
> > -	if (flags & SVM_FLAG_SUPERVISOR_MODE) {
> > -		if (!ecap_srs(iommu->ecap)) {
> > -			dev_err(dev, "%s: Supervisor PASID not
> > supported\n",
> > -				iommu->name);
> > -			return ERR_PTR(-EOPNOTSUPP);
> > -		}
> > -
> > -		if (mm) {
> > -			dev_err(dev, "%s: Supervisor PASID with user
> > provided mm\n",
> > -				iommu->name);
> > -			return ERR_PTR(-EINVAL);
> > -		}
> > -
> > -		mm = &init_mm;
> > -	}
> > -
> >  	mutex_lock(&pasid_mutex);
> >  	ret = intel_svm_alloc_pasid(dev, mm, flags);
> >  	if (ret) {
> > --
> > 2.25.1  
> 


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
