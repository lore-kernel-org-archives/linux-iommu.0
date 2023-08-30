Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF9C1374
	for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 03:55:03 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50098cc8967so8017714e87.1
        for <iommu@lists.linux.dev>; Tue, 29 Aug 2023 20:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693367702; x=1693972502; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yBqktMQetI5IOCQP5dlOQl/11nqAkCQ7kAENt/e88W0=;
        b=Loe9p/MATQEHONkorEFNg6aMQBms47bnOpZylXN+MIUST+Lpk+oVLeKAbwy4MY1Snf
         Hgxe5ATg28w521mgTEIdAMIdCr5M7HPIHrwSYSGDzZk6NVQ+TpdkhmGyEzJjZXrmouEy
         3tvxjJNAjlEa18yGuhOEFrgOmCqBGqa1vVFRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693367702; x=1693972502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBqktMQetI5IOCQP5dlOQl/11nqAkCQ7kAENt/e88W0=;
        b=QqwPRguZYpP8VvTEBClgTh99pqjTfLqSy675+FWdFHZ0D/aYIIaqnWgEbArsPJebKM
         /SYrinwNqUW5+S5c/zmikB9MhcA/ZKDHDCxtOG3QKxTwYDkRwKIvLavom0UwjUYxy48b
         28kSA0wsWCHw14H/zmABNoSZZVkD7MlMThmGQTXsiyJA7sijgYSFNMcyS3sjqxOb0ZNF
         jAtjfZvQP6bFDeShFcGZTCPcqWy9jMJ9zAXql1PhjPOIcaCKVTSYQQDRGDw9w1F83uDf
         SqFMsZJI+JKphRtIHD5Sv2Zdu2G277fV9AONGZX3GLeCNY2OWTCZSkmtpszqzUnH3rJv
         szAw==
X-Gm-Message-State: AOJu0YxQYZAAXWs69l6Q3VSW7UcJffTlRWfaTrIDEXq0nd28mr9QcFim
	xTdJvZZVVCqwtRviOIbyhiDpUD9rVec9mtIy1cWyCcMV
X-Google-Smtp-Source: AGHT+IE4tm1qx8e+7I0V0eA5mqSqLoVODoRK5RYzFw1xRFO213eDe1j0rnKcPMi1U5An67dagEz+FQ==
X-Received: by 2002:a05:6512:118e:b0:4fd:d64f:c0a6 with SMTP id g14-20020a056512118e00b004fdd64fc0a6mr653574lfr.48.1693367701753;
        Tue, 29 Aug 2023 20:55:01 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id a3-20020ac25203000000b004ff969ab934sm2191347lfl.177.2023.08.29.20.55.00
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 20:55:00 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2bd0bc8b429so48002221fa.2
        for <iommu@lists.linux.dev>; Tue, 29 Aug 2023 20:55:00 -0700 (PDT)
X-Received: by 2002:a2e:9397:0:b0:2bc:e1a3:fbaa with SMTP id
 g23-20020a2e9397000000b002bce1a3fbaamr845437ljh.22.1693367700488; Tue, 29 Aug
 2023 20:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZO4NUZ+k4Q4zPu6X@infradead.org>
In-Reply-To: <ZO4NUZ+k4Q4zPu6X@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 29 Aug 2023 20:54:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wik9Df4Si7aYOqgyhf=io2OaP=7Yur-xpbNe6oHuxSFAg@mail.gmail.com>
Message-ID: <CAHk-=wik9Df4Si7aYOqgyhf=io2OaP=7Yur-xpbNe6oHuxSFAg@mail.gmail.com>
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.6
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Petr Tesarik <petr.tesarik.ext@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Aug 2023 at 08:23, Christoph Hellwig <hch@infradead.org> wrote:=
>
> Yajun Deng (2):
>       dma-contiguous: support per-numa CMA for all architectures

What?

This commit seems entirely bogus and is actively misleading.

It claims to enable support for per-numa CMA for all architectures.

It does no such thing.

All it does is to change the default value for a config option. It was
perfectly available before, now it is - incorrectly - made 'default y'
in case the config supports NUME at all.

There seems to be no real reason to change the default value of this
config option. The commit message most definitely doesn't argue for
it, since it talks about something entirely different than what the
code changes does.

I have taken this, but I protest these kinds of nonsensical changes.
That commit is actively misleading and confused, and I think the
default value for that config option should just be 'n' on all
architectures.

Why is this option so important that it should be enabled just because
some minimal NUMA support might be enabled?

Please don't add these kinds of hidden "default y" by making them
default on some much more common option instead.

                Linus
