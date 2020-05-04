Return-Path: <SRS0=OemM=6S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31FAC3A5A9
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 15:21:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB709206D9
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 15:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB709206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7FC1220412;
	Mon,  4 May 2020 15:21:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V8KpCcA2Y-es; Mon,  4 May 2020 15:21:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C01BF20356;
	Mon,  4 May 2020 15:21:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1F82C088A;
	Mon,  4 May 2020 15:21:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2973C0175
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 15:21:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CE58A20412
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 15:21:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SrGAGZPRQ8XX for <iommu@lists.linux-foundation.org>;
 Mon,  4 May 2020 15:21:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by silver.osuosl.org (Postfix) with ESMTPS id 04C0D20356
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 15:20:59 +0000 (UTC)
IronPort-SDR: szvtyHzL+qQFliBgg5PyBL5DLaiYmrW//CDTCZzc/Qm5PpY9thX81N79/jXFacrNBBI0NV19ue
 GOyYjEDEPskw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2020 08:20:59 -0700
IronPort-SDR: DhyAxpzPRY/Tebzamw5nV/OXd83VAZRNIf4QKSKn9BLW4Q4E1kjVLjHW+nXqmurbxOZK0rot2h
 utpob8xZoQVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,352,1583222400"; d="scan'208";a="460700180"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by fmsmga005.fm.intel.com with ESMTP; 04 May 2020 08:20:58 -0700
Date: Mon, 4 May 2020 08:27:03 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v6 02/25] iommu/ioasid: Add ioasid references
Message-ID: <20200504082703.2ecc03c1@jacob-builder>
In-Reply-To: <20200504142548.GB170104@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-3-jean-philippe@linaro.org>
 <20200430113931.0fbf7a37@jacob-builder>
 <20200504142548.GB170104@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, jgg@ziepe.ca,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, fenghua.yu@intel.com,
 hch@infradead.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, catalin.marinas@arm.com, felix.kuehling@amd.com,
 will@kernel.org, christian.koenig@amd.com,
 linux-arm-kernel@lists.infradead.org
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

On Mon, 4 May 2020 16:25:48 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Thu, Apr 30, 2020 at 11:39:31AM -0700, Jacob Pan wrote:
> > > +/**
> > > + * ioasid_get - obtain a reference to the IOASID
> > > + */
> > > +void ioasid_get(ioasid_t ioasid)  
> > why void? what if the ioasid is not valid.  
> 
> My intended use was for the caller to get an additional reference when
> they're already holding one. So this should always succeed and I'd
> prefer a WARN_ON if the ioasid isn't valid rather than returning an
> error. But if you intend to add a state to ioasids between dropping
> refcount and free, then a return value makes sense.
> 
Yes, a WARN_ON will do. No need for return value for now.

> Thanks,
> Jean
> 
> >   
> > > +{
> > > +	struct ioasid_data *ioasid_data;
> > > +
> > > +	spin_lock(&ioasid_allocator_lock);
> > > +	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> > > +	if (ioasid_data)
> > > +		refcount_inc(&ioasid_data->refs);
> > > +	spin_unlock(&ioasid_allocator_lock);
> > > +}
> > > +EXPORT_SYMBOL_GPL(ioasid_get);
> > > +
> > >  /**
> > >   * ioasid_free - Free an IOASID
> > >   * @ioasid: the ID to remove
> > > + *
> > > + * Put a reference to the IOASID, free it when the number of
> > > references drops to
> > > + * zero.
> > > + *
> > > + * Return: %true if the IOASID was freed, %false otherwise.
> > >   */
> > > -void ioasid_free(ioasid_t ioasid)
> > > +bool ioasid_free(ioasid_t ioasid)
> > >  {
> > > +	bool free = false;
> > >  	struct ioasid_data *ioasid_data;
> > >  
> > >  	spin_lock(&ioasid_allocator_lock);
> > > @@ -360,6 +383,10 @@ void ioasid_free(ioasid_t ioasid)
> > >  		goto exit_unlock;
> > >  	}
> > >  
> > > +	free = refcount_dec_and_test(&ioasid_data->refs);
> > > +	if (!free)
> > > +		goto exit_unlock;
> > > +  
> > Just FYI, we may need to add states for the IOASID, i.g. mark the
> > IOASID inactive after free. And prohibit ioasid_get() after freed.
> > For VT-d, this is useful when KVM queries the IOASID.
> >   
> > >  	active_allocator->ops->free(ioasid,
> > > active_allocator->ops->pdata); /* Custom allocator needs
> > > additional steps to free the xa element */ if
> > > (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) { @@ -369,6
> > > +396,7 @@ void ioasid_free(ioasid_t ioasid) 
> > >  exit_unlock:
> > >  	spin_unlock(&ioasid_allocator_lock);
> > > +	return free;
> > >  }
> > >  EXPORT_SYMBOL_GPL(ioasid_free);
> > >    
> > 
> > [Jacob Pan]  

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
