Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E9418FDA5
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109411; cv=none; b=qBPthtW+T74sqaQVC4XF+Nbsyi7EM66PdpzMgZiNOtIRXBa1bfMtBIlzT/YSVlirf6sUmK/vJBzopcBhIRsa3ml/5YpOPex30X+OIJkadXLgIhhm8TMx9gavHSIakHqGQqax5G/ba5uXxu46JeiQkptTrnpe5KuJC+GJMFTpf3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109411; c=relaxed/simple;
	bh=RiH6D3l1BYetcyeHc3NgSPwEUIKjfMpkQxy3ymImDug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBTXsNH1bCMGA0mziD6k4k9i1tVTlhP7vzKCR8Dhuut7EnGqfug4/uvyha8SJXuN1T8sDhshMeDonQwF5LJfb/b0vyPjQCaFP3kzah0aP3mIKUMVmZaGwxj74mytoGmSO/K+0qytCn4/KB8i769D+9D+kSZzDs6ZsnkBuY/MAUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ldQccpXR; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldQccpXR"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f8490856so3676411e87.2
        for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 02:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730109405; x=1730714205; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P8zwHHVlFDhC3eCYRjgzIufh+8Duk97Oi3BDhNd/SH0=;
        b=ldQccpXRlxqcJEa+IKv8mgAlFEKR46WWJXFPcR0FJhw4JFTBbaq9GqVu3zponmUNem
         EBXs6agShrEnFSwc3GR/0kFRwghO0/RTrJdgTqnLPCIA5If2kXYBG+nLMxRwEm4SphTU
         Yq1MnUONs260Zixb6tPh/i9vcyv9ywqTNL6fgA9d7wanbHNdh9P8p7qmrbdOUStgtJrc
         SC9NkYI1uKOV+jYf2cAB3M3Fs3AyLed8vRm/l9SPRbKnJ3Lgmmhb0349fFyDP5R9uhzJ
         ImEhl+zqNxW77A3z7sU1vt7Jez+CxmEGuNJBELbIBvLbJE9xemK0xXtmMa3r4fV1qWnp
         AA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730109405; x=1730714205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P8zwHHVlFDhC3eCYRjgzIufh+8Duk97Oi3BDhNd/SH0=;
        b=S+dJuKCkjyzW/FtmjC4jXeWPGgwAO4YXK27RbStwX0X+1h7kbHNDhQga9CW532bLOJ
         U1t9JiE9j+ef8SbJM7CfcH2L2Q4oCCqJu7s8hJzSPdm/ioDvGHEC0LJkOQYrnf8OTxP2
         9kBr4Z36j3mekO36Riuwo2k8KDqRrT5w3jDJ9qJr3dodeUC8Fz+50+foAGjbjDrZPtQF
         1gdfT801QuN46k4putjrJJP6h/Pp1oh31cQw1hFIjKfpTFp+kgH7E4iarIIBebnle1Vw
         dvsPOhv9qrCNCPqW9OgCtdKhqVBQ6DUoehCBfK/z7Cy/ajSTnJtKByeQy4DVdoPXz1U5
         0wrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpFQRQsRi3KTuqr9Vxwumg9id9YSPgIt0UqvxlUr23fOWC14VOasReAswpo0mV2UPADRuWGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyufW18Izltm8Y+ZDWwfvpK1Xpwqsva93ElIsv0ufIwH6KQTolK
	iWQLvyStLO4k5cldn9oJc5LExKDwIFEhP3m1N7CB1OwO5+Q5k102QfxmhMBZYX3rjcO3PThgoUX
	j2poz2E8VTJRCI27nS5cNIpoLTa0MCAYobvu4HA==
X-Google-Smtp-Source: AGHT+IGPJlmP5++H8GZgIolANUUnQm/hil6sECZXrtRl0gMOO8zCL/uGJFkEPpBWQMpVap1I8eF1RQlMPNEQCKQkew0=
X-Received: by 2002:a05:6512:2304:b0:53a:aea:a9e1 with SMTP id
 2adb3069b0e04-53b34a1afd9mr3531208e87.54.1730109405411; Mon, 28 Oct 2024
 02:56:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com> <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca> <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca> <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>
 <20241017120518.GI4020792@ziepe.ca> <CABQgh9EnEqDKkxg3VUgjSqBzz27h8B3Ct4w=A0vR6JK=d7fXHQ@mail.gmail.com>
 <20241017130805.GA926121@ziepe.ca> <f218230c-ae01-4168-b36e-5e502de6b3db@linux.intel.com>
 <CABQgh9GU4xp=7Svs_Ni=bvNKECKKUjHgq4d-FjT5Y_4wu44kDA@mail.gmail.com>
 <CABQgh9HYDRVOYtL=jgc4CqX0XhNmCtBDOCm8S6_mgBzBtZVk7Q@mail.gmail.com> <e030bf31-330c-4734-be13-634174c7b099@linux.intel.com>
In-Reply-To: <e030bf31-330c-4734-be13-634174c7b099@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 28 Oct 2024 17:56:28 +0800
Message-ID: <CABQgh9EQjEpHLn76g0Fdu7L6PwmYbiJxuPT-OSPKo7SrN7dAgQ@mail.gmail.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt attach/detach/replace
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 27 Oct 2024 at 22:26, Baolu Lu <baolu.lu@linux.intel.com> wrote:

>
> Can you please make this change a formal patch by yourself? As I don't
> have hardware in hand, I'm not confident to accurately describe the
> requirement or verify the new version during the upstream process.
>

OK, how about this one

Subject: [PATCH] iommufd: modify iommufd_fault_iopf_enable limitation

iommufd_fault_iopf_enable has limitation to PRI on PCI/SRIOV VFs
because the PRI might be a shared resource and current iommu
subsystem is not ready to support enabling/disabling PRI on a VF
without any impact on others.

However, we have devices that appear as PCI but are actually on the
AMBA bus. These fake PCI devices have PASID capability, support
stall as well as SRIOV, so remove the limitation for these devices.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/fault.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index bca956d496bd..8b3e34250dae 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/pci-ats.h>
 #include <linux/poll.h>
 #include <uapi/linux/iommufd.h>

@@ -27,8 +28,12 @@ static int iommufd_fault_iopf_enable(struct
iommufd_device *idev)
         * resource between PF and VFs. There is no coordination for this
         * shared capability. This waits for a vPRI reset to recover.
         */
-       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
-               return -EINVAL;
+       if (dev_is_pci(dev)) {
+               struct pci_dev *pdev = to_pci_dev(dev);
+
+               if (pdev->is_virtfn && pci_pri_supported(pdev))
+                       return -EINVAL;
+       }

        mutex_lock(&idev->iopf_lock);
        /* Device iopf has already been on. */
--

2.25.1
