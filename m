Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A54B1993AE
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725279; cv=none; b=OChE8Kp1x59Syps1CvjE/sUMVmVRMuyyjD22H3iPqT7KCSStHTwlAjDWeeAYrSLEMT8vu+9JzNtziJsz6U2gj3z1wYUGfArv7cwlUZFzY+ugmDgOUaTPbYuPyyfBRcKuDI9Y8e44fg53465rWznEuWvb50BasRUUn95xG2JT6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725279; c=relaxed/simple;
	bh=LNzYxv0wLMZeausbdHI3AeTl1UXTVZvJw90aFrQfGOs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wg0Ko4kruTNtozw1bfSCee0/cQkaooIXWXXU+rgyGvV0ukEBFw/iIkITMR1V630qmykyXCu+rPi5OH/eZ2GexJrc+A7Xfhg4CAGeAXuJojbYcLADraAk89lX8vOGtP7IYnBwTcjHOFLLwbjGphgDwyWvCn5UFplXJ2CzEpZXBoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ialtct2k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ialtct2k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723725277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iQURm0VtOkt6tr0AHUSutMukkCnX4LoAIbMGGNruLHw=;
	b=Ialtct2k1DnhcBAgS3CkWQIjFHlaInY4M99k1TPpfE+m4bmjzd1A4Ut+Ji1J9N00TA/FVt
	b9NM6va1Wd8BkV2xStyRUb3DZSxKP7rMhCFi+1onaT/iYZGeGJ3qIkngxrVDbDg3x3/uFw
	1UtIEh9gPn+SjROqJCVWCYY+Hv6XBJI=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-wQbH48-nPBi_MqaRYVgOHA-1; Thu, 15 Aug 2024 08:34:34 -0400
X-MC-Unique: wQbH48-nPBi_MqaRYVgOHA-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81fa58fbeceso92110239f.2
        for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 05:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723725274; x=1724330074;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iQURm0VtOkt6tr0AHUSutMukkCnX4LoAIbMGGNruLHw=;
        b=Sq9hamyzgOwBnI2SpSuVVseFY45ux+2GDbCh83791EXzKf10zZSxVt3K9dhw+aC7EX
         jCRE3i/2+JdJ79YiEASEEYtB1vWpksD+Lgeilc5imsW47t/1p2400dQURnkncWgnCAp2
         7l7UqBZFZapYwWQgaq/WpXNf5xRwnjEOuQ3w0d8unXJk4wZ9eGiFY/AmvtNUIDWr4mSh
         8SfZ4ojEbLwmNZGWMhbwFyQokQFnhPFcpt7Q9zDgt3JpUY38D01MFu3T9B12HiUaINAQ
         3zXIMgno+pWuEZHidvUHW0w12D5w3qvmO4spEpK5RXEugdWixG6g3XsTYEKB8UpL5iZP
         LQ8g==
X-Forwarded-Encrypted: i=1; AJvYcCWeYPUTRIwaBvZo0xMdDWAwoifn3TwXt53VLi82Vo+ptjMG34WBOFmcr0uIcXXtbnK0hr3IL1kvxCaawmVMpZ3y53QeNHE=
X-Gm-Message-State: AOJu0YzTDonRq7ArYwVzujBr0JpMLp7i+dLJuu9yBW4l6yvdx38N3aSB
	kBdow+03+3b76VxMIbi7JMCFXg6HYdrx+nTTpaoDc3O26phELhspGaH8jOUEb7kkx9L4Rlj/kwB
	BvYTP7I0/q4yz8DU3eIRB1q3aZTfJOxvvfGBzeV6Htu/HwNHqAvchptBUQM3a
X-Received: by 2002:a05:6602:341d:b0:7fb:86c:321 with SMTP id ca18e2360f4ac-824dacda406mr656346739f.1.1723725273873;
        Thu, 15 Aug 2024 05:34:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7xdWX0SQil5/xQT2XqCBEZ74QgWSK4v+8FgpuFPpVMSnxNIOsaPiaZEe4CkoAKD7E9J6PkA==
X-Received: by 2002:a05:6602:341d:b0:7fb:86c:321 with SMTP id ca18e2360f4ac-824dacda406mr656344439f.1.1723725273476;
        Thu, 15 Aug 2024 05:34:33 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ccd6e7cea0sm455937173.8.2024.08.15.05.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:34:33 -0700 (PDT)
Date: Thu, 15 Aug 2024 06:34:30 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] iommu/vt-d: Add helper to flush caches for context
 change
Message-ID: <20240815063430.70ac9b00.alex.williamson@redhat.com>
In-Reply-To: <4ff133f3-e541-4a0f-a72c-ce682720e6df@linux.intel.com>
References: <20240702130839.108139-1-baolu.lu@linux.intel.com>
	<20240702130839.108139-7-baolu.lu@linux.intel.com>
	<20240814162726.5efe1a6e.alex.williamson@redhat.com>
	<4ff133f3-e541-4a0f-a72c-ce682720e6df@linux.intel.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 12:47:58 +0800
Baolu Lu <baolu.lu@linux.intel.com> wrote:

> On 2024/8/15 6:27, Alex Williamson wrote:
> > Hi Baolu,  
> 
> Hi Alex,
> 
> > This appears to be non-functional and breaks device assignment...  
> 
> Yes. This is broken. Thanks for pointing it out.
> 
> Perhaps I can fix it by passing domain id to the helper? Something like
> below:

Hi Baolu,

Yes, I did a similar quick fix to prove this was the issue.  Thanks,

Alex

> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 01002ae2a091..b3b295e60626 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1152,7 +1152,7 @@ void cache_tag_flush_range_np(struct dmar_domain 
> *domain, unsigned long start,
> 
>   void intel_context_flush_present(struct device_domain_info *info,
>   				 struct context_entry *context,
> -				 bool affect_domains);
> +				 u16 did, bool affect_domains);
> 
>   #ifdef CONFIG_INTEL_IOMMU_SVM
>   void intel_svm_check(struct intel_iommu *iommu);
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 159da629349c..34006b6e89eb 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1903,6 +1903,7 @@ static void domain_context_clear_one(struct 
> device_domain_info *info, u8 bus, u8
>   {
>   	struct intel_iommu *iommu = info->iommu;
>   	struct context_entry *context;
> +	u16 did;
> 
>   	spin_lock(&iommu->lock);
>   	context = iommu_context_addr(iommu, bus, devfn, 0);
> @@ -1911,10 +1912,11 @@ static void domain_context_clear_one(struct 
> device_domain_info *info, u8 bus, u8
>   		return;
>   	}
> 
> +	did = context_domain_id(context);
>   	context_clear_entry(context);
>   	__iommu_flush_cache(iommu, context, sizeof(*context));
>   	spin_unlock(&iommu->lock);
> -	intel_context_flush_present(info, context, true);
> +	intel_context_flush_present(info, context, did, true);
>   }
> 
>   static int domain_setup_first_level(struct intel_iommu *iommu,
> @@ -4077,6 +4079,7 @@ static int context_flip_pri(struct 
> device_domain_info *info, bool enable)
>   	struct intel_iommu *iommu = info->iommu;
>   	u8 bus = info->bus, devfn = info->devfn;
>   	struct context_entry *context;
> +	u16 did;
> 
>   	spin_lock(&iommu->lock);
>   	if (context_copied(iommu, bus, devfn)) {
> @@ -4089,6 +4092,7 @@ static int context_flip_pri(struct 
> device_domain_info *info, bool enable)
>   		spin_unlock(&iommu->lock);
>   		return -ENODEV;
>   	}
> +	did = context_domain_id(context);
> 
>   	if (enable)
>   		context_set_sm_pre(context);
> @@ -4097,7 +4101,7 @@ static int context_flip_pri(struct 
> device_domain_info *info, bool enable)
> 
>   	if (!ecap_coherent(iommu->ecap))
>   		clflush_cache_range(context, sizeof(*context));
> -	intel_context_flush_present(info, context, true);
> +	intel_context_flush_present(info, context, did, true);
>   	spin_unlock(&iommu->lock);
> 
>   	return 0;
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 5792c817cefa..b51fc268dc84 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -683,6 +683,7 @@ static void device_pasid_table_teardown(struct 
> device *dev, u8 bus, u8 devfn)
>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
>   	struct intel_iommu *iommu = info->iommu;
>   	struct context_entry *context;
> +	u16 did;
> 
>   	spin_lock(&iommu->lock);
>   	context = iommu_context_addr(iommu, bus, devfn, false);
> @@ -691,10 +692,11 @@ static void device_pasid_table_teardown(struct 
> device *dev, u8 bus, u8 devfn)
>   		return;
>   	}
> 
> +	did = context_domain_id(context);
>   	context_clear_entry(context);
>   	__iommu_flush_cache(iommu, context, sizeof(*context));
>   	spin_unlock(&iommu->lock);
> -	intel_context_flush_present(info, context, false);
> +	intel_context_flush_present(info, context, did, false);
>   }
> 
>   static int pci_pasid_table_teardown(struct pci_dev *pdev, u16 alias, 
> void *data)
> @@ -885,10 +887,9 @@ static void __context_flush_dev_iotlb(struct 
> device_domain_info *info)
>    */
>   void intel_context_flush_present(struct device_domain_info *info,
>   				 struct context_entry *context,
> -				 bool flush_domains)
> +				 u16 did, bool flush_domains)
>   {
>   	struct intel_iommu *iommu = info->iommu;
> -	u16 did = context_domain_id(context);
>   	struct pasid_entry *pte;
>   	int i;
> 
> Thanks,
> baolu
> 

