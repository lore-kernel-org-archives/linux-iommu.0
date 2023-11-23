Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D09835EE8
	for <iommu@lists.linux.dev>; Thu, 23 Nov 2023 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WJ+ze4VU"
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 5CBD966073C8;
	Thu, 23 Nov 2023 15:48:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1700754528;
	bh=HtHhhwKzqiAmW0q6ZmXEw8LmlFeUglATrn7z4cKTM9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WJ+ze4VUzHRjNkBmb6lHmuf+Ebafd6xx5KUHZAu3ciKi8Z9HslrU7lKnm3FrQEMEJ
	 fyrMpd2ysP8Smsy4P1xV+3HPvZNL0jnu3AG5vDnK7srtUsDj9JpEI/Ff+A76wKrReN
	 FxOdklU12dId4ezpOa6L9wswuq/9XddLllvpFDET6066MKt5aA3UNZ+FXMuSlTleVU
	 oYxVqNxTznf15TalnGYoESVFvVnaB5NPPDNaTjceLbQXy4ZLr7+QFpJUozDNPRr+Ar
	 3gIqMZTTwX0T4s63bOGd4qxMS4vBsscDDjlzhFen/tat7oN+lntrgfbHCX88V7FKk2
	 Q9nIo+TiEMpCw==
Date: Thu, 23 Nov 2023 16:48:43 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Rob Clark <robdclark@gmail.com>,
 Gaurav Kohli <quic_gkohli@quicinc.com>, Steven Price
 <steven.price@arm.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Sean
 Christopherson <seanjc@google.com>, Alex Williamson
 <alex.williamson@redhat.com>, Joao Martins <joao.m.martins@oracle.com>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>
Subject: Re: Light summary of LPC discussions on io page table
Message-ID: <20231123164843.040a2c67@collabora.com>
In-Reply-To: <20231123151118.GA436110@nvidia.com>
References: <20231123151118.GA436110@nvidia.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jason,

On Thu, 23 Nov 2023 11:11:18 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Nov 23, 2023 at 09:51:41AM +0100, Boris Brezillon wrote:
> 
> > Can these people please raise their voice here? Or maybe LPC's IOMMU
> > discussions were summarized somewhere in an email sent to the IOMMU ML,
> > where we could discuss that, instead of this thread.  
> 
> I think we are using session recordings mostly these days? I have a
> bunch of people interested - I'm going to work to launch another group
> project to tackle this. Maybe in Jan.
> 
> The recordings are not broken up yet, but here is the master:
> 
> https://www.youtube.com/live/vO2mAM8wOvU
> 
> Pasha's talk is first at 2:21, and there was some discussion in the
> room that may be hard to hear including the use of RCU and the
> refcount. Pasha is interested in solving the memory waste his VFIO
> application causes which is basically an algorithmic problem inside
> the io page table.  There was also some side discussion about
> optimizations. mm implements a batch free technique that could apply
> here too, and a batch alloc is also potentially interesting.
> 
> My talk starts at 3:11 and we have another discussion later around
> this issue in the context of dirty tracking optimization. Joao has
> written and shared some code for what is concerning there in an
> earlier email Sean C is the voice at the back sharing the KVM
> learnings that getting to a common implementation is highly
> recommended
> 
> I had an interesting hallway discussion about a use case for bringing
> back the old VFIO type 1.0 huge page split behavior and implementing
> it in every enterprise iommu.
> 
> Then we have this DRM need, which I've come to think of as a
> guarenteed map without a table level allocate.
> 
> These need touching all the "enterprise" focused page table
> formats. There are so many now, doing the algorithm work 5-7 times is
> not reasonable. A common radix algorithm and a more complex shared
> implementation relying on RCU is the direction I want to head in. mm
> shows a template how to achieve this, and I have some rough ideas to
> explore.

Thanks for pulling this together. I'll try to watch the video and make
sense of what's explained there. I'll get back to you if I have
questions.

Regards,

Boris
