Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59DB2F363C;
	Mon, 24 Nov 2025 23:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764026008; cv=none; b=O4p5cvenNS+yAE1PpvNwAecz36zQPiTBKq1Z1FUyqLlr1nuB65HgbgZ6PNKT5gsTWBuMcORM50MysAbCqxTZJMmDJuGLhge6Kok1uac6w4rQzXZrRvMpKLw8EOoVKE7ezN2Nkd3nWNzQXoKPOjqMk+R9+2dhPwNz/udeDXmNyRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764026008; c=relaxed/simple;
	bh=b+z7hG6yhVVTznsGD9qWMOyyNSsyG5YqfkEL8dBN8wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KR98Wp+0wQ+nppNZ+3v4wmHzfK5tDyN8bXQ0qMGknzWWzaC+9+qcfQpI5ckuFZgonzgOtUeJ8fXEGYTcLqs+d4L2Y5fVI1Z+uidWrrxxH1pnEyDh0P9r8h2kWwEPQXxFYD/Hnsx2ETYe3MJgN0iyEgaP07kaVe9pfgvBsGbz3tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2TK/ucke; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2TK/ucke"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=kqCSyh/ldHEevO91VA549tj9DNL2UTg/ugPa7E64c1Y=; b=2TK/uckeZkRVDDYOfr7nwpb6sn
	/0qDKxuglHn9IFR3uyiAqDh7fgtJjOnBiYZCW9nxYCRjsZJjCslKTEJFRSo5LL5mbIGVoSHaHQKuX
	OxZYFaPfNtGQR+xbsY6R4DraE+xQ0M+1W4LotYo+b8bwuaKyZimMYSRQeRD/nabzgzovnY6ar8IFl
	DGUSIOkvAaKLShQnP0/aD/EauNWUOezOCqVBomfju4+nvcXh8plPW7egRbtVPwLNCYD0XnSv+Qt51
	V9iMTWXRgJGNZ4k/h9gRP2qL2+KKYfhotsRtPq/03Cwc6Twve7wqOsFJccsFgI9pS0GrA9ijTKhEk
	505hKvcQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNfkJ-0000000CRAF-1sKi;
	Mon, 24 Nov 2025 23:13:23 +0000
Message-ID: <7854489b-bc9e-4bb9-a19d-cff96badc180@infradead.org>
Date: Mon, 24 Nov 2025 15:13:22 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] drivers/iommu: Add page_ext for
 IOMMU_DEBUG_PAGEALLOC
To: Mostafa Saleh <smostafa@google.com>, linux-mm@kvack.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, xiaqinxin@huawei.com
References: <20251124200811.2942432-1-smostafa@google.com>
 <20251124200811.2942432-2-smostafa@google.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251124200811.2942432-2-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/24/25 12:08 PM, Mostafa Saleh wrote:
> Add a new config IOMMU_DEBUG_PAGEALLOC, which registers new data to
> page_ext.
> 
> This config will be used by the IOMMU API to track pages mapped in
> the IOMMU to catch drivers trying to free kernel memory that they
> still map in their domains, causing all types of memory corruption.
> 
> This behaviour is disabled by default and can be enabled using
> kernel cmdline iommu.debug_pagealloc.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  6 ++++
>  drivers/iommu/Kconfig                         | 19 +++++++++++
>  drivers/iommu/Makefile                        |  1 +
>  drivers/iommu/iommu-debug-pagealloc.c         | 32 +++++++++++++++++++
>  include/linux/iommu-debug-pagealloc.h         | 17 ++++++++++
>  mm/page_ext.c                                 |  4 +++
>  6 files changed, 79 insertions(+)
>  create mode 100644 drivers/iommu/iommu-debug-pagealloc.c
>  create mode 100644 include/linux/iommu-debug-pagealloc.h
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6c42061ca20e..dddf435a1c11 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2557,6 +2557,12 @@
>  			1 - Bypass the IOMMU for DMA.
>  			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
>  
> +	iommu.debug_pagealloc=
> +			[KNL,EARLY] When CONFIG_IOMMU_DEBUG_PAGEALLOC is set, this
> +			parameter enables the feature at boot time. By default, it
> +			is disabled and the system behave the same way as a kernel

			                           behaves

> +			built without CONFIG_IOMMU_DEBUG_PAGEALLOC.
> +
>  	io7=		[HW] IO7 for Marvel-based Alpha systems
>  			See comment before marvel_specify_io7 in
>  			arch/alpha/kernel/core_marvel.c.


-- 
~Randy

