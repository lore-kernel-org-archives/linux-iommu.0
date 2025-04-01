Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B701F0E5F
	for <iommu@lists.linux.dev>; Tue,  1 Apr 2025 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743503725; cv=none; b=SjC1GEI+rnUGOzY7vlqdrzbh2kjNcTWRozzOJ3EMfdElZMs446SL2KPI/zniRbrmNO3pepgdCsadyifskYw/WbnpOK/N/9rd7Q6sTSpOHkZZ/u7tgpiRCy6UrAfgf/XvaRGO3Js7gw47hwdULzifYlCMwoop6ldJK7WO5fpeuEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743503725; c=relaxed/simple;
	bh=bB0Q88NaQ1z3A+sAKvbKfweAcqrwjXi0SB3rHqKzM6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3PJ1d0BUa+Lz8XUvK9cXqcFol3ky59q4EGwfRUugC/KGIXP7UeTRJPu8Tn5eSF2ajvcXStMhbfbFCxXi8nmDJ+LqBF/Pf9Dh/Cg2eRlGH4OanChZP/SQkLwDCWh+e9nNo8E/LZhSx+louNrI0UuFasI5idY020xqvYihFm8QYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S7KduqAL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S7KduqAL"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso24938895e9.3
        for <iommu@lists.linux.dev>; Tue, 01 Apr 2025 03:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743503722; x=1744108522; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=094SZ9fz+o6eVY5ZaePMpljZ6ZXESAEN9w/PXff7gsU=;
        b=S7KduqALguK4NWtjIOmz25qBDMhw4iAKyDMh8EFLnbGHKJ7yykeoVeFeTk3RQ6f5kl
         3GtyRhrJvXd+AqKv6yBoR/UTrA+HhQfV1r5i/kcUijGj5Br4857L0x5CssQlRXqiGuqm
         mSi3WPFAmRnLZGm31z0vKs7J8wMdxujLE+IrQkLgN3P/GS6tQaUH8HrL28oyq+BQpitm
         8NGkT5dlA3LmeLIaY1gnU20sn9oRJw9EGGemtpEQU6F80lUegrDZZXeGvTQOnnpAOi41
         oVFkbiNu8F6F5+6CkGfrJxkdN+6wchHu1QHuE9HRMgW1erbmC0Pppb/rZ4m6TC3E/ds5
         QC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743503722; x=1744108522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=094SZ9fz+o6eVY5ZaePMpljZ6ZXESAEN9w/PXff7gsU=;
        b=UOPh1AUUwT8xYDe7fuvyrUSWainNhd0x20jhgQ74SmkR1IHVGMFnPYkCDYGoJr2FcY
         ySZPzGx/TbC3CN3//Zt8iYH/0LlQvfOOAV0Q4fDcHLdV0FR+PsWc+leWXYV7RuT+dCV9
         Wcwe9AxJuzafVlqSPy7/2XrkTc9057TOdydYErdt49i2/IfnJ4QYfMmNqSEx92sgeK2Q
         KwvN9w3LUhcJY46RqBwybnQiR3UFYF4FQ/Tmq0ZYL0dcsq1uZMh52Y+H5qDRnN7z1rrW
         a/ppGE9cbGyJowYUPc1Q/1R53R2lHf5T7nuHP/+d09M6sIK8a0pM4nmOtSBA8z92ncU9
         Oogg==
X-Gm-Message-State: AOJu0YxTecSIUl6C8oE9R56mO2MqqeTJILEfFADL36EYxa9oUp2ZVSd9
	NFPqzOlkeaemE/j39Gy+rGDWvXMFumhc47bxe26lVgCljSX9h/mMfmMUrXrVlDE=
X-Gm-Gg: ASbGncuVsfU3o6yARCp1orXn2vKvmwmEG1Wo1E4keC2CD2LJmbNEYOdh/aH/gUN+STK
	1ICqniOmLoUUDnEt1SFjM2RKlB/4iOF97n9J0+7iRvL7TmvWbvbGba+UMF7LCnJjq0FHt/DcixY
	bI8pcRqDGV3xKRprnZ2zGadlTAKzGIkYqh4JaXH427KyrdTikW89LTMVfOk0wTqSvDVN/qQv3EF
	w2NcsmQjnF4EdHw3RL4RMX/TYHm00HrRcQrwaAVZ81B1j3Xr7J4z4xSIY/ZaxBcDm67wTlc1D+y
	6r2k5vKrTlMrLGBAhdpudVzB64DCq/8VSKqiMV0UlvE=
X-Google-Smtp-Source: AGHT+IH0MYFlI+kNZ16n6YuowDwZDpAgl0lcpbfUtl1S5hYwQqcUs9sspCA+WvoevEZPVnDHgpx5gw==
X-Received: by 2002:a05:600c:4e87:b0:43d:8ea:8d80 with SMTP id 5b1f17b1804b1-43db61d5fd2mr102696825e9.5.1743503721639;
        Tue, 01 Apr 2025 03:35:21 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b658c87sm13912049f8f.9.2025.04.01.03.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 03:35:21 -0700 (PDT)
Date: Tue, 1 Apr 2025 11:35:19 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: iommu@lists.linux.dev, David Woodhouse <dwmw2@infradead.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Rob Clark <robdclark@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
	virtualization@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-tegra@vger.kernel.org, pierrick.bouvier@linaro.org
Subject: Re: RFC iommutests_: Testing software for everything IOMMU
Message-ID: <20250401103519.GC2424925@myrica>
References: <5zoh5r6eovbpijic22htkqik6mvyfbma5w7kjzcpz7kgbjufd2@yw6ymwy2a54s>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5zoh5r6eovbpijic22htkqik6mvyfbma5w7kjzcpz7kgbjufd2@yw6ymwy2a54s>

On Fri, Mar 28, 2025 at 10:11:13AM +0100, Joel Granados wrote:
> Custom qemu device: pci-ats-testdev
> -------------------------------------
> To support IOMMU testing under qemu, the pci-ats-testdev [10]
> (different from pci-testdev [11]) was used to emulate DMA transactions.
> It is a full fledged pci device capable of executing emulated DMA
> accesses. It was originally intended to test Linux kernel interactions
> with devices that had a working Address Translation Cache (ATC) but can
> become a platform capable of testing anything PCI/IOMMU related if
> needed.

Yes please!  Maybe "pcie-testdev" rather than "pci-ats-testdev"?  There
are other PCIe features that are poorly tested at the moment, for example
PASID and PRI. The programming model of devices that actually implement
those can get too complex so we need something simpler to precisely stress
the IOMMU driver infrastructure. Driver unit-tests alone aren't good
enough for exercising TLB invalidation (DMA after removing a mapping must
crash), tricky cleanup paths (eg. killing a process bound to a device
that's issuing page requests), runtime PM, MSIs etc. I'm guessing testing
newer/future features like TDISP would also benefit from a simple device.

Some time back I needed a device like that to reproduce some tricky races
but never got round to implementing extra PCIe features. Although this one
[1] is based on virtio any programming interface should work as long as it
can instruct the device to send precise DMA transactions, ideally many in
parallel.

Thanks,
Jean

[1] https://jpbrucker.net/git/linux/log/?h=virtio-dmatest/latest
    https://jpbrucker.net/git/qemu/log/?h=virtio-dmatest/latest
