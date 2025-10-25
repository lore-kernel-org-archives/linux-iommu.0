Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614EF302CB0
	for <iommu@lists.linux.dev>; Sat, 25 Oct 2025 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761406232; cv=none; b=GtF1cBAbF6wwdko903lF3nY+Jnj9HM4e3lNsjN16CMrYZ/bRLSxlQgPKladiyFiNlXOlsHsLnfkFKbJFJ5it0mZboFiGevPg3mfTMniEtofBGpH6BP8cETG9PkyHVrUU/ep3MkXh9+KiZ4CcV4swIwm2M1j3cyTVq/cqMYlElXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761406232; c=relaxed/simple;
	bh=YQe91ROlP9epeFIBAVeb7AxK2YjKLaeOQX5QP76voII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxhNmtcgpuCqD+zwpqropyll74TadkGtSW54TPoAUZ7kBes7xFJ9A7x5d7jqv8jCVVRSF+GBLDv6rqYjlj6yPdQaKrm4H2x8VRdkwAW06uNUhYPavfwevvIVxm7w4+t+bAXy5d8ScxiL9BDVDzqM8eMDmIl9Y4zbelKxigZCIiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=LjG7MzXA; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="LjG7MzXA"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c45c11be7so5390938a12.3
        for <iommu@lists.linux.dev>; Sat, 25 Oct 2025 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761406228; x=1762011028; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQe91ROlP9epeFIBAVeb7AxK2YjKLaeOQX5QP76voII=;
        b=LjG7MzXAPjqtnvCn3OJO0gaiIS0BXh6jeqWpG+fmNWStQa7Yeu3OBIxuiUmpMTB4XK
         m2WXtzYIWlAgOXmF62Ap4+PYDzA5B5zr7VQOAP5ZRrPtQvhvkQYvkWi/ssgYtxO7iH0x
         GBxl2YAZ4FiBvTsOCdG3HzGUys1lU/tbq50euwGL25k4A0rZS8irYiOcbQi6u56i28sx
         YusWZeXlO+IoJ9949Pc615oIYVnEPLu2LLV0aRzNG5YJi5DY/bYxDzliSKHW4JozxW7i
         lhv60b4F/wlJYeLrZPN8GDBlGZGJGfr4SJ+6u7TVOrzJ0qaBrhyHG1dp7XLYBQzccjFz
         U3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761406228; x=1762011028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQe91ROlP9epeFIBAVeb7AxK2YjKLaeOQX5QP76voII=;
        b=FPQLfjt+80LnuQMdZtHG7x9LBGoVVXc0nc+hmcGmcpHCyYC7NoyJur7WeUaYagzADF
         oC/trU8ui5LY3ZtAPgqhC1lW/rP0LqV+mNtuzzYg/gyK1OmJz4SJdPkhMEUa3uNcK83g
         AvS7duGLZXhOdiYSlX2B/EaY3gb+lZt4op4Drr2z7eLoqOGrrX5ErGk8C3s3Qt+oOo+Q
         xsJN8Oks/BLsIO2jJmgKRtEBibVQQeKql160TXjxm+mrZ/LSnerVeglUAR58IMerQA86
         QewDaHznl1iRycSUXLrfvx1bww3+F/6YiK+tnOl2O6moY2v1zUqCUdPMbs5RGzVnE4as
         jaHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9VIAkGDMB2kpzq9ywwmdRpjGnfims3LfYynID2xXOnoTghwvnup4pfTiGfxR4ZPZK0KwMUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJEzDr/+PF1mSXdvJRwDqNAVIgm4WwCsD4YWvVtxdSN2cuOlgv
	za4IEFZdeMqIGKdL0WMf9PjtmUNvJpV8qGOwyyDEm/r4b8OoDak4eVxKnvRQTj8hvpsi0YoQnI+
	z7li8qQepOZLk5x0gwg2QuldywpWaY04GF2UMbdBjsA==
X-Gm-Gg: ASbGncsBPIY0qGmTjGh8FrPbjxaGAToWFVJ+6RWUK2pFnVlY7l1O5z6w5z5+xfwVsU3
	Cwxj1cfsQabCHeagbB2l4mTPKIPkAfms/PoJ4sZUKV3PyHhANeJGr2+4ZpLNhUjKh1vzCbgW0Qu
	YuWbNS/ZOtPzCdKRXDFHc/MjjvVICDikjAeZ2nxHjx5boZfI6qvONCQnQs9sO5zJtZnEJUse0hT
	i19HllH6vwSHfFHY9wJRnPQnZE/jsSGopKUc6xuCybKKcL/Z9Mtw1h12w+uGLoXSkIDUPaNK2o5
	8oBz/hzLmFElcQlIbtZ78rELjL+l
X-Google-Smtp-Source: AGHT+IHyii/MACqqA1gMbxyh8CZfZM/MVeB0dSh2M8XUI9vv6+1k3VQ9IQ7FPNSu6S0HuT0ITqx9emJSEDbCLG+Yc0Y=
X-Received: by 2002:a05:6402:350c:b0:61c:cf8d:e51d with SMTP id
 4fb4d7f45d1cf-63e6007d198mr5362602a12.22.1761406228044; Sat, 25 Oct 2025
 08:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com> <5-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <5-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 25 Oct 2025 11:29:51 -0400
X-Gm-Features: AWmQ_bmUOgV3_0ASbOM3QoMzXfGDVzgu3GeEUS2HtNMs-zqEXMaBdqidVXde5tM
Message-ID: <CA+CK2bBHzGi-4dqXeQn+OvahYfm5miKEhSuVmYCpo=Z4cUdONw@mail.gmail.com>
Subject: Re: [PATCH v7 05/15] iommupt: Add iova_to_phys op
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

On Thu, Oct 23, 2025 at 2:20=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> iova_to_phys is a performance path for the DMA API and iommufd, implement
> it using an unrolled get_user_pages() like function waterfall scheme.
>
> The implementation itself is fairly trivial.
>
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
