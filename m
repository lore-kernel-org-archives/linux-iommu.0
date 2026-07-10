Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA67347535
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717875; cv=none; b=iK0PQ50OQhWEzGjXY0cM3XrGRjeItiv0kOq8LU9bWUEfxjSXr0PcQaRnQ0qw2Hg3WkhAuTFNMvhPrALBOldbNdqRdD/k8j333aJl6QfjIfr0CH9MytQsz8apu/PSaqsytmbpci90D2dh2NyfyeIHr/4ftVamPWLc5khUlZcdIBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717875; c=relaxed/simple;
	bh=64t7FYB+aOc4n1B7jdfC1HLjfGo79OokY8KIFToWw7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1Ptvcyo8DbCX/6rxdW0eFuM+xsG5Oe90uiGlg694lmx3+GPyNBKTpwi2eXHhKldyI7eEwSG1IvsEESu8Qeb1Wx9E4Til3QTUF1dE2Qr0CZdaHbOzLDRCcxrK6XQQEvpOSkLK3Iu1Ngo0cgV1529h6atqh9vaMywqRnTT5ICbCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s2QMKSkM; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2QMKSkM"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2ccbff2e6a7so8657485ad.1
        for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 14:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783717874; x=1784322674; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=64t7FYB+aOc4n1B7jdfC1HLjfGo79OokY8KIFToWw7M=;
        b=s2QMKSkMUmkhOFNaHeVn07kKBjMgXVgwYSQqxkJAX1fYSRWBlMhrWq4m0vHelraKQL
         ZjRIuJSRlkAVIEEQ+Z8xzIhn/auNbD75vUQhAVV6pjLuJSaARyedJVoudMFOEFKtG1Ob
         7RHzuNKKtKULKobkXojVT2n9wCyp3WYwCV5EzFq4C3pPznA0aHdDI9Y+xj+tPa71z835
         Vslfxw7MTWO74jkJOZ2mVZ4O7aUZkRmm8U0v6erzMr5Xnfpec2CZh7eZsIN9FD+EmBUo
         DtF3sSOJEMaXg6CSUpqlUdoWG0RfvxGrTTvTIaw80HS+GuXaRzLFad9SYLzkh3IzfRAJ
         7C3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783717874; x=1784322674;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=64t7FYB+aOc4n1B7jdfC1HLjfGo79OokY8KIFToWw7M=;
        b=Bh++6lw79ZBwrHbR/xDNTcUYdNVsZrfnzJ6z6REVVbmFPq1X39oZywSWnagGESE+in
         s8lb4LDy0NO5qumhcjl99YTsfwMOQwH35SdDPjfhYYUBdqqlyhbFLtkHOEak6WMQKIzc
         trM7bvl/NCupznPXpdKP6aNZtdpNUTKsMO0Zt1sNzLtwAVOd0oJdmXZDY26ntxnqfrjm
         dWtKIdVQCBBO9ubrsyN65Dzrs0duHM2LbnGjJBNZDg5wMigykPIlJ6tqjvo6XfFdOTzW
         qg+A1RUJ16+5LPkKDkbBKpydaRjCzKhO6lBVHIvvxQiVKK2FRzgz5zNYCFqW+R3xioRL
         NV8Q==
X-Forwarded-Encrypted: i=1; AHgh+RpZ5fLht1AeVFQZYrFTnyWCjS++CH+7++WRT4ZMrAYNZLklTHY5keYTHFRYbDwNyBOfsZKAkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3HbjhSc9aYlKR5/B5J/+0SAJKBUtZUggg/USGOEjqc0964Gpt
	tvz1qf1066KEz/LjTiUPvV9rV+4EQ4fvZfUYRm46JHaES6NRTP2a8ppj
X-Gm-Gg: AfdE7cnjq+NAeJVaZG7C//0YBlN4k0Oa6GMDgY3uS85su4UDhyHw9882AXcGPjhqKxc
	fMA5E1OUTTImVWRoTev3fx1WPUEqqTWUbn+YSVPQhqZ09QtW/JwEyLPElIjq0uTsZWmF27Q60Xe
	uh2pkKXzdslyQdsQW/iG9ewHeKbQvGDREQBSGgEakTzKCiqqnSbilkoA5uB7kOg8SMftncJhTuD
	09Q2BBQywDUhKy9SXcac/bELdXjedHT9zv2QiQHgbAq0OQXtfJzeblyeQHt7c7+wmsSHMVFwjKn
	Ozrw9uBLm8uvwIOjnZDy83B38oTRErMZIOLPr9h35XiY7pJL0ytg1sc8aFq0ZbCeeyFgnsnxkg+
	zpIBcPzdikiMIncL1k1Iu/7qVr9kRRnNgLpLDz7qKV4iSz/PXbTcsQmmKKu9MW8FqadcqsXwMpC
	Fsd+u5EL7vWww2Jkkh+NfTJHOj14AtD5N6+na3c+bqsB5Iislk3drcEAeayHIdOSER/L9ZCBw=
X-Received: by 2002:a17:903:458f:b0:2cb:3f5b:6663 with SMTP id d9443c01a7336-2ce9e9b4534mr6597835ad.11.1783717873913;
        Fri, 10 Jul 2026 14:11:13 -0700 (PDT)
Received: from ubuntu-gnu-linux-24-04-3.hub ([2407:7000:af23:3e00:f127:785b:6e87:f831])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccdf808379sm52881965ad.48.2026.07.10.14.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:11:13 -0700 (PDT)
From: Jiaxing Hu <huhuvmb88@gmail.com>
To: =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Cc: Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/rockchip: implement .flush_iotlb_all
Date: Sat, 11 Jul 2026 09:11:05 +1200
Message-ID: <20260710211105.9782-1-huhuvmb88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710111508.917486-1-huhuvmb88@gmail.com>
References: <20260710060513.863714-1-huhuvmb88@gmail.com> <20260710111508.917486-1-huhuvmb88@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 10 Jul 2026, Heiko Stübner wrote:
> accel/rocket is in mainline, so I guess the interesting question is, why
> are you expecting your changes to be (stay?) out of tree?

Thanks. I had been treating it as exploratory: single-layer inference runs
on the open stack (rocket + Teflon) on RK3576, but chained inference does
not, and I narrowed the failure to below the software surface
(fixed-function hardware I cannot reach from an open board), so it felt too
unfinished to send.

But you are right that an RFC is the better way to handle it. I will clean
up the RK3576 bring-up (power domains, clocks, IOMMU, DPU/RDMA, DTS) into
an RFC against current mainline and post it, with the chained-task
limitation described honestly. If you can point me at who else is working
on the RK3576 NPU, I would be glad to compare notes.

Thanks,
Jiaxing
