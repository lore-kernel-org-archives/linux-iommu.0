Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DC02C3266
	for <iommu@lists.linux.dev>; Tue, 23 Dec 2025 03:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766459571; cv=none; b=IOZUDvRYUPgpV4UJ2fgMFA3gKLEqPGoxx9SfwDBNumL7VFGAz8na1axeirNigRzXmPxGKhwtMw7UoO1pDYtjPeusyaxbD72hj4ztN1gEk8DnskHlImRKfXRutdKP0YAlhMMMRDzickAm4ojGFahHjPzIcQGEswcaKVWZOMkg1DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766459571; c=relaxed/simple;
	bh=VZyqklWEi259Pn0Ym0ExHaMu9FDrnrFRS0/16Xf+qeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRZNZSUxm1nL4EUBJ2J9mbJW+AYdB5ZUkWqnJfEPZDF/mraj16HiSHQwZrYb3ERB0LeacBFawtMkmRp72CSFyloot606X9i42rTQ4FDW/8Nb+Owq8s5yGPOcpP/iPOwc2fkJyfCANg5GMlmGAB/rnlIhHRwT4OCFXFMty3uHVjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMr8FmwB; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMr8FmwB"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88a37cb5afdso67722316d6.0
        for <iommu@lists.linux.dev>; Mon, 22 Dec 2025 19:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766459568; x=1767064368; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VZyqklWEi259Pn0Ym0ExHaMu9FDrnrFRS0/16Xf+qeg=;
        b=NMr8FmwBarCNZatqbd7MLK7jrOz5rh4otGyPRyJcx0KXkYUv9M+ks1edXKB0tk1E8o
         jDVwSTZ9W9xkduZPIxmTxrqlLUge9HxALbWqoJ5JVS0b0abaXkTucvJdZenG+dmtptIQ
         WD2xB5WQf3DTcvYfiw8qJsv2m7d0SO8PD9x2sWTsFHBbDFHHtSCCwLSUlEw6TXsS42LJ
         Ppz5xJnd4BMo/NK53dZhyCm/OzqqaQdgJ97ehPQsukfAsHprwz2JJaAOF2AwRlgdPdea
         WTRYLcjpckb9yBOQGck8ynjSKTCcdduIC6l/WX1BkcXx2J6lTJrgWFynX2vRaYKBoRNa
         AvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766459568; x=1767064368;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZyqklWEi259Pn0Ym0ExHaMu9FDrnrFRS0/16Xf+qeg=;
        b=j0SAKVVT3hR2jTJfe2n/5pan1MnnLl7yLUr8ErdzIgh+NmmgzP0qF9OpZ5qMOMFN7t
         ibDgAZWDuzxKgCHEGro7cCMMUdZ++in43IhqfuWhzjI+fRx/zSJ/8W1IkKrrFkb4FuAM
         AzMavIw8xjiMmumuV1VvHaIJlyOv4uFzBXEvv8niMjX2eMXf3H/cgUduDU6uL29QO71N
         LTzOZSy9xaFEexivCez4zxSI66C8weRqS8mhM20jWFXdihG/TjxDD77BLjCi9Ar0o7Fg
         k9Ckt2bvyB1/U4AjQqVtaIGKD/Dxf/xtI6sQIufCTz6xdBnI7Yvu2emfdRQZ9lVv2LUJ
         JHBg==
X-Forwarded-Encrypted: i=1; AJvYcCUGEbG1s6RF+2MQYC3HaIoG09THHsNH75Pi8qwrKywmEcb1AMTKQSefqeGqAiruhn1xjlf1FQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLJIKKGuEypHy5PY5Rm+iGQJlYTs+ZGFItAAKD1pnYxJcbxDjE
	48jm6Scqv1UPhvsa5o+UaMtZOWekc33OaeMy/fs5MIHyU86Mzt8GPJYVEfqn200BwsXqrMfKkKN
	ekZyjlmkNj/K8MXdlGYkrUeFXb508RCo=
X-Gm-Gg: AY/fxX4kL/laxPziSx5RH3ujVCZrf/DP9IxKcQtEEQ1DZozkxH5H6AUHHGhKeFeWOuv
	dSljvshiV8IhcBJmRf7644ST1I7bjQWBG/uXqnoHfPIfsxKsMERJZsdGh7t2A2UXdgoX2OW+9J8
	BL/5yzq9CmRYNgrB0Ww2ha+6y9x/i6H+zJFIK2qlKejZbe3c4d6UE1I9O5NySBC/QRm1jzstnXv
	Z/XbPSSgAPjaZV51y+Fp0qciPAmRwTA2Fs7IDxE+OCU5l9LyfR6vWVJXT+4cHNcd35kYQ==
X-Google-Smtp-Source: AGHT+IG66207/uZQbKu9SYDXoWgjuHn7VS7optej1qWvQP1ZI6F00v1h0rkGhn5DZ+CwJZ+aon6HE+LPILKBAqozQqI=
X-Received: by 2002:ad4:5ae3:0:b0:88a:2ac8:9b3 with SMTP id
 6a1803df08f44-88c505fa466mr295836596d6.9.1766459567704; Mon, 22 Dec 2025
 19:12:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251222153246.2220659-1-xiaqinxin@huawei.com>
 <20251222153246.2220659-2-xiaqinxin@huawei.com> <CAGsJ_4y_xTJJRBzvSszg0qOAX7tAahJYzLaKcTPuJg6ctJsyUg@mail.gmail.com>
 <7fd4101c-d778-468f-98be-43cccdb03b1a@huawei.com>
In-Reply-To: <7fd4101c-d778-468f-98be-43cccdb03b1a@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 23 Dec 2025 11:12:36 +0800
X-Gm-Features: AQt7F2rCIMmAMwqZz53tZHYJKa_0CrIacbBAlWalUay_pCGl11-js8dDw1OnOuM
Message-ID: <CAGsJ_4w5E6L9SGp4oujK=D9sJwa5bYeQY1fUhxVAn6v=+OP-pg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dma-mapping: benchmark: modify the framework to
 adapt to more map modes
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: jonathan.cameron@huawei.com, wangzhou1@hisilicon.com, 
	iommu@lists.linux.dev, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"

> To be compatible with other modes that in the future, 'prepare_data' may
> not be necessary. So, I add a judgment here.We can delete it in the
> current version and add it after this scenario occurs.

Right, feel free to drop it. I guess __GFP_ZERO for allocation is sufficient.
