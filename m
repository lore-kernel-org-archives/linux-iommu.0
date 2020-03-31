Return-Path: <SRS0=6vqp=5Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428F9C43331
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 22:31:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1851420787
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 22:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1851420787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D6E0D24F06;
	Tue, 31 Mar 2020 22:31:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zDnAKWpvHeex; Tue, 31 Mar 2020 22:31:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 777D4204D7;
	Tue, 31 Mar 2020 22:31:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4ACB8C1AE2;
	Tue, 31 Mar 2020 22:31:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEFC1C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 22:31:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A6AAB888C1
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 22:31:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QCzBDrzUj8dt for <iommu@lists.linux-foundation.org>;
 Tue, 31 Mar 2020 22:31:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C5F5B888D1
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 22:31:26 +0000 (UTC)
IronPort-SDR: f5KVDlt4mKenH4C2bTfAntCSHihDLHS7afibHqxUJGG6GfAGV1fmyZuL1VEDGinxJIyhunZET0
 zVinCWs1za9Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2020 15:31:27 -0700
IronPort-SDR: x7+9+2GyuZdKUoCr0/pqHOp/fiqSXRV71rjcAqWtV2FUjNdlw9068G2QMGr75VCvTgokzQTWXn
 MKVsGTKeb+mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,329,1580803200"; d="scan'208";a="249204455"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga003.jf.intel.com with ESMTP; 31 Mar 2020 15:31:26 -0700
Date: Tue, 31 Mar 2020 15:37:13 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH V10 10/11] iommu/vt-d: Enlightened PASID allocation
Message-ID: <20200331153713.2b53e898@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7FA10F@SHSMSX104.ccr.corp.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584746861-76386-11-git-send-email-jacob.jun.pan@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FA10F@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
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

On Sat, 28 Mar 2020 10:08:52 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Saturday, March 21, 2020 7:28 AM
> > 
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > 
> > Enabling IOMMU in a guest requires communication with the host
> > driver for certain aspects. Use of PASID ID to enable Shared Virtual
> > Addressing (SVA) requires managing PASID's in the host. VT-d 3.0
> > spec provides a Virtual Command Register (VCMD) to facilitate this.
> > Writes to this register in the guest are trapped by QEMU which
> > proxies the call to the host driver.  
> 
> Qemu -> vIOMMU
> 
Sounds good. Thanks!
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
> >  drivers/iommu/intel-pasid.c | 57
> > +++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/iommu/intel-pasid.h | 13 ++++++++++-
> >  include/linux/intel-iommu.h |  1 +
> >  3 files changed, 70 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/intel-pasid.c
> > b/drivers/iommu/intel-pasid.c index 9f6d07410722..e87ad67aad36
> > 100644 --- a/drivers/iommu/intel-pasid.c
> > +++ b/drivers/iommu/intel-pasid.c
> > @@ -27,6 +27,63 @@
> >  static DEFINE_SPINLOCK(pasid_lock);
> >  u32 intel_pasid_max_id = PASID_MAX;
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
> > +	status_code = VCMD_VRSP_SC(res);
> > +	switch (status_code) {
> > +	case VCMD_VRSP_SC_SUCCESS:
> > +		*pasid = VCMD_VRSP_RESULT_PASID(res);
> > +		break;
> > +	case VCMD_VRSP_SC_NO_PASID_AVAIL:
> > +		pr_info("IOMMU: %s: No PASID available\n",
> > iommu->name);
> > +		ret = -ENOSPC;
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
> > +	dmar_writeq(iommu->reg + DMAR_VCMD_REG,
> > +		    VCMD_CMD_OPERAND(pasid) | VCMD_CMD_FREE);
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
> > b/drivers/iommu/intel-pasid.h index 698015ee3f04..cd3d63f3e936
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
> > +#define VCMD_VRSP_RESULT_PASID(e)	(((e) >> 8) & 0xfffff)
> > +#define VCMD_CMD_OPERAND(e)		((e) << 8)
> >  /*
> >   * Domain ID reserved for pasid entries programmed for first-level
> >   * only and pass-through transfer modes.
> > @@ -113,5 +123,6 @@ int intel_pasid_setup_nested(struct intel_iommu
> > *iommu,
> >  			int addr_width);
> >  void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
> >  				 struct device *dev, int pasid);
> > -
> > +int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int
> > *pasid); +void vcmd_free_pasid(struct intel_iommu *iommu, unsigned
> > int pasid); #endif /* __INTEL_PASID_H */
> > diff --git a/include/linux/intel-iommu.h
> > b/include/linux/intel-iommu.h index ccbf164fb711..9cbf5357138b
> > 100644 --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -169,6 +169,7 @@
> >  #define ecap_smpwc(e)		(((e) >> 48) & 0x1)
> >  #define ecap_flts(e)		(((e) >> 47) & 0x1)
> >  #define ecap_slts(e)		(((e) >> 46) & 0x1)
> > +#define ecap_vcs(e)		(((e) >> 44) & 0x1)
> >  #define ecap_smts(e)		(((e) >> 43) & 0x1)
> >  #define ecap_dit(e)		((e >> 41) & 0x1)
> >  #define ecap_pasid(e)		((e >> 40) & 0x1)
> > --
> > 2.7.4  
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
