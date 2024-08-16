Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E125013B293;
	Fri, 16 Aug 2024 21:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723842490; cv=none; b=Ayd7lCds+WWZS/S8yral4yCQGUlJZo5NdYILIz+L6g9qIG0w27eeLHCo8LZh9lKrv7k+jggLfO+4tTKGtvmWps0WuUKBEX7Ia/8J1OuRubP0twFevAJb/twCXGiXgv8cr89TIB2/ZrPp8RZPskXjUiSs9GY4dxrTVRd4bEXXfwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723842490; c=relaxed/simple;
	bh=mu9+7H+Dkgd9XFJ1RYjkPeJ1/+nmxz/+g/WwCW1an3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFOM1hDNH6URASB5Y6GOEFAmhSpXjnPwsE887M541U3DQ8KNmWCxqOwz9ckUohtHEp8+GA4a6n2lnCPGZ0bUBl3l1gi4YdR64J11x8+gUef4O+sfrZ1/mbqwKPCxZdpgeNEr13N/0nNn68eqoqp6wfhmAtUy99rwsg7I/wmxCio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abYeuapB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abYeuapB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504A6C32782;
	Fri, 16 Aug 2024 21:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723842489;
	bh=mu9+7H+Dkgd9XFJ1RYjkPeJ1/+nmxz/+g/WwCW1an3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=abYeuapBtYh8pZ+a3tNJH0JOmDBeXqsM5vmKeaALXT0MwHcmhyXTfUcVhhvTKE4IF
	 a6FNdSq+KF6uf9i9mfwSwEIMrKRgDNnzl5HKY6ka04k7YyD3bbZI0pHWAoEBOkA7DX
	 Z3NAHFBnDydmMHziTkFH1u1z65OLYQKDUjdcDqO0HU6Y64ZvCXtr0QZ4AbxnRF6Jn0
	 +VkAH4OifgCvL/Fkxs+Upt0da79QHkGeJdm0oA2KKFcaeiSPnWBEur353hAc7IEdoq
	 /n7KVmwSJRlWdp0KktHaBy8pZFjgzzRFMs48tFKZCokKIHlGBacIbPeWuidaSSULMY
	 +/Vvo7ylVsEfA==
Date: Fri, 16 Aug 2024 15:08:08 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: kernel@quicinc.com, klarasmodin@gmail.com, saravanak@google.com,
	robin.murphy@arm.com, m.szyprowski@samsung.com,
	aisheng.dong@nxp.com, hch@lst.de, devicetree@vger.kernel.org,
	will@kernel.org, iommu@lists.linux.dev, catalin.marinas@arm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] of: reserved_mem: Add code to dynamically
 allocate reserved_mem array
Message-ID: <172384248618.2197825.13104717668175387439.robh@kernel.org>
References: <20240809184814.2703050-1-quic_obabatun@quicinc.com>
 <20240809184814.2703050-3-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809184814.2703050-3-quic_obabatun@quicinc.com>


On Fri, 09 Aug 2024 11:48:14 -0700, Oreoluwa Babatunde wrote:
> The reserved_mem array is statically allocated with a size of
> MAX_RESERVED_REGIONS(64). Therefore, if the number of reserved_mem
> regions exceeds this size, there will not be enough space to store
> all the data.
> 
> Hence, extend the use of the static array by introducing a
> dynamically allocated array based on the number of reserved memory
> regions specified in the DT.
> 
> On architectures such as arm64, memblock allocated memory is not
> writable until after the page tables have been setup. Hence, the
> dynamic allocation of the reserved_mem array will need to be done only
> after the page tables have been setup.
> 
> As a result, a temporary static array is still needed in the initial
> stages to store the information of the dynamically-placed reserved
> memory regions because the start address is selected only at run-time
> and is not stored anywhere else.
> It is not possible to wait until the reserved_mem array is allocated
> because this is done after the page tables are setup and the reserved
> memory regions need to be initialized before then.
> 
> After the reserved_mem array is allocated, all entries from the static
> array is copied over to the new array, and the rest of the information
> for the statically-placed reserved memory regions are read in from the
> DT and stored in the new array as well.
> 
> Once the init process is completed, the temporary static array is
> released back to the system because it is no longer needed. This is
> achieved by marking it as __initdata.
> 
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> ---
>  drivers/of/of_reserved_mem.c | 68 +++++++++++++++++++++++++++++++++---
>  1 file changed, 64 insertions(+), 4 deletions(-)
> 

Applied, thanks!

