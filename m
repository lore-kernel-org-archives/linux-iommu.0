Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B575F30B53F
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 20:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773953674; cv=none; b=jcc4l+0cZjjtwLitpkz50UYoQC2zsvPCPnG3BPDeihvlgY+ebkfZFk7l4MaFaoXocjlQLHQGmKq//B//p0ejBGS8NrD8ZweVY030G6aPfmftkfybrYFTopperRKPZTBimwVfDgssMv64l5jjmI3V4v5QLzpWy6qX+jfxJnCYewk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773953674; c=relaxed/simple;
	bh=rQ8jOPX8ZyyiaUDP/Ws9FcBOSexPt2uadqrTujPU5ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jP8yoBkhDlt8qU02OXgXTklCqd0ePGd6JF9gLZAQTi8zSmZbGHzd1UqzZuUqV6Uq1pDQbkKWf+5gyWP1eIzyCNPhKHYJeWrSAWBCaU/bqcDY0QU6JdhKJjIdErNFg53zZro3aqUXMgnLsY6X1my+LGB11PQPcMYKXTxOK2vtt4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wcTIF39R; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wcTIF39R"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so24825ad.0
        for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 13:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773953673; x=1774558473; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=19Xw5f9a4xpkhlTeHR9HScsDJ7KIvG2RWfmSuFdiufE=;
        b=wcTIF39R0pIwOOzMnHKPzEx/mOPJyCQtRTh2FQwcAubR9AraP+92Xunk+FruFEQXcb
         wap6n7OfYSuyzvetgWSyOpgyW5swDRsuZULqE0N7YRYTGwYi9WBdPznGpQakEWRW1WTJ
         2xvZ9yiux6JcdVl64wog5VvFEKYF9QHPm+e8MrXjIY0n1NjGzI5ktDKOpFH12FiTNuMo
         CsTu1L3MIZrzhVArqV8KBtwBGHRPwQ6e+yGSAn4jkGyjbWkChcMglB/wjzeB8kjqM8Kz
         5ayy3TbLJYIjqYusV8L9ab7h/js1pZdo1MxY3bUwoPh5CVyxHwePXIy6fz84yvd8T6AS
         6AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773953673; x=1774558473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19Xw5f9a4xpkhlTeHR9HScsDJ7KIvG2RWfmSuFdiufE=;
        b=eX6K605uuYOft6tK04HhE3DeItxLfd2wkap3B9XOJIUglm6C3G947aSCaLGjZnFIBe
         UBehuTRXk9so8PnAI8sdgxfp+3Eg8VFCjozEzp6HsbemCkTi1OZm/BnYZjy/5E9ONvYZ
         GDxa22z8Yb0cX17+Enh+DlaObzQU2W/NHsQK5kMjBLQhQNwyXnV1gvbOCoYpgOm9K0O9
         NstjH8a0VQcAenKtqm9EuwsKyLtoDfYPpHs6uQY1Qa/kKHLMfdtHGsdyS20Zzyy0CDLF
         WIR1P0YodVyBEnqlpiklh0omQa7cK2ZAuZyJu0xebeJ3WjpqAFoyoC/sWXbzmVNzrJ+C
         Ahbg==
X-Forwarded-Encrypted: i=1; AJvYcCUy/C8xhuorAlH7ct+sl40YzuhVppVcJhPbcH61XCwzxNhaXJz4rGvnf2Zg9ycX9PXwxbp0IA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwiyF0Ln6OJ9Jq6mCaBqnG3SngWm5qbvopOhnz9uV9bprFiNU7m
	PQ06jnnEnNAuu/tYUDPF91RkHv5vX7nXkRpO9K6biCcovz65EDTMHrsCwmEFfYI8Gw==
X-Gm-Gg: ATEYQzzda7AnSU7g326lsCH2LmMUzX0TsjL/+tP5vWG9EcWEdvU1CPAwqfxkWuqWKxm
	hE7KFtuvNsreIHTeQwKqCMb2cwoMDGIC3qpfcwY3BAXp9JR/yYdWB6yi/LDEdn2PIguqjINnSHX
	iTDh/k72a5HNXVvg6uoPJOfCtcHBHJ+tdi19qOHuIUvNcusw1HM/B0DrJ/fTNYEjVmRwxb00Irc
	IjWoNQQzcefM7LN8XCHk9AG2C5LOsNxsqEoe7Ew9SPkrhJ99sHKlRnHzAG2DrGeMviknwzZL0sD
	/IuqDBy68M66m50BfLghRXKtP3pQqpbOYazCjjviQ2/yCR+6/9OGDYBEFv1cKnr8Vv+Y93SzcfC
	ppxyHgP1+0IE83+SknAFtV/mgFiwaB3aWyO/hVDaLfVLKWNfDgjqHk/bEbXa5o46yIx4Xxjt0+f
	VJTmwOQsccvv9lUtqjEayIWx5GWhwjexRzte36BvJdGfkwcNEWytdKXdkcJA==
X-Received: by 2002:a17:902:cecc:b0:2ae:c358:bb9f with SMTP id d9443c01a7336-2b082855f56mr897565ad.10.1773953672329;
        Thu, 19 Mar 2026 13:54:32 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516a8dsm1241785ad.3.2026.03.19.13.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 13:54:31 -0700 (PDT)
Date: Thu, 19 Mar 2026 13:54:27 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
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
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 07/14] iommu/vt-d: Restore IOMMU state and reclaimed
 domain ids
Message-ID: <20260319190137.GA3983821.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-8-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-8-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:41PM +0000, Samiullah Khawaja wrote:
> During boot fetch the preserved state of IOMMU unit and if found then
> restore the state.
> 
> - Reuse the root_table that was preserved in the previous kernel.
> - Reclaim the domain ids of the preserved domains for each preserved
>   devices so these are not acquired by another domain.

Can this be two patches? One just restoring root table and second one to
reclaim device ids.

> -static void init_translation_status(struct intel_iommu *iommu)
> +static void init_translation_status(struct intel_iommu *iommu, bool restoring)
>  {
>  	u32 gsts;
>  
>  	gsts = readl(iommu->reg + DMAR_GSTS_REG);
> -	if (gsts & DMA_GSTS_TES)
> +	if (!restoring && (gsts & DMA_GSTS_TES))
>  		iommu->flags |= VTD_FLAG_TRANS_PRE_ENABLED;
>  }

I think we can just check in the caller, init_dmars(), and not call this
function. We are already modifying that function, so no need to make
changes here as well. WDYT?

>  
> @@ -670,10 +670,16 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
>  #endif
>  
>  /* iommu handling */
> -static int iommu_alloc_root_entry(struct intel_iommu *iommu)
> +static int iommu_alloc_root_entry(struct intel_iommu *iommu, struct iommu_ser *restored_state)

Nit: Since we are using iommu_ser at other places, I will recommend to
keep it same variable name here as well.

> @@ -1636,8 +1643,10 @@ static int __init init_dmars(void)
>  						   intel_pasid_max_id);
>  		}
>  
> +		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
> +
>  		intel_iommu_init_qi(iommu);
> -		init_translation_status(iommu);
> +		init_translation_status(iommu, !!iommu_ser);

Just put 'if' here to avoid changes in init_translation_status().

> +static int __restore_used_domain_ids(struct device_ser *ser, void *arg)

Nit: Just curious, why two __?

> +{
> +	int id = ser->domain_iommu_ser.did;
> +	struct intel_iommu *iommu = arg;
> +
> +	ida_alloc_range(&iommu->domain_ida, id, id, GFP_ATOMIC);

Should we check if allocation succeeded or not?

> +	return 0;
> +}
> +
> +void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
> +					       struct iommu_ser *iommu_ser)
> +{
> +	BUG_ON(!kho_restore_folio(iommu_ser->intel.root_table));
> +	iommu->root_entry = __va(iommu_ser->intel.root_table);
> +
> +	restore_iommu_context(iommu);
> +	iommu_for_each_preserved_device(__restore_used_domain_ids, iommu);
> +	pr_info("Restored IOMMU[0x%llx] Root Table at: 0x%llx\n",
> +		iommu->reg_phys, iommu_ser->intel.root_table);

Should raw pointer values be printed like this?

