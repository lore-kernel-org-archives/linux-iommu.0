Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE7431B808
	for <iommu@lists.linux.dev>; Tue, 16 Sep 2025 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033307; cv=none; b=kBCTFzq9kUaq2KewEPHhkY1p9YdCnvsK7aeqRdvs9ScUt+9nWLILKNa436IU7V2PFUOWIG3pfv2NfhJ+nnxm7elAp7qhfjbUm7h8vNyod1qWJ7hre2eIZiHGObnBIu61RQrAEQiTAyOqz79IOkK6NSPvtSKTroOG4ubWVVqsvL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033307; c=relaxed/simple;
	bh=Nu11bmOVRte2aokBqHmrTHWTKZU8JcQy9nmoUexKGS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IznFGAACAIiSuITbuXzwVaXsufLnOcaVp/u8kewgZHSYe+9Ed6w3TmX1KgRKUM4GtBtIroWaepy87D6DI1AEz8/4E9wjqAIoovYiY1S6X5tMNFsqdq1ZqAuT9I+Hxk6mcYA665QhjBKUelTnQ9UQp59RW8xN5rz72B9d4Vv4pbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CVyMXgYf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CVyMXgYf"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45f30011eceso58885e9.1
        for <iommu@lists.linux.dev>; Tue, 16 Sep 2025 07:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758033304; x=1758638104; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CT4KnFMC9K253+uFB3sGHZvOxPtog/sC9euCmcEFSfI=;
        b=CVyMXgYf/bzr7RDFGXWhuKguWJiYbEUQ20GHBFSiDo9ykcVa2o/ve4U43DFzpp6ubH
         K2GBpNhmLqvrcx7wIlJj7Uh6iR8q3x6OzxXUvfS+/nwn/QDOJMM7sTzXvoQLqA4Qun2y
         z6melJpE9W8z9AamVpWXX7IR24isiqB9gFnuwKpLNFgAkxHULwr65gZtKE9S5Fv6hDKu
         7v3vradggw11fFPnj0/i+xyLDMNKBdABRNvv4L1rn9C/BNHlzbgqhvTyvZ31PjxQJ7YK
         M+3eSDb/lU6F83JBwqeWjvEfiXxjxQN76/dE6Y061I5/jgtrLpSIOGq54MScFPxgELdp
         1lPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758033304; x=1758638104;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CT4KnFMC9K253+uFB3sGHZvOxPtog/sC9euCmcEFSfI=;
        b=IJDdMxeeRXQxgzgQ+PtQeEPfbHgsbsgQojdMvRSUG71UE+4PSWLJYmHeoCLQJoc5KL
         C9HLOApctFX8gNswiu/LsPjkWa0mveR3mPW4fPtVhxWyRnYQZP+xPzyfm0eO/LtaEz9z
         VcE3BSVHoYoGU/rQ1PtftlYEMnXvmYGRxvoTVJTqKUaoug21YeH/4YzDUva7H86qvkBm
         Ks61tjSYxu/CwbR7dKzJHkEB929CCzsceZzs4lin4erFmFQj9EEcDgL1JgQaCh9dmLyK
         e2dF0qMbjyCTLJdeY+Zk6dy0EcsVFoEUQIDC8dh9SeOkL69FkmOJ0rXDn/2R9sKpfrbW
         2TwA==
X-Forwarded-Encrypted: i=1; AJvYcCXvbCf5da7kd463GCUrovYUyUH7xwulTE7S73YJ4aGfoifHCQapgE++xkNYYNZEpNr2fvG4Gg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAqzGZPKOQYHIhq+krJl27jkhwkDOX8f27OVTUPffL5khxIGcs
	ohkjA7YreBURUwn3r0X8eohgLw3/nDvNirihHxX+KL6ETUexdqX8i8RTT2xdTB6D9w==
X-Gm-Gg: ASbGnct6H00dPrcpJPvV+vNKruA4cPmUavrTu8LTeuzPri2m8dcvNxtcpi6CJKYqB3V
	nqkGiJ6c2UB8cZMws+4Lb+33RwpStQ2M6TtLDqdTK1WPx4RoVa3wWHQp5INB8OAHHaP9pcJIt+M
	9EY4+XjrZAtPIQUyn0WsnFWFZIm0qi581+c6+2UIpUiKScXMO5iY0YI34S5rQU3Dor7sqxP/Lqg
	q0fd2h4jin5rAbubccukugu84XSefOx7flQcamxBt1DQ1sYy/U6KxmDkEYAZYDoLb6xFG56HiBQ
	FDEPqzQrxR1KoNofAv9YqcUeEZq8DQubyLDPmP97fxi6oZ60ur+YRKw2TuwjnNdg6+DP5YvDezb
	8qCyyopQiqU0N6nPN8h/1pDFiKg1CwcQEh8OzYj9q5/tFVDhdhu9nKQCjhdWxgV3fn3TQ6Q==
X-Google-Smtp-Source: AGHT+IECpwDExsg0Dr7B4qD1+CeVxxyJjTc2PPzhq2qhSmxiB4I92vX7At74X9XKcTLJsKMwvH5o1A==
X-Received: by 2002:a05:600c:8b35:b0:45a:2861:3625 with SMTP id 5b1f17b1804b1-45f320ea2dfmr1951735e9.4.1758033304305;
        Tue, 16 Sep 2025 07:35:04 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e9cf04db65sm10884027f8f.3.2025.09.16.07.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:35:03 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:35:00 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	jgg@ziepe.ca, mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 16/28] iommu/arm-smmu-v3-kvm: Create array for hyp
 SMMUv3
Message-ID: <aMl1lCvuKQFfOhNb@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-17-smostafa@google.com>
 <CAE2F3rDc-4SirDDrQeZJQDqjdv67-QFfQhHfwyd+O6f5OsBSpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rDc-4SirDDrQeZJQDqjdv67-QFfQhHfwyd+O6f5OsBSpw@mail.gmail.com>

On Tue, Sep 09, 2025 at 11:30:48AM -0700, Daniel Mentz wrote:
> On Tue, Aug 19, 2025 at 2:55 PM Mostafa Saleh <smostafa@google.com> wrote:
> >
> > +               if (kvm_arm_smmu_array[i].mmio_size < SZ_128K) {
> > +                       pr_err("SMMUv3(%s) has unsupported size(0x%lx)\n", np->name,
> > +                              kvm_arm_smmu_array[i].mmio_size);
> 
> Use format specifier %pOF to print device tree node.
> If mmio_size is a size_t type, use format specifier %zx.
> Align language of error message with kernel driver which prints "MMIO
> region too small (%pr)\n".

Thanks for catching that, I will fix it in v5.

> I'm wondering if we should use kvm_err instead of pr_err.

I am not sure, kvm_err seems to be used from core arch code only, but
I don't see why not.

Thanks,
Mostafa

