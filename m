Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4318201265
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189165; cv=none; b=M60lC7d9lk0CmgayU3UHufMH/3me3aV4LAY1rMUbmapV6tMBVwsEzJj2aaBQPjTatTp7/mhEV+9z/qp1Bf82yw3RjlFWoxMtsGZRGMhAu7Yey1XvI0wqBBa7PppuShcis7dRgDk6m2CNPRC6TmgNxgSSFEWTk7F6aL0pmVxCV40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189165; c=relaxed/simple;
	bh=ewE5C91VqIEclE8EE6eSORF2urCUiFplqwhKVbQgjUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5l86HLtla1gHKaNKHoITqKk8hiRZTuzTVFgWC2qKUfvj+RPcRLpur2J6ZoBOEpCNxRuUPUw4GvaW6502ZEoeFKQAcQoGW8LYSbMMP2hrfp1Mkr4YeXICGiVeQocgzy6H5y3jhbCaAGfUivvAkAkjvod0nrRQl1Eyj6nN6UJbmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g7VVvisd; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g7VVvisd"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f1292a9bso5985306e87.2
        for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 01:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730189162; x=1730793962; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpKc/KqpX5HtlgfK6Baua5GTCTYuIvnrrTfwnIfrUok=;
        b=g7VVvisdyRjD8FdJx4Hp1I8NL8YoA6x7OP6DqUyPNY7Gfpjp05WMpedQWZxQSMGRNG
         e+bO4rf6yzfunsmHeeD52tsdiML0Ee4FE8Le8y1C+IpKmTxKknjnr1TxGRKT9Dnri+YY
         RW2uJfQYDz+rg6nmxZSAv6iwJseHJ8B0/uD94sRJEKucCpr4pKe8+3rQcmSZm58VoJf0
         Zl2Ohv/ARFTfuemc0KcZLqlu+Ws8mNUQqcEXNiJEjNr5wtpsG/LdyTvZBQkzQuCm/Iq3
         TFM+92Xu++FFuwjlQSfR5pNGB+Ve6ZNjQjd/huZX/htFJ9khrdN2RNVhqlLRy6icmS2B
         35xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730189162; x=1730793962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpKc/KqpX5HtlgfK6Baua5GTCTYuIvnrrTfwnIfrUok=;
        b=FQQTIRhpRwtekK0nwiZ9U0TppcOUfwg7T9CzpiAoOVLoLZWP0LYxUJXs7DW60dWgUE
         UBH7buKzZFEkQdyOkIylJCCO4TWmqeUfAVJ6AphB6TUSr3FG66etK2zBOFbjypQxiFF2
         583KDTWigRUbvKMFfQI+VE3zn1cWj7ty+2SL/RM6EhOh8nbrssuXK8EnYjeo/B3lNflM
         zpSYCcFeyl7Kru3UEk/FUzdHyzdUnDtqVBFqv9sSoT9PFzEpNlf0q+jI281UpLrR4/IN
         MIHUowynCPflQxQBrW5fEHWLxcf+ye6q0LjP/KayhME3b4fxecn4x0e/JRdaqUUogbnC
         55jw==
X-Forwarded-Encrypted: i=1; AJvYcCXvGlNyV94YSf3gfAlZ6f1/sJz8+2fi9+wxqDBJvb88BAYjjVK9FTqeGXt6D5Bza7EPIbRTvg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkHmOgeO1Dkk0EV4rB/JhbBJ1YbZLloJclCnnxvjkSNF33knSt
	2zmJcyH3rvAUJiqD+LwuWdPfjZ3SploxizZbq0CACBmyM02VmSZxFQyXolnmimpXuNcAYURjHuJ
	aXbUSe6W8jQAEuLlYVguESH5mlZ+MzuZUOrhXBw==
X-Google-Smtp-Source: AGHT+IFdMeju8u+bLvoWRylkETprLuQWVbYwdSt0OlbdfpFshotvbQALRsmdDmsdtxr9Bkka0/GgKYmryi5IgB6xkZk=
X-Received: by 2002:a05:6512:39ce:b0:539:fc86:ce38 with SMTP id
 2adb3069b0e04-53b34c35b65mr4163098e87.60.1730189161784; Tue, 29 Oct 2024
 01:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231024135109.73787-1-joao.m.martins@oracle.com>
 <CABQgh9HN4VnL04EbadWh9cQf+YpTzvscvXBdHY8nte6CW8RVvg@mail.gmail.com> <b7f79653-4bfd-42f6-a641-479d2973190f@intel.com>
In-Reply-To: <b7f79653-4bfd-42f6-a641-479d2973190f@intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 29 Oct 2024 16:05:50 +0800
Message-ID: <CABQgh9H8LJstiwDon3=e2uMruVwCS9AyGutcct6WyMODSo5=AA@mail.gmail.com>
Subject: Re: [PATCH v6 00/18] IOMMUFD Dirty Tracking
To: Yi Liu <yi.l.liu@intel.com>
Cc: Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Yi Y Sun <yi.y.sun@intel.com>, Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, 
	Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Oct 2024 at 10:48, Yi Liu <yi.l.liu@intel.com> wrote:
>
> On 2024/10/29 10:35, Zhangfei Gao wrote:
> > VFIO migration is not supported in kernel
>
> do you have a vfio-pci-xxx driver that suits your device? Looks
> like your case failed when checking the VFIO_DEVICE_FEATURE_GET |
> VFIO_DEVICE_FEATURE_MIGRATION via VFIO_DEVICE_FEATURE.

Thanks Yi for the guidance.

Yes,
ioctl VFIO_DEVICE_FEATURE  with VFIO_DEVICE_FEATURE_MIGRATION fails.
Since
if (!device->mig_ops)
    return -ENOTTY;

Now drivers/vfio/pci/vfio_pci.c is used, without mig_ops.
Looks like I have to use other devices like
drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c, still in check.

Thanks Yi.
