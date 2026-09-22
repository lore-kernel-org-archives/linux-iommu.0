Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE3336896D
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 05:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055866; cv=pass; b=Tds8xG9fIhs240NqHCWuvf+M63Wk+D4dchVqle1ZLoaGsrvxIH9nkw8rfx/GIQ3ElyaFABWkLVtQdvl7QQNASyzrR/g4dVNVC/q7NDDgFoOiFfN+FBlnUHs41y/YUsYFQP1YsgtgcCr9V2D9ps7FPeuZP6hDFqPEQSUNaGufZS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055866; c=relaxed/simple;
	bh=mVQSIA+KZumLgnewVGIvAtxnjvVRKy38ae4smjKb/as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=li5jOSp3dw7QAMxkPzxdsqUJ1qSYrUeDhSEyQKz6lwDTfWaPgFVLrM0RRDkLg59k/0Z0KcyCkY0jKySo+eNd4JdeLKYMnPw3/qTiBqp9fgG4SNqeoN2GBEwFGjH+nWB3SnR9PXpOyzBgTGGOXkIZvh8MP4Q9fy9SMn8jFAXTkAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKfKvwbb; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKfKvwbb"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-895353e9051so33194197b3.0
        for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 22:44:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790055863; cv=none;
        d=google.com; s=arc-20260327;
        b=WL1HFV7tnZPRkkZ4edMhbyn++LZDtT+OtubGESAF7UmOlueYdr7XqITBibmRi4d2PK
         EgN0aJDK6nc7yguyuZX7o2+9xJamHph6Qlbfo7sz+ed2PLxiDiyb58dwLSSxj+ou31/H
         39QNGAmHJ3I6dsv1X/rOTSJujfdC+9Ytgp7TGPEsYWpE8Ax5DMAmDGXKj/qFKCngkrXJ
         Lw0HguutfqSn6/O0RITRvQfy4MjeRD963uXBCbdAUGMp91LJQG+ztu4Iq1Z5FHq8WHqE
         MoeQ17dZVHbOsc7vJz4GpJZN0PypJP/SBdqBqUicoADTrorRV31vc+X7T2n6He/rt+G1
         dalw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mVQSIA+KZumLgnewVGIvAtxnjvVRKy38ae4smjKb/as=;
        fh=sxFI1gtUYHeu8oDjSrse3sUBrJ730N17rxr96Boz7KU=;
        b=Li7PCBS/gAxeGkzsTRI+mRbTCfO1yIjAR14W6+VqJMVV1l1Nn1GMeHCrKgUjNEjMSt
         ndA3sRG32pbKSOi09191GUe39rOd6Hua7T+EXMysT4x8PNrxCj6hRnxK40ZJhGyYrIaW
         Xeu1+Vioat8RXmcCzFDnPLiJJkiIhOsOW/230cHhE0XHNk+KScCUfxH9P+AN/f9Av7NH
         hhntWTIbDS3NyLGlJqlYl7uls2hrcZgtHoLd+Ai9XzUDZovEC22L5zIHbR0x9VC2oZQE
         d3WYe8+jX9qESl4BK/wjfrPA+KoFlbciS86aXS4z+RsD4xTHz4x/CDFkgK99bHdqz+8h
         FBug==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790055863; x=1790660663; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mVQSIA+KZumLgnewVGIvAtxnjvVRKy38ae4smjKb/as=;
        b=SKfKvwbbceLpa2n1GU2mADy3FcNlZ1e6L1WYfSWXphPmLulWU79JUG3ycJxUb0EANs
         GjFILB6JpcFaEZMVmmPd/Ha4zcwb4SSi9IN7b0euRBoq9ftbTXM398cXELt5kdmVSpbU
         hOsR6IKGFFPWKL804muIds+8xh9amKAT/ShAcJRDmO75UTHkOIyAcRuwseIOEevnRiSE
         Z8amWrDR0dXctUirUk8E/5heAZgTQklUYvF6sbNTKlJPqaozBm8bwMoyG/o27X7wXcmO
         HzShNuS3P+c13glyz8Rwnmh5TnjRmPvz+6VdMly+ox8nvoY5aFDOjQJlEmXassbAhqEI
         wGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790055863; x=1790660663;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mVQSIA+KZumLgnewVGIvAtxnjvVRKy38ae4smjKb/as=;
        b=xBbnDOlsMyOAyXeIIPtUU4eOpP74n48uCC5rdEOvhF3yjE6sLDaF5sxR2mRUJc8uan
         gK/fjaDd94NIZYlHQ63bPUsIfwcCgSTA1kFUqBhSMiqTrzjRm+9X3qR8hX5xLAu9g6l8
         GKWIeesRtCCXBM6nTlK8926CHABcFgbK/oVIhpEdXgzW3/8zsieOl4TkkuQzJSW/yEQc
         J3uzNrpX8oE59sRjo0Xc5jM7jR6HFzNlgngMNICpRDg6fz21M6QgnwIWtQOeCSePHgPf
         NuenZ0QRSvniA4fwQ6qyH/a2aOFvP2VktFY8IZDpGVNEHZtAAm6gxDKtu5wCDIG1taRq
         GJpw==
X-Forwarded-Encrypted: i=1; AKwUvBxvdc1aYkp0Foc6+iMFjllIOY9LTIvMfkr6cKs0h+Ublfax34M/SXAe6zg7YG3WCTCPNvOy7Q==@lists.linux.dev
X-Gm-Message-State: AFuF++l4mP/82tLjQ1ETXHgZLObLtrvJIKwZnC18hIC573zisbjevQA3
	1hg8g1wwUarvkjwJE1lNgPjJ85Xcwx0wg2DRsXj2MkfZNKJ13x6kcn1W2u5CMftsdVkOHIX4iDW
	hKCw1sUoOa7LFZXcBgHol3tJD6SjZZRk=
X-Gm-Gg: AYBFou1ny3khtUbRtSTR6SCSOscrmVVGZVcVbvB/LJnCFZR2wlSg8vjxUbn3CsFK1fD
	419Qi02lc3Y4WLmQdX1fb/pI7uBD9PDbOEUHaHhAUcOA36CzuaXQsZeXocydnxFfbankv9IeL60
	HOXPt0CEEELByj9AZvs7zb90CpMAQZZVE79+zruarlbwOVJeuZKp7yakSCdNPR7qn1y11xe76eQ
	86YApnhCSzgsqxOmL/EmXdsLpyubMH1BJ1JwDuRI1uPQ6kUiel5oCNtQlrUh/is5Wq6eKLO1lho
	gdnT6e7qdDHZWSdv83qheAur1WaTwkOJmILSJcPUQok8Jutmd7nPIwE=
X-Received: by 2002:a05:690e:140a:b0:671:70d1:d6e9 with SMTP id
 956f58d0204a3-6717fe6484amr3963390d50.91.1790055863048; Mon, 21 Sep 2026
 22:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260922054116.416333-1-oss.patchbox@gmail.com>
In-Reply-To: <20260922054116.416333-1-oss.patchbox@gmail.com>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Tue, 22 Sep 2026 01:44:11 -0400
X-Gm-Features: AcwNN1X4U-FOuecLC7XSWshGXMtdfg5aLnegDD7bITFGtDrk_TB67QveNxFm1nE
Message-ID: <CAGG=RgCA4kAbx39LuSRiKu1sx2CbTEAhZH1bKNCxPn5i1m=x+Q@mail.gmail.com>
Subject: Re: [PATCH v1] iommu/virtio: Reset device before deleting virtqueues
 on probe failure
To: Jean-Philippe Brucker <jpb@kernel.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, virtualization@lists.linux.dev, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Sept 2026 at 01:41, Yuho Choi <oss.patchbox@gmail.com> wrote:
> 2.43.0

Please disregard this patch/thread. It was sent inadvertently due to a
duplicate submission.
I apologize for the noise.
