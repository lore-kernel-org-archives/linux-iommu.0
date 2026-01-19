Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F416389462
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768835379; cv=pass; b=sAU291W8dzDRSpju0nYIbi5dM1R9fLUt2xBjKlYcQA9m9DJSJye40E/tNy3ivTK+CScfweA4M1tlDIPHIGwELSzQ/Sduwi2zrkDQ3eqpQECj8waBtOfeIWGh1/1fBikyTTLQjU+bm/Hx6euNL2agfqciiBF4N6HqbIRRAWUVKFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768835379; c=relaxed/simple;
	bh=9UYprNeVIjPbdEC/Vthez+8t5RhTWtuHYzI22TL9Cf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lf4sJQgK3OAmbESnFj1xKC6YvofJydbkheHZatOiqkj24rOWCCyit+H48etDq7NXAcnRJd6lkNTTUrlC65lDnoy8PTxFD9mPi5rQ0WhCUGXhuukJ6lFvJF54cYgTBPsWDj/cm/YtbHWD6oNEB7QJe/IEBltlnWLynzobxz4l7GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dq2cBMjr; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dq2cBMjr"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64baa44df99so11405a12.0
        for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 07:09:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768835377; cv=none;
        d=google.com; s=arc-20240605;
        b=HKLgME0Usu56DP/3VFyzgaq+sUjpognWUZa49VZ1Eg9myNSybOYdoviGVxya2J99kO
         B0WmACcMbsD3QqkuP4q4ffX0I7s6qRXSzGO+g2qkDkwEtfQjvx8qPCnS07HSF3k6LBEF
         O2QVary3AOaGAoEauy/IWFH1F5ivuU52PcDn9OCQzbtC1KqaIb6OoC3DKtpwsybwW9cM
         i7Na/WYz89q2Kjxcf9b35cvL9BnI3clJOUr5apo4d/jKjzBstsLdIHnvxdKcjiE1AO2L
         rn088NeY/9uybxLH3J+pnaP2//9bkksvHnmGWCucf8G3JGA099XjDzT/GTsRtJT/Gpxd
         5N6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9UYprNeVIjPbdEC/Vthez+8t5RhTWtuHYzI22TL9Cf8=;
        fh=CqtyEPGxfHN6iGtARaLcVVkiAkLZn8r+J3NXgUYMRVs=;
        b=ZLBua+EAFdF+1Yr8Cj1bBu7dtRW5SLAK67lL3emC6OqyYvko81no1BJQ42i8uKgrLH
         ZtVwskBpe85gGTDrDAzvgZPZ3HgI1/g9txoEjEi6xpQ7kxx/MrvxvDRC+yraFX8h1lom
         2Ilsj0+KVhpyWvTiG/SOSw0PlrgMWlCrU/x1QaOa9jvrQTRNLzVzEot0R17lBrUThnL3
         jMYvtXh+3OyxW9uFlb86PGKXlv3RlYubE91HN3pAysCgxoeWtSL3gXqHs30oPq+DrcZD
         dIrA6sd45X7nlZdehUrqJdblW4YjsvFCEFAFy3zzmUhN9Pif5r/AgpiiBcOYKOpPxG8Q
         AFxA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768835377; x=1769440177; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UYprNeVIjPbdEC/Vthez+8t5RhTWtuHYzI22TL9Cf8=;
        b=dq2cBMjrCr/0reZ1ZG8wvlmuNNssYtOkQq9imKEs2lpljOsBQ8TkkijstbDMrR6ll9
         5d9HW1R/g27S1L3SUX/mwcMAybbTzgsSAjAk6XLh8Co2u7vc+xV100YHQjfUyoBYq78Q
         QEFROKGRfUV0+QEbk5rRMltytc7hQnfCmMjNqWNEGXM8RLqs2g7yO6kV168mZK2r48zt
         n82qmpiWXUIOwb/mz5CVj/ykE1YmUypwiptbeqlINPdRyeQHm3nDKYoWxw2lCxPK4/kD
         UP9eqBqZPaknKu3/hEK515a1Fg/YBOjcaL64y4V4/Eeh1UHBeHcTZfBIGm6Tpn/5blib
         /kEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768835377; x=1769440177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9UYprNeVIjPbdEC/Vthez+8t5RhTWtuHYzI22TL9Cf8=;
        b=aKqlGHdEZiENhjthMkbFgE4CHS3eUvGReI3713D/dgJ3CGjhyaJkCD9QN578ezUof2
         R5AhBB+cgT1diGo7M3NJxHE94NZuFDMCKp/zpJOPz0gywHqVwSirz4XFOWbf9yFXDhkR
         3y1MVjReWJoBXW84bnGr+cCLpbIgZqC6k/YbmFjeX+BgvuYXUoTLyKsdawLcICy0Fi9r
         0fuXuF2e4JZ08VuDfxfQEuevG9h9dcd2xROFUK6rFdlK0qetZ/CC41c8s8cmDWKROOzb
         NZS2YlhCsRE3nCeUD16a649L2ZROgXmy4fy5MdrNNXtcyC2SHKMQ+AUOmlD2QUcYjr/c
         avRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWry6I9YS3zHqyFuCQw5N42lQ9yPqyMECD7ZACRqea990l7rsJnow3S8JZTzDQqmJRmnijGqQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNyLhuRJlMIXPZ68XDvbTeDR8IQK1X1Gz9ZCBNQtGg+FPlO+GA
	FJCTC6YDGxyHR3aJSTZXoSM6Or9FC/91PsVUp0N+9udKb7VSJQ9dgKP4b61jW5lGPOgdarbRrmw
	T+PP5SpaDcIwMfsz59wRx+6PGp9g62i7/fwRVOHE5
X-Gm-Gg: AZuq6aJIQrN+/Vj2XTy+KJ5DlEQ/fY3ZYZYkyjwReofk/UAmORtVqnOlqpdSNWaYWnR
	OrSdWvZbob+SJXbePG5cpTNqLTQyWbqMkyPTeT4RKxWBvyTuMDllAR199NEtqo+f8OM9LNOr6vt
	DOP4+gNRGLtoQDwEADPZ/SDJHQkNMbp2rXsHP9ZInC+2N9L0VkDlF0s69wlcPWWRy1wZXvfGmoX
	WESua5gRd8IeSF268iyuGGaashF15W4oqY7YxonyBv9Y9yxzFVhHiexlfwU4DwqwOSnWgehP21U
	FShmyw==
X-Received: by 2002:a05:6402:518e:b0:655:c10d:70c1 with SMTP id
 4fb4d7f45d1cf-6560b278fa6mr65248a12.8.1768835376417; Mon, 19 Jan 2026
 07:09:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260119142246.3821052-1-smostafa@google.com> <bca59694-6b09-4839-8577-c8ac4420eb56@kernel.org>
In-Reply-To: <bca59694-6b09-4839-8577-c8ac4420eb56@kernel.org>
From: Mostafa Saleh <smostafa@google.com>
Date: Mon, 19 Jan 2026 15:09:21 +0000
X-Gm-Features: AZwV_QjVeUiz0Q-zd8xi5T7pPmQe5X_A7eWLr5iRgluDvbc3fWR971kZpw8m3kA
Message-ID: <CAFgf54paL1O22-crK-RufOzwYBqQ-CU4BD6=h30WOOfdA2__Vg@mail.gmail.com>
Subject: Re: [PATCH 0/2] iommu: debug-pagealloc: Remove pfn_valid() usage
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz, 
	surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	rppt@kernel.org, xiaqinxin@huawei.com, baolu.lu@linux.intel.com, 
	rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 2:27=E2=80=AFPM David Hildenbrand (Red Hat)
<david@kernel.org> wrote:
>
> On 1/19/26 15:22, Mostafa Saleh wrote:
> > This is a small fix for the new config IOMMU_DEBUG_PAGEALLOC based
> > on the discussion:
> > https://lore.kernel.org/linux-iommu/CAFgf54pBAUm3ao-UJksiuGKtvv4wzRyFq_=
uKwLe0H1ettO4DLQ@mail.gmail.com/
> >
> > Where it was concluded that pfn_valid() is not enough to validate
> > physical addresses before access to page_ext.
> >
> > The first patch introduces a new function in page_ext that takes a
> > physical address as an argument, and the second patch uses it instead
> > of calling pfn_valid() and phys_to_page()
> >
> > Benchmarks with the new implementation can be found in:
> > https://lore.kernel.org/linux-iommu/20260114164322.787125-1-smostafa@go=
ogle.com/
> >
> > This series applies to iommu/core tree.
>
> This is part of v7 [1], right? Can't we just apply v7 instead or are the
> commit IDs already stable?
>

It should be stable according to Will:
https://lore.kernel.org/linux-iommu/20260114164322.787125-1-smostafa@google=
.com/T/#m59d0b455e3f2160cb6f9980a0ae65bc481c53898

Thanks,
Mostafa

> [1] https://lkml.kernel.org/r/20260114164322.787125-1-smostafa@google.com
>
> --
> Cheers
>
> David
