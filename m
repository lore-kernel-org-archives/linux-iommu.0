Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAF15398
	for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 15:17:06 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4fe15bfb1adso8935933e87.0
        for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 08:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693408624; x=1694013424; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y2Lq1UEtVYfmaVSMBjGqn/DzODksXNcJpAcn5BFpVcs=;
        b=AGnXU8qN04tsBTFB6+FbmskwPm8+A9azOwKsYHeA7SjYqtZYDi+v0Vgy9maUfAG1a3
         HMQMM6uaZuJJ14YOSSb3Eb9AH91p7E9bK/5iadrwfG+CZpsteKwsWj4jYNonWlJyX2gS
         goKt8D2sz7hqH/Cm+Ee3PRFcnaiUuRKDc9GR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693408624; x=1694013424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2Lq1UEtVYfmaVSMBjGqn/DzODksXNcJpAcn5BFpVcs=;
        b=NXdUyCWSIrji2VNrZJk6EtQb2xdNW0TV9fHJtnG279tGCDz3pWjsYh2XB4gVtupIkE
         /wLMfCIKG/jf6T0eifov9y/HSlwFdVqn/M1NCAfbwvqoZVAfkY1UHeFt+3DRlHJrDRC3
         We2b0Sy3W+U4Plum3aO4hoO5yh8ESypCEKgDKLuCFRs37HHBy5iXgWHOuEYJ6ybSn7iY
         tXenmyHNB8FOtrWp7ZuMsFJR7aVsn72K0MfPw1zYESpIUMmVgDdUcxmZOikSdOIroJor
         kwk+JVQZs/8cg/K9M65KG2pTfGCwlGjk06g+LOpzPrQjD26bnSsP1cTbkhHtkvvMOZDp
         6k7w==
X-Gm-Message-State: AOJu0YygZh7osbKgifZjhUlh/ksob70bvQ3Zhv5LnZAD0JbZpU1+3Arq
	i8NTjVpvXFv73YybMX6JLUuFhTbshw5NiuFEA7dotKHC
X-Google-Smtp-Source: AGHT+IGbC6wDGV6aLS4vsBcxY1Z3txpejMfu0y+r/NqZ5UQQeSSsBKqIP3/xaCeRMBlhl30iX2Icww==
X-Received: by 2002:a19:9106:0:b0:500:79a6:38d4 with SMTP id t6-20020a199106000000b0050079a638d4mr1655901lfd.40.1693408624573;
        Wed, 30 Aug 2023 08:17:04 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id u1-20020ac24c21000000b004fe4ba4cdc3sm2433217lfq.89.2023.08.30.08.17.03
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 08:17:04 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so87752741fa.2
        for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 08:17:03 -0700 (PDT)
X-Received: by 2002:a2e:7e09:0:b0:2b6:cdfb:d06a with SMTP id
 z9-20020a2e7e09000000b002b6cdfbd06amr2210430ljc.22.1693408623545; Wed, 30 Aug
 2023 08:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZO4NUZ+k4Q4zPu6X@infradead.org> <CAHk-=wik9Df4Si7aYOqgyhf=io2OaP=7Yur-xpbNe6oHuxSFAg@mail.gmail.com>
 <ZO7iy/Ei+wZK0I/d@infradead.org>
In-Reply-To: <ZO7iy/Ei+wZK0I/d@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Aug 2023 08:16:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwuJckhd76veFTJeDefktAdbpWrZh-U+AGb+NN3B_XLg@mail.gmail.com>
Message-ID: <CAHk-=wiwuJckhd76veFTJeDefktAdbpWrZh-U+AGb+NN3B_XLg@mail.gmail.com>
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.6
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Petr Tesarik <petr.tesarik.ext@huawei.com>, Yajun Deng <yajun.deng@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Aug 2023 at 23:33, Christoph Hellwig <hch@infradead.org> wrote:
>
> It actually does..

Ahh, bah, mea culpa. That's what I get for having mindlessly looked at
the config part (which was, in my defense, about 90% of it), and
missed the one-liner that actually moved the call from the arm64 init
to the dma init.

But yes, please do look out for making things 'default y' - even if
that 'y' is then a bit indirect.

          Linus
