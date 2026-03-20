Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462C040DFC2
	for <iommu@lists.linux.dev>; Fri, 20 Mar 2026 01:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773968743; cv=none; b=Wl5xzuikkTz1zag3ojDAt9XI0GJVGrzIZo4nePtm3N/U44B0LEITU7QlaD/0SUZ405IeYyQkjYA0oXmhyZSn42rrmYDjZjz59zO16QnfvukTUER1v0VnwZwwqmtbmqQbUjKFk6xomlibRQ3ajUwOwwrYQI+8kJCkteM1Z/r/TqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773968743; c=relaxed/simple;
	bh=QIqXKeW1izdWNR8jM1NhwLjTo9tqpcgolnf5WC9Fg60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0qLV4UVo9u4wpbKh/mOYAaOOMlPNolYuo84qhn+M1LjoqWMSrFiPXFJT3R3EAUvryxUi864IT0/JErnduqwb/PRZbnnHdZcFrMw/RtBK3k0gGyqIslz2tO5X6ywFm1gfN3FquXAF4kjDdVQ1e2wygm3HfpmYFTOUrphryzw480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BknWEtIe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BknWEtIe"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so40145ad.0
        for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 18:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773968739; x=1774573539; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xTn3hK2jgdEVmDsb9ax7KRypVVI5dKtyHQlrYUlMo/M=;
        b=BknWEtIe1ON0qVgev3Odb5nTYEZ3lG2wtZ13Ib+D1DVMYmMch2zgMuPz4t/ViWZLdG
         VjjCYZcQshZ8wRZ7zYN0orS7gaFpjFjhRKCU7jI+rnWd/ZP737oBgVUQ/gquact1SD/J
         L28VdfBOZMh/Ig7u09b02JBW10q9tD/ppxLMnrT8tSdrjaNczXdbXEjNS9gQM//e9u/9
         Iz129yguCh/49B4SXTJny2ONMdUPKSlEZfGTtqBHDwkdrYfWTP/PFXuQqVJ9lGF052+1
         jvsvdYZVupN2TpxtXBHO2SYlatiEOjb46rOw5svTV/BZD95CWUa6k2Dax8F5w3o7rzfk
         Wicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773968739; x=1774573539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTn3hK2jgdEVmDsb9ax7KRypVVI5dKtyHQlrYUlMo/M=;
        b=bjQzVtKgU23IrOheAATA3L1LVvs5b6FjteUoS3YhHRo5hMBsZjbEOpOWtfJe5yPNvq
         lDLI5t8F8hW7kLYa6FJoYqeJnxuwFJizdIzt++JtNNheh53HZSTl13HxKW+M6bTbenAH
         fGUa8zH/pryPPn2ywOPkp0EWbSfzze8GDZrlT3URc768B2gHEkRrWMc5Uk78XNDHm1eT
         asZYhYedrdI2TZkx7s6bsdw3ERf7SgBOxjxJvWj61JyCPgdET5wXIXK85IBVG+WSOcDR
         y8fuy3/EYJFf2xhJkNP+0zMqvempQO3neypoflXr084ulNpvFySadVqNLF7Wnki9UBBF
         5j2g==
X-Forwarded-Encrypted: i=1; AJvYcCWWrGWaJ8Weyex+3PjujssNdMxtmbDFc9JkiLN4CSnI00JLU3iu4RE9rfZ/jWKUOIRXyIX5tg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzD9A2oBIeRvYVoCw+zjYaR5om0W5s7oA+d5FKtsy1928AUFn/Z
	qrA3kLZ9MhVzO+p2mVfGINpNexpy/ZtDl4l9KhIpC0WC9NFk9tCLM99pTiwvzFbDmA==
X-Gm-Gg: ATEYQzzDOKE8IAVRDKUHOEk05p8Ybwva8cJRTZ5nJ2+pEbZI4KxEXLeCdWn3uVubeXV
	Qbrt8dZQnt79fTvvLUer3VdmnwJG7MHe17X+TkoQKTwuL3Vhi40W193XasAOtdAQkcqtsi0nf9S
	QCU59/Je6BWhu5esssBlDfPeLltOME7+C1tCduSUSk8dLwx6Vg28o/pOq4tZh6H8aRTb53aDeps
	6hEie/YQ3rF9bQwleJrpj8Ikl5QUd6BWnT6kRnMRf2hrZPA9wqGmnwt6kGu9Ytrhx8fhCwN/PSA
	niLBfL1kY1I00uCQ8JsLM0JlQm8QR89ZYLwnGcW7cAXlOjdG9p1zfqlUimdwydOKuGOw/qTY6mk
	4gP/HI1BIF1yfmv+OE8t8wnIY1J0xGsZzn8e+Xb5JKuX4CU7y2LnRIFZYAoAgYSzy02vsIqjUE3
	m5IJsQ7Boy9RQ/OTXowunMKtGkSJXGcSXqUdxSefbMGabrOtMAQvo2j2xT1m8BYQ==
X-Received: by 2002:a17:902:d544:b0:2b0:5cc5:9405 with SMTP id d9443c01a7336-2b08366b3bfmr1001805ad.1.1773968738628;
        Thu, 19 Mar 2026 18:05:38 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836b97fesm4163285ad.84.2026.03.19.18.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 18:05:38 -0700 (PDT)
Date: Fri, 20 Mar 2026 01:05:34 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Vipin Sharma <vipinsh@google.com>
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
Message-ID: <abyX6xWTK4R5_vDp@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-8-skhawaja@google.com>
 <20260319190137.GA3983821.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260319190137.GA3983821.vipinsh@google.com>

Hi Vipin,

On Thu, Mar 19, 2026 at 01:54:27PM -0700, Vipin Sharma wrote:
>On Tue, Feb 03, 2026 at 10:09:41PM +0000, Samiullah Khawaja wrote:
>> During boot fetch the preserved state of IOMMU unit and if found then
>> restore the state.
>>
>> - Reuse the root_table that was preserved in the previous kernel.
>> - Reclaim the domain ids of the preserved domains for each preserved
>>   devices so these are not acquired by another domain.
>
>Can this be two patches? One just restoring root table and second one to
>reclaim device ids.

This patch is restoring the state of the preserved IOMMU. The domain ids
are part of the iommu state and used in the context entries that are
being restored in this patch, that is why I kept these in one patch. I
will reword the subject of this patch and add a note on this in commit
message.
>
>> -static void init_translation_status(struct intel_iommu *iommu)
>> +static void init_translation_status(struct intel_iommu *iommu, bool restoring)
>>  {
>>  	u32 gsts;
>>
>>  	gsts = readl(iommu->reg + DMAR_GSTS_REG);
>> -	if (gsts & DMA_GSTS_TES)
>> +	if (!restoring && (gsts & DMA_GSTS_TES))
>>  		iommu->flags |= VTD_FLAG_TRANS_PRE_ENABLED;
>>  }
>
>I think we can just check in the caller, init_dmars(), and not call this
>function. We are already modifying that function, so no need to make
>changes here as well. WDYT?

Yes, I think we can move the if outside.
>
>>
>> @@ -670,10 +670,16 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
>>  #endif
>>
>>  /* iommu handling */
>> -static int iommu_alloc_root_entry(struct intel_iommu *iommu)
>> +static int iommu_alloc_root_entry(struct intel_iommu *iommu, struct iommu_ser *restored_state)
>
>Nit: Since we are using iommu_ser at other places, I will recommend to
>keep it same variable name here as well.

Hmm... that is a good point. I think I will update the other places and
change it to restored_state/preserved_state to better reflect the
context.
>
>> @@ -1636,8 +1643,10 @@ static int __init init_dmars(void)
>>  						   intel_pasid_max_id);
>>  		}
>>
>> +		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
>> +
>>  		intel_iommu_init_qi(iommu);
>> -		init_translation_status(iommu);
>> +		init_translation_status(iommu, !!iommu_ser);
>
>Just put 'if' here to avoid changes in init_translation_status().

Agreed.
>
>> +static int __restore_used_domain_ids(struct device_ser *ser, void *arg)
>
>Nit: Just curious, why two __?

I will remove these.
>
>> +{
>> +	int id = ser->domain_iommu_ser.did;
>> +	struct intel_iommu *iommu = arg;
>> +
>> +	ida_alloc_range(&iommu->domain_ida, id, id, GFP_ATOMIC);
>
>Should we check if allocation succeeded or not?

Good point. This should not fail as we are reserving these ids during
init. But I think I will add a WARN here.
>
>> +	return 0;
>> +}
>> +
>> +void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>> +					       struct iommu_ser *iommu_ser)
>> +{
>> +	BUG_ON(!kho_restore_folio(iommu_ser->intel.root_table));
>> +	iommu->root_entry = __va(iommu_ser->intel.root_table);
>> +
>> +	restore_iommu_context(iommu);
>> +	iommu_for_each_preserved_device(__restore_used_domain_ids, iommu);
>> +	pr_info("Restored IOMMU[0x%llx] Root Table at: 0x%llx\n",
>> +		iommu->reg_phys, iommu_ser->intel.root_table);
>
>Should raw pointer values be printed like this?

I will remove this.
>
