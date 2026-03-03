Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83C242F56E
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563294; cv=none; b=NGcDlNo3aRvLBGHndopW6tMK18uKY4Aq8MNdWM6+BI38lVZxw9TWtidB24jZ00UDMFk//NAlNlzWmfAUyDREpT+I/3SqdfaKEWe58KLfvPoY/WQgbOKlF4UsNu8ZBRqRCVZmXZax/XOCjugDIpNCGO8olXr34HiOYd7OhqD5A5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563294; c=relaxed/simple;
	bh=AOQWvUqJv4lNcUO8YIDTbhsNhv0Q3kF0idwcy68u+oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rARoAvQbIrll27nAbXwI6gsl+pKLUVURC+uz+zznnEYHZmARcRQZd/zriGg5NUNJasnk9QyP5OcoOd00yyR8MlTZW3oLumK8ss/8mOSUGHzGMj5MwkPgghUhw7UVYFNrUHWmBs9bFmjj7ioUEGYjPexDubFift2CCYR1r8TtFOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fOHrbAx/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fOHrbAx/"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ae4b40999bso96005ad.1
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 10:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772563291; x=1773168091; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u30Jc93NSo6jjaBUVn4MMoIkiqIVphQIkXw+rRzsOT0=;
        b=fOHrbAx/lML3qFRSSsegDNMaQE4456e2Ui/b/CGxdkmtFL5cKB4PtVZGr7KAwCRaJg
         O3m8zcTynNhhJtTqSDM+WLdEBrFVkx9xuBqlBf+dfUGvLxNNSMdBz6g1l7QwOd6zZicn
         lSzV1GeEbbsZO+gigFrOeFZe2dFd732ZEPE9K3CvqW5aMKNyPIu707eFaUPpCJjM0Six
         YlL8rk51LLinBPoEOUiRD/wffh6VTy6bs4qHRDBmEcJaz0EGbEpzq6/aGhn/fX9HQoo/
         04HBPQf7ZH5KNVOgioCOMNUuymRpTuJYX60Mr+sfyC7M5Yve5u9lpSN4wxPIgwH3aWCy
         4j1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772563291; x=1773168091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u30Jc93NSo6jjaBUVn4MMoIkiqIVphQIkXw+rRzsOT0=;
        b=OOyT2NwkkTcPNpi73HjMuRkGVcNKK/hzIZROP+6oYHA5n/MGN0NG8T9RdWqGu7ebEO
         KXk/OBTRgLMdAnlKr5wGREnCVGwpR0l4upoWWuHdwOYrFpf1+9+ia2umbzDOmvs7+3l5
         KM55w+1UC1vDXE4a8JwjbM1NofGb2ftmUcYeicjgVwfPNGXCBunTjJ3NNpDDmLV1ofVE
         3ztEYOF/04uXLdI3tmKNebNsMpQWoyanP1w5BcJ8Hg6w0KBgaN+55iwpJy9OiH16Idl2
         lEpLJAPfuknpP2H9clSVKFjGMuiovSgGALiJ+e5tBidLNm3H6RHvGRk+TNk41PMRypEk
         5Rjw==
X-Forwarded-Encrypted: i=1; AJvYcCUlUR0PBj5lMnZigd75gkZNCLQBa1fKJa7y2bTqv6s1shX/vXjwAjq7B7Y8Du9B/w9s18YHqQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyrXqrt/45QHel+Y6mnUG2Xt7m+uDjohyniuKS/R51VJUQ31VLf
	+vHBkpdQTTdrMcoA3psglsUExMUT40gPXOgQLf78GRC8Twt75BLsZRkxmLKe603KUg==
X-Gm-Gg: ATEYQzxujqUoc9n9gXMUn8fL7O4yRh0vSWoBnuYdk7eFjMbK+J+JqoAXodXTbjgR00n
	LXHC1nY7WANVyHn5G8MgI6Ww4Kd1kUm4ssnu+ip+c8cxEY69ELTjHK9vndoyFoGTb5Ux45Zqmqk
	LYzan9T53qrvmvSrsArsVnpzOIc3nYinKxCi92QyLPbIEGtFY0/hCKn6PxP6wzPTRhzlj4/YoFD
	tIIbqK0GM4wZ/0zQiVwpjzKvfe5HQQZMdstWaptvM0v6SrdbmTYo8DATf6+Rg1a0EYXV0m8Lf0p
	HRYmmSF6x5tx6kqvRwiG5lmJCCOYXQk69ElsfHboiPfDEV5xugTK2CXEIGdKKeGZ1S7En42fBt2
	DOG1pISwTQJc4lS5cKvwYAQoOJS013ZLweR1fHli4s9Q7wu0MEGqCGVKJxqiTzdfZSmEMXOdMAC
	CozXO4t5TfZ7wTMY95C4p29WtUcQvxBi20cVIFODGAUfeccyZE39eciadd6oIuDQ==
X-Received: by 2002:a17:902:e847:b0:2ae:4808:bd99 with SMTP id d9443c01a7336-2ae4808bec6mr6306545ad.2.1772563290740;
        Tue, 03 Mar 2026 10:41:30 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4e2f85sm3486410a91.17.2026.03.03.10.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 10:41:30 -0800 (PST)
Date: Tue, 3 Mar 2026 18:41:26 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 04/14] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <af4h6wh75qdvgu27td43ndlxdyb5drq2pf7tssdsln3q5gce6f@6su7ylrgomhz>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-5-skhawaja@google.com>
 <d3wmnc43r3mir2emoitj432j3bfdw362dqmkvywa2qvu5tskb4@oqjkseil5i54>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d3wmnc43r3mir2emoitj432j3bfdw362dqmkvywa2qvu5tskb4@oqjkseil5i54>

On Tue, Mar 03, 2026 at 04:42:02PM +0000, Ankit Soni wrote:
>On Tue, Feb 03, 2026 at 10:09:38PM +0000, Samiullah Khawaja wrote:
>> IOMMU pages are allocated/freed using APIs using struct ioptdesc. For
>> the proper preservation and restoration of ioptdesc add helper
>> functions.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/iommu-pages.c | 74 +++++++++++++++++++++++++++++++++++++
>>  drivers/iommu/iommu-pages.h | 30 +++++++++++++++
>>  2 files changed, 104 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
>> index 3bab175d8557..588a8f19b196 100644
>> --- a/drivers/iommu/iommu-pages.c
>> +++ b/drivers/iommu/iommu-pages.c
>> @@ -6,6 +6,7 @@
>>  #include "iommu-pages.h"
>>  #include <linux/dma-mapping.h>
>>  #include <linux/gfp.h>
>> +#include <linux/kexec_handover.h>
>>  #include <linux/mm.h>
>>
>>  #define IOPTDESC_MATCH(pg_elm, elm)                    \
>> @@ -131,6 +132,79 @@ void iommu_put_pages_list(struct iommu_pages_list *list)
>>  }
>>  EXPORT_SYMBOL_GPL(iommu_put_pages_list);
>>
>> +#if IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE)
>> +void iommu_unpreserve_page(void *virt)
>> +{
>> +	kho_unpreserve_folio(ioptdesc_folio(virt_to_ioptdesc(virt)));
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_unpreserve_page);
>> +
>> +int iommu_preserve_page(void *virt)
>> +{
>> +	return kho_preserve_folio(ioptdesc_folio(virt_to_ioptdesc(virt)));
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_preserve_page);
>> +
>> +void iommu_unpreserve_pages(struct iommu_pages_list *list, int count)
>> +{
>> +	struct ioptdesc *iopt;
>> +
>> +	if (!count)
>> +		return;
>> +
>> +	/* If less than zero then unpreserve all pages. */
>> +	if (count < 0)
>> +		count = 0;
>> +
>> +	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
>> +		kho_unpreserve_folio(ioptdesc_folio(iopt));
>> +		if (count > 0 && --count ==  0)
>> +			break;
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
>> +
>> +void iommu_restore_page(u64 phys)
>> +{
>> +	struct ioptdesc *iopt;
>> +	struct folio *folio;
>> +	unsigned long pgcnt;
>> +	unsigned int order;
>> +
>> +	folio = kho_restore_folio(phys);
>> +	BUG_ON(!folio);
>> +
>> +	iopt = folio_ioptdesc(folio);
>
>iopt->incoherent = false; should be here?
>

Yes this should be set here. I will update this.
>> +
>> +	order = folio_order(folio);
>> +	pgcnt = 1UL << order;
>> +	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, pgcnt);
>> +	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, pgcnt);
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_restore_page);
>> +
>> +int iommu_preserve_pages(struct iommu_pages_list *list)
>> +{
>> +	struct ioptdesc *iopt;
>> +	int count = 0;
>> +	int ret;
>> +
>> +	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
>> +		ret = kho_preserve_folio(ioptdesc_folio(iopt));
>> +		if (ret) {
>> +			iommu_unpreserve_pages(list, count);
>> +			return ret;
>> +		}
>> +
>> +		++count;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_preserve_pages);
>> +
>> +#endif
>> +
>>  /**
>>   * iommu_pages_start_incoherent - Setup the page for cache incoherent operation
>>   * @virt: The page to setup
>> diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
>> index ae9da4f571f6..bd336fb56b5f 100644
>> --- a/drivers/iommu/iommu-pages.h
>> +++ b/drivers/iommu/iommu-pages.h
>> @@ -53,6 +53,36 @@ void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size);
>>  void iommu_free_pages(void *virt);
>>  void iommu_put_pages_list(struct iommu_pages_list *list);
>>
>> +#if IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE)
>> +int iommu_preserve_page(void *virt);
>> +void iommu_unpreserve_page(void *virt);
>> +int iommu_preserve_pages(struct iommu_pages_list *list);
>> +void iommu_unpreserve_pages(struct iommu_pages_list *list, int count);
>> +void iommu_restore_page(u64 phys);
>> +#else
>> +static inline int iommu_preserve_page(void *virt)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static inline void iommu_unpreserve_page(void *virt)
>> +{
>> +}
>> +
>> +static inline int iommu_preserve_pages(struct iommu_pages_list *list)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static inline void iommu_unpreserve_pages(struct iommu_pages_list *list, int count)
>> +{
>> +}
>> +
>> +static inline void iommu_restore_page(u64 phys)
>> +{
>> +}
>> +#endif
>> +
>>  /**
>>   * iommu_pages_list_add - add the page to a iommu_pages_list
>>   * @list: List to add the page to
>> --
>> 2.53.0.rc2.204.g2597b5adb4-goog
>>

Sami
