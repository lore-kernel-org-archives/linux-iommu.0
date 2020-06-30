Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9459BC433DF
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 17:28:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50F36206C0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 17:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F36206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1F063874F0;
	Tue, 30 Jun 2020 17:28:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nI2ons_wqit6; Tue, 30 Jun 2020 17:28:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4EE8A86BB5;
	Tue, 30 Jun 2020 17:28:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31549C0865;
	Tue, 30 Jun 2020 17:28:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3DFBC016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 17:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 86E7A2042E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 17:28:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gsxZBXkl6-kZ for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 17:28:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by silver.osuosl.org (Postfix) with ESMTPS id 523FF203CE
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 17:28:27 +0000 (UTC)
IronPort-SDR: hKlghT1D0e8XM91h7Zgkw2WriC0I6DwmixTMyqrVQVtC6axcmlsax9uRZ3KbwLnkJ0xnfcqfA1
 iXs+IdA3a9Zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="164325314"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; d="scan'208";a="164325314"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 10:28:25 -0700
IronPort-SDR: iic3PxhGJrZzMZYF5AwBTrPWKPYtdK4G0iPGGe2A6J+qfv6LgmwGkl419RUyX7A2ZrQIO75+Ds
 5vmxmwbb6IwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; d="scan'208";a="277496676"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga003.jf.intel.com with ESMTP; 30 Jun 2020 10:28:24 -0700
Date: Tue, 30 Jun 2020 10:34:59 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 6/7] iommu/vt-d: Warn on out-of-range invalidation address
Message-ID: <20200630103459.6c99c961@jacob-builder>
In-Reply-To: <d87d15fd-71d5-6735-74df-583024826ab0@linux.intel.com>
References: <1592926996-47914-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1592926996-47914-7-git-send-email-jacob.jun.pan@linux.intel.com>
 <d87d15fd-71d5-6735-74df-583024826ab0@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>
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

On Thu, 25 Jun 2020 18:10:43 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi,
> 
> On 2020/6/23 23:43, Jacob Pan wrote:
> > For guest requested IOTLB invalidation, address and mask are
> > provided as part of the invalidation data. VT-d HW silently ignores
> > any address bits below the mask. SW shall also allow such case but
> > give warning if address does not align with the mask. This patch
> > relax the fault handling from error to warning and proceed with
> > invalidation request with the given mask.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c
> > b/drivers/iommu/intel/iommu.c index 5ea5732d5ec4..50fc62413a35
> > 100644 --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -5439,13 +5439,12 @@ intel_iommu_sva_invalidate(struct
> > iommu_domain *domain, struct device *dev, 
> >   		switch (BIT(cache_type)) {
> >   		case IOMMU_CACHE_INV_TYPE_IOTLB:
> > +			/* HW will ignore LSB bits based on
> > address mask */ if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
> >   			    size &&
> >   			    (inv_info->addr_info.addr &
> > ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
> > -				pr_err_ratelimited("Address out of
> > range, 0x%llx, size order %llu\n",
> > -
> > inv_info->addr_info.addr, size);
> > -				ret = -ERANGE;
> > -				goto out_unlock;
> > +				WARN_ONCE(1, "Address out of
> > range, 0x%llx, size order %llu\n",
> > +
> > inv_info->addr_info.addr, size);  
> 
> I don't think WARN_ONCE() is suitable here. It makes users think it's
> a kernel bug. How about pr_warn_ratelimited()?
> 
I think pr_warn_ratelimited might still be too chatty. There is no
functional issues, we just don't to silently ignore it. Perhaps just
say:
WARN_ONCE(1, "User provided address not page aligned, alignment forced")
?

> Best regards,
> baolu
> 
> >   			}
> >   
> >   			/*
> >   

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
