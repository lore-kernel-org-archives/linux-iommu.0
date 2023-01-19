Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C4EA950
	for <iommu@lists.linux.dev>; Thu, 19 Jan 2023 17:44:21 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id h21so2111949qta.12
        for <iommu@lists.linux.dev>; Thu, 19 Jan 2023 09:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uagwk8oR7LPWqlzC3PvjsT4JfUYRAFGo9v4XuZ07zBk=;
        b=nP6xVbCjpeodz/mRIOjm6xSBUhqllO6OARfOl2D2EQlboN3z2B5vLRQsNU3WO5+KRs
         tLJaNLsd/zYPkP4RFkyzHni8pKIjEC9USvFJhlO9bycPtZx1ZpnWwqHbJNx6uX5Mo0s0
         1+0fFmPjbbLzz3jadhXmiXTRy3NH/fmeHezoHyd3hx3XEW0/Xs7teWpqz+NAsk2lxE6t
         fexg9FvsRCQPaKxl/uzl0FxeLIJGYIfb+NZM7eEA9QzVo+P+zZNTy1wtuAAIP216Dd9D
         kIAtttuRV6EBEAict3s0OVFwJSxkzQGLZ7+Ubf/NS5R3xrtdp12BB0ROU7vKBAkHFlJW
         LL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uagwk8oR7LPWqlzC3PvjsT4JfUYRAFGo9v4XuZ07zBk=;
        b=1NF3+QeVHPIluf8EfRzIG73l+NmxjeXUqEmYHkzm5k1nDpi+7mWaz1Zig3UREz3vDI
         EXEMAYUHgQ3HdIJ0TJInuvTVWChv+OBcZ7ikWxtqUNTMg7XF0MW8lrQQVjV+RXl4NNRo
         eAjC6CmmzkRYVOM6Q1R0y1OJHC/bfF8TO+Td9phXvi/2U5ScUj9jsefZ+v39gR3Nm2Tq
         TPJVjaqeJ1EyzjBOm4SpI7F8Soa2d9PUqIk/l1rR3HuB5TGWMkBCCBzzhyVEsxIDU7S0
         MqXj7zVxXGh4/NjyvIJNa3Qg72mEWieHBYLyRxoNOtjhvyBap3+DgMwPVLrjL52sseaH
         t4kA==
X-Gm-Message-State: AFqh2kqlxb/RlJtSKkwcHmGi0caykQm9XOq5IUi/hNEUYqc2++93N/Xy
	St8CfCo8I2NjX4d6G7JxJVcMJA==
X-Google-Smtp-Source: AMrXdXtdkw6bZG4rXeIxw0GPjaolavd09O8lSwYuZEkyHv6r9utsdO+I6RRn0E5l0+m/NuY/CoaIjQ==
X-Received: by 2002:ac8:65cb:0:b0:3b6:2e8b:3363 with SMTP id t11-20020ac865cb000000b003b62e8b3363mr15120364qto.52.1674150260824;
        Thu, 19 Jan 2023 09:44:20 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-167-59-176.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.59.176])
        by smtp.gmail.com with ESMTPSA id g27-20020ac8775b000000b003ab1ee36ee7sm5325828qtu.51.2023.01.19.09.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:44:19 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pIYxX-00EGs1-95;
	Thu, 19 Jan 2023 13:44:19 -0400
Date: Thu, 19 Jan 2023 13:44:19 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	joro@8bytes.org, robin.murphy@arm.com, thomas.lendacky@amd.com,
	vasant.hegde@amd.com, jon.grimm@amd.com
Subject: Re: [PATCH 1/4] iommu/amd: Introduce Protection-domain flag VFIO
Message-ID: <Y8mBczFH/Hw6xot0@ziepe.ca>
References: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
 <20230110143137.54517-2-suravee.suthikulpanit@amd.com>
 <Y8F53dzdebKLTlOy@ziepe.ca>
 <90762dee-1559-58ac-220d-a13635d5032e@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90762dee-1559-58ac-220d-a13635d5032e@amd.com>

On Thu, Jan 19, 2023 at 02:54:43AM -0600, Kalra, Ashish wrote:
> Hello Jason,
> 
> On 1/13/2023 9:33 AM, Jason Gunthorpe wrote:
> > On Tue, Jan 10, 2023 at 08:31:34AM -0600, Suravee Suthikulpanit wrote:
> > > Currently, to detect if a domain is enabled with VFIO support, the driver
> > > checks if the domain has devices attached and check if the domain type is
> > > IOMMU_DOMAIN_UNMANAGED.
> > 
> > NAK
> > 
> > If you need weird HW specific stuff like this then please implement it
> > properly in iommufd, not try and randomly guess what things need from
> > the domain type.
> > 
> > All this confidential computing stuff needs a comprehensive solution,
> > not some piecemeal mess. How can you even use a CC guest with VFIO in
> > the upstream kernel? Hmm?
> > 
> 
> Currently all guest devices are untrusted - whether they are emulated,
> virtio or passthrough. In the current use case of VFIO device-passthrough to
> an SNP guest, the pass-through device will perform DMA to un-encrypted or
> shared guest memory, in the same way as virtio or emulated devices.
> 
> This fix is prompted by an issue reported by Nvidia, they are trying to do
> PCIe device passthrough to SNP guest. The memory allocated for DMA is
> through dma_alloc_coherent() in the SNP guest and during DMA I/O an
> RMP_PAGE_FAULT is observed on the host.
> 
> These dma_alloc_coherent() calls map into page state change hypercalls into
> the host to change guest page state from encrypted to shared in the RMP
> table.
> 
> Following is a link to issue discussed above:
> https://github.com/AMDESE/AMDSEV/issues/109

Wow you should really write all of this in the commmit message

> Now, to set individual 4K entries to different shared/private
> mappings in NPT or host page tables for large page entries, the RMP
> and NPT/host page table large page entries are split to 4K pte’s.

Why are mappings to private pages even in the iommu in the first
place - and how did they even get there?

I thought the design for the private memory was walling it off in a
memfd and making it un-gup'able?

This seems to be your actual problem, somehow the iommu is being
loaded with private memory PFNs instead of only being loaded with
shared PFNs when shared mappings are created?

If the IOMMU mappings actually only extend to the legitimate shared
pages then you don't have a problem with large IOPTEs spanning a
mixture of page types.

> The fix is to force 4K page size for IOMMU page tables for SNP guests.

But even if you want to persue this as the fix, it should not be done
in this way.

> This patch-set adds support to detect if a domain belongs to an SNP-enabled
> guest. This way it can set default page size of a domain to 4K only for
> SNP-enabled guest and allow non-SNP guest to use larger page size.

As I said, the KVM has nothing to do with the iommu and I want to
laregly keep it that way.

If the VMM needs to request a 4k page size only iommu_domain because
it is somehow mapping mixtures of private and public pages, then the
VMM knows it is doing this crazy thing and it needs to ask iommufd
directly for customized iommu_domain from the driver.

No KVM interconnection.

In fact, we already have a way to do this in iommufd generically, have
the VMM set IOMMU_OPTION_HUGE_PAGES = 0.

Jason
