Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56674223311
	for <iommu@lists.linux.dev>; Thu, 19 Dec 2024 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734606871; cv=none; b=uLZQLaTo1PXY3iIKMf67JCK/Kqel6sKMFhbTBoadIp+JYzQu3J2a8C98eTaXCCCBFgAooonQQrabOF/I7Y9+eiQHrbtvac0OFwdGh9q/4mt05ShEi7Fa2hdOUCBkXdQ+9OTI/9SSh6sulbNqR3ce7z2TCE+eV1sN9PEFa6se8qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734606871; c=relaxed/simple;
	bh=8RuIoJ0q/4dY8lZ6nY/JYhaMNSssJ3bm0ZjjKWMF2fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvDS8tGQwWdUBeea/xs7qN8c7gYCo4/tjwp1cdjrF9ayPvF4QVxqjzQBBLDj4ukGSVYuG2FV3CAoTVSFKVZ/XnHYDWOuxs12iZ0Evg2Bm9+Pv0ZxwA1N39ep1LBOmXkDWnTnAYS1Ya+Umhb+zH9+RIOdqK06mE+16UYCnRZZG3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QMkvzoIv; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QMkvzoIv"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa6aee68a57so106050166b.3
        for <iommu@lists.linux.dev>; Thu, 19 Dec 2024 03:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734606866; x=1735211666; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k232UiDWZ9i334Ovjw0KByCgbnjokcMOWAtrXY0DoWA=;
        b=QMkvzoIv9MNy3/tmOszVE2kQknWv+fyaExkIC/1C1/p6EyytgO7PVUnNiLCrmeXawE
         Zqc2dqX/UBvaGNFA33Ep5VmLqKLLDiPm5dLPlgAJm+rMKI1hNVxulf3PNziH8PJnEfb3
         FLrudClVl8OogiDZO7wFmf8KiWy6okKfbNG62KOJKYil0Bek6gxzC8ZA9naZJXBVGq0r
         QDZqD9mGmGjckDlFUXYucstv+5loic1z0Rr8wtvfmMuI4zJuTOfhf+tNkjRfyHxV28Vd
         qB03ftMPejweliF4mooSk+ibuzr8gUAPc+PYrBk5luZxHzRDVuT/vuDI7WXAcq3n9ApX
         bsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734606866; x=1735211666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k232UiDWZ9i334Ovjw0KByCgbnjokcMOWAtrXY0DoWA=;
        b=diuyjF4a/H7oaJ8L8BXAu/LEhEHy1aEtYGP57a/3+y247W412STJ/yShx5c0OP4zi5
         DG8Pci0ahgGoMMtc7kj2OTZ9Kbg/5bVainHbdZeuR+Crx7p7j+tIcHPhUkSPLpEgFGsi
         yT7DSD9oeMVQKa7s/8zZaBiyeS/+Ajb0dxIOmbRS3LZOSUOsF9rHDpupTymvI7e722b8
         Bqr9vs5snXaZTrlWWlaOfZbU1LSU+NcUSC2jPl3uuKQJQC1BZOUjLWQgeYJTDnqiR8kL
         UQ5gDnaYjIgpOyVgAfvHGXueJfGjBJb249HZRmFIGzvrabLsnLayDKAhiunzLdKc37Tk
         ef9g==
X-Gm-Message-State: AOJu0Yz8NTgi3iTBCGRZNTWUJWdOLS/6PKZswf560qKq1F1OMTeCub1o
	tfV2GryQmAuEW+1elpSowl4hhKaohqm1DLVCLUBrPUzItHJvH/iRbgDBnluemg==
X-Gm-Gg: ASbGncuLub5TCZG23Z3ImqXZ3cgv3aFYnQyZyMUc6sSrb5xejrNvCRKSRmEGhOStkwV
	sLYEL+6KEKZb7ojjZLETbKycLlxvDY+deHucspxDuDEbkZmAi8QeaL0yseGLjO5mkFjdh/Q1Ezk
	eqIgbzDeRkMse+5fNlv+23I+H0ddf/gRObsd1Tr4YJxE6GTP95G7oDQwRheEA9ek58h2/ImQ/WA
	imLQs7IS4cpwTVrQ3i9CrMb9O9GOBJTcCBVxwcbCr4bGXAwzvY1MQ4lGjYMqoj8dMX/K7/U+Nzu
	0pYno1HIdW1JNXE=
X-Google-Smtp-Source: AGHT+IHKoh5EsN1uLkOfWMRdI2tQtHhYwKploXkp4V8soZqdefYj8PoGPzqWp1FX9+8rm326OJSgBg==
X-Received: by 2002:a17:907:1c90:b0:aa6:85d0:1486 with SMTP id a640c23a62f3a-aabf496eb16mr518756966b.54.1734606866353;
        Thu, 19 Dec 2024 03:14:26 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e8954adsm55343466b.64.2024.12.19.03.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 03:14:26 -0800 (PST)
Date: Thu, 19 Dec 2024 11:14:23 +0000
From: Quentin Perret <qperret@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org,
	robin.murphy@arm.com, jean-philippe@linaro.org, jgg@ziepe.ca,
	nicolinc@nvidia.com, vdonnefort@google.com, tabba@google.com,
	danielmentz@google.com, tzukui@google.com
Subject: Re: [RFC PATCH v2 11/58] KVM: arm64: pkvm: Add pkvm_udelay()
Message-ID: <Z2QADxbdoYi5q9iT@google.com>
References: <20241212180423.1578358-1-smostafa@google.com>
 <20241212180423.1578358-12-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212180423.1578358-12-smostafa@google.com>

On Thursday 12 Dec 2024 at 18:03:35 (+0000), Mostafa Saleh wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Add a simple delay loop for drivers.
> 
> This could use more work. It should be possible to insert a wfe and save
> power, but I haven't studied whether it is safe to do so with the host
> in control of the event stream. The SMMU driver will use wfe anyway for
> frequent waits (provided the implementation can send command queue
> events).

Mooh, I'm thoroughly hating that we need this -- pKVM is non preemptible
so we better not wait for too long.

I can surely figure it out from the following patches, but could you
please expand on the use-case?

On a side note I'm not too worried about the power impact of not having
a wfe in there, again we better not be spinning for long enough that
power starts to be noticeable.
