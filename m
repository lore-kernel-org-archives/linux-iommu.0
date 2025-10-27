Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A930E2DECCB
	for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761594693; cv=none; b=u9w9iJzNFoEEjhCIo4qbWL90wy6HNUkUabOxkn+gdPgltowvfMkeHwVQLs/k0AfOsAP21MCcu6TYZeWb20IvrLv3ZiuW16bP6ru+osPHIsBpG1PJSY2k6FqKVMg7wQz2uMW9kLzqjdd6Tyr11XleABJHqxMbYsxQCtSw8mzoz10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761594693; c=relaxed/simple;
	bh=LUw2mZCfH1yOBKTSy9rxXAh/jPqUNSJVBaTxVdNrEJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MyFjc8ZKMLVQv58fRLQq6o80hJwHTaZmDLWibQuowsrYUe79ewl1Hjrx/Fp9Wor1u+EKVDadIRzgOPAhwTPDDYE6vIgpZy8eYrrn54e6JKKm7yI/CdHNMDnIY0W4GGqXChrHd7DQNZFKfAICGnr+k/fEv56GBa7U/YFbScJcL1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LPVZKtqn; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LPVZKtqn"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4eccff716f4so76831cf.0
        for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761594690; x=1762199490; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUw2mZCfH1yOBKTSy9rxXAh/jPqUNSJVBaTxVdNrEJg=;
        b=LPVZKtqnY4emjo1YAJajzXCK5tEU4NAjpmF5/ZKJ3apQEEzLf4bRGBPtEHLnJT11TP
         WgYzOnYbruKydqPmMrYuNLXmwPPPuVExxtBsc/Ufoo9WJTAW2Z3mnNGOuL0UZL0WvIpu
         ANxEQNXI1FKC8rEyuPfD/5RF0hGuQ56QMmarACBLN2qDsKWrh/WUTa24nrJ7/RC37r2C
         cO51Nin7OielUJNUPilZQE18Tmouk7tvPOz1wrDEWvHBrk3QwJwtqWfA5EwyOJQr2L2D
         cUL0Jw2CmBnWsPewLsMbzEcgD5I8sV1eKiOIhx+1ed1YkGitg/jiZk0hILQBM9Y/ayTn
         3y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761594690; x=1762199490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUw2mZCfH1yOBKTSy9rxXAh/jPqUNSJVBaTxVdNrEJg=;
        b=GYmT8s6hZ9h4PEr6oT2yFQC5/nNMk93p1UaIw5HOrGtmQTH2fLxek0NUfMZmeyRpMD
         ftPz10mABsMl9ZmagO1DORKzcAZHlQ5Dw237/b56WcIQtU0zTsfD+cjWxfiOhaWiF6Km
         dFqXwPzTUf02otT7cLysslYEQl0Au4b2bTuGZt+76nFd6IZO/K71/tKRMlPdVmJd0CNs
         N5n4n4PABFwqhdWa22OlPnT4lM5oQYGhExMc+s5FotydCVOstK2vdziiXNsHGVRtmRsS
         In6Ro47aDcx/RlZJqUDRWwytfSUjKkfaPUCtuUE0kcNtNzCmsn+vCm3qNkAUeBZSiRYt
         hAIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZVbDp64dO09fVztnIChTUXA/9/Qyz++C6SRoBjzF+hkPadjcExGfAlFFEOjeBdxXw2T/6sQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTBVivpGYHjtcg6TGcmqxttH1TOxUdfv9G+Byo3FlIBSm6ptB7
	id3Fass6eevimMzcMQSABMhizFZK4jzv7AiuXhkY9LJhzQgoPjhTGYokOw47UYrkv7KG1657B3z
	RIN6Y4h/mjDFWrqQt1K8xMzbheexaSDXtgZmyf7u0
X-Gm-Gg: ASbGncvWRpL7YDrvGxZKtQ0NgmwlknJ2FlKvroXT/DaiLQOoB5PVTj5ofLP9T/xtAO9
	++VxWzwyOvU9JGmVzmwKj3q55e0/W9g316dgZAm9VVOzaoDnLAhXfmOqMcKgLg6iMi5J95ucuJ2
	u7OIpkhJOSwdaUViwgC5ECf/S+iiMeNBEChRFUwbGTv/i+hhlqFp3TAul1IFG6Bea7xy1MudnIZ
	gUVgg6qVFheCcwIdwod7WQUvg0BHziPokC/MUJR1w4torIByEMENgN6ru/b8gFc7H9MfA==
X-Google-Smtp-Source: AGHT+IEmicxEYEPLgQn38b6v1mJfTIvyLMT/qtHkmyMNLHlEBQmcYJx6gF8JYoLZrM0kAWrtv1hez5d7WlrSFzFFVW4=
X-Received: by 2002:ac8:7fcb:0:b0:4e8:b04a:82e3 with SMTP id
 d75a77b69052e-4ed08f1af35mr1416621cf.10.1761594690047; Mon, 27 Oct 2025
 12:51:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251026203611.1608903-1-surenb@google.com> <aP8XMZ_DfJEvrNxL@infradead.org>
In-Reply-To: <aP8XMZ_DfJEvrNxL@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 27 Oct 2025 12:51:17 -0700
X-Gm-Features: AWmQ_blGO7QUW6nBgXPDBNUnzq3Ln5ah_SLow5ox4iXfcHmzA4G72ZsuhQ4Fq80
Message-ID: <CAJuCfpH1Nmnvmg--T2nYQ4r25pgJhDEo=2-GAXMjWaFU5vH7LQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Guaranteed CMA
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, alexandru.elisei@arm.com, 
	peterx@redhat.com, sj@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	corbet@lwn.net, axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, willy@infradead.org, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, hannes@cmpxchg.org, zhengqi.arch@bytedance.com, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 11:54=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> Hi Sure,
>
> jsut as last time please don't build empires with abstractions that
> don't have a single user, and instead directly wire up your CMA variant.
> Which actually allows to much more easily review both this submission
> and any future MM changes touching it.

Hi Christoph,
I'm guessing you missed my reply to your comment in the previous
submission: https://lore.kernel.org/all/CAJuCfpFs5aKv8E96YC_pasNjH6=3DeukTu=
S2X8f=3DnBGiiuE0Nwhg@mail.gmail.com/
Please check it out and follow up here or on the original thread.
Thanks,
Suren.


>
