Return-Path: <SRS0=NDwq=TC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDC4C43219
	for <iommu@archiver.kernel.org>; Thu,  2 May 2019 16:44:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 810C2208CB
	for <iommu@archiver.kernel.org>; Thu,  2 May 2019 16:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810C2208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 410ED31A7;
	Thu,  2 May 2019 16:44:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5B54831A5
	for <iommu@lists.linux-foundation.org>;
	Thu,  2 May 2019 16:43:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E018A711
	for <iommu@lists.linux-foundation.org>;
	Thu,  2 May 2019 16:43:56 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	02 May 2019 09:43:37 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by orsmga002.jf.intel.com with ESMTP; 02 May 2019 09:43:37 -0700
Date: Thu, 2 May 2019 09:46:24 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v7 05/23] iommu: Introduce cache_invalidate API
Message-ID: <20190502094624.43924be8@jacob-builder>
In-Reply-To: <6af5ddb7-75ad-7d3f-b303-f6f06adb1bf0@arm.com>
References: <20190408121911.24103-1-eric.auger@redhat.com>
	<20190408121911.24103-6-eric.auger@redhat.com>
	<a9745aef-8686-c761-e3d0-dd0e98a1f5b2@arm.com>
	<e5d2fdd6-4ce1-863e-5198-0b05d727a5b6@redhat.com>
	<6af5ddb7-75ad-7d3f-b303-f6f06adb1bf0@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"ashok.raj@intel.com" <ashok.raj@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Marc Zyngier <Marc.Zyngier@arm.com>, Will Deacon <Will.Deacon@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Christoffer Dall <Christoffer.Dall@arm.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Vincent Stehle <Vincent.Stehle@arm.com>,
	Robin Murphy <Robin.Murphy@arm.com>,
	"kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
	"eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
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
Message-ID: <20190502164624.uhGp3yPNoIe0ncSAwalHyis3AcdlRAYrt3TCAg6T9fA@z>

On Thu, 2 May 2019 11:53:34 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> On 02/05/2019 07:58, Auger Eric wrote:
> > Hi Jean-Philippe,
> > 
> > On 5/1/19 12:38 PM, Jean-Philippe Brucker wrote:  
> >> On 08/04/2019 13:18, Eric Auger wrote:  
> >>> +int iommu_cache_invalidate(struct iommu_domain *domain, struct
> >>> device *dev,
> >>> +			   struct iommu_cache_invalidate_info
> >>> *inv_info) +{
> >>> +	int ret = 0;
> >>> +
> >>> +	if (unlikely(!domain->ops->cache_invalidate))
> >>> +		return -ENODEV;
> >>> +
> >>> +	ret = domain->ops->cache_invalidate(domain, dev,
> >>> inv_info); +
> >>> +	return ret;  
> >>
> >> Nit: you don't really need ret
> >>
> >> The UAPI looks good to me, so
> >>
> >> Reviewed-by: Jean-Philippe Brucker
> >> <jean-philippe.brucker@arm.com>  
> > Just to make sure, do you accept changes proposed by Jacob in
> > https://lkml.org/lkml/2019/4/29/659 ie.
> > - the addition of NR_IOMMU_INVAL_GRANU in enum
> > iommu_inv_granularity and
> > - the addition of NR_IOMMU_CACHE_TYPE  
> 
> Ah sorry, I forgot about that, I'll review the next version. Yes they
> can be useful (maybe call them IOMMU_INV_GRANU_NR and
> IOMMU_CACHE_INV_TYPE_NR?). I guess it's legal to export in UAPI values
> that will change over time, as VFIO also does it in its enums.
> 
I am fine with the names. Maybe you can put this patch in your sva/api
branch once you reviewed it? Having a common branch for common code
makes life so much easier.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
