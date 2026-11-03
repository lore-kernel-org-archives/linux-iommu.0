Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695695;
	b=hGSRtToN3/MdyzA+SZqWH7T8mZsS/c4jApNvt+7TbASMWkVTyl7mrRVOoY9zLORU8YXg
	 0XvLitpoNU3ELmi18hk74lJ36sKdUqnpJ+zFlXtYReDk3EQawmrj39qMtGFRo2ID6rH8m
	 ka51gtvq0DLTQUwnrPC0ITggu99Y32hgXXbMIx2Fax8nh3fJEyupRkdpNIG30jfecucy7
	 2vPwfRGxg6nmL/Y0QZVBLNf7fp8W1WfB6GpryvAbb8FbC9xHEEehLTEhk1iDvFU6v1okg
	 hvcW1IRfv+sESM4BhiEqub6q+C56zVmfyUslTQACT210uU8D7h4xu9uVe8xUhDtk6iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695695;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aoUFhuYQcJ6QU5ydKv9+uxtt5LR3lX/aX8ZyHdDkimw=;
	b=yEDYo414ret+uXleCGrcUUCiAeJDH+i6Nm92nWmCZtqs4DinmRdKnBFPLolHieGnr0D0
	 jJacLNPa1Fm9dHuRYemK/0uWZ6z2o3Xh7Vgf5eilMadyvBVWc0y+FDZ4IaGPQVXjhY6ud
	 geCsu8E2BP9H59Fq+PnivGivAekLP6/XMwp4Vjp1k3lRW1Ap/4EBWwLlCkyiyHz4Qsvkd
	 N15UHkoG/0pcILr8SpqpHh48QWJHKLGrgHhl5FcP2weGev+1m27l3XNkOaTTuSqFFcL/O
	 pi2c4suexAFpN6y1mycl+efSDajNsanGPwrPK9zU7T9HzFMUdUgQ8tACvfUOxLDmLSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="XS/xa+2d";
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6D3606A944
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 08:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B6D3606A944
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XS/xa+2d
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso2591175a12.2
        for <iommu@lists.linux.dev>; Tue, 03 Nov 2026 00:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793695694; x=1794300494; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aoUFhuYQcJ6QU5ydKv9+uxtt5LR3lX/aX8ZyHdDkimw=;
        b=XS/xa+2dl47KbU21SLfMK+w3fRzaPX6QzJsuAtsPZsGw30ITXqOpHyss8QCTnq0agw
         f2bQ5qVfxlq0gEYx6qkv8BrfNI8U3BhwCD9Qz7woCBIOvLqcw3BYpOWKw5mqbWXNMUet
         dxsc1aeqaK2qbt19kba4N4B3v2Iom/w6hGMlSXcyyR/XzHZkWTsOKRUrx91WX/27G45f
         Qa3pdo159v3u/E0fPJm5+6JaJe9V1sxK4b8VX/nFlaQjORAWZdQvPNkNwi0KQXMK9PKU
         YTnP09wRS04MH3CKazgzPS+6SsMNNq3HCKwPShKJv00cH/qrfdVeesnlUGUPxe5vPuKu
         hOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695694; x=1794300494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aoUFhuYQcJ6QU5ydKv9+uxtt5LR3lX/aX8ZyHdDkimw=;
        b=CEmU0MiXTra1d7AkI6LHQ6Pb3TLXnYivb7lb8HKK3lwGwuAPOapwv0J9BOh2AVBk+p
         OdwlyzvnphvAish/UgGcuR26XoLS/lsnYE4oJyidempxHLkNiN3P3dFvUA4WgeXxLqwd
         aB5mqvKhsN02P80DTVK88qbyHxZNkD8ACrjPed1amgGQd6bTF5dmpZs0ULN0f1bNMa4C
         C2ALwOH44KyqmPuTt7dc9QN1GXj9EHn79CJwO60YvwEleVAJjBT4i66BfXl8cHGFqPAr
         0bgPyehnNjUW6sGDYYkG9WSyyA16/H3JCzmNc7BufEO37nAc6V+22guanVj3J8fW8FkG
         vLdg==
X-Forwarded-Encrypted: i=1; AKwUvByCW9aUOOSjXnOQySPAQcL6SOU0NIHecZ2HLE/VscAaDI1t2Whg2pTo9Tc50bBxIwpcPPhl5g==@lists.linux.dev
X-Gm-Message-State: APuU4Z/o7lzINuUtMPtdIHT4AkEfOkTLfPVX7+NhaUQVc/U37b6PbZNf
	xNK3QtdC62Xzo3FuPq8o78ug3pe83Ygg1oOCunMPAKw6tNeWsudSdJya
X-Gm-Gg: AYBFou15wIktm6ZDhIkfhe2b6O4cP0mP7iepZM/SZ2N6Wf81RzRD6g87As+kZ3r7/zL
	d6w+SR0wHg8bO8uSWgMkLh2lpn2uk2nt3FYOm649wbHc6HgP6Efr/es7s4IpFpT6RcH/1mi/rb2
	plP/2B7MkDjcJLLdZ/sQK3ANgkeiKeKEOzcz0sg5WEHO7UPfZH4j7peBXmOLJ3ulcj2AWrCoWBI
	0NNovFCLYrXMx0FVHKzs3F359dtDif+PcAVv36pk/WbFvQYSG0LTk6dAp/oBrUvkV846vgGWLvn
	MEMIv7p6ZK3polHb6jLlVY8ajvdaWpW9wUbLtrS/wm8KPHFZwNUqpLQUFOUuTq/s6Jxnt0YTMMu
	ldNfY5kIP/Eg9AAkYuzXICLS2538GqI3ko+a83hgYH1bDpBg/kkO4W00hjvPDTQfvBxXusdbDFl
	N7lTQ8Rs9hRx2hfPtf2ZALaziTFsRmjOGsV/ZoTUe2J9HeL1M7fbKHV1DybXNZU64KWX8La0DDk
	iocXU3pXTqFcXuEFnJwQP2i/E1ylmXpLXCZyB+zsSBSVqP9iIyQoYtYqajqS8hHUvU5djgw04+B
	jhzUbkJ5zKUgF3PHKNjYqqdC8dsfBClREbwhdy57fkn7oA9E
X-Received: by 2002:a17:90b:3c0b:b0:3ab:9c73:130 with SMTP id 98e67ed59e1d1-3ae89764119mr10317018a91.33.1793695694619;
        Tue, 03 Nov 2026 00:48:14 -0800 (PST)
Received: from spiderman.taila3fd8c.ts.net ([202.112.47.77])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae880a46f1sm8608222a91.3.2026.11.03.00.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:48:14 -0800 (PST)
From: Li Ximo <lixicaicai@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wang Haoran <haoranwangsec@gmail.com>,
	Li Ximo <lixicaicai@gmail.com>
Subject: Re: [PATCH] iommu: Guard iommu_group_first_dev() against an empty device list
Date: Tue,  3 Nov 2026 16:48:05 +0800
Message-Id: <20261103084805.2465010-1-lixicaicai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261026143758.GA1674867@ziepe.ca>
References: <20261026143758.GA1674867@ziepe.ca>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jason,

On Mon, Oct 26, 2026 at 11:37:58AM -0300, Jason Gunthorpe wrote:
> Are any of these even possible to be called with an empty group? How?
>
> The giant wall of text at the top failed to explain how this could
> ever even happen.

You are right to push on this. After re-auditing the call paths on
7.3, I could not demonstrate a reachable path that calls these helpers
with an empty group. I was wrong to present this as a real bug without
a demonstrated trigger. Please consider the patch withdrawn. Sorry for
the noise, and thanks for the review.

Best regards,
Li Ximo
