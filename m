Return-Path: <SRS0=U628=6F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E052FC55185
	for <iommu@archiver.kernel.org>; Tue, 21 Apr 2020 21:45:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE9BE206D9
	for <iommu@archiver.kernel.org>; Tue, 21 Apr 2020 21:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9BE206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8B7D420476;
	Tue, 21 Apr 2020 21:45:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d4alh-C0yRXY; Tue, 21 Apr 2020 21:45:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2BA8220378;
	Tue, 21 Apr 2020 21:45:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 067FDC1D91;
	Tue, 21 Apr 2020 21:45:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E3BCC0175
 for <iommu@lists.linux-foundation.org>; Tue, 21 Apr 2020 21:45:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3899286B78
 for <iommu@lists.linux-foundation.org>; Tue, 21 Apr 2020 21:45:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7MnAzUBCPNEq for <iommu@lists.linux-foundation.org>;
 Tue, 21 Apr 2020 21:45:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 32E0B86B68
 for <iommu@lists.linux-foundation.org>; Tue, 21 Apr 2020 21:45:17 +0000 (UTC)
IronPort-SDR: cQX0lO8X/0XwftNPQzxDofK2gie1h9jNVAyCsfH0r2Z7IcuO8PpnweEBoBB2XSYsZtxq353zLv
 T9Be5ZM+XTbg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2020 14:45:16 -0700
IronPort-SDR: MwvvF2uOE0/rXubMe0J7rP2SBZ7NPzFjCQFRpdgTxUXhT+1BkCZkaaUflxP8D0Ma8PrKuUH+uN
 o6C6CID10IyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; d="scan'208";a="244305142"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga007.jf.intel.com with ESMTP; 21 Apr 2020 14:45:16 -0700
Date: Tue, 21 Apr 2020 14:51:14 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 03/10] iommu/ioasid: Introduce per set allocation APIs
Message-ID: <20200421145114.49e05059@jacob-builder>
In-Reply-To: <20200407110107.GA285264@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200401134745.GE882512@myrica>
 <20200406130245.690cfe15@jacob-builder>
 <20200407110107.GA285264@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>,
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

Sorry for the late reply, been trying to redesign the notification part.

On Tue, 7 Apr 2020 13:01:07 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Mon, Apr 06, 2020 at 01:02:45PM -0700, Jacob Pan wrote:
> > > > +	sdata = kzalloc(sizeof(*sdata), GFP_KERNEL);
> > > > +	if (!sdata)
> > > > +		return -ENOMEM;    
> > > 
> > > I don't understand why we need this structure at all, nor why we
> > > need the SID. Users have already allocated an ioasid_set, so why
> > > not just stick the content of ioasid_set_data in there, and pass
> > > the ioasid_set pointer to ioasid_alloc()?
> > >   
> > 
> > My thinking was that ioasid_set is an opaque user token, e.g. we
> > use mm to identify a common set belong to a VM.
> > 
> > This sdata is an IOASID internal structure for managing & servicing
> > per set data. If we let user fill in the content, some of the
> > entries need to be managed by the IOASID code under a lock.  
> 
> We don't have to let users fill the content. A bit like iommu_domain:
> device drivers don't modify it, they pass it to iommu_map() rather
> than passing a domain ID.
> 
much better.

> > IMO, not suitable to let user allocate and manage.
> > 
> > Perhaps we should rename struct ioasid_set to ioasid_set_token?  
> 
> Is the token actually used anywhere?  As far as I can tell VFIO does
> its own uniqueness check before calling ioasid_alloc_set(), and
> consumers of notifications don't read the token.
> 
for vt-d, the per vm token (preferrably mm) will be used by kvm to
manage its PASID translation table.
when kvm receives a notification about a new guest-host PASID mapping,
it needs to know which vm it belongs to. So if mm is used as token,
both vfio and kvm can identify PASID ownership.

> > 
> > /**
> >  * struct ioasid_set_data - Meta data about ioasid_set
> >  *
> >  * @token:	Unique to identify an IOASID set
> >  * @xa:		XArray to store ioasid_set private ID to
> > system-wide IOASID
> >  *		mapping
> >  * @max_id:	Max number of IOASIDs can be allocated within
> > the set
> >  * @nr_id	Number of IOASIDs allocated in the set
> >  * @sid		ID of the set
> >  */
> > struct ioasid_set_data {
> > 	struct ioasid_set *token;
> > 	struct xarray xa;
> > 	int size;
> > 	int nr_ioasids;
> > 	int sid;
> > 	struct rcu_head rcu;
> > };  
> 
> How about we remove the current ioasid_set, call this structure
> ioasid_set instead of ioasid_set_data, and have ioasid_alloc_set()
> return it, rather than requiring users to allocate the ioasid_set
> themselves?
> 
> 	struct ioasid_set *ioasid_alloc_set(ioasid_t quota):
> 
> This way ioasid_set is opaque to users (we could have the definition
> in ioasid.c), but it can be passed to ioasid_alloc() and avoids the
> lookup by SID. Could also add the unique token as a void * argument to
> ioasid_alloc_set(), if needed.
> 
Sounds good. still pass a token. Thanks for the idea.

> Thanks,
> Jean

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
