Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987D32C80
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 05:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730872044; cv=none; b=FhZ7GeJBZ9EiJZfRXUC8wFpI3QZ4Nm1W312AJh/OMEVKuqn6F/WDiMVL5rboczTu3vL2OJ3igqiTwJTCiexkfrHcqX74sm8RHApqbpVPVjVa9RhHK2a0biSz1Jxxf7FQ7/rAxSWhCWiw/AXuFm/9HxZjI8+4QgJ3v5EtydY3Qak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730872044; c=relaxed/simple;
	bh=dYSK4OvUsOnyLQSwnFtsKalpN2mQMKz+nYSsrdB416E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWjsVMgOss0vCc3EDlwJAz3o/Y7DymzpHbEEQtXjI9rcyU7U8bs34XxWRo1puoKRvyVZBtOKOlZ6NWkjZ+xxYdPd+uY5QlR+275kFzLK6iAgS/pBti75qLrd/QTdpzNd18iAc+CFtUZm0WOky8+1zrdNfG3hHu2cIYcKpVvs+nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QD3ygSqx; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QD3ygSqx"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e59dadebso7726957e87.0
        for <iommu@lists.linux.dev>; Tue, 05 Nov 2024 21:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730872041; x=1731476841; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4wlFtruNqQoercRi+1WD7cjSp20+NvrYGVk9jN7SiPQ=;
        b=QD3ygSqxbFMld8BAHGPgGKyF79IiJbGIrB9ufKszy4QDPYLIQnqSo4DBjGZDGRK8lx
         S+W9a36TfG8C5Ybp/Gj39XSHceoXhtaKT4YTBc9v00Xwvdx9q98oDmjsRC1YTbDhkHwR
         oSyL8hOUamSARJyPSwAdGkUrHgNbA7GKvOhZTpq/sh8Fjia08PQdzjm4HDmeg8DcrMQI
         WDpDn62YyiQl7Pj0NRxEL88nMHcLcl1T/v+K7u6I73EpNEa+KWwx16drG0wswmRrW/7Z
         YhNoEPHW2dacvAQ2ZiHK3rT859QQ3zsPZp5/lY+CRSXF/ETMSR682xv2SEKAMctPKcTa
         ViPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730872041; x=1731476841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wlFtruNqQoercRi+1WD7cjSp20+NvrYGVk9jN7SiPQ=;
        b=TwmEVNCr7YdaBZI8RyPjwzz130jzxqH1vw8Z+z8V7VDpU3MtQ0ZdwRLbXlV9YKFyeP
         T5XbWOMHLDsOa97T3Jb3KLhS0rdTRlGtoxJu7js2YzYBCrcdI+jUE006SVkwNyQ46vrC
         mnNN6umtejJNCuG6ul3AvN++1FeVepim81AwYd59qoVkjNAw1srwquhQLMeMV6zdsp/8
         FNsx6k5Q5h2b201YUBT1kiVK1nDXZVVXx4fha1/Dj29WVvxLduCGBhv1yl2Udf+7Y2eB
         ROzfO4iLok5OxGQ6D1LlqREW4D4em3jftj04+4WKnKZy60NUh02JCKuSYF3b7y/eYeok
         pbkA==
X-Gm-Message-State: AOJu0Yxcrtc3J8wdz2Zf28ScmBFUKVpdHw3fa0q1hXTuCvK0Kz1eU1Su
	ixQm0tk8zJCDwOZNTJDAfsV0uBHQ8JcO+61tDY8F45eQj9qrXRpJWWzY7UVSl/grZzbvHd/xuh2
	oc8ioC2FnjdPtfPp2ZFeJMZ79KQYUguzw+rS0kQ==
X-Google-Smtp-Source: AGHT+IEnLs5oHn+wd5p8lCC2M2Tssn5RakwYm8btDcDudbYQW7dLKT6AmkZYIPaEtOX+HUdGXJaNRoHMRaMkwx6uano=
X-Received: by 2002:a05:6512:3f0c:b0:53b:1369:fcf8 with SMTP id
 2adb3069b0e04-53b348f96e8mr19139399e87.15.1730872040707; Tue, 05 Nov 2024
 21:47:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241028113209.123-1-zhangfei.gao@linaro.org>
In-Reply-To: <20241028113209.123-1-zhangfei.gao@linaro.org>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 6 Nov 2024 05:47:09 +0000
Message-ID: <CABQgh9H9HWaKRP=rFvXf90PjfVP1M6YpwfLcYTZH1hWET6GPsw@mail.gmail.com>
Subject: Re: [PATCH] iommufd: modify iommufd_fault_iopf_enable limitation
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	jean-philippe <jean-philippe@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, baolu.lu@linux.intel.com, 
	shamiali2008@gmail.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Oct 2024 at 11:32, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> iommufd_fault_iopf_enable has limitation to PRI on PCI/SRIOV VFs
> because the PRI might be a shared resource and current iommu
> subsystem is not ready to support enabling/disabling PRI on a VF
> without any impact on others.
>
> However, we have devices that appear as PCI but are actually on the
> AMBA bus. These fake PCI devices have PASID capability, support
> stall as well as SRIOV, so remove the limitation for these devices.
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/fault.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> index bca956d496bd..8b3e34250dae 100644
> --- a/drivers/iommu/iommufd/fault.c
> +++ b/drivers/iommu/iommufd/fault.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/pci.h>
> +#include <linux/pci-ats.h>
>  #include <linux/poll.h>
>  #include <uapi/linux/iommufd.h>
>
> @@ -27,8 +28,12 @@ static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
>          * resource between PF and VFs. There is no coordination for this
>          * shared capability. This waits for a vPRI reset to recover.
>          */
> -       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> -               return -EINVAL;
> +       if (dev_is_pci(dev)) {
> +               struct pci_dev *pdev = to_pci_dev(dev);
> +
> +               if (pdev->is_virtfn && pci_pri_supported(pdev))
> +                       return -EINVAL;
> +       }
>
>         mutex_lock(&idev->iopf_lock);
>         /* Device iopf has already been on. */
> --
> 2.25.1
>

Hi, Jason

Would you mind also taking a look at this.

Thanks
