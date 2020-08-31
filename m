Return-Path: <SRS0=U/E5=CJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFD7C433E2
	for <iommu@archiver.kernel.org>; Mon, 31 Aug 2020 17:45:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C5D420866
	for <iommu@archiver.kernel.org>; Mon, 31 Aug 2020 17:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5D420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BC5DA21FA8;
	Mon, 31 Aug 2020 17:45:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4ga7zzZxGTnh; Mon, 31 Aug 2020 17:45:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7256020BF8;
	Mon, 31 Aug 2020 17:45:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60B3DC0052;
	Mon, 31 Aug 2020 17:45:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2519FC0051
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 17:45:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E5E3821FA8
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 17:45:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3qgWM98LsmK5 for <iommu@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 17:45:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id D5FF220BF8
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 17:45:19 +0000 (UTC)
IronPort-SDR: wUs8AEsV/tpcx/+EYg2SW5+OzoEILnbAmTqskcIb2mWCBYxIz7ln8hKWhob7d7htlGDDv3M7G+
 /lwsOVZ/CA8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="221260793"
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; d="scan'208";a="221260793"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 10:45:18 -0700
IronPort-SDR: 4V0HKjPMEFKjJ0dIOMZTyD7eACTRqRvtsa0jzkyZrLLFrCUNsnqyHPIMd+XP7P1heylDfFA6Ly
 bRfswT/CRLSw==
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; d="scan'208";a="340728810"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 10:45:17 -0700
Date: Mon, 31 Aug 2020 10:52:24 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v7 7/7] iommu/vt-d: Check UAPI data processed by IOMMU core
Message-ID: <20200831105224.7a90ba34@jacob-builder>
In-Reply-To: <1b131401-a9a3-3641-99cc-430d9b51efa5@redhat.com>
References: <1596068467-49322-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1596068467-49322-8-git-send-email-jacob.jun.pan@linux.intel.com>
 <1b131401-a9a3-3641-99cc-430d9b51efa5@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

On Thu, 13 Aug 2020 11:19:46 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 7/30/20 2:21 AM, Jacob Pan wrote:
> > IOMMU generic layer already does sanity checks UAPI data for version
> > match and argsz range under generic information.
> > Remove the redundant version check from VT-d driver and check for
> > vendor specific data size.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  
> 
> > ---
> >  drivers/iommu/intel/iommu.c | 3 +--
> >  drivers/iommu/intel/svm.c   | 7 +++++--
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c
> > b/drivers/iommu/intel/iommu.c index 021f62078f52..7e03cca31a0e
> > 100644 --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -5391,8 +5391,7 @@ intel_iommu_sva_invalidate(struct
> > iommu_domain *domain, struct device *dev, int ret = 0;
> >  	u64 size = 0;
> >  
> > -	if (!inv_info || !dmar_domain ||
> > -	    inv_info->version !=
> > IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
> > +	if (!inv_info || !dmar_domain)
> >  		return -EINVAL;
> >  
> >  	if (!dev || !dev_is_pci(dev))
> > diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> > index 713b3a218483..55ea11e9c0f5 100644
> > --- a/drivers/iommu/intel/svm.c
> > +++ b/drivers/iommu/intel/svm.c
> > @@ -240,8 +240,11 @@ int intel_svm_bind_gpasid(struct iommu_domain
> > *domain, struct device *dev, if (WARN_ON(!iommu) || !data)
> >  		return -EINVAL;
> >  
> > -	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
> > -	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
> > +	if (data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
> > +		return -EINVAL;
> > +
> > +	/* IOMMU core ensures argsz is more than the start of the
> > union */
> > +	if (data->argsz < offsetofend(struct
> > iommu_gpasid_bind_data, vendor.vtd)) return -EINVAL;  
> Shouldn't you test the vendor flags here?
> intel_pasid_setup_bind_data() only checks valid ones but not ~mask.
> 
Yes, vendor flags should be tested to make sure there is no undefined
flags being used.

Thanks!

> Thanks
> 
> Eric
> >  
> >  	if (!dev_is_pci(dev))
> >   
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
