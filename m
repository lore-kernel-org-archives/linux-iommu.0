Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA83022D785
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 02:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769395885; cv=pass; b=fNGGFtrOzVMfpGVe6C3bUGeXLj+cbWxxpJDoO22L5LD7myLhKvCjVKieD1T6LQxNPprQzkcEvUNOIeWpen0gLnWmrfTraH5ml2JjGyaoqwRCD8A7g389VklhSXjQmIkLVnVBDuyhC2Aux9xsJm0OVVq/LL80iVYj9OBplfte3qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769395885; c=relaxed/simple;
	bh=lLGj/5JbDrizBI4s95rI7BnGWGt651dfbulABo1MnJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IaK2ue+nz7fsKcxRvirjiov/LNCTHYMN7QrmmBZLRht3QjV4FmAbs3GFnZ9Jky3kvjD53fKrYPsafUy7DPzoOCpEzMr8Vh04lCd+ArveKGG3RNMvn3hZIbqha7wZ5oXMQxcgKxNc8u1s1rGAhGIRIfRjc9oX0zORV0TEChrZRZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmFeaxzr; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmFeaxzr"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c5265d06c3so570312185a.1
        for <iommu@lists.linux.dev>; Sun, 25 Jan 2026 18:51:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769395883; cv=none;
        d=google.com; s=arc-20240605;
        b=efqB5iDY3E+VQ/zOtLRpAxlGvwpjdw5iZ3NB3Qx6OH4jIgsaMMJVWHs4JTE+tKXJKV
         yhSeF7mb2uM21vwUIPLHZ2OsBqzGxcqR6KzGwy/EtpCzxWbxYVYHbrB6DamvJwRX4w5V
         kEe8LiyGJW3dxkEzs50wEoxahX1x9gm8qtYlrfch45sM1Ou9DjtlNVeb9Q6CyxvZPIsf
         MOYusvTPZl561R9eehGDyLAfyaoe0LfbYETAIzaWfR+0Ldty2uFlAanQymYJ2UUu/VJB
         Urbu4WMT4iYvk9hIm3odmX+w6If4KnqULNISQAycH6ASOpriY4DIqgUBNoWbIQddfL1j
         WzlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=URbjx9ICHTnGD0lFSJDDko12hiaAKA6BGls4sQTEKIo=;
        fh=Ts+BQxKHYnJLUbBvQjlXK6RxoWNdlbjUPsrR1lpSvFY=;
        b=ZgwkDCchMbFoVdnPRxR3UWZG9p0sGJP6roDd2wR4ETtI/IJEzmFNoiOhgxeqysm3VQ
         x4zTC7H3MIRb0W+Nkf8j0oIKHRGLe9s3vFVQ1wjZ+AOVyMnT2JdpDlddiBXnwnmX0Fdh
         eFq10sRxhuMqQUpmVNyp8W3dybkC3utmUVDxpai86Vl2p4yV0hPjq0/5icWP9YWkJNQb
         Z19r3XqZcB/oiRJlyn+4jeHdJjjW48CBv5HS6PQapwHLc923ZCKcZtLCiOpNiv/SC3vd
         nlNYDW4p146pIhtJBUVGgRRyKzsD6FpHs9JjvP2B3UEiQbPNkuh6XML2oJu8mfL1S702
         JHgg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769395883; x=1770000683; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URbjx9ICHTnGD0lFSJDDko12hiaAKA6BGls4sQTEKIo=;
        b=WmFeaxzrhpAXhBjsK3xiWItz2kMysr0JB7h5mb8kfMC51x+U6NOGFlMN5BDkfni8Au
         LnG+XeGkEwhil8T+4a86FaQlQLk8S0ERtusBYoH1GQTlUGe/adNhu4pYqjwbSKufkLie
         7C++YPmCJgULMDi+S7JWNrtaOimSTqggRprMuABR9qHtKeYTFgVH9JgTn4PYPTJ1OdEr
         ljXcpMVFafVl6CKtO43JMxeNNLFkrwGsJvI890Mfp1tuA30yf+j5AGKfjvUBJIJn1aLa
         IvW1zUPHxTIGHCop5LUMna+N1JMMNaKnHeyaz31ggh28ejqyDHSvRSZIHA0hEggfE4GL
         YBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769395883; x=1770000683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=URbjx9ICHTnGD0lFSJDDko12hiaAKA6BGls4sQTEKIo=;
        b=KBI+GAticwjfbgpCpuRQP5e6ZB6WDeCh4yj42PFOdJJUaZVg4JW5GH+kAovHThq3vG
         4NW1YMdF33tg1BP4Q+9UBGUzb0doh0oIVYiRsbrZ0PvmELV6lmHuCrQWhYQlpMKMk3ap
         dJgFiXr6NJwNuXvsBfXpznUz1dUKDQdAZHjcJPH5xKJAqu9FUbAvAAFkd5C7OawSXtTs
         c+3LIcVZBoeNpn1QTzg1NAoKvW8xnYTiWm0hXsvFlG7i0YiWcdb1vBjaIg/hbsSFKZTt
         9yFDd4EnvPHz/StYWSxGvNPzNVUKClBreuKu8qZWBBxkrXcEiI1Pht/UjNbuFI1hjvX/
         r67w==
X-Forwarded-Encrypted: i=1; AJvYcCWDg/5/5g1hpxiBLf9pW8GpZMEifA2tdj4GST7Z5MMQe4wfKaBdDiUPRIN/WGjwUDEPftgxhA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAtuo7UucfkrwasUiXlLQU9glbsPxvAVeyTDk3/PG2djTEFVhN
	U5PJG841IkoyT1S/kiNJrFwPJ8dOPCvSQqjSfyoOoxtW7OGE2fi+zO524zp6XI68HRa/2rrfiAn
	6JvRZtV7nxDMgFzf2TeeWIkSd8Ke0L2chAvfGHrg=
X-Gm-Gg: AZuq6aJMrs9ap6nsOG82hBuoBSMNArIaQnR6WWfT1E5i7gmILGhEsqv2bRPQMZolDVv
	30o70jPVBrfXBx0YSh9UB8RkdOcJme8c2yyDyyNypL3mb1zxC7h3apiZr6iWoYF3AwLhCJgWw83
	YIfsH6bh97HxQUSn1CZxRAP1SKzgbVUfm8OWI0tCtRfYRosHhubhpfsX3DYkPiJo5Can0/yDzix
	hMwGGsoOHS7wgBI+sIPdkY9Q9c/pt+Kq8SljkSB88XUmURu7hBFXJPt1/39JtJcSCgpgbsN8w==
X-Received: by 2002:a05:620a:4489:b0:8b2:eefb:c8ab with SMTP id
 af79cd13be357-8c6f97f1f17mr308663285a.19.1769395882595; Sun, 25 Jan 2026
 18:51:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260112093436.3456315-1-xiaqinxin@huawei.com> <20260112093436.3456315-4-xiaqinxin@huawei.com>
In-Reply-To: <20260112093436.3456315-4-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 26 Jan 2026 10:51:11 +0800
X-Gm-Features: AZwV_Qh70YfLcTpDfirNJFyaXFpRBaH8c9jaxDPmuH5P2M7dnE8wVp59HQrhN-I
Message-ID: <CAGsJ_4zkLF8Si6A0tvFNPGq2VJ8Md-Be=25K65XxSn-JWtCxbA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] tools/dma: Add dma_map_sg support
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: jonathan.cameron@huawei.com, wangzhou1@hisilicon.com, 
	iommu@lists.linux.dev, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 5:34=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
> Support for dma_map_sg, add option '-m' to distinguish mode.
>
> i) Users can set option '-m' to select mode:
>    DMA_MAP_BENCH_SINGLE_MODE=3D0, DMA_MAP_BENCH_SG_MODE:=3D1
>    (The mode is also show in the test result).
> ii) Users can set option '-g' to set sg_nents
>     (total count of entries in scatterlist)
>     the maximum number is 1024. Each of sg buf size is PAGE_SIZE.
>     e.g
>     [root@localhost]# ./dma_map_benchmark -m 1 -g 8 -t 8 -s 30 -d 2
>     dma mapping mode: DMA_MAP_BENCH_SG_MODE
>     dma mapping benchmark: threads:8 seconds:30 node:-1
>     dir:FROM_DEVICE granule/sg_nents: 8
>     average map latency(us):1.4 standard deviation:0.3
>     average unmap latency(us):1.3 standard deviation:0.3
>     [root@localhost]# ./dma_map_benchmark -m 0 -g 8 -t 8 -s 30 -d 2
>     dma mapping mode: DMA_MAP_BENCH_SINGLE_MODE
>     dma mapping benchmark: threads:8 seconds:30 node:-1
>     dir:FROM_DEVICE granule/sg_nents: 8
>     average map latency(us):1.0 standard deviation:0.3
>     average unmap latency(us):1.3 standard deviation:0.5
>

What happens if m is set to 0 while g is set to 8?

Thanks
Barry
