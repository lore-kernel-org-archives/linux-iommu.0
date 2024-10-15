Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457391C7617
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978362; cv=none; b=iBsP7vdcMNYXfCNwsLIEbG0g3ZiX4uzQtZP3yqgxqfvzfyY1MPU0iT8Y/B2VUkvmQ3AhiKrv8zjeyWmgOm1sA5IgL0hOsYmcUSaag0XxDO2KGrTRHqHrbEAPWf73cbnGKlM4JAzAleDPV28tckY4P2Yc4v/5XNykfhhHiygtuc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978362; c=relaxed/simple;
	bh=vlXtBKVnXfGbKLkE/qDj9i17mSuFZ64HL3fM0HBPdDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eF9QvfReUsebfg5eRgAU9yHYxlJ16yiyOQULAGUxHiCFxV5S9EEO1Yay6OIdzHTq9NZQyRycYR8rXyXbul9HxFtsvq/P7Vg2j1lV+ecwHTx3mqW39m+NYDlVvIF4qOBx2CFFTwzdi83OfeAo7hJyLO3DbigUkigMkBwMxX6hQBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r2Hic5gH; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r2Hic5gH"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so1030395ab.1
        for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 00:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728978360; x=1729583160; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=12pFpxnrbGxJEph57/6mELybsu5UzTUq2TEGUPb5hXs=;
        b=r2Hic5gH0jgELSTacMXo+05Vf2cl9XVQotWQu0474Mep/p/iglBL0+yfiLtYfwL8dm
         JHI0kJw+mhkQrahUa8PAorG2FVkDYHqhvFWzTuQJH7RROdmfXi9cfdPZY+5WlPCxq/2I
         GgP9kzgMcHtlV0DQx25N+G8mXGyGhQMY02e5bXAT06OGqU64jojIiuWPc8PJevnbVqG1
         jqEWB8YU/GCsOB3u8SjsO+WLQ8UFt8MzvQVgnc53oYjOxRFtXqtZLKRB2BHy2jE1t/eH
         eKEi34BXyK2PMkqKRoxiWHokUb8UJBRe3OkkOz8+F3chEuZ7BViGWOBGy/K9SgBgTTvY
         rFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728978360; x=1729583160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12pFpxnrbGxJEph57/6mELybsu5UzTUq2TEGUPb5hXs=;
        b=TP0hVykCqwxo7NXty4IZtr8TyDB1WgI+xgK/usfNDb3OcHY3/COXxjofoD/8t0Pph4
         iUkU7ka3zK+Mb6yqo1A+IIReJ2Sq2w53j2rMd6KhTwXDIRQ8c5pVRnkZGa22NkHOPeBK
         SK48m3ROoOGlaUzYQOkd9QeWDSCGxH4Wa0qiFccnppOU+DbVVx9UrnXlRjH7fQFwATyG
         XH9ektsrq/TUVLJnKiMJm03NN+Vz2DcO6nIBEWRoXEELtjI79fJ5Sn69igqbMZZDnWmr
         X7yPQ/i2qNJ9fxVBE4L8Q/F6TCC5C6zYqw09A5ZBZENCDC36bccELPMLj2q5IIr6TfAo
         Hjsg==
X-Forwarded-Encrypted: i=1; AJvYcCUU5hh6qzfS/H+2pjV1O3xI9Z1MORcjeKvg2qiKc+PqaWVGzX6V3GUp0EuGb+dqQFBOCJvj+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWs38GeeZqV0RpLYoDb1PiRnlglQYUTiFD1w/W4tGeMjbwlamI
	u9wHojXnFrFPiPm6W55JE5eTA8Of2Q5Xoq4CSh1WYWbl/f691SpxpwNN0lqDmU1EWm2z9WYpsEp
	j5tPh
X-Google-Smtp-Source: AGHT+IGwCERemshlQ9IHB/+9DCefPlRwOjvwDRvaGMX9XFXY+6vxh/QCc+0dTnMQeEqWO5nbKdZGUg==
X-Received: by 2002:a05:6e02:b44:b0:3a0:9f85:d768 with SMTP id e9e14a558f8ab-3a3bdd346femr12060435ab.11.1728978360066;
        Tue, 15 Oct 2024 00:46:00 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17fa48cfsm6533885ad.78.2024.10.15.00.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 00:45:59 -0700 (PDT)
Date: Tue, 15 Oct 2024 07:45:50 +0000
From: Pranjal Shrivastava <praan@google.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH RFC 0/2] iommu/arm-smmu-v3: bypass streamid zero on i.MX95
Message-ID: <Zw4drtlAGy-LW7Ov@google.com>
References: <20241015-smmuv3-v1-0-e4b9ed1b5501@nxp.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015-smmuv3-v1-0-e4b9ed1b5501@nxp.com>

Hi Peng,

On Tue, Oct 15, 2024 at 11:14:41AM +0800, Peng Fan (OSS) wrote:
> i.MX95 eDMA3 connects to DSU ACP, supporting dma coherent memory to
> memory operations. However TBU is in the path between eDMA3 and ACP,
> need to bypass the default SID 0 to make eDMA3 work properly.
> 
> I was also thinking to introduce "bypass-sids = <0xA 0xB 0xC ...>" to
> make this reusable for others, but not sure. I could switch to
> "bypass-sids" if you prefer.

Any reason why you can't use the sysfs to change the iommu domain type?
i.e. by using the /sys/kernel/iommu_groups/<iommu_group_number>/type
AFAIK, the arm-smmu-v3 driver allocates one iommu_group per device.

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Peng Fan (2):
>       dt-bindings: iommu: arm,smmu-v3: introduce nxp,imx95-bypass-sid-zero
>       iommu/arm-smmu-v3: Bypass SID0 for NXP i.MX95
> 
>  .../devicetree/bindings/iommu/arm,smmu-v3.yaml        |  4 ++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c           | 19 ++++++++++++++++---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h           |  1 +
>  3 files changed, 21 insertions(+), 3 deletions(-)
> ---
> base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
> change-id: 20241014-smmuv3-120b24bc4659
> 
> Best regards,
> -- 
> Peng Fan <peng.fan@nxp.com>
> 
> 

Thanks,
Pranjal
