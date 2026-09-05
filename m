Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C102931E5;
	Sat,  5 Sep 2026 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788629580; cv=none; b=ovmBPzVEfKVskPjDTPNufnccxpFWfzQDoKZ/49Y32OUd9d+AvTqDifQJJzW/lE/gsa0/rHro1E5MSXxaIo253z5E+MtbFIYOl2jPLC+X/fJ0gLAzHtOC3bl3xYDK4CVvfciA7hgM7oQ2hG9p0k+gfaqhZlqeiAWRqRnxPZ4/hvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788629580; c=relaxed/simple;
	bh=WXbyMZAeqYHFgA4M9IxoL47KthIk3hfgkeKKXtG/t/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHIN//dXt3Xpf4Npi9Wd8ncSqwrT08SHc28JbgwtodUh7yUafliOtqVuEHF/iDeNT1T1ChYQLSKA273iHcnzhVDnfNo91LJG8pdOh+PKvnMRV0US513V7PN4V4rokwYQ/C9Ufgw41xryQ3S4M4oOVImjuPjLnKu8+Z+8c9wt3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cL/ujbaS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cL/ujbaS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=PRfVu4sMKH+cr89JDLKLumPkAYqH/s+Zv/lNneBM+qY=; b=cL/ujbaSxaiLvU8zwCMMwZQ/Tr
	LhuJ8r9I1YpND2S6iotXVikiuFZ0Epo317YQpXvICExA8gEMlwm3mjMG2SfUYyieH4NfbT2IXJzan
	7c4LzHlNRMom7hkIGRKgfwRskOLgJs88eo1rSZIR8y3oO69uokTADk6IwXKG0x/9QDm8CL/7YhC5z
	UF3HVFYwbR0Zj7hl5O5ThsjaA8naYl8EqA7CYk9g8AaMlfzc8puK7puaONlD8zj+6lb4Whp5BGMIB
	MHB0BXplY4z/v7xcv5RVzk/woha0utB9wCs/ZZtRKBS2MHZWPImhwc23/dogFtVgmPOv1o25Jfzfy
	H9pn7WKw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2uG9-00000004I7q-3dLY;
	Sat, 05 Sep 2026 17:32:58 +0000
Message-ID: <29bec214-e991-4f22-8e72-48d30c08bf9f@infradead.org>
Date: Sat, 5 Sep 2026 10:32:57 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: userspace-api: iommufd: Fix the struct
 iommu_hwpt_alloc name
To: Karl Mehltretter <kmehltretter@gmail.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
 linux-doc@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260905103819.43424-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260905103819.43424-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/5/26 3:38 AM, Karl Mehltretter wrote:
> struct iommufd_hwpt_alloc does not exist; the name is struct
> iommu_hwpt_alloc.
> 
> Use struct iommu_hwpt_alloc.
> 
> Fixes: e2d8fe9148b7 ("Documentation: userspace-api: iommufd: Update HWPT_PAGING and HWPT_NESTED")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
thanks.

> ---
>  Documentation/userspace-api/iommufd.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
> index f1c4d21e5c5e..763b23339480 100644
> --- a/Documentation/userspace-api/iommufd.rst
> +++ b/Documentation/userspace-api/iommufd.rst
> @@ -242,7 +242,7 @@ creating the objects and links::
>  
>        Either a manual IOMMUFD_OBJ_HWPT_PAGING or an IOMMUFD_OBJ_HWPT_NESTED is
>        created via the same IOMMU_HWPT_ALLOC uAPI. The difference is at the type
> -      of the object passed in via the @pt_id field of struct iommufd_hwpt_alloc.
> +      of the object passed in via the @pt_id field of struct iommu_hwpt_alloc.
>  
>  5. IOMMUFD_OBJ_VIOMMU can be only manually created via the IOMMU_VIOMMU_ALLOC
>     uAPI, provided a dev_id (for the device's physical IOMMU to back the vIOMMU)

-- 
~Randy
