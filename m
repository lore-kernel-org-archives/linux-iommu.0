Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C61474CC;
	Sat,  5 Apr 2025 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743873334; cv=none; b=m2v0Md0qMj4zdIUR+DlS6HZLBJOoLj2LfCLMjUXRn8o/+0vCIY/nEDTD24WQCmgqZGj97k2LeBR4ixLylgVzuzQzYhsS3kUJjzUtCvnVgcku7IzL9HuOQ4lrs1JEcDk0r95J8qKLVlr3+qGOTjl9vRpjdrAmEAFijokK3Nd5baI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743873334; c=relaxed/simple;
	bh=b1IqaERcyii5vqNUAnyn0nLI0QHoRvGF/a+UIVRdmCo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=Zjp0zfotyztV0N2tiztSmvMGBHbil76bL1Pgecdlqt/vEOUcIVCS/f7pa2jjtavBIF3V1YlmQSvTs83+GvHgEbV1aNmE/KzhvUxoIeOhDrp6SD8HoPHFbdcfCcGu5wMyB3GqqHdzSCm1Qk2QWmvvcS+gTzYogCSnReqvapzyT3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONFBmOPH; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONFBmOPH"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e6167d0536so5452306a12.1;
        Sat, 05 Apr 2025 10:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743873331; x=1744478131; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isSd+kZScL6eZdRBnkO9dSwf+mmMPraP1IggRwVj8UY=;
        b=ONFBmOPHehRxKWLRmBj+amzk8ukfizooVslzWIC4adFcTqgHhIaqJlsUVMVhUar5dV
         F6ltexH4IPFeknKjqUdwojw5qoI2pYnOaX/h23Fg+pfmVg8zlE9FziG5/sVvI+Vb0P4x
         +D4FijWJMJ0G/evuOFA4ZO0W681r1OZZuRRQ7G4SuIMzjr4poRBzGVX+sCaiNjspnRdm
         F85eeQ6QeprKoU8om33iPh4W1cDfYTywZhoXSSBm2lUERHdHNrpj/YdgEBmrAKTETNb3
         7BLv2qo01sdurlpETFivY3BmksZzdZWbXTTE4U7zVuNyYLxu7mg2OU/b268v1rcrATI9
         +YAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743873331; x=1744478131;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=isSd+kZScL6eZdRBnkO9dSwf+mmMPraP1IggRwVj8UY=;
        b=ZZSa2kraLfCWgkryIi/+f/45kr9mKafyBaKt8SQ5jAj0AtGB4rwQgvXK7y9EoPXSiZ
         TPNjqEGtMDn8L3d0nLI3P02p/baEggk6AyPivLmRKIAa92TmWHmOylfyHiLx63yyPndU
         xJiV08HoG+I7anLvR3nszCZ5d8KQmKMQSe6JmEyOFJs2IQFPS3ddrLABpB4n3wP/apCi
         jt8nGsiClbu3wOa18pQ76MO+sm2qZ6i4lLzZsdAMRI4B8/umDxBwVgGaDOqpL/UkJ547
         ePJET2SVUs1x8tkpwHDKWj+rsidqIXUYVUbtDJTKAMmwuXtootCYv3PjpWzMhYDgK8YY
         dNyg==
X-Forwarded-Encrypted: i=1; AJvYcCU+Pon2xiT1HiSl/uD9pORBv+9q4BUm7MnWdaNZE6c098Jxmr7oaYcuZFn+kwBBLgDYkv3rsTKbguv3UQ==@lists.linux.dev, AJvYcCWiRxrYHeAxxl3IJA+HH7VC5spj/035n947LyIZ0hT6G90E6ItZI0AX7vpn6uPX/f3URGGvjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfXLJq5JBODsm/AvFXPXmMUiYRFSNxuzpJVYF8wmYZG0vAxjrl
	9CLJJmSAerq4jLWb7uAxn62eyQ+Mb/oFoKHcokPI5zL5vSprPFg1
X-Gm-Gg: ASbGncviG8wLwq3dpyroopByQ0wSDMCZln5lLONMfWuHFEjetP8lgsZss5zMcoZ6I2s
	63xDOc8IUx6JBNKaeHG51nLhohuGuRRVgl4Z2Qkjd0eiAyEpALLo9g9QiGvV1NJ5cqR9E0/h4Od
	itOfL3ACJW3xCM/9bqLU5W79Ng+1FXzgne1neyQjKtXh4Bn1JmkHtpYlb6bWzhfafVvL1M4FoZB
	wZV2xw1i7SjMSEkxrLk3pY66Lime6RQUGplStvmaUXzMd9Bv4wAUVA15QWS+AqVn8EPQnUJ+eh5
	mBGau1CRVchR5S6ECB2JhPpah/m+nqpPI/wUJ5X6fxxrX6mH6Qly8O2/CnKgekjD4Gmpi3s4Llp
	3hJAfKsi7OAWLMa6fbEq1nZFFlA==
X-Google-Smtp-Source: AGHT+IEYMEj6vVipafSJra5qktqhabiYJ6Afca6i+XiA9t0i2eFoS2ovVKnUzZgGlq8Rm6N1mlmmsg==
X-Received: by 2002:a05:6402:358b:b0:5ec:cba6:7d82 with SMTP id 4fb4d7f45d1cf-5f0b3b5ff1cmr7092924a12.3.1743873331349;
        Sat, 05 Apr 2025 10:15:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:5d29:f42d:f4b6:62bc:3e10:c9d4? ([2001:b07:5d29:f42d:f4b6:62bc:3e10:c9d4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f088085e3esm3913147a12.58.2025.04.05.10.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 10:15:31 -0700 (PDT)
Message-ID: <33e608d18c12fda45c922bc06ae9a49c2b3d777a.camel@gmail.com>
Subject: Re: [RFC PATCH v2 16/22] coco/tsm: Add tsm-guest module
From: Francesco Lavra <francescolavra.fl@gmail.com>
To: aik@amd.com
Cc: Jonathan.Cameron@huawei.com, aneesh.kumar@kernel.org,
 ashish.kalra@amd.com,  baolu.lu@linux.intel.com, bhelgaas@google.com,
 dan.j.williams@intel.com,  dionnaglaze@google.com, hch@lst.de,
 iommu@lists.linux.dev, jgg@ziepe.ca,  joao.m.martins@oracle.com,
 joro@8bytes.org, kevin.tian@intel.com,  kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-coco@lists.linux.dev, 
 linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org, lukas@wunner.de, 
 michael.roth@amd.com, nicolinc@nvidia.com, nikunj@amd.com,
 pbonzini@redhat.com,  robin.murphy@arm.com, seanjc@google.com,
 steven.sistare@oracle.com,  suravee.suthikulpanit@amd.com,
 suzuki.poulose@arm.com, thomas.lendacky@amd.com,  vasant.hegde@amd.com,
 x86@kernel.org, yi.l.liu@intel.com, yilun.xu@linux.intel.com, 
 zhiw@nvidia.com
Date: Sat, 05 Apr 2025 19:15:28 +0200
In-Reply-To: <20250218111017.491719-17-aik@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On 2025-02-18 at 11:10, Alexey Kardashevskiy wrote:
> diff --git a/drivers/virt/coco/guest/tsm-guest.c
> b/drivers/virt/coco/guest/tsm-guest.c
> new file mode 100644
> index 000000000000..d3be089308e0
> --- /dev/null
> +++ b/drivers/virt/coco/guest/tsm-guest.c
> @@ -0,0 +1,291 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/module.h>
> +#include <linux/tsm.h>
> +
> +#define DRIVER_VERSION	"0.1"
> +#define DRIVER_AUTHOR	"aik@amd.com"
> +#define DRIVER_DESC	"TSM guest library"
> +
> +struct tsm_guest_subsys {
> +	struct tsm_subsys base;
> +	struct tsm_vm_ops *ops;
> +	void *private_data;
> +	struct notifier_block notifier;
> +};
> +
> +static int tsm_tdi_measurements_locked(struct tsm_dev *tdev)
> +{
> +	struct tsm_guest_subsys *gsubsys =3D (struct tsm_guest_subsys
> *) tdev->tsm;
> +	struct tsm_tdi_status tstmp =3D { 0 };
> +	struct tsm_tdi *tdi =3D tsm_tdi_get(tdev->physdev);
> +
> +	if (!tdi)
> +		return -EFAULT;
> +
> +	return gsubsys->ops->tdi_status(tdi, gsubsys->private_data,
> &tstmp);

Missing call to tsm_tdi_put().
