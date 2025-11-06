Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324512F7AAD;
	Thu,  6 Nov 2025 23:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762472952; cv=none; b=uNFAxlr+qTKAMiZ+6yKFs5IJh5Oc8Ee3EGWu0jPh1P86NWNt2MZjYTnwyr4PAeVnMpHYP3sQhJAX+0ilP3rbly8BbR2zuYtRLEfakdR7/yj2dUbKCT0IdwSLpUK11/NV5EdaDptWVHKLDjVkTVmvhhpoTJDpXL9wY3hJg2/7G5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762472952; c=relaxed/simple;
	bh=0+thG+wVCnGYmvgPihEgqva+HDz9VgPZqdcoz4oEsok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s9j2M+k/BicwiUot5EGFcge87NbeLmcx4JFBD/alHN280J3cd1tgfeR/5tlEz7BUdCmNAegPOnbMuvOIbaIjhfCpAVwxqui+wwK+HdSCaNWFFKMalB1WosubFIChWkury/OZP+EcpugynDevlt4UWZgYC6LrGk6hTyDlLbKhP4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VWfdeD6S; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VWfdeD6S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=P+fjfIGHIu+Ekfvl3GYJAAouYjpk5EMCOKL2TFY2cpg=; b=VWfdeD6SyUqBlG+HvOLbP9uPE2
	4szANMRomD0iuNjnyFkjIai9qRLeJlFwArvRpdxbLQGWckChb2Su1qrN3yOB4hMy0rKr+tgO6RurO
	NkjKcEhDoC4iiDBBLd6s5dYwKVtsN5kha0r98GXuv0AJLAlabYNe3H3PoXRSfbFZGI8Awy18bpKQ/
	33w1eCyeLLycaBGAvzoA81XW4s4wObMrnXaGIrPq8LqHzlwxdYjcgNYcJTqR364FslQmPXCuG3f45
	6BNMiIMuHiW+FM47SJBoC8m4ibeXng7OxloGoYB+aB7QJMqL3razc3UnWXLVZ0vwLndWx3M5KjpBi
	X7yEU2uw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vH9j3-0000000GPOO-0fkO;
	Thu, 06 Nov 2025 23:49:09 +0000
Message-ID: <e93153a1-4abf-46e3-a652-e95fe494b315@infradead.org>
Date: Thu, 6 Nov 2025 15:49:08 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Documentation: genpt: Don't use code block marker
 before iommu_amdv1.c include listing
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Samiullah Khawaja <skhawaja@google.com>,
 Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20251106073845.36445-1-bagasdotme@gmail.com>
 <20251106073845.36445-2-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251106073845.36445-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/5/25 11:38 PM, Bagas Sanjaya wrote:
> Stephen Rothwell reports htmldocs warning when merging iommu tree:
> 
> Documentation/driver-api/generic_pt.rst:32: WARNING: Literal block expected; none found. [docutils]
> 
> This is because of duplicate double colon code block markers: one after
> generic_pt/fmt/iommu_amdv1.c and the one in its preceding paragraph. The
> resulting htmldocs, however, only marks the include listing (after the
> former) up as it should be.
> 
> Drop the latter to fix the warning.
> 
> Fixes: ab0b572847ac ("genpt: Add Documentation/ files")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20251106143925.578e411b@canb.auug.org.au/
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/driver-api/generic_pt.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/generic_pt.rst b/Documentation/driver-api/generic_pt.rst
> index 210d1229aa1c1f..7a9ca9f2878d4f 100644
> --- a/Documentation/driver-api/generic_pt.rst
> +++ b/Documentation/driver-api/generic_pt.rst
> @@ -27,7 +27,7 @@ compiled into a per-format IOMMU operations kernel module.
>  For this to work the .c file for each compilation unit will include both the
>  format headers and the generic code for the implementation. For instance in an
>  implementation compilation unit the headers would normally be included as
> -follows::
> +follows:
>  
>  generic_pt/fmt/iommu_amdv1.c::
>  


Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
