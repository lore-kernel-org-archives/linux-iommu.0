Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A4B1DD9D3;
	Thu,  7 Aug 2025 08:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754556917; cv=none; b=ZvE6Z2ydwfxNGNZWbP15cWakyvB9XSweAAobUxAiguuMZIXKOKlNtaY9V3HHQ9/CzWwrb6YUkreQ46ITq6NIEyqeKjgQ922qSSSwwUo2GYM07e0BamMS/9AXvR5q/rhThmIkw5Pt3fsHiX6QIpnMuVJSkk5G697uwSsmgIrhyjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754556917; c=relaxed/simple;
	bh=g3yf/dOmHDZXoFZt1DvD8hFyMT82oPqy6hzZZaH9V7Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJIk+Thzg7elQ5zvDpIcRydXQ6chK7olSYrWAeoitQ9dlJAswcC/v5TXOBg0MEcZjfVDZuRiBzClXwRotCOycVYPHD7aVzPfkOz4Y5B2KN0mJKXxdEFukG28AJZ7NeGFfcd8gWHd4mH8Wr4OdwTrCg3ZIaeeT7TZMBrs8JG8jo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIBO4AAu; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIBO4AAu"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b0a2dd3a75so6136391cf.0;
        Thu, 07 Aug 2025 01:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754556914; x=1755161714; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k9a9WhbNCGb8YhrTnVPeyzgeezUvn/b3sTZjZO2U7CY=;
        b=AIBO4AAu8q8TxGpvalFRsf+y5eAMmPAJ4jJNH1ThKI3RzwDm0frYJRdP0wkNYe7v48
         ZFsofYwFObhxYkp0natZS8WFq/h0CrFIvuJw30JDdnoLv7jmGCm13e+CKx78vfCZNXlV
         j7rmH/CituI2ud3eFyh/gCSJIyv+A0d3vBHHpd50DxRSvvBTcc9R99eQ5mRBVCJpncUD
         cBlCyHCw5pH63/gUbT9UkSOowqxFv2o6z6CPN3REPW52GmBMjYjvKKD4/0Z/yUik8Qix
         yRHPsqOWXLI23IMvXNeAK83TIONLhIW2fdJTxtTShm2cwHLlfDISU6Nvbk0/rnBMNYlF
         SBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754556914; x=1755161714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9a9WhbNCGb8YhrTnVPeyzgeezUvn/b3sTZjZO2U7CY=;
        b=Pyx+sJKi6cnIKZ9bm61/yyxLYV6DUw1NNARHS4yiEaWpjLdE7bB6oAGr3osT4ES5wl
         oPpYwKs+gkhMYo9sHkulI0reAxFJTGw2wMFi+Np0IuW3v19G4k1VcYloGNg98/O6zLSX
         xXyE5nL1D8wQNZ3zKtL4TKMNZCem/cCyo3GmJTz8API8mLyceCWtYKfMQDt57Y5F5MWz
         synPaglMADp9xN8puctrNEmyJnIB4mXtuzwEPkpIlHw66fMzzdiNq2lVefv3VHJDlMf6
         zTpnQIpKUIqJqLQKKJJH3FdJDEQgQDzHJEKrykeAmflMET9sWxYcw8iNUIFh2xSf3Nl7
         cDsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+aWysK+2j/Dl8nojQgEKb/g/SS9cMpER7KmURc7U60UCbO9tds2YZDnJMx26V5TICnPzBoJSX0H/ULvE5NCRNxy4Rwg==@lists.linux.dev
X-Gm-Message-State: AOJu0YypNC3+th5v/64uG6uW++cATSOSzzG0foE3r6o3pp8r6RLpq3sU
	PQLrD1eIlhEsSS5IEOL0kmyWVmdvF0buUHFn1MaqESvTeKDNSR2w2HKB
X-Gm-Gg: ASbGncvTXjAz+25ROYGQVGuRhK8W85PZT6pEnVYqrNwXL+VzqC8CSgB/nr7eaO5Hhyh
	2FsWokEo2RzQMSbjJYo+SBQ7zT/iv7j9JiLeY4hyHvXEm/Sw5m40jGbNx1nueqUZC7Lsdg3maSw
	ow44CYkwQZU2ccYj3Xprak6duZg/h31cJ1VefeqdeXnUQ1x0EwggYqhaSn/EAUlC8Cw28PVgr+f
	gegxqm9CdUJJ0CJ1/AdHGcRR1V5yq3B9WYmd5mF+uG+sJDg7sqPD9ZBoms+tFgVZUc4j6bcDDrJ
	8pPZGvhcar25ONm6jOcmQz2kSRx3So9j/sl499LOtQi4+zJPeTzkAHW6rhpJeLGcezOkE3X6mP6
	NzIcKV3LlWjPCqw1PPQ==
X-Google-Smtp-Source: AGHT+IEBoTFn5fp5D0vEnyZRWpmeH5FejQKaRL6voGlP7R6jALLXCFYaUigc7+u+qekvvwXJy/JrZw==
X-Received: by 2002:ac8:59d2:0:b0:4b0:38b2:3808 with SMTP id d75a77b69052e-4b0a1689282mr31711321cf.43.1754556914485;
        Thu, 07 Aug 2025 01:55:14 -0700 (PDT)
Received: from localhost ([142.186.9.88])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b0696a3744sm47901061cf.37.2025.08.07.01.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 01:55:14 -0700 (PDT)
From: Seyediman Seyedarab <imandevel@gmail.com>
X-Google-Original-From: Seyediman Seyedarab <ImanDevel@gmail.com>
Date: Thu, 7 Aug 2025 05:00:00 -0400
To: dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v4] iommu/vt-d: replace snprintf with scnprintf in
 dmar_latency_snapshot()
Message-ID: <h6impubmygtakszk7t6ffknvtje72c4ovknjgme5xletglkl5g@4lpcs22onyqi>
References: <20250731225048.131364-1-ImanDevel@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731225048.131364-1-ImanDevel@gmail.com>

On 25/07/31 06:50PM, Seyediman Seyedarab wrote:
> snprintf() returns the number of bytes that would have been
> written, not the number actually written. Using this for offset
> tracking can cause buffer overruns if truncation occurs.
> 
> Replace snprintf() with scnprintf() to ensure the offset stays
> within bounds.
> 
> Since scnprintf() never returns a negative value, and zero is not
> possible in this context because 'bytes' starts at 0 and 'size - bytes'
> is DEBUG_BUFFER_SIZE in the first call, which is large enough to hold
> the string literals used, the return value is always positive. An integer
> overflow is also completely out of reach here due to the small and fixed
> buffer size. The error check in latency_show_one() is therefore unnecessary.
> Remove it and make dmar_latency_snapshot() return void.
> 
> Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
> ---
> Changes in v4:
> - Removed 'ret' in latency_show_one() since it is not being used anymore:
> https://lore.kernel.org/oe-kbuild-all/202508010632.WB0CM5Bz-lkp@intel.com/
> 
> Changes in v3:
> - Restored return type of dmar_latency_enable() back to 'int'. It was
>   mistakenly changed to 'void' in the previous version.
> 
> Changes in v2:
> - The return type of dmar_latency_snapshot() was changed based on the
>   discussion here:
> https://lore.kernel.org/linux-iommu/aIDN3pvUSG3rN4SW@willie-the-truck/
> 
> 
>  drivers/iommu/intel/debugfs.c | 10 ++--------
>  drivers/iommu/intel/perf.c    | 10 ++++------
>  drivers/iommu/intel/perf.h    |  5 ++---
>  3 files changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
> index affbf4a1558d..65d2f792f0f7 100644
> --- a/drivers/iommu/intel/debugfs.c
> +++ b/drivers/iommu/intel/debugfs.c
> @@ -648,17 +648,11 @@ DEFINE_SHOW_ATTRIBUTE(ir_translation_struct);
>  static void latency_show_one(struct seq_file *m, struct intel_iommu *iommu,
>  			     struct dmar_drhd_unit *drhd)
>  {
> -	int ret;
> -
>  	seq_printf(m, "IOMMU: %s Register Base Address: %llx\n",
>  		   iommu->name, drhd->reg_base_addr);
>  
> -	ret = dmar_latency_snapshot(iommu, debug_buf, DEBUG_BUFFER_SIZE);
> -	if (ret < 0)
> -		seq_puts(m, "Failed to get latency snapshot");
> -	else
> -		seq_puts(m, debug_buf);
> -	seq_puts(m, "\n");
> +	dmar_latency_snapshot(iommu, debug_buf, DEBUG_BUFFER_SIZE);
> +	seq_printf(m, "%s\n", debug_buf);
>  }
>  
>  static int latency_show(struct seq_file *m, void *v)
> diff --git a/drivers/iommu/intel/perf.c b/drivers/iommu/intel/perf.c
> index adc4de6bbd88..dceeadc3ee7c 100644
> --- a/drivers/iommu/intel/perf.c
> +++ b/drivers/iommu/intel/perf.c
> @@ -113,7 +113,7 @@ static char *latency_type_names[] = {
>  	"     svm_prq"
>  };
>  
> -int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
> +void dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
>  {
>  	struct latency_statistic *lstat = iommu->perf_statistic;
>  	unsigned long flags;
> @@ -122,7 +122,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
>  	memset(str, 0, size);
>  
>  	for (i = 0; i < COUNTS_NUM; i++)
> -		bytes += snprintf(str + bytes, size - bytes,
> +		bytes += scnprintf(str + bytes, size - bytes,
>  				  "%s", latency_counter_names[i]);
>  
>  	spin_lock_irqsave(&latency_lock, flags);
> @@ -130,7 +130,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
>  		if (!dmar_latency_enabled(iommu, i))
>  			continue;
>  
> -		bytes += snprintf(str + bytes, size - bytes,
> +		bytes += scnprintf(str + bytes, size - bytes,
>  				  "\n%s", latency_type_names[i]);
>  
>  		for (j = 0; j < COUNTS_NUM; j++) {
> @@ -156,11 +156,9 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
>  				break;
>  			}
>  
> -			bytes += snprintf(str + bytes, size - bytes,
> +			bytes += scnprintf(str + bytes, size - bytes,
>  					  "%12lld", val);
>  		}
>  	}
>  	spin_unlock_irqrestore(&latency_lock, flags);
> -
> -	return bytes;
>  }
> diff --git a/drivers/iommu/intel/perf.h b/drivers/iommu/intel/perf.h
> index df9a36942d64..1d4baad7e852 100644
> --- a/drivers/iommu/intel/perf.h
> +++ b/drivers/iommu/intel/perf.h
> @@ -40,7 +40,7 @@ void dmar_latency_disable(struct intel_iommu *iommu, enum latency_type type);
>  bool dmar_latency_enabled(struct intel_iommu *iommu, enum latency_type type);
>  void dmar_latency_update(struct intel_iommu *iommu, enum latency_type type,
>  			 u64 latency);
> -int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size);
> +void dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size);
>  #else
>  static inline int
>  dmar_latency_enable(struct intel_iommu *iommu, enum latency_type type)
> @@ -64,9 +64,8 @@ dmar_latency_update(struct intel_iommu *iommu, enum latency_type type, u64 laten
>  {
>  }
>  
> -static inline int
> +static inline void
>  dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
>  {
> -	return 0;
>  }
>  #endif /* CONFIG_DMAR_PERF */
> -- 
> 2.50.1
> 

Hi there,

Just following up on this patch. Please let me know if there's
anything else needed from my side.

Regards,
Seyediman
