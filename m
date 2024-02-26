Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7A5129A62
	for <iommu@lists.linux.dev>; Mon, 26 Feb 2024 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957182; cv=none; b=rYVllt+AbeJQRrHeAMh+DeacYns3JPJ43GpLx4LYWtcNHl9UJQ/boUQ+6xs+PnpABJjbXQUNppS8vkrOGIkzjY+RlXXJfagCvx/q0ogJcM4D0j+a7qOQrHJgB1aIKNbDL55Bcr70nsgJrhenAdbFx/OAImb61Om0RRZaiY81VeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957182; c=relaxed/simple;
	bh=gai/GiGBgYJiOyrG+mmY/1tUlW1NPiRKQw3ns5tMD68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2hJwMwr2vZX+08+dLvM4wJ0bZYN5ynFEKybK33BZGY5J1XQA78GkzZXhIk5J+hk+WuyOOZ7dWLxX1mL+0/zj6IjECQ2kugYKed1LTFKt2pnT1eVG4QKt5H9/uAk4SWMU0nsUORL2+wrRCvgVfIIccMCW2J/H7T1fFiQZ8tjWxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TcaotAr/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TcaotAr/"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412a390347dso8815925e9.3
        for <iommu@lists.linux.dev>; Mon, 26 Feb 2024 06:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708957179; x=1709561979; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gai/GiGBgYJiOyrG+mmY/1tUlW1NPiRKQw3ns5tMD68=;
        b=TcaotAr/CUo2P4Qo+SUUX0dZkNBRSADGpQuMiuE7YwQMDwJ7sIaOwM1vHfoIBaiJzz
         fVyHqvXgETlXrtyXIWxjU3MdeOqGsA4tV6/kpOeYHKlNVIfiHi+NSH8dDD07pgCMagkS
         clBexnygNtKdeJJ7u6LsVAerksOzwF4YsOb/NmxLWx4mO5uheg3H9XGN/+Rj/DEr8/dW
         fGLTyYu4QvWcVZ4BKqP4mZ5TTy4CW7WGITJKzSIXa00fuVBTYxvduUsPsxJIco/gsqs0
         MtLmP/4+1Y+dY24KPhhJ0lhurMWL1vbLV+dTOFA+fgNJyTMYbAOB2VgMaUoo9ApFCrIE
         XXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708957179; x=1709561979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gai/GiGBgYJiOyrG+mmY/1tUlW1NPiRKQw3ns5tMD68=;
        b=Cppr8zvw+tlgdjCykJZ7ULA88K62KDqYLPVD/gUzczutqvjUGsQMZH4mdFBJgC4Nar
         xeYgrCdKHzVM9RrSFqPIhzpmryRD6Dfzmv/SqYfSyU+K87qN17fwaPCW45PGJNgD8mpv
         TI+EdsrRfcITVKa+wawMtSDJ43K/rB/11+yz5wPBJKP1J3AlZVhu0R4cZPpv4ypd5eqx
         zea6QwEmjGRKx36B1meQyYuLfF5WpSzPBwFwJhtdFMuI1oLUpI6Q5WFxysQQs7gK8do2
         VUa/8P94WgJmFt120pokHOO9/4XnUcDrkKLAKw+N/iwBjzCYNmjbxP3xYbcZVwufRn68
         /MjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8TQ5fpur0DaGIJ8TgU08oChjAVbS2HqpfAlmk4ykmWpns+FwhxfuFEDMDfeQhZ8oMBaAqrHkWpV3ffsDKAKLbqylebY8=
X-Gm-Message-State: AOJu0Yyu5OgTEXpFkhVIR2IxahXsW3QgHTpZ276C0EyGT+yJlLYUm08M
	ZM2hJNO71YWuqt9hz0lmnd8En0WpNisnAy3sbqr9dPQHVLQyLVQnE0MWpMD9ZTI=
X-Google-Smtp-Source: AGHT+IEdNCnX1nw1wKmlDkmdLNh/bZj2Ejkr26vzdxCwCUpJHwjjuA0WQ0F8/258UyR0vtTBUJErAA==
X-Received: by 2002:a05:600c:524e:b0:412:a16d:fedc with SMTP id fc14-20020a05600c524e00b00412a16dfedcmr3592533wmb.7.1708957179481;
        Mon, 26 Feb 2024 06:19:39 -0800 (PST)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id y16-20020a05600c365000b0041296bac040sm10861565wmq.26.2024.02.26.06.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 06:19:39 -0800 (PST)
Date: Mon, 26 Feb 2024 14:19:16 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, james.morse@arm.com,
	suzuki.poulose@arm.com, oliver.upton@linux.dev,
	yuzenghui@huawei.com, dbrazdil@google.com, ryan.roberts@arm.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev
Subject: Re: [RFC PATCH 30/45] iommu/arm-smmu-v3: Move queue and table
 allocation to arm-smmu-v3-common.c
Message-ID: <20240226141916.GE1579460@myrica>
References: <20230201125328.2186498-1-jean-philippe@linaro.org>
 <20230201125328.2186498-31-jean-philippe@linaro.org>
 <Zc9PHXEn3IKFlzXZ@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc9PHXEn3IKFlzXZ@google.com>

On Fri, Feb 16, 2024 at 12:03:41PM +0000, Mostafa Saleh wrote:
> > +int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid);
> I see this is not used by the KVM driver, so it is not needed in the
> common file?

Indeed, looks like I've already removed this at some point

Thanks,
Jean
