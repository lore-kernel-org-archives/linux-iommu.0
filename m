Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8B529B8EF
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 03:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765510458; cv=none; b=uEsAupBpGhKxMpkwDDQSOsraOCZaq/YQ2Fq1jhH+9I588GWQbSCj1a86AqWQkEeTK3Pe0wGIqLPCXDbok7Fkby4uwqeGXmkG8WUVLbiMs1Ik22kytQp1UIW1wpPXRlr0jPD5Ny5lQoqfF+oOLDJNbJhDe+Lr6rikzogOloKG1ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765510458; c=relaxed/simple;
	bh=HsbNc9NhdAR/LG1ML5qxg47G4bhkbg0BKoPAGiEnJGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJAUhYWCiM6W2YmblTwdT0eUX0Mmc8T3QSWFC4epak3UiDJoHBm8tOWRUz13+d6ELUNczTl+n0oYM8LJ2LyPmD8KYpq8f497cJgTmdDHPrz+oPbsS7l0KIss76TtyzCWGxG/cEYzrdAxNcEZVliUpj+T6Uu2LFP8tNa4mm7Yjx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hi9eEy3g; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hi9eEy3g"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-349bb0a901fso128167a91.1
        for <iommu@lists.linux.dev>; Thu, 11 Dec 2025 19:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765510449; x=1766115249; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DI+KXchmH44mUxxpsbUV6PudffQTHA3dEjh5VjxDDHg=;
        b=hi9eEy3g7nvv8nLOhfzq5kb9uzdKE1eg981Qrww6D2uyNDIvzk7eNCGu4yZJI7wCux
         3iz3NtNvGnlDHtYXhOzisYPMHWfpvlwQCtrUT/6+naZ6nvvdWj7jfxBEfCQb/gDIHDVX
         Nqbo3e5ND6UCSx69kG4Hu4+yPpm6z9IgoXb+ns/w/SBNmM5XR/FZpHQ7mhfNey+AMtCp
         mgkJS95ma67rXF65nS0cm8L47EaNbznkKe0EhT3B3Yp4UUZimHLg9AJgy4rgBliB49AI
         y5Of7j/wAFDvUupb0wHLzijHucJAi3CznVaw71VzBMivlPZZPTx1bKKH2ljozvvbvC9C
         6tvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765510449; x=1766115249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DI+KXchmH44mUxxpsbUV6PudffQTHA3dEjh5VjxDDHg=;
        b=KddnB71lq5KKkgD5qslFhka9AorY0fGJFwSLapct+qS5UZiXTNKtb0vC4Opr6v15Bk
         xawsyevdSBFCW5yWlDcTBb/EFBaFrM91QCg4ak+SVD1N4R9jbp3ararJ9AQcwIHqDEOA
         2vMS4ww0AklihQo7W6vBnk1BHulQ1hHD8+opXcaq+sFMkVXcNIuB4NzgVlmJKZSOyqF7
         YV84NrIX9wPzjm5HE9AnGsty8H2IG26681hbfPpxso3Cfd399lCDTvmHAa8GhMeW/2xw
         lec05a8ufpYzmmhW8l6sc20rk6lYT0K9JzIXk7PE7YBr1XbKR7i8TbI0zppeGQSHTmnb
         4Kvg==
X-Forwarded-Encrypted: i=1; AJvYcCWbIa64IuEeLejT6lT/T9+CNCXBvZxOW8LveNWHYNcXSbwFzbG49EGTM5VH6+c3R/cz97j1kw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtLXjRzs1K9UElMxQ07lPDDPTaLi0/Trk8ppUP1ZWbM9nq+49X
	hu3hIPWBLUCMTB0gtFLecEDtpDfp0iSCcAI2NQp2KCM47PrC34ZBpqDI
X-Gm-Gg: AY/fxX4SxfszdIams21CG6ZtummWoMX4LS+XhPCOsz8SDjiHlr5iZ6FR+29iHAQ+rBc
	aTzD+2ORf7DCKQUH7tWGP8IWr+O0K8O3ys+Sg97LGbXZXoH/2DkjKogLmvnxgFEI0lGYaplSfqm
	OInSlzoe0uxpoKfOk3e/glX9/Uhc9/PoCtueKBUYIadF2jk2H3zUF+u7lxA+sh3LPkHq6ItXRWp
	q2YnXaREx84R0YrFCwO4q0UReEQVudk6lH8rBsq7JwcLiBnJb6U3JPxFi+TTyyFKVSJKFbxCWtb
	TR8TgrgFOJlWh6KSJFa0iZdOnCb3aW9dIJprDrs34eBsTZlcf5iAvVg+mz8zwcVlV0GQ7qxytzR
	nw0YcH4Ufd7A9al9eNQdeoK9K00QJGajkvFT1KS236ynzMuhnewX8PKqXjMG7pCwE0QQ74/htD6
	7FNw4j7Rj9W4byN+0=
X-Google-Smtp-Source: AGHT+IEq2LErwdAEYXkfS1MvdZpjTJctOQkyTkNrB4+pZbLaSSuDnUfhZAotu6OCfqjLgju1qwGSvQ==
X-Received: by 2002:a05:6a21:3397:b0:342:d1c5:491 with SMTP id adf61e73a8af0-369aab23434mr604352637.0.1765510449357;
        Thu, 11 Dec 2025 19:34:09 -0800 (PST)
Received: from rock-5b.. ([27.17.162.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ad5996fsm3575764a12.22.2025.12.11.19.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 19:34:08 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: benjamin.gaignard@collabora.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	joro@8bytes.org,
	kernel@collabora.com,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	mchehab@kernel.org,
	nicolas.dufresne@collabora.com,
	p.zabel@pengutronix.de,
	robh@kernel.org,
	robin.murphy@arm.com
Subject: Re: [PATCH v9 3/7] iommu: Add verisilicon IOMMU driver
Date: Fri, 12 Dec 2025 11:31:57 +0800
Message-ID: <20251212033157.3036182-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911155720.180465-4-benjamin.gaignard@collabora.com>
References: <20250911155720.180465-4-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On Thu, 11 Sep 2025 17:57:13 +0200, Benjamin Gaignard wrote:
>+#ifdef CONFIG_VSI_IOMMU
>+void vsi_iommu_restore_ctx(struct iommu_domain *domain);
>+#else
>+static inline void vsi_iommu_restore_ctx(struct iommu_domain *domain) {}
>+#endif

After applying this patch to v6.18, I get error when building this driver
as module:

drivers/iommu/vsi-iommu.c:541:6: error: redefinition of 'vsi_iommu_restore_ctx'
  541 | void vsi_iommu_restore_ctx(struct iommu_domain *domain)
   |      ^~~~~~~~~~~~~~~~~~~~~
In file included from drivers/iommu/vsi-iommu.c:31:
./include/linux/vsi-iommu.h:18:20: note: previous definition of 'vsi_iommu_restore_ctx' with type 'void(struct iommu_domain *)'
18 | static inline void vsi_iommu_restore_ctx(struct iommu_domain *domain) {}
   |                    ^~~~~~~~~~~~~~~~~~~~~

I have to use:
#if IS_ENABLED(CONFIG_VSI_IOMMU)
instead.

Best regards,
Jianfeng
