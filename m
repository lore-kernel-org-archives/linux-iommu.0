Return-Path: <SRS0=BbwH=5W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8403C2BA1A
	for <iommu@archiver.kernel.org>; Mon,  6 Apr 2020 19:57:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F4F20672
	for <iommu@archiver.kernel.org>; Mon,  6 Apr 2020 19:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F4F20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7939C20784;
	Mon,  6 Apr 2020 19:57:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VeiloW5uMVJz; Mon,  6 Apr 2020 19:57:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 726D32001F;
	Mon,  6 Apr 2020 19:57:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F183C1AE2;
	Mon,  6 Apr 2020 19:57:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55CA9C0177
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 19:57:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1F51D87C20
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 19:57:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f-cH7Ill38bZ for <iommu@lists.linux-foundation.org>;
 Mon,  6 Apr 2020 19:56:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 045DD877A0
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 19:56:55 +0000 (UTC)
IronPort-SDR: Z4TnPjS8ZAe0rjPqNcDaY5ZU2yUEcfjqb6dZPsP9iEINw6Rb2VEjf3P84B5pmcali2uoGoHNL+
 ew9flHofiBEQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2020 12:56:55 -0700
IronPort-SDR: 7jaDNfISimOsHgG8svNRIWnOicdsddpNv9m3+uFUcpM6VJKwiW8snjGbgyGtWgyPJzwB932q9z
 tta1yJ1iMWGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,352,1580803200"; d="scan'208";a="247005866"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 06 Apr 2020 12:56:54 -0700
Date: Mon, 6 Apr 2020 13:02:45 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 03/10] iommu/ioasid: Introduce per set allocation APIs
Message-ID: <20200406130245.690cfe15@jacob-builder>
In-Reply-To: <20200401134745.GE882512@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200401134745.GE882512@myrica>
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

On Wed, 1 Apr 2020 15:47:45 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Wed, Mar 25, 2020 at 10:55:24AM -0700, Jacob Pan wrote:
> > IOASID set defines a group of IDs that share the same token. The
> > ioasid_set concept helps to do permission checking among users as
> > in the current code.
> > 
> > With guest SVA usage, each VM has its own IOASID set. More
> > functionalities are needed:
> > 1. Enforce quota, each guest may be assigned limited quota such
> > that one guest cannot abuse all the system resource.
> > 2. Stores IOASID mapping between guest and host IOASIDs
> > 3. Per set operations, e.g. free the entire set
> > 
> > For each ioasid_set token, a unique set ID is assigned. This makes
> > reference of the set and data lookup much easier to implement.
> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/ioasid.c | 147
> > +++++++++++++++++++++++++++++++++++++++++++++++++
> > include/linux/ioasid.h |  13 +++++ 2 files changed, 160
> > insertions(+)
> > 
> > diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> > index 4026e52855b9..27ee57f7079b 100644
> > --- a/drivers/iommu/ioasid.c
> > +++ b/drivers/iommu/ioasid.c
> > @@ -10,6 +10,25 @@
> >  #include <linux/spinlock.h>
> >  #include <linux/xarray.h>
> >  
> > +static DEFINE_XARRAY_ALLOC(ioasid_sets);
> > +/**
> > + * struct ioasid_set_data - Meta data about ioasid_set
> > + *
> > + * @token:	Unique to identify an IOASID set
> > + * @xa:		XArray to store subset ID and IOASID mapping
> > + * @size:	Max number of IOASIDs can be allocated within the
> > set
> > + * @nr_ioasids	Number of IOASIDs allocated in the set
> > + * @sid		ID of the set
> > + */
> > +struct ioasid_set_data {
> > +	struct ioasid_set *token;
> > +	struct xarray xa;
> > +	int size;
> > +	int nr_ioasids;
> > +	int sid;
> > +	struct rcu_head rcu;
> > +};
> > +
> >  struct ioasid_data {
> >  	ioasid_t id;
> >  	struct ioasid_set *set;
> > @@ -388,6 +407,111 @@ void ioasid_free(ioasid_t ioasid)
> >  EXPORT_SYMBOL_GPL(ioasid_free);
> >  
> >  /**
> > + * ioasid_alloc_set - Allocate a set of IOASIDs
> > + * @token:	Unique token of the IOASID set
> > + * @quota:	Quota allowed in this set
> > + * @sid:	IOASID set ID to be assigned
> > + *
> > + * Return 0 upon success. Token will be stored internally for
> > lookup,
> > + * IOASID allocation within the set and other per set operations
> > will use
> > + * the @sid assigned.
> > + *
> > + */
> > +int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int
> > *sid) +{
> > +	struct ioasid_set_data *sdata;
> > +	ioasid_t id;
> > +	int ret = 0;
> > +
> > +	if (quota > ioasid_capacity_avail) {
> > +		pr_warn("Out of IOASID capacity! ask %d, avail
> > %d\n",
> > +			quota, ioasid_capacity_avail);
> > +		return -ENOSPC;
> > +	}  
> 
> This check should be in the same critical section as the quota
> substraction
> 
yes, right.

> > +
> > +	sdata = kzalloc(sizeof(*sdata), GFP_KERNEL);
> > +	if (!sdata)
> > +		return -ENOMEM;  
> 
> I don't understand why we need this structure at all, nor why we need
> the SID. Users have already allocated an ioasid_set, so why not just
> stick the content of ioasid_set_data in there, and pass the
> ioasid_set pointer to ioasid_alloc()?
> 

My thinking was that ioasid_set is an opaque user token, e.g. we use mm
to identify a common set belong to a VM.

This sdata is an IOASID internal structure for managing & servicing per
set data. If we let user fill in the content, some of the entries need
to be managed by the IOASID code under a lock. IMO, not suitable to let
user allocate and manage.

Perhaps we should rename struct ioasid_set to ioasid_set_token?

/**
 * struct ioasid_set_data - Meta data about ioasid_set
 *
 * @token:	Unique to identify an IOASID set
 * @xa:		XArray to store ioasid_set private ID to
system-wide IOASID
 *		mapping
 * @max_id:	Max number of IOASIDs can be allocated within the set
 * @nr_id	Number of IOASIDs allocated in the set
 * @sid		ID of the set
 */
struct ioasid_set_data {
	struct ioasid_set *token;
	struct xarray xa;
	int size;
	int nr_ioasids;
	int sid;
	struct rcu_head rcu;
};


I agree SID is optional. User could just use the token to reference
the set. I use the SID for performance reason, i.e. quick lookup from
SID to its data. Otherwise, we may have to search through a list of
sets to find a match?

> > +
> > +	spin_lock(&ioasid_allocator_lock);
> > +
> > +	ret = xa_alloc(&ioasid_sets, &id, sdata,
> > +		       XA_LIMIT(0, ioasid_capacity_avail - quota),
> > +		       GFP_KERNEL);  
> 
> Same as Kevin, I think the limit should be the static
> ioasid_capacity. And perhaps a comment explaining the worst case of
> one PASID per set. I found a little confusing using the same type
> ioasid_t for IOASIDs and IOASID sets, it may be clearer to use an int
> for IOASID set IDs.
> 
Sounds good.

> Thanks,
> Jean
> 
> > +	if (ret) {
> > +		kfree(sdata);
> > +		goto error;
> > +	}
> > +
> > +	sdata->token = token;
> > +	sdata->size = quota;
> > +	sdata->sid = id;
> > +
> > +	/*
> > +	 * Set Xarray is used to store IDs within the set, get
> > ready for
> > +	 * sub-set ID and system-wide IOASID allocation results.
> > +	 */
> > +	xa_init_flags(&sdata->xa, XA_FLAGS_ALLOC);
> > +
> > +	ioasid_capacity_avail -= quota;
> > +	*sid = id;
> > +
> > +error:
> > +	spin_unlock(&ioasid_allocator_lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_alloc_set);
> > +
> > +/**
> > + * ioasid_free_set - Free all IOASIDs within the set
> > + *
> > + * @sid:		The IOASID set ID to be freed
> > + * @destroy_set:	Whether to keep the set for further
> > allocation.
> > + *			If true, the set will be destroyed.
> > + *
> > + * All IOASIDs allocated within the set will be freed upon return.
> > + */
> > +void ioasid_free_set(int sid, bool destroy_set)
> > +{
> > +	struct ioasid_set_data *sdata;
> > +	struct ioasid_data *entry;
> > +	unsigned long index;
> > +
> > +	spin_lock(&ioasid_allocator_lock);
> > +	sdata = xa_load(&ioasid_sets, sid);
> > +	if (!sdata) {
> > +		pr_err("No IOASID set found to free %d\n", sid);
> > +		goto done_unlock;
> > +	}
> > +
> > +	if (xa_empty(&sdata->xa)) {
> > +		pr_warn("No IOASIDs in the set %d\n", sdata->sid);
> > +		goto done_destroy;
> > +	}
> > +
> > +	/* Just a place holder for now */
> > +	xa_for_each(&sdata->xa, index, entry) {
> > +		/* Free from per sub-set pool */
> > +		xa_erase(&sdata->xa, index);
> > +	}
> > +
> > +done_destroy:
> > +	if (destroy_set) {
> > +		xa_erase(&ioasid_sets, sid);
> > +
> > +		/* Return the quota back to system pool */
> > +		ioasid_capacity_avail += sdata->size;
> > +		kfree_rcu(sdata, rcu);
> > +	}
> > +
> > +done_unlock:
> > +	spin_unlock(&ioasid_allocator_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_free_set);
> > +
> > +
> > +/**
> >   * ioasid_find - Find IOASID data
> >   * @set: the IOASID set
> >   * @ioasid: the IOASID to find
> > @@ -431,6 +555,29 @@ void *ioasid_find(struct ioasid_set *set,
> > ioasid_t ioasid, }
> >  EXPORT_SYMBOL_GPL(ioasid_find);
> >  
> > +/**
> > + * ioasid_find_sid - Retrieve IOASID set ID from an ioasid
> > + *                   Caller must hold a reference to the set.
> > + *
> > + * @ioasid: IOASID associated with the set
> > + *
> > + * Return IOASID set ID or error
> > + */
> > +int ioasid_find_sid(ioasid_t ioasid)
> > +{
> > +	struct ioasid_data *ioasid_data;
> > +	int ret = 0;
> > +
> > +	spin_lock(&ioasid_allocator_lock);
> > +	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> > +	ret = (ioasid_data) ? ioasid_data->sdata->sid : -ENOENT;
> > +
> > +	spin_unlock(&ioasid_allocator_lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_find_sid);
> > +
> >  MODULE_AUTHOR("Jean-Philippe Brucker
> > <jean-philippe.brucker@arm.com>"); MODULE_AUTHOR("Jacob Pan
> > <jacob.jun.pan@linux.intel.com>"); MODULE_DESCRIPTION("IO Address
> > Space ID (IOASID) allocator"); diff --git a/include/linux/ioasid.h
> > b/include/linux/ioasid.h index 9711fa0dc357..be158e03c034 100644
> > --- a/include/linux/ioasid.h
> > +++ b/include/linux/ioasid.h
> > @@ -41,6 +41,9 @@ int ioasid_register_allocator(struct
> > ioasid_allocator_ops *allocator); void
> > ioasid_unregister_allocator(struct ioasid_allocator_ops
> > *allocator); int ioasid_set_data(ioasid_t ioasid, void *data); void
> > ioasid_install_capacity(ioasid_t total); +int
> > ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int
> > *sid); +void ioasid_free_set(int sid, bool destroy_set); +int
> > ioasid_find_sid(ioasid_t ioasid); #else /* !CONFIG_IOASID */
> >  static inline ioasid_t ioasid_alloc(struct ioasid_set *set,
> > ioasid_t min, ioasid_t max, void *private)
> > @@ -52,6 +55,15 @@ static inline void ioasid_free(ioasid_t ioasid)
> >  {
> >  }
> >  
> > +static inline int ioasid_alloc_set(struct ioasid_set *token,
> > ioasid_t quota, int *sid) +{
> > +	return -ENOTSUPP;
> > +}
> > +
> > +static inline void ioasid_free_set(int sid, bool destroy_set)
> > +{
> > +}
> > +
> >  static inline void *ioasid_find(struct ioasid_set *set, ioasid_t
> > ioasid, bool (*getter)(void *))
> >  {
> > @@ -75,5 +87,6 @@ static inline int ioasid_set_data(ioasid_t
> > ioasid, void *data) static inline void
> > ioasid_install_capacity(ioasid_t total) {
> >  }
> > +
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
