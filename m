Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9264C8061D
	for <iommu@lists.linux.dev>; Fri, 19 Apr 2024 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713531393; cv=none; b=MScCkdUmz1mCUFzwi/lS626mCcEKCXFGSwEY3YE2ATag+bEhtdkgirJEy1i26xPXCjNmBBhocpAsKF9UGVzd+WE6bgqD2iGuNrOyRPnCDQoGLIgkGJeHthypyPuMXFbDIZHhkiaxGcWsTb7DIUmV+AC4iWQ9QBo1MS/NQ6rDNRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713531393; c=relaxed/simple;
	bh=TMr4RZ19Bd7AjfjrbQ1usf3bz+QWBHzTOPk2Gqnrkm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqIpffZHLI5iFBmiWWa2IT70xBwD5SDKwR68oGw6v6t3+/ZszZLpi2RJ407YaIWnj3brprPURuGuVG/1S3PI+35ybQdmuyZRXFar+jRfuorKmkvmvxtHwfpALpxAeeLom6opt1J/7klFq4keKRNxsDvi0ksq4n1OonLcdPaXwws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NAU1+tW1; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NAU1+tW1"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2352cc0b076so1138363fac.0
        for <iommu@lists.linux.dev>; Fri, 19 Apr 2024 05:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713531390; x=1714136190; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qAnQXOAIIj9oS1dVAkkGazDr3oWNNZyu5Ad+/xAUOSA=;
        b=NAU1+tW1tsSTQW7NlhYkStDb+pjL3hCXoyey/JGqTF3iqeOGUhuWsFMDuroJNjOj1U
         X+WeFvNQR8RrL59eMSKxYsRuizGc7+SgWUVkRDHwL6hJRX0c84Kow+EvHNM95Visu3iY
         exg3WN+bldKy3GX0WhtuAUjsfJ1IhP5TjdrNrnh8Anhfu4M6JkauPJqFUUp3mfFG0/tu
         q8aAQcPk0hEVWjJjrrVd+VVSOmb6PzDGGIMsSsyIrkuQYFFg/A98C3FuPrNvs5VOidoM
         RPuP6qRt5EmcSsfHgkOj+kPhskziO4bn0CyAsuQX23hEHfNMYm/iEvE+RVy7TpIJocQI
         KBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713531390; x=1714136190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAnQXOAIIj9oS1dVAkkGazDr3oWNNZyu5Ad+/xAUOSA=;
        b=Ck6SMddGtN5+ouEt1k2mS0ediIstZ/AOxfKBO0Y2AHeqEhtUe4pdb3xO16Q1WmuQ1G
         TKEK/ctwsS7COsH/4jT9peGiUgs4HfqsVjdKIbS6smundHBjZhLD/KJARzLAWb7Xe38h
         Q7a5GEVcaHr7c6ZGueAyeQTsMLY3SCegBrfoAfbfcuArsErS7v6UtAXPkjvnExhfc1yn
         QWO8NyQMjg52/6uLCEKZ+9Swe2YIxqCHy+Ek97RiwPPDPaiPNKeDCV44dhObLKSynXZ5
         Lugvpjqis2diFyy681y/+AJLQ4Smt96yX+T1Y4W9HonS6NpQ5XNK3LjrK9gSXm7Ug41E
         fSrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYc5L1KVzfQ07X/Rh4GtjFbXZoV57JRxeTuFmcYitos5b8nkwhweMmeSBUDvBfIMncZzeo0za4c07C39QG3Ma8Fo8/LNU=
X-Gm-Message-State: AOJu0YzsLo9J7AWpIIVNL6ZznZimGe13Vbhbe60Q7kqSKO0p1kaEmt7N
	EYEEJGXRqslJ4aYsfGZ3vKzRWEn+PeomzwkKqs67h7/1dn/cOfDxq2ya6bnjAhY=
X-Google-Smtp-Source: AGHT+IHFfBcis79UcRir4VffHs5X6NLftoITO/91C4p4EpS7Z44Ysxagpcl0DozKM758wLJf4tJP1g==
X-Received: by 2002:a05:6870:2d4:b0:22e:9901:ede4 with SMTP id r20-20020a05687002d400b0022e9901ede4mr2180580oaf.38.1713531389153;
        Fri, 19 Apr 2024 05:56:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id t20-20020a05683014d400b006eb77e42ff5sm691060otq.26.2024.04.19.05.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 05:56:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rxnn1-00FPgO-MQ;
	Fri, 19 Apr 2024 09:56:27 -0300
Date: Fri, 19 Apr 2024 09:56:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Subject: Re: [PATCH v2 7/7] iommu/riscv: Paging domain support
Message-ID: <20240419125627.GD223006@ziepe.ca>
References: <cover.1713456597.git.tjeznach@rivosinc.com>
 <301244bc3ff5da484b46d3fecc931cdad7d2806f.1713456598.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <301244bc3ff5da484b46d3fecc931cdad7d2806f.1713456598.git.tjeznach@rivosinc.com>

On Thu, Apr 18, 2024 at 09:32:25AM -0700, Tomasz Jeznach wrote:

> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index a4f74588cdc2..32ddc372432d 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -46,6 +46,10 @@ MODULE_LICENSE("GPL");
>  #define dev_to_iommu(dev) \
>  	container_of((dev)->iommu->iommu_dev, struct riscv_iommu_device, iommu)
>  
> +/* IOMMU PSCID allocation namespace. */
> +static DEFINE_IDA(riscv_iommu_pscids);
> +#define RISCV_IOMMU_MAX_PSCID		BIT(20)
> +

You may consider putting this IDA in the riscv_iommu_device() and move
the pscid from the domain to the bond?

>  /* Device resource-managed allocations */
>  struct riscv_iommu_devres {
>  	unsigned long addr;
> @@ -752,12 +756,77 @@ static int riscv_iommu_ddt_alloc(struct riscv_iommu_device *iommu)
>  	return 0;
>  }
>  
> +struct riscv_iommu_bond {
> +	struct list_head list;
> +	struct rcu_head rcu;
> +	struct device *dev;
> +};
> +
> +/* This struct contains protection domain specific IOMMU driver data. */
> +struct riscv_iommu_domain {
> +	struct iommu_domain domain;
> +	struct list_head bonds;
> +	int pscid;
> +	int numa_node;
> +	int amo_enabled:1;
> +	unsigned int pgd_mode;
> +	/* paging domain */
> +	unsigned long pgd_root;
> +};

Glad to see there is no riscv_iommu_device pointer in the domain!

> +static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
> +				    unsigned long start, unsigned long end)
> +{
> +	struct riscv_iommu_bond *bond;
> +	struct riscv_iommu_device *iommu;
> +	struct riscv_iommu_command cmd;
> +	unsigned long len = end - start + 1;
> +	unsigned long iova;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(bond, &domain->bonds, list) {
> +		iommu = dev_to_iommu(bond->dev);

Pedantically this locking isn't locked right, there is technically
nothing that prevents bond->dev and the iommu instance struct from
being freed here. eg iommufd can hit races here if userspace can hot
unplug devices.

I suggest storing the iommu pointer itself in the bond instead of the
device then add a synchronize_rcu() to the iommu unregister path.

> +		riscv_iommu_cmd_inval_vma(&cmd);
> +		riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
> +		if (len > 0 && len < RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
> +			for (iova = start; iova < end; iova += PAGE_SIZE) {
> +				riscv_iommu_cmd_inval_set_addr(&cmd, iova);
> +				riscv_iommu_cmd_send(iommu, &cmd, 0);
> +			}
> +		} else {
> +			riscv_iommu_cmd_send(iommu, &cmd, 0);
> +		}
> +	}

This seems suboptimal, you probably want to copy the new design that
Intel is doing where you allocate "bonds" that are already
de-duplicated. Ie if I have 10 devices on the same iommu sharing the
domain the above will invalidate the PSCID 10 times. It should only be
done once.

ie add a "bond" for the (iommu,pscid) and refcount that based on how
many devices are used. Then another "bond" for the ATS stuff eventually.

> +
> +	list_for_each_entry_rcu(bond, &domain->bonds, list) {
> +		iommu = dev_to_iommu(bond->dev);
> +
> +		riscv_iommu_cmd_iofence(&cmd);
> +		riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_QUEUE_TIMEOUT);
> +	}
> +	rcu_read_unlock();
> +}
> +

> @@ -787,12 +870,390 @@ static int riscv_iommu_attach_domain(struct riscv_iommu_device *iommu,
>  		xchg64(&dc->ta, ta);
>  		xchg64(&dc->tc, tc);
>  
> -		/* Device context invalidation will be required. Ignoring for now. */
> +		if (!(tc & RISCV_IOMMU_DC_TC_V))
> +			continue;

No negative caching in HW?

> +		/* Invalidate device context cache */
> +		riscv_iommu_cmd_iodir_inval_ddt(&cmd);
> +		riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
> +		riscv_iommu_cmd_send(iommu, &cmd, 0);
> +
> +		if (FIELD_GET(RISCV_IOMMU_PC_FSC_MODE, fsc) == RISCV_IOMMU_DC_FSC_MODE_BARE)
> +			continue;
> +
> +		/* Invalidate last valid PSCID */
> +		riscv_iommu_cmd_inval_vma(&cmd);
> +		riscv_iommu_cmd_inval_set_pscid(&cmd, FIELD_GET(RISCV_IOMMU_DC_TA_PSCID, ta));
> +		riscv_iommu_cmd_send(iommu, &cmd, 0);
> +	}
> +
> +	/* Synchronize directory update */
> +	riscv_iommu_cmd_iofence(&cmd);
> +	riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_IOTINVAL_TIMEOUT);
> +
> +	/* Track domain to devices mapping. */
> +	if (bond)
> +		list_add_rcu(&bond->list, &domain->bonds);

This is in the wrong order, the invalidation on the pscid needs to
start before the pscid is loaded into HW in the first place otherwise
concurrent invalidations may miss HW updates.

> +
> +	/* Remove tracking from previous domain, if needed. */
> +	iommu_domain = iommu_get_domain_for_dev(dev);
> +	if (iommu_domain && !!(iommu_domain->type & __IOMMU_DOMAIN_PAGING)) {

No need for !!, && is already booleanizing

> +		domain = iommu_domain_to_riscv(iommu_domain);
> +		bond = NULL;
> +		rcu_read_lock();
> +		list_for_each_entry_rcu(b, &domain->bonds, list) {
> +			if (b->dev == dev) {
> +				bond = b;
> +				break;
> +			}
> +		}
> +		rcu_read_unlock();
> +
> +		if (bond) {
> +			list_del_rcu(&bond->list);
> +			kfree_rcu(bond, rcu);
> +		}
> +	}
> +
> +	return 0;
> +}

> +static inline size_t get_page_size(size_t size)
> +{
> +	if (size >= IOMMU_PAGE_SIZE_512G)
> +		return IOMMU_PAGE_SIZE_512G;
> +	if (size >= IOMMU_PAGE_SIZE_1G)
> +		return IOMMU_PAGE_SIZE_1G;
> +	if (size >= IOMMU_PAGE_SIZE_2M)
> +		return IOMMU_PAGE_SIZE_2M;
> +	return IOMMU_PAGE_SIZE_4K;
> +}
> +
> +#define _io_pte_present(pte)	((pte) & (_PAGE_PRESENT | _PAGE_PROT_NONE))
> +#define _io_pte_leaf(pte)	((pte) & _PAGE_LEAF)
> +#define _io_pte_none(pte)	((pte) == 0)
> +#define _io_pte_entry(pn, prot)	((_PAGE_PFN_MASK & ((pn) << _PAGE_PFN_SHIFT)) | (prot))
> +
> +static void riscv_iommu_pte_free(struct riscv_iommu_domain *domain,
> +				 unsigned long pte, struct list_head *freelist)
> +{
> +	unsigned long *ptr;
> +	int i;
> +
> +	if (!_io_pte_present(pte) || _io_pte_leaf(pte))
> +		return;
> +
> +	ptr = (unsigned long *)pfn_to_virt(__page_val_to_pfn(pte));
> +
> +	/* Recursively free all sub page table pages */
> +	for (i = 0; i < PTRS_PER_PTE; i++) {
> +		pte = READ_ONCE(ptr[i]);
> +		if (!_io_pte_none(pte) && cmpxchg_relaxed(ptr + i, pte, 0) == pte)
> +			riscv_iommu_pte_free(domain, pte, freelist);
> +	}
> +
> +	if (freelist)
> +		list_add_tail(&virt_to_page(ptr)->lru, freelist);
> +	else
> +		free_page((unsigned long)ptr);
> +}

Consider putting the page table handling in its own file?

> +static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
> +					    struct device *dev)
> +{
> +	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
> +	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
> +	struct page *page;
> +
> +	if (!riscv_iommu_pt_supported(iommu, domain->pgd_mode))
> +		return -ENODEV;
> +
> +	domain->numa_node = dev_to_node(iommu->dev);
> +	domain->amo_enabled = !!(iommu->caps & RISCV_IOMMU_CAP_AMO_HWAD);
> +
> +	if (!domain->pgd_root) {
> +		page = alloc_pages_node(domain->numa_node,
> +					GFP_KERNEL_ACCOUNT | __GFP_ZERO, 0);
> +		if (!page)
> +			return -ENOMEM;
> +		domain->pgd_root = (unsigned long)page_to_virt(page);

The pgd_root should be allocated by the alloc_paging function, not
during attach. There is no locking here that will protect against
concurrent attach and also map before attach should work.

You can pick up the numa affinity from the alloc paging dev pointer
(note it may be null still in some cases)

Jason
