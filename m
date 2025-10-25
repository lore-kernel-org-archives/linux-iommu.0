Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B932347C7
	for <iommu@lists.linux.dev>; Sat, 25 Oct 2025 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761405359; cv=none; b=M7iJNKAOYELsMA6pBkf7xn9NXAmyRiRKCzJBno66yhM2BbkJBPImE6K5HSlS8RbeCymDzovlp6Fb3E5eRqv0ZpzIzRs3xaflp6H2BdkyJMBgce37RvIzzqARDIrac42shheFakMSa2Z+bi24E8cIHXCqjaR6nG5+s/1uPYCRtM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761405359; c=relaxed/simple;
	bh=bi4GMT2iyyBr9MQrD3T6o1udwx+0fc5659kLbgfo8vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmYYOIeEllT9o9JQYXDa156eh2RMQlg+dAFPG9TAhKEABTCHjYtO0LQEkvBrzwOjQWODPaRLG974HlfXA4nat6viWQkJSxsEUDqXWKaop/abapC6a80WTbJGMlfVwC8elzstYr1W1zw80Ty/PIpZ7IHeHzn/43dvaw1nEzCfr2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=DcIBqhO3; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="DcIBqhO3"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b472842981fso410174366b.1
        for <iommu@lists.linux.dev>; Sat, 25 Oct 2025 08:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761405356; x=1762010156; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bi4GMT2iyyBr9MQrD3T6o1udwx+0fc5659kLbgfo8vg=;
        b=DcIBqhO3Sy811vmLYuKx6Gb3nsRFo/fk7RBB9zKPQZCY85FvDubFhACHXOxT+89AnE
         bSWe2l5fphjCoQF03PYZga5hIFDBwaX5M2MaGxNUF8kpRpy7ya2oxzP5EpG0SBSuejbN
         wxg6+CgpNFq3z9CmSTKXH0u5VZYtRyrw7WlAQpKfavUEQHpF5Wub09D+b6W8one6/IEN
         U/VUSOpiyyKk+nIgSZq0LIApyI3Xm9hDYjxU0SqmzO4Nr8geKbLGmVOCFpuE1s1lj8n5
         CS2QrFrLFlc+ELuAscRmheq6gCTAWQNRn1GDpjDJm/pF4eEdExIx2BXRGwYiTHvvbOsx
         yBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761405356; x=1762010156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bi4GMT2iyyBr9MQrD3T6o1udwx+0fc5659kLbgfo8vg=;
        b=XKe17vLwF2Y+oQ4h2xf2VRLuZW6K2ssQ1N9WyxCxTKMKaVdAg6XMF+EaJKIXRFgJ3k
         XsF9eHNemv2FUQK8Qa53gwaV+vaZtV1Dx/nxZzHnYPYOhRn+ZhN+6ejJ0bRt9XpHk2m/
         8YBUgk1xbfzd2j9BUYo83QtTxGBBisTL7fgQKBEIfrLpMBp/HtMgcol5Kv7QSl8/ck1u
         cVMzqCDbNNCXnNhgDH/KrkMvEVSKHbSBqFzuA7N5QJuTvW7Hys7fIPHYzDLXUGIfbFkS
         8inuAq3QP3HBtgJnJbukP4ZgeOKtm69vDI4LApWhF4FAnBdLI1mVSPorx5XZT0OpzQJF
         3neQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpwEr8oPCtYpaykxqdVrEO+1U8NQ4t0PANpEKFwkEaKoARVQTdpcYnPWp1ybAZ+n3zm6fTDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZ1hfUXQbaisSwJxGmFg8LSrJPnmSWoh04Try6VbdSmQaZIW/e
	RLCupF1kjNdShwHeRE+4CwR3Hw+CxIm/vnvhRXM3nWE+VVapymu2/Z2xRy/JvfiDoroQR1qUJXQ
	2CjE/qor1s0Oxd8n7WtngM9C4sGg3SM66UUCeMj1I1g==
X-Gm-Gg: ASbGncs8PaPpoX/YcIa/dh/3RhPS53emwwaQ74+buJBXmCkLYK2qMaGpH8lRN4xF3CM
	JgWUQ5aFLJYgYgvQ4eE72laL69JNIr39VApigvICZTr8AqnwI1yJ7jPkkbNKmMPAo7nS4IFffXs
	QTnt1QkeJBf4NZNzUyvt1w1rh0cb9mAV0Nk48JMW0iGby8rhuCT1ibPp+YnIScZY3j6Xh/7Ibgu
	8fZv71SQ59QzkVpuzmR0NEiEf2RUA4jwc6SupQLp4KiinwTexU2BGPapoXoyZDd3UgqXjB+xpxO
	9olR2s103oSlJa8gIA==
X-Google-Smtp-Source: AGHT+IFCiIAROvFB2yMO0UCR+4ZQEZ0s8jgRn6oQbNbO878Y9zbld799sNxrnedeLYq8Qy2EigSbEXq7Bo6P6npPVMM=
X-Received: by 2002:a17:907:5cb:b0:b3f:294c:2467 with SMTP id
 a640c23a62f3a-b647195b32emr3912611266b.10.1761405356545; Sat, 25 Oct 2025
 08:15:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com> <2-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <2-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 25 Oct 2025 11:15:20 -0400
X-Gm-Features: AWmQ_bmbZ8u5CogyggVXgDbcACzApTnoI3lXdk_DKTEGWhLBxFj0guiH9QhsMTM
Message-ID: <CA+CK2bBpunzb9yaQE91NYfp64xSSuRaHW71MC=3bLVfWsHBDzA@mail.gmail.com>
Subject: Re: [PATCH v7 02/15] genpt: Add Documentation/ files
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	llvm@lists.linux.dev, Bill Wendling <morbo@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, 
	Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
	James Gowans <jgowans@amazon.com>, Kevin Tian <kevin.tian@intel.com>, 
	Michael Roth <michael.roth@amd.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 2:21=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> Add some general description and pull in the kdoc comments from the sourc=
e
> file to index most of the useful functions.
>
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
