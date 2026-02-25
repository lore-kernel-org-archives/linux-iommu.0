Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD9038F946
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772016153; cv=pass; b=Z8F9y7hGWYUeKsFl3L0hz9GreCRxQEZOYnpcP7Izs5P2SmQxNTUFgCkuAz6Nf+YVbdXxHGMn5z9jLptRF/LHgMiKIUi6E77jzwoF3WFoZisFPpqRQjJediG4qYRkTcGLem9GYr57MQSs1a2DTMB2mjm0DYhwEvpZZJOUL0D1bvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772016153; c=relaxed/simple;
	bh=CVTrXmujrsUxDdutQ2jh+KkL4pmUDBpK9XjepnBTmrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WmIfknl7272wtWlzu4kOim5bqp1KsbpkMdBQ32P1I5GiCCsE84PPZ0Bm56RWlvmBc5qc5ARaF2NtSWYwT7IHWFH4g8CIau67oAYrWdFs+QHwX/GcmPugIN7vHJ58+39EHXq7XnSHNooWu/KwUSjIfaLWLseudSm4V/infSajVQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k25G9QH9; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k25G9QH9"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89577f866d6so10942826d6.0
        for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 02:42:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772016151; cv=none;
        d=google.com; s=arc-20240605;
        b=CFmpexydE5Gc7J7TjJYv1a1bTqUspvX13bKK3kLaERYleIeGxOmtA0ti5YyoEG23Ie
         PU17yrOJfvHzTb9v3pBop0uyvk3NkSSqLWoW/ysu5cux87AxaYNCuIFXPeDsOEe+O1y1
         Il6aw1jDWE1/+FPU8s9uXHGsIkL7FQiXxu3+9nvnSO5eQcok8wiX8XVdqQf1M0rs/Qf5
         j0z3/wpC54UAcRBFso8GrQL5NSIIePdW953HrVZcJwfWufOXN7n1tHX2dD/Ofq+sOeeX
         jcwk0vUqtZN71dCzqS2ZHpsBbAjfRarfLBFvfVWHIQEd27/rEgaxQnp3WUPQniD29lfK
         6dPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CVTrXmujrsUxDdutQ2jh+KkL4pmUDBpK9XjepnBTmrE=;
        fh=UwmrK+X4QumxHHuetn37DN1n8l1o6bwnWc6FJWwzXwA=;
        b=LRbaYtkgdyRhulHufOu4OBOOr66oHEaaOfz3uQZ6SfVT2lhqnA28DPwl/CpGDAqwxb
         Zu56bAUvQaXGHc5DVbomZi/pX2hjIJ4WAyE0LBgQmz7/WdyqlXnq43y/K1W03efd+LOa
         nLzRngw6kdTqFd5NPh0gMwjEXrnt4ymMiXyRMy5k6jtD4Or8gesVlE1RGsCgQjNCm2S6
         PFr+pFzocbVRXxCcmbhH878H09Wv2aveyrOGi8jVlsLzWAyC2V1B+IsRbh075HKoxeX6
         PzrOUC3v4ST2Kvfm7m5CIXRAjmszA6l3UdvgINiGm1d+W5W+Nj7VknmvyUU5Nw8iny07
         ujLw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772016151; x=1772620951; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVTrXmujrsUxDdutQ2jh+KkL4pmUDBpK9XjepnBTmrE=;
        b=k25G9QH9O4Z1gS6ibic04cdBIHJ+BzsXPT7Jg3VSU+hMEIg2k5BV7NXYedDOx3dRk5
         y0Oa0nmj086iozb1dGh1/6v8yCSstXyuG9HWmNITMuW9ntlrw/WnLDewX4qXV5UgU2at
         MLl8YaAmcJ1xmU4swFMMkaDIf9DjtRVPt1SXnXFsdUV2oheAX/PacrY7OeIXSW6Jd3iP
         BkciTt5tyUK26sj/I5i5bXUhfUzVWJCzTRlZSWKdn/FadaXyjNx0zVS9F97CvbLhy/IO
         lKOcVVFOra5cLbzn6dJ1TTEwQmatyY7fs/0NDkrGWgMhtG8JDcGWf9BsoOXQtR2wnhsv
         xQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772016151; x=1772620951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CVTrXmujrsUxDdutQ2jh+KkL4pmUDBpK9XjepnBTmrE=;
        b=UNKkCanj3REw8l55+19SXiORm81gT8mYMvxoPFxolqNjYIpdr5UluFfmpErcG14kow
         HHPs17hIjd5loPBwMlanL2tb/jIANEJWDeFCNF2Q4BuWSRFtAZCa0kkKjgR35M5MEPGW
         T6IfX/YRVfeQ9VIoZHmZ0LQfxRAT/LpA/Ka0Vx2h8OPIyryyTlXeXVah5TanyzO/XGiX
         aeT83sv4BulV1zFp1xIXuUYhrKDlV08pg2c4AOpWzSyEMa5mq7LKelm8T4YE+2i1n/iK
         fJdiEbvKn8Ggjq7M/jBFfz6zC9+Gw379TsWarI3CGrLng20E593CKkcIp09/N0cRooH6
         QH3g==
X-Forwarded-Encrypted: i=1; AJvYcCVF+38stq3PToOOJgxy2vu74NSd1O5dHXfJUcGyBUjQrqu561b1R8MmjFanJgnBDSH7Y0u3vg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGabAPICmzcf0dy5eqipKEWnm/mkcVg3uPsHUt0Y6UUrDEdPgj
	IEJfn1NalCCzPQ24kL/WbbMwgOS2L+P7e7tRqz7bjpd8xp0pmtIVdpERczUf19m5RtaL8U3KU8i
	4tByRG3D0BP7osIeyrPultTcWw5A0aH0=
X-Gm-Gg: ATEYQzxtroZadpXEC1qQ+ehWH7KOqs8HNl0fSt8XOpXaZ9On1Vjwg+Kvo4mNlYLsovN
	BWyD/C2W12wPHx3onfYnQjpBynhTJQaryJxqmt+ZLRwZaVUF98tw/dtVSba+dqkPGriIxAceG0e
	pgmWoug0iLm8M1juSqkSUsXRbfyHFpSdndw3n5avcGUdXmh2zepZUP3HeXX19sKh0cML6p6Rz5l
	l5glxvLSvAMFZY8TAPiV+vP5+7H9D6509C91iRB8jwf4bj0uDamGSR3jyJDfswF3JMWTLnLiqIw
	ngXw9w==
X-Received: by 2002:a05:6214:29c4:b0:894:6f00:82e2 with SMTP id
 6a1803df08f44-899b385a738mr38429726d6.36.1772016151032; Wed, 25 Feb 2026
 02:42:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260225093800.3625054-1-xiaqinxin@huawei.com>
In-Reply-To: <20260225093800.3625054-1-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 25 Feb 2026 18:42:19 +0800
X-Gm-Features: AaiRm52JDGSmx1XcL3i2mYeE4AItbQLOSktL-Ach7soClUUIGqOm-LjUH43rWDs
Message-ID: <CAGsJ_4wDs1f=oPzBkHHfRQp32EoGOV6JwhFYxZX=tBXyN-AFWg@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] dma-mapping: benchmark: Add support for dma_map_sg
To: Qinxin Xia <xiaqinxin@huawei.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: jonathan.cameron@huawei.com, wangzhou1@hisilicon.com, 
	iommu@lists.linux.dev, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 5:38=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
> Modify the framework to adapt to more map modes, add benchmark
> support for dma_map_sg, and add support sg map mode in ioctl.
>
> The result:
> [root@localhost]# ./dma_map_benchmark -m 1 -g 8 -t 8 -s 30 -d 2
> dma mapping benchmark(SG_MODE): threads:8 seconds:30 node:-1 dir:FROM_DEV=
ICE granule/sg_nents: 8
> average map latency(us):1.4 standard deviation:0.3
> average unmap latency(us):1.3 standard deviation:0.3
> [root@localhost]# ./dma_map_benchmark -m 0 -g 8 -t 8 -s 30 -d 2
> dma mapping benchmark(SINGLE_MODE): threads:8 seconds:30 node:-1 dir:FROM=
_DEVICE granule/sg_nents: 8
> average map latency(us):1.0 standard deviation:0.3
> average unmap latency(us):1.3 standard deviation:0.5
>

+ Marek,

Hi Marek,

Would you be willing to pick up Qinxin's series into the dma-mapping
tree? I think that would be helpful, at least for my
"dma-mapping: arm64: support batched cache sync" series[1] and for
potential further optimizations to dma_map_sg().

[1] https://lore.kernel.org/lkml/20251226225254.46197-1-21cnbao@gmail.com/


Thanks
Barry
