Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592A1166F32
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 03:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728962389; cv=none; b=gwUIo0ulHpCeT4nCoWUD06G7K/U7CliJe2KlduykHmx6EoZVPUT8puf8+WvpGDuij2kLuqPuKjBpfatO0ItSf1683GYQposbX6itBOX4oBYhVYnGDAtNI3l/UA7ABdyJEAceDJusGF2KYK/+MUKUIN8h8mUrj90cuS9MQAwcASA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728962389; c=relaxed/simple;
	bh=syw8l1KwjEBWtLU1JH5AK1kULW2THayjgvY12VC2Tx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCNR2cuCKanL4Lyh99oZeyt4bAAyvw5rgopKJV9EIAMTB/rycPHlZ5J6VD6ATr8UfOM6l2qOB8yx7NUY3QOx8qG3ryKtobotoYgQWoGdjCMyllY+lzcqtJMZ5Se5AUE1aXX60LMmLlyijUbHk3VqSKHcaMwhFZCmF1BrZa82nTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uc7xy+Pr; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uc7xy+Pr"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539d9fffea1so3630725e87.2
        for <iommu@lists.linux.dev>; Mon, 14 Oct 2024 20:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728962385; x=1729567185; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QZJ30zy3Y9wI3Z0YkhEC9QUrXIWOd4xHS/wNqEUb/eU=;
        b=uc7xy+Prn2LSc/bw6Gho3I1WNSbci3xq3A7SK5kQ0+6jO1aEHMDyOI6rk0MTyIoh/5
         LBw6fPaQkotkKJ9VhN3iZv7+nxdMC9PO/0OBL7PG1+YEWbZ97kSVHnpLofyEV+E++foo
         p+mm9aFXFLSMHRGthyCJNZwhT/A7SJxIQYI1qvxSMAriasAjwmHJ6Fku9UepcnFM7bGA
         lc8Brx4qhleuGXw8f69DGB8gfupAYBMFvlKEY24jWsOjOWtaKUDEvC2IT77br1YQizUL
         2Q+pHyBaCjPkJUMctBzmCX9CShf4SAKobEwJzZHZcgzaEpg929Q8uUKTeNdxlP1mBSPB
         EX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728962385; x=1729567185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZJ30zy3Y9wI3Z0YkhEC9QUrXIWOd4xHS/wNqEUb/eU=;
        b=vk4uoJupYVVeBzRXzHgjVqvqEk9HOf5LqmnHXBHlg8G/H862YJdvVCDWZR3C2pZXTG
         RQ04Ix/yTsNAsUjB3ymABX2v/XCO1zpHJ+RNenf8wKPX8e2wOeeZQUn9Yr+Z57/+abCv
         V47oawn3mDj4FgRJV+dZgnvHJ+SboBfHq9xn/LoX24BWlNAAco9orqhf7NN6zyX8tJ0Z
         0rbF/LGK88qII8fG5XZGdf+KgOVWXm882neLlOhk+ThMCwoBWOPAYkgd+QeeeGnb2LHN
         Zwq8NIJ/iD4GDCNlRbK0aWjzJwmQEZq//apKv8YPOYHa+jjG76eeayuM63ksr5rJiuHh
         3esg==
X-Forwarded-Encrypted: i=1; AJvYcCWqita2Bg1g5S1CTtj94Sgz19IN6uBEUpl2rpr7Vo7UrePuiVTR2NMy2hct6pZrX5EljlVSnA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWuNbEDJ+Jszn8ajrr6XIvhPNwW69ETzMAV+lok++OyiojVzNQ
	l84n8EmX+K+K/JcDRe5dEJzPuvkwPxoHGe2zK2H6RenzNjZ1lWZ8nbAFkwi+rrhdwW5ZngGRira
	lF5xZ3wX++afRYwiYHEhif37JOzcd8jYq9Td5hQ==
X-Google-Smtp-Source: AGHT+IF2l+l9aIjC2cv2bCp01lbBm8QlrtKCARf+AmZ684Kp2buFC5VFNgRnQSqkTeJHMQUtLY2v5L1TykBuAKg0PM4=
X-Received: by 2002:a05:6512:baa:b0:539:e94d:b490 with SMTP id
 2adb3069b0e04-539e94dbcd1mr3817040e87.43.1728962385314; Mon, 14 Oct 2024
 20:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240702063444.105814-1-baolu.lu@linux.intel.com> <20240702063444.105814-8-baolu.lu@linux.intel.com>
In-Reply-To: <20240702063444.105814-8-baolu.lu@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 15 Oct 2024 11:19:33 +0800
Message-ID: <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt attach/detach/replace
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi, Baolu

On Tue, 2 Jul 2024 at 14:39, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> Add iopf-capable hw page table attach/detach/replace helpers. The pointer
> to iommufd_device is stored in the domain attachment handle, so that it
> can be echo'ed back in the iopf_group.
>
> The iopf-capable hw page tables can only be attached to devices that
> support the IOMMU_DEV_FEAT_IOPF feature. On the first attachment of an
> iopf-capable hw_pagetable to the device, the IOPF feature is enabled on
> the device. Similarly, after the last iopf-capable hwpt is detached from
> the device, the IOPF feature is disabled on the device.
>
> The current implementation allows a replacement between iopf-capable and
> non-iopf-capable hw page tables. This matches the nested translation use
> case, where a parent domain is attached by default and can then be
> replaced with a nested user domain with iopf support.
>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h |  41 +++++
>  drivers/iommu/iommufd/device.c          |   7 +-
>  drivers/iommu/iommufd/fault.c           | 190 ++++++++++++++++++++++++
>  3 files changed, 235 insertions(+), 3 deletions(-)
>

> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> index 68ff94671d48..4934ae572638 100644
> --- a/drivers/iommu/iommufd/fault.c
> +++ b/drivers/iommu/iommufd/fault.c
> @@ -8,6 +8,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/iommufd.h>
> +#include <linux/pci.h>
>  #include <linux/poll.h>
>  #include <linux/anon_inodes.h>
>  #include <uapi/linux/iommufd.h>
> @@ -15,6 +16,195 @@
>  #include "../iommu-priv.h"
>  #include "iommufd_private.h"
>
> +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> +{
> +       struct device *dev = idev->dev;
> +       int ret;
> +
> +       /*
> +        * Once we turn on PCI/PRI support for VF, the response failure code
> +        * should not be forwarded to the hardware due to PRI being a shared
> +        * resource between PF and VFs. There is no coordination for this
> +        * shared capability. This waits for a vPRI reset to recover.
> +        */
> +       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> +               return -EINVAL;

I am using the SMMUv3 stall feature, and need to forward this to hardware,
And now I am hacking to comment this check.
Any suggestions?

> +
> +       mutex_lock(&idev->iopf_lock);
> +       /* Device iopf has already been on. */
> +       if (++idev->iopf_enabled > 1) {
> +               mutex_unlock(&idev->iopf_lock);
> +               return 0;
> +       }
> +
> +       ret = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_IOPF);
> +       if (ret)
> +               --idev->iopf_enabled;
> +       mutex_unlock(&idev->iopf_lock);

Also iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_SVA); is required
In thinking how to add it properly.

Thanks
