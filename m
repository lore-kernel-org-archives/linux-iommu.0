Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CCF1A71D
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ccX4iHHf"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-41feb963f60so9862921cf.1
        for <iommu@lists.linux.dev>; Mon, 06 Nov 2023 05:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699277806; x=1699882606; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KzUJinv9/fl8y3fgEplZsti39lStZsfyox5/IwZyEIY=;
        b=ccX4iHHfTC49lwuWkN4EY05dfHOXVjJEFJ7/fqlJ+5JkpCesiLrlKrZehOJWeI3JYi
         8lek4zaGe3UOtW7ow1z8DZIiYbccQayg0L5pYohk7Cgpq7lEPLeJpxqLIsWUNj+QJCby
         KyeP0JBL6Wz5EUXHh21/+vBYCTfnlCneQXODrRZfEmzJ8QsfmkirL953zdKiJTLyL2sf
         F+NVyu4pRkYUiDCBCEf4lLTw6SuX7j+oXOv9wyZFs19as2Mcohr3b8rnenYMjv7XEPlA
         rmtBGXRN73Il3kbI9q551mMqGKlSTrCbDAeN+uMcALP1SgTwcMBn0aWLj2bQ0WYMhq3K
         oluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699277806; x=1699882606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzUJinv9/fl8y3fgEplZsti39lStZsfyox5/IwZyEIY=;
        b=BVvJnmbYcV/kRtM3Pc3kB1Py3SD6d3KNQwgdXPuXMVXKYID0SCJ5VtMG+/j/huhWv1
         GYxmnMEVubYMhIxhKfbbxbzPHrzSMSaae9+xtMK5+49OM14+VAinef6NjSfh2thzmCQV
         OVQvQ8k27KRd75LMu/sHemc0RiD4wM+d+9X1EVs701p3X+zMkYfzeEGrtDN1oyPNKMwc
         bdxn712B8QiOPfvYbD0F4aCL/xo1BH4o+ClXOZ2Yzsmbj52K4IO+FbXaenIpvNGnaZZQ
         XI6u67xYCtAM0IyvsaYDWYLlY3mtr9oFGjLh0Df2LriPEp36mA6iwsGO2204uEqLqZgb
         60LA==
X-Gm-Message-State: AOJu0YzH5wMCo0eyXRSt78Pu4PExEY0a1+u/OjfBQUlua7ZPG7Av0S2q
	OKw3JNkqp8jJnsl13i+rN/BFkg==
X-Google-Smtp-Source: AGHT+IFzWkJz1CN7NQ17qgi+fv8XazK6oicoJyg6agqPXJvqxhXjM2ehmg3z58sCCv+xaKC1UDIDlw==
X-Received: by 2002:a05:622a:1b8e:b0:418:1235:5c84 with SMTP id bp14-20020a05622a1b8e00b0041812355c84mr12938875qtb.10.1699277805891;
        Mon, 06 Nov 2023 05:36:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id b8-20020a05622a020800b00419c39dd28fsm3373867qtx.20.2023.11.06.05.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 05:36:45 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qzzmW-001Me4-Qa;
	Mon, 06 Nov 2023 09:36:44 -0400
Date: Mon, 6 Nov 2023 09:36:44 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 06/13] iommu/amd: Introduce per-device domain ID to
 workaround potential TLB aliasing issue
Message-ID: <20231106133644.GJ4634@ziepe.ca>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-7-vasant.hegde@amd.com>
 <20231105181604.GH4634@ziepe.ca>
 <a4855a3e-02f5-2ebe-f8c7-92137421418e@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4855a3e-02f5-2ebe-f8c7-92137421418e@amd.com>

On Mon, Nov 06, 2023 at 06:09:47PM +0530, Vasant Hegde wrote:

> > I think this driver really suffers from not having the right
> > data structures to handle everything cleanly.
> > 
> > In smmuv3 I added a 'master_domain' structure that linked the PCI
> > device to the iommu_domain. ie when attach is done you'd create a new
> > master_domain that essentially stores the parameters required to do
> > invalidation.
> > 
> > For what is going on here I would say to do that an then put the
> > "domain id" inside the "master_domain". Decide when the domain is
> > attached if the domain id should by taken from the iommu_domain
> > (device does not support PASID) or from the device (device does
> > support PASID)
> 
> We still have single domain concept (at least until we introduce
> vIOMMU). All we are changing is how we allocate domain ID.
>
> Having another domain for each device just to keep invalidation info is
> complicates things. Also IMO its unnecessary.

It is not another domain, it is cleaning up the mess of keeping track
of what caches need to be invalidated for a single domain.

Today we have this:

struct protection_domain {
	struct list_head dev_list; /* List of all devices in this domain */
	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */

(and I'm sorry, but using a global array of iommus and this dev_iommu
thing is an insane design)

Now this adds a new concept domain_id_is_per_dev(), and it still
doesn't support PASID properly!

Instead write it like this:

struct attachment {
    struct list_head attachments_item;
    struct amd_iommu *iommu;
    struct iommu_dev_data *device;
    ioasid_t pasid
}

struct protection_domain {
    struct list_head attachments;


Where every ops->attach_dev allocates a new struct attachment and
threads it on the liked list of the protection_domain.

Then the invalidation logic become completely straightforward, no
confusing mess:

invalidate_iotlb_v1:
   list_for_each_iommu(elm, domain->attachments)
       build_cmd_v1_invalidation(&cmd, domain->cache_tag,  ...);
       iommu_queue_command(elm->iommu, &cmd);

invalidate_iotlb_v2:
   list_for_each_iommu(elm, domain->attachments)
       build_cmd_v2_invalidation(&cmd, device->gcr3_cache_tag, elm->pasid, ...);
       iommu_queue_command(elm->iommu, &cmd);

invalidate_ats:
   list_for_each(elm, domain->attachments)
       if (!elm->device->ats enabled)
             continue
       build_cmd_atc_invalidation(&cmd, elm->device, elm->pasid, ...);
       iommu_queue_command(elm->iommu, &cmd);

Where list_for_each_iommu de-duplicates the iommus from the sorted
list, Michael had a series that showed how to do this for SMMU.

Basically you precalculate exactly the invalidations required and
store it in a list associated with the domain. When it is time to do
an invalidation then you just walk the list and do exactly what it
says.

Jason
