Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18023C10
	for <iommu@lists.linux.dev>; Sun, 30 Apr 2023 20:08:05 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-50bc040c7b8so1557759a12.2
        for <iommu@lists.linux.dev>; Sun, 30 Apr 2023 13:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682885283; x=1685477283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAT/2iwDABQLtvre5aF/VZoih+/bS832V3Wecs87BJg=;
        b=L5mpwGfOFJz6YY/vGsnF4UITWfh+2BWeOEBTOsyKP2AIAruKAzlw0xc7u6MT1ayRpU
         4vcYy6VXBmOLkohuxRI6N1zNfDGUJbE5n6LjPOsn0zoovS5fAiSjBGSFaJ7I/lZJ1f74
         7hiAtZjnfDUhgj7XZj4tr6doEiZBnwV5lKeac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682885283; x=1685477283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAT/2iwDABQLtvre5aF/VZoih+/bS832V3Wecs87BJg=;
        b=Y96LQoJKkpsbaZcpyM/WqCeyAcA30Oy/+r3wC7PcfoKx8bKBfaNInQNdCCXeVsVtnP
         lkYctAJ9Bg4gWOtwGB2p+7/I0uYNTPf6k0C2Vymw8WLM7e7VoAJx9ILSVZl33vu1BwjW
         JRsfH9RUCTr33F2LNA8hjbyBfy84wfRmPAShS8Ek5GkLiXUfHWooGWRVzYUqbYsPNtE1
         IJp/X3mw/nP4RI9VBp58ezN6UO8EJO6OmiZiv/U6nRfEFp4iaDd4GMI91wsLn8TPdhKe
         rmP1G2mniRXvsTnTz9T9FlkCVsXwE0GRQioQ9Skq4hzQTnmF90KObT1JU+bfeSiJ2m5T
         /2+Q==
X-Gm-Message-State: AC+VfDzeMMk04wiHqyaQ9uXwBfFf47tV33mGeprk6TwVx/ES8QKJ5/BK
	RVStVKpF8FyGmLEYpMOiPSbVNl39zeLw3ldXZ7TBPg==
X-Google-Smtp-Source: ACHHUZ4UEYQoZC+NVfvd/Ne1rd38Oqiyk3ct2qj1aT6KTR+xUSP5YCBNOtoOKLCzRyJAWtUHQkCEyw==
X-Received: by 2002:aa7:cc88:0:b0:508:3f08:ea0f with SMTP id p8-20020aa7cc88000000b005083f08ea0fmr4750379edt.28.1682885283564;
        Sun, 30 Apr 2023 13:08:03 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id og36-20020a1709071de400b009600ce4fb53sm5144705ejc.37.2023.04.30.13.08.02
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Apr 2023 13:08:02 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-94ef8b88a5bso272803366b.2
        for <iommu@lists.linux.dev>; Sun, 30 Apr 2023 13:08:02 -0700 (PDT)
X-Received: by 2002:a17:906:9c82:b0:957:862a:9e6e with SMTP id
 fj2-20020a1709069c8200b00957862a9e6emr13699469ejc.73.1682885282026; Sun, 30
 Apr 2023 13:08:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZE5NR5Ml8I2/Ze0f@8bytes.org>
In-Reply-To: <ZE5NR5Ml8I2/Ze0f@8bytes.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 30 Apr 2023 13:07:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiriLmq6OgLLF9seANqCJqjCrgUC384zcJUFtv3xJgVkQ@mail.gmail.com>
Message-ID: <CAHk-=wiriLmq6OgLLF9seANqCJqjCrgUC384zcJUFtv3xJgVkQ@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v6.4
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 30, 2023 at 4:13=E2=80=AFAM Joerg Roedel <joro@8bytes.org> wrot=
e:
>
> this pull-request is somewhat messier than usual because it has a lot of
> conflicts with your tree. I resolved them in a test-merge and sorted it o=
ut
> for you to compare your solution to mine (mine is also mostly similar to
> the one in linux-next).

Your resolution is different from mine.

Some of it is just white-space differences etc, but some of it is meaningfu=
l.

For example, you have

                if (mm->pasid < min || mm->pasid >=3D max)

in your iommu_sva_alloc_pasid(), which seems to have undone the change
in commit 4e14176ab13f ("iommu/sva: Stop using ioasid_set for SVA"),
which changed it to check for

           .. mm->pasid > max)

instead (which seems also consistent with what ida_alloc_range() does:
'max' is inclusive).

You also seem to have kept the deleted <linux/ioasid.h> header file.

I'm also a bit unsure about what the intent with mm_valid_pasid() is.
In commit cd3891158a77 ("iommu/sva: Move PASID helpers to sva code")
that helper (under the previous name) got moved to a different header
file, but in the process it also got done unconditionally as

  static inline bool pasid_valid(ioasid_t ioasid)
  {
         return ioasid !=3D INVALID_IOASID;
  }

and didn't have a "ioasid is disabled in the config, so have an
alternate helper that always returns false".

But in your merge, you ended up splitting it into two versions again.

I don't think that's technically the "right" merge (it basically
changes things wrt the two branches), but I do think it's nicer.

So I edited my merge to follow that lead.

Finally, I'm not happy with the Kconfig situation here. Commit
99b5726b4423 ("iommu: Remove ioasid infrastructure") removed
CONFIG_IOASID, but left the

        select IOASID

in the 'config INTEL_IOMMU' Kconfig case. I removed that as dead, but
now we have that

        select IOMMU_SVA

in the 'config INTEL_IOMMU_SVM' case instead. So it's a very different
Kconfig setup.

Anyway, I'm not super-happy with how this all turned out. The example
merge seems to be wrong, and the Kconfig situation is confusing.

Somebody should double-check my result, in other words.

                Linus
