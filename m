Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFF7C83004
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 18:21:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A99D208FE
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 18:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A99D208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 987EF864EE;
	Tue, 28 Apr 2020 18:21:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nZ1k5E7UEp6l; Tue, 28 Apr 2020 18:21:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 635A586500;
	Tue, 28 Apr 2020 18:21:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 485DFC0864;
	Tue, 28 Apr 2020 18:21:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D127C0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 18:21:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7E28C228D1
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 18:21:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CpuVxgafE0VS for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 18:21:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by silver.osuosl.org (Postfix) with ESMTPS id ADFCE228BD
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 18:21:16 +0000 (UTC)
IronPort-SDR: iEyCqjMxZpylRhiGeFKYm4HuL8vcB4hu7jLvZku7gcdwBYZdNj4/x2PxKggT31l29GZFKmxSEg
 akndt63dqSjg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2020 11:21:16 -0700
IronPort-SDR: fEllwY/yDUHilV4MwNXkmRzFM+lSBT+iRjfIEDui2kV6NyKP0dtFxyxrGbKIVjasPSUBTHPj1q
 SUOQXnFqF6XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; d="scan'208";a="302780227"
Received: from jpan9-mobl2.amr.corp.intel.com (HELO localhost)
 ([10.212.240.17])
 by FMSMGA003.fm.intel.com with SMTP; 28 Apr 2020 11:21:14 -0700
Date: Tue, 28 Apr 2020 11:21:13 -0700
From: "Jacob Pan (Jun)" <jacob.jun.pan@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/7] x86/mmu: Allocate/free PASID
Message-ID: <20200428112113.000033bd@intel.com>
In-Reply-To: <87pnbus3du.fsf@nanos.tec.linutronix.de>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
 <1585596788-193989-6-git-send-email-fenghua.yu@intel.com>
 <87pnbus3du.fsf@nanos.tec.linutronix.de>
Organization: intel
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 jacob.jun.pan@intel.com, H Peter Anvin <hpa@zytor.com>, David
 Woodhouse <dwmw2@infradead.org>
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

On Sun, 26 Apr 2020 16:55:25 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> Fenghua Yu <fenghua.yu@intel.com> writes:
> 
> > PASID is shared by all threads in a process. So the logical place
> > to keep track of it is in the "mm". Add the field to the
> > architecture specific mm_context_t structure.
> >
> > A PASID is allocated for an "mm" the first time any thread attaches
> > to an SVM capable device. Later device atatches (whether to the
> > same  
> 
> atatches?
> 
> > device or another SVM device) will re-use the same PASID.
> >
> > The PASID is freed when the process exits (so no need to keep
> > reference counts on how many SVM devices are sharing the PASID).  
> 
> I'm not buying that. If there is an outstanding request with the PASID
> of a process then tearing down the process address space and freeing
> the PASID (which might be reused) is fundamentally broken.
> 
Device driver unbind PASID is tied to FD release. So when a process
exits, FD close causes driver to do the following:
1. stops DMA
2. unbind PASID (clears the PASID entry in IOMMU, flush all TLBs, drain
in flight page requests)

For bare metal SVM, if the last mmdrop always happens after FD release,
we can ensure no outstanding requests at the point of ioasid_free().
Perhaps this is a wrong assumption?

For guest SVM, there will be more users of a PASID. I am also
working on adding refcounting to ioasid. ioasid_free() will not release
the PASID back to the pool until all references are dropped.

> > +void __free_pasid(struct mm_struct *mm);
> > +
> >  #endif /* _ASM_X86_IOMMU_H */
> > diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
> > index bdeae9291e5c..137bf51f19e6 100644
> > --- a/arch/x86/include/asm/mmu.h
> > +++ b/arch/x86/include/asm/mmu.h
> > @@ -50,6 +50,10 @@ typedef struct {
> >  	u16 pkey_allocation_map;
> >  	s16 execute_only_pkey;
> >  #endif
> > +
> > +#ifdef CONFIG_INTEL_IOMMU_SVM
> > +	int pasid;  
> 
> int? It's a value which gets programmed into the MSR along with the
> valid bit (bit 31) set. 
> 
> >  extern void switch_mm(struct mm_struct *prev, struct mm_struct
> > *next, diff --git a/drivers/iommu/intel-svm.c
> > b/drivers/iommu/intel-svm.c index d7f2a5358900..da718a49e91e 100644
> > --- a/drivers/iommu/intel-svm.c
> > +++ b/drivers/iommu/intel-svm.c
> > @@ -226,6 +226,45 @@ static LIST_HEAD(global_svm_list);
> >  	list_for_each_entry((sdev), &(svm)->devs, list)	\
> >  		if ((d) != (sdev)->dev) {} else
> >  
> > +/*
> > + * If this mm already has a PASID we can use it. Otherwise
> > allocate a new one.
> > + * Let the caller know if we did an allocation via 'new_pasid'.
> > + */
> > +static int alloc_pasid(struct intel_svm *svm, struct mm_struct *mm,
> > +		       int pasid_max,  bool *new_pasid, int
> > flags)  
> 
> Again, data types please. flags are generally unsigned and not plain
> int. Also pasid_max is certainly not plain int either.
> 
> > +{
> > +	int pasid;
> > +
> > +	/*
> > +	 * Reuse the PASID if the mm already has a PASID and not a
> > private
> > +	 * PASID is requested.
> > +	 */
> > +	if (mm && mm->context.pasid && !(flags &
> > SVM_FLAG_PRIVATE_PASID)) {
> > +		/*
> > +		 * Once a PASID is allocated for this mm, the PASID
> > +		 * stays with the mm until the mm is dropped. Reuse
> > +		 * the PASID which has been already allocated for
> > the
> > +		 * mm instead of allocating a new one.
> > +		 */
> > +		ioasid_set_data(mm->context.pasid, svm);  
> 
> So if the PASID is reused several times for different SVMs then every
> time ioasid_data->private is set to a different SVM. How is that
> supposed to work?
> 
For the lifetime of the mm, there is only one PASID. svm_bind/unbind_mm
could happen many times with different private data: intel_svm.
Multiple devices can bind to the same PASID as well. But private data
don't change within the first bind and last unbind.

> > +		*new_pasid = false;
> > +
> > +		return mm->context.pasid;
> > +	}
> > +
> > +	/*
> > +	 * Allocate a new pasid. Do not use PASID 0, reserved for
> > RID to
> > +	 * PASID.
> > +	 */
> > +	pasid = ioasid_alloc(NULL, PASID_MIN, pasid_max - 1,
> > svm);  
> 
> ioasid_alloc() uses ioasid_t which is
> 
> typedef unsigned int ioasid_t;
> 
> Can we please have consistent types and behaviour all over the place?
> 
> > +	if (pasid == INVALID_IOASID)
> > +		return -ENOSPC;
> > +
> > +	*new_pasid = true;
> > +
> > +	return pasid;
> > +}
> > +
> >  int intel_svm_bind_mm(struct device *dev, int *pasid, int flags,
> > struct svm_dev_ops *ops) {
> >  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> > @@ -324,6 +363,8 @@ int intel_svm_bind_mm(struct device *dev, int
> > *pasid, int flags, struct svm_dev_ init_rcu_head(&sdev->rcu);
> >  
> >  	if (!svm) {
> > +		bool new_pasid;
> > +
> >  		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
> >  		if (!svm) {
> >  			ret = -ENOMEM;
> > @@ -335,15 +376,13 @@ int intel_svm_bind_mm(struct device *dev, int
> > *pasid, int flags, struct svm_dev_ if (pasid_max >
> > intel_pasid_max_id) pasid_max = intel_pasid_max_id;
> >  
> > -		/* Do not use PASID 0, reserved for RID to PASID */
> > -		svm->pasid = ioasid_alloc(NULL, PASID_MIN,
> > -					  pasid_max - 1, svm);
> > -		if (svm->pasid == INVALID_IOASID) {
> > +		svm->pasid = alloc_pasid(svm, mm, pasid_max,
> > &new_pasid, flags);
> > +		if (svm->pasid < 0) {
> >  			kfree(svm);
> >  			kfree(sdev);
> > -			ret = -ENOSPC;  
> 
> ret gets magically initialized to an error return value, right?
> 
> >  			goto out;
> >  		}
> > +
> >  		svm->notifier.ops = &intel_mmuops;
> >  		svm->mm = mm;
> >  		svm->flags = flags;
> > @@ -353,7 +392,8 @@ int intel_svm_bind_mm(struct device *dev, int
> > *pasid, int flags, struct svm_dev_ if (mm) {
> >  			ret =
> > mmu_notifier_register(&svm->notifier, mm); if (ret) {
> > -				ioasid_free(svm->pasid);
> > +				if (new_pasid)
> > +					ioasid_free(svm->pasid);
> >  				kfree(svm);
> >  				kfree(sdev);
> >  				goto out;
> > @@ -371,12 +411,21 @@ int intel_svm_bind_mm(struct device *dev, int
> > *pasid, int flags, struct svm_dev_ if (ret) {
> >  			if (mm)
> >  				mmu_notifier_unregister(&svm->notifier,
> > mm);
> > -			ioasid_free(svm->pasid);
> > +			if (new_pasid)
> > +				ioasid_free(svm->pasid);
> >  			kfree(svm);
> >  			kfree(sdev);  
> 
> So there are 3 places now freeing svm ad sdev and 2 of them
> conditionally free svm->pasid. Can you please rewrite that to have a
> proper error exit path instead of glueing that stuff into the existing
> mess?
> 
> >  			goto out;
> >  		}
> >  
> > +		if (mm && new_pasid && !(flags &
> > SVM_FLAG_PRIVATE_PASID)) {
> > +			/*
> > +			 * Track the new pasid in the mm. The
> > pasid will be
> > +			 * freed at process exit. Don't track
> > requested
> > +			 * private PASID in the mm.  
> 
> What happens to private PASIDs?
> 
Private PASID feature will be removed. We are in the process of
converting from intel_svm_bind_mm to generic sva_bind_device API.
https://lkml.org/lkml/2020/3/23/1022

Thanks,

Jacob

> Thanks,
> 
>         tglx

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
