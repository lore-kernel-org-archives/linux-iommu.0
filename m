Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867E515A843
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938322; cv=none; b=o3AvIkHbTFq2MbgRbkPl9BkXoGnwUThG39yIzOtHtUJQoZqKgpAbKHUsBHFRZ9UKPACgG+qaEcEk+Vv9gz6eR2WQQVnRdZBStdLfkfy5kb593guYTOTtbluAjwwIAcyfDlI4kcvjhtGVE3QFQOcXo3cPLOy4aHjjmRsIeTVMIdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938322; c=relaxed/simple;
	bh=4IXglGr9l4VCVBfr5iiKmffF4j+cQVeZIofcjJ0pYyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RiBoR8XjG9WS3yOFJK01RBn668vMCgCEaRmaPbq0ff3Zit0qE4Ik4ayZRQBF3KN/zdBj5nn6/4zncYVYgsxXKFrYsaeUR+bJmbSVaIz4ZH+EzqQoZfWqC3Iw7b7s1vmQn/t4SgL3Yt5Ye15O+O34V3W00/616r+HNYi2S3+QBpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aCXnZBUP; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCXnZBUP"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-549644ae382so2045882e87.1
        for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 00:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741938318; x=1742543118; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IXglGr9l4VCVBfr5iiKmffF4j+cQVeZIofcjJ0pYyE=;
        b=aCXnZBUPFMx2bDUjq+xIfAVKAwGU3fRcbTclt+1kgvTLyPk+cl7BnwkwmrQhrQnJFM
         +0VF2I5NNfRoZifJaWeY47m7lWrtrfauE6KUSEWiQka3QjJTZZ3Ivm5Qku3ZsoyjC5SH
         wnSEj21l2W/scZYXou3+IqGm29gt01blRVKK4TLGg44+hJ4FFoeC0pkM27GcHIXBRefh
         tzbOgxMqAdpaHpXn+FsX/ZsAEX50149IIkfyVfOJ/JFI/bA5g+whk8WUn+tXKJtgVCYQ
         d3AVOh+0MzEq8nVYuk4uWyZnbO55MKUuD/kZxjcNSwbweBlPh+T8B0ZIN4UBmMZGYBTy
         sAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741938318; x=1742543118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IXglGr9l4VCVBfr5iiKmffF4j+cQVeZIofcjJ0pYyE=;
        b=cGp5j9u6gEBAvYxkkeLjOHUYXR4gPVQw0U+oQRxbigOjlr1MxBRU9sNkovpTODq51t
         RsbQlQLtNMdKf22YawlbZ9EVf1VVl/yw9fOZD07BvZK2nmWwj8rebEHJVlUHENHaHawT
         bxAj+GOFq2VhU2KznqZYDFKKapLyOGPiMDb5Fe10ZAIDOKBI1EjUKDgQ7Jj+Dk3gXf5L
         //VF8NeHvu57+cYrqKJX9rgkoxiQ6KB7flZlZ8Tl4tZdQUv5eS9sttaF0JHNzfAYl6RB
         r5wPsZzm3l+VwAqBUrMWwUEInNmG1g3PCKjHxyTZsq85kYATXx7v/FpXVNh7UvgHEnwK
         420A==
X-Forwarded-Encrypted: i=1; AJvYcCXOFAvDZPWetienJPTR8aEFfP619+FDdY3SpT7zJvirwL5TvKvgNj8sfwnf8ch/KfEClKFlwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcdoEpc1/VrNepO/M0bel7oMYmmNmeEvW1034tcjl6ooROos+y
	hnpl2OmHy5CgUgFDSI7g5ooY+EX3Qhj48Cv+wDz2EiMMyi+0zNk4vEoMTILF3bd9eyo71b3m30P
	0Qd+/5LzQUBI0kx4+O/pqDGu9j/c+LPhy+SwrKA==
X-Gm-Gg: ASbGncu8o7qNN5LSpYfDNoqFxb0EJ8Xxvb8kpa+fvuEeDu5y+KjSqDEqijaKGW4Y7CU
	eldApW0wuko0OQB/Egsz4CuwJ9vAJ8b2VsSVrDRJlq7y075+DkTOWBlgQqJGS3ZO9q8LpbdocFf
	5lh63Goo1kD727MQlBYzKB0IjscL1RICc=
X-Google-Smtp-Source: AGHT+IHn9sxin8VaKK5Gnmxxh46mS3jxTVpqeyGrlH8i+3MPWyEHFXgWyizzd4dtTn/AxPVdShyaidKbX1JVoYTvpIY=
X-Received: by 2002:a05:6512:400c:b0:549:6759:3979 with SMTP id
 2adb3069b0e04-549c391013fmr491228e87.18.1741938318560; Fri, 14 Mar 2025
 00:45:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250314071058.6713-1-zhangfei.gao@linaro.org> <20250314074243.GA234496@rocinante>
In-Reply-To: <20250314074243.GA234496@rocinante>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Fri, 14 Mar 2025 15:45:07 +0800
X-Gm-Features: AQ5f1Jo1hzhKnUZ6-hglECj56zUmrT2BhqIMFCuupN6B6C346gBVJ_JE-yDZvlk
Message-ID: <CABQgh9FfdetW8n5q19KBo1JhhST_+T8fF+gFM3Siq7o7UyHkBA@mail.gmail.com>
Subject: Re: [PATCH] PCI: declare quirk_huawei_pcie_sva as FIXUP_HEADER
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Mar 2025 at 15:42, Krzysztof Wilczy=C5=84ski <kw@linux.com> wrot=
e:
>
> Hello,
>
> > "bcb81ac6ae3c iommu: Get DT/ACPI parsing into the proper probe path"
> > changes arm_smmu_probe_device sequence.
> >
> > From
> > pci_bus_add_device(virtfn)
> > -> pci_fixup_device(pci_fixup_final, dev)
> > -> arm_smmu_probe_device
> >
> > To
> > pci_device_add(virtfn, virtfn->bus)
> > -> pci_fixup_device(pci_fixup_header, dev)
> > -> arm_smmu_probe_device
> >
> > So declare the fixup as pci_fixup_header to take effect
> > before arm_smmu_probe_device.
>
> Applied to quirks, thank you!

Thanks Krzysztof
