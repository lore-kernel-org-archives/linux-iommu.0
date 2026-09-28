Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFE14BD349
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790607428; cv=none; b=G14S4/F+g3cvrICRFjvMTmyc7ZRL45kioweEjzwDEEPRvvllF3bv5Ana4NEF0Q2RwlCn67lu+Dxu0vuXwhcfJwkqPgvK4QjeZ4rGiJs2Vik6NWaeXd7oE/ZyzB8VesHdMDqm93CZC29eWOWrxYhwspb6PP4/Mwo28N0tLbL8Y3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790607428; c=relaxed/simple;
	bh=hnhQkpKoMw2Zhfw9DM4few3dVnMySo2yIHKJrwxV20g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WS1vOgJ+WRVaPnkqyVGG12Fdn0PiY5Hiq5o80x1Cn8OtNCOx8v/dahUUw4aCxT89ceAwtDNbBVpDhTexDWWxT4luge1G/PKVd3KN0xXkyr554muxQdYTavDkT0BoB9rSJjSgpE06Awsp/ph6ZWX1FTlkdUH7lgU3KEqQXOR1+xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ctG+Y3WS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ctG+Y3WS"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2db33db4de9so92635ad.0
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 07:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790607425; x=1791212225; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Go9hn601ofYGhTbmTXvodFkeQSZutx3QY5olFYU9dfU=;
        b=ctG+Y3WSq7wPpkwHVlmydJSouSru19Ur3NfkABhz8Ru+f/GyrXX4qYJ+kUgBJRQTBu
         4mw+a+FxkMjFVmHWFjpJCpPBLDeg4RNpMCR3v6nTlyyMQovDiAJBNWZWgQu6oi9as1nX
         yn8HIfXOKeC3m/FYO6GUdEWY1tT5iVNiF8XY4WlZTqrDMhBNV5lwY6KJevhpo+wPDY1x
         +0FQRmrIFHvnh6bXSWCFzBnsnVWS630FjMhnUMLJnXGMDUyvXQIvc1Sux+4bLAGNFJ0Y
         /QHCWPhnyJYZ0D2Kds1hFO2musaQRnyBZTS2rLkORXE7dl5YX+iWNxAxwbdCX81CR8MC
         toWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790607425; x=1791212225;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Go9hn601ofYGhTbmTXvodFkeQSZutx3QY5olFYU9dfU=;
        b=sL8GzpK7w4cGFyy2/KPUmTTce3PxuDgXb8hlljJ0RYmJf6gyGFuyVOmbypzngbdfXX
         S3hzY21oJuTkPgWDr+x0eu04laKQy7G90a8Jbh/StYTZQvqSdRhXXHzABfad/x0vKYhn
         DY67TkgbnXP5EnKGaTEnY+kjxc86WJiyCPOSgM+47oNp4Bp3x9lxanSEHIY7MHtDKR6k
         WxYk2bDOzS1ovQj83N6tVOpKlJsn3jbW93mZ6R3eFHMG59uDVvzqgyYlkrHcC/FBb1dM
         bDocOkuQ2lMdoYgDmlcYz14V/Ge8jJz0X7WJ0oj7+8WFR8Rweg4rdTzXUOwOfCi+7a94
         GXIA==
X-Forwarded-Encrypted: i=1; AKwUvBwlWgKHl6kaDYxJFUdjH2SPY/SuLh/PQIpPqeJAPI25DynpvYBGek/a4EOzwDaZ1Z0pZhaG9w==@lists.linux.dev
X-Gm-Message-State: AFq9FYIbqdKSr30q38k6csG8653rZelS/JKDaA1AfxfQKpdnD2gVH5+q
	ExRYl0bdBQbS//L/KuNGWxVW8Nrt8lBc4QDOE7PaTVpzxIfyLXlNfWuptIud5x9UmQ==
X-Gm-Gg: AYBFou3POpFVxQqoPYU1tniD9e1tmVK9b8pU7jgvNIznTv/7T8nEe9n8GemCHwxibt4
	l4V0zp3csqKUVrhOJgSOlIVMbZtb7LGyIQ8JoWxgSvfwSRPn37670LlxWph0TFlMns9D9a4AQuu
	8cr9igFTR/yFoJkuh2KY5SxK6zWULH72aLc1ELq3eZxmstmUhzIRrEhfjcKlFjcc7dQuABnh5KC
	SG3AYlqLw0DapEaaZNlQG/EGLD8J6je5CMNYDPw5Fh3rMydspBmgvCtbXPycjVNxxhaJH10Hoza
	8b/l12qkpwPx52QVwYFyArRGpz2KjC2jbRd5t365KRfgYP5Mt0Dau/TWJkoMHXG6vP58VIh0PIx
	844JAV/wffyqDKlKdt4ZTMRxmKUAgEfRbzS56KxAJApHuCL/sRcRhITTJQjhW2PxyOJRc5aCAbu
	7YUxwdQNVqW3DYRaL8fwvVrN4qosVPVFNynYGBZhSA+6QtUSk2lJ1dUI6LF0hKCCMSbXYNFReUO
	oNeL8gaoi6bLN+h07KD0XU6XS9WzHrN6uin
X-Received: by 2002:a17:902:d4d2:b0:2df:42af:2f9f with SMTP id d9443c01a7336-2dfa968ef1cmr5442355ad.1.1790607424172;
        Mon, 28 Sep 2026 07:57:04 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9feddd0sm7198628a91.2.2026.09.28.07.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:57:03 -0700 (PDT)
Date: Mon, 28 Sep 2026 14:56:54 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, David Matlack <dmatlack@google.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org,
	Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: Re: [PATCH v7 5/9] iommu/arm-smmu-v3: Keep track in arm_smmu_invs if
 range invalidation is used
Message-ID: <arqANvAwIz6GSXJp@google.com>
References: <0-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
 <5-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>

On Mon, Sep 21, 2026 at 08:55:13PM -0300, Jason Gunthorpe wrote:
> Summarize if any of the inv entries will use range invalidation and if any
> need ARM_SMMU_OPT_FULL_CONT_RANGE_INV. The next patch will use this to
> avoid range invalidation pre-calculations unless the range commands will
> be used.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
