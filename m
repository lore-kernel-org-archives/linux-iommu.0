Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDEC227B88
	for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739522608; cv=none; b=MD4pwWxFw3973sP/RxR/ZUSSTlBe6iguxhg0sp2dGTBJEjKa7+JuyE6LA9GfFeGbrtEihzef0c2g7goWgYQ3ZtriwO0qn8AqaJxz9VKf1RKW+VH8C2TuvOT918glitN8WSON5PwSd9XvkpjhWfq7ll7JaxaP2ejBOn2r/WzaPhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739522608; c=relaxed/simple;
	bh=CXPc3y668anJq9lBRrDv5CYpwtXv7HerEoD7uqDJSrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/CX/bf57T5fEfxxoke7DFS4ywjB3W5lzepa9YI9OQR8vgQuerhWdjkazOST0GEiJ79Grefw+Ev+dbi+0wo16qKdpQpqwfxTIXbSqaiQG6KbQLrMoQ/BOWlmTdrB6MDnk5z0Sp8x7FSliCq2So3wAIfZJtXlbffLUvrQEMPxOJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZYwcIodE; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZYwcIodE"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-545074b88aaso1911106e87.3
        for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 00:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739522604; x=1740127404; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YrGWn46F9945+gUUg8W+kiuyxDl8keZLgoB3N8SvlL8=;
        b=ZYwcIodEDBklG86i8WoKdgkvxaJAwyumJlPHcdQ6jzD8r2gNli72BAqfiNs2R52b5W
         yOWq6H4tRc0A7DZRjsgfWL2jurv9kZ8b8h3X7HSAtB+2nB5oGwRgCznGfkaiWLaUwGsZ
         Sz0vrEBt5Y7qWhGEvyTouT1/cl3f7jHYKaxjYgFBfqzwMQGPvJ6zQkRFLjX66yu/eFCR
         ekDK8klxmkU9yrUlfuOSyQFOkLBXOctaq0HyQdaYOxAOfmsZZ5JT4WaCMd8JfGSHzSLm
         poETDh9jDqhi+bEcYl/m9DQZHHVzbheoEJcGpKBGhRME8gO3ItylciKE3oPkmFmbMOL/
         yeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739522604; x=1740127404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrGWn46F9945+gUUg8W+kiuyxDl8keZLgoB3N8SvlL8=;
        b=FkhCjQTMEGZiq6s5Ez7UOM5Ev7LjOTJEikrSyantyLQfzYMOPGwiRLUID4fSR8+aaC
         CQ5n5j4NIPP66QV1mcApAu7DDFhVo5udrOLCiD61msN7xML/WQbPrUQDxJ4bmeTd/R6I
         6oOzKxTdLr3RVScJAOpcJF6rpDvz8IUBfb3ZRwDxetkFmyzItMvOwZ1G8jWKLbmUYSXN
         nahz8wZcGJnHGsZioBNnUSzu/I1B5OvJvzC3qomQ3peCTiKCtf+2TtmT1hgbP7Lm54CA
         z3Voi2eLl0mJwpYlr3OtKs1Mj1HuuibtPf3GHANdUQvymz3UoVeoT/J0USyFrU8m0Q2+
         jqvw==
X-Forwarded-Encrypted: i=1; AJvYcCWOFu3SeyDIjmrgJ6Gku92my7PRZLi/JoENniWZ5Q2PD38EntabGzw8FgxZ91tw/9wdoweLJw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyhd6gY1srW2lYHGnY0VMBhMAIl0hukFv16Sd9CZ2A1OwV20fFZ
	CptMUm1GwqVgPT76uY07jUNEb5wdGWlzeodPkyO7xO1WgBOmezQ3BOf1ydmCRryOOQGH1MA+vcq
	MQjsP4JhV9V5+nC5LVkCdppsHGb7LBYPJNiOo3Q==
X-Gm-Gg: ASbGncvbsg16ob6Ed+dRN3mV4e1wxEJ4PuzL96Us60tI3DWRKukN30fwRQLCOQj6vi2
	YUilAuqsaUVXE4I11RDpwMrbCHaLGhjKEUPaJNaos0CFFDR6vAqnjSWs6eSKdyJ7MaWru1sa0MM
	gN9A==
X-Google-Smtp-Source: AGHT+IEy54NZS39ARrjg/49nfZ2l3CeZ4lYDsrIyQaSITqrHjX5TvkMyKcPqBEKExLhAOiEB7VqLqCeUMkrmy70IrdI=
X-Received: by 2002:a05:6512:6ce:b0:545:2b68:9360 with SMTP id
 2adb3069b0e04-5452b689407mr281546e87.23.1739522604517; Fri, 14 Feb 2025
 00:43:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
In-Reply-To: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Fri, 14 Feb 2025 16:43:12 +0800
X-Gm-Features: AWEUYZkjQWE-qK49xiiBKEEkxJP-7Ch5gON0NzmMUVyroeED-rVwKmIQ7uLah4I
Message-ID: <CABQgh9FMy7oVt9+enSpJxXvkux+czMFqbsPZVgmBV+rFWWvhGA@mail.gmail.com>
Subject: Re: [PATCH 00/12] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Vinod Koul <vkoul@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi, Baolu

On Fri, 14 Feb 2025 at 14:11, Lu Baolu <baolu.lu@linux.intel.com> wrote:
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
> https://github.com/LuBaolu/intel-iommu/commits/iommu_no_feat-v1

I quickly test this branch

1. host test is OK

2. qemu boot one device, test ok,
though reports this when guest bootup.
vfio-pci xxx: resetting
vfio-pci xxx: reset done

3. qemu boot multi device,  test fails, host kernel reports [Hardware Error]
qemu can boot no problem
Test fails.

Will do more check without these patches.

Thanks
