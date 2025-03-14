Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957B11F03C7
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945704; cv=none; b=IzHZd+zllgtREHuBZ1xMArK93MhasxC6QST83LMqgVR9EZMD2t9QiYaiES6lJgFjJBgrHBqFRQs5saQHCAVvwr7tIy0QcJhnW703FlGD1FiDGQHjYzXTGLvpkodIGCp0uAnuqwOEFA66ebYBmQZ9AZGCTKXI5pDt8S7kvuP39g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945704; c=relaxed/simple;
	bh=ntrXBr+INEaTdjjIuTH+2ThTesvG7vd12dHm2Z44+kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtFN2z6OG13sOVfST9GwchI7xmMxpivz95naQohILTZcN+94+BtTqpwBfDOb7OgDVuU6CoBc06MufRDj5xkalI0RGxdfQ04rIQER5jhQMNNJrMkndlvme3JJo8xgaGKqLF8azrroUZYo/FUrb65hFby21smvX0MoUt3FACBygxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j21qaANG; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j21qaANG"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bfc79ad97so30830601fa.1
        for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 02:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741945701; x=1742550501; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FD6bznsu01iYGcm6ewJe4RuYE462CwiH5xGheRZGZw0=;
        b=j21qaANG5SZdofVddCMVlte/vSk3pJ8KF7udwOTjLH9HZDQNs/7K4Qt1fSMnuw6MGS
         ivUKBLBO/xeIXtQEmn821ZlKybx0WGxTtvg1NMAhdj+7EelXkkDoNbaoJu+n4XbCG0tV
         QD7IlEXB2qJQ/HD871WegsZkj2UnsoiNcTnlGaGu7lf1JtTe+CefocdcY2Rn6dK9oL4Y
         JAGjuj0MqW1nZ6FtjUoOGjMZhMI5lGjp5k+UVRY7eivYPETS9LUiE8BMrJZednd+5d1h
         2lIqS3Ibq8J7JRVCj3sHTk2S8tc0b/OckFLG3pHnlrYShoIAGLP9jOAORGWYUsE7JAQz
         R9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741945701; x=1742550501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FD6bznsu01iYGcm6ewJe4RuYE462CwiH5xGheRZGZw0=;
        b=GOCve4JG0YVYLQ1h+kiAfzQBWB1mtdwKlTWDfJ28U0q2glWPMnVO1ZiTgg4aMEJyWF
         rXCICJ2XfRDFJE4yde4b6AJ6ZCwZNRuT1kIRiWCypFK1OOlWrq0J6pZhfCMokEsWbCq7
         sR+rObgsrDXiWC7lm0PwW19qONDOSlkfYZnEzdm2iHdVbb5sKU+jAXh9I6Ib4G7mc4zb
         idppxh+L10QIAsO1L75dFRpVuhQWNFCQZUxSn7AOl72Zju4Gkt4umAUrJVyM9yqQr1T9
         JDPEPxhdtqzP+gegLq5MhM0z77EyCMPuXETvHqG5a/URo73tI0UHY1qPfxkCjiccHsDq
         vCZg==
X-Forwarded-Encrypted: i=1; AJvYcCV6+gtqUsGgwYcuZEgWv4ugC7QGTl/nsnddYjdOkdnyOTGOThMyos5ki+QbcnqWury7QLedyg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZGRhOOelqRqcOxUTkuxStSOLBLRlcz+cu8ugXhlFaNCqkZ4yy
	wfb6wyyrkhyiCsgvUTVwGKzg7heY2driELCruRzoSqC1I/cIu7Y+kyOQoj2Sve3JfUSr2eMfJUJ
	QIyWTZfv7fSm6cpLYZZJbIKK7OMVdCaSfWR3GGg==
X-Gm-Gg: ASbGncsX1K5mmNL0EriP2t6vjjKQxWOCeW9lMJJXlZ2HBLId7ZvvEA9KRkL05qG8G53
	BB3nSbt0hf5NyKkxI1UERKLzgQaGW2rQaiJdOtYDfNeVobZdWaYfn/WZvJnSkfZy5QM+4Id1O6Z
	s2DIaq1+1d240u/Mqt7+fiQSmfMImjIqo=
X-Google-Smtp-Source: AGHT+IF+BXUJPCiL1c7sbvSs4gfqol1v20qox8jtJslAuMcy8M2YGJF8kQcGGVoAZtCirbS3VlFVKlXtncaYF36CYig=
X-Received: by 2002:a05:6512:ba8:b0:549:7145:5d2d with SMTP id
 2adb3069b0e04-549c3f97f37mr544029e87.16.1741945700612; Fri, 14 Mar 2025
 02:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <SJ1PR11MB61295DE21A1184AEE0786E25B9D22@SJ1PR11MB6129.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB61295DE21A1184AEE0786E25B9D22@SJ1PR11MB6129.namprd11.prod.outlook.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Fri, 14 Mar 2025 17:48:09 +0800
X-Gm-Features: AQ5f1Jp8h2KQrj8cXSVVa65hkY1o46EVlIPZXIQrn2pTPHmKX_laXhYL3waLDDA
Message-ID: <CABQgh9HBqbJYnUqJzG+nOY=B8nQ-8Scy8i0ctszBm8rzpocNFw@mail.gmail.com>
Subject: Re: Regression on linux-next (next-20250312)
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "robin.murphy@arm.com" <robin.murphy@arm.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, 
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Saarinen, Jani" <jani.saarinen@intel.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi, Borah

On Fri, 14 Mar 2025 at 17:18, Borah, Chaitanya Kumar
<chaitanya.kumar.borah@intel.com> wrote:
>
> Hello Robin,
>
> Hope you are doing well. I am Chaitanya from the linux graphics team in Intel.
>
> This mail is regarding a regression we are seeing in our CI runs[1] on linux-next repository.
>
> Since the version next-20250312 [2], we are seeing the following regression
>
> `````````````````````````````````````````````````````````````````````````````````
> <4>[    6.246790] reg-dummy reg-dummy: late IOMMU probe at driver bind, something fishy here!
> <4>[    6.246812] WARNING: CPU: 0 PID: 1 at drivers/iommu/iommu.c:449 __iommu_probe_device+0x140/0x570
> <4>[    6.246822] Modules linked in:
> <4>[    6.246830] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc6-next-20250312-next-20250312-g9fbcd7b32bf7+ #1
> <4>[    6.246838] Hardware name: Intel Corporation Arrow Lake Client Platform/MTL-S UDIMM 2DPC EVCRB, BIOS MTLSFWI1.R00.4400.D85.2410100007 10/10/2024
> <4>[    6.246847] RIP: 0010:__iommu_probe_device+0x140/0x570
> `````````````````````````````````````````````````````````````````````````````````
> Details log can be found in [3].
>
> After bisecting the tree, the following patch [4] seems to be the first "bad" commit
>
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
> commit bcb81ac6ae3c2ef95b44e7b54c3c9522364a245c
> Author: Robin Murphy mailto:robin.murphy@arm.com
> Date:   Fri Feb 28 15:46:33 2025 +0000
>
>     iommu: Get DT/ACPI parsing into the proper probe path
>
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
>
> We also verified that if we revert the patch the issue is not seen.
>
> Could you please check why the patch causes this regression and provide a fix if necessary?

I just send one fix caused by this patch
Just FYI

[PATCH] PCI: declare quirk_huawei_pcie_sva as FIXUP_HEADER

"bcb81ac6ae3c iommu: Get DT/ACPI parsing into the proper probe path"
changes arm_smmu_probe_device sequence.

From
pci_bus_add_device(virtfn)
-> pci_fixup_device(pci_fixup_final, dev)
-> arm_smmu_probe_device

To
pci_device_add(virtfn, virtfn->bus)
-> pci_fixup_device(pci_fixup_header, dev)
-> arm_smmu_probe_device

So declare the fixup as pci_fixup_header to take effect
before arm_smmu_probe_device.

If your system has fixup, it may need a change '
from
DECLARE_PCI_FIXUP_FINAL
to
DECLARE_PCI_FIXUP_HEADER

Thanks


>
> Thank you.
>
> Regards
>
> Chaitanya
>
> [1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
> [2] https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250312
> [3] https://intel-gfx-ci.01.org/tree/linux-next/next-20250312/bat-arls-6/boot0.txt
> [4] https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250312&id=bcb81ac6ae3c2ef95b44e7b54c3c9522364a245c
>
>
