Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8179525621;
	Fri,  9 Feb 2024 10:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476119; cv=none; b=Gr2WPWb6vjjhqapvEl2Z6pjNZMhYFYq5kIzDV5Zjevv8ipy+CS/1s68Jbl6555I/M4sotm02Vejj7HDSpdOUwr9HC5MCZt4/B6blG6esa5ANB3ipuEtWDulKRGXypHg9LkNkIG/rt/XaNzmUGbxQOBD9t87xsy9Eu0UwuDduak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476119; c=relaxed/simple;
	bh=2WOJQ2RgbU0u8rkQ+XtqSxX9y1ZGslQjMejF/3cwOaE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C49U/zA4KdFw+wlryLXYLGz4YLetnLRj0BgSI5nTAE1KVwmXeqY1VnbJjBkTDHbuZh3QljqBirZRIholpgQm98i+GcetG8wqAuLEzN9//8WKDdiGFDAHUALqNbRBDEeCylZ1HVqXvQ6KjLleH8+OAedtlLRWbV/tXhGd5j7fkuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVYBri5J; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVYBri5J"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2a17f3217aso96563166b.2;
        Fri, 09 Feb 2024 02:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707476116; x=1708080916; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPDCxvBNMC7jVwM9lF/rwisiu2UQZms91Q9LKR4ZUe8=;
        b=CVYBri5JGud0htUWwy+/t8208pnFxijDAphcc7r6a+EnyYZ60Igq2HABa7ARgheCg0
         iuluoTOVz+rw0YkQyiTmDJyD9ReFfWMCGa9ATgxxCDIDxnw9rSB2VA4QjccqyN+IHp3u
         h3edpyRnalNSICtKIT3enwPtaHHRLmyDr/r2AqQop8TS8il1GUmomUvQ6LejsRkPDG6P
         zJNVGR/oQ9hFMczt0g4bE7VhqnyuG5K4KSJ4Y/Y37lBPMP1lE6FFEUiKyzQOLXJbH+XL
         cmKf0JTwxrxBiWBJyx0RKdPkNBTfhhl301ERFbn6mvnCuwO5OA9LNt/1ahj6o0Ol2LFJ
         fZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707476116; x=1708080916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPDCxvBNMC7jVwM9lF/rwisiu2UQZms91Q9LKR4ZUe8=;
        b=diU2JXyMOadoVmh6mpCNr6/xd6PgA5d8zRfCChzDTQEPRI1zWzqDH5QrvT7TKcJHQw
         aQMmDMYKhTkj1NBBX9BQPcpOMga3F6s7GRAo8JXYOM5H18y2JsolZDxeGpogt9oOJjGJ
         XYQqUVcKLECdw94kmczsWmT6j1+RVglVzZiWYYr9uEDMkvH2yJ9lNmfpwGznJbz4xVg7
         w5kWknHu4hfsVtuCqKMNzAnWsatTYtDoLViIpp94ZYPr+M9KIAssM6d9PmZYWELk4O+r
         XzXTdXJJw4zSiROZA1YLhkUdlUkS2ZAOEm8iejVeQR/pEPMMwMnJBNnfrDy8is1DsQTk
         wgQg==
X-Forwarded-Encrypted: i=1; AJvYcCVQGQdOo2YUZjvt8IYZaDoA4cS7K9mOfKqpZZIs/6vgX0EDqYEFCmmS7pIwq/dYrIf0uDg2UrY5PrgJQ5mgc5fSZhXItivuI9zOhLFnAUazCWkLVrBugHYI0HBYFin/DyCjRgFEnbadMdFzSCqYQc7AJ2Hir60xJ6IO
X-Gm-Message-State: AOJu0YzKPBJ0VExtxI8ENbWV2usCuA67IM3HM+vYBNq377pWa30gJe/u
	B7739TfY5JCvJSSmh2WLkJ1C4P5+MfrZVk3cslCueqWnJT05vSTtCJJFe4brgv8=
X-Google-Smtp-Source: AGHT+IH8fQC4BYcatf4eNnFGSb58UqS4zJtebYfp5Tkvc0uum0cdKtMKpIELju2LqVMZ4Dh9GK/KUg==
X-Received: by 2002:a17:906:f9d1:b0:a35:103e:3614 with SMTP id lj17-20020a170906f9d100b00a35103e3614mr863231ejb.52.1707476115517;
        Fri, 09 Feb 2024 02:55:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW0W2ig//yQ03IYUX8CzVxAEgCm8ndS3T1j4w20EZR4F7pSO46B0Ssj3CYd8S2QKwCcARm6ki3u9e+DBebFxzoEmI0oAbFUYYnNmQnIfRpW9iMLjJG04+63v/Bw70+28ySDWZpJTWzL6cI2ZNkUJZJBwsdxGXcv13Cex5FSXWQ/rA9VbY9FqqY9gqP3vr4cmM/C3FOjfKS8JqLEr7MLEXtAgcq9EhKu+atw3ez0PoqAKQG/JmJIV2N3c6/pHD4PEA5X2XFnqx8RZrsvXH+e/FBSspe0y9uDFUUpbR+LzWYkl9acy+GflcK9HZwzgdhL5XJATWhk/+YNWJSYJgI+XFcILFpe3zGY7mon1YpeqDQFNax5MEtzOpB5DFscrKJeiFJa/7oEMJeHdR8nIb74rJbhsoPHQM5vd0oKFnfn7QtJHpVf89dKVi8weQbjAgJ8g2mC1rBg2UiWropsPA72suo7mEQ2M8/tfdoGloKbAuI+XKt7MyeE0A4AUXuhmNfplAnS7k3f5b8skGR7wFI1yF/DOwTR9dk2x5l3vM5QHJJa/wXVNHmAM7ZtMSHzOAcf7sB/1Dk6rr6D6sBvSBih/Yi7A3mTIUvJfrTMeAH3bu+fBav/NdxOlr0OWM9Aut74GPCsiTwnDNmslfl6+GV9NyNqTeUeLd6jND27dWT/VhjfxwKpej42Iobb9GYk/l2DwagtHAj1C6DTy4Tyejx0ACCc3UnkebndWh0nS1SilTf6sRtD17hmcAGj6yEScljW6quvxOQyxq1rGybRxq+XfDHNKiGkrJcTfhs7AOxIFi8aJl3Fnj8/k/Q+dBj1ROIQhnjUeOw/Ex01Ynamfb6VACenMHuYjs2DjUiRQe5nrAPgYOyUOHlpV/SI9NViaJOezY/A87rwGJG3CngeT5OAMkMDIqpvq62KcNN+aLUv/t7qFkaBjYyzTSgLR+iN0DO+phbXFZ
 pZJknOwjoo5SfgsL5gCYFRu5BCGxsd7nqNZTS9Hzq/tcc4IS/I7MGp6eiH+iCXIfdGAUgh4wOUbiOFGVsT9Z4idnsbB4hg5CGFiXSz6dgATKIgfsFvnmH4aQsC8iOJY2gmUAl3aIcQoEvOGdClgxelpZRKICgoSZzGK6kDqTQ6vgChMcBthxj+Rdb0aQRz1GtwtU+RcgF48fqY/UxEv4oUdUktTlEpJvnVT+0OlR5hZMlrAkTb4orEqBQKit/397dC5qzNVOLhyViUGFZVmUj8RcXSSScjXz/1Qn6eg+H7iKlae2EqEcdkYUiIBH/c/9zREOdzHiAGPOLatjckrAsePGDqYRUI/w0KCpzynCVjY1wV3GpyCS/noMczEQKDj7rAfUyB7PzDOalH/Cd8ScBs3aHXlv9Eo6z+MLOLKzJwD/e02tmzYjM86xU4WeM23qznU1N3jw777w==
Received: from jernej-laptop.localnet (APN-123-244-98-gprs.simobil.net. [46.123.244.98])
        by smtp.gmail.com with ESMTPSA id cu7-20020a170906ba8700b00a37b795348fsm629101ejd.127.2024.02.09.02.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 02:55:14 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io,
 asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com,
 cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com,
 dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de,
 iommu@lists.linux.dev, jonathanh@nvidia.com, joro@8bytes.org,
 krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st,
 mhiramat@kernel.org, m.szyprowski@samsung.com, pasha.tatashin@soleen.com,
 paulmck@kernel.org, rdunlap@infradead.org, robin.murphy@arm.com,
 samuel@sholland.org, suravee.suthikulpanit@amd.com, sven@svenpeter.dev,
 thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com,
 vdumpa@nvidia.com, wens@csie.org, will@kernel.org, yu-cheng.yu@intel.com,
 rientjes@google.com, bagasdotme@gmail.com, mkoutny@suse.com,
 Pasha Tatashin <pasha.tatashin@soleen.com>
Subject:
 Re: [PATCH v4 07/10] iommu/sun50i: use page allocation function provided by
 iommu-pages.h
Date: Fri, 09 Feb 2024 11:55:09 +0100
Message-ID: <2718393.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20240207174102.1486130-8-pasha.tatashin@soleen.com>
References:
 <20240207174102.1486130-1-pasha.tatashin@soleen.com>
 <20240207174102.1486130-8-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne sreda, 07. februar 2024 ob 18:40:59 CET je Pasha Tatashin napisal(a):
> Convert iommu/sun50i-iommu.c to use the new page allocation functions
> provided in iommu-pages.h.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


