Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE191411DD
	for <iommu@lists.linux.dev>; Mon, 29 Apr 2024 20:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422303; cv=none; b=B90YFqFXrcxd3Fztx0GnB8g580UO3wXR6b2reY7ljpVHUXnCc1Ns+eWL2ZvQU61x+AqMKwcQY12fZg5+vHTFTDXaPNheYbCQ189vbpdxRb42kpsGG+oMLbCOmGwk+8GOJL4/E11gg63nKX5kmSnoF121qyivxPEX6HWm2tw0PU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422303; c=relaxed/simple;
	bh=hGkJQ2hEBOMlcZ1QQLXlHGuMxkhZEnRo9lDvpVvAHME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQeYtHMtEonIK1XPurEDhTOsJ9eVxWZNEgDGUwT4V7223MEuFqVGjxrvdEq31PRQUrVlpHhfrwuS56yIp0/DwqGZj52Wchgh0jmaE3KPQ/DbkRiKMc057C1hUvJiOgYCgZbXXmveU3jotW21QmXie9FggyiT0ed3WsHfZIHOUzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eejoqtNM; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eejoqtNM"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6a06b12027cso54111346d6.0
        for <iommu@lists.linux.dev>; Mon, 29 Apr 2024 13:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714422300; x=1715027100; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U10a+UAKqIg3J4+xTDrbP/nR0140IUjBUmVPbfPeBtU=;
        b=eejoqtNM2DEGzo+xxcc2OQLtaevN/+bhJLqKs1iM2qCOks9u3i8GR3GWB1T7AruStL
         W6qHLiaQf4RE1K/xSRzXFtniPClCYDkpgoC2GnPxP02TxQ61l36waD7KJ4PxT87O3ijd
         P/juwI6QSSGpXhSqSuHLG7DRJa2hguJmDCl9CYgbcZGEZepIryWHN1JoqujtZwpyYhwG
         XdqlIx/ZsneaH0Zv40KS89rCNjU+sNtyPIEN19WnLdDmrat55l8c1Vy0tgnn8K6y9va2
         3B7bhdHfbtfIQNtSRtWwPCCcxFT8ZL3NtTWypXTJJzj/7d/PR8LplReupmTdxDdqShfl
         lEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714422300; x=1715027100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U10a+UAKqIg3J4+xTDrbP/nR0140IUjBUmVPbfPeBtU=;
        b=l8nxnjdupehYtSwrvIRhJ8mcsMqEtc5l172H5RKzBA4HLOvQlk9Zt9POmBr6v/87E0
         F1Tm+J2CJOnj42aGFcp0lxUvKxWdeoQCJu20FquR12iJ+yX7Hyj1CoOsKRPKg/yM6hr5
         A7CnyHnAgPXpqpFWMHQiT93ibOhfDM+u+KNc54G1Mds241RHZ1KIEgZ0MGuZ0ZOs8zwp
         mHIcXM3uGTQXKiSYohAla7LEZidD2qbhNJYUxSFKn45Mox1OT+v/45T4jv4+PA5bT+dM
         GwuvFCSSYz3jxK8ga75b7TlZQNXCNk+W7r3E11DixeIQVSTSjdINKpDoyH1UCMqypAgD
         ketA==
X-Forwarded-Encrypted: i=1; AJvYcCV8M7epv7MQQ57yOqRdDzkFQOUfAqfTLNJxY0j/Mbpbr5+zDpex07Jjyy/dQT5YnsMgaAuLMGq0mock5RTJB7xMpJh81sM=
X-Gm-Message-State: AOJu0YzoGlR1acGW3kf8G3IlbwpNjFl5/S7dj9aew/3Hib1hkokmFqCB
	neVBnLtzrYjvmiwG4FUBheXE3XyprPnCm8KYFrRxQ8Pt5OXz0qW2Yq3wcx1515A=
X-Google-Smtp-Source: AGHT+IF06oYaGQ5jj9Iw6KSync38cZEI2xitY/lo/JDJPZex4PeINFt5C+ktEksqHFLkO2LXKXqFgA==
X-Received: by 2002:a05:6214:170c:b0:6a0:c155:a650 with SMTP id db12-20020a056214170c00b006a0c155a650mr1291314qvb.23.1714422300544;
        Mon, 29 Apr 2024 13:25:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id x8-20020ad44588000000b0069b432df140sm3829579qvu.121.2024.04.29.13.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:25:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s1XYY-002rmm-3g;
	Mon, 29 Apr 2024 17:24:58 -0300
Date: Mon, 29 Apr 2024 17:24:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/9] iommu: Replace sva_iommu with iommu_attach_handle
Message-ID: <20240429202458.GR231144@ziepe.ca>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-3-baolu.lu@linux.intel.com>
 <20240403115913.GC1363414@ziepe.ca>
 <e3f526e3-6474-49ff-b8d6-995aaf1c1830@linux.intel.com>
 <20240408141946.GB223006@ziepe.ca>
 <86e723e7-c3be-41b1-95d8-dbdf86bbdab5@linux.intel.com>
 <20240409234800.GD223006@ziepe.ca>
 <5871aaec-b81a-4ad4-8eb1-656a04d04bda@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5871aaec-b81a-4ad4-8eb1-656a04d04bda@linux.intel.com>

On Sun, Apr 28, 2024 at 06:22:28PM +0800, Baolu Lu wrote:

>         /* A bond already exists, just take a reference`. */
>         handle = iommu_attach_handle_get(group, iommu_mm->pasid);
>         if (handle) {
>                 if (handle->domain->iopf_handler != iommu_sva_iopf_handler)
> {
>                         ret = -EBUSY;
>                         goto out_unlock;
>                 }
> 
>                 refcount_inc(&handle->users);
>                 mutex_unlock(&iommu_sva_lock);
>                 return handle;
>         }
> 
> But it appears that this code is not lock safe. If the domain on the
> PASID is not a SVA domain, the check of "handle->domain->iopf_handler !=
> iommu_sva_iopf_handler" could result in a use-after-free issue as the
> other thread might detach the domain in between the fetch and check
> lines.

For the above you just need to pass in the iommu_sva_iopf_handler as
an argument to attach_handle_get() and have it check it under the
xa_lock.

The whole thing is already protected under the ugly sva_lock.

Ideally it would be protected by the group mutex..

Jason
