Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0332D7812
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 19:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654259; cv=none; b=XHWiKdUxPpwEgws8el4fukWFthfz8gORr6q3vV9PQKGcFK9Igi/cpfZ00REO158GfoNxblE5X+haniPsbOMW1yMrhC84dVyVprTVMhlEbzn1g+MGYinbe8/fkFy53QDeiSGk1wsMtk8Ct23Gcx+W5plRd+toV8Wy4BLx3WSj+Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654259; c=relaxed/simple;
	bh=y5XKP/EZOwx3lugnWlSKex8y0sj0d381WUjpO2U3VuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceW7/hDOYR0ph+BRFl+PW46pgYsrtHw42B5DzdpAb7i/gt6USF+WOA/wyCWU2iu6+VcxB0Hl1m2AyICMqz8gkJ355fO/mspRullPVvv92Dr1fiOdQsyqaHd74/mNYM1OfasS/p7sQDdrv57pk4mkT3Pt5zVYvN821LdM/9kyTWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aXPw5eRl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aXPw5eRl"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2731ff54949so34455ad.1
        for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 12:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758654258; x=1759259058; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BVuSRD80cb05xRP8eCjDZvMC/JNrybFBLhN6uiPb/HE=;
        b=aXPw5eRlOjEVMxUl4XcXRS4/QZGZHjYZUl9jaPwctvjungBxIWAwhtyXEMMnjSzOqQ
         0a4m0beRXYD0r1BworRXqGPMxxtPguT1NRsrZ4LC/EWDmCuZUFWi0WC/3/9dautnHp7+
         Cx5NSOi6jkkgCZjIfb5MO4dWaeu46W50SwIbMTenSTrKxCm+1nx5gnv8VQp4Q1uKj79X
         BjGSR+5aRY2SUSWXnWQiHJPM1vwvvL7w72peQH/VcBPCKcuPw0hSwyRAbaWtIll168xp
         rWhmUFP0zyrhmR0sjCWEGtPff/8a9QR2j5l4yBVYXu+MOzVyiyuDQd4/Ipz+c/YiO2T/
         S7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758654258; x=1759259058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVuSRD80cb05xRP8eCjDZvMC/JNrybFBLhN6uiPb/HE=;
        b=fWKmZmvecPcqaSn7o8hafjZitWSEyIaYlvC5GTj1BaXJg4lPNp9fhUkV7WOfTp53nh
         lZUVwRlmtfX/uLhT5pzsyxGw6gHMfe8hmhpAHMkfOaiYnb2Nu5EQ1tbg+eA4dWF5mTUI
         A1ZZZcTjUWL3OnIQiP66fRJPLe00JWP9mE3ZUK0zsek3Wneqg8OQpUwjkQEx9TuIimia
         PZAKL1LnN5WDC3p40+Yf8FJ7caQnexgXfrRcCK469PYX8no0Rl1YjuhsPkp47aiZKlNM
         xupQKBV7EN4tvEuVpXuFVXKPDAJcRZ6AU5GyXoDWY8XB3QtGPAQGAe27oVR00K1pbj/K
         isoA==
X-Gm-Message-State: AOJu0Yw0iHpz5zMzjM2I8PW0AaMxVXkpERYgRZlAeYm72an3Ry65EDg2
	ZE+R1iPRxDiDr4yOS5bkwDdT7Bqc9yIXl/bLpe8VlIBzMvC9SH8HsDwbMcu7w97eUg==
X-Gm-Gg: ASbGnctzL5lGCHRE67FcANCEtkbd+w2eEHpFqvObJqr5VPNIOoyyfvOIOweKGuucgAR
	VT55TYB5J+cBnfBmZ63LC91ECqExllVtJkUu7Lax5ZRUXw9omdHAuOdU4r7FK7NFXntYCP2O/in
	hCFyOD4Lh8Yg32k1Ztq4iB3IJz6x3dxwhKs6BIgXCEMNcBp8UKyDAWiTb3DwkqR7uoSgzgAjpnM
	U2Nii5x+5jtlaYUrudjs2H/UTYK6IN4lMm4D3MohozcyjsiAKVn6eWEpobYZv2QT3zXcVRTmJf1
	mgYovQDURWWL2YByS7uyX3XFQK+DUu1Pkz3d8PwOkFC/NNq1NQIVPMNwpJMHv8n728N+d6omfrR
	n+VARxde8oAFXC8JJVzMCE/bfx0/tz9LURU+74OTrM9zV3ubHMFiZoPe2nqZlE8Y=
X-Google-Smtp-Source: AGHT+IGlm3sxbw3MtGkL7PIjJGczzrrl/P0p5+02K7dTiPLCrVjzmQQzziPhIyR/5DAW3Upq3GMMIg==
X-Received: by 2002:a17:902:e809:b0:26e:ac44:3b44 with SMTP id d9443c01a7336-27ebe858bf7mr777395ad.10.1758654257284;
        Tue, 23 Sep 2025 12:04:17 -0700 (PDT)
Received: from google.com (23.178.142.34.bc.googleusercontent.com. [34.142.178.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306085e6e7sm16766873a91.28.2025.09.23.12.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:04:16 -0700 (PDT)
Date: Tue, 23 Sep 2025 19:04:11 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, jgg@ziepe.ca
Subject: Re: [PATCH v4 2/4] iommu/io-pgtable-arm: Move selftests to a
 separate file
Message-ID: <aNLvK2xW7f5ZNYt0@google.com>
References: <20250922090003.686704-1-smostafa@google.com>
 <20250922090003.686704-3-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922090003.686704-3-smostafa@google.com>

On Mon, Sep 22, 2025 at 08:59:26AM +0000, Mostafa Saleh wrote:
> Clean up the io-pgtable-arm library by moving the selftests out.
> Next the tests will be registered with kunit.
> 
> This is useful also to factor out kernel specific code out, so
> it can compiled as part of the hypervisor object.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/Makefile                   |   1 +
>  drivers/iommu/io-pgtable-arm-selftests.c | 208 +++++++++++++++++++++++
>  drivers/iommu/io-pgtable-arm.c           | 200 ----------------------
>  3 files changed, 209 insertions(+), 200 deletions(-)

Reviewed-by: Pranjal Shrivastava <praan@google.com>
