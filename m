Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F092C79CD
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 19:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772049368; cv=pass; b=jLxASAcGWh0Ac7CWV2lC+kWRLViJldq8WQdccF/GlJY7w0eL5oXd5sS/lPmlvrYKgFOXrlmPOWgWaLemY8PxZ9g7KY8F2oxe/jejF7oTSqF/aWUlFRr00GCXsjOFtD79Olf7aYGlaiYq2julXB+VAV8dBemuOcQ85xnMkIgv2JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772049368; c=relaxed/simple;
	bh=HRL6lEk8UXTpub6PekQgYs2cjNTKn63oRhQdj5ExDbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USy1TQeRrAiTTGLWXNK2yS7IRApqJMau+Qw+4nv3eL6OT+W8B39JCRVaVvdO9r9vvT0WkDw+aTGH26ZxmQkg4cFqtpUZTTBfAqxJXiAOgQUG8seLDCwXI93pwz8SL/KC8iPca6nuh3/8KOJsroXWp96y//+dUZI0QOx1MwxgVLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qfd7r8Td; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qfd7r8Td"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4806b0963a9so14665e9.0
        for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 11:56:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772049365; cv=none;
        d=google.com; s=arc-20240605;
        b=lRNxTMazpbzxWmwWnyg8IfybzPzkouNB+O99mqHPaVQ+JR+J42LN2QC/0Fa+db3X2u
         GiL14lvnaYBzmpfeb0MHkMAHiMktnNRSHRyKostHhnOuobXO6Iy3+r3QCArKeQeM7jYO
         v90kRjIWVusinlYAedEDQnhj6g4N14y3Y3TJsMD0kOouZLWVB46B/lV+zsmB3kaVQtra
         gm4FtvKM/wUWdewahK7/D2nqGa4EvN4GMbqtNhnedXiYTrjKYORRgVFndIUZeTbVYiFb
         7O9srVHfNFl+h7CpbThlw0/o1eMYnZjoTHxPOzEHI5MRKvpYrV5I6P1C6Tv4lPi2JTHm
         T70A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HRL6lEk8UXTpub6PekQgYs2cjNTKn63oRhQdj5ExDbk=;
        fh=h8yLmjrernBF1YHXgNk1QFZ2DCb6naIaMkhrqp/uhrg=;
        b=dWR2gd+9O5GULGZ4HRlYrQFfyTs+MAowvubNAruhiNzciLQ8zfLmqbD3oGrCNSIi2H
         khXzGs89SjTqxW6rn8RixeRubJEa0Qb7szCciE7J5Hw/K4+CnpR9/vKdkzgyEOJdlxoK
         8EN8xS/1hJ405FGjI6RauHPPAwTmgpZM5nXyRX8RPSpmLYBdtsS6Fr8ux/pUjeMvZeYm
         F2jjt74JlvaezEFljpH5eAZzdnYcbQT0r2zJlBkQNJWJ1AzwBZkIBgInw+Bi3gRvWC5A
         UG7Bpmq8k3LnA3srSY3ldq0srhQeUGpGj/vnAB+0k5mHM6fVHWagClIeijhCRdDfYqRx
         V6vQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772049365; x=1772654165; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRL6lEk8UXTpub6PekQgYs2cjNTKn63oRhQdj5ExDbk=;
        b=qfd7r8TdMR3dFyU6Ur4f0IioPCMFrbwI5vutUrjwmdDPoeF7skpVZyOfrOJalnW8xl
         Qjvp2k7amB2L4kJeK6i15E3SeH297MTahLzi71oY3WNkprK/s4PNwp3zcNapEaNL9i5N
         tSw2C/a9c3So58t0J/mB5yRpN/mqXDiDiD2pDV4qPW9IefMWA2jdspKMVhxzfuel4tNT
         x/E5r/sx3h6D7E49RljbNvlUPvbE/c8i2OSFMxaECAf6bBNLSjTtJOBK2bTakWCyKn9k
         6vawzhYdOLZZNC2M/qFI76i5s+kcoMaZIiCHmRXBW/grmJ4RKfJYyqOQ18LZBfDmRHos
         4H1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772049365; x=1772654165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HRL6lEk8UXTpub6PekQgYs2cjNTKn63oRhQdj5ExDbk=;
        b=J0vlstJt8V4XSTi9dAaUc5q5/SNTf0IO97TyHv43kMwbimvC+FdOiM9InOXBePGiwc
         ORk/gLZcLKqra7sp9vkLiBy/VpW2v80IfAUnIrp7FswDYsvo81GsBz9lRn7/6yywNPGN
         v7yx9nI5ajxVZGJKOIdXDr2LxT+eTSjz6fLXPAP0ddY/0jvlyd0v0E5BHXw/TCqB4ghO
         dXLqiDarRYSThEf9GO+YKz27XXAVZ3XI41r6wu8ObJeSPN+/xoe91U8CmcHFQUV9urvI
         amTpgY19OWBysWUTiYijx8If/8m+Z/EFKOuagrgDNd4lfLTP/RhdNdpX1dpc0wYC1XhZ
         34ag==
X-Forwarded-Encrypted: i=1; AJvYcCV2OVG/UMzHRrEidVOjVxSEOAQ7wbOQdtFwK8pScJNcBUSkcF5MtLEoH5KcGq0gD5qqZYInvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyx9NeKomyQSSOGw55MH9vRUCXo75tmVXTQ2It9wvFzhyzf/dQS
	eQFV3wB9ovATRziBHRMq/Vuj5Rkzhj4fwhb8XldK+oOAhBfsx5BqmHJJDzQBO9y7BMd2drzozVv
	vDHIzt75Y3EAQDvhNxYr6bPbtSWtDs46fsF92yCE9
X-Gm-Gg: ATEYQzwniDKIlT9XxqNLf03b7uOAP7+gYOyJZd4mIBxC9y6olvFqcmlszWv/wINTcSa
	4aCkhw2YauHe970ApN5hgHNdm09c6u9pNL2TkeH0gLuszsjgNudhqD2c74P0nrA1NMMSqBUGCMN
	csO5vQ7gRHv3UzcCPS36exRVVvwKlAESEDjR43jCKcY/PD5UOn36uUPeEwFyeO3YkdVxHsFT/8z
	YNpI6uMdIdpZIaeS5n5+PkWiYdT2qMMAEh36TH8Ka/se9nJFCtbGDTs21GxYEhINUQ69uiFJlN1
	hTM65RW/vVs71TU3+PEBESoU/XsHgVZxTuA+W0VwD1UTujETKFoxDRT8infxsVZ2YOrynw==
X-Received: by 2002:a05:600c:6a8f:b0:477:c5b3:7a9b with SMTP id
 5b1f17b1804b1-483c3188d68mr92305e9.10.1772049365087; Wed, 25 Feb 2026
 11:56:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260225-dma-buf-heaps-as-modules-v1-0-2109225a090d@kernel.org> <20260225-dma-buf-heaps-as-modules-v1-7-2109225a090d@kernel.org>
In-Reply-To: <20260225-dma-buf-heaps-as-modules-v1-7-2109225a090d@kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 25 Feb 2026 11:55:53 -0800
X-Gm-Features: AaiRm50aJvmG-U5wbOHTqLRYSqzdYRLj0K9YYWnCflGgDx3T0BxE0_R2bnIQaGw
Message-ID: <CABdmKX12GL7gd_TMArPbjGwSOOhu+udFHZ61dDfMwWf3q6cB+w@mail.gmail.com>
Subject: Re: [PATCH 7/7] dma-buf: heaps: system: Turn the heap into a module
To: Maxime Ripard <mripard@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 8:42=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> The system heap can be easily turned into a module by adding the usual
> MODULE_* macros, importing the proper namespaces and changing the
> Kconfig symbol to a tristate.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Same comment about a note about the module being permanent.

Reviewed-by: T.J. Mercier <tjmercier@google.com>
