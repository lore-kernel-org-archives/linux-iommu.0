Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC316931C
	for <iommu@lists.linux.dev>; Thu,  8 Feb 2024 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383480; cv=none; b=Bh/tff5loSmxA3aD1jVvLMLfHLXpnHMVXupOaIQXrPK0BIsHxMt1PxIXld2jkqvQp0jFzlumgkQYATebRv4Xdb8Uiz1UXlEYj66oN0alaPBZZjcAkgJWRyaDwM+t9FzD2sVMKNKqFnrP/J7eXAnbUzqp4ldRYyjDHhhUWzCcGck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383480; c=relaxed/simple;
	bh=p7M5LRY2IIR3JbhYpi12gul04UVDehtCNBndvFQhT4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QaBYJ7C3Rb37aGPFZwNvqcz6DpAWcpDqVKedSSBmzadpVsAGrp90C4nfdyXoe1+I7iOSIMN26bzBv8gurResz9cTkMyb+J3//hiA19RLt3JKbmu/3lmNSO6wmofIK97mlmzF+lXooxdtIWt3wHFDALgMpAihRIebkpkEwIL/h+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xqwkPnn/; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xqwkPnn/"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-511612e0c57so2699700e87.2
        for <iommu@lists.linux.dev>; Thu, 08 Feb 2024 01:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707383475; x=1707988275; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o6hMNIZUaBRVM7gi8uDMiowpTMxtF27cC2fdkjBJWH8=;
        b=xqwkPnn/NOzRfmKOXiaiQZ7mLPVX7wh1k80/RO22DWBmGwZ7evfhlMdRrwJ8/00+G5
         sr6QOCc+ZQuk4/xgiTVwVVYhdrGU43UKfMQXx8KOz9SiNgi5Zq9e7QkXJoEQ8MhguHZY
         Qip/BmHxbl3ogWQgF64oJF7jSleGURrd6nyUxv3PwXXL3F1xjSG6WSOma7wqZHVZoIgm
         IS8i2sY7zBCxCVlE7KRCWsoJZk3XAYywI4Gnk0ZAwvQ5DfBMSVkqgykZV7A3Reff2xsG
         WyInddL54hgLJQHOwtT/yttIYgb8OMOu60OJq5gPG8zOXsLYXmLOTkTKAbiQqFSdXJIw
         aXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707383475; x=1707988275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6hMNIZUaBRVM7gi8uDMiowpTMxtF27cC2fdkjBJWH8=;
        b=OAHonz1OhQpzuuAMVe/RYl9ZA3q6ky/su7waCyOVc6J/oA0BW5jadQCPGX2DCbVQJJ
         /UxbA7HD/5zqWxIqo2I4t3qOFjDZ8GMmPZA0z4zSqAMSctozKJ1+QJ2THVwEOsL/Xilu
         9PIXrz/j6brvcRB3jFpO30Yqwo3OrYtcS5ZVSmsUBu7UGUA3WEhP1hoHdmaxwX9D6Bej
         idzszs5ALVAxF9H5x9A7nnn+aViOw3Lhm3oLzmpjMqmwfmDVD0u6h+bvD4EbDMhEM9SH
         lMwofo51Dj93xh0yFsPGTzPNPms8/0bWfPCf0Z2Ri1fWYuBV7JHWia3ld5LGEHfwW2xl
         z56g==
X-Forwarded-Encrypted: i=1; AJvYcCU77ZwrXcU+REEG3tyWrgAiOdOouiGHXHWlbJdfsul/AonbpSNfXR8FazEQq4T3F772w6d88CwW3CjGfa0q6cdEJd1kSVE=
X-Gm-Message-State: AOJu0YxS91yuvb/JKpVkPFRckCT+j6uv3u0ZQjuHA7VzwQkp9zBdwgbF
	2yVc0qPvIj/yUCPsn85l+r10PH3htpZA7Z30FItzCuMt+iXDi1htrZ5vhfE/DJ4BpbQiPhbX1fw
	DarZ0tFGj5C+ZVdFK2QPCnrnY3lHuovOwzJkpYQ==
X-Google-Smtp-Source: AGHT+IEdMMmX0qUysZ36JNG6vjjPDWbDnwCkmT8i09RQZO80h9rQ9AXsc+CoHbdB4Czk7n8tQfMWuFQWC0VHbAenhUk=
X-Received: by 2002:ac2:4107:0:b0:511:6d76:4a6 with SMTP id
 b7-20020ac24107000000b005116d7604a6mr980330lfi.49.1707383475362; Thu, 08 Feb
 2024 01:11:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240207013325.95182-1-baolu.lu@linux.intel.com>
In-Reply-To: <20240207013325.95182-1-baolu.lu@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 8 Feb 2024 17:11:04 +0800
Message-ID: <CABQgh9G_KCNjj4TvKzG04cQVPsWn2OCSEd_vK10fBtJtWX4E0Q@mail.gmail.com>
Subject: Re: [PATCH v12 00/16] iommu: Prepare to deliver page faults to user space
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Longfang Liu <liulongfang@huawei.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 09:39, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> When a user-managed page table is attached to an IOMMU, it is necessary
> to deliver IO page faults to user space so that they can be handled
> appropriately. One use case for this is nested translation, which is
> currently being discussed in the mailing list.
>
> I have posted a RFC series [1] that describes the implementation of
> delivering page faults to user space through IOMMUFD. This series has
> received several comments on the IOMMU refactoring, which I am trying to
> address in this series.
>
> The major refactoring includes:
>
> - [PATCH 01 ~ 04] Move include/uapi/linux/iommu.h to
>   include/linux/iommu.h. Remove the unrecoverable fault data definition.
> - [PATCH 05 ~ 06] Remove iommu_[un]register_device_fault_handler().
> - [PATCH 07 ~ 10] Separate SVA and IOPF. Make IOPF a generic page fault
>   handling framework.
> - [PATCH 11 ~ 16] Improve iopf framework.
>
> This is also available at github [2].
>
> [1] https://lore.kernel.org/linux-iommu/20230530053724.232765-1-baolu.lu@linux.intel.com/
> [2] https://github.com/LuBaolu/intel-iommu/commits/preparatory-io-pgfault-delivery-v12
>

Wandering are these patches dropped now,

[PATCH v2 2/6] iommufd: Add iommu page fault uapi data
https://lore.kernel.org/lkml/20231026024930.382898-3-baolu.lu@linux.intel.com/raw

[PATCH v2 4/6] iommufd: Deliver fault messages to user space
https://lore.kernel.org/lkml/20231026024930.382898-5-baolu.lu@linux.intel.com/

And does iouring still be used in user space?

Thanks
