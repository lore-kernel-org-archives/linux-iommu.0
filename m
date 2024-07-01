Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302F115ADAB
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838915; cv=none; b=N9G8cwDaqyz8SWsqxZOE/rc0oFpROYPNUCMw9AqkRagmmxH/r/1fJuTPGakREIlq737NHzWsTlf1RR7ec8rnUDFFlyqaz5G5ARxVjv/4ZUZLXVd1lVZnAGhGeLvLUr0435wYcSo0Mafe7CScJoOfmQdUkAuPJN+HDKFNIbul8ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838915; c=relaxed/simple;
	bh=BcacgMNTuXZ+EMlYZldnMh+90qHGE8oI584+fATS1xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpolAxD9er91wjilE5/7Vm66Tpc89jZkexfegq+dtkGw87gUKw3wVB5/SYCIH/CJQ1vyQkCIczDGlchV9QWeFHNMeTUXmOhRvMe/jTzLWwYZoBY1RYdguaAE1TPFZyjXJ8UEVZwsUYFN1XY3yiOkFskQ5F62PQQID2JdZ3YW6xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eK+AIjl0; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eK+AIjl0"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52cdb0d8107so3426584e87.1
        for <iommu@lists.linux.dev>; Mon, 01 Jul 2024 06:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719838912; x=1720443712; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSOQxp/mD2SUurvWX0AEwNvMGjNvTwzJap2KaVh1zBY=;
        b=eK+AIjl0h9Ui3gRgYDMhJ6TQiDMI5iIU0JQnpu4tCHdSrcw9m5b7ILtVEI0VaU0wr1
         iY0OBxj+1tPsnN3e17BOvv6opeE5l3uzl+xsDhqRFI9qJlEww/F0/2ULMGxCDpKSjP5C
         IfF1Ykjr4RsrVEtYt+jx//NgNBzQ9c7lrj+cSPK96ojeB7FouvWKOnfZXEyZ3BPeossZ
         PVEY9eKkHFlldfQwWgKiRoSa95dT1O1TuzdW+ZFCAmkc/SoYL8+/hbCpnouYnLZbpBAD
         UjuiALmVdRVBNSisCD004DHcf0Z+ORwhABw2LpAsQSfCqISqr1HXBKeUqdfxcK47zNIv
         DqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719838912; x=1720443712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSOQxp/mD2SUurvWX0AEwNvMGjNvTwzJap2KaVh1zBY=;
        b=X27QuOUkcdjQajCP4nNEd635J7Fh2ntYMwaJgGIXb7k55UyxWtP5CZe4aD5p3ubR2D
         vjaHxjCG3BrHF9jrafTfPW90O7YMKYw/7WClxS97jCCkG2SldnF3WZkn3059X0RzfUc/
         HlpjxV65acSnLNfXJM8W7BZ3fz72TAzIqncpZfv/SCNNRxPHkvbGdA/PeW7iHFQqJQHx
         I+BsW9/KErr1t0teH3DtYc12nIBF2AFY+rAu1OeTGDw7oeRkDeBpBTVVGyH3OPRUFBkn
         OwLYZyd0DkUCXp5GPxeKevCqbtiFMZcltzcxEmDTFXB1R39ExGHVNem+nnyLJ9zM7WEP
         GqtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOKTRip6Khs0nsQVhfBhbQFlaKRvUl1eIwQxUOjtHUgLUE4WYOgX6t6lL1JBB+FVlYidHh21axPM5z5gZz7sjEY+qfE9k=
X-Gm-Message-State: AOJu0Yy8wfP44iGQRJ17JpKdIyaRoJVxzIKSnOJtNln5uax/sIO3OduF
	tioho18vGayG3L6QNnkaWqX/VKWBwINbXe64YCRhegBGdpbkuVdVx5qcqE0b4dU=
X-Google-Smtp-Source: AGHT+IEnMHmaqPosbfn7Ngk1Y8Xlmzzim7ZOlO5mnK6ZEyARCtdzXm9ARWtOnguMtbzh2DJlYS/rig==
X-Received: by 2002:ac2:4157:0:b0:52c:dea0:dd55 with SMTP id 2adb3069b0e04-52e8266fa5bmr3186258e87.24.1719838910837;
        Mon, 01 Jul 2024 06:01:50 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8cd8sm9956632f8f.27.2024.07.01.06.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 06:01:50 -0700 (PDT)
Date: Mon, 1 Jul 2024 14:02:07 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Will Deacon <will@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	liviu.dudau@arm.com, sudeep.holla@arm.com, joro@8bytes.org,
	robin.murphy@arm.com, nicolinc@nvidia.com, ketanp@nvidia.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Enable PCIe ATS for devicetree boot
Message-ID: <20240701130207.GB2414@myrica>
References: <20240607105415.2501934-2-jean-philippe@linaro.org>
 <20240701102400.GA2414@myrica>
 <20240701115723.GA1732@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701115723.GA1732@willie-the-truck>

On Mon, Jul 01, 2024 at 12:57:23PM +0100, Will Deacon wrote:
> On Mon, Jul 01, 2024 at 11:24:00AM +0100, Jean-Philippe Brucker wrote:
> > On Fri, Jun 07, 2024 at 11:54:13AM +0100, Jean-Philippe Brucker wrote:
> > > Before enabling Address Translation Support (ATS) in endpoints, the OS
> > > needs to confirm that the Root Complex supports it. Obtain this
> > > information from the firmware description since there is no architected
> > > method. ACPI provides a bit via IORT tables, so add the devicetree
> > > equivalent.
> > > 
> > > Since v1 [1] I added the review and ack tags, thanks all. This should be
> > > ready to go via the IOMMU tree.
> > 
> > This series enables ATS for devicetree boot, and is needed on an Nvidia
> > system: https://lore.kernel.org/linux-arm-kernel/ZeJP6CwrZ2FSbTYm@Asurada-Nvidia/
> > 
> > Would you mind picking it up for v6.11?
> 
> I'll take a look.

Thanks Will, coming back from holidays I hadn't seen Joerg's announce from
Friday before sending this

Thanks,
Jean
