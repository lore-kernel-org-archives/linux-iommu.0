Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D0A224891
	for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744788583; cv=none; b=prjVDNgPxTf/CR5O1py0+xus+1xIIiE8RC0JIBQF/L1R1uILDUO04ieDME7euYRsdiElpkLsiFaUZklKOx5pq6rqpZ41ovH0vLTAJA/yGtWGfGTXzyMkrjeAoZJWanGXyC9GbpQTuXa6k+Y8t59R5/lbmMCR2wfmgyLxQ6UK6GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744788583; c=relaxed/simple;
	bh=AxrFm7mECps3NAVYQZ/1AtNj2pO+p+u28rcLP7YnJ6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4VHkGDx58oazg+aP4hMe2nVa08hpIsS5nkSYnhaol/4kmw2aMC5t1fc2GbnLVthkclKxb5yXqk6f52ba+uKi9oBiaGBO0Q9hvPXmXO0L/HvdiY5+441TbCQbsM0bVv5cpE0kWZZeOFEw+pYdy4wncz/E5t9VLgsuZBbB8HBTxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RQ30+gIe; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQ30+gIe"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so7527328e87.2
        for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 00:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744788579; x=1745393379; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AxrFm7mECps3NAVYQZ/1AtNj2pO+p+u28rcLP7YnJ6M=;
        b=RQ30+gIe+GkLlolEpzE0frEYoO25RsSWxAjRZyekNI4ybAZrWddAkh6IfctXo5AQBX
         KYBgyfjc9CU+jfROE8lCqPx9TvEBL/CKsaViLGgZofTYdf+cqOniueRsqsytrBFvRUUt
         iUBv3ha2XCKNQTRYl6agLb4B+mLVklbo0u6b4lAFKz8Cfdl2KO9X5lyrsU9GEXHxhH3o
         Lzp5nDshXLLmynWG9URZHhMG5pz8O2GibzsGjk/KLr21pEZGXZDHVUTqAEbiQngPUNn8
         QCmihicE7GO7ySyhLdIJzegq++fBhG5gNY5Z4EnfvgWYOn/Sig0XSlfjDU0Fhp6/K5ym
         JqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744788579; x=1745393379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxrFm7mECps3NAVYQZ/1AtNj2pO+p+u28rcLP7YnJ6M=;
        b=h4gDZPYKL1a6Ai88V1QYlQe8LzntUTvdeFGiCVUoHvelSwLOXgWyOyaTLdzGv+N4Qx
         YwVkdzd9EvpGlZE0tkX1YjupGDKiI9t0cX6Eqmzw7wc/2Ty6KY/EXYAz0AoByPHTRRKH
         rhCbuWwaR8AX6X7sdmXbb+kKhPgaja8omP8EnyoSUaWGUR9TJWkVtZI3vC8lvBZEJ9lI
         xI2Cl+IYyeKtNTo2EeL4IcSI3z3D/GHLEvolKnCoUVjAxkmUcUmFaknEBrtWdFrkARJU
         T72H8hMauGgXi0ChJlyJIpTUNapb7ay7heuBCA6bIyc4t8DPdcFVCR202azu2+zCRfM1
         slDw==
X-Forwarded-Encrypted: i=1; AJvYcCXo2mQIWoWV2U5doFMjXpSFPtYUZ/0qOHKWw+qD2oQV3OXT9MiUnplYBdjwnNOAPQbmzPXNvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YweClG03XgUajSEACv658KlAAQMUkDUFRSZeLNviXezBXP9wOOq
	xRSiOfZBl/qETjEuSbioRHpWPXA2OTrDpAuF4ll4LoFoU4WQtf336BSa+FMBiblTUCZ3YZeyifY
	MKgYjArIzftT/YRK8PsPxls4eVy0kFpi9GJ6xrg==
X-Gm-Gg: ASbGncum6HYBQ9GWOVtZk5utBz9RCt9IGndcgb1+y3Vpn4CzI8608kTAxwMYlFoeqt8
	yBI8eesWe558j0YoPUpSsw+1tCHcmt+H3E813BueXzXEowptyVrWl7jaafYtZnzxFF7nNL8HD3w
	XYWNlKqqDEOx4ogEMgZgupXTkTm2g=
X-Google-Smtp-Source: AGHT+IGZWFmMw9jMNISg9qXAm/8QxzvIK8y2LFzg8WsosYGLrR2V6y3+hI+Mn7J/kJPCN2eqQC7miGeWstaMkW3JOh0=
X-Received: by 2002:a05:6512:3d94:b0:549:7330:6a5a with SMTP id
 2adb3069b0e04-54d64a9d377mr239109e87.23.1744788579234; Wed, 16 Apr 2025
 00:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
In-Reply-To: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 16 Apr 2025 15:29:27 +0800
X-Gm-Features: ATxdqUGYZ1JRHppABWSGDBuq1ICwAaAqDmGhKvQGJ6wZswlbpffJy7z4MGxxX_w
Message-ID: <CABQgh9HbFOYsVinxr6eY-C-5UACaYeLcX8kU_HG696Wks9wn1Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghuay@nvidia.com>, Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Hi, Baolu

On Thu, 13 Mar 2025 at 13:19, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> The new method for driver fault reporting support relies on the domain
> to specify a iopf_handler. The driver should detect this and setup the
> HW when fault capable domains are attached.
>
> Move SMMUv3 to use this method and have VT-D validate support during
> attach so that all three fault capable drivers have a no-op FEAT_SVA and
> _IOPF. Then remove them.
>
> This was initiated by Jason. I'm following up to remove FEAT_IOPF and
> further clean up.
>
> The whole series is also available at github:
> https://github.com/LuBaolu/intel-iommu/commits/iommu_no_feat-v4
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>

Will you re-spin this patchset, it is not in 6.15-rc.

Thanks
