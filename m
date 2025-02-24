Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB61A0BF8
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 04:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740371912; cv=none; b=OF9apL4IPkMi0n8eLHYdTh10YqjExpdxtxXGXiMuKGA2Xkk4NEZYHaXPhx6/6dQ9xHYPQPBu+qegoM8bCudIe/j/4z9BvBEXpkjuR/4E9BRLxPjaYK8T76TuQUYvluhTwPR+3UZfuMtmTAG8uLtpzRYLKQXdusmM1PEssKTx6fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740371912; c=relaxed/simple;
	bh=Kxoqux8ig1bneZc8TPbOtwtdCXGrWd1siptghYniyZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKF/pLECdDnVJM88qIogWq60+Vw10iUYUOOgWaRG7HedtLDyOlngMv5z2dmNdA5kNwfiJnOltkl5XNlBKYubgpLTA+a6Y7p6cVjUzOjpS/Tfq/3RL21+exJcvtfKfxzTZ8DM4diyEuotbSt0137HheDG1DlVEv/UAw89VeARj7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nE18YxXO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nE18YxXO"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220e0575f5bso256135ad.0
        for <iommu@lists.linux.dev>; Sun, 23 Feb 2025 20:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740371911; x=1740976711; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QXOPbjowj6Hzwuap/XS84BFQBW4l8rdr65xne9mv6JE=;
        b=nE18YxXOOaC8szMw2NnJoM85RcvyV0EpGhFAqyYpNxBuD4VKy23Z+92Fwn9AlFR3lv
         yAAUzXZ4ZPFLv3R0gj4/YV3mBaAmxAmHWSVpWpAEWje1ydqz3vEbGkdBgGrwI0SJm/Ch
         5HMfJfCbZKm/aC8klXSM2n9Yt+mnlp86Oy7kjHB8026Z8hBX8p0F36tsj323r0FuqqN7
         TJL3Qe6p7thihKHfCVZbATP0nFd2bhCLarrbfeQgWcdmowUd+TnJr0rNyQmL4SLoo21c
         VdhMDrbNDDBtMtVsoKG6QOpSesk1F6cH+kmbz9q/pPLxnBAhr2bY8/BJ8UrnCX9g3n8q
         vtsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740371911; x=1740976711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXOPbjowj6Hzwuap/XS84BFQBW4l8rdr65xne9mv6JE=;
        b=dp/czJYTgM3L118GHWgRbr+LuF84S6AJuAKA0C00e/tbQSnnMjcD/wsAmFAL9/DoZ8
         J4ZhX8+VPhUxNeq9A45whnenxWU+z+jCLFftDp9cYH9/CzzRDQ448hky0Q5mRUl3OCxD
         FbrM554oj6r6SZHT5HWsDJTxJ1BTPeLqSVZEACwMYnoHO1LY5yQsCXwI2mSwMb6SkjeU
         EnEuodVJASVOSrlwGbAfmvBRhiT/ZBq05GC3N3xSjS+rI74yY62NiOexhDS2ma1UEa5p
         /VumpSWl9j+Iq3CtWRmaBRhTDcUP0Dn3n1KzNUYSKbCcSAMmoxoOnG8vXsByrxFBM3z2
         0b0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKIBxM7yWaj7lRPAA1j8lSZghJ8IEXB42ngMCxMqtXWiwlkNEUkxkvX1mbnhedSTVQeVQgHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywis5K/5pSnNAlVUJYTaCef47l2b0UWGgd+d6MZjClyVFarjuhr
	UvnYQBDspK3zOHfDXDHU42qhWiqJ5K2a5YbQVyIleIprhcwpkkhkm2JxKXNzlg==
X-Gm-Gg: ASbGncs3bWg8oiO/nfHu9oP5nZ7+lSnqjX4IMWwWRQTNxsQEaH0KDom8S5IB3hEzqL1
	Yy4JYK9I5l+ZuuR6M5czleYWxCGjLsN82VzwZbmfIm2fc+B+abNigS6458Jmcsupd01iFciYcnA
	qpbwVL5J0DK5x8ApWCvhpMrzXu1eYIVbwFEyRQ1ahNJyX7lyyCuz7hB07xmbEwBoYnDBDCrKIPT
	eEjEsazxiO5J7Ykkm8bBS92eac5vH3N7GU8wLrUTusPBa7SUn9KQWUCeEdBL8VaeO7p4/GseZba
	Coau9DFYZN4/wp1BXOk/bTHbsdTH4jykWvuvICXo0Xyn61673vE/Xqa51rxjIwY=
X-Google-Smtp-Source: AGHT+IEdLGzG2X3YEfsIyog+f9j0aXsArsFeUuMcB+n8G7DuxjBKyqLer9ZGTISS6pMA8Im0wRP9Ug==
X-Received: by 2002:a17:902:da8c:b0:216:21cb:2e14 with SMTP id d9443c01a7336-2226cc46c3amr2333105ad.21.1740371910429;
        Sun, 23 Feb 2025 20:38:30 -0800 (PST)
Received: from google.com (169.224.198.35.bc.googleusercontent.com. [35.198.224.169])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-add540f75f7sm15349070a12.46.2025.02.23.20.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 20:38:29 -0800 (PST)
Date: Mon, 24 Feb 2025 04:38:19 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v7 14/14] iommu/arm-smmu-v3: Set MEV bit in nested STE
 for DoS mitigations
Message-ID: <Z7v3u55JNDqveAuD@google.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
 <2b088fe8d2c7e692426b0d1f58d4f2c12ecb907e.1740238876.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b088fe8d2c7e692426b0d1f58d4f2c12ecb907e.1740238876.git.nicolinc@nvidia.com>

On Sat, Feb 22, 2025 at 07:54:11AM -0800, Nicolin Chen wrote:
> There is a DoS concern on the shared hardware event queue among devices
> passed through to VMs, that too many translation failures that belong to
> VMs could overflow the shared hardware event queue if those VMs or their
> VMMs don't handle/recover the devices properly.
> 
> The MEV bit in the STE allows to configure the SMMU HW to merge similar
> event records, though there is no guarantee. Set it in a nested STE for
> DoS mitigations.
> 
> In the future, we might want to enable the MEV for non-nested cases too
> such as domain->type == IOMMU_DOMAIN_UNMANAGED or even IOMMU_DOMAIN_DMA.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 2 ++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c         | 4 ++--
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
