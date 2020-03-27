Return-Path: <SRS0=HkIk=5M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F45BC2D0ED
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 17:23:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F128206F6
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 17:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F128206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AEFE988AFB;
	Fri, 27 Mar 2020 17:23:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ztsk26vaQuaN; Fri, 27 Mar 2020 17:23:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 86A9088AF4;
	Fri, 27 Mar 2020 17:23:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70EF8C1D7C;
	Fri, 27 Mar 2020 17:23:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B441C0177
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 17:23:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3151B89462
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 17:23:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T3qOrqsbWfQq for <iommu@lists.linux-foundation.org>;
 Fri, 27 Mar 2020 17:23:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 63CE98943F
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 17:23:11 +0000 (UTC)
IronPort-SDR: I08GlZOgBiO1mzU9qVk3NZSwgqNicxIqnOnGqDCEn213lBhJ/xK12NM/7Kx7NSZX5ehQ9ifS+f
 EE27b1rpKztA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2020 10:23:05 -0700
IronPort-SDR: dmCESq+UuI/tUr1+5McIjHKVJAkla5rxQ82hDDoulRwum86+9trA9MXHYN3YnNUG5mZ/Lfejpc
 IxZbe8txAaow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,313,1580803200"; d="scan'208";a="394441624"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga004.jf.intel.com with ESMTP; 27 Mar 2020 10:23:05 -0700
Date: Fri, 27 Mar 2020 10:28:50 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 05/10] iommu/ioasid: Create an IOASID set for host SVA use
Message-ID: <20200327102850.77a5d5da@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED4DA@SHSMSX104.ccr.corp.intel.com>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED4DA@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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

On Fri, 27 Mar 2020 09:41:55 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Thursday, March 26, 2020 1:55 AM
> > 
> > Bare metal SVA allocates IOASIDs for native process addresses. This
> > should be separated from VM allocated IOASIDs thus under its own
> > set.  
> 
> A curious question. Now bare metal SVA uses the system set and guest
> SVA uses dynamically-created set. Then do we still allow ioasid_alloc
> with a NULL set pointer?
> 
Good point! There shouldn't be NULL set. That was one of the sticky
point in the previous allocation API. I will add a check in
ioasid_alloc_set().

However, there is still need for global search, e.g. PRS.
https://lore.kernel.org/linux-arm-kernel/1d62b2e1-fe8c-066d-34e0-f7929f6a78e2@arm.com/#t	

In that case, use INVALID_IOASID_SET to indicate the search is global.
e.g.
ioasid_find(INVALID_IOASID_SET, data->hpasid, NULL);

> > 
> > This patch creates a system IOASID set with its quota set to
> > PID_MAX. This is a reasonable default in that SVM capable devices
> > can only bind to limited user processes.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel-iommu.c | 8 +++++++-
> >  drivers/iommu/ioasid.c      | 9 +++++++++
> >  include/linux/ioasid.h      | 9 +++++++++
> >  3 files changed, 25 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index ec3fc121744a..af7a1ef7b31e
> > 100644 --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -3511,8 +3511,14 @@ static int __init init_dmars(void)
> >  		goto free_iommu;
> > 
> >  	/* PASID is needed for scalable mode irrespective to SVM */
> > -	if (intel_iommu_sm)
> > +	if (intel_iommu_sm) {
> >  		ioasid_install_capacity(intel_pasid_max_id);
> > +		/* We should not run out of IOASIDs at boot */
> > +		if (ioasid_alloc_system_set(PID_MAX_DEFAULT)) {
> > +			pr_err("Failed to enable host PASID
> > allocator\n");
> > +			intel_iommu_sm = 0;
> > +		}
> > +	}
> > 
> >  	/*
> >  	 * for each drhd
> > diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> > index 6265d2dbbced..9135af171a7c 100644
> > --- a/drivers/iommu/ioasid.c
> > +++ b/drivers/iommu/ioasid.c
> > @@ -39,6 +39,9 @@ struct ioasid_data {
> >  static ioasid_t ioasid_capacity;
> >  static ioasid_t ioasid_capacity_avail;
> > 
> > +int system_ioasid_sid;
> > +static DECLARE_IOASID_SET(system_ioasid);
> > +
> >  /* System capacity can only be set once */
> >  void ioasid_install_capacity(ioasid_t total)
> >  {
> > @@ -51,6 +54,12 @@ void ioasid_install_capacity(ioasid_t total)
> >  }
> >  EXPORT_SYMBOL_GPL(ioasid_install_capacity);
> > 
> > +int ioasid_alloc_system_set(int quota)
> > +{
> > +	return ioasid_alloc_set(&system_ioasid, quota,
> > &system_ioasid_sid); +}
> > +EXPORT_SYMBOL_GPL(ioasid_alloc_system_set);
> > +
> >  /*
> >   * struct ioasid_allocator_data - Internal data structure to hold
> > information
> >   * about an allocator. There are two types of allocators:
> > diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> > index 8c82d2625671..097b1cc043a3 100644
> > --- a/include/linux/ioasid.h
> > +++ b/include/linux/ioasid.h
> > @@ -29,6 +29,9 @@ struct ioasid_allocator_ops {
> >  	void *pdata;
> >  };
> > 
> > +/* Shared IOASID set for reserved for host system use */
> > +extern int system_ioasid_sid;
> > +
> >  #define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
> > 
> >  #if IS_ENABLED(CONFIG_IOASID)
> > @@ -41,6 +44,7 @@ int ioasid_register_allocator(struct
> > ioasid_allocator_ops *allocator);
> >  void ioasid_unregister_allocator(struct ioasid_allocator_ops
> > *allocator); int ioasid_attach_data(ioasid_t ioasid, void *data);
> >  void ioasid_install_capacity(ioasid_t total);
> > +int ioasid_alloc_system_set(int quota);
> >  int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int
> > *sid); void ioasid_free_set(int sid, bool destroy_set);
> >  int ioasid_find_sid(ioasid_t ioasid);
> > @@ -88,5 +92,10 @@ static inline void
> > ioasid_install_capacity(ioasid_t total) {
> >  }
> > 
> > +static inline int ioasid_alloc_system_set(int quota)
> > +{
> > +	return -ENOTSUPP;
> > +}
> > +
> >  #endif /* CONFIG_IOASID */
> >  #endif /* __LINUX_IOASID_H */
> > --
> > 2.7.4  
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
