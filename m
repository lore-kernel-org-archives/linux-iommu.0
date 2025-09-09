Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A16314B80
	for <iommu@lists.linux.dev>; Tue,  9 Sep 2025 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413918; cv=none; b=qZ+zuo3lQhktEjCv5mvHzBdPwmlntGopjHmgPShPQI3ZvXqx83qh64cxV3GB00Yzr4rBA5pG+XErja4S+uvlzJ2JJ2BjkoQ1OoveB+gA1X4TF73LxICqeFgABv4o1X60LSh4U4cCj2XdXOPl+7yE1Ss9e/w1Q1dZ8dr3Sm9FaVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413918; c=relaxed/simple;
	bh=lj3i7DkwgDDQfj+771UKfDbe8JmLcdhupbsoCJs0uWo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tVVaVQSJMNfqpqxvJhcfTGfl1nuXiE4tET/zngVYRWqn7wVB6ye7vBy1IcR95k6/gQyFCfwa09uwDV2qCXRaSI1WDU+6f8Nlqv5A7joz1d5fYU+op1VWVV1VvipTB9O9xFXixDDl2kgRHM7RrqmqCYTJ8hrJEAL5gp6RzXOeF1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DymGiR7F; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DymGiR7F"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dde353b47so13436155e9.3
        for <iommu@lists.linux.dev>; Tue, 09 Sep 2025 03:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757413915; x=1758018715; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HW3k3a1g3PxSXTokioV5I6j30q9AGehCL+syHRYqQJY=;
        b=DymGiR7FREfPwH9bTJ6ZuD1eSpoDjVa0EN1PvL4snFAxaIcbaNewI0+tkNv5hKmsrE
         V+ILD5zqKTY4WMhaxc3H3Poq9frK0qH3b6Cw85zZUMB6nff0OeuTdtHbMq4MP6RuqZtL
         uM1xCNQodkohM5UZYE7kTVjEOx1yTewVpM7Ci09lEW1N583MWDpNFCimBC/7bdP9idUo
         Ezwlggb56hmD5VAxvcGEycFaWsacz4hY0B+FhRSAXfO7MHVg5cJyVnCwDDr9hLIme6WU
         gcd8I30Zgq5THkMy3/feI8vVzMm7xXp3tK3G6AL0FLx+t5zGHYNu4172CYR6FDZHwR0s
         +qzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757413915; x=1758018715;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HW3k3a1g3PxSXTokioV5I6j30q9AGehCL+syHRYqQJY=;
        b=iwsGui3GEnmkUAJ3UOhyVRinMpvoKLMOJPoJm2NSS7q2SR925/ArFh0yOYkDD9CHTd
         XExxpPoIBDWny5rBWzE23yWVEmgDMn6uPjE/nghbhA9dWDrJUtyMpwpw7oPEH4jAtCqi
         yc5ijqjShVEykiKom/1If3LkvMASwnEEywdilhDYyyvXgx8xn4eowleL5m3Pq21Nu+Ey
         rPCdCvwfh0SK5RN4KtB3Ya0vFj2FsZ8ZRhOuQQuQ1d3sUAy4aYtxRYXd9eY/Ri7nHqNA
         VSvlxin0/zn2/Xzz71ilCEzXqIjs6DEEGrsJhn4R/HGD6tJ8H/SUYEDqYeHEqxRMybwn
         9KqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVT7TtrpwoYF2euM9zdaAl4Q5LvW5pkxFlNyNz+Yc+7wu8H160OlbYiZKiStW8VDF7wWFEWg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpRiSgW8ERCxjDi9ihFX8PSk/Ps8qaGYjqJRFR71TxOu1v9N97
	Cui1lWF7JONyd18thJ0Xqtd7QcnXBm6LwJpB4Q2tqTszq8V8oZn++vJgL3PXh6vafco=
X-Gm-Gg: ASbGnct1j/MGbmyBMQnI5JJQcutkqAqM5w4cG3QzrBhZ2I8c989fjhVv5C/DhaAGW2n
	jqM+aY+TSnHJbu+Zabe8oZKTn0Kp1RJaqsQbp90SVvVGGheaFJhGw3IXSQGliLZPPw+eSvjqtX6
	iOSRFN2CyzehUeAJDoYIwKrHxnjtlWyDfj7g0XUhDWgXfPKLDYgzt64YSv7v+V2gkcET/D0wHIb
	eujlMQFg3F0OMedgOlGUnjxYin92NAlcqalVFm6uos78Y40k8FQHM1LyrlLTMsQS6PZWgWM3DgB
	OdU9IbOVQqcZZkt84fpDZuhDakR0NV5kFxVgiv4gv4qx5sG1Zqrgrcu4n9/xBAxUFbptpXj+tak
	wr6198l7WHcmIHfk7cb7JVR4prZHvvtOHUuYxMQ==
X-Google-Smtp-Source: AGHT+IFoH9EnqEx0+Pe7sMyMKqAMtXnTsmvRwSvLBqe7bfnXupVV7qrijqcbw+6s8Vdt6wGe0MhdPw==
X-Received: by 2002:a5d:5889:0:b0:3e0:152a:87b4 with SMTP id ffacd0b85a97d-3e64392b7a6mr8151669f8f.35.1757413915001;
        Tue, 09 Sep 2025 03:31:55 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e7521ca2ddsm2126411f8f.23.2025.09.09.03.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:31:54 -0700 (PDT)
Date: Tue, 9 Sep 2025 13:31:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hector Martin <marcan@marcan.st>
Cc: asahi@lists.linux.dev, iommu@lists.linux.dev
Subject: [bug report] iommu/io-pgtable-dart: Add 4-level page table support
Message-ID: <aMACFlJjrZHs_Yf-@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Hector Martin,

Commit 74a0e72f03ff ("iommu/io-pgtable-dart: Add 4-level page table
support") from Aug 21, 2025 (linux-next), leads to the following
(UNPUBLISHED) Smatch static checker warning:

drivers/iommu/io-pgtable-dart.c:183 dart_get_last() warn: array off by one? 'data->pgd[tbl]'
drivers/iommu/io-pgtable-dart.c:252 dart_map_pages() warn: array off by one? 'data->pgd[tbl]'

drivers/iommu/io-pgtable-dart.c
    174 static dart_iopte *dart_get_last(struct dart_io_pgtable *data, unsigned long iova)
    175 {
    176         dart_iopte pte, *ptep;
    177         int level = data->levels;
    178         int tbl = dart_get_index(data, iova, level);
    179 
    180         if (tbl > (1 << data->tbl_bits))
                        ^
It does look like this should be >=.

    181                 return NULL;
    182 
--> 183         ptep = data->pgd[tbl];

data->pgd[] has BIT(2) elements.  The data->tbl_bits value is set
in dart_alloc_pgtable() and it has a check if (tbl_bits > max_tbl_bits)
which ensures that it is not more than 2.

I don't think dart_get_index() can actually return more than 3 so
maybe the check can just be removed?

    184         if (!ptep)
    185                 return NULL;
    186 
    187         while (--level > 1) {
    188                 ptep += dart_get_index(data, iova, level);
    189                 pte = READ_ONCE(*ptep);
    190 
    191                 /* Valid entry? */
    192                 if (!pte)
    193                         return NULL;
    194 
    195                 /* Deref to get next level table */
    196                 ptep = iopte_deref(pte, data);
    197         }
    198 
    199         return ptep;
    200 }

regards,
dan carpenter
