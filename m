Return-Path: <SRS0=r/qF=5N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF6EC2D0E8
	for <iommu@archiver.kernel.org>; Sat, 28 Mar 2020 06:44:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F822072F
	for <iommu@archiver.kernel.org>; Sat, 28 Mar 2020 06:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F822072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4087B207A4;
	Sat, 28 Mar 2020 06:44:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fj0qh5rsAbpZ; Sat, 28 Mar 2020 06:44:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3D59C203A9;
	Sat, 28 Mar 2020 06:44:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 378ABC18DA;
	Sat, 28 Mar 2020 06:44:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F9D3C0177
 for <iommu@lists.linux-foundation.org>; Sat, 28 Mar 2020 06:44:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9B147886F5
 for <iommu@lists.linux-foundation.org>; Sat, 28 Mar 2020 06:44:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NaOGd7zDHB1f for <iommu@lists.linux-foundation.org>;
 Sat, 28 Mar 2020 06:44:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CA59D886EE
 for <iommu@lists.linux-foundation.org>; Sat, 28 Mar 2020 06:44:21 +0000 (UTC)
IronPort-SDR: vQEqlQFoeSM35gZrZ0L/xfsoJBPeLAt1Yp/vbAwzcVDKvMgJKLsQfhPeAbj66llxJcRpRHII68
 wbDeD1L6AW9w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2020 23:44:21 -0700
IronPort-SDR: Luifc5ZLeKo9Za6t6vSeXRzzwDQeGumRNs/ozrB0q0wUnxydn/xYHDUtIQx1pM9/TXm70s0CDl
 NhrjHPnJEXiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,315,1580803200"; d="scan'208";a="236850536"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga007.jf.intel.com with ESMTP; 27 Mar 2020 23:44:20 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Mar 2020 23:44:20 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Mar 2020 23:44:19 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.213]) with mapi id 14.03.0439.000;
 Sat, 28 Mar 2020 14:44:16 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH 09/10] iommu/ioasid: Support ioasid_set quota adjustment
Thread-Topic: [PATCH 09/10] iommu/ioasid: Support ioasid_set quota adjustment
Thread-Index: AQHWAs3NK42wQfu7/kyYiimhS040MqhcOJaQgABbOoCAAP8EAA==
Date: Sat, 28 Mar 2020 06:44:15 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D7F76CE@SHSMSX104.ccr.corp.intel.com>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-10-git-send-email-jacob.jun.pan@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED605@SHSMSX104.ccr.corp.intel.com>
 <20200327163057.75a0e154@jacob-builder>
In-Reply-To: <20200327163057.75a0e154@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
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

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Saturday, March 28, 2020 7:31 AM
> 
> On Fri, 27 Mar 2020 10:09:04 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Sent: Thursday, March 26, 2020 1:56 AM
> > >
> > > IOASID set is allocated with an initial quota, at runtime there may
> > > be needs to balance IOASID resources among different VMs/sets.
> > >
> >
> > I may overlook previous patches but I didn't see any place setting the
> > initial quota...
> >
> Initial quota is in place when the ioasid_set is allocated.
> 
> > > This patch adds a new API to adjust per set quota.
> >
> > since this is purely an internal kernel API, implies that the
> > publisher (e.g. VFIO) is responsible for exposing its own uAPI to set
> > the quota?
> >
> yes, VFIO will do the adjustment. I think Alex suggested module
> parameters.

ok, I remember that.

> 
> > >
> > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > ---
> > >  drivers/iommu/ioasid.c | 44
> > > ++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/ioasid.h |  6 ++++++
> > >  2 files changed, 50 insertions(+)
> > >
> > > diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> > > index 27dce2cb5af2..5ac28862a1db 100644
> > > --- a/drivers/iommu/ioasid.c
> > > +++ b/drivers/iommu/ioasid.c
> > > @@ -578,6 +578,50 @@ void ioasid_free_set(int sid, bool destroy_set)
> > >  }
> > >  EXPORT_SYMBOL_GPL(ioasid_free_set);
> > >
> > > +/**
> > > + * ioasid_adjust_set - Adjust the quota of an IOASID set
> > > + * @quota:	Quota allowed in this set
> > > + * @sid:	IOASID set ID to be assigned
> > > + *
> > > + * Return 0 on success. If the new quota is smaller than the
> > > number of
> > > + * IOASIDs already allocated, -EINVAL will be returned. No change
> > > will be
> > > + * made to the existing quota.
> > > + */
> > > +int ioasid_adjust_set(int sid, int quota)
> > > +{
> > > +	struct ioasid_set_data *sdata;
> > > +	int ret = 0;
> > > +
> > > +	mutex_lock(&ioasid_allocator_lock);
> > > +	sdata = xa_load(&ioasid_sets, sid);
> > > +	if (!sdata || sdata->nr_ioasids > quota) {
> > > +		pr_err("Failed to adjust IOASID set %d quota %d\n",
> > > +			sid, quota);
> > > +		ret = -EINVAL;
> > > +		goto done_unlock;
> > > +	}
> > > +
> > > +	if (quota >= ioasid_capacity_avail) {
> > > +		ret = -ENOSPC;
> > > +		goto done_unlock;
> > > +	}
> > > +
> > > +	/* Return the delta back to system pool */
> > > +	ioasid_capacity_avail += sdata->size - quota;
> > > +
> > > +	/*
> > > +	 * May have a policy to prevent giving all available
> > > IOASIDs
> > > +	 * to one set. But we don't enforce here, it should be in
> > > the
> > > +	 * upper layers.
> > > +	 */
> > > +	sdata->size = quota;
> > > +
> > > +done_unlock:
> > > +	mutex_unlock(&ioasid_allocator_lock);
> > > +
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(ioasid_adjust_set);
> > >
> > >  /**
> > >   * ioasid_find - Find IOASID data
> > > diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> > > index 32d032913828..6e7de6fb91bf 100644
> > > --- a/include/linux/ioasid.h
> > > +++ b/include/linux/ioasid.h
> > > @@ -73,6 +73,7 @@ int ioasid_alloc_set(struct ioasid_set *token,
> > > ioasid_t quota, int *sid);
> > >  void ioasid_free_set(int sid, bool destroy_set);
> > >  int ioasid_find_sid(ioasid_t ioasid);
> > >  int ioasid_notify(ioasid_t id, enum ioasid_notify_val cmd);
> > > +int ioasid_adjust_set(int sid, int quota);
> > >
> > >  #else /* !CONFIG_IOASID */
> > >  static inline ioasid_t ioasid_alloc(int sid, ioasid_t min,
> > > @@ -136,5 +137,10 @@ static inline int ioasid_alloc_system_set(int
> > > quota) return -ENOTSUPP;
> > >  }
> > >
> > > +static inline int ioasid_adjust_set(int sid, int quota)
> > > +{
> > > +	return -ENOTSUPP;
> > > +}
> > > +
> > >  #endif /* CONFIG_IOASID */
> > >  #endif /* __LINUX_IOASID_H */
> > > --
> > > 2.7.4
> >
> 
> [Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
