Return-Path: <SRS0=PWDw=5R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAF6C2D0F0
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 22:44:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 952E020719
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 22:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952E020719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6B8802549C;
	Wed,  1 Apr 2020 22:44:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FlfSDRJDaFVL; Wed,  1 Apr 2020 22:44:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3F3AD20478;
	Wed,  1 Apr 2020 22:44:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2EEE3C1AE2;
	Wed,  1 Apr 2020 22:44:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0FDCC089F
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 22:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E005686749
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 22:44:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 77kssRdsnibK for <iommu@lists.linux-foundation.org>;
 Wed,  1 Apr 2020 22:44:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D8F5586138
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 22:44:26 +0000 (UTC)
IronPort-SDR: W7OSmHdl5WiMjw6j/ld1LrnImBB5O0ssQK868WI9PUB5ggH/2f1cEa1ZimC9yc1HJ7g0sHAeb8
 G1OJCe6g4LrA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2020 15:44:26 -0700
IronPort-SDR: zkdHSM9lj9RG+TCgrQGNl9DJiOh5LdoXcru112HuXNimShCk6VYW+Fmyawdg5b+53sAe07ES/A
 wXa/65VULsgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,333,1580803200"; d="scan'208";a="284569522"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by fmsmga002.fm.intel.com with ESMTP; 01 Apr 2020 15:44:25 -0700
Date: Wed, 1 Apr 2020 15:50:13 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 01/10] iommu/ioasid: Introduce system-wide capacity
Message-ID: <20200401155013.7386b2ad@jacob-builder>
In-Reply-To: <20200401134552.GD882512@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200401134552.GD882512@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
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

Hi Jean,

On Wed, 1 Apr 2020 15:45:52 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Wed, Mar 25, 2020 at 10:55:22AM -0700, Jacob Pan wrote:
> > IOASID is a limited system-wide resource that can be allocated at
> > runtime. This limitation can be enumerated during boot. For
> > example, on x86 platforms, PCI Process Address Space ID (PASID)
> > allocation uses IOASID service. The number of supported PASID bits
> > are enumerated by extended capability register as defined in the
> > VT-d spec.
> > 
> > This patch adds a helper to set the system capacity, it expected to
> > be set during boot prior to any allocation request.  
> 
> This one-time setting is a bit awkward. Since multiple IOMMU drivers
> may be loaded, this can't be a module_init() thing. And we generally
> have multiple SMMU instances in the system. So we'd need to call
> install_capacity() only for the first SMMU loaded with an arbitrary
> 1<<20, even though each SMMU can support different numbers of PASID
> bits. Furthermore, modules such as iommu-sva will want to initialize
> their IOASID set at module_init(), which will happen before the SMMU
> can set up the capacity, so ioasid_alloc_set() will return an error.
> 
> How about hardcoding ioasid_capacity to 20 bits for now?  It's the
> PCIe limit and probably won't have to increase for a while.
> 
Sound good. Default to 20 bits but can be adjusted if needed.
 

> Thanks,
> Jean
> 
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/ioasid.c | 15 +++++++++++++++
> >  include/linux/ioasid.h |  5 ++++-
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> > index 0f8dd377aada..4026e52855b9 100644
> > --- a/drivers/iommu/ioasid.c
> > +++ b/drivers/iommu/ioasid.c
> > @@ -17,6 +17,21 @@ struct ioasid_data {
> >  	struct rcu_head rcu;
> >  };
> >  
> > +static ioasid_t ioasid_capacity;
> > +static ioasid_t ioasid_capacity_avail;
> > +
> > +/* System capacity can only be set once */
> > +void ioasid_install_capacity(ioasid_t total)
> > +{
> > +	if (ioasid_capacity) {
> > +		pr_warn("IOASID capacity already set at %d\n",
> > ioasid_capacity);
> > +		return;
> > +	}
> > +
> > +	ioasid_capacity = ioasid_capacity_avail = total;
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_install_capacity);
> > +
> >  /*
> >   * struct ioasid_allocator_data - Internal data structure to hold
> > information
> >   * about an allocator. There are two types of allocators:
> > diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> > index 6f000d7a0ddc..9711fa0dc357 100644
> > --- a/include/linux/ioasid.h
> > +++ b/include/linux/ioasid.h
> > @@ -40,7 +40,7 @@ void *ioasid_find(struct ioasid_set *set,
> > ioasid_t ioasid, int ioasid_register_allocator(struct
> > ioasid_allocator_ops *allocator); void
> > ioasid_unregister_allocator(struct ioasid_allocator_ops
> > *allocator); int ioasid_set_data(ioasid_t ioasid, void *data); -
> > +void ioasid_install_capacity(ioasid_t total);
> >  #else /* !CONFIG_IOASID */
> >  static inline ioasid_t ioasid_alloc(struct ioasid_set *set,
> > ioasid_t min, ioasid_t max, void *private)
> > @@ -72,5 +72,8 @@ static inline int ioasid_set_data(ioasid_t
> > ioasid, void *data) return -ENOTSUPP;
> >  }
> >  
> > +static inline void ioasid_install_capacity(ioasid_t total)
> > +{
> > +}
> >  #endif /* CONFIG_IOASID */
> >  #endif /* __LINUX_IOASID_H */
> > -- 
> > 2.7.4
> >   

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
