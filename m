Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325DD2627F3
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 17:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715725; cv=none; b=ciLYZ4elkZpdv8IWnbrNBTiUR6+E0LQWVIK45PZEIt0jkK5fNGfgjPS1qb3aBgjp+yim240sVXo4s5Dsm7uG4ojTBjWLahV8hRP3YguV8m9uv6OVRu1K3jwoyHTCwcxfHFIKaAlPHefJZOhmb8Kk+Vu+yII/y0QTGAoSq0zvRs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715725; c=relaxed/simple;
	bh=mIjUexkbM9coqCh0GSL4O85/rHY5aGj04usaPjJ5KJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHIPkUqJAIMKDfGspZvV8C8tSCA+8UZXSAwT0MHxuQMnFNzEfhcaHnkGESnshU7HP6iIz+ukU0loumwtnK9FeVRlLQV3O+1WrG+qjePrgVaLq7q2IGku2LVkT9hJX0TmK5ryBBlurcDYrHfV16sIJASjbZ7n2MEi5L7ZD81qQ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OMycoYyb; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OMycoYyb"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so1626a12.0
        for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 10:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741715722; x=1742320522; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIjUexkbM9coqCh0GSL4O85/rHY5aGj04usaPjJ5KJI=;
        b=OMycoYybMWqWrqT6O8hkbkmy0XFzo7obdnAfj6rlDPhMr721YGAdxs/y7QOZq3G/7y
         hyWbMg33c4wV+mFLmoDPCW+qY0NF83GYIMG7EYIZwLqoIDdD7TGzCqlbBaeq6o5m9W46
         NVPqOveUhgE1vHYoKlAX8lgWzcD+wdViBAWDOaYKg++LGwIUOuLmEzGmtUW5J0tMlXiZ
         ytL+sg0f+YAG5I/BLJ8mOLEQZWRuakG6c4X7vM1mjP0WfOSR5iE5ah1zCfd5RGgj/Q14
         U00d5b47m5P0MeBMxiLjB1unUodgZeLDeMEcTRJHcO1NVHN2qfjJKRq/obNxXT4VMI5w
         GfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715722; x=1742320522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIjUexkbM9coqCh0GSL4O85/rHY5aGj04usaPjJ5KJI=;
        b=WBHgIOlCILzkIPDGlo3S/tMEY5FhRy7AXA0XBCr7L8r3bMrwBAhX6M6wEV6fDcxQrN
         EjS/Lt01r3HrspK71V77vvF7903/CEIA2pt6jgMmckDlXnj4pI2hE8eA3Q4QissuaCo+
         X38hoG36oGlaaJUkdtSj3LVHK/zA9alAcCXSto+VWo/zWXuazkdxMBfRFNVoy1drPjXJ
         gW1CzliFBjWLj07j+QtqeWTYPhPldfap2cIq52GM0zeMyJ745gyIe8mhu4nkb+JlFWZK
         h5OMbDNXjQgv7jZuOZKzso7DW+w7w+WRyRFJQWn0i4BIXV2QeSwatCrxt/ZiiMQhq49x
         qDCw==
X-Forwarded-Encrypted: i=1; AJvYcCVQJFtauJ+rGifk65GGafepHeMVSRfAnWYkVGnr/fiVJzkugEKtn0dYMobvHPfqvUO9xG010Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUiHaO0zEdIW54owPyrewU+9qGn8SoZR1PaPRFjRz4NrZ2iQZ3
	P/h3dLPFVuLgAXL75Sw/Q1QrYOPC5yt7BudOZSeqQl/ypXP8jzvjQcKFggOn+SQllF2Ng2ikBsZ
	pNX8j8isXleQbDLWiovlpw/x5y7L8d4n7h2qG
X-Gm-Gg: ASbGncvPlmdwmoDKBDdtSlX1odRuxyu8njG1zaFZT7WI3vgsggkTgerJu70L7SSSP+5
	0875f/8kaWwebtOPBuTnaVf9HYzwLRsYuUxnXh+5HLxBAKwhiMtulHPEQ1qNbRkejo9Os5wbGS9
	fwPFSTuKs0A7PL1HVvIbFxiCgFpNcF5Q4eCShEThpEf2207i337H1emTSMLtLw
X-Google-Smtp-Source: AGHT+IHBou0AMnOc1wlERmQEiByjC9z6tx0SCc40GDDV97vQKc68PhQO6ik31ktuvMGhrIBUoFtdSF1c+d39GaMkrhc=
X-Received: by 2002:a05:6402:2048:b0:5e5:ba42:80a9 with SMTP id
 4fb4d7f45d1cf-5e7b2684877mr140a12.1.1741715722207; Tue, 11 Mar 2025 10:55:22
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250310-b4-qcom-smmu-v1-1-733a1398ff85@gmail.com>
 <6f5f2047-b315-440b-b57d-2ed0dd7395f6@arm.com> <CALHNRZ87t7eXohTcpFnejFAPDsyE_1g0aPsASuQ7y5c_zxnLUw@mail.gmail.com>
In-Reply-To: <CALHNRZ87t7eXohTcpFnejFAPDsyE_1g0aPsASuQ7y5c_zxnLUw@mail.gmail.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 11 Mar 2025 10:55:11 -0700
X-Gm-Features: AQ5f1JoKKBbJ5USMaxKYhA8jhl8TuOZ3b3iaSIOxkea3mVVta9KFMFOusPuFh1Y
Message-ID: <CAE2F3rB-ACt2rdVFYSpSap=t_poTi0-PxhgrYGg4vzjfic7vqA@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm: Allow disabling Qualcomm support in arm_smmu_v3
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 9:51=E2=80=AFAM Aaron Kling <webgeek1234@gmail.com>=
 wrote:
> I am working with the android kernel. The more recent setup enables a
> minimal setup of configs in a core kernel that works across all
> supported arch's, then requires further support to all be modules. I
> specifically am working with tegra devices. But as ARCH_QCOM is
> enabled in the core defconfig, when I build smmuv3 as a module, I end
> up with a dependency on qcom-scm which gets built as an additional
> module. And it would be preferable to not require qcom modules to boot
> a tegra device.

If you want to build arm_smmu_v3.ko, you'd have

# CONFIG_ARM_SMMU is not set
CONFIG_ARM_SMMU_V3=3Dm

in your .config. I don't see how this would enable ARM_SMMU_QCOM or QCOM_SC=
M.
