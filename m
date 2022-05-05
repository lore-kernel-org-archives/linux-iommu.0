Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6362C433EF
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 13:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DAB0840A9;
	Thu,  5 May 2022 13:39:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qP2lPUPiduSz; Thu,  5 May 2022 13:39:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 35C92840A1;
	Thu,  5 May 2022 13:39:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5508C007B;
	Thu,  5 May 2022 13:39:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C700C002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 13:39:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DD2F4840F5
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 13:39:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MWzhZy7fmvo5 for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 13:39:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E39E840DA
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 13:39:08 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-d39f741ba0so4202298fac.13
 for <iommu@lists.linux-foundation.org>; Thu, 05 May 2022 06:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Kb8f4M/l5z6uxpDp6qlCrIRzZnhYZpwv4r1elaJ2Id0=;
 b=bxZRCmDQan2xGXp3qqVXNGx862ETbFFt31nV6CLZpdPipaMEq/oLSslZtPA08TKTgM
 QQLXHg6zP65ezFnRj2snvB65jWMXnqQR0oxAxiZiJVr5ucUPgtCpVnA5B1U1ydXnNV4O
 aW6bYQFeLUMU6/nPEXiWn7k1KcvHW+CLGoXfBQ/RB4Rho/9oF1VvJoPL7XoEQumg+g1H
 X1k5ys3IoDR0ZxusVW9AVeheT6/Cb7mECpjzufoOQqIcOUqnr4CrKvC+xb3LYoHgSMcl
 Wz6oGBXdFkHgYShZC1cPEJYkl4+qK8Fwy/BAfMi9dQyj8mhyXrwMLTmlrRmpMlkAa9/E
 Ha4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Kb8f4M/l5z6uxpDp6qlCrIRzZnhYZpwv4r1elaJ2Id0=;
 b=FGhjDX70mnK/N6ItoRIXHQt4WmosDDZ3MlbnBcLs4FWdLe/BWC7L8fzx8YvaJm5PUw
 4Jpz2N+TtqLf+MfYOL7jtFozarAaG5QTRlGJ0KkNaOOTNkCn1N0eKJNjhRBkBB6v+Xkz
 M/mZSskwOUJ9YDywu3BknfihOWgBpvWGCOwGFL5HVpDXvDcU7fgcjWz+OLYA7y5Q2AiU
 TpFSOGBVtrXmgcoBybpP6Pi97ra5YTehcy7F3Y4FqU8+0QcKZ8oxETzMhzdRXY9Uzm7Y
 kE2oQDDSK7XHClYzos5ip8GKHcjItdjb8jTnE3/ZQ036HQNNjF64V23D3wc3oBxwqFlS
 BQaw==
X-Gm-Message-State: AOAM531spSVhQnJrwImWE93zp0we3AeT4SoyrvWkNqx5AqKwTZrEV6cH
 5WQVHWoL13SSCwW6BLW2rEjYdA==
X-Google-Smtp-Source: ABdhPJxKxShZt5CyviRanuZSq/psWkLAX+SqxyYKbLeRsW4giB0nlJOn6dDxwjLecNkjKg8yKQLqUg==
X-Received: by 2002:a05:6870:d78d:b0:d4:4b29:7ccc with SMTP id
 bd13-20020a056870d78d00b000d44b297cccmr2253927oab.69.1651757947172; 
 Thu, 05 May 2022 06:39:07 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 x6-20020a4a8d46000000b0035eb4e5a6c3sm774557ook.25.2022.05.05.06.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 May 2022 06:39:06 -0700 (PDT)
Date: Thu, 5 May 2022 14:38:39 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 10/12] iommu: Prepare IOMMU domain for IOPF
Message-ID: <YnPTXwjpHnnGp4j2@myrica>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-11-baolu.lu@linux.intel.com>
 <YnFydE8j8l7Q4m+b@myrica>
 <9144a782-04d2-a09d-4ac1-7133e5986619@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9144a782-04d2-a09d-4ac1-7133e5986619@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
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

Hi Baolu,

On Thu, May 05, 2022 at 04:31:38PM +0800, Baolu Lu wrote:
> On 2022/5/4 02:20, Jean-Philippe Brucker wrote:
> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index 7cae631c1baa..33449523afbe 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -3174,3 +3174,24 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
> > >   	iommu_group_put(group);
> > >   }
> > > +
> > > +struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
> > > +						    ioasid_t pasid)
> > > +{
> > > +	struct iommu_domain *domain;
> > > +	struct iommu_group *group;
> > > +
> > > +	if (!pasid_valid(pasid))
> > > +		return NULL;
> > > +
> > > +	group = iommu_group_get(dev);
> > > +	if (!group)
> > > +		return NULL;
> > > +
> > > +	mutex_lock(&group->mutex);
> > Unfortunately this still causes the deadlock when unbind() flushes the
> > IOPF queue while holding the group mutex.
> 
> Sorry, I didn't get your point here.
> 
> Do you mean unbind() could hold group mutex before calling this helper?
> The group mutex is only available in iommu.c. The unbind() has no means
> to hold this lock. Or, I missed anything?

I wasn't clear, it's iommu_detach_device_pasid() that holds the
group->mutex:

 iommu_sva_unbind_device()          |
  iommu_detach_device_pasid()       |
   mutex_lock(&group->mutex)        |
   domain->ops->detach_dev_pasid()  | iopf_handle_group()
    iopf_queue_flush_dev()          |  iommu_get_domain_for_dev_pasid()
     ... wait for IOPF work         |   mutex_lock(&group->mutex)
                                    |    ... deadlock

Thanks,
Jean

> 
> Best regards,
> baolu
> 
> > 
> > If we make this function private to IOPF, then we can get rid of this
> > mutex_lock(). It's OK because:
> > 
> > * xarray protects its internal state with RCU, so we can call
> >    xa_load() outside the lock.
> > 
> > * The domain obtained from xa_load is finalized. Its content is valid
> >    because xarray stores the domain using rcu_assign_pointer(), which has a
> >    release memory barrier, which pairs with data dependencies in IOPF
> >    (domain->sva_ioas etc).
> > 
> >    We'll need to be careful about this when allowing other users to install
> >    a fault handler. Should be fine as long as the handler and data are
> >    installed before the domain is added to pasid_array.
> > 
> > * We know the domain is valid the whole time IOPF is using it, because
> >    unbind() waits for pending faults.
> > 
> > We just need a comment explaining the last point, something like:
> > 
> >         /*
> > 	* Safe to fetch outside the group mutex because:
> >          * - xarray protects its internal state with RCU
> >          * - the domain obtained is either NULL or fully formed
> > 	* - the IOPF work is the only caller and is flushed before the
> > 	*   domain is freed.
> >          */
> > 
> > Thanks,
> > Jean
> > 
> > > +	domain = xa_load(&group->pasid_array, pasid);
> > > +	mutex_unlock(&group->mutex);
> > > +	iommu_group_put(group);
> > > +
> > > +	return domain;
> > > +}
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
