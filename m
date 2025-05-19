Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60400D2FF
	for <iommu@lists.linux.dev>; Mon, 19 May 2025 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689348; cv=none; b=kOj3nL/Bv5JBfM5+OetsolXmNbNWlS6hKD7a1x0EFe76y9FYPx7p+KeDaV/T+vjiPh710F80NCSiOGXQffFEnUnVsIjbeUBkp8GhJvLRfYASB/jl4OgruorOMsBW9GBYM9U3ipkNEDJkdHWykiAXx+Yv+0Pl8LDR1oqGWbTUA3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689348; c=relaxed/simple;
	bh=muFhmXyLo0DEmnYrqAEiQ7Yzh6caV+km2177Wl6cRao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLt7ApGNa19ssbx1BwQsP0SE1De91mw+IAXez1dZw0szRuvmSTRaQ5NjbFcEql7KkEw0H+R8P6rhUUkXu8AIq+rptMaxEEqcALBIP8+hqIFowxyFTJpe8z9P9MUO/BTzmRWR888zeaROLitr+zdgqlzzk5i2lDNbgddTFFCmfkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O661XUDL; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O661XUDL"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad5273c1fd7so809634966b.1
        for <iommu@lists.linux.dev>; Mon, 19 May 2025 14:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747689345; x=1748294145; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xfCxvNrNXH6YMvxiBWl55URv30Vk5ImyK9KqXeiCoPg=;
        b=O661XUDLI0Njm5FAYAbAhxKlZGeVY/lVJfa+ZYeg2gQO0xmLMFcj1Q7AmLxHlOFFzA
         0505juw+CAMz5N3ZOT8eE1yOax7Yq1UOiTt6EneSqyb5vsrkU12EbRe4zA1u+lhxqVPV
         sZ+bkDeL9vG9c/Nu1Scxz6doNWyROfwo5WKdqKuO6FGFnkDiKry0Oto+u6FokWe8btKa
         QKmEQa2n4bP+I8225FnReqwRpo2naycfoLmJg0al6ezMIAVMGmHuHh9ySTTncoD9N7va
         wPncDOEbYnsCkoWOgXdvPga8i0vePS8JjJhUMeF/FlWFVcArm6yN2qsfROOgOfXqP8ex
         uhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747689345; x=1748294145;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfCxvNrNXH6YMvxiBWl55URv30Vk5ImyK9KqXeiCoPg=;
        b=I/FiY9IwTR3ynb+AAHPZG8GBjB7Fh53jhamUpOHZcoe43gMPsxiwKK4msGKTPb6zKf
         W9OAL0wVHmAaHa/Zwf/t7M4wgCaWe40FUvgGw+3w3fBu4BU+03/m+pZF0Eq0uFmJnBN5
         Pk0k2kQBdpxTGL0d2toiz+Kb8rr/fcSoHa45xzDjKIJuUtl+bo4YTtAcjy13OzIa6eHR
         HbQIMDBKAifEm4GO9BFtOz66Y3C3b0DfPQXwe1oE5YoZT3yMSxqGK3PF2HBXdmTLFi8Y
         ro9xP1JXWFWFTw9R+IcTQVKyMzo4YJJti4pb/yWqWvRHHz/A0swlfT1eP9Gn1T/KKfwQ
         yH8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyO1JTDG8yOgX1uXlpUhxKUOO3ffOZG2PqOOmu+6Xrev5FleVCqyYANvJbRAk3j89zKVfJZg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzy0BXW8SxE3K39s4qNyxgZbFW2jJO3YrfoKc7ONdP71vSrpCiS
	yo/mUEJgt4jdB0mvhmiozBxH2I5J+/xD0zGuAbIOxZ6TOrSYNIZcro5EZfbWthOLX6gpB0po3Nv
	KPt5/0RYDUlntHDmhm6o3zEI9ExzgBXo=
X-Gm-Gg: ASbGnctrqfAipmljPEUC8mh7U97+xOqwKbyG7rkUNn1WMz+w/W1eOhAAz7o8FI3vMVY
	kC0GKBPlDpaAo5PdL9HHWZ89a9zBR3cmB6TFBUABQVfUhxJy0wRH8ecKEtTKidca+REs+msRUfC
	fEW9779vhLgnT/04iWpxN4JIAuWBjFx+M=
X-Google-Smtp-Source: AGHT+IEdHJ5TsiYJUOSilPNO+z3JABvgvB65Ct1aB4PjJ2fABaDgZlQuvx2XmPkklIghfrLSC+0u0HMeQGgesMbdSWY=
X-Received: by 2002:a17:907:94d0:b0:ad2:2949:bdfc with SMTP id
 a640c23a62f3a-ad536b7ca51mr1349013266b.3.1747689344467; Mon, 19 May 2025
 14:15:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250519175348.11924-1-robdclark@gmail.com>
In-Reply-To: <20250519175348.11924-1-robdclark@gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 20 May 2025 07:15:32 +1000
X-Gm-Features: AX0GCFs4JnXwsJdajW1l7s7toaeaNTWjF5f0e497pSZ8wodPL0eA75PFrE0O5i4
Message-ID: <CAPM=9tw183FMOT8uUacqegnb5CREAyr8KbXxO2mCuFK-SmUB1A@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH v5 00/40] drm/msm: sparse / "VM_BIND" support
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, Connor Abbott <cwabbott0@gmail.com>, 
	Rob Clark <robdclark@chromium.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>, 
	Christopher Snowhill <chris@kode54.net>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Eugene Lepshy <fekz115@gmail.com>, 
	"open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Jonathan Marek <jonathan@marek.ca>, Jun Nie <jun.nie@linaro.org>, 
	Kevin Tian <kevin.tian@intel.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	"moderated list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_?:buf|fence|resvb" <linaro-mm-sig@lists.linaro.org>, 
	"m oderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_?:buf|fence|resvb" <linux-media@vger.kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Sean Paul <sean@poorly.run>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 May 2025 at 03:54, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Conversion to DRM GPU VA Manager[1], and adding support for Vulkan Sparse
> Memory[2] in the form of:
>
> 1. A new VM_BIND submitqueue type for executing VM MSM_SUBMIT_BO_OP_MAP/
>    MAP_NULL/UNMAP commands
>
> 2. A new VM_BIND ioctl to allow submitting batches of one or more
>    MAP/MAP_NULL/UNMAP commands to a VM_BIND submitqueue
>
> I did not implement support for synchronous VM_BIND commands.  Since
> userspace could just immediately wait for the `SUBMIT` to complete, I don't
> think we need this extra complexity in the kernel.  Synchronous/immediate
> VM_BIND operations could be implemented with a 2nd VM_BIND submitqueue.

This seems suboptimal for Vulkan userspaces. non-sparse binds are all
synchronous, you are adding an extra ioctl to wait, or do you manage
these via a different mechanism?

Dave.
