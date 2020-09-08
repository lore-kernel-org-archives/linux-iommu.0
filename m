Return-Path: <SRS0=mWlM=CR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FBEC43461
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 20:28:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED63C2080A
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 20:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED63C2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 949E486BBD;
	Tue,  8 Sep 2020 20:28:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6CZU7rURSuP5; Tue,  8 Sep 2020 20:28:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6DC4F86796;
	Tue,  8 Sep 2020 20:28:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51CB9C0052;
	Tue,  8 Sep 2020 20:28:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18074C0051
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 20:28:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 05100873B4
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 20:28:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pK8VCk0PBVWx for <iommu@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 20:28:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0B9D6873B2
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 20:28:49 +0000 (UTC)
IronPort-SDR: Oh7DlNh870NrmvGxx8ROdsdpw/MTiPaLjkRzn4csPH9Sw05PGiqXEND+w2b2GPV4tlHqUafBfU
 Wz1Quj3D31sQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="219777034"
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; d="scan'208";a="219777034"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 13:28:49 -0700
IronPort-SDR: c0ikQvZ8vrjqGcL6rV+knrP+JTH/OpIQYI6PbA8UhpF4CtnDl4WcYUeF/JDbuetzZBvAweZTWy
 8IHs3VvfsReQ==
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; d="scan'208";a="333596282"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 13:28:49 -0700
Date: Tue, 8 Sep 2020 13:30:46 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 4/9] iommu/ioasid: Add reference couting functions
Message-ID: <20200908133046.194e0577@jacob-builder>
In-Reply-To: <20200825101937.GA3252704@myrica>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200825101937.GA3252704@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.pan.linux@gmail.com>,
 Raj Ashok <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, Wu Hao <hao.wu@intel.com>
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

On Tue, 25 Aug 2020 12:19:37 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Fri, Aug 21, 2020 at 09:35:13PM -0700, Jacob Pan wrote:
> > There can be multiple users of an IOASID, each user could have
> > hardware contexts associated with the IOASID. In order to align
> > lifecycles, reference counting is introduced in this patch. It is
> > expected that when an IOASID is being freed, each user will drop a
> > reference only after its context is cleared.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/ioasid.c | 113
> > +++++++++++++++++++++++++++++++++++++++++++++++++
> > include/linux/ioasid.h |   4 ++ 2 files changed, 117 insertions(+)
> > 
> > diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> > index f73b3dbfc37a..5f31d63c75b1 100644
> > --- a/drivers/iommu/ioasid.c
> > +++ b/drivers/iommu/ioasid.c
> > @@ -717,6 +717,119 @@ int ioasid_set_for_each_ioasid(struct
> > ioasid_set *set, EXPORT_SYMBOL_GPL(ioasid_set_for_each_ioasid);
> >  
> >  /**
> > + * IOASID refcounting rules
> > + * - ioasid_alloc() set initial refcount to 1
> > + *
> > + * - ioasid_free() decrement and test refcount.
> > + *     If refcount is 0, ioasid will be freed. Deleted from the
> > system-wide
> > + *     xarray as well as per set xarray. The IOASID will be
> > returned to the
> > + *     pool and available for new allocations.
> > + *
> > + *     If recount is non-zero, mark IOASID as
> > IOASID_STATE_FREE_PENDING.
> > + *     No new reference can be added. The IOASID is not returned
> > to the pool
> > + *     for reuse.
> > + *     After free, ioasid_get() will return error but
> > ioasid_find() and other
> > + *     non refcount adding APIs will continue to work until the
> > last reference
> > + *     is dropped
> > + *
> > + * - ioasid_get() get a reference on an active IOASID
> > + *
> > + * - ioasid_put() decrement and test refcount of the IOASID.
> > + *     If refcount is 0, ioasid will be freed. Deleted from the
> > system-wide
> > + *     xarray as well as per set xarray. The IOASID will be
> > returned to the
> > + *     pool and available for new allocations.
> > + *     Do nothing if refcount is non-zero.
> > + *
> > + * - ioasid_find() does not take reference, caller must hold
> > reference
> > + *
> > + * ioasid_free() can be called multiple times without error until
> > all refs are
> > + * dropped.
> > + */  
> 
> Since you already document this in ioasid.rst, I'm not sure the
> comment is necessary. Maybe the doc for _free/_put would be better in
> the function's documentation.
> 
good point. will move the free/put to doc.

> > +
> > +int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid)
> > +{
> > +	struct ioasid_data *data;
> > +
> > +	data = xa_load(&active_allocator->xa, ioasid);
> > +	if (!data) {
> > +		pr_err("Trying to get unknown IOASID %u\n",
> > ioasid);
> > +		return -EINVAL;
> > +	}
> > +	if (data->state == IOASID_STATE_FREE_PENDING) {
> > +		pr_err("Trying to get IOASID being freed%u\n",
> > ioasid);
> > +		return -EBUSY;
> > +	}
> > +
> > +	if (set && data->set != set) {
> > +		pr_err("Trying to get IOASID not in set%u\n",
> > ioasid);
> > +		/* data found but does not belong to the set */
> > +		return -EACCES;
> > +	}
> > +	refcount_inc(&data->users);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_get_locked);  
> 
> Is it necessary to export the *_locked variant?  Who'd call them and
> how would they acquire the lock?
> 
It is used by KVM inside the atomic notifier handler. Notifier chain is
invoked under the lock.

> > +
> > +/**
> > + * ioasid_get - Obtain a reference of an ioasid
> > + * @set
> > + * @ioasid  
> 
> Can be dropped. The doc checker will throw a warning, though.
> 
yes, will do

> > + *
> > + * Check set ownership if @set is non-null.
> > + */
> > +int ioasid_get(struct ioasid_set *set, ioasid_t ioasid)
> > +{
> > +	int ret = 0;  
> 
> No need to initialize ret
> 
right,

> > +
> > +	spin_lock(&ioasid_allocator_lock);
> > +	ret = ioasid_get_locked(set, ioasid);
> > +	spin_unlock(&ioasid_allocator_lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_get);
> > +
> > +void ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid)
> > +{
> > +	struct ioasid_data *data;
> > +
> > +	data = xa_load(&active_allocator->xa, ioasid);
> > +	if (!data) {
> > +		pr_err("Trying to put unknown IOASID %u\n",
> > ioasid);
> > +		return;
> > +	}
> > +
> > +	if (set && data->set != set) {
> > +		pr_err("Trying to drop IOASID not in the set
> > %u\n", ioasid);
> > +		return;
> > +	}
> > +
> > +	if (!refcount_dec_and_test(&data->users)) {
> > +		pr_debug("%s: IOASID %d has %d remainning users\n",
> > +			__func__, ioasid,
> > refcount_read(&data->users));
> > +		return;
> > +	}
> > +	ioasid_do_free(data);
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_put_locked);
> > +
> > +/**
> > + * ioasid_put - Drop a reference of an ioasid
> > + * @set
> > + * @ioasid
> > + *
> > + * Check set ownership if @set is non-null.
> > + */
> > +void ioasid_put(struct ioasid_set *set, ioasid_t ioasid)
> > +{
> > +	spin_lock(&ioasid_allocator_lock);
> > +	ioasid_put_locked(set, ioasid);
> > +	spin_unlock(&ioasid_allocator_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_put);
> > +
> > +/**
> >   * ioasid_find - Find IOASID data
> >   * @set: the IOASID set
> >   * @ioasid: the IOASID to find
> > diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> > index 412d025d440e..310abe4187a3 100644
> > --- a/include/linux/ioasid.h
> > +++ b/include/linux/ioasid.h
> > @@ -76,6 +76,10 @@ int ioasid_attach_data(ioasid_t ioasid, void
> > *data); int ioasid_register_allocator(struct ioasid_allocator_ops
> > *allocator); void ioasid_unregister_allocator(struct
> > ioasid_allocator_ops *allocator); void ioasid_is_in_set(struct
> > ioasid_set *set, ioasid_t ioasid); +int ioasid_get(struct
> > ioasid_set *set, ioasid_t ioasid); +int ioasid_get_locked(struct
> > ioasid_set *set, ioasid_t ioasid); +void ioasid_put(struct
> > ioasid_set *set, ioasid_t ioasid); +void ioasid_put_locked(struct
> > ioasid_set *set, ioasid_t ioasid);  
> 
> Please also add the stubs for !CONFIG_IOASID.
> 
yes, will do.

Thanks a lot!

> Thanks,
> Jean
> 
> >  int ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
> >  			       void (*fn)(ioasid_t id, void *data),
> >  			       void *data);
> > -- 
> > 2.7.4
> >   
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
