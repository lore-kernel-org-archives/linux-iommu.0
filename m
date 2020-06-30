Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B33C433E4
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 04:50:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13BD42067D
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 04:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BD42067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CDFE08823B;
	Tue, 30 Jun 2020 04:50:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uNxNpx9xjG2k; Tue, 30 Jun 2020 04:50:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D2DC8881EC;
	Tue, 30 Jun 2020 04:50:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE04AC0865;
	Tue, 30 Jun 2020 04:50:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C431C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 04:50:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 15CD187AB1
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 04:50:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZWB0GjfMK-8Q for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 04:50:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 399EB87A85
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 04:50:30 +0000 (UTC)
IronPort-SDR: wTwnZyjUmpZvWpWZZLhHYgwGLNZb+4md2SefOvMZUHL02r3A2AZaXIJGyNqjGAfSDEYp+YoLgy
 l7xDENghlMgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="146135341"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; d="scan'208";a="146135341"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2020 21:50:29 -0700
IronPort-SDR: YDVA/aYnL+AdORxJOcaUrm4P4FFEuhV5QspBKdyUg1K4nteR2qMdYjvlk2FSnc5Jyy7DWQ8nB+
 fnfawDMxGVjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; d="scan'208";a="313280347"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by fmsmga002.fm.intel.com with ESMTP; 29 Jun 2020 21:50:28 -0700
Date: Mon, 29 Jun 2020 21:57:03 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 3/7] iommu/vt-d: Fix PASID devTLB invalidation
Message-ID: <20200629215703.4858896d@jacob-builder>
In-Reply-To: <57091f4a-fb53-40a4-6a28-a498f548f8b8@linux.intel.com>
References: <1592926996-47914-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1592926996-47914-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <57091f4a-fb53-40a4-6a28-a498f548f8b8@linux.intel.com>
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

On Thu, 25 Jun 2020 15:25:57 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> On 2020/6/23 23:43, Jacob Pan wrote:
> > DevTLB flush can be used for both DMA request with and without
> > PASIDs. The former uses PASID#0 (RID2PASID), latter uses non-zero
> > PASID for SVA usage.
> > 
> > This patch adds a check for PASID value such that devTLB flush with
> > PASID is used for SVA case. This is more efficient in that multiple
> > PASIDs can be used by a single device, when tearing down a PASID
> > entry we shall flush only the devTLB specific to a PASID.
> > 
> > Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table")
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   drivers/iommu/intel/pasid.c | 11 ++++++++++-
> >   1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/intel/pasid.c
> > b/drivers/iommu/intel/pasid.c index c81f0f17c6ba..3991a24539a1
> > 100644 --- a/drivers/iommu/intel/pasid.c
> > +++ b/drivers/iommu/intel/pasid.c
> > @@ -486,7 +486,16 @@ devtlb_invalidation_with_pasid(struct
> > intel_iommu *iommu, qdep = info->ats_qdep;
> >   	pfsid = info->pfsid;
> >   
> > -	qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 -
> > VTD_PAGE_SHIFT);
> > +	/*
> > +	 * When PASID 0 is used, it indicates RID2PASID(DMA
> > request w/o PASID),
> > +	 * devTLB flush w/o PASID should be used. For non-zero
> > PASID under
> > +	 * SVA usage, device could do DMA with multiple PASIDs. It
> > is more
> > +	 * efficient to flush devTLB specific to the PASID.
> > +	 */
> > +	if (pasid)  
> 
> How about
> 
> 	if (pasid == PASID_RID2PASID)
> 		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 -
> VTD_PAGE_SHIFT); else
> 		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid,
> qdep, 0, 64 - VTD_PAGE_SHIFT);
> 
> ?
> 
> It makes the code more readable and still works even we reassign
> another pasid for RID2PASID.
> 
agreed, thanks.

> Best regards,
> baolu
> 
> > +		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid,
> > qdep, 0, 64 - VTD_PAGE_SHIFT);
> > +	else
> > +		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64
> > - VTD_PAGE_SHIFT); }
> >   
> >   void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
> > struct device *dev, 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
