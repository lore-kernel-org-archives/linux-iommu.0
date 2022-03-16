Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D15C433EF
	for <iommu@archiver.kernel.org>; Wed, 16 Mar 2022 20:48:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AC1F84312;
	Wed, 16 Mar 2022 20:48:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id miDRWyehskRw; Wed, 16 Mar 2022 20:48:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ECF1C84322;
	Wed, 16 Mar 2022 20:48:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C52CAC001A;
	Wed, 16 Mar 2022 20:48:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A87CC000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 20:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B6F0402D7
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 20:48:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WAjYwjYBRVVO for <iommu@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 20:48:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D188C401FC
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 20:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647463695; x=1678999695;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=q+FQmfaETXRwzuv/cK+SYKBKZ/3kdd4QXApm/25DTEQ=;
 b=NVBcCm0+qO7ZIra81hzjIPLLRmjl5UG8vNUvssi9zUHoIEguM92Zs2zD
 lrRfYZ3J772uN9+R1NxhlZ3vaTjXKjnoDukLBAR/9UNZRmhrbXeCQYrEx
 eKJbdqOGJ/4w5qEEJWEHUkzzr74dlhqGJlerrTyoOjQ3DHArrwm2ZrwNF
 LU/g4TP87vEdOUiYPhQXzmy0TyfyumIDnMyx4jDaKAFlVkL41R8wbC9b4
 J3tyHbzAKpX2v8TNpA5JHSds7IGSM92jQvwhb7ciDezPfyabth+0Twa5G
 EZAfF52BfR0lpto6tpBN1YIiUhyCYK0F0gHIYrtrvhYkDbgOZ27AyrVti Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="255539243"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; d="scan'208";a="255539243"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 13:48:15 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; d="scan'208";a="690720627"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 13:48:14 -0700
Date: Wed, 16 Mar 2022 13:51:31 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Message-ID: <20220316135131.44c666ee@jacob-builder>
In-Reply-To: <BN9PR11MB527696917B0F6496700885328C119@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB527696917B0F6496700885328C119@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Wed, 16 Mar 2022 07:39:09 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Tuesday, March 15, 2022 1:07 PM
> > +static int intel_iommu_attach_dev_pasid(struct iommu_domain *domain,
> > +					struct device *dev, ioasid_t
> > pasid) +{
> > +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> > +	struct device_domain_info *info = get_domain_info(dev);
> > +	struct intel_iommu *iommu = info->iommu;
> > +	struct pasid_info *pinfo;
> > +	unsigned long flags;
> > +	int ret = 0;
> > +	void *entry;
> > +
> > +	if (!info)
> > +		return -ENODEV;  
> 
> btw this interface only works in scalable mode. Lack of a check to
> return error on legacy mode here.
> 
right, legacy mode has no PASIDs. will check

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
