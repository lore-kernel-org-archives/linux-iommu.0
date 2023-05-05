Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0119E2F33
	for <iommu@lists.linux.dev>; Fri,  5 May 2023 18:04:06 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-958bb7731a9so377627666b.0
        for <iommu@lists.linux.dev>; Fri, 05 May 2023 11:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683309845; x=1685901845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdJjs9CjNXLLFADO9bBX7juUeHygp4VbE2s0YcEvSDk=;
        b=bNqbfVfGD+0ZuohZwGAG5mSHHZ0SjE+Xt8+Weh02vLh+Nh6Mt3x6amCsWPomuFSAuI
         S/1bo9O/VZ3+TYyQY+bU+FuLpUz98R8FRtPYP6c+49j9Wemees1nklJQnvVcf17NaqdG
         x11zOICMpyqCibtnyYFZalyyJ8rtmGABKY3Ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683309845; x=1685901845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdJjs9CjNXLLFADO9bBX7juUeHygp4VbE2s0YcEvSDk=;
        b=c4U2R5nzlu1I4O3cPt2ZwrMZBPvYzGEQVmynnrL48TRh9+q0jQdzj9Dv3uJ4DjFEsw
         siQC8TVDAvyIYza0O9ZidCp+dRZkqw0tLMDaozLmOA+qmYZRCpRSfsk6A46XAx2bQXyR
         LgndxiqWz9OB7+RcyCRYv0ok6XFopqU5oqfSnPSY47cms7QsO47Aa3r9xpwvMKB/cSdL
         tEcuEida0NxSfhJGAgPFpEbjkgxmCVMp3YDN0p7Pp+h8CwcHpmzkdy/KNogMwMLxL/YL
         a9VLgf3bpQEgyHK6tvANajaK5C3U6+hLSeZ+aXlmP95BTh+JGQYKOnJ0OLnN1rYoks2X
         tpDQ==
X-Gm-Message-State: AC+VfDwj25hjqsEvPn6ZPFRSNbfOIXNRkR8a5lxCJdSTO22dmiKx8Pvt
	DNBKgPS7pPK4gdCfueTt1b20msJkpzWbTLOF9vmhsg==
X-Google-Smtp-Source: ACHHUZ7/YTOZOB34TrrfcKHEz7OYWyokSTvaJ170CIMWwZuylm71U/45wEbBpcbLAgXJfhfAIb3TRA==
X-Received: by 2002:a17:907:7e92:b0:958:5c21:3fa7 with SMTP id qb18-20020a1709077e9200b009585c213fa7mr2375652ejc.25.1683309844980;
        Fri, 05 May 2023 11:04:04 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id og6-20020a1709071dc600b00965e839f56bsm908313ejc.182.2023.05.05.11.04.03
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 11:04:04 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-965e93f915aso157454866b.2
        for <iommu@lists.linux.dev>; Fri, 05 May 2023 11:04:03 -0700 (PDT)
X-Received: by 2002:a17:907:3f9a:b0:961:be96:b093 with SMTP id
 hr26-20020a1709073f9a00b00961be96b093mr2186880ejc.36.1683309843677; Fri, 05
 May 2023 11:04:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZE5NR5Ml8I2/Ze0f@8bytes.org> <CAHk-=wiriLmq6OgLLF9seANqCJqjCrgUC384zcJUFtv3xJgVkQ@mail.gmail.com>
 <ZFUMja5MpRPWCRXw@8bytes.org>
In-Reply-To: <ZFUMja5MpRPWCRXw@8bytes.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 May 2023 11:03:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjW4CzM9YZqwB3jU9mt7FKdctLWAbOcBQAwJ0_2eRmP=g@mail.gmail.com>
Message-ID: <CAHk-=wjW4CzM9YZqwB3jU9mt7FKdctLWAbOcBQAwJ0_2eRmP=g@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v6.4
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 5, 2023 at 7:02=E2=80=AFAM Joerg Roedel <joro@8bytes.org> wrote=
:
>
> On Sun, Apr 30, 2023 at 01:07:45PM -0700, Linus Torvalds wrote:
> > Anyway, I'm not super-happy with how this all turned out. The example
> > merge seems to be wrong, and the Kconfig situation is confusing.
>
> You are right, looks like I missed some context when doing my example
> merge, sorry for that. I will take more care next time.

So I find the suggested merges useful even if they are wrong - it just
makes me look at what I did in an area that is clearly non-obvious.

And the part that made me unhappy about the merge was actually how
non-obvious it was, not so much the mis-merge itself.

That config option rename in particular I find to just be bad. We now
have some code that is *very* central, to the point where we have a
field for it in the 'struct mm_struct', and special callback for
fork() and exit(), and then the config option is called something
completely incomprehensible like 'IOMMU_SVA'?

That just smells to high heaven to me.

Now, I'm not saying that 'struct mm_struct' is some holy thing, and it
has a lot of other strange fields that get enabled by strange config
options. But I *am* saying that it's one of our most central data
structures in the kernel (just behind 'struct task_struct'), and when
it has something like this in it:

    #ifdef CONFIG_IOMMU_SVA
                u32 pasid;
    #endif

that just doesn't look right. "IOMMU_SVA" just isn't an obvious or
descriptive enough name to be involved in that data structure.

The old name ("CONFIG_IOMMU_SUPPORT") honestly made a ton more sense
in that context.

So I was a bit frustrated with the merge.  When there are merge
conflicts, the way I resolve code is to make the resolution make
sense. Most of the time that's completely trivial, then occasionally I
have to look at the code history to see what people were doing.

And in this case, I didn't feel like the end result made sense, if you
see what I mean. The resolution is _right_, but I'm not happy about
it.

                 Linus
