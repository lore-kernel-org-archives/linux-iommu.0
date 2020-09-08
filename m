Return-Path: <SRS0=mWlM=CR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C483C43461
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 22:38:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDABD20757
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 22:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDABD20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 88F20272A1;
	Tue,  8 Sep 2020 22:38:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lXMSzK9wjcsm; Tue,  8 Sep 2020 22:38:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5377C204A1;
	Tue,  8 Sep 2020 22:38:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3903AC0052;
	Tue,  8 Sep 2020 22:38:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92FC9C0051
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 22:38:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 89C258726C
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 22:38:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XPsYdb7wvn8O for <iommu@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 22:38:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8B88287267
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 22:38:31 +0000 (UTC)
IronPort-SDR: +Fa0N0wg7Z1RuqxPM5AzE3ouIu6ELukFq4KPozjLbZ2hwTzYY8MBgKZ8DU14I5BUJ0N3KrMW3A
 IButqsKA0lHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="138280197"
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; d="scan'208";a="138280197"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 15:38:31 -0700
IronPort-SDR: EXbna6K539fSGhwY4i7HUSEKvHAbnLBaGp+NlajOVbjBbB2b1zZiXoBoI2SL6vgpSZ/TdFOEFl
 bN3NCBaz0Efw==
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; d="scan'208";a="448970957"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 15:38:30 -0700
Date: Tue, 8 Sep 2020 15:40:28 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 5/9] iommu/ioasid: Introduce ioasid_set private ID
Message-ID: <20200908154028.0ec5abba@jacob-builder>
In-Reply-To: <8fe449f7-606e-e90a-28d5-9c29cac5a9c3@redhat.com>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <8fe449f7-606e-e90a-28d5-9c29cac5a9c3@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.pan.linux@gmail.com>,
 Raj Ashok <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Wu Hao <hao.wu@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>
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

On Tue, 1 Sep 2020 17:38:44 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> On 8/22/20 6:35 AM, Jacob Pan wrote:
> > When an IOASID set is used for guest SVA, each VM will acquire its
> > ioasid_set for IOASID allocations. IOASIDs within the VM must have a
> > host/physical IOASID backing, mapping between guest and host
> > IOASIDs can be non-identical. IOASID set private ID (SPID) is
> > introduced in this patch to be used as guest IOASID. However, the
> > concept of ioasid_set specific namespace is generic, thus named
> > SPID.
> > 
> > As SPID namespace is within the IOASID set, the IOASID core can
> > provide lookup services at both directions. SPIDs may not be
> > allocated when its IOASID is allocated, the mapping between SPID
> > and IOASID is usually established when a guest page table is bound
> > to a host PASID.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/ioasid.c | 54
> > ++++++++++++++++++++++++++++++++++++++++++++++++++
> > include/linux/ioasid.h | 12 +++++++++++ 2 files changed, 66
> > insertions(+)
> > 
> > diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> > index 5f31d63c75b1..c0aef38a4fde 100644
> > --- a/drivers/iommu/ioasid.c
> > +++ b/drivers/iommu/ioasid.c
> > @@ -21,6 +21,7 @@ enum ioasid_state {
> >   * struct ioasid_data - Meta data about ioasid
> >   *
> >   * @id:		Unique ID
> > + * @spid:	Private ID unique within a set
> >   * @users	Number of active users
> >   * @state	Track state of the IOASID
> >   * @set		Meta data of the set this IOASID belongs to
> > @@ -29,6 +30,7 @@ enum ioasid_state {
> >   */
> >  struct ioasid_data {
> >  	ioasid_t id;
> > +	ioasid_t spid;
> >  	struct ioasid_set *set;
> >  	refcount_t users;
> >  	enum ioasid_state state;
> > @@ -326,6 +328,58 @@ int ioasid_attach_data(ioasid_t ioasid, void
> > *data) EXPORT_SYMBOL_GPL(ioasid_attach_data);
> >  
> >  /**
> > + * ioasid_attach_spid - Attach ioasid_set private ID to an IOASID
> > + *
> > + * @ioasid: the ID to attach
> > + * @spid:   the ioasid_set private ID of @ioasid
> > + *
> > + * For IOASID that is already allocated, private ID within the set
> > can be
> > + * attached via this API. Future lookup can be done via
> > ioasid_find.  
> I would remove "For IOASID that is already allocated, private ID
> within the set can be attached via this API"
I guess it is implied. Will remove.

> > + */
> > +int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
> > +{
> > +	struct ioasid_data *ioasid_data;
> > +	int ret = 0;
> > +
> > +	spin_lock(&ioasid_allocator_lock);  
> We keep on saying the SPID is local to an IOASID set but we don't
> check any IOASID set contains this ioasid. It looks a bit weird to me.
We store ioasid_set inside ioasid_data when an IOASID is allocated, so
we don't need to search all the ioasid_sets. Perhaps I missed your
point?

> > +	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> > +
> > +	if (!ioasid_data) {
> > +		pr_err("No IOASID entry %d to attach SPID %d\n",
> > +			ioasid, spid);
> > +		ret = -ENOENT;
> > +		goto done_unlock;
> > +	}
> > +	ioasid_data->spid = spid;  
> is there any way/need to remove an spid binding?
For guest SVA, we attach SPID as a guest PASID during bind guest page
table. Unbind does the opposite, ioasid_attach_spid() with
spid=INVALID_IOASID clears the binding.

Perhaps add more symmetric functions? i.e.
ioasid_detach_spid(ioasid_t ioasid)
ioasid_attach_spid(struct ioasid_set *set, ioasid_t ioasid)

> > +
> > +done_unlock:
> > +	spin_unlock(&ioasid_allocator_lock);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_attach_spid);
> > +
> > +ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid)
> > +{
> > +	struct ioasid_data *entry;
> > +	unsigned long index;
> > +
> > +	if (!xa_load(&ioasid_sets, set->sid)) {
> > +		pr_warn("Invalid set\n");
> > +		return INVALID_IOASID;
> > +	}
> > +
> > +	xa_for_each(&set->xa, index, entry) {
> > +		if (spid == entry->spid) {
> > +			pr_debug("Found ioasid %lu by spid %u\n",
> > index, spid);
> > +			refcount_inc(&entry->users);
> > +			return index;
> > +		}
> > +	}
> > +	return INVALID_IOASID;
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_find_by_spid);
> > +
> > +/**
> >   * ioasid_alloc - Allocate an IOASID
> >   * @set: the IOASID set
> >   * @min: the minimum ID (inclusive)
> > diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> > index 310abe4187a3..d4b3e83672f6 100644
> > --- a/include/linux/ioasid.h
> > +++ b/include/linux/ioasid.h
> > @@ -73,6 +73,8 @@ bool ioasid_is_active(ioasid_t ioasid);
> >  
> >  void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid, bool
> > (*getter)(void *)); int ioasid_attach_data(ioasid_t ioasid, void
> > *data); +int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid);
> > +ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t
> > spid); int ioasid_register_allocator(struct ioasid_allocator_ops
> > *allocator); void ioasid_unregister_allocator(struct
> > ioasid_allocator_ops *allocator); void ioasid_is_in_set(struct
> > ioasid_set *set, ioasid_t ioasid); @@ -136,5 +138,15 @@ static
> > inline int ioasid_attach_data(ioasid_t ioasid, void *data) return
> > -ENOTSUPP; }
> >  
> > +staic inline int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
> > +{
> > +	return -ENOTSUPP;
> > +}
> > +
> > +static inline ioasid_t ioasid_find_by_spid(struct ioasid_set *set,
> > ioasid_t spid) +{
> > +	return -ENOTSUPP;
> > +}
> > +
> >  #endif /* CONFIG_IOASID */
> >  #endif /* __LINUX_IOASID_H */
> >   
> Thanks
> 
> Eric
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
