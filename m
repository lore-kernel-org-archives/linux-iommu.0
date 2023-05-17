Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896425255
	for <iommu@lists.linux.dev>; Wed, 17 May 2023 05:49:25 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso285355a12.1
        for <iommu@lists.linux.dev>; Tue, 16 May 2023 22:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684302565; x=1686894565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCbjMLR0MZgcNfob+sgwKSmJL6K6D2r7QJTL+XYxuoY=;
        b=neCmu+kmQQCi6kMbUvpKbB3crrQIIlJOMJaAX5+04o65SAm/rJJCULnMqUZtV9DUZj
         TS3Bj10pryxxtgQi2zKgGImlwFJ8h9KjXeJkwzavmE09947Ia3Dw8/z59I7LL+Bv8+Ge
         NJv56L2xKXKFgtXxkFFv5dW3hkStv92iKK7l+4Xv0jUMatFTRZGKOANQo/wh6n+C6YJj
         ftCW9eI1zRxJ2qpKs2jECnogoiP/FV0KTa9tl/cYElWMQfYvpCrp6XwHack8ieAWRRMl
         SrsbyOrN0dLztIsY+mGw04SwsdzDz9xD8Kr1Wv5w8dfa6iMZaWd7ceOBRA4iveWzeHSB
         qAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684302565; x=1686894565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCbjMLR0MZgcNfob+sgwKSmJL6K6D2r7QJTL+XYxuoY=;
        b=UvGnNTt1NHkzj+udTVGAsL/uOS5l+Bb9ydjLMuEvxRjj2fZ4yFakjdjvyzn2S4W2TG
         CbQhqbSC2kKWFnNIOX76DduUrUqEeU/iFyDBsmPgOamGbUpwFl8SodQP5Gxic9nFAaSg
         dgV1AGn93Z0ac2hYP8YtGZXVL3pBl0Zjl3rw4fS7bYaWUbFd5q0eJ9XJcB9+iAajyHr1
         DFYS7+EyGo/1g3BYBSv526BusA0jgJT9o5nWcWPDYNkWPD6fV8TQJ4A28i+gu7Rs8xZw
         62figq6ndabUGwxLZQ/Wl+UfBcCj0cJeRPKC/I7ScdM7WkCd29Niref7gD1kqXiZ1N3g
         KISA==
X-Gm-Message-State: AC+VfDyuTWRI12YvepcxCw/WrefJ8R9sI4uq/pNUk+Z/n+7GgXXPT7JK
	N550UElFxTcMDPJdPPjcgPldt0+De3mPzAuX6vcbOA==
X-Google-Smtp-Source: ACHHUZ5fIT8xDntcFkwurCfHm8u1oNZsfnad+A4aQBt5Vv8q8opPNnB5kZgQuSA6fqq3MUIaDWfXwkaqeTY2nOTeU4g=
X-Received: by 2002:a05:6a20:3d09:b0:100:5f62:be76 with SMTP id
 y9-20020a056a203d0900b001005f62be76mr43582822pzi.54.1684302564708; Tue, 16
 May 2023 22:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230426203256.237116-1-pandoh@google.com>
In-Reply-To: <20230426203256.237116-1-pandoh@google.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Tue, 16 May 2023 22:49:13 -0700
Message-ID: <CAMC_AXUkiHvBaWQm8fnAbgbxe59iF9UM59=yBoa3LcuLGQ=E3A@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: Fix domain flush size when syncing iotlb
To: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Nadav Amit <namit@vmware.com>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sudheer Dantuluri <dantuluris@google.com>, Gary Zibrat <gzibrat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26, 2023 at 1:32=E2=80=AFPM Jon Pan-Doh <pandoh@google.com> wro=
te:
>
> When running on an AMD vIOMMU, we observed multiple invalidations (of
> decreasing power of 2 aligned sizes) when unmapping a single page.
>
> Domain flush takes gather bounds (end-start) as size param. However,
> gather->end is defined as the last inclusive address (start + size - 1).
> This leads to an off by 1 error.
>
> With this patch, verified that 1 invalidation occurs when unmapping a
> single page.
>
> Fixes: a270be1b3fdf ("iommu/amd: Use only natural aligned flushes in a VM=
")
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> Tested-by: Sudheer Dantuluri <dantuluris@google.com>
> Suggested-by: Gary Zibrat <gzibrat@google.com>

Cc: stable@vger.kernel.org
