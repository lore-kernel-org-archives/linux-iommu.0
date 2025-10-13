Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49747314B84
	for <iommu@lists.linux.dev>; Mon, 13 Oct 2025 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370211; cv=none; b=GYPwerf10abNn8Qh/eaAPoSOFe5/vRX3r/vRR/wY/O14np1c/qNwNA6d1xCsDw0z8og/VCmI9elv3XVrmMZ6W9e+o8nyGOgQVjWYCG4wQaD7FkQS0122BcLm+lrRG+HkQqFFM+Qvid+Wph8jdYRrdjchlpHgmdyPYSvIsb+3jBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370211; c=relaxed/simple;
	bh=kIVPmCT9kaUq2YA1N7gOyA1JcTYZFNkXFcLBy2dOX+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VyjEK+KKBU+7a1uAgHKxjXL+JyKU2/dtwrTVbVK03naWNIg0rHN9/cGtRaHR31q7vU3t3fM72LTH+gdKVyq8RShvQChRw8wnMXZclCWA21k1oCgVHMyhEqWjAhlSUBo8k/LPyVQLPgO6d6MvSxF82HGR8KfpEtlUM1DxsV+1qtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xop1oQvJ; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xop1oQvJ"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-4308afd43f0so1374475ab.0
        for <iommu@lists.linux.dev>; Mon, 13 Oct 2025 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760370208; x=1760975008; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvE2QaubCaNe+b2bi3Ii9pwdFgyDED1xYIH2KKqTA4w=;
        b=Xop1oQvJEeY6VxUdOSAYn59kLMbUw2dJeLw4o8HmPO0F4l/qg4EydHQXV+VVxmzp2H
         Ajy/lb9px5GsoM+l+aWuT4ty5soKnwwzioWIpwmPF0R2Uw4NuzKunlqBiCWniaOSizlX
         9mnDu5WfatgrwPhIwEhYfc2HLusRHnyTDpnT5TZTHmTn1FJqLDFzECUwpVzdFwjnh6Q4
         efXRWkUDfWqIIskTo4vzdfrlZjaMeQwOeapXQ3qEuuuxw3dmU0QaOVV3fnHa/xFWjDl7
         BfzYlCvjMygGFjXnI9NA6FhUbYq16Hy3/+ZUpe1eMNb24P83uy6XnjaaG0yeNyu6D51L
         2Ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760370208; x=1760975008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvE2QaubCaNe+b2bi3Ii9pwdFgyDED1xYIH2KKqTA4w=;
        b=ecbdkNknX9floWV6RmCrZ3EENxc8B8jxtGh1uxsw7CoJnD3XqItnGav0YxByFCQVUA
         hjwtqlsS96v2jZZ6GTjVl9GDft1VWm8+8qdoyrEmciy+2+ZSKkoauM6zHDV0QlCM4UWO
         hT32Bfdn0UIRFJdO5x9RVduH2w4eMoDcwNbZ3cpqiWgHNiLJ28Xyd9fPvNcHAJahK/Rn
         st6qLN75MSoClzfaUUZ0dTx7EVw8MsHVwgy60JBfU4ZvVbcVKrw8P+NERp26sK/8Mzae
         nIbfLTvDv/4ttK9E+LRr+A1Li0tN1ltHX7qCYkTmPSRqEYHrRn7kUsDAW7ZalZTB/fW4
         pvCA==
X-Forwarded-Encrypted: i=1; AJvYcCW0i8JmJlsJRwoBpxjNp2CiUePWgn/E/sbkkhbyHPlbl2+z8TFO8MnRVziFRO0jTOZLKZs9bA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyinK4WIypMpdasROpyV5uYuMl2IDr0XxscJPVjgdiXiP0GPQ6u
	/WC7rcSKpJUCcXfM7nXbu95hWFb/bl+pEvnwRbGRci7nFxkYYG3r0iP8iSUx0kBcXD5FZ21vAcR
	a1u7Y/hri0uXD4BfV2Vv31jMcuhfzWeV5DignSgNK
X-Gm-Gg: ASbGncsEkg796bWsEg/rjMoT+mFPVpElakqjbtZRkX4+AfTIi/Bw5kP1WK6mpX02myO
	5LNuXUsBlWX0Wf3yVf3enUGi4h+902A9kRAs9a//biJPoI6D1X9N02mKsuB2VechM6/+j+Euml7
	4elVZuDPnCCpsTVKuBNRi8m9AFhnlSaboudn2/RWjONvuFgSNGQW+gRisU/wp167PBaF+O7WoAC
	g+cT8AWd4+a+mmLqPcIyBWgLKX2aasocdHMr1fKMlwLvb6NtJcQ
X-Google-Smtp-Source: AGHT+IGi9WTnaWtP/uIr7PgRC+0JilLcGDbVVnkS9tGZZgbSezgQwLrXzu3IZ+mvJsC1St6EdcqZZFWTwoYrtUBb1Hk=
X-Received: by 2002:a05:622a:808d:b0:4e6:eaea:af3f with SMTP id
 d75a77b69052e-4e6eaeaaf5dmr26573411cf.3.1760370207737; Mon, 13 Oct 2025
 08:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251010011951.2136980-1-surenb@google.com> <20251010011951.2136980-2-surenb@google.com>
 <aOyf5FxH8rXmCxLX@infradead.org>
In-Reply-To: <aOyf5FxH8rXmCxLX@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 13 Oct 2025 08:43:16 -0700
X-Gm-Features: AS18NWAw--9GoJimKYZPU6XtnCpJ2t59ru9kAaQP92i8jW-vrfiHymNpWuM0LSo
Message-ID: <CAJuCfpFs5aKv8E96YC_pasNjH6=eukTuS2X8f=nBGiiuE0Nwhg@mail.gmail.com>
Subject: Re: [PATCH 1/8] mm: implement cleancache
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
	iommu@lists.linux.dev, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 11:44=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> Please don't add abstractions just because you can.  Just call directly
> into your gcma code instead of adding a costly abstraction with a single
> user.  That'll also make it much eaiser to review what GCMA actually
> does.

Are you suggesting to fold cleancache into GCMA? GCMA is the first
backend donating its memory to the cleancache but other memory
carveout owners can do that too. The next two on my list are MTE tag
storage and memory reserved by kdump.
Also note that the original GCMA proposal from 2015 [1] used both
cleancache and frontswap to donate its memory. We don't have frontswap
today, but this shows that it doesn't have to be a 1-to-1 relation
between GCMA and cleancache.
Thanks,
Suren.

[1] https://lore.kernel.org/all/1424721263-25314-4-git-send-email-sj38.park=
@gmail.com/
