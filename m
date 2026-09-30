Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7D74156ED
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798613; cv=none; b=iOMq4dnckJt74mBQJX55rpFVznk1I0eF10Z+/zdBWF5CPMuyh11E1XIQwOTR+k5UtlfUqdwbkKT5P8WpN9W2xfZx/IQD4L5R8SdxaEptN0h3zSndJqoOZuwg+eZ4Z6VF54TRSnt3vAAdJcZTU26T2KTLEunqdS+MUuKTBy1RhfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798613; c=relaxed/simple;
	bh=tb7tRqjRKsskIV4ptJEZWXYPWkaWUIXs01cFsV/GkMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=US+gZAcQvGuxnkLNPFNzHumDo5Skehct0tBZNfnpZ6rVH8h6br2rmpXe+WQj+oQSMXANpCcTbwDgysyR85slAIbRCIzWtWXtVU+2BmkcaRKD1S3rbfl5Isr4w6N0ox78vR7GEgPVCMLewvPovUM8B6sW5wYKCau7cx5OXO++ZsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GWIKXjWN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GWIKXjWN"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e2e4ef20beso18475ad.0
        for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 13:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790798610; x=1791403410; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gV7fs5Nei/k8o70WCYEk0VoBwcvkJqHkvDHNbl1vC2Y=;
        b=GWIKXjWNYQigzEKbNcz2wBkpGpYIasAazqWP97AP6Gno45WTj02hsYQMODT377v5q7
         Baz7NzDhpB9ESdFcnFrRLk4D8qLjxFyDeAIo9fqFVPoBGzvpWiEmDriJF55fe0kPVfNM
         Rj5dOAWeHZp0yLhtj9zHZjU5OOZ3hBswj/Z+pCcUREYrD8QTg71mOWQ+YMTcpFMFHPae
         VEDiduRKQ0gCdSj0IgmfrhPDm/O+/AL9QvyoRAdrhYe3ZeXB7B43zam7xd2l4ChcNuPU
         7rbtE2Lkea61r4Cdvu5JHxplXGkyU9FYWjRy2BPm500WE71aSAjGfOYwocasEHs4Pjly
         cLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790798610; x=1791403410;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gV7fs5Nei/k8o70WCYEk0VoBwcvkJqHkvDHNbl1vC2Y=;
        b=TXSpAb5EzSca2QfgRmc+O4r0A2/6UvIk2uEDp6Y7PNKFJINg8iZFqj54H7bjcUyEKr
         pJILfz8SUfFwOicmL9NRO4GuIs2qq0H9ufOkcrDU72qI8MclbOPLG+fEXijcluB6aViy
         H5TSJbJCaW56X7oplzjGr0rpbQ+UfxFSInXYwblx684HRzLzsOEfhCeRkcS+dFGfb5Nf
         lXlwr2vcc3/mM84QUsES1w5uoNa5F/n0gYK0kiUrijI2F+Wq/8r0vv3PaZopuVjP+FFx
         EbUdjv6AbGEf3iRtDsZTEtYvEB7BNWOlFYaJOyfFBl1NIhJ8IY+rcVqSmuo90x2P8z3m
         vluA==
X-Gm-Message-State: AFq9FYIBdvq8H4cxtqbPzVr8XW9K/UnL4lzM2FpZN3nTKrDbp1v3B5Ca
	deEfg0f5kheusWvJeSwGObcafWYQUDrwnkWeaEs6UjoYxUFUx9A3o+Vru2YMVdoaWQ==
X-Gm-Gg: AYBFou1yRZfq/i58Hb/RccVVn0wqf/ZBEEBRwryFiviuDOS+88or/QNz4vz89H4hTCr
	gTgdRdm++sssD1hDoREiVXlAAtYZ08sLF7EECISvgQahiIgeq1WOk1TP/FhUFj7JWoIKiqMFB5K
	yS38lZMvSr7b/Cr8RAzf30/MIbihpuq6TYyM2u4A/kW5hMVFEWFYk/QCEiJ+IndPJu9G3ukX3GV
	V2NDK8J0+OHfI+qJTm6HFASAtR1rdO5e8jBLkXWM8m1nPkQUJp7zNA0JNItZBeyoQOK8pd/hiZC
	NoXS98fz3WeoZbb05wMATFPicylyNJDV5xCiEyxBjaXnJs2B31jUgt2QWrQMxfh3OKOq/MKgNiq
	9DM0xfCy/w4EKi38HFB7EvDImeOYE5/SLWQkCwfw/w9289B1YHVYsdxe5ntHiWmg4t6573+NCnU
	K3sl//S5IyYeZ8NVYjUihPDD3Aj/KkCMYEjkKni4CWcQ+TEHDfWt84SYTfekp9wn3I8MJ0Cp4Pc
	V7B2IXbINRNkWi1z9Gtm487JLrHEd1CbKcF
X-Received: by 2002:a17:903:32d0:b0:2c7:9e6a:1a8d with SMTP id d9443c01a7336-2e305407c5fmr334005ad.12.1790798609384;
        Wed, 30 Sep 2026 13:03:29 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e300a90dc9sm1914285ad.18.2026.09.30.13.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 13:03:28 -0700 (PDT)
Date: Wed, 30 Sep 2026 20:03:21 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v11 10/16] iommu/arm-smmu-v3: Factor out
 arm_smmu_handle_gerror()
Message-ID: <ar1rCWg2mJ3aiZS2@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-11-praan@google.com>
 <ar1WQCud+B3nAWX6@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar1WQCud+B3nAWX6@nvidia.com>

On Wed, Sep 30, 2026 at 11:34:40AM -0700, Nicolin Chen wrote:
> On Tue, Sep 29, 2026 at 03:45:04AM +0000, Pranjal Shrivastava wrote:
> > The GERROR register's state might be lost when the SMMU is powered down
> > during runtime suspend, requiring the suspend sequence to handle any
> > pending errors before the hardware state is lost.
> > 
> > Refactor the gerror handling logic into a helper function. Subsequent
> > patches will invoke it from the runtime suspend callback after disabling
> > the SMMU, ensuring that any late-breaking gerrors are logged and ack'ed
> > before the hardware state is lost.
> 
> CMDQV has a separate IRQ, so I think it likely needs a counterpart.
> 
> I have a similar patch in one of my series:
> https://lore.kernel.org/linux-iommu/16ae24cc2a002802b990afa1a69fe4ceab1e0da2.1790188510.git.nicolinc@nvidia.com/
> 

On a different note, I should look at that series, I think there were
multiple things that were fixed/addreseds in that series. I'll try to
take a look soon.

Thanks,
Praan
