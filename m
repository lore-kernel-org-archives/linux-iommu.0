Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F59275854
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750070452; cv=none; b=OXVw9/KAsKDWzA2+Wr23s0mWK55G6TCqv3LoRI0R0sEXpviPPS7I9a6qzQOVacAfF/m4Y/dtIXJ/mt99JX8bjz2q5OWxth8s8G/kCU7pDjOQJguU8f3gNXwB4Kyu6qFyMzdksUjiB+8AihCMQGkRirYJOO0sh5NlsIwgzeU5Ebo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750070452; c=relaxed/simple;
	bh=8XMWvcD5dIXEwocCT7V0Ty4mO1xZ8Yq21hFRXXg+GQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdaTvkGFbDfOi4ggKXGFohKtEAsEJ/zFqq+DQD0jOJV8gmKn/HSLPGRrxKeZpXQTIgClHwEWU857pOZhLbc1TXSfKt2ozQcv2uf+IBfPGoQcFeFdb2c1c2hfsQhdV3VDaQkx5+ZWPEvL1YZub71Xn+7yiDL5cuo+oelDBvbKaWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvF5cAuj; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvF5cAuj"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4e7ef5d6bffso868748137.3
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 03:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750070449; x=1750675249; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKcJBSl+Htuh3i5x90yiqO0jHstMNoYTds6WpGdMy9c=;
        b=hvF5cAujH1ZOFkE8mqPlgb4ghsd6Jpay0I7Ts7QwLR0BbNCk46r2Gwo7fCpWsNUx6j
         UpgPlPVK3XAslMfJvXzeEApCjQv45kTqiUKGq9DbsFvGDy2Oxd/7IFpzuL0EkFUM5G5Q
         iNCA9VXGsXMM6CcdvAoDuSKZah4OZurpGLxnKYiSaIGpddotnuDAs/YavWZDGHXkZki6
         DMSzHDeG7A9iQcaFOr57CH4TUyxKWKGHe9RfJZVcxMYHn6WdFyHcObq1NBlvD6uPra2I
         ezxbzyM0pyN2Ui5Y/BvqEa8Go5wnur7mDOZ4/JJBS8xTJkB55a/qkD+QppCqyJ6uzBaL
         qtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750070449; x=1750675249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKcJBSl+Htuh3i5x90yiqO0jHstMNoYTds6WpGdMy9c=;
        b=g3FDvYF49hKdcFCcX4M3Go5/B6T+6Tnr2iSHXBc4ZQfeaFou/669vHaOb3GoSVXc+q
         6ae1SsFyLNjVoQLn+8m2edFuy4z+vTAY1zWnoadP7PwnFfQJrMTrgQ5kLJXgE5cyJEZw
         MTz4KBobZG/mIgayWuFTRuIbyaNIZZoBNDkIxvfUN4t5Zaw8A/BwwYpaaaL9uBsabXLq
         6bVfqU1dP8b6rir8pRpU/xBZlD5ucToJH37+0gxrVBpucBNy5DT47/uOB5dLlISjglfk
         XYa9f3z+RUX16Dh1KGdQ7715YQGOJK/yqOPOO4tmABva+CrMOYvGW8qaaw8wkWvLBjfz
         GH9A==
X-Forwarded-Encrypted: i=1; AJvYcCXC4DbTK5qbVlG3oAdopAYasUxRCIwSjhD2xq05EnY51EMzIGR7v4S0JtUm3tUx6GJpIDt8Pg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSkj6J/Y0S3F7XLgysr28Nhj9sxxDjo6p5Lfx5NYYIUs4L8Y1M
	C/4wZs4WWUTPD4ywWTTjIBljeks6tSNvmfa8EdhmhqCFXDTGaDwZ3bBHtAGzhMCrpohL0Z5G7nv
	N3EfKE3rp9S7TYf/75KHRrwice4NC9uw=
X-Gm-Gg: ASbGncsLGRdKVIy6hszq+znPIZenkyfBDkFSnTSgdmIMesBz22TTIofJpeLRPOVm160
	e459I8DNDTNf992WO3VOvnyD/CeFBIdEHZNlnedRCALz3l2426DcdNGldV/paMNZNoKvpB9vuR6
	zVm2HFQJzHbfYVB2ionTfj3M4KamL/tCaWkO742bHM9mFb
X-Google-Smtp-Source: AGHT+IGyrVuaJSujsaH/Gb6IqSn1XaIFzPww+xgJhL0qSz46P+E9FU9vcP3CXBQsbgaUwh0W0CRlwO5C49KfqNRF7ss=
X-Received: by 2002:a05:6102:4bc5:b0:4e6:eaed:7e2 with SMTP id
 ada2fe7eead31-4e7f6188746mr5750214137.5.1750070449393; Mon, 16 Jun 2025
 03:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250614143454.2927363-1-xiaqinxin@huawei.com>
 <20250614143454.2927363-2-xiaqinxin@huawei.com> <20250616105318.00001132@huawei.com>
In-Reply-To: <20250616105318.00001132@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 16 Jun 2025 22:40:38 +1200
X-Gm-Features: AX0GCFuFgGB6vPgX23Rf-5Mt2x4mXZwQlCu1ReuAWrQ4w8qJcActIkO0Jlw_fYo
Message-ID: <CAGsJ_4wOB+cmGzuzzacwJGeUYgGLuKg94wuWC+mA-_=r0TVuhQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 1/4] dma-mapping: benchmark: Add padding to
 ensure uABI remained consistent
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Qinxin Xia <xiaqinxin@huawei.com>, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	yangyicong@huawei.com, hch@lst.de, iommu@lists.linux.dev, 
	prime.zeng@huawei.com, fanghao11@huawei.com, linux-kernel@vger.kernel.org, 
	linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 9:53=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Sat, 14 Jun 2025 22:34:51 +0800
> Qinxin Xia <xiaqinxin@huawei.com> wrote:
>
> > The padding field in the structure was previously reserved to
> > maintain a stable interface for potential new fields, ensuring
> > compatibility with user-space shared data structures.
> > However,it was accidentally removed by tiantao in a prior commit,
> > which may lead to incompatibility between user space and the kernel.
> >
> > This patch reinstates the padding to restore the original structure
> > layout and preserve compatibility.
> >
> > Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header f=
ile for map_benchmark definition")
> > Cc: stable@vger.kernel.org
> > Acked-by: Barry Song <baohua@kernel.org>
> > Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>
> FWIW I checked the patch above indeed accidentally dropped the padding an=
d the structure
> is copied to userspace so this fix is correct.  Given it's not in a uapi =
header this
> only really affects the selftest I think this is mostly a case of there p=
ossibly being
> out of tree tools with a local copy of this structure definition.

Somehow, I feel we have placed
tools/testing/selftests/dma/dma_map_benchmark.c in the wrong location.
As a selftest, it should have a mechanism to check kernel dependencies,
start properly and automatically, and report pass or fail.

dma_map_benchmark.c seems more like a tool that belongs in tools/dma,
rather than a test.

>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks
Barry
