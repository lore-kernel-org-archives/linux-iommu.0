Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E3A2F2E
	for <iommu@lists.linux.dev>; Fri, 20 Jan 2023 16:13:23 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-4d19b2686a9so79027647b3.6
        for <iommu@lists.linux.dev>; Fri, 20 Jan 2023 08:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nnnpJIhnP1vcwuZ//nrLjSWu+mlpW1enDoAjtwMXXkM=;
        b=bhjy5dTOt4C/rd0+3QQWLfABXZ2eXLaWn6kttxKeh75wLZ57MFpOuV3EmJu7iU56SP
         xUKkuSGX4UlYLQamywu3ZeJr6J9EvsjdyeCuKgVZmdd+GBdoCjxRrKzBvg4hLT8foI++
         mbtty6VfynHJLBdlCGxfxSY4XI67LaKKM2ne5RONPozt2tVaBMJ8enYexgyyBzxfXRRE
         ksKgEICAhmEJUUqVCa7hief3ggo43Qmos1yaLfmQH3GaN4FEHW/l5jnlvRy8Oe8E56d+
         c4++0PuDPyVeSb6ChkTgLYuHlj2WQrEtzjKVYmEIhxQFZSuD5VQ8KchdWySWZNwpLRdU
         e3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nnnpJIhnP1vcwuZ//nrLjSWu+mlpW1enDoAjtwMXXkM=;
        b=4oBfjf5/YClpLNjhAqTUW0GIrn3PHs2yO2M63M8lZd+rLyeIPDLOO8wUjfPoa7hunh
         E/gq6RtMJ0+TbCg3Jwor6b0eY1I8J858VW00IctXhla9g5L/pSJV/D61M6AjAXPhu6ay
         QoIAxsiQPZt5vWq7pG6hLUWeqQ9keMvY1958JLT84oYA9IL5tXvRKNvY6mBc4x2c7Jn1
         8s206mkHqzA3UtbzYX+E9pU3FIb9i6IQLkzQkReLcsDDOBjsiJtyZHbpwt35ted2GMJB
         pi4q9wn2eCoELYbE4Lsl5m2phbNcyKwZO1qkSF4Ohys/FH7VPfGPjY2mYmJPgCXvSvXI
         zvoA==
X-Gm-Message-State: AFqh2krImOohvUVFS/644Tz0jseXkfVEGzNUtIpf+24o+0zKh8/52Qrd
	+EEF8yeDwqaNiuWwEeOlrqKV1g==
X-Google-Smtp-Source: AMrXdXu3qNDfo/JXyOvXUEFjmc1wICh9iBLoxaXI+U2LkbMjwodGbSt4PH+0gVd84Q0abmHaq7dIOg==
X-Received: by 2002:a0d:c182:0:b0:4c5:8b45:884e with SMTP id c124-20020a0dc182000000b004c58b45884emr10281370ywd.16.1674231202560;
        Fri, 20 Jan 2023 08:13:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-167-59-176.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.59.176])
        by smtp.gmail.com with ESMTPSA id m8-20020a05620a290800b006fb8239db65sm26737463qkp.43.2023.01.20.08.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 08:13:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pIu13-00EjaF-9S;
	Fri, 20 Jan 2023 12:13:21 -0400
Date: Fri, 20 Jan 2023 12:13:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	joro@8bytes.org, robin.murphy@arm.com, thomas.lendacky@amd.com,
	vasant.hegde@amd.com, jon.grimm@amd.com
Subject: Re: [PATCH 1/4] iommu/amd: Introduce Protection-domain flag VFIO
Message-ID: <Y8q9ocj2IZB2r6Np@ziepe.ca>
References: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
 <20230110143137.54517-2-suravee.suthikulpanit@amd.com>
 <Y8F53dzdebKLTlOy@ziepe.ca>
 <90762dee-1559-58ac-220d-a13635d5032e@amd.com>
 <Y8mBczFH/Hw6xot0@ziepe.ca>
 <c3fbec52-1281-eb1c-40f8-588438146c14@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3fbec52-1281-eb1c-40f8-588438146c14@amd.com>

On Fri, Jan 20, 2023 at 09:12:26AM -0600, Kalra, Ashish wrote:
> On 1/19/2023 11:44 AM, Jason Gunthorpe wrote:
> > On Thu, Jan 19, 2023 at 02:54:43AM -0600, Kalra, Ashish wrote:
> > > Hello Jason,
> > > 
> > > On 1/13/2023 9:33 AM, Jason Gunthorpe wrote:
> > > > On Tue, Jan 10, 2023 at 08:31:34AM -0600, Suravee Suthikulpanit wrote:
> > > > > Currently, to detect if a domain is enabled with VFIO support, the driver
> > > > > checks if the domain has devices attached and check if the domain type is
> > > > > IOMMU_DOMAIN_UNMANAGED.
> > > > 
> > > > NAK
> > > > 
> > > > If you need weird HW specific stuff like this then please implement it
> > > > properly in iommufd, not try and randomly guess what things need from
> > > > the domain type.
> > > > 
> > > > All this confidential computing stuff needs a comprehensive solution,
> > > > not some piecemeal mess. How can you even use a CC guest with VFIO in
> > > > the upstream kernel? Hmm?
> > > > 
> > > 
> > > Currently all guest devices are untrusted - whether they are emulated,
> > > virtio or passthrough. In the current use case of VFIO device-passthrough to
> > > an SNP guest, the pass-through device will perform DMA to un-encrypted or
> > > shared guest memory, in the same way as virtio or emulated devices.
> > > 
> > > This fix is prompted by an issue reported by Nvidia, they are trying to do
> > > PCIe device passthrough to SNP guest. The memory allocated for DMA is
> > > through dma_alloc_coherent() in the SNP guest and during DMA I/O an
> > > RMP_PAGE_FAULT is observed on the host.
> > > 
> > > These dma_alloc_coherent() calls map into page state change hypercalls into
> > > the host to change guest page state from encrypted to shared in the RMP
> > > table.
> > > 
> > > Following is a link to issue discussed above:
> > > https://github.com/AMDESE/AMDSEV/issues/109
> > 
> > Wow you should really write all of this in the commmit message
> > 
> > > Now, to set individual 4K entries to different shared/private
> > > mappings in NPT or host page tables for large page entries, the RMP
> > > and NPT/host page table large page entries are split to 4K pte’s.
> > 
> > Why are mappings to private pages even in the iommu in the first
> > place - and how did they even get there?
> > 
> 
> You seem to be confusing between host/NPT page tables and IOMMU page tables.

No, I haven't. I'm repeating what was said:

 during DMA I/O an RMP_PAGE_FAULT is observed on the host.

So, I'm interested to hear how you can get a RMP_PAGE_FAULT from the
IOMMU if the IOMMU is only programmed with shared pages that, by (my)
definition, are accessible to the CPU and should not generate a
RMP_PAGE_FAULT?

I think you are confusing my use of the word private with some AMD
architecture deatils. When I say private I mean that the host CPU will
generate a violation if it tries to access the memory.

I think the conclusion is logical - if the IOMMU is experiencing a
protection violation it is because the IOMMU was programed with PFNs
it is not allowed to access - and so why was that even done in the
first place?

I suppose what is going on is you program the IOPTEs with PFNs of
unknown state and when the PFN changes access protections the IOMMU
can simply use it without needing to synchronize with the access
protection change. And your problem is that the granularity of access
protection change does not match the IOPTE granularity in the IOMMU.

But this seems very wasteful as the IOMMU will be using IOPTEs and
also will pin the memory when the systems *knows* this memory cannot
be accessed through the IOMMU. It seems much better to dynamically
establish IOMMU mappings only when you learn that the memory is
actually accesisble to the IOMMU.

Also, I thought the leading plan for CC was to use the memfd approach here:

https://lore.kernel.org/kvm/20220915142913.2213336-1-chao.p.peng@linux.intel.com/

Which prevents mmaping the memory to userspace - so how did it get
into the IOMMU in the first place?

Jason
