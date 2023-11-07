Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529532DF91
	for <iommu@lists.linux.dev>; Tue,  7 Nov 2023 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="S88vG29k"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-66d060aa2a4so38731686d6.2
        for <iommu@lists.linux.dev>; Tue, 07 Nov 2023 05:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699363293; x=1699968093; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g+ZGwdfOpQ5bFXzc3cVBNoStzv4X2p/HawoSIM5mxTM=;
        b=S88vG29kL+to1BqhnkMM3DMXjdU2ZAciT/LCSD0VLZDWEozq61ywbFCpyezODSU03m
         Kkk/vFC9s7jUR6pq1hPf3LAr2gglrdfXwlf0UBS16szLsb/kMNw6sAgVJBVF5FoCHK3c
         e4Dlxzc3xo4jhjmYz54ZmjwljWdxKAiXXmC2ELUDUAqQgoXViO9nvcbufiEa1s8bJLqk
         m3mBKedmSRvLy1gMbt4vjfTCa4Zi2qaf7MckIXGPr88zsDZSSbwX8rf0Xpd476RDgi0m
         2rN4QY/FCT8iWX5z1XJ2lvmMoPzWNwwS0QlHyjRUImXVKIZpt6rUkIuOxhPHXx5GMmJR
         ltZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699363293; x=1699968093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+ZGwdfOpQ5bFXzc3cVBNoStzv4X2p/HawoSIM5mxTM=;
        b=YdIxp69dpTnWKxmniPwyQe2qglkr5MRtO5xVlGoN+BU3hMP5d2T/wtArz5uXRDSO16
         Cf5YCfvMlYmlJN65iOn78eyen1ya9Er6KB90i1x7FF4YoxG1js/CuSakRV5aU9DzZzgD
         1UbwkS/12cl/+pIJFr7hLdwSYqAybHA5J1+m5/cO8suefvqPz4MeGtY3zjQUtDXwVJmH
         GlqWh6poEt1TPPEGPrLoN4O5LjQKtxQIWGBDgXQVr7vIwUdxOcJMuFIW845/i92JcRCq
         FOOYAKfZSSN71CIS4PjDiUZi6mQH2LZoRj7tIhkR6PVAhsyhSuPbRG7mMbIk/BElk91s
         HjQw==
X-Gm-Message-State: AOJu0YzPaF6DsKPX9uDibj9n3Juc4I4zSKO1Z3+tL4nvfDbh+8FiNAoh
	J6G1BoLC1a5d9W/5qSzDzThJgZC69vu7JpEZs3s=
X-Google-Smtp-Source: AGHT+IFFkdvAf2a8Vd+r4xjNAYj8HQoKjk18Wpov7uF1L3wuL5trrqNo2XVwjTLVqCVI0AIitvckpA==
X-Received: by 2002:a05:6214:1d0d:b0:671:cc80:c59d with SMTP id e13-20020a0562141d0d00b00671cc80c59dmr33933572qvd.0.1699363292942;
        Tue, 07 Nov 2023 05:21:32 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id mx1-20020a0562142e0100b0066d0ab215b5sm4380612qvb.13.2023.11.07.05.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 05:21:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r0M1L-001Vg5-Je;
	Tue, 07 Nov 2023 09:21:31 -0400
Date: Tue, 7 Nov 2023 09:21:31 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 06/13] iommu/amd: Introduce per-device domain ID to
 workaround potential TLB aliasing issue
Message-ID: <20231107132131.GX4634@ziepe.ca>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-7-vasant.hegde@amd.com>
 <20231105181604.GH4634@ziepe.ca>
 <a4855a3e-02f5-2ebe-f8c7-92137421418e@amd.com>
 <20231106133644.GJ4634@ziepe.ca>
 <2318eb1e-e62f-7e48-fa43-1d75331a75d9@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2318eb1e-e62f-7e48-fa43-1d75331a75d9@amd.com>

On Tue, Nov 07, 2023 at 11:00:18AM +0530, Vasant Hegde wrote:
> 
> 
> On 11/6/2023 7:06 PM, Jason Gunthorpe wrote:
> > On Mon, Nov 06, 2023 at 06:09:47PM +0530, Vasant Hegde wrote:
> > 
> >>> I think this driver really suffers from not having the right
> >>> data structures to handle everything cleanly.
> >>>
> >>> In smmuv3 I added a 'master_domain' structure that linked the PCI
> >>> device to the iommu_domain. ie when attach is done you'd create a new
> >>> master_domain that essentially stores the parameters required to do
> >>> invalidation.
> >>>
> >>> For what is going on here I would say to do that an then put the
> >>> "domain id" inside the "master_domain". Decide when the domain is
> >>> attached if the domain id should by taken from the iommu_domain
> >>> (device does not support PASID) or from the device (device does
> >>> support PASID)
> >>
> >> We still have single domain concept (at least until we introduce
> >> vIOMMU). All we are changing is how we allocate domain ID.
> >>
> >> Having another domain for each device just to keep invalidation info is
> >> complicates things. Also IMO its unnecessary.
> > 
> > It is not another domain, it is cleaning up the mess of keeping track
> > of what caches need to be invalidated for a single domain.
> > 
> > Today we have this:
> > 
> > struct protection_domain {
> > 	struct list_head dev_list; /* List of all devices in this domain */
> > 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
> > 
> > (and I'm sorry, but using a global array of iommus and this dev_iommu
> > thing is an insane design)
> 
> Devices behind different IOMMU can be attached to same domain (like VFIO case).
> We do need to track the IOMMUs and as part of invalidation we have a requirement
> to send `completion` command to each IOMMU. So this links domain to IOMMUs.

I understand how it works.

> Array is not a best thing here. I have it in my TODO list to change this to
> xarray or something. But that's after SVA series as we are already making too
> many changes to fundamental data structure in this series.

'unsigned dev_iommu' is the problem not the array.
 
> > Now this adds a new concept domain_id_is_per_dev(), and it still
> > doesn't support PASID properly!
> > 
> > Instead write it like this:
> > 
> > struct attachment {
> >     struct list_head attachments_item;
> >     struct amd_iommu *iommu;
> >     struct iommu_dev_data *device;
> >     ioasid_t pasid
> > }
> > 
> > struct protection_domain {
> >     struct list_head attachments;
> > 
> > 
> > Where every ops->attach_dev allocates a new struct attachment and
> > threads it on the liked list of the protection_domain.
> 
> 
> We support PASID only in V2 page table mode. V1 does not have PASID stuff. So we
> just have list of devices in the domain. Then each device has PASID table (that
> what this series does).

Doesn't matter, v1 uses the dev_iommu and the point is to consolidate
alll of this.

> Also as mentioned above we have the requirement of `completion wait` call for
> each IOMMU. Hence we track the IOMMU list. Having it per device like above
> increases completion wait calls which is not good. IMO above changes
> unnecessarily complicates stuff.

It is not per device, it is still done per-iommu. I wrote:

    list_for_each_iommu(elm, domain->attachments)
        build_cmd_v1_invalidation(&cmd, domain->cache_tag,  ...);
        iommu_queue_command(elm->iommu, &cmd);

Which is the same work as iterating over protection_domain->dev_iommu,
the iommus are extracted from the device list which is needed anyhow
for ATS, PASID, and V2. So just use it everywhere.

> > Then the invalidation logic become completely straightforward, no
> > confusing mess:
> > 
> > invalidate_iotlb_v1:
> >    list_for_each_iommu(elm, domain->attachments)
> >        build_cmd_v1_invalidation(&cmd, domain->cache_tag,  ...);
> >        iommu_queue_command(elm->iommu, &cmd);
> 
> Ours is domain based invalidation. So our flushing logic is

> 	Flush IOMMU TLB for each IOMMUs
> 	If device has ATS
> 		Flush device IOTLB
> 
> 	For each IOMMU (dev_iommu list)
> 		call completion wait

This is what I wrote.

> > invalidate_iotlb_v2:
> >    list_for_each_iommu(elm, domain->attachments)
> >        build_cmd_v2_invalidation(&cmd, device->gcr3_cache_tag, elm->pasid, ...);
> >        iommu_queue_command(elm->iommu, &cmd);
> 
> From driver point of view, fundamentally V2 invalidation is not too different as
> we have single invalidation command. All we need is few extra param to tell its
> guest page table invalidation with PASID.

From a SW perspective it is totally different because V1 invalidates a
single domain id per IOMMU and V2 invalidates a domain_id&PASID for
every device.

> > invalidate_ats:
> >    list_for_each(elm, domain->attachments)
> >        if (!elm->device->ats enabled)
> >              continue
> >        build_cmd_atc_invalidation(&cmd, elm->device, elm->pasid, ...);
> >        iommu_queue_command(elm->iommu, &cmd);
> 
> 
> Driver already does this.

The SVA series had code like this, I'm saying you need to generalize
it.

> > Where list_for_each_iommu de-duplicates the iommus from the sorted
> > list, Michael had a series that showed how to do this for SMMU.
> > 
> > Basically you precalculate exactly the invalidations required and
> > store it in a list associated with the domain. When it is time to do
> > an invalidation then you just walk the list and do exactly what it
> > says.
> 
> I think we have most things already in protection domain. Only extra check we
> have is checking `pdom->dev_iommu[i]` which will be fixed separately.

You have it but it is not structured in a logical way, that is why
this series has introduced nonsensical things like a PASID for a
domain, encoding the V1/v2 state ina PASID/etc, and then did a half
version of this list anyway to make SVA work.

Bring the list from the SVA series into this series, use it
consistently, remove the weird stuff and then it will make sense.

Do not have a list *and* a bunch of weird stuff, that is moving
further away from what it needs to look like..

Jason
