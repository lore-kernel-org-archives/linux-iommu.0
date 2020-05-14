Return-Path: <SRS0=Hf/t=64=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C5CC433E0
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 15:51:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3AD02065F
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 15:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3AD02065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A25E7887AE;
	Thu, 14 May 2020 15:51:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GrPt6rprlWLi; Thu, 14 May 2020 15:51:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2E44787CD4;
	Thu, 14 May 2020 15:51:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FEC8C0178;
	Thu, 14 May 2020 15:51:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEECEC016F
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 15:51:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DA88788A42
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 15:51:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N3xpjPpn-7bg for <iommu@lists.linux-foundation.org>;
 Thu, 14 May 2020 15:51:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8E7988844D
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 15:51:36 +0000 (UTC)
IronPort-SDR: /vWmAGUevmS+jzIGdqCdhyg9gc4cFwdw/+rDMQI0IcP3bvCrO1lQh+Di6uIT+OK/60LJVY1WR6
 Lfk64SBak/Tw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2020 08:51:35 -0700
IronPort-SDR: I/hGnemAqgDMh5MYOq4b6XxPhMa7ut5i+YI+RWKp5VDKXZoqgRQ5x2ah70x0nhPFf5S+PKF035
 OJ3tp9gwsjFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,391,1583222400"; d="scan'208";a="437953389"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga005.jf.intel.com with ESMTP; 14 May 2020 08:51:34 -0700
Date: Thu, 14 May 2020 08:57:45 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v13 4/8] iommu/vt-d: Add bind guest PASID support
Message-ID: <20200514085745.105af4fb@jacob-builder>
In-Reply-To: <20200514055930.GD22388@infradead.org>
References: <1589410909-38925-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1589410909-38925-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200514055930.GD22388@infradead.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Jonathan Cameron <jic23@kernel.org>
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

Thanks a lot for the reviews, comments below.

Jacob

On Wed, 13 May 2020 22:59:30 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> > +	if (dev_is_pci(dev)) {
> > +		/* VT-d supports devices with full 20 bit PASIDs
> > only */
> > +		if (pci_max_pasids(to_pci_dev(dev)) != PASID_MAX)
> > +			return -EINVAL;
> > +	} else {
> > +		return -ENOTSUPP;
> > +	}  
> 
> This looks strange.  Why not:
> 
> 	if (!dev_is_pci(dev)) {
> 		return -ENOTSUPP;
> 
> 	/* VT-d supports devices with full 20 bit PASIDs only */
> 	if (pci_max_pasids(to_pci_dev(dev)) != PASID_MAX)
> 		return -EINVAL;
> 
That is better, will do.

> > +		for_each_svm_dev(sdev, svm, dev) {
> > +			/*
> > +			 * For devices with aux domains, we should
> > allow multiple
> > +			 * bind calls with the same PASID and pdev.
> > +			 */
> > +			if (iommu_dev_feature_enabled(dev,
> > IOMMU_DEV_FEAT_AUX)) {
> > +				sdev->users++;
> > +			} else {
> > +				dev_warn_ratelimited(dev, "Already
> > bound with PASID %u\n",
> > +						svm->pasid);
> > +				ret = -EBUSY;
> > +			}
> > +			goto out;  
> 
> Is this intentionally a for loop that jumps out of the loop after
> the first device?
> 
The name is confusing, it is not a loop. I will change it to
find_svm_dev() and comments like this?

/*
 * Find the matching device in a given SVM. The bind code ensures that
 * each device can only be added to the SVM list once.
 */ 
#define find_svm_dev(sdev, svm, d)			\
	list_for_each_entry((sdev), &(svm)->devs, list)	\
		if ((d) != (sdev)->dev) {} else

> > +	/*
> > +	 * PASID table is per device for better security.
> > Therefore, for
> > +	 * each bind of a new device even with an existing PASID,
> > we need to
> > +	 * call the nested mode setup function here.
> > +	 */
> > +	spin_lock(&iommu->lock);
> > +	ret = intel_pasid_setup_nested(iommu,
> > +				       dev,
> > +				       (pgd_t *)data->gpgd,
> > +				       data->hpasid,
> > +				       &data->vtd,
> > +				       dmar_domain,
> > +				       data->addr_width);  
> 
> Why not:
> 
> 	et = intel_pasid_setup_nested(iommu, dev, (pgd_t *)data->gpgd,
> 			data->hpasid, &data->vtd, dmar_domain,
> 			data->addr_width);
> 
> ?
> 
I thought we want to align the parentheses? Either way is fine.
Baolu?

> > +	for_each_svm_dev(sdev, svm, dev) {
> > +		ret = 0;  
> 
> 		...
> 
> > +		break;
> > +	}  
> 
> Same only looks at the first device style.  Why dos it only care about
> the first device?  That needs at least a comment, and probably a
> first_svm_dev or so heper to make it explicit.

Yes, same as above. change to find_svm_dev() since there should be at
most one matching device in the svm list.


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
