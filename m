Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7333C12D1FF
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829427; cv=none; b=V/t0Mfs3fky4ZLce6eitle/c6BJo1e+s21caAuc8/covBESF4HL0FK1aNaQHYMUrxVZG8rBhpZg3MUHLwCJ+R769nMCQIPf/5LU7S2WSliENt5lQWxg8eITHGPASirwtKG8QgzvVZ2U9jmHUTn2TyMZ1SwWajLPCYA0OW/ggo2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829427; c=relaxed/simple;
	bh=n94gVyy849dz93qJ6lalONV+LGkG+4MFl8sfuXXQrW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqH7A2dw//EasD4c43ITlkSj34FDPyytrx60wNe8LVARXZZYk69y7Q6AXzlXmPri0cPiR8YPDLvTva+CVIfBZZ82CU46ZbVOToXD3Oz7ANIoXnC20E12c2o9SwH5xbKH4GvHIb/JE6fY4raqw3Gf6iisOLoau+oMwLa4K0yBtrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jsveRrzT; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jsveRrzT"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec0f3b9cfeso33370541fa.0
        for <iommu@lists.linux.dev>; Mon, 01 Jul 2024 03:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719829423; x=1720434223; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xY8d+HAkWfCBetfPMhE7Q4IYxdRfyfvsMH6WlImrlIc=;
        b=jsveRrzTQ8yrhu3uMziKT/Eo6sDKgkQdWeFamYngLC7aUG+w4iCIuGaPf7M4Hg2FK1
         pNXOj1qVNaWO8rjNzDMI8FxzsHq24UIepIji5ePVtfHUHOiyRtJGFptts+7PKLGkRSdo
         ts9Ioi51iuF0p1w4UTlhZnNyDn85jud2rMXyFUFFwYgiF+smN1sEhqJcCHtz1N5Z6ACO
         xCVqzGoh16APMi+DMKDxHHgDPvQnwStCiBksVFE33dqToxlLP7m3i12kKFFGzSUZdM0w
         K3VMRf3cS8fTATJF65VzJiXz9T5iv1x8shdaT5LazNbSLE2r8YirdRbtSb5L0CwxY2b9
         al7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719829423; x=1720434223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY8d+HAkWfCBetfPMhE7Q4IYxdRfyfvsMH6WlImrlIc=;
        b=dFuwsEaR9ZH5Z6bXeMlpKU0In7/LOC/kricdQJYl8lkyWdmLsbLhEtJ/ZuqWaNE98m
         zeyULPv7JfSJk2FgrQ/J3nkkM+2mdarhtalzJkkwwhN2kIRYPx+Q7CKL0fzX64C6bWVX
         JAY4BU+VHLzZrZyDivIFAYS+e6nII8oXIBH5IXxMKzeB45b4xA0jLrDug0b+sDsUgDau
         nPoom0NeI476oVv9R0L12wKYT448FvgmcxMFK7hbRA0K3O+ZPCmpjkaXpiAsiLmqUdod
         QMAneNfIRXbGyc5WFwymsLbkJz+SwaKFEz7s2j4F7fXzSE4tiTdakZqpI90KyYQ391Cb
         phjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxsdrhVYkxyEPvL3EIE2OAO55e7YXddJngiDK4dMXK3DWKj+YEz8i4eVmlIc6xrgthNBg0LT4LI0WdcJUop0gGXVrOCa4=
X-Gm-Message-State: AOJu0YzvxeZLa84F7A744Ii8PB965uiM2IB12Gdvmlk/urE//SA7+Fwl
	/2vzIO85s6J7cbFmSDPjmOzX4Mrtwg1n/rOAZEZY4ot0byoqwLOXzIg+ZGmEy60=
X-Google-Smtp-Source: AGHT+IHn1x4/AXOS/KKlqIEGbYUZOI8dBCLD27ZLb+p6WIUGXcMNUx34kmR1UcblCSl1Pa/mlV2OGg==
X-Received: by 2002:a2e:a912:0:b0:2ec:4d8d:375f with SMTP id 38308e7fff4ca-2ee5e3767fdmr37486211fa.16.1719829423583;
        Mon, 01 Jul 2024 03:23:43 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0621fesm146262315e9.24.2024.07.01.03.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 03:23:42 -0700 (PDT)
Date: Mon, 1 Jul 2024 11:24:00 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: will@kernel.org, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	liviu.dudau@arm.com, sudeep.holla@arm.com, joro@8bytes.org
Cc: robin.murphy@arm.com, nicolinc@nvidia.com, ketanp@nvidia.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Enable PCIe ATS for devicetree boot
Message-ID: <20240701102400.GA2414@myrica>
References: <20240607105415.2501934-2-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607105415.2501934-2-jean-philippe@linaro.org>

Hi Joerg,

On Fri, Jun 07, 2024 at 11:54:13AM +0100, Jean-Philippe Brucker wrote:
> Before enabling Address Translation Support (ATS) in endpoints, the OS
> needs to confirm that the Root Complex supports it. Obtain this
> information from the firmware description since there is no architected
> method. ACPI provides a bit via IORT tables, so add the devicetree
> equivalent.
> 
> Since v1 [1] I added the review and ack tags, thanks all. This should be
> ready to go via the IOMMU tree.

This series enables ATS for devicetree boot, and is needed on an Nvidia
system: https://lore.kernel.org/linux-arm-kernel/ZeJP6CwrZ2FSbTYm@Asurada-Nvidia/

Would you mind picking it up for v6.11?

Thanks,
Jean

> 
> [1] https://lore.kernel.org/all/20240429113938.192706-2-jean-philippe@linaro.org/
> 
> Jean-Philippe Brucker (3):
>   dt-bindings: PCI: generic: Add ats-supported property
>   iommu/of: Support ats-supported device-tree property
>   arm64: dts: fvp: Enable PCIe ATS for Base RevC FVP
> 
>  .../devicetree/bindings/pci/host-generic-pci.yaml        | 6 ++++++
>  drivers/iommu/of_iommu.c                                 | 9 +++++++++
>  arch/arm64/boot/dts/arm/fvp-base-revc.dts                | 1 +
>  3 files changed, 16 insertions(+)
> 
> -- 
> 2.45.2
> 
