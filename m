Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE8B301000
	for <iommu@lists.linux.dev>; Tue,  9 Sep 2025 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442662; cv=none; b=VBwLPTQOPrZJRt/ZtemmyNsRDykBThg6yzDV3/90QEMlQnxQeyQIah2zUOpfPgS9NUZljMBW/v5f0CAqioWWKOxPdETQkalguMYFMTaMOGw1UVrJLjotlXzgbs+7PMFUuj83yWt3gVWrq6qtxNyz+A0mqNZ+Er7YjZVUZwGSXWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442662; c=relaxed/simple;
	bh=yM0Xnr5mgLbhYQekgENeXiwmJdvFW1b1xD3j7t4hWgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjVXaFs1nuUKCwLiXUmRbE9NfDE2E7DbR8hV04iYXdgy9LH/lXKKr231aJTuh6xAhv8vZadRQT4W2JN9QRNy8MgQ5FTIrS4Jl/gKg00Y+TZCwTWLtitAzi+R4s7DsUoRelgtVWqGWl6xWiN3fhzGkGa//W9/dBz4UoCLUZDRbQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2LHQ6PkH; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2LHQ6PkH"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b4bcb9638aso80071cf.0
        for <iommu@lists.linux.dev>; Tue, 09 Sep 2025 11:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757442659; x=1758047459; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfxcLFfDrPkIJiNUWhVN3N4fK2AjPT82pZU1A16szcs=;
        b=2LHQ6PkHHmNAZWQtRjbtwTyiNxL+fK5tUPzjW2uZPxsVY4HEnjBE11mfIulXoZQ+lT
         H57MJc2mX6eWEK2BDZ8k69Xfpt8Vz+u1eAjPhDys6Uc7amDfFBgyj2OQqKBIp4Lt5Ms2
         KHhC2LO+pmsqx7v+TMy3N23WuPz0L+nj+Q0bJDrI+8CilygncLEJxD+D1vrM82GZnekc
         DNuJOwdx3J2LU+RaxEqu8lUqhTI3L0ct3DPepCagWYgWihQ5lcyieQeOO6yY/cjCwcD9
         UGShd9x9UxHb5/koXqwc11m3PhJu792n8iVcrwrkwUquotfb4xeKA4MFmRP4/3hJwXe4
         0A5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757442659; x=1758047459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfxcLFfDrPkIJiNUWhVN3N4fK2AjPT82pZU1A16szcs=;
        b=V5jM2ISRPCAb3qmTVhh2p6DIdTYc/91DTRdMlniFWn3JB+xjZLwwDGXOKV4vndpzmg
         g2RAdCP3Z33EMAB+Xa5g7pAo4lRz9kaKb1+A7Gg0Thoc2sKIwIKaIgrdQkwNhJNsTsMa
         TzjoMIDX9fPPvYp4eGePRXWoSTLwTzWEf+VtrUcSA7TrG5IfcktWeEi4bZMPBNPr/7to
         1SNAjzLbkOb7k2ZqoK9cgKJvP3X4fOrPwwosJln2xZup9dmEsf4Va4pG5DO0PcHtug/c
         0lMo0QOXf7c0xG5UuVndpqDasJmaQFaxeq21ycVjHdpViH/OK1aLo8h0FwM8k9mA1u95
         YBmA==
X-Forwarded-Encrypted: i=1; AJvYcCXeM2y35h5KoiFq2hMb7LdwoFSbjNZ82jy7r92TVtqP0XumYJ+lttqgTXEAOjkxPhUwlPoGjw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2cuvnN2Lf9Hc7+cXhRnhzAspSzhU2Msze3f0M5KTXs1na2gY7
	23a3GRRg3dxjc+rky0w7VMQ0ibwfDVoHKzOxeFzFgmitk1TEtWeITvBx+uLYgHp14zqPKuiVOWN
	SEEpr3Tip+xGKB2/ia+9cSfkFbGYhp7yXCXXLoJnG
X-Gm-Gg: ASbGncvc6YKtaQuvxaL4VudHR7DiXhcNsq5scuEshu7g3CPaXydJ3JR6zpH91Z9E5IP
	cX+Xz2CnvUpizmIcDX6QvZ7WBZzzfm+HDev2UnCQ5yNUe4M1arxLM40hn5DR72oBWWpTpa/Vgxc
	7A3YALcUzXl1NcY5r8qfZ18jQgmtl9r40Co0+Z4mQyea6pTI1faalObUh92bsln9tAC0Lkrtysi
	EH7DgMbQJ8m4SrY6GkWmQ==
X-Google-Smtp-Source: AGHT+IGf+Q8hPzzej9xbfaEr60LoJgETjDgKDHy0ML31wiaO21T7Ktg8vRU8pvPgmGyM85KMJM70NWIugrUwyx3yAfE=
X-Received: by 2002:a05:622a:14e:b0:4b4:979d:8764 with SMTP id
 d75a77b69052e-4b62569f89bmr232071cf.19.1757442659042; Tue, 09 Sep 2025
 11:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250819215156.2494305-1-smostafa@google.com> <20250819215156.2494305-17-smostafa@google.com>
In-Reply-To: <20250819215156.2494305-17-smostafa@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 9 Sep 2025 11:30:48 -0700
X-Gm-Features: Ac12FXyo44kEPGnZiMSM0NG36OMtjkd65ZSJDU9pCejgoL2I9Mvg7O8L88TNYvU
Message-ID: <CAE2F3rDc-4SirDDrQeZJQDqjdv67-QFfQhHfwyd+O6f5OsBSpw@mail.gmail.com>
Subject: Re: [PATCH v4 16/28] iommu/arm-smmu-v3-kvm: Create array for hyp SMMUv3
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	robin.murphy@arm.com, jean-philippe@linaro.org, qperret@google.com, 
	tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 2:55=E2=80=AFPM Mostafa Saleh <smostafa@google.com>=
 wrote:
>
> +               if (kvm_arm_smmu_array[i].mmio_size < SZ_128K) {
> +                       pr_err("SMMUv3(%s) has unsupported size(0x%lx)\n"=
, np->name,
> +                              kvm_arm_smmu_array[i].mmio_size);

Use format specifier %pOF to print device tree node.
If mmio_size is a size_t type, use format specifier %zx.
Align language of error message with kernel driver which prints "MMIO
region too small (%pr)\n".
I'm wondering if we should use kvm_err instead of pr_err.
