Return-Path: <SRS0=UfLp=4C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3498FC35242
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 23:21:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0648C2081E
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 23:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0648C2081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CDADE2279E;
	Fri, 14 Feb 2020 23:21:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sn9TgcL2B3BG; Fri, 14 Feb 2020 23:21:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B795D22797;
	Fri, 14 Feb 2020 23:21:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A91CFC0881;
	Fri, 14 Feb 2020 23:21:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B8A8C0177
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 23:21:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4A6232279B
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 23:21:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BU-mdzxmY3bb for <iommu@lists.linux-foundation.org>;
 Fri, 14 Feb 2020 23:21:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 5A9C222797
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 23:21:40 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Feb 2020 15:21:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,442,1574150400"; d="scan'208";a="381591053"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga004.jf.intel.com with ESMTP; 14 Feb 2020 15:21:39 -0800
Date: Fri, 14 Feb 2020 15:27:01 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH V9 05/10] iommu/vt-d: Support flushing more translation
 cache types
Message-ID: <20200214152701.18f76ce1@jacob-builder>
In-Reply-To: <11add211-dec0-1932-c29c-22cbbf145bd4@redhat.com>
References: <1580277713-66934-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1580277713-66934-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <11add211-dec0-1932-c29c-22cbbf145bd4@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

Hi Eric,

On Wed, 12 Feb 2020 13:55:25 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 1/29/20 7:01 AM, Jacob Pan wrote:
> > When Shared Virtual Memory is exposed to a guest via vIOMMU,
> > scalable IOTLB invalidation may be passed down from outside IOMMU
> > subsystems. This patch adds invalidation functions that can be used
> > for additional translation cache types.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/dmar.c        | 33 +++++++++++++++++++++++++++++++++
> >  drivers/iommu/intel-pasid.c |  3 ++-
> >  include/linux/intel-iommu.h | 20 ++++++++++++++++----
> >  3 files changed, 51 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> > index 071bb42bbbc5..206733ec8140 100644
> > --- a/drivers/iommu/dmar.c
> > +++ b/drivers/iommu/dmar.c
> > @@ -1411,6 +1411,39 @@ void qi_flush_piotlb(struct intel_iommu
> > *iommu, u16 did, u32 pasid, u64 addr, qi_submit_sync(&desc, iommu);
> >  }
> >  
> > +/* PASID-based device IOTLB Invalidate */
> > +void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid,
> > u16 pfsid,
> > +		u32 pasid,  u16 qdep, u64 addr, unsigned
> > size_order, u64 granu) +{
> > +	struct qi_desc desc = {.qw2 = 0, .qw3 = 0};
> > +
> > +	desc.qw0 = QI_DEV_EIOTLB_PASID(pasid) |
> > QI_DEV_EIOTLB_SID(sid) |
> > +		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
> > +		QI_DEV_IOTLB_PFSID(pfsid);
> > +	desc.qw1 = QI_DEV_EIOTLB_GLOB(granu);
> > +
> > +	/* If S bit is 0, we only flush a single page. If S bit is
> > set,
> > +	 * The least significant zero bit indicates the
> > invalidation address
> > +	 * range. VT-d spec 6.5.2.6.
> > +	 * e.g. address bit 12[0] indicates 8KB, 13[0] indicates
> > 16KB.
> > +	 */
> > +	if (!size_order) {
> > +		desc.qw0 |= QI_DEV_EIOTLB_ADDR(addr) &
> > ~QI_DEV_EIOTLB_SIZE;
> > +	} else {
> > +		unsigned long mask = 1UL << (VTD_PAGE_SHIFT +
> > size_order);
> > +		desc.qw1 |= QI_DEV_EIOTLB_ADDR(addr & ~mask) |
> > QI_DEV_EIOTLB_SIZE;
> > +	}
> > +	qi_submit_sync(&desc, iommu);  
> I made some comments in
> https://lkml.org/lkml/2019/8/14/1311
> that do not seem to have been taken into account. Or do I miss
> something?
> 
I missed adding these changes. At the time Baolu was doing cache flush
consolidation so I wasn't sure if I could use his code completely. This
patch is on top of his consolidated flush code with what is still
needed for vSVA. Then I forgot to address your comments. Sorry about
that.

> More generally having an individual history log would be useful and
> speed up the review.
> 
Will add history to each patch, e.g. like this?
---
v8 -> v9
---
> Thanks
> 
> Eric
> > +}
> > +
> > +void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64
> > granu, int pasid) +{
> > +	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
> > +
> > +	desc.qw0 = QI_PC_PASID(pasid) | QI_PC_DID(did) |
> > QI_PC_GRAN(granu) | QI_PC_TYPE;
> > +	qi_submit_sync(&desc, iommu);
> > +}
> > +
> >  /*
> >   * Disable Queued Invalidation interface.
> >   */
> > diff --git a/drivers/iommu/intel-pasid.c
> > b/drivers/iommu/intel-pasid.c index bd067af4d20b..b100f51407f9
> > 100644 --- a/drivers/iommu/intel-pasid.c
> > +++ b/drivers/iommu/intel-pasid.c
> > @@ -435,7 +435,8 @@ pasid_cache_invalidation_with_pasid(struct
> > intel_iommu *iommu, {
> >  	struct qi_desc desc;
> >  
> > -	desc.qw0 = QI_PC_DID(did) | QI_PC_PASID_SEL |
> > QI_PC_PASID(pasid);
> > +	desc.qw0 = QI_PC_DID(did) | QI_PC_GRAN(QI_PC_PASID_SEL) |
> > +		QI_PC_PASID(pasid) | QI_PC_TYPE;
> >  	desc.qw1 = 0;
> >  	desc.qw2 = 0;
> >  	desc.qw3 = 0;
> > diff --git a/include/linux/intel-iommu.h
> > b/include/linux/intel-iommu.h index b0ffecbc0dfc..dd9fa61689bc
> > 100644 --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -332,7 +332,7 @@ enum {
> >  #define QI_IOTLB_GRAN(gran) 	(((u64)gran) >>
> > (DMA_TLB_FLUSH_GRANU_OFFSET-4)) #define QI_IOTLB_ADDR(addr)
> > (((u64)addr) & VTD_PAGE_MASK) #define
> > QI_IOTLB_IH(ih)		(((u64)ih) << 6) -#define
> > QI_IOTLB_AM(am)		(((u8)am)) +#define
> > QI_IOTLB_AM(am)		(((u8)am) & 0x3f) 
> >  #define QI_CC_FM(fm)		(((u64)fm) << 48)
> >  #define QI_CC_SID(sid)		(((u64)sid) << 32)
> > @@ -351,16 +351,21 @@ enum {
> >  #define QI_PC_DID(did)		(((u64)did) << 16)
> >  #define QI_PC_GRAN(gran)	(((u64)gran) << 4)
> >  
> > -#define QI_PC_ALL_PASIDS	(QI_PC_TYPE | QI_PC_GRAN(0))
> > -#define QI_PC_PASID_SEL		(QI_PC_TYPE | QI_PC_GRAN(1))
> > +/* PASID cache invalidation granu */
> > +#define QI_PC_ALL_PASIDS	0
> > +#define QI_PC_PASID_SEL		1
> >  
> >  #define QI_EIOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
> >  #define QI_EIOTLB_IH(ih)	(((u64)ih) << 6)
> > -#define QI_EIOTLB_AM(am)	(((u64)am))
> > +#define QI_EIOTLB_AM(am)	(((u64)am) & 0x3f)
> >  #define QI_EIOTLB_PASID(pasid) 	(((u64)pasid) << 32)
> >  #define QI_EIOTLB_DID(did)	(((u64)did) << 16)
> >  #define QI_EIOTLB_GRAN(gran) 	(((u64)gran) << 4)
> >  
> > +/* QI Dev-IOTLB inv granu */
> > +#define QI_DEV_IOTLB_GRAN_ALL		1
> > +#define QI_DEV_IOTLB_GRAN_PASID_SEL	0
> > +
> >  #define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
> >  #define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
> >  #define QI_DEV_EIOTLB_GLOB(g)	((u64)g)
> > @@ -660,8 +665,15 @@ extern void qi_flush_iotlb(struct intel_iommu
> > *iommu, u16 did, u64 addr, unsigned int size_order, u64 type);
> >  extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid,
> > u16 pfsid, u16 qdep, u64 addr, unsigned mask);
> > +
> >  void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32
> > pasid, u64 addr, unsigned long npages, bool ih);
> > +
> > +extern void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu,
> > u16 sid, u16 pfsid,
> > +			u32 pasid, u16 qdep, u64 addr, unsigned
> > size_order, u64 granu); +
> > +extern void qi_flush_pasid_cache(struct intel_iommu *iommu, u16
> > did, u64 granu, int pasid); +
> >  extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu
> > *iommu); 
> >  extern int dmar_ir_support(void);
> >   
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
