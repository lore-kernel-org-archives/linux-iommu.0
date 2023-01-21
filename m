Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ACD7E
	for <iommu@lists.linux.dev>; Sat, 21 Jan 2023 00:09:06 +0000 (UTC)
Received: by mail-vs1-f42.google.com with SMTP id i188so7400093vsi.8
        for <iommu@lists.linux.dev>; Fri, 20 Jan 2023 16:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J7BKazUSzb1FuErPzK4kF9qsdvEIt5ZVPv77Xw43Sic=;
        b=Lv6dLxXyu3T7dCN1lyJJvzbBKoBwk6tonW4rIMmuQ/8rtpir0a1+37L2jxKr7FYxTa
         v68sRwqiyjkkOvpKog+fDlcUXr0+EmV+yaXzZ22AQfzjjc+NFALFIGsVUc5ldTKbS231
         2MixXyLizzVu9ZsHwJRSlGFkcNqmi/T1e2JND2RGE5gq8fkINzqGfjzqZW1EEdtnHYX4
         I0Fa6v8Y+/cjTwb/A9rqyGsvQWOrgoInqep5TrjRdDSHSdHGq/7DCa4CDhx3nekkrpQ6
         nuyMajBWPHebMNEqDV0eXaawKW19GCvmI+K5qO39wQWaWT6fjD6Nl3bpCuTIlEm537bV
         lfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7BKazUSzb1FuErPzK4kF9qsdvEIt5ZVPv77Xw43Sic=;
        b=HTf9LSWEXSG19/3yUBjHnGiHfIZpOzjkr565yiVCvPbsziEhUN/NLqi4XfDSVzoKuJ
         gNGmV62en3v8L3LmJ7lJXr1lsXtDhYISxq6iSP7jl9fbeC9duH5Kc2K1T+fRNqz8ELbM
         tEpMaY1pfk3Y+tX7OeOkh3zithdKgSRe8yBs67ciMjzy533ghxkO30B4eTNzeoafZSLl
         ixs4ubuJqTna2JpSfR8H8YWflbe8kNQDvXCe1phOPOotePkEYbL80FzQu2G1rGCiQ5nS
         Jx+C4nJ0hXwV0xICIje7Hf0eWNrEN2wNszBmAxGsPLieLljvG72+hokK+MDHXTVC2cJd
         L5lw==
X-Gm-Message-State: AFqh2kqy/R5CkbZ7o7oPzS3keL+v8NzL6BaS114DhwBPht0MUKK8/UaR
	b5dEQgea7TOuO5s8ZNlTYyoblw==
X-Google-Smtp-Source: AMrXdXsqYs732eIFEJxe8fLjdOnsesRBsekrMmjo9aqzufULnunaDZN6UZ5io5tMGIRNcMJjKzFT4w==
X-Received: by 2002:a67:ebd5:0:b0:3d0:fce9:d9c0 with SMTP id y21-20020a67ebd5000000b003d0fce9d9c0mr9632517vso.31.1674259745390;
        Fri, 20 Jan 2023 16:09:05 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-167-59-176.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.59.176])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a430c00b006ee949b8051sm26866756qko.51.2023.01.20.16.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 16:09:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pJ1RQ-00F5ku-7B;
	Fri, 20 Jan 2023 20:09:04 -0400
Date: Fri, 20 Jan 2023 20:09:04 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: "Kalra, Ashish" <ashish.kalra@amd.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	joro@8bytes.org, robin.murphy@arm.com, vasant.hegde@amd.com,
	jon.grimm@amd.com
Subject: Re: [PATCH 1/4] iommu/amd: Introduce Protection-domain flag VFIO
Message-ID: <Y8stIO6oAw8wEgEI@ziepe.ca>
References: <20230110143137.54517-2-suravee.suthikulpanit@amd.com>
 <Y8F53dzdebKLTlOy@ziepe.ca>
 <90762dee-1559-58ac-220d-a13635d5032e@amd.com>
 <Y8mBczFH/Hw6xot0@ziepe.ca>
 <c3fbec52-1281-eb1c-40f8-588438146c14@amd.com>
 <Y8q9ocj2IZB2r6Np@ziepe.ca>
 <1ba09b11-8a07-24dd-a99f-eeacb2f5c96c@amd.com>
 <Y8rUYTjVhksAu+i9@ziepe.ca>
 <da56ae0c-8f72-b39f-95b8-8870ec9fb336@amd.com>
 <1e1e98ea-5215-be21-b732-58c67e9c8fd6@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e1e98ea-5215-be21-b732-58c67e9c8fd6@amd.com>

On Fri, Jan 20, 2023 at 04:42:26PM -0600, Tom Lendacky wrote:
> On 1/20/23 13:55, Kalra, Ashish wrote:
> > On 1/20/2023 11:50 AM, Jason Gunthorpe wrote:
> > > On Fri, Jan 20, 2023 at 11:01:21AM -0600, Kalra, Ashish wrote:
> > > 
> > > > We basically get the RMP #PF from the IOMMU because there is a page size
> > > > mismatch between the RMP table and the IOMMU page table. The RMP table's
> > > > large page entry has been smashed to 4K PTEs to handle page
> > > > state change to
> > > > shared on 4K mappings, so this change has to be synced up with the IOMMU
> > > > page table, otherwise there is now a page size mismatch between RMP table
> > > > and IOMMU page table which causes the RMP #PF.
> > > 
> > > I understand that, you haven't answered my question:
> > > 
> > > Why is the IOMMU being programmed with pages it cannot access in the
> > > first place?
> > > 
> > 
> > I believe the IOMMU page tables are setup as part of device pass-through
> > to be able to do DMA to all of the guest memory, but i am not an IOMMU
> > expert, so i will let Suravee elaborate on this.
> 
> Right. And what I believe Jason is saying is, that for SNP, since we know we
> can only DMA into shared pages, there is no need to setup the initial IOMMU
> page tables for all of guest memory. Instead, wait and set up IOMMU mappings
> when we do a page state change to shared and remove any mappings when we do
> a page state change to private.

Correct.

I don't know the details of how the shared/private works on AMD, eg if
the hypervisor even knows of the private/shared transformation..

At the very worst I suppose if you just turn on the vIOMMU it should
just start working as the vIOMMU mode should make the paging
dynamic. eg virtio-iommu or something general might even do the job.

Pinning pages is expensive, breaks swap, defragmentation and wastes a
lot of iommu memory. Given that the bounce buffers really shouldn't be
reallocated constantly I'd expect vIOMMU to be performance OK.

This solves the page size mistmatch issue because the iommu never has
a PFN installed that would generate a RMP #PF. The iommu can continue
to use large page sizes whenever possible.

It seems to me the current approach of just stuffing all memory into
the iommu is a just a shortcut to get something working.

Otherwise, what I said before is still the case: only the VMM knows
what it is doing. It knows if it is using a model where it programs
private memory into the IOMMU so it knows if it should ask the kernel
to use a 4k iommu page size.

Trying to have the kernel guess what userspace is doing based on the
kvm is simply architecturally wrong.

Jason
