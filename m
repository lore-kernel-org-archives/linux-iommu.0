Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FA53FA5CB
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296586; cv=none; b=asG8V6DU4hGdYdW6luoYgKsnK6NSZK6ZYUW8sFOiTFbSMqwaCjfMwm6vR6RQZNl5+8G8sI3ELTGRSLVBE9qTqzmHZQLmvuEsNzmct9SNgA9JdIB0oocfn2eAre+L+ft6Ni44Vl3lNl0D65sqaKlbbRMrD8z+R6X9HhtnM5S0HTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296586; c=relaxed/simple;
	bh=J1ljfz5wmfgXIv5mNoi+wqRu95rQj2li3gvVLPDMlxU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tcVdh8HZLg4CzsgI4Su4AqoTDss0F0Q1N0zp7PiVzC9xp5UAtrS3RZ27zlwZ9vG8Jhmhpcum3YuLOHsy9bzBMT/lSJUMd7Rr/OynKTfC6/3nH3psPMaXZiB2q5VmDck22RPgvcK0yyEKHt8H3g9XbO0OUpuxrFutYyFP8VmRBso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DgRJ9Wik; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DgRJ9Wik"
Received: from localhost (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id C3DE920B7168;
	Wed, 20 May 2026 10:02:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C3DE920B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779296575;
	bh=wyxKqJ9lrHVBaSNRxDKJVeLCoMWf1vQqn1Ka3pv9pKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DgRJ9WikxSa5toLCAPdvFZAU/jKtPHqHlpL0JtE33P5gXoyEGhVTrApByUMomYM3e
	 HwhhvPDrL7rf0XHj+1uG/XuLfSFjJf0+svrGmOWZ4lZkPcPmBhKHVKxQ8SO1m7WDXu
	 3cNt4lVF/UX1WKdrxELZlBwWHUARvagHafqKMrak=
Date: Wed, 20 May 2026 10:02:59 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
 <smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
 <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
 <skhawaja@google.com>, <pasha.tatashin@soleen.com>, Will Deacon
 <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v5 5/9] iommufd: Add an ioctl to query PA from IOVA for
 noiommu mode
Message-ID: <20260520100259.00004262@linux.microsoft.com>
In-Reply-To: <a0e88436-3bcd-4808-8aa8-86b3ec0c197a@intel.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
	<20260511184116.3687392-6-jacob.pan@linux.microsoft.com>
	<a0e88436-3bcd-4808-8aa8-86b3ec0c197a@intel.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Yi,

On Wed, 20 May 2026 15:20:15 +0800
Yi Liu <yi.l.liu@intel.com> wrote:

> From: Yi Liu <yi.l.liu@intel.com>
> To: Jacob Pan <jacob.pan@linux.microsoft.com>,
> <linux-kernel@vger.kernel.org>,  "iommu@lists.linux.dev"
> <iommu@lists.linux.dev>, Jason Gunthorpe  <jgg@nvidia.com>, Alex
> Williamson <alex@shazbot.org>, Joerg Roedel  <joro@8bytes.org>,
> Mostafa Saleh <smostafa@google.com>, David Matlack
> <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin
> Chen  <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com> CC:
> Saurabh Sengar <ssengar@linux.microsoft.com>, <skhawaja@google.com>,
> <pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>, Baolu Lu
> <baolu.lu@linux.intel.com> Subject: Re: [PATCH v5 5/9] iommufd: Add
> an ioctl to query PA from IOVA for  noiommu mode Date: Wed, 20 May
> 2026 15:20:15 +0800 User-Agent: Mozilla Thunderbird
> 
> On 5/12/26 02:41, Jacob Pan wrote:
> > To support no-IOMMU mode where userspace drivers perform unsafe DMA
> > using physical addresses, introduce a new API to retrieve the
> > physical address of a user-allocated DMA buffer that has been
> > mapped to an IOVA via IOAS. The mapping is backed by SW-only I/O
> > page tables maintained by the generic IOMMUPT framework.
> > 
> > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>  
> 
> since this patch is under your ahtuorship, maybe Jason's s-o-b should
> be prefixed with a c-d-b tag.
Missed this before, yeah, will do
 Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
 Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
 Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
 Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>

