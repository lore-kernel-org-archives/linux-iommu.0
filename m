Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4786A29C347
	for <iommu@lists.linux.dev>; Tue, 23 Dec 2025 02:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766458722; cv=none; b=W/20H45x9URzAIxH6vTSUEt7v0X/csuAGf3JGxGiPAq/L6e1kqMEiINczXaSDOaCKYo9pv6jOTJrPxfj6XJbDWueVggkStZe0/zQOid15mycaxX4BqU7sEoo9oey2fAnyDXOxL2GFiUPoMt94Iw0jQEWnfjlQZuTq0l3iKOhlWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766458722; c=relaxed/simple;
	bh=hyuRn9rPv9n+wVXTpSBzCO/DJnAw2GLfslzZEt5Bilo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8rHOP/CUb6Krx00QLo/71IJ2C0zAXJIThyVrS+UiKsyyPC66Xtj3J7NnSiXKLf1ukfAf1S9BAzBe4ygQIClOVLpvc/Ne1d/iRXYmKxCR0P9QgHMqOsZNUZaXyrdnrF0IQCGsJHMEL7gXhdFl7PGKiDCiV5o5Km1O3Pt4hZK+JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wxeadf90; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wxeadf90"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-88fca7bce90so25597876d6.3
        for <iommu@lists.linux.dev>; Mon, 22 Dec 2025 18:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766458720; x=1767063520; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3G260ozrUF2PgPsOeJ8v7/7iL5uClvFQu/vTUBFFTw=;
        b=Wxeadf90vyKq3GEjtNumWcI4/FmxqvZMS4gAfLxQBbkgRFOr5cn801PWOha1e+Co62
         WLPeQgMNxMX/f48YbXkm+WyfrCp/vkp3tRXrrrzLNljm3bCDWqHlacKSF70fVvLi2Srv
         c7Cp6ZkKSoeLG+/JPXSfzrVrAuZ3mOvvrL5SsCBHy9NAsfswKwYm2JqZO785p+twALiO
         gOEQGE93CmdO51gHYe/2Wu3EbKcEuCYFUYWgv3cdevm+xqYfMEQQb0F6oybd6eRTuEa0
         kT3Wle+lx9O7C2q/puza9w2PsoKh++37rCfRD5tkDHnCa6Y9QcTM+OEz+g08m+AnFR8U
         Z2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766458720; x=1767063520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K3G260ozrUF2PgPsOeJ8v7/7iL5uClvFQu/vTUBFFTw=;
        b=Gk8swVx/z64tgb1j4I9SRTLM+dM+x/7xykyCcS90N1nLFT9oHUPSpAQ7s6fljbkq+t
         tnJPGwv+vYxHbN5tXWA66nKuelo7hQMkDRUo0+kzC+nPYe5cQrnplgQ5QvfKW7phqjQh
         ZEC1Z5ZGZkzfwWSMW/RY1CKQ7kHN4NrNTG1KHoaLOmwPRR2Q29zWGFeQB6QuBJExz+UC
         bKqYXCFpiLn5NwO4SFTYRdzjS3ED9QcO78SDYaABdPEGyBTGikBn+5kJq7umr4LJVfCr
         AkExMcVeoxfppHrZBcSERMRohEjl+E3luIrq9ASsrG796OwcW0U2TpNQ7g4piYYqzWnm
         sX0A==
X-Forwarded-Encrypted: i=1; AJvYcCVSXuzlIq0qaU2F2Gi5sHp456u6xiqBs7SMg/IHYfEi5QDFiUTPA0et4NLiDKjH5sMYh/i23w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxgr5nYCdhPaWjkHgUj/KOb3xO9sdRqOBvyxh9qvj20fSoJR3Kv
	Eccb3jlnW56uzMJhC0EheCs89CtwM4yBUb0gEEllelnBY7Pg1xrJoLOfN4ccHII+33WbFzYJ6k9
	teteUrgqCBuQRz63xWjIniTQW/6Kd4Cc=
X-Gm-Gg: AY/fxX46z8bgZDTl2dhCLyq8Q2/QpviVz2V6Mzba59mnUTaFrPmwCJil3kepNstxvWJ
	si9mbzL2YK6bgVX5NQbS4IJvHJqDmzZmwvntwWcX5XnagzMHVxRMLgbO7ec5aqyZirH9VLgqhX0
	qIvkqtYDr7JcEy4QCiCGrBEz9obuwbSAEOq9piAF9Le1qqcsD0otvhFzxqpjCflJbHsY9Q3gALc
	UBhQaNEieEHLDYpUVBAyQgug0OgRZO4dQEk8oAc5BaDrYvOJaN2TzsghqAtePiAkjiVTVlmo8mW
	pd+h
X-Google-Smtp-Source: AGHT+IEBVTZruOpOf1RS8mg6+BZaRfsfr4p4ThX5QbIrrB7XQAP7BkrLwHFod+Y4yKQB7TL2n4m3Rkb8l1JKoHT9YPs=
X-Received: by 2002:a05:6214:3110:b0:88a:568b:f4af with SMTP id
 6a1803df08f44-88d828162edmr223224396d6.23.1766458720014; Mon, 22 Dec 2025
 18:58:40 -0800 (PST)
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
Date: Tue, 23 Dec 2025 15:58:28 +1300
X-Gm-Features: AQt7F2pCXW_JUov-m9U47jN7B4SqfyFtO4gmm0IlGzV8EelLuPZN2ZlH4cvWK9o
Message-ID: <CAGsJ_4z-KRNTJsce_6pCOjEDtsiHHOh4C9K9iY1o_3--RMM-=w@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dma-mapping: benchmark: modify the framework to
 adapt to more map modes
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: jonathan.cameron@huawei.com, wangzhou1@hisilicon.com, 
	iommu@lists.linux.dev, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> >> +               if (!mb_ops->prepare_data)
> >> +                       mb_ops->prepare_data(mparam);
> >
> > Did you actually test it? and why don't you need prepare_data() sometim=
es?
> >
> > Thanks
> > Barry
> 'if (mb_ops->prepare_data)' is correct.
> If you want to do some tests before I release the next version, you can
> modify it in this way. I have tested it and it is work.

I=E2=80=99ve reviewed it many times. You are:

+               if (!mb_ops->prepare_data)
+                       mb_ops->prepare_data(mparam);

not
               if (mb_ops->prepare_data)
                       mb_ops->prepare_data(mparam);
Am I crazy?

Thanks
Barry
