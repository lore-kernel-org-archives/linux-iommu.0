Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085B847F5B
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159118; cv=none; b=LslV4vgZE/w/GYhnZdPBuvQhbIzzuMvM7ZTZoYTKxdcfcV/+WEu1RnH/BwGDG8+OIf1LT7grFseV9ch8Wa36MzHV3Q4ZxfVjg8qBVUJ9YYQL/5gLrsxwbZbaCl14RqAGtvg4NWp7/XCqihHOMiwaUaO8d9DaRBZLIjnLjBE0CoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159118; c=relaxed/simple;
	bh=5VTygx6qb8sYZukMVdB0Zlh8j66lTNxSLNHqv5bFTEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUJxOe30+iVCFZoYXCmzpsR4MTmo6PRZAWDTXyoxJj1bx/FAcqiK6ZpHW8EKpnHInEN/BwjT2BTt3iYLXUXZrChuzydbZFQh15PMQDNvXrImMd9pplZRsBTzbG5q3Q38tDkDq1UCMg9t4EbWnBXU4Nawc8sbMY2kMPh5GDevvI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=LCFw4pJZ reason="key not found in DNS"; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="LCFw4pJZ"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42a8900bb93so34956911cf.1
        for <iommu@lists.linux.dev>; Mon, 05 Feb 2024 10:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1707159116; x=1707763916; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VTygx6qb8sYZukMVdB0Zlh8j66lTNxSLNHqv5bFTEc=;
        b=LCFw4pJZUe/VMFrluE1W/8s6WX8oX0KgGa+qMyl78ENd0/YFS7mkE5a81AfMueuO7v
         d96xwAp2yyG4jAA/YUxSQqquIBWMXreURNQNQFN5lm88Tv2qor2MYw7n01vhr8nAxKB/
         oxX/jEdNV1vpyx9MZbIWhRGyoCYDpTkDzOud6Znnrqzp3h3yKpMpQv26I24vQ4fiR717
         4hylRcqeM6Fd/LDo65CH53/YnQnN8B0K4FfhToJEqb0A4K4D3S8ngUu1q2V6YBDuwgld
         3DUDyXer5lzmZDTUC5R9dvi+KG9X9+G8U2Z73sQ7Gl4o5p/Dc38MHBUJoWnZMh7k6IbQ
         pQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707159116; x=1707763916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VTygx6qb8sYZukMVdB0Zlh8j66lTNxSLNHqv5bFTEc=;
        b=Sw/ZHbzGSfEBuElBf5FpBhgd13rR+pQDMHI3LRA35MY6yzYNXGj/MnFtkSTNG0gwVx
         odm4qf8Yi7KjMBqsr726QDv+pBW0D7dtB2Yp3oZhODODFU6EcaXSGJcNXnrwrRMSs6EJ
         dg7HwZWSSjj8/AYaZlSCCt0ipSs9yTnKv0/qJg8/RFazpdb1PdbhUPrhaJPa8DIXIi7s
         hrh9VPFim8qU5Knh8cCYzRTFtlW6TiafgWAiHY0EGztMV/UUp16vDCI+ZwIqLJVx9tPS
         ur18UC9vjBgPivhuCPh2/7QofVo11G9SSt+WK/9g+9dVW9xSITM96iSk/pRHpYQ1n/D+
         z6Bg==
X-Gm-Message-State: AOJu0Yw/63YSq4mqbugUNCuFGUqFdaOle3xTVD4UVm8sytLWMIDY5mtm
	es1dlYawLyPp+ByhGcju1KFA1o5pE/r1Mg+YMd44NwfaqrzfPC7omYGqYrpmwwUGNSnRsqG2FOK
	X3uSkmw8mCXhWRywx8+dnsXzH1UF2ldfazsE7lA==
X-Google-Smtp-Source: AGHT+IHCtUOUFGkzr8TaBXdeKKOZ0Xp0nyD8dcW0qlThLgsuY3VQrT8RHm+w5NKlMubnehHSEWMT8PuNkDi2wou0sNY=
X-Received: by 2002:ac8:5f12:0:b0:42a:b410:fa47 with SMTP id
 x18-20020ac85f12000000b0042ab410fa47mr18907qta.17.1707159115882; Mon, 05 Feb
 2024 10:51:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1707144953.git.robin.murphy@arm.com> <ae4a3bda2d6a9b738221553c838d30473bd624e7.1707144953.git.robin.murphy@arm.com>
In-Reply-To: <ae4a3bda2d6a9b738221553c838d30473bd624e7.1707144953.git.robin.murphy@arm.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 5 Feb 2024 13:51:19 -0500
Message-ID: <CA+CK2bBW08=reuD7UfkJfzumVx3ZFYJuD4ptriW4paBiNKV8Hw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iommu/iova: Tidy up iova_cache_get() failure
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, rientjes@google.com, 
	yosryahmed@google.com, john.g.garry@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 10:32=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> Failure handling in iova_cache_get() is a little messy, and we'd like
> to add some more to it, so let's tidy up a bit first. By leaving the
> hotplug handler until last we can take advantage of kmem_cache_destroy()
> being NULL-safe to have a single cleanup label. We can also improve the
> error reporting, noting that kmem_cache_create() already screams if it
> fails, so that one is redundant.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thank you,
Pasha
