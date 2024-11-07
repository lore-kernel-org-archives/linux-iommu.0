Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5FB185B5F
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 04:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730954429; cv=none; b=mWEStDlgku8xm2hrnXnLGTv8M1/X2BNb+0pVr1cFBWNZWoPUGwS++srEJasV4Z5QPo+nI12SCFsNKJIeTWlcPZnlQAuqLmMPMghb4N3gOwo3sn4wwKuYgWrvTOnp14iO99rVP8/0pXO4kq2DOwdE8w98zLgEnhRXE4dFIgSE1ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730954429; c=relaxed/simple;
	bh=C8T98Sa2leDE2aVBOiD4LYqi1ctZER7DeoVbj0OUT30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cze+R2W8MTx0TkPHw+QpGNDQPeL+WfRQdLNIfyl3jbxWVB+bZni1DqdUJB++AQgtYdKHNuQQ4ofq6+Ra6tAc28YvhmR3yUtZ3npoJT81IuABvic+DlopoffAFamzhn0HfSql660zT31Ak4rt/ACsLGdCwPFMANuAdHhnaTNSJF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MsSZZ3sS; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MsSZZ3sS"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so724363e87.1
        for <iommu@lists.linux.dev>; Wed, 06 Nov 2024 20:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730954426; x=1731559226; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kS3PhzgV8hPWd3Nz2X4ljMHj7vMg0QaN6Lo6Vk67xTw=;
        b=MsSZZ3sSTFosNNuRB9OBSAQaHkBO6IXM85DMxPgOqUMeMj+80rEUTuSzvMnLLn46ZV
         pgItJVon41PUOLyuJdBJBV3230EdzQs9mUzSIREqjUob4hErfBK7VeARbkh87RJ3tW6W
         JFQK0Yny780Vbij9+b/4/JcRB2OxAGw94GLWmhYWAL8DmlsqDysFjS/aC9605yVF+T8T
         1crF0CFT/iC7kh6VRYMuOwj/ey5pWlan+mkXw4gxbOf9on2N2H2Km3HacETaw/xCpzsu
         9SoNt1SHG6TOAyWfsRdIzI1/lYVxC5rVWX4ZoVMfB+/iye8VXAWIspAQaNjMkezzxZEV
         yhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730954426; x=1731559226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kS3PhzgV8hPWd3Nz2X4ljMHj7vMg0QaN6Lo6Vk67xTw=;
        b=XPdMTK2WGkqztciUOaZUYifhmBqa9B6Y0plIkD/KW1RtJM+Xo9KSMiiYTSREzRzW0v
         GAIGuFvlhvoOdiDufnNoE5EzxWYFFymoWm1z2HyC1g2twqhQoCtZPVhEVwldKBlgz1hP
         dr5U+1zQiZSR72T3pTJj8hFuf1SYPaJMVU1HqX9dZBTGOENHCTTGd3QtxCgMR3mwz48w
         tIvi2obl/H7NLNx79RqRRuAs5p6g8afd/+VzYV/7V72m2WaGi3zPkOmDM/wZZpC2Td1X
         tT8wOOfwZ8NFMQjIMMZiObwTVXVMDu7y1uvwT6IOQzu8BTV/uB8Jd7EUtFYwvj4pg8Fm
         LttQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHj6u0UyjazuOQdfLj0ngdgwORzWvfcDZPLGX0dXYKjnonTfn/VFKDY9DUdxu44E9hvFKjUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywj8VT67oxmGhajGkTTG6J48gkZ0REZjPmw/sWcKN5aY7CSMEL7
	vsk0PO2iNsD1jl/d6BLp4uyjycNXsPo5MTg9+Sjs8rQd3YvnhqjB1ZSZWATnaw8hSqnTgBYxumh
	ZOpt7G26+fHl1RDYElu3DyPRaTe1Wq+aDLg8wJQ==
X-Google-Smtp-Source: AGHT+IE6mu02yFj3cbKRiS8rNaWfTch6NvNc8XHMgEPjm27a3mfwdePPbwFloVV4AAmL3acydHk3/qanmVOZP5ve+pE=
X-Received: by 2002:a05:6512:110e:b0:539:f2f6:c70f with SMTP id
 2adb3069b0e04-53d828e3da4mr206716e87.8.1730954425978; Wed, 06 Nov 2024
 20:40:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241028113209.123-1-zhangfei.gao@linaro.org> <CABQgh9H9HWaKRP=rFvXf90PjfVP1M6YpwfLcYTZH1hWET6GPsw@mail.gmail.com>
 <20241106135944.GP458827@nvidia.com> <fcef9cb1-797a-496a-9ef5-1e2f530dc8f6@linux.intel.com>
In-Reply-To: <fcef9cb1-797a-496a-9ef5-1e2f530dc8f6@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 7 Nov 2024 04:40:15 +0000
Message-ID: <CABQgh9E=AKgN=QqewH+HPyHEk8bYzABnEuj3UiWwpHMYUNFrhg@mail.gmail.com>
Subject: Re: [PATCH] iommufd: modify iommufd_fault_iopf_enable limitation
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	jean-philippe <jean-philippe@linaro.org>, shamiali2008@gmail.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Nov 2024 at 01:52, Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 11/6/24 21:59, Jason Gunthorpe wrote:
> > On Wed, Nov 06, 2024 at 05:47:09AM +0000, Zhangfei Gao wrote:
> >> On Mon, 28 Oct 2024 at 11:32, Zhangfei Gao<zhangfei.gao@linaro.org> wrote:
> >>> iommufd_fault_iopf_enable has limitation to PRI on PCI/SRIOV VFs
> >>> because the PRI might be a shared resource and current iommu
> >>> subsystem is not ready to support enabling/disabling PRI on a VF
> >>> without any impact on others.
> >>>
> >>> However, we have devices that appear as PCI but are actually on the
> >>> AMBA bus. These fake PCI devices have PASID capability, support
> >>> stall as well as SRIOV, so remove the limitation for these devices.
> >>>
> >>> Signed-off-by: Zhangfei Gao<zhangfei.gao@linaro.org>
> >>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> >>> ---
> >>>   drivers/iommu/iommufd/fault.c | 9 +++++++--
> >>>   1 file changed, 7 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> >>> index bca956d496bd..8b3e34250dae 100644
> >>> --- a/drivers/iommu/iommufd/fault.c
> >>> +++ b/drivers/iommu/iommufd/fault.c
> >>> @@ -10,6 +10,7 @@
> >>>   #include <linux/module.h>
> >>>   #include <linux/mutex.h>
> >>>   #include <linux/pci.h>
> >>> +#include <linux/pci-ats.h>
> >>>   #include <linux/poll.h>
> >>>   #include <uapi/linux/iommufd.h>
> >>>
> >>> @@ -27,8 +28,12 @@ static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> >>>           * resource between PF and VFs. There is no coordination for this
> >>>           * shared capability. This waits for a vPRI reset to recover.
> >>>           */
> >>> -       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> >>> -               return -EINVAL;
> >>> +       if (dev_is_pci(dev)) {
> >>> +               struct pci_dev *pdev = to_pci_dev(dev);
> >>> +
> >>> +               if (pdev->is_virtfn && pci_pri_supported(pdev))
> >>> +                       return -EINVAL;
> >>> +       }
> >>>
> >>>          mutex_lock(&idev->iopf_lock);
> >>>          /* Device iopf has already been on. */
> >>>
> >> Hi, Jason
> >>
> >> Would you mind also taking a look at this.
> > Lu? Are you OK with this?
>
> This change looks good to me. But the s-o-b chain would make more sense
> if we can make it like this,
>
> Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Zhangfei Gao<zhangfei.gao@linaro.org>
>
> With this addressed,
>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks Baolu,
Have fixed it.

Thanks
