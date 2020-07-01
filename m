Return-Path: <SRS0=cxdO=AM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D70C433DF
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 14:13:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A15D420702
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 14:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15D420702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8C2B18AFCB;
	Wed,  1 Jul 2020 14:13:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wI7J2ZrqR7Iy; Wed,  1 Jul 2020 14:13:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E95FD8B117;
	Wed,  1 Jul 2020 14:13:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D54B0C0865;
	Wed,  1 Jul 2020 14:13:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAC3BC0733
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 14:13:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D62398B117
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 14:13:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qohvkqnGYu5l for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jul 2020 14:13:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D84988AFCB
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 14:13:44 +0000 (UTC)
IronPort-SDR: nhSUrjvqy0i1SD/ytRSoRGfMMnT8+e9hL0QXEv0Fbe4IBpNJ6qCiwMaz4wdgp2tOHKjbowjwRs
 2IQix9qY/i6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="126674831"
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; d="scan'208";a="126674831"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 07:13:44 -0700
IronPort-SDR: fOtmYyZxrhlY1AuGr4Ozlj3jy5/x1r25cQc7P/xlxTkCSKcd57uDPdKFRMtlNudqyvfVmKSJal
 ZDVgJGQvmhbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; d="scan'208";a="387016908"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by fmsmga001.fm.intel.com with ESMTP; 01 Jul 2020 07:13:44 -0700
Date: Wed, 1 Jul 2020 07:20:19 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 3/7] iommu/vt-d: Fix PASID devTLB invalidation
Message-ID: <20200701072019.2afd1cc1@jacob-builder>
In-Reply-To: <6f970f1f-621e-f66e-79d4-f2871c121baa@linux.intel.com>
References: <1593551258-39854-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1593551258-39854-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <6f970f1f-621e-f66e-79d4-f2871c121baa@linux.intel.com>
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

On Wed, 1 Jul 2020 08:49:54 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi Jacob,
> 
> On 7/1/20 5:07 AM, Jacob Pan wrote:
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
> > b/drivers/iommu/intel/pasid.c index c81f0f17c6ba..70d21209dd04
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
> > +	if (pasid == PASID_RID2PASID)
> > +		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid,
> > qdep, 0, 64 - VTD_PAGE_SHIFT);
> > +	else
> > +		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64
> > - VTD_PAGE_SHIFT);  
> 
> The if/else logic is reversed.
> 
> 	if (pasid == PASID_RID2PASID)
> 		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 -
> VTD_PAGE_SHIFT); else
> 		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid,
> qdep, 0, 64 - VTD_PAGE_SHIFT);
> 
indeed, will fix. thanks

> Best regards,
> baolu
> 
> >   }
> >   
> >   void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
> > struct device *dev, 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
