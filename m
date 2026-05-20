Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0E73563E9
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 19:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307167; cv=none; b=jHGt/E5WuXBKX2+UTTEDcafjVkl8TxUzQGRMIubUyRDC99Qz6LY98qSSElS/VjG5CaWv/a3qESUUM/b3gjJ5LuYAtP0pytwwpahUJpYpvK1CNeEItw/VHGoSkdhscunOxkgelvPV4wkpUoHtyxZVLjK5mdAGFmv8ZPrH5ver/aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307167; c=relaxed/simple;
	bh=S7TAJoU+IMqYQKKwE9M0wXBnMWS7p5Uteu79IW573uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkzUaZp65qZ6FMGnAg44rWbyzX+s59CX/UfJ3Lv/OrI8GE/4WdOKy8xmKVizCy6eNyq5PIe4GD6jloMON4KJWvZsfhAGjWpVHjwDg7AhWZnginy/MDxt9oHHbAcBduQIepM/a8BurIgKC2RZyOHd/dmgRIry/cWGQDvex9UvTgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=clJMrxE9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="clJMrxE9"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b46da8c48eso2685ad.1
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 12:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779307166; x=1779911966; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6s3nWbufKIAdpd+T1kqQvCCgsvhw2lBrbx69UeZQAOE=;
        b=clJMrxE94ovOUA/xyA/fXOV6OFtjkmShFl0uRff+/LHXqnonW8snHyHYZlZFYD6luH
         wd9B/0GhYDnm7/D+SlotKUUOhUCrgNFzHJO+kGYIkvTj43LEUXB4vujEslP7l2y40dmB
         QMIokN3VB+dh38cbztG6WbGu1xGU0BE+BoINP6WhD2u3rdEDZU9rcaLX8F2aEkqNz3xD
         p0E20uPsB2nFgjgSMdFggchJCYu+LgB3vVEoAgsHWf/dVTMG0FoxRfXUZsJFuCUuKy98
         hkXlwalbPCQmLCMMLYXSU76S+hqDbeaArasA2jFQrUAdK3lJAACqPm96q/LYxJXiyniX
         cfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779307166; x=1779911966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6s3nWbufKIAdpd+T1kqQvCCgsvhw2lBrbx69UeZQAOE=;
        b=sJrELSDjrgn5dX90k6+sSJbcHdcmob8l0QnCILJr6733dqDwExggBB7etM6PUmZQST
         sRQFbAaNigE9TLmvuDrVihfAWg4Um3HXme/xxMQtgE4lJc+8TP+vK7+OoXvDsLEtRgHq
         aZ4aquo57HZYWrtMAeypLfna5BZU+ndIhcAWTYSKMm+hEyaCVIYCHzVDzXAVV3CRJJfq
         Kb91CR7+9U5XDvm8fVSzaWQW8sfuE572iVnZXDp3xJ++Cjv92myV4sB3FDXAJXagb/CB
         jp8WI3ESeoHBqwYdRk3j83Ji4mzKhWD9TnOJPRAxzrAZ61Fxn4JR/KbKwq8QqiOKu6ix
         zftg==
X-Forwarded-Encrypted: i=1; AFNElJ+ZM1jbjnlhZrUMQukzZmFB8b77SKJwe5+Cgv6QWJY+YYLcUouiwqWOm3f2KSjzs4sh1LEaTA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXRPJ4unoDit2fi9eYHJWsYrh7+jb0NXePaJLvtlVJQtwn0/UC
	Nnbl3OM7hmzYqwtmVv50n/wxHkSFPhY5QDw/czFZqT30pVZa/g9m1hpkGYPgjCSFqQ==
X-Gm-Gg: Acq92OGLtl/8TRQ8Qr45HxMrSx9ulFtvVcmtzqWA9QWeFFZYWBi9tQBRcDyk/5WJ0yI
	LRmboKuSrW/2drrXlbGMB+iJGN+zdfQ8e9Pl6ZtHcriToDIsLlcYq+VexRfqMOaoEcVxjFSppPW
	GGOcLIBf8Fzw0nngHlWv5xukb0TMwTRt+DjLL/Z4FKIRed5n58ygrf5GDBwbyhPAei29TjYVzwv
	wpOBktiOAl3XaknHrEtekul2z0VITgEpYAM3dn/6ZFXNqrDNi31Q3wQVtE0xzgkPGdTn4/Wi57/
	oJDjx67SAWDKPWM/YZQ0eRWvjFYjVuHnP7XUTxJBZv6sZoJ7ZvomnNe+yZUsRWAbqU+n9rTM0qa
	YNijlYkuwtkkyJK4oZEBSDWu/eNjnHHwylaJsyV0r0TlfZGNHyAm3ESQQ2veyvX6Pm7nzTOKj/f
	naiGA7BbjNBjvBheeKobyTvn/fZGlew6Wxq20ofVMHfIpWHRgyi+GlZ7FCY8CBL2PwBw8KMw==
X-Received: by 2002:a17:902:d487:b0:2bd:907:2ce5 with SMTP id d9443c01a7336-2be9f694c1bmr510145ad.7.1779307164981;
        Wed, 20 May 2026 12:59:24 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb1006fbsm19676025a12.21.2026.05.20.12.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 12:59:24 -0700 (PDT)
Date: Wed, 20 May 2026 19:59:21 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
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
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 09/16] iommu/vt-d: Restore IOMMU state and reclaimed
 domain ids
Message-ID: <ag4Ront9mcdRDYBu@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-10-skhawaja@google.com>
 <agzaTPROvwVO-3lO@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agzaTPROvwVO-3lO@google.com>

On Tue, May 19, 2026 at 09:46:52PM +0000, Pranjal Shrivastava wrote:
>On Mon, Apr 27, 2026 at 05:56:26PM +0000, Samiullah Khawaja wrote:
>> During boot fetch the preserved state of IOMMU unit and if found then
>> restore the state.
>>
>> - Reuse the root_table that was preserved in the previous kernel.
>> - Reclaim the domain ids of the preserved domains for each preserved
>>   devices so these are not acquired by another domain.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/intel/iommu.c      | 55 ++++++++++++++++++++++--------
>>  drivers/iommu/intel/iommu.h      |  7 ++++
>>  drivers/iommu/intel/liveupdate.c | 57 ++++++++++++++++++++++++++++++++
>>  3 files changed, 105 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 68fecd4e57fa..4118a0861f38 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -670,10 +670,17 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
>>  #endif
>>
>>  /* iommu handling */
>> -static int iommu_alloc_root_entry(struct intel_iommu *iommu)
>> +static int iommu_alloc_root_entry(struct intel_iommu *iommu,
>> +				  struct iommu_hw_ser *iommu_ser)
>>  {
>>  	struct root_entry *root;
>>
>> +	if (iommu_ser) {
>> +		intel_iommu_liveupdate_restore_root_table(iommu, iommu_ser);
>> +		__iommu_flush_cache(iommu, iommu->root_entry, ROOT_SIZE);
>> +		return 0;
>> +	}
>> +
>
>Minor nit: I still believe this condition block can be moved into the
>caller? Since the called fetches iommu_ser, it can call this as a stand
>alone helper and bypass calling iommu_alloc_root_entry if (iommu_ser).

Agreed. Also as Baolu suggested the cache flush is not needed, so we can
move it out as it is self-contained. Will update this.
>
>>  	root = iommu_alloc_pages_node_sz(iommu->node, GFP_ATOMIC, SZ_4K);
>>  	if (!root) {
>>  		pr_err("Allocating root entry for %s failed\n",
>> @@ -992,15 +999,16 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
>>  		iommu_disable_translation(iommu);
>>  }
>>

[snip]
>
>> +
>> +static int _restore_used_domain_ids(struct iommu_device_ser *ser, void *arg)
>> +{
>> +	int id = ser->domain_iommu_ser.attachment_id;
>> +	struct iommu_hw_ser *iommu_hw_ser;
>> +	struct intel_iommu *iommu = arg;
>> +
>> +	iommu_hw_ser = phys_to_virt(ser->domain_iommu_ser.iommu_phys);
>
>We should check for iommu_phys being NULL here.. I know corruptions can
>be funnier but a WARN_ON(!iommu_phys) could help catch NULL corruptions

Agreed. I will add a WARN_ON here.
>
>> +	if (iommu_hw_ser->type != IOMMU_INTEL)
>> +		return 0;
>> +
>> +	/* Only allocate domain ID from associated IOMMU HW unit */
>> +	if (iommu_hw_ser->intel.phys_addr != iommu->reg_phys)
>> +		return 0;
>> +
>> +	/*
>> +	 * This can fail as multiple preserved devices can share the same domain
>> +	 * ID. Since this is done during DMAR init so these failures can be
>> +	 * ignored.
>> +	 */
>> +	ida_alloc_range(&iommu->domain_ida, id, id, GFP_ATOMIC);
>> +	return 0;
>> +}
>> +
>
>Thanks,
>Praan

Sami
