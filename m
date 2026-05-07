Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB88D33A9E9
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 19:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778183580; cv=none; b=gnczwAPUiXtM1cKIXkmuhzmaYQUvG1O+oLWQ51x7895sHTnFompH9tzAnruEo4LK7AucXG8o7sXgmy17F2piYu7lPLRGZSiOQ7doREAZhRMJIovMcSYARErlscKGdp7bLuz92XZP95GryMKRK0o2viE+oHK69QcP2L9vOHtbloE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778183580; c=relaxed/simple;
	bh=m5WrwJrwUPjUGvBzSD52ltgiX6XfTNVaKEDLCoj+VR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOkf2qeM/WxYcJasokDbJ2SYzLElDRmP0hgx2MnzRKak5CEctzlRwhop4Z7t60EnVa+Rk6N810Ysn75Y2GiWAYicV4AcqrcFKjVHowx+F6+TPrT/YqZBCQH+aXS6Uuisr5Z/U1SZLxJx+x0UJPZD2gXMyNX75/rQI89aJ5WaIzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HbSGq9tG; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HbSGq9tG"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50d864c23bdso16081cf.1
        for <iommu@lists.linux.dev>; Thu, 07 May 2026 12:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778183578; x=1778788378; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UXxlxipshsFnd98Nkncaq6s+XN4axxGz1vRo0Xze8nc=;
        b=HbSGq9tGxRkmq9C+4PtCoUM821RdvcdGLiHjzc1hhjR8gKkKSPbzWcNwufPpfhzmJt
         +0jDkFltSJszLjtfkbdvWBpZ9oRpEKdKA8bg7KltLr3xA52j36+0f33FaL/JubzOtUnA
         wFdRTF1Clcpd4G/MHuvPXffjdQ8kul5nlu4a3ISujMEGY/Pglmfzb/1nhE2PVSMqqpNq
         CU1Er+N8C7qDXFUqQ13B9cvnsl5F+xU/G7MGTUF7tmca6xZX3byShIFBNz++iVZx4NoQ
         iU9PfyzptQhGUOnTI3uTirkXLmp5LShGnLsgwsOn4UcLMCZhXRp2rhtN3SWo7/FyZ7NV
         8OUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778183578; x=1778788378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXxlxipshsFnd98Nkncaq6s+XN4axxGz1vRo0Xze8nc=;
        b=Yku37F1c8xdFl4bSxEsM9BS62L+luMaZdsyRm3asXLOa0mVp6U3RGRKKgjivcjhVJ8
         7imUyGuTidsTUaza2MQQ7oPGPZY1QZz4L/BGjxY4l9ey/i61iZHfx96GKIxu0RgFvxKS
         v1s44iumt1yGyVyf0LDm1C3kn44QQI2+FxFn28NYqqGHlmI7dTsjnqZaUItcJkrF2c5W
         L2ytvUo8D/r4UVdBm5FRpztkq+O+ybIrrrhoqXD/xmVk9TVln9HzLD4NV7rF5rm/bHsO
         KgVbeZ9PxOgL0NDB8Za/dtfdjQoY+Z79i3OkEBYBZKWXpPHwEfGcSB/4B+EdKttL9Nvx
         erBg==
X-Forwarded-Encrypted: i=1; AFNElJ9/GBXRw3blXqaLZ2Jl7NHYSUc4Ztaz1D8jnyRrXLYJfxLD7cWuDK3Di4wXlfglHk7Q3Em/TQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsKrVodbBRRoZF8R6OOLno9sgO/mmlD1mYJtAtTfl9YEmY0a4F
	3tmOJDtxDnUB9STSRkVwnRGXKNKrZ4IXlSnujssiYRaJFQEAkOGZrrCwo0qzzgmPlw==
X-Gm-Gg: AeBDieto2uBd62UVYRCxI1Hv3jQi/WXJU8C/U5AAZD2JtobFmjvfQ87tn6Tx0uPhI7x
	y02MKkjMVPYX7Q7FBixJJ2rZQiQkygesM5n5M/EsiF3Lr4LnUIViFF5gQLnqN78mVmfkKfO2x0p
	UG4aQDKm146tBA8RYS3Lb8k5WpZODt3j7CdeLqNMaD66kk9RkvaXf4kRyDC0MauOXAiJ4TeyO5K
	Z9Sgo3RJKhppGSal/YdIJ96KJaLRQDk8SZvoEC8tKjQ7FB2T6YZyFPhPjggmp8oAV8dNBr+4lB+
	MfzgFXBSQuiKeJNGdfvMleXGa6ARTJopYJEMWELz3Ujvo7NRrZqkXiZulV/FIGF09P6hMuLU9ms
	zSbRanPRunWBYe0SYZKpBEBtLadZCVAkA1fUNZjQ8x/aSVjdKTCf90P7eaPgFgHKkKMTY4WEav5
	xMS2emDY8XbFcuRA+J18XoAYCz0pxetQaCg0QAJbgzymWAuFi/z33Z0SY406g/d8H96+ys5eHO5
	KP9WUA=
X-Received: by 2002:ac8:614b:0:10b0:50f:ce97:3b84 with SMTP id d75a77b69052e-51487e39150mr2421751cf.6.1778183577126;
        Thu, 07 May 2026 12:52:57 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc29a80069sm2298791985a.15.2026.05.07.12.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 12:52:56 -0700 (PDT)
Date: Thu, 7 May 2026 19:52:49 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Yigit Oguz <yigitogu@amazon.de>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	baolu.lu@linux.intel.com, dwmw2@infradead.org,
	suravee.suthikulpanit@amd.com, jgg@ziepe.ca, nicolinc@nvidia.com,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Lilit Janpoladyan <lilitj@amazon.com>
Subject: Re: [PATCH 3/3] iommu/amd: Add vendor:device ID to AMD IOMMU event
 logs
Message-ID: <afztkdvuWFn-42Pr@google.com>
References: <20260506150541.60467-1-yigitogu@amazon.de>
 <20260506150541.60467-4-yigitogu@amazon.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506150541.60467-4-yigitogu@amazon.de>

On Wed, May 06, 2026 at 03:05:39PM +0000, Yigit Oguz wrote:
> Add amd_iommu_devid_str() helper that formats PCI device identity as
> SSSS:BB:DD.F VVVV:DDDD by looking up the pci_dev via
> pci_get_domain_bus_and_slot. Falls back to SSSS:BB:DD.F when the
> device is not found.
> 
> Before:
>   AMD-Vi: Event logged [IO_PAGE_FAULT device=0000:41:00.0 domain=0x000a
>   	address=0xe0000000 flags=0x0020]
> 
> After:
>   AMD-Vi: Event logged [IO_PAGE_FAULT device=0000:41:00.0 8086:1533 domain=0x000a
>   	address=0xe0000000 flags=0x0020]
> 
> Signed-off-by: Yigit Oguz <yigitogu@amazon.de>
> Signed-off-by: Lilit Janpoladyan <lilitj@amazon.com>
> Assisted-by: Claude:claude-4.6-opus
> ---
>  drivers/iommu/amd/iommu.c | 94 ++++++++++++++++++++++++---------------
>  1 file changed, 58 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 01171361f9bc..441b4a7e85d5 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -779,11 +779,34 @@ static void dump_command(unsigned long phys_addr)
>  		pr_err("CMD[%d]: %08x\n", i, cmd->data[i]);
>  }
>  
> +#define AMD_IOMMU_DEVID_SIZE	48
> +
> +static void amd_iommu_devid_str(struct amd_iommu *iommu, u16 devid, char *buf,
> +				size_t size)
> +{
> +	struct pci_dev *pdev;
> +
> +	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id,
> +					   PCI_BUS_NUM(devid), devid & 0xff);
> +	if (pdev) {
> +		snprintf(buf, size, "%04x:%02x:%02x.%x %04x:%04x",
> +			 iommu->pci_seg->id, PCI_BUS_NUM(devid),
> +			 PCI_SLOT(devid), PCI_FUNC(devid),
> +			 pdev->vendor, pdev->device);
> +		pci_dev_put(pdev);

From a quick glance it looks like we call this in bottom halves, which
looks fine.

> +	} else {
> +		snprintf(buf, size, "%04x:%02x:%02x.%x",
> +			 iommu->pci_seg->id, PCI_BUS_NUM(devid),
> +			 PCI_SLOT(devid), PCI_FUNC(devid));
> +	}
> +}
> +
>  static void amd_iommu_report_rmp_hw_error(struct amd_iommu *iommu, volatile u32 *event)
>  {
>  	struct iommu_dev_data *dev_data = NULL;
>  	int devid, vmg_tag, flags;
>  	struct pci_dev *pdev;
> +	char devid_str[AMD_IOMMU_DEVID_SIZE];
>  	u64 spa;
>  
>  	devid   = (event[0] >> EVENT_DEVID_SHIFT) & EVENT_DEVID_MASK;
> @@ -796,15 +819,16 @@ static void amd_iommu_report_rmp_hw_error(struct amd_iommu *iommu, volatile u32
>  	if (pdev)
>  		dev_data = dev_iommu_priv_get(&pdev->dev);
>  
> +	amd_iommu_devid_str(iommu, devid, devid_str, sizeof(devid_str));

Will this iterate the global pci dev list for EVERY event? I'm wondering
if we could improve that somehow?

[------------- >8 ---------------]

Thanks,
Praan
