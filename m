Return-Path: <SRS0=C308=ZZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F291C432C0
	for <iommu@archiver.kernel.org>; Tue,  3 Dec 2019 16:45:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA7B52064B
	for <iommu@archiver.kernel.org>; Tue,  3 Dec 2019 16:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7B52064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8153B878E3;
	Tue,  3 Dec 2019 16:45:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8WyZkd2Q-oDG; Tue,  3 Dec 2019 16:45:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CD75B878CE;
	Tue,  3 Dec 2019 16:45:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2C4FC1798;
	Tue,  3 Dec 2019 16:45:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76E14C087F
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 16:45:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 64FCD87758
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 16:45:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ztq2ALCHy0ac for <iommu@lists.linux-foundation.org>;
 Tue,  3 Dec 2019 16:45:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 96A2787740
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 16:45:44 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Dec 2019 08:45:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,273,1571727600"; d="scan'208";a="222883231"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga002.jf.intel.com with ESMTP; 03 Dec 2019 08:45:43 -0800
Date: Tue, 3 Dec 2019 08:50:26 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 0/5] iommu/vt-d: Consolidate various cache flush ops
Message-ID: <20191203085026.1785292b@jacob-builder>
In-Reply-To: <f703c267-c946-30cf-7e0e-4de16edcde18@linux.intel.com>
References: <20191122030449.28892-1-baolu.lu@linux.intel.com>
 <20191202120252.45606c47@jacob-builder>
 <f703c267-c946-30cf-7e0e-4de16edcde18@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
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

On Tue, 3 Dec 2019 10:44:45 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi Jacob,
> 
> On 12/3/19 4:02 AM, Jacob Pan wrote:
> > On Fri, 22 Nov 2019 11:04:44 +0800
> > Lu Baolu<baolu.lu@linux.intel.com>  wrote:
> >   
> >> Intel VT-d 3.0 introduces more caches and interfaces for software
> >> to flush when it runs in the scalable mode. Currently various
> >> cache flush helpers are scattered around. This consolidates them
> >> by putting them in the existing iommu_flush structure.
> >>
> >> /* struct iommu_flush - Intel IOMMU cache invalidation ops
> >>   *
> >>   * @cc_inv: invalidate context cache
> >>   * @iotlb_inv: Invalidate IOTLB and paging structure caches when
> >> software
> >>   *             has changed second-level tables.
> >>   * @p_iotlb_inv: Invalidate IOTLB and paging structure caches when
> >> software
> >>   *               has changed first-level tables.
> >>   * @pc_inv: invalidate pasid cache
> >>   * @dev_tlb_inv: invalidate cached mappings used by
> >> requests-without-PASID
> >>   *               from the Device-TLB on a endpoint device.
> >>   * @p_dev_tlb_inv: invalidate cached mappings used by
> >> requests-with-PASID
> >>   *                 from the Device-TLB on an endpoint device
> >>   */
> >> struct iommu_flush {
> >>          void (*cc_inv)(struct intel_iommu *iommu, u16 did,
> >>                         u16 sid, u8 fm, u64 type);
> >>          void (*iotlb_inv)(struct intel_iommu *iommu, u16 did, u64
> >> addr, unsigned int size_order, u64 type);
> >>          void (*p_iotlb_inv)(struct intel_iommu *iommu, u16 did,
> >> u32 pasid, u64 addr, unsigned long npages, bool ih);
> >>          void (*pc_inv)(struct intel_iommu *iommu, u16 did, u32
> >> pasid, u64 granu);
> >>          void (*dev_tlb_inv)(struct intel_iommu *iommu, u16 sid,
> >> u16 pfsid, u16 qdep, u64 addr, unsigned int mask);
> >>          void (*p_dev_tlb_inv)(struct intel_iommu *iommu, u16 sid,
> >> u16 pfsid, u32 pasid, u16 qdep, u64 addr,
> >>                                unsigned long npages);
> >> };
> >>
> >> The name of each cache flush ops is defined according to the spec
> >> section 6.5 so that people are easy to look up them in the spec.
> >>  
> > Nice consolidation. For nested SVM, I also introduced cache flushed
> > helpers as needed.
> > https://lkml.org/lkml/2019/10/24/857
> > 
> > Should I wait for yours to be merged or you want to extend the this
> > consolidation after SVA/SVM cache flush? I expect to send my v8
> > shortly. 
> 
> Please base your v8 patch on this series. So it could get more chances
> for test.
> 
Sounds good.

> I will queue this patch series for internal test after 5.5-rc1 and if
> everything goes well, I will forward it to Joerg around rc4 for linux-
> next.
> 
> Best regards,
> baolu

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
