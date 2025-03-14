Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E645815350B
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 07:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938168; cv=none; b=MeLxa6BzZ/ERJNb6spUsVSGFs7eMyEkgrin2JbwJTpJfiGiuo9bJ5fQNCenFqFIECJFc26phgzmMutdQGzI/BoOkbTfxB/9u+5F7/h6uZhoZ8S7qnIF7jMg49Dcj1JGKCKPazcXffPolYkG56doPsuX3Vacsr+jyTn7LYCVc4Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938168; c=relaxed/simple;
	bh=GegKs5cB6rEP5RXjACoaxSKxCsPA+a5CEkUU45D6q88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUXyxKCfANKpTmkHJV/uZ4A1spAZKaSmUMt2W4qeFyn4LF0q2Cw+9R4A+0wS5QdLr6w1GAsagC13XBMVBFLEMFMJsnkRVqU1VNATGWVvxN65MjDItnat0mn10nFnS9EIzthaMjwhjrSebJd9IxCz8YwTGXVE/ajrD46gqrUNNqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-225b5448519so33534365ad.0
        for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 00:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741938166; x=1742542966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRgjO2BIUZBSivLl6NeuN4w5VSf79WUc7xlXdm/Meg4=;
        b=S8OvspUYruuDayTuJMpAMWUQ85BbX7oXYjXAw7RDA9/M8oVIx4C6Wo7zTiuO5wWjc1
         P2aVWkJgYaABWHfcBHCN2vdtS+ZPhp7JUCD6veOaKHmVLSSEdcgmhs/c4gLNhOzw2hXi
         mcUb0hB4Dle07wwTr98H1GnEl4cS4yr+z6qIoEiljSDEn0uRBK9UYp/O+Jfn0t45qlc2
         enQRGOjqV8mtNxOdC9M1kDQp0E81AGhPbOAJQVOJEWQlUW+PwP95c72T1gYRhl+zcU8T
         hNU0uRjPIuyh6/S2Bwa30PDKuSm1n5mkOWoMvfztE/viI4JrT0MK87WN9DyUD+QHF36o
         h2Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWyWmwU3RQidYXdgZX03oVywPBIs+nAPa+yYAH0xHLHFpBnOwFFyVrqBpdTgy8jTA+qN70NmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJeU5EubpqaTrQvzfG++6pVHkYitTZVSRWWuRlBYuLBnYe1xjl
	g3TJ5hUqJ4/MZWNkOvfG41MvBVAN3waWjIcd/h81rE1B3x27k4MO
X-Gm-Gg: ASbGncvLyGGkDsEzqKX5INN//znUMBqYahszEpqrk7fbY9DOn/IwDqt7eE5Iu+wYNIx
	V/WoSppHTfNqXeZjF0c4B1Bd9CNx16klj/H1UkuPcfOKhn65xI7ISb3wpfomu+UkfAjMiBrRvqm
	PR10TmSNPaQojFqlor0LEl5UpXsicjlwzFeySMWcajM13WWvEi+qm4AGEsDSg67Mp6B0p/o/2XS
	CKBie8HfxuBfz6gUs7f1yHfxpcfiQtaWJ1TKl8WD+0Gw+ToZu7IUmCZvFmhi9Uw+GkV72HGbOt3
	KpU+CNfauaMKY9uv1J1Pdox7g22XQhT2KqdeVXyhlQOE8YvtZwN/jSikngc+q6JDjsDYSd+nKyv
	u4bY=
X-Google-Smtp-Source: AGHT+IFMosdQqzJMfplyxY0dp1bYJt8xdM1zl0ikoM6bb9JGR8ja9dovQk0/9fXocpUpVfobamHH6w==
X-Received: by 2002:a05:6a00:4b05:b0:736:ff65:3fcc with SMTP id d2e1a72fcca58-737223ed33bmr1854674b3a.16.1741938165983;
        Fri, 14 Mar 2025 00:42:45 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-737115293f6sm2523949b3a.14.2025.03.14.00.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 00:42:45 -0700 (PDT)
Date: Fri, 14 Mar 2025 16:42:43 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: declare quirk_huawei_pcie_sva as FIXUP_HEADER
Message-ID: <20250314074243.GA234496@rocinante>
References: <20250314071058.6713-1-zhangfei.gao@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314071058.6713-1-zhangfei.gao@linaro.org>

Hello,

> "bcb81ac6ae3c iommu: Get DT/ACPI parsing into the proper probe path"
> changes arm_smmu_probe_device sequence.
> 
> From
> pci_bus_add_device(virtfn)
> -> pci_fixup_device(pci_fixup_final, dev)
> -> arm_smmu_probe_device
> 
> To
> pci_device_add(virtfn, virtfn->bus)
> -> pci_fixup_device(pci_fixup_header, dev)
> -> arm_smmu_probe_device
> 
> So declare the fixup as pci_fixup_header to take effect
> before arm_smmu_probe_device.

Applied to quirks, thank you!

	Krzysztof
