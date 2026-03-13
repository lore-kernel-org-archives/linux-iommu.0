Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFF1367F5B
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773427699; cv=none; b=d9m8afYgwAzSchR1J16VPqhbAoOjMW3jghw+RsTDVXMKPoc0ZCMLuHzgOtxFLWFsi3QrXQS57gglJfWFS86x35fpUuoUh2tB48OKvVu4/oGo4N2M4bkNUh8m5IWZV6wYxszGEV/8U04yITz8vmu2H07V3u63zaK6ysgC/yfuoZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773427699; c=relaxed/simple;
	bh=bDMn+pND6C8k5z/VxMRY1ADpxIk5K4fL3QB8DYqqNso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwOlsdE/TczE/Ai2DtNGnjEf1xgnVLsNSwAAU/1tFvJZZD8oCk2b6Qnd19IyIl45D3SEgWkvnkplb2L5RU4mM62z2B/V0G24MBtJISlHCpH1goDXJsco/039S5SXAA+AIKGHsJVo+dQpFlhAkFqC748nxP2Urz8yx5hSo6bsGn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=V/HzrUe+; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="V/HzrUe+"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cb4136d865so324583485a.1
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 11:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773427697; x=1774032497; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01fjBoYSqV223rYI33+jsswxHzATZtFRcSWT+x97rj0=;
        b=V/HzrUe+AMR46DpKU7FTvAij6nNhJsggxUi9FRdtc2bBT9R5CvKLYNEgZcOI+k6CEx
         H/VUlAnyfOgPtRPA/PtY2XT/6qXwnkJtnLZ8/AXG/JbDTk52YEXk3A6QC9YfRowIM1BG
         hrokmBm6OyNjp40DmruC87YtzrgxW9wkelNy7etL2ybckjTtqtt6sjQQDlVZHhM+UlfF
         oGNBpewCDV+RQJp53G7rJEjs/bLzKJPcPJVDJ5+DyxHd/YNblgmNuL+U0TPEkAg92a9M
         hWyxuyfLqtuFVCcxMkHSpwWpAqQUISXCEUiKX/eER5LFini+kV9iALlhorjW3HWOBqR6
         JLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773427697; x=1774032497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01fjBoYSqV223rYI33+jsswxHzATZtFRcSWT+x97rj0=;
        b=svfekLG0kfcjnQ/35Ot9pgq0Zv7EJ6j5QLaltKeL/rQBwxfpn1Pf1oXVBzbG/7L39b
         bbvtanTnRuzS4Jd0NTcLromKAcuo0BlfvO/1wk3mrQq+XfMrgtykS+MdKvrUL9X/v2Vu
         tmZFPl5ZTob+ceRFSK9q/+QqXHycPBZdYruPVldaAuK05xo/S7axqj1iV/QzBFhL6mjG
         um51cXhmeNAdsiVub/vLcFNwQko79L34qrdiawXMIuFpHHGfm2YP0vnFs2dPqwLvJ42y
         cazd6I7LXpNOdFEFmCX0/bw8ZsU1/QDDDxQ3jgu9EMcUcFUoEiJncodegeyooANavQaX
         jyqA==
X-Gm-Message-State: AOJu0YxV5mNtSJBwLAfdgD7fW24tQc0R1Au953KBxcdi+dounf91zU+v
	JLt49eGkQ+I3w9t33AMqO15gVOavGtNtMmzeTQK3rYck9CImsRv47hEbTXjOLllPtEs=
X-Gm-Gg: ATEYQzyoIxNMmu7nZHda1bYm1sBgqdG0pcLA/bNW2FXjFmtocOm6gNHFMYh4+F3mJc7
	czUz80Go/e9KXBWREvUuMJDIQAOMKs63JSw9TrIn0o61qMHjxycJeL/Qh+poKUDoCLe0FM8qVV4
	IZA63hwyaRMC9l9fCzsm45++AfK8c9dunuFs0XqYb9IndaJ3JMiIS3RVTOoec7GwROyAuzXV21i
	IHjVW9PCLUofxQkmgDmo1Z2ZbQOn7llPu4Ks34vkJ8073+pxY2iSdjaN4JNMl7F35RIkoq3ze1o
	VujPJI5cuqk1+0o+pdUz3UkqmmpyMzAw7PzNs8zeee0ENzXUZvQL1s9OXtwqSjNy6/nyjb7GRyl
	K68i85HYr4pNSy7Q1nUxBluyBhrQS9H93Q8Oe0XIb9Iid/cqU3eJxHNknJb7uqLl4Xv6SpZ9mMt
	wsGzsQTOCZUy0bY3YvTcvYRVCjGHzEN0OhRQVgP2f+PEpdnOL2XEQP5SLOuRodiwA7nZNIe38p2
	0zNdSYT
X-Received: by 2002:a05:620a:4510:b0:8cd:b52c:5983 with SMTP id af79cd13be357-8cdb5b59a6emr636703785a.42.1773427697122;
        Fri, 13 Mar 2026 11:48:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda212cac1sm715538585a.33.2026.03.13.11.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 11:48:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w17YV-00000007M4R-42dz;
	Fri, 13 Mar 2026 15:48:15 -0300
Date: Fri, 13 Mar 2026 15:48:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 2/3] iommufd/tsm: add vdevice TSM bind/unbind ioctl
Message-ID: <20260313184815.GO1704121@ziepe.ca>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
 <20260309111704.2330479-3-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309111704.2330479-3-aneesh.kumar@kernel.org>

On Mon, Mar 09, 2026 at 04:47:03PM +0530, Aneesh Kumar K.V (Arm) wrote:
> @@ -1174,6 +1175,23 @@ enum iommu_veventq_flag {
>  	IOMMU_VEVENTQ_FLAG_LOST_EVENTS = (1U << 0),
>  };
>  
> +/**
> + * struct iommu_vdevice_tsm_op - ioctl(IOMMU_VDEVICE_TSM_OP)
> + * @size: sizeof(struct iommu_vdevice_tsm_op)
> + * @op: Either TSM_BIND or TSM_UNBIND
> + * @flags: Must be 0
> + * @vdevice_id: Object handle for the vDevice. Returned from IOMMU_VDEVICE_ALLOC
> + */
> +struct iommu_vdevice_tsm_op {
> +	__u32 size;
> +	__u32 op;
> +	__u32 flags;
> +	__u32 vdevice_id;
> +};
> +#define IOMMU_VDEVICE_TSM_OP	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_OP)
> +#define IOMMU_VDEVICE_TSM_BIND		0x1
> +#define IOMMU_VDEVICE_TSM_UNBIND	0x2

use enum for an op, put it before the struct, add kdocs for the enum
members.

Jason
