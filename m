Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2072F8E90
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 23:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782687977; cv=none; b=LvHJl8I2l4J0g+4IbHhU3QV+b66z26YJp9seq9vPLdrkiqXNv9Af+rWHyzfs1ZJc1CBSPzWEP3nT27kHSQkH+PSOZN83IZFlJsQ1Jg9hCUM5UVkMYBYL2HExe7OdTgD4pBao9uUVeIgsrnsrEXR/H70HSs63sKP40La4lbfSpDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782687977; c=relaxed/simple;
	bh=Etgv1zt6H58TAeWQ2Ok+9a/koljupx+SXENx+QnUjf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEtAxmwirHtZgdo34Xo/BEXQBg4e4SzJDSmeUZa6msBeFgjvV/fWiL/Wd2tEijghMYPB9ugtpQq8bKTAIf8NUW6jHQvn4ykKwkozGsK+VjiPHLtPvi7WebjdM2b2jtYmclG3aVSPa4AsVFdftEdFHiA/mVMEwxUqCHAv0ZJ7Zzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SUf4qTZ3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SUf4qTZ3"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c9b2ac97cdso20515ad.1
        for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 16:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782687975; x=1783292775; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w9ASwZXxOhuIEA88U9uqvxx2ThgVPLf9gDKq6x0EUXg=;
        b=SUf4qTZ3itdccxG6pFkcu4NMrxdnQI4WDBRlyEUP54CWy29L/pZPp++sttwO55K7AC
         w7qj0aYkdWuF1pbje8gM2FfexWOwVYk5XZfDK55lFaNMLnA/N0WERZ4QgKsDErYSzdwC
         eBdivxtLQw2HRrr0WdNH7Q8X/XskYaU+hgpH9KUHvWRPYtaxDCFwm7ocCxpooKSDwLe/
         FSQ2RSNENLUm4aP2IJi2zRAoCH6hAqOdLlpI1cOlD0HsQC93Dg3Z9D/NZyuvvVw5uhds
         gg4ofRmUVLjUx/+GhRL5RECZJAdVQb2U3/Avp4lMXZynIv+nrpTRH8rO+b50SyUT+r89
         PrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782687975; x=1783292775;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w9ASwZXxOhuIEA88U9uqvxx2ThgVPLf9gDKq6x0EUXg=;
        b=c4zFfiAgulTF4OXf5xoaLXEsJ3KQakHIxLL4IdWpWPrx4dIdnGyFoKc/JpJHi8AlSU
         0BUiWQGpSdGkBjWI169KBJB0s0hgMCr59jNCYtgn9Ogn6VZ028GyQ2jUS870hKQ8nu2J
         pMYHyWpzzKUQy0fibiqzQFYlFk4Myck9gx7jejYoK+glSP2h/etsEygoG0F5S6tearcE
         fRT7zpSJuLm0CminpiV5a2AaDG0YC3rSuNkl8UM2vJRtHsm6d3sgGvmvrn6W3Bv1ccGl
         vK+7RtWA67RSM4MmUo3LPVepbPzQQozgVh5HnJ8WGopeNzggBeAIgkviwWiXq+FaCuLv
         /b4A==
X-Forwarded-Encrypted: i=1; AHgh+RqpmUZGyDveE3sEKBuKCupKyRBI7l3gORsD6OoUcpwHx7pwFg8MIP6vVHr1vgmBo0lyD5cnCg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAVDdKX9VYAMZ/PJ1WU+xricJOSIg+6NhaJOVsYN7PRPhzkH0f
	KeCSxYISXOElvrWt4vyQIagHQJ7VfUqx+bRN+jfSmkH7rTNtUx3z78tr4Axn2pRusA==
X-Gm-Gg: AfdE7ckFy/HrvVsov3tXt0KSe7vkDy735q7FOCHPxP8XJSaap/IDTlV8anp0nNQnce6
	OQJHBWvEK35uDY7F7UN9mO+qfO1RZqoZRXD/RSlp6y8pPPjO+kLERV70Uomi0gM6mgxkyrsjuqu
	xfUMUkyyTQOwpHBpqbpBkDH6e/NzrbjUT4MN2lxqQ9s6psO/YyIve2jggG1jjPHbdV5clXL4LAr
	TNUMbqEXBIo7MkxJhbttjjP8OINdSpHCW0+Gjhb60piFebg6QHJg70Ol0qmMexsHnFHgrxSqg6S
	obvN727MlbOt05L/zg4wv9s8SX6wVQGJuw7pqFQiYu6DB18XoGGLQcDaDm35DnhC1XqHIp2HnC/
	R28SOm4q8/ck1GXijiEd5K7MXfoNqtI9NYgSu/HUnfrctUHOQSrbSJHfv8AJZ14kvk2OiA8N0zA
	5tm0+YZ+MB+ON8+GmscbZw/IUZMcpYp31wyK/NlwzN6K/QzWX7qqxJ6RkxTQ==
X-Received: by 2002:a17:902:fd87:b0:2c1:ee6e:be1c with SMTP id d9443c01a7336-2c9a27fbf39mr2722965ad.26.1782687974705;
        Sun, 28 Jun 2026 16:06:14 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca0b454815sm3400655ad.2.2026.06.28.16.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 16:06:14 -0700 (PDT)
Date: Sun, 28 Jun 2026 23:06:07 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v6 2/7] iommu/arm-smmu-v3: Implement
 is_attach_deferred() for kdump
Message-ID: <akGo30h_EZCUJCkJ@google.com>
References: <cover.1779265413.git.nicolinc@nvidia.com>
 <89cbd3760a13f11cf63f6ead12f44974511f308a.1779265413.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89cbd3760a13f11cf63f6ead12f44974511f308a.1779265413.git.nicolinc@nvidia.com>

On Wed, May 20, 2026 at 10:03:19AM -0700, Nicolin Chen wrote:
> Though the kdump kernel adopts the crashed kernel's stream table, the iommu
> core will still try to attach each probed device to a default domain, which
> overwrites the adopted STE and breaks in-flight DMA from that device.
> 
> Implement an is_attach_deferred() callback to prevent this. For each device
> that has STE.V=1 and STE.Cfg!=Abort in the adopted table, defer the default
> domain attachment, until the device driver explicitly requests it.
> 
> Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
> Cc: stable@vger.kernel.org # v6.12+
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
