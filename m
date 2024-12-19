Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C446221D8E
	for <iommu@lists.linux.dev>; Thu, 19 Dec 2024 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734606630; cv=none; b=FzXB+DAKVtJsP9AdEz4m7nRq4SYipbz1tk/5pzJF22/RhHHkz93JbS2dR9NtSR2jY3UGFHAkv/o+pzkG1/G7PRTqnjhfNa8WsEkJbqLdLy/N1Z++xnEwVPXylggIAIvrx5QZA/Rwkgo+DlRRAQrDLIeWDP6ddgNLEgXq4j2Q9Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734606630; c=relaxed/simple;
	bh=KA1ixWNP5WI3RizWmsymPfBhlXudCJCqwF4L4GJqyeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmYIaTUze+UlU+zdyr0UrCyM2jR9+iaxzuADnTKu1aYy5VjhVReOTgO7Uiofi8nMtbMiX572B50+EJQtABYiJSyK/ZOmZR/JVNNqa0nWg1NQjJiWsJOSBEkeleofGekJYL+0X3diMfN/9y5atvkJMs0aPfKPJ3qwfMz8pE5yRec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ygi/OeO9; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ygi/OeO9"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa66e4d1d5aso98826366b.2
        for <iommu@lists.linux.dev>; Thu, 19 Dec 2024 03:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734606627; x=1735211427; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d5b9H3Sr5EYFy0j2cHR9n5SDx5jRbjOaoGMUJe0iL/U=;
        b=Ygi/OeO9+UzbmajMc6vHkpvx2nYinn6BjP1ZrGaPTMbYfeGOFWuVT485m3FGl6l7mB
         1qZmFPWd6wf0ufvDw7jR2jWoYJuqtbQJ2v+cOnW5oTJsRb0PrHZQUIn6A+V8dhaV6siP
         EGoE17/0qDyV0LCYoIBfk9IqGAnqwgOnCixHIKnRpNJ5HtgJXANakRwXe+MfWI0uu6zT
         YTsiITXozmUmZjjBUpdLAs4Su82CO6k3JL2hZeCerkS+0GSA4OvsBxtdMP6eD1/Nr1/8
         bf61q2pUtPOVXknUUqsnqQjCM9j9hV4BW1JGqLHQtsRRw1nOSm+ziFUUsEqkp8FmLFM1
         GzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734606627; x=1735211427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5b9H3Sr5EYFy0j2cHR9n5SDx5jRbjOaoGMUJe0iL/U=;
        b=lR9eG1ie37ELSy2idwZ+c4J7Y+zpnKumJhhrrx3/VUggC7doJ9//IJ0T1vo+i05X3p
         60KE7/9tLWHKrjZpPGGaPYnPIYzk2A6w9DFslajr4fllRSTF4F1Fk80uEHpXn2ccKyMC
         RX9GGC45FK6R6Tn6asLxNmQuTTka5/M7oVBVhCMu4XuJixORAEpQPo9b+i/Ws4j+2yHz
         +Waqx/XfE6PpPB1v+W1OByg3egrX78NaBBueeovANWIFeJEKTHNosg+keeRf4MVgkGJq
         0C6XXHp5455mYo1f+OyPUr2oCkHpsFkq36Bb865FmglH/ZOVLBAAexuHu/ZZPOoEEjX+
         d1BQ==
X-Gm-Message-State: AOJu0YytZJrhhlogihwDjtBatcLgTbYq9YseexBhvgRvb5xfeGQ9dmsX
	JIdmLmZ05Azbo7p49sJKOv5fUPQyu708w6TYLRs3l9HxTMqTtSucBT2YwNPi8A==
X-Gm-Gg: ASbGncsh0YR/GP5P8XSPWb9WLwMbUNckfTDIiHEn3aFPolNELivH9vdcO4lMIOACHsJ
	z9liOlT1MCX7e3DuCeNg++JyXDuaP3+kzhSwtXBxaWD6F6+IGkXDtR5K5/ZqWvSA9nY73DBQSiN
	1Cv3Fs5NZB3l6stYdw6LpEDgUCjnZQgujTBFejT9PQ0LgvX/p1TtDB8r/gohZ/43ennrbjmM7Zr
	WDzlmAbSPDxP8g/9q2r/qetjlPauCiw7UDxOk8E24FqiHHC15l6MQFfh0sWRUHpMrhe15Jns3jd
	m9wzDJBgV2vikmc=
X-Google-Smtp-Source: AGHT+IG1QUopT3Ag0ASkVgubCSavXZGnEyoaVH9YZtChHHKZ/cqx6LkSAMoHjTC7eHCXPYeU1uUf5Q==
X-Received: by 2002:a17:907:7da0:b0:aa6:8d51:8fdb with SMTP id a640c23a62f3a-aac079029cdmr282978566b.19.1734606626623;
        Thu, 19 Dec 2024 03:10:26 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e894f7fsm54124966b.46.2024.12.19.03.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 03:10:26 -0800 (PST)
Date: Thu, 19 Dec 2024 11:10:23 +0000
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
Subject: Re: [RFC PATCH v2 21/58] KVM: arm64: pkvm: Add
 __pkvm_host_add_remove_page()
Message-ID: <Z2P_H4eahmrvhkIl@google.com>
References: <20241212180423.1578358-1-smostafa@google.com>
 <20241212180423.1578358-22-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212180423.1578358-22-smostafa@google.com>

On Thursday 12 Dec 2024 at 18:03:45 (+0000), Mostafa Saleh wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> +/*
> + * Temporarily unmap a page from the host stage-2, if @remove is true, or put it
> + * back. After restoring the ownership to host, the page will be lazy-mapped.
> + */
> +int __pkvm_host_add_remove_page(u64 pfn, bool remove)
> +{
> +	int ret;
> +	u64 host_addr = hyp_pfn_to_phys(pfn);
> +	u8 owner = remove ? PKVM_ID_HYP : PKVM_ID_HOST;
> +
> +	host_lock_component();
> +	ret = host_stage2_set_owner_locked(host_addr, PAGE_SIZE, owner);

Any reason why this can't be expressed using __pkvm_host_donate_hyp()
and __pkvm_hyp_donate_host()?

This doesn't check any state, so it feels like a dangerous primitive to
have. Is the issue the overhead of mapping/unmapping into EL2 stage-1?
