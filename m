Return-Path: <SRS0=HkIk=5M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76466C43331
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 16:02:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 421072071B
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 16:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421072071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1BA9F87446;
	Fri, 27 Mar 2020 16:02:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7lgeJSSIPi_m; Fri, 27 Mar 2020 16:02:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6DD34872EF;
	Fri, 27 Mar 2020 16:02:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34E26C1D7C;
	Fri, 27 Mar 2020 16:02:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE69CC0177
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 16:02:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 974E7895E5
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 16:02:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N3pNzfCTA69d for <iommu@lists.linux-foundation.org>;
 Fri, 27 Mar 2020 16:02:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C3D588929F
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 16:02:16 +0000 (UTC)
IronPort-SDR: lq6MofnJWb/9yX+R30NHGxEN4hBOpN1MHnVVCjQedK+8d9FcU2itCzkoP0LiG7QbH+OILrXKhK
 Ln8ZPBnGH/9g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2020 09:02:15 -0700
IronPort-SDR: xB2dVmSGKpWZumoZA4tldw1y68F80iVE6l1Sl7XNuAGzMoP4bmWRqTu/z4QoAm8CunjOIQYfNK
 rajAc6vD70+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,313,1580803200"; d="scan'208";a="247925019"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga003.jf.intel.com with ESMTP; 27 Mar 2020 09:02:15 -0700
Date: Fri, 27 Mar 2020 09:08:00 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 01/10] iommu/ioasid: Introduce system-wide capacity
Message-ID: <20200327090800.64949170@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED264@SHSMSX104.ccr.corp.intel.com>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED264@SHSMSX104.ccr.corp.intel.com>
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

On Fri, 27 Mar 2020 08:07:20 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Thursday, March 26, 2020 1:55 AM
> > 
> > IOASID is a limited system-wide resource that can be allocated at
> > runtime. This limitation can be enumerated during boot. For
> > example, on x86 platforms, PCI Process Address Space ID (PASID)
> > allocation uses IOASID service. The number of supported PASID bits
> > are enumerated by extended capability register as defined in the
> > VT-d spec.
> > 
> > This patch adds a helper to set the system capacity, it expected to
> > be set during boot prior to any allocation request.
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
> 
> From all the texts in this patch, looks ioasid_set_capacity might be
> a better name?
> 
That was my initial choice as well :), but it may get confused with
ioasid_set.

I will rephrase the text to avoid 'set'.

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
> > ioasid, void *data)
> >  	return -ENOTSUPP;
> >  }
> > 
> > +static inline void ioasid_install_capacity(ioasid_t total)
> > +{
> > +}
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
