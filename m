Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FAC21FF35
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765554102; cv=none; b=JzmO/F/3IEJE1hV7R67FJEUlLjDCy7y/l8SLIMwTGtJVah9dBzYh3yvrDWDFniqeFdi2YEddVAeeRLeilWJtioN+B6WVeaMue935tswYhPpLro+sXdi6vMjUR+ZbDpBes96vtflv387PUGQedYZlhmp1wENt6PtEmnaxS7zkgAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765554102; c=relaxed/simple;
	bh=DXvytcOpbGo1jKvvdjOi6minbJGrWLE9ozhpxKSuBGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQk6HfJaqSEhHm8IbUeRX8OxRKxTMuLdJuaQFQ10xHTmImW4nsjSEsf1x4HiP8/dageGQCq3cQgMXuiYB+zmNT2eGSzgUcVZqjbAg+iSrq1kpgBd2fdpHAk4qYMenoWOyuLzDBGSFHeFgEwfK04B6eHE/ZPfS9xMbw2oVIt3vhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fLk+FYZB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fLk+FYZB"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779a4fb9bfso128815e9.0
        for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 07:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765554098; x=1766158898; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yb0mpDrVWWr4Uchsh7e1JfdRTz6GJRCuX0Lg98K6TFs=;
        b=fLk+FYZBV0r6hDDC2QRuyKZWYawIVprIeA5M56oR/7EWg7TaeGkjFJi3ecG/xGF/kJ
         aORqJbpe/Cy1Hp6pmM6ToTd8Ealm1s17UzkmP68MqR4QaSSBLPiMJp+JdK/xmLWhrT/Z
         LBPB8g/+5Bb9OfgEx/vTA6xlTEdab62HJrQmNYculUmEm7XvLfJ/iuM4d96lWMpeRvBd
         1KK5jO9vyL9eu1/uJ/ZzUZm3zARSa9ummHoobrKjwUA9BeRtc2Q3wINN7XS7VELlzzTw
         HapYQll/5J+dEyYa9mudK1bMQiYqeEnWNRlhHOUQ2pC8mf2gJVt3sqDVIvx3SSR1ssnL
         nt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765554098; x=1766158898;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yb0mpDrVWWr4Uchsh7e1JfdRTz6GJRCuX0Lg98K6TFs=;
        b=n5uj5EER1DW4EVBOleI/K9RqKLggLkk5pcacum5+wcuTrhCdrgBx9D0jS4H1WuWBd0
         SjUvC013VygKB/SBRIBwpK4KKSPt0hLLOtDe/gJUe68aT2EF6/PcT131tYcwDPl16oS+
         ZWUcnFeSfwgJx0+y7XqwlW8pWZlnLmsH9M59oyZ2jADhHhwj2/3k1NtqI7qXHNXdGpVp
         9P3zgThZJ643VXTtWgZNsnT9Z43z0NpXNV8y8286/t/NF7SNXkU8uRK26Q0pKBg5H/H8
         FHUedtLhBQwZb0mBpI7rkDOMMjHJBTZjAYssQncabyIMasfDSIptou12p7a3t41Pm6ih
         sQLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUmZoQXjwNRVTAiuvg4lrt/1Sw6ffTweY6rXD7Q5qkSRWZq0Colm2doD0Mqm2xRAAiDVqKag==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvJIk4KWKoVC5xdDrli31+h1y3GcVp5Y1KJqfP7lMrOYKcD7Ut
	BXEgxtVngRW2PZZAjk9DD2DJwDkooT1i0r5+m5wjc5s86GF4djYBiMg1PoSgKA8Kdw==
X-Gm-Gg: AY/fxX4qUm1oW6in3fDOqyFbZhRoA23nwzdz4dqJ0szwdvtIlZCbyjzVbWdUCfCILyW
	ekqRM6OqHhS6ypn0eKVCdO/q9t6xIXcsOVMS9WAWcu7AW9mA15fGhHh/QkXKsCsrmGXDfkOa5L5
	uMBZddLXQbflLLEyc8HWfzW1rj/l/EadMdM8dB/zet7JlZUWo6TzEwvLSt8flfsmDiYQT/paG7+
	a5IRVzoJcBAIt5YVoBEBzzrzTs5vrp+le/u9uj7Sa4IqBYn6R37bVnH5Bk8eRVzWWlb24EgWBt0
	vgCUPaYokr09QnfyiLASSQWBw5jZ7lZnjfKzcjb8JpbvwNYFyvZm8XafJbHBAjTcSAyux4ItAZv
	Ta6wjILePJPteM/Yow+T2jyZUgWkBXef7b0p1oX/G5xzF7FFTVVbe6pFQ5ZY5RaFNN8YrfozPKn
	azQCdV0YCmLW7AFuDzluGv+iHfRhWljekU56VfiQFjMaH9TmNHUQ==
X-Google-Smtp-Source: AGHT+IE8Wx434r/TRdblX8cNOSB3Il2X+1GmWAuGcjE2WU7i1xwbelBfzCA/D0WahfUc0XUl/gS5rw==
X-Received: by 2002:a05:600c:8885:b0:477:2f6f:44db with SMTP id 5b1f17b1804b1-47a8980f38emr1011225e9.5.1765554097506;
        Fri, 12 Dec 2025 07:41:37 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f49da20sm36628515e9.5.2025.12.12.07.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:41:36 -0800 (PST)
Date: Fri, 12 Dec 2025 15:41:33 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	praan@google.com, danielmentz@google.com, mark.rutland@arm.com,
	qperret@google.com, tabba@google.com
Subject: Re: [PATCH v5 05/27] iommu/arm-smmu-v3: Split code with hyp
Message-ID: <aTw3rS1Pp-Iqq7yU@google.com>
References: <20251117184815.1027271-1-smostafa@google.com>
 <20251117184815.1027271-6-smostafa@google.com>
 <20251128164655.GB812105@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251128164655.GB812105@ziepe.ca>

On Fri, Nov 28, 2025 at 12:46:55PM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 17, 2025 at 06:47:52PM +0000, Mostafa Saleh wrote:
> > The KVM SMMUv3 driver would re-use some of the cmdq code inside
> > the hypervisor, move these functions to a new common c file that
> > is shared between the host kernel and the hypervisor.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/Makefile        |   2 +-
> >  .../arm/arm-smmu-v3/arm-smmu-v3-common-lib.c  | 114 +++++++++++++
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 161 ------------------
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  61 +++++++
> 
> I would think these inlines should go in some -common.h instead of
> arm-smmu-v3.h for better clarity, and ideally pkvm stuff does not
> include arm-smmu-v3.h at all?

My thought was that we use “arm-smmu-v3.h” to avoid moving a lot of
code and messing up the git history, but I have no strong opinion,
splitting is fine also.

Thanks,
Mostafa

> 
> Jason
