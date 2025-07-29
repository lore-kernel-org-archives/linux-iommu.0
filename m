Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2A2777E4
	for <iommu@lists.linux.dev>; Tue, 29 Jul 2025 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753782961; cv=none; b=IoD3ECaEr/FBXNePs0PpWYlEC/4q1olNJGnMnNlZOO7TpFX+36qv4gXT0Lub1WG8jVhiPmhLWqlY/FYp9osr5hrTU4YGI3j8YGn8fvahkjSn9Zo1CoRCcQISCKDjHLfNdPCqyf2T1YUkcPCuDBxEo2HQaSBNKtwL1vpB2p7vSiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753782961; c=relaxed/simple;
	bh=6J6O8lIPO8lPF6L2zLsyMC1bVxdBOnAwKLyRubhILW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFzlSbUWqXFUtJKA2+qwCTjpeTO3o4fraErm27+rAhe2KHUMe+ZS1YXslf2bY+58+fb0/RLFFCRa3DBszYqeGGT4oCTbFced9dyMecaDvURvVrSwkKsahwMnPE8cbim4SJbAW9tVWuBPtNtAnuZcO1PabQmHRfulu3eZDLf9H1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w+nCUqu6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w+nCUqu6"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4561b43de62so71335e9.0
        for <iommu@lists.linux.dev>; Tue, 29 Jul 2025 02:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753782958; x=1754387758; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y8BeCJxT0E9y6LqcrNbSOsYh4JRswSE7zt76fN7xljQ=;
        b=w+nCUqu65Xxil6Ie+zqAw63dPVK5bf/4sEjm8SpBrZB6L2KH2weJtSKKwHnS5cYHJQ
         jUl8ytAWD1ISlirnsRMDKnPeVsTQkz6GsGEAP6VR6gu+gocXsQGbnFHTzxXw5uvGk3n7
         EjekMhEBL42wHJLiuk1jdSNu4SmdIp8rjmRZOcJy3raxiCwqXdn8kgPUyz63j07i23Hq
         XJJZjdhLyH7GmvHDqKCUIgu8HHOEOAZDGfn4CUOa7bjNqS6nuIef0dBcYTzd/EQyulh5
         eeoCCWSk34mSb7CSExZj5X2Ldc1Dz7Z0EBZcBeLWnI1UpjGa5elNLCR8VAYT2LRKco/e
         +yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753782958; x=1754387758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8BeCJxT0E9y6LqcrNbSOsYh4JRswSE7zt76fN7xljQ=;
        b=fNUyWvnzTvqFCn6mBW1SgkWS1oV/hFV1diC/imWsAFrdgc2BKa+cIM59LzwW9aNZUE
         sG/jEJPOq3dfldA2OC+7jTELFZjaPgJE2CCSPpmP5WgxcX6ghIw4ZDaFM3utKwOXVE/5
         O9c22SCI7eKtZuunpOC8AQjjaKrPm14QcPPAsT1VFNzhuYMkqo7dy7Yz0rUz9nkkoN6/
         oXgxjgPvq85R6oyDje3PQf2hh12FZGts/XEdAf8eZK3P9O6iFjKUMJlKltregnkQIzxE
         +7Ec/fsLZkNVmEEKx/IwQdFaMEW7cVl9BmQ5qYRRSJNNahZOoagIrrUY4xcm4I5VrJad
         af9A==
X-Forwarded-Encrypted: i=1; AJvYcCUas4HNz+LRA7NwuDs5a7r+wGUIpoGw3lwC65Prt7o6u6FKrVkmxjHvVpEvOJ5gUVpokbCgXg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8LSWDwECIVE6Ef2emvkL2qeEyN7UhiQ1PZrK7czDlTpnykFtj
	fZ1zQtoFrMS1a6MyjH3GDYtwIguLfjfNe+ncm3/sDqvk5M2TLK4WMjyV5Tbc+Dw6zA==
X-Gm-Gg: ASbGncsRChVR7Tpykv2TnFI0057Ibh3xfzu3RMm4qcVX0DK1gMnLKujIfzKKKdfbZTt
	JWpWWioHuvIvWxYIjyrzU68F46L1HAvCcHsjip9Rf3NS8zrYf5VOcPaGQVwByrXoc1CFCu0NguZ
	99CiSI/2slejo9WGRJ5vKStQyiGY3E7cepN35Rxm45fnhRevXxhASKNIgT1ZNuGKTQ9sFRqYARB
	1S8uVhND5MVvdNLkFbKCwR8PQtYgyKbAVyYHw4mxoa6O6M9pdVF93rlnCg8LhWxCS78EwwPaLm8
	jBa4pi82r8WKFGznUBLzvHY0vdi8XfG48NKEkVA19EyOBwZFiylAQ3xxH2hJQdRrGgwqSQxnRdC
	LhGeXIaxZ6wNVQQf6xLBHmWi0t4WxXG9mtKFrdigQYkvAHuRLXLK1aFruJkiV
X-Google-Smtp-Source: AGHT+IGzES6hqfjR1ngn6YMh6m2QMnuLZqGDQbq8stqciYuYMIFTwvOmpG+4EtUrCFw2V/nQTG/heg==
X-Received: by 2002:a05:600d:17:b0:453:6133:2e96 with SMTP id 5b1f17b1804b1-4588d58f585mr1058175e9.0.1753782957791;
        Tue, 29 Jul 2025 02:55:57 -0700 (PDT)
Received: from google.com (232.38.195.35.bc.googleusercontent.com. [35.195.38.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588e33f8a2sm19702345e9.0.2025.07.29.02.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 02:55:57 -0700 (PDT)
Date: Tue, 29 Jul 2025 09:55:53 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	jgg@ziepe.ca, mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v3 20/29] iommu/arm-smmu-v3-kvm: Setup command queue
Message-ID: <aIiaqSVtSpX7hr8i@google.com>
References: <20250728175316.3706196-1-smostafa@google.com>
 <20250728175316.3706196-21-smostafa@google.com>
 <c8da60f6-4083-4aac-b921-d57b767fa895@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8da60f6-4083-4aac-b921-d57b767fa895@kernel.org>

On Tue, Jul 29, 2025 at 08:44:03AM +0200, Krzysztof Kozlowski wrote:
> On 28/07/2025 19:53, Mostafa Saleh wrote:
> > Map the command queue allocated by the host into the hypervisor address
> > space. When the host mappings are finalized, the queue is unmapped from
> > the host.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> 
> Your SoB must be the last one.

I see, thanks for pointing it out.

Thanks,
Mostafa

> 
> 
> Best regards,
> Krzysztof
