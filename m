Return-Path: <SRS0=m6Z5=YW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B977FCA9EC3
	for <iommu@archiver.kernel.org>; Tue, 29 Oct 2019 17:10:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8302067D
	for <iommu@archiver.kernel.org>; Tue, 29 Oct 2019 17:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8302067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 534DDD4A;
	Tue, 29 Oct 2019 17:10:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CB9D2D3D
	for <iommu@lists.linux-foundation.org>;
	Tue, 29 Oct 2019 17:10:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2275D8B8
	for <iommu@lists.linux-foundation.org>;
	Tue, 29 Oct 2019 17:10:14 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	29 Oct 2019 10:10:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,244,1569308400"; d="scan'208";a="351041584"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by orsmga004.jf.intel.com with ESMTP; 29 Oct 2019 10:10:12 -0700
Date: Tue, 29 Oct 2019 10:14:36 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v7 02/11] iommu/vt-d: Enlightened PASID allocation
Message-ID: <20191029101436.3ca8d438@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D5CDC00@SHSMSX104.ccr.corp.intel.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1571946904-86776-3-git-send-email-jacob.jun.pan@linux.intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D5CDC00@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Jonathan Cameron <jic23@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, 25 Oct 2019 06:19:29 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan [mailto:jacob.jun.pan@linux.intel.com]
> > Sent: Friday, October 25, 2019 3:55 AM
> > 
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > 
> > Enabling IOMMU in a guest requires communication with the host
> > driver for certain aspects. Use of PASID ID to enable Shared Virtual
> > Addressing (SVA) requires managing PASID's in the host. VT-d 3.0
> > spec provides a Virtual Command Register (VCMD) to facilitate this.
> > Writes to this register in the guest are trapped by QEMU which
> > proxies the call to the host driver.
> > 
> > This virtual command interface consists of a capability register,
> > a virtual command register, and a virtual response register. Refer
> > to section 10.4.42, 10.4.43, 10.4.44 for more information.
> > 
> > This patch adds the enlightened PASID allocation/free interfaces
> > via the virtual command interface.
> > 
> > Cc: Ashok Raj <ashok.raj@intel.com>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > ---
> >  drivers/iommu/intel-pasid.c | 56
> > +++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/iommu/intel-pasid.h | 13 ++++++++++-
> >  include/linux/intel-iommu.h |  2 ++
> >  3 files changed, 70 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/intel-pasid.c
> > b/drivers/iommu/intel-pasid.c index 040a445be300..d81e857d2b25
> > 100644 --- a/drivers/iommu/intel-pasid.c
> > +++ b/drivers/iommu/intel-pasid.c
> > @@ -63,6 +63,62 @@ void *intel_pasid_lookup_id(int pasid)
> >  	return p;
> >  }
> > 
> > +int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int
> > *pasid) +{
> > +	unsigned long flags;
> > +	u8 status_code;
> > +	int ret = 0;
> > +	u64 res;
> > +
> > +	raw_spin_lock_irqsave(&iommu->register_lock, flags);
> > +	dmar_writeq(iommu->reg + DMAR_VCMD_REG,
> > VCMD_CMD_ALLOC);
> > +	IOMMU_WAIT_OP(iommu, DMAR_VCRSP_REG, dmar_readq,
> > +		      !(res & VCMD_VRSP_IP), res);
> > +	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
> > +  
> 
> should we handle VCMD_VRSP_IP here?
VCMD_VRSP_IP is checked above, if it times out, you will get panic. Not
sure whatelse to do?
> 
> > +	status_code = VCMD_VRSP_SC(res);
> > +	switch (status_code) {
> > +	case VCMD_VRSP_SC_SUCCESS:
> > +		*pasid = VCMD_VRSP_RESULT(res);
> > +		break;
> > +	case VCMD_VRSP_SC_NO_PASID_AVAIL:
> > +		pr_info("IOMMU: %s: No PASID available\n", iommu-  
> > >name);  
> > +		ret = -ENOMEM;
> > +		break;
> > +	default:
> > +		ret = -ENODEV;
> > +		pr_warn("IOMMU: %s: Unexpected error code %d\n",
> > +			iommu->name, status_code);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid)
> > +{
> > +	unsigned long flags;
> > +	u8 status_code;
> > +	u64 res;
> > +
> > +	raw_spin_lock_irqsave(&iommu->register_lock, flags);
> > +	dmar_writeq(iommu->reg + DMAR_VCMD_REG, (pasid << 8) |
> > VCMD_CMD_FREE);  
> 
> define a macro for pasid offset.
> 
will do.

> > +	IOMMU_WAIT_OP(iommu, DMAR_VCRSP_REG, dmar_readq,
> > +		      !(res & VCMD_VRSP_IP), res);
> > +	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
> > +
> > +	status_code = VCMD_VRSP_SC(res);
> > +	switch (status_code) {
> > +	case VCMD_VRSP_SC_SUCCESS:
> > +		break;
> > +	case VCMD_VRSP_SC_INVALID_PASID:
> > +		pr_info("IOMMU: %s: Invalid PASID\n", iommu->name);
> > +		break;
> > +	default:
> > +		pr_warn("IOMMU: %s: Unexpected error code %d\n",
> > +			iommu->name, status_code);
> > +	}
> > +}
> > +
> >  /*
> >   * Per device pasid table management:
> >   */
> > diff --git a/drivers/iommu/intel-pasid.h
> > b/drivers/iommu/intel-pasid.h index fc8cd8f17de1..e413e884e685
> > 100644 --- a/drivers/iommu/intel-pasid.h
> > +++ b/drivers/iommu/intel-pasid.h
> > @@ -23,6 +23,16 @@
> >  #define is_pasid_enabled(entry)		(((entry)->lo >> 3)
> > & 0x1) #define get_pasid_dir_size(entry)	(1 <<
> > ((((entry)->lo >> 9) & 0x7) + 7))
> > 
> > +/* Virtual command interface for enlightened pasid management. */
> > +#define VCMD_CMD_ALLOC			0x1
> > +#define VCMD_CMD_FREE			0x2
> > +#define VCMD_VRSP_IP			0x1
> > +#define VCMD_VRSP_SC(e)			(((e) >> 1) & 0x3)
> > +#define VCMD_VRSP_SC_SUCCESS		0
> > +#define VCMD_VRSP_SC_NO_PASID_AVAIL	1
> > +#define VCMD_VRSP_SC_INVALID_PASID	1
> > +#define VCMD_VRSP_RESULT(e)		(((e) >> 8) & 0xfffff)
> > +
> >  /*
> >   * Domain ID reserved for pasid entries programmed for first-level
> >   * only and pass-through transfer modes.
> > @@ -95,5 +105,6 @@ int intel_pasid_setup_pass_through(struct
> > intel_iommu *iommu,
> >  				   struct device *dev, int pasid);
> >  void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
> >  				 struct device *dev, int pasid);
> > -
> > +int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int
> > *pasid); +void vcmd_free_pasid(struct intel_iommu *iommu, unsigned
> > int pasid); #endif /* __INTEL_PASID_H */
> > diff --git a/include/linux/intel-iommu.h
> > b/include/linux/intel-iommu.h index 2e1bed9b7eef..1d4b8dcdc5d8
> > 100644 --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -161,6 +161,7 @@
> >  #define ecap_smpwc(e)		(((e) >> 48) & 0x1)
> >  #define ecap_flts(e)		(((e) >> 47) & 0x1)
> >  #define ecap_slts(e)		(((e) >> 46) & 0x1)
> > +#define ecap_vcs(e)		(((e) >> 44) & 0x1)
> >  #define ecap_smts(e)		(((e) >> 43) & 0x1)
> >  #define ecap_dit(e)		((e >> 41) & 0x1)
> >  #define ecap_pasid(e)		((e >> 40) & 0x1)
> > @@ -282,6 +283,7 @@
> > 
> >  /* PRS_REG */
> >  #define DMA_PRS_PPR	((u32)1)
> > +#define DMA_VCS_PAS	((u64)1)
> > 
> >  #define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)
> > 	\
> >  do
> > {
> > \ -- 2.7.4  
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
