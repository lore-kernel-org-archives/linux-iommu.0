Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4843D15A0
	for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 03:59:36 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso34392766b.2
        for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 20:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693454374; x=1694059174; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=32Wr8NYu6HSmc0mkG+FLn0sx5HN2+FhcGiqyKWtv7y8=;
        b=c/QP3YhRgxe8ubgJHmCULLb2MD8Yi1Arjfb2iX1cSfA2oEzXGnhhhM/gXOhFlxbhwj
         rLBBeOeMnqIXn9XmruGIB7GKu9g+9YBlsu79B9d08Ch+OhD9eQlQzDfPO18FaJqvIO51
         ZyTfYNuJrCI49vveh6z632OL16LdH0JsoOLsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693454374; x=1694059174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32Wr8NYu6HSmc0mkG+FLn0sx5HN2+FhcGiqyKWtv7y8=;
        b=isGN/GDSUwBOuxcrzE+WRDMOTZyYbYY210eKcoxVRsuUpJ1kcB4PRy4ZISnyBOg5Kx
         hs85XO0aC8gJBVwVT9YH3bKgoKLeBa/vhpdyShEi6qDRMcu3aGFb9o+f1XF4q9Vp0M6w
         4jgJvyHqJH/055JfsEsUaE1YgcSi6FrAxj9whnhzhmcJ7eLyuf25zOSbvqw7Zec/g4Xx
         HgMRUF9mbmk2YlzhytPNyU/pKcqZ7hUE9EtxmiRAlGKMrAYlpNj+GZzkHg9O555gMmxZ
         TOY+VZ5Cv596ZXo7VLp7p/WFxwoFYWYE+rqOy+DCi5cXmYvG4g7IXutU7+J6fxUxr5E+
         OlfQ==
X-Gm-Message-State: AOJu0YxZcf/63VCblKQVzn3UadOWIdI5P79t+t/tvi7qjCxewXaPhAV4
	Eq3rGBr0NLQ/0w6C8RxH6XucrvD8VIk8iFNB1wgWhQ==
X-Google-Smtp-Source: AGHT+IEaVvRtIW3I04c9Ta0Vya0rxLF/7PDChpZ+0Mwa5ASFxgjwPSYEKqe+k3WsQArKenro8JNH/Q==
X-Received: by 2002:a17:906:8441:b0:9a2:292d:ea63 with SMTP id e1-20020a170906844100b009a2292dea63mr2868438ejy.37.1693454374302;
        Wed, 30 Aug 2023 20:59:34 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id ox29-20020a170907101d00b00992ea405a79sm268415ejb.166.2023.08.30.20.59.33
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 20:59:33 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-99bf1f632b8so35450966b.1
        for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 20:59:33 -0700 (PDT)
X-Received: by 2002:a17:907:7844:b0:9a5:c4ae:9fec with SMTP id
 lb4-20020a170907784400b009a5c4ae9fecmr3151324ejc.52.1693454372889; Wed, 30
 Aug 2023 20:59:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZO/Te6LU1ENf58ZW@nvidia.com>
In-Reply-To: <ZO/Te6LU1ENf58ZW@nvidia.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Aug 2023 20:59:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_L-97_06_ruO7xL7vxX4QpaqGQKw-6LtKAR_CB1cyYw@mail.gmail.com>
Message-ID: <CAHk-=wg_L-97_06_ruO7xL7vxX4QpaqGQKw-6LtKAR_CB1cyYw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull IOMMUFD subsystem changes
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Tian <kevin.tian@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Aug 2023 at 16:40, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> This includes a shared branch with VFIO:
>
>  - Enhance VFIO_DEVICE_GET_PCI_HOT_RESET_INFO so it can work with iommufd
>    FDs, not just group FDs. [...]

So because I had pulled the vfio changes independently with their own
merge message, I ended up editing out all the commentary you had about
the vfio side of the changes.

Which is kind of sad, since you arguably put some more information and
effort into it than Alex had done in his vfio pull request. But the
vfio parts just weren't part of the merge any more.

I did put a link to your pull request in the commit, so people can
find this info, but I thought I'd mention how I ruthlessly edited down
the merge commit message to just the parts that were new to the merge.

I appreciate the extra background, even if I then decided that by the
time I merged your part, some of it was "old news" and not actually
about what I merged when I pulled your branch.

.. and if I had realized when I merged the vfio parts, I probably
could have added your commentary to that merge. Oh well.

                  Linus
