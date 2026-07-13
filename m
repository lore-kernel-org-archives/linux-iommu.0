Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A9B3E639D
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 10:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783937775; cv=none; b=GMIcNexcAbzvKHnRHdC+8Oxf8fUWhuxy0QUerpLKOp/q+MlyBmQAxRKZ9K7IQS7tEaSZ+m2JH19OMu0HLcmLpai9mj4SlT18LFQI1/YrSdGJbSdGnFspIVy4ZeVKkhzvNnnljSb5rpfLc6udchDeL8MhlfuGBaIwr8HZhnlP270=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783937775; c=relaxed/simple;
	bh=mq4aj/XamaUGePQ75xWTJleNN/w5cVm+bg5zUUVdePg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIhyTyvLYnWdEDCUQV9R6JxZS3H6mRadTeUL5TMQ7qxyl9+iOSFvTLEF0OsAFS/OazlLLFgWQNm9zb2DwPxhxM64UgjP8dm1Q1gBgLGAEllOr3xTAwc0ySLs3s/d4T0hVCfCGWaiOYEk9+1BWDTtfaO1W/sbaTkYonQ4AQ/Appo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqfuINUt; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqfuINUt"
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2cc7a345f51so23689275ad.0
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 03:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783937773; x=1784542573; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Pw/M9cQ/WNEAfuTTS00025CV/d5Oe7obd9EEdA8IR8=;
        b=bqfuINUtHYeUZkjh4IJ6SCvTFwFZfvBeRTK+axeH9XTqa4IX86ko9bNaVRmbiqGle7
         DYq0RewWnMU1PSaafvKj9FqMDpy8tNUYoiJzWP3aMvPOfXtHqYHmkKlef7/7QhftvvOV
         bxeN8c3+SAwQFTwrndvcBqoPE3jd8TTQcYnHZ8YelNtO5VZzw7l8EGfuS9ZFWcSOsKUK
         vda85JrasOMNxgwLkaCaX6/07k07JuH6oXluHsW4lXpNAKO3gqTr7wweIeYQE2DWbZ8m
         DdEp5ccr0X6rQd6F7t1+ngPZ5Dt1IbTr7GCqH6a9yiR3ji9cbmBfiGMxDYgvEfS6nWlp
         zYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783937773; x=1784542573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Pw/M9cQ/WNEAfuTTS00025CV/d5Oe7obd9EEdA8IR8=;
        b=fOi6CwWHAwAESqCVbaWoFSVd5+5mD6ExvDdAkQvL+7db7oPGTTkOqCz0dO54Dz4YtO
         9eKuF/+ZlfBpO/ua4TdS6s+3zCxDhrC/RbzX3Uv7Y0d6+KFlwE3+2wFFGaj8pyTXZWW4
         XThwZd0mVBCevMuDr58XGCyDNhtXGN2TUkqiE8yc4J/rCfn2rrLyx09OLLJJ2CYNpwYI
         K70luPmOzJhCP45F/lgnx28+zV2m/PJ1Q/rlLofhEHRqUFUR6uclii+/DOJWkJhTKIWH
         4tOWjCXb3C5nEd4/3gqayNytPxfqGTzm9gVmQGOx6vb5mpVZoIPePHC7K40LsPgvFKQM
         D8Qw==
X-Forwarded-Encrypted: i=1; AHgh+Rrxdnk0ZeYRlmcBbqi6B9YfxZzqcuglRl+boZsPDit/Nk53CgCPbFjiKzOO4DRWSEZUkl90cg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKcf3YrXCAiAmRZY3qIlfLCNZDT6sU9a7HhxaQQQdKFomHn0NO
	9XPvuQxASe5iNzo8eCBoI+hv/6SyVBGvNye/XBU5dYXx4V1aup4gme/C
X-Gm-Gg: AfdE7ck1GsiQbkX7CLjjG0x0wKLlIz1KTykWu00+Y5tNszciQO3W1RzQj4LpNbVc6CH
	QihoOtIx5aCypeOKMz49PUlfYVuwb5uCccSnEALAZQgbLfQNvtNnpa7xR5CTlmR2gjxX9fir8NI
	XMz7iq/C66+ASaFB++j0N2pwqexeZMM7NdlePTcM0RrKrYNBU3Q5gRjJPm+0XcFHmCD7hKxOJH9
	U8bSuHzUBrwTK6aQaUMF3Nv/nAH3R1uUIXvLDxgYRvGmN9QQOqRQmg7H3kduAc3976OXh3VZ1bn
	pIB22Uth7alWDR1r5NeqvL2iHzIS1zTedcOWf4c63Jz39n4ket1Snx5jZM5q2BacgiRBsVQ14I7
	kCTG5cArAR0VAYqRqx2SYNLiteyyuQrodd2koql5DKyrlQ0r8+ZgTIbJtvpdNqxGjr7hc868jfs
	ezjoqe8iTj3uz3SALNEpXcTAZ9Z2I=
X-Received: by 2002:a17:903:2d1:b0:2ca:6c8:abd8 with SMTP id d9443c01a7336-2ce9eabdb67mr74433615ad.12.1783937773073;
        Mon, 13 Jul 2026 03:16:13 -0700 (PDT)
Received: from q-System-Product-Name ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb56fsm98067295ad.15.2026.07.13.03.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 03:16:12 -0700 (PDT)
From: "Bingyu.Xian" <shanbeeyoo@gmail.com>
To: Gong Shuai <gsh517025@gmail.com>
Cc: Tomasz Jeznach <tomasz.jeznach@linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: Re: [PATCH v1] iommu/riscv: Add page request queue and IOPF support
Date: Mon, 13 Jul 2026 18:15:46 +0800
Message-ID: <20260713101548.1594496-1-shanbeeyoo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <0c596ea4-8c29-4e5f-8238-cb8f8c5015fc@gmail.com>
References: <20260617090116.3254505-1-shanbeeyoo@gmail.com> <0c596ea4-8c29-4e5f-8238-cb8f8c5015fc@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shuai,

Sorry for the delayed reply, and thanks for pointing me to Tomasz's
riscv_iommu.next branch.

I agree that the PQ/IOPF work in this patch overlaps with Tomasz's
ATS/PRI/SVA series.  Please consider this patch withdrawn.  I will review
his branch and coordinate any remaining work with him rather than duplicate
the existing implementation.

I also agree that the debugfs test helper should not be mixed with the core
implementation.  If I send follow-up work, I will keep the test helper in a
separate patch.

Regards,
Bingyu
