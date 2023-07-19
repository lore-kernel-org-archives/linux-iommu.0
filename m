Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5401BB23
	for <iommu@lists.linux.dev>; Wed, 19 Jul 2023 21:44:02 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-66f3fc56ef4so904340b3a.0
        for <iommu@lists.linux.dev>; Wed, 19 Jul 2023 14:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689803042; x=1690407842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLihZVHK3CHWRwQZuJeTGZhqi1m+X+Vl21f6YoEXJhU=;
        b=G+UVUHjmkfa1/Iq+zmyB9mjg/dn+9znCrn3YV7v6AEvEH+6Isw/fYyMRfwBN4MUI9Q
         DMCmhTAWA/tndSpWKNBcbeZMoBrNHbq6I3Y3SFxZ9TYnR/cTXsJarADgWG0v7CRKS7MT
         86Aa+F3bx7QHwdi8/mOfbWJ8clXA/zEh7PS70c2+vslzfCv4seQtPy2JfNUKwX/NLT4H
         jVohrDUeK3eAUzHcA9lJF9MxyrR7fTQ3gwziLV7TVEKi/1JmTNU382je2ILO8L5Q7bSN
         lL+vgfvPWDhd3TzvnIyZ4op+0rhSr8CvxX5PlJ+lv5r7Zob2M3hINsgcszb97jAz+39Z
         gVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689803042; x=1690407842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLihZVHK3CHWRwQZuJeTGZhqi1m+X+Vl21f6YoEXJhU=;
        b=SRJBKd3BOGyYsXOytXpuGyaEB07zqCDwWwSdgd39iPhtflb+mwyNuDGp5OAza+HHjU
         f+sxmUSlYC+Ro78uhu2w2CT0+slBjvjmOKYGjJEAWnnXYf0ydSq5LGsRggEndjoN3Jr5
         nGkPqjQ50oaJw0yjp5kaTArd01r+i3g23AXADIsKg7gRWji+t6VQv2aQgB1l1e+bnPeT
         aLIThDirjv1l+DdPE3eNwCptLPKpRc3RyCTjn+2xcU1bo98aau1vTTYMv/3jVa1GH3ub
         LmbK52c3VnLsWcI0O3uWyZ2mnlYv1M9wg1gO5WEtfDq28OOCcCTOC+UAgO0awHVOa+Tb
         rIWA==
X-Gm-Message-State: ABy/qLaW0SqL7ksPF46PooqWvV659q8ejnF8G7uS+UvabAbTRiwLxhaT
	tbyGITzsWOpUqBkgHoo5XSS6tDaGB4Bp/EMzf5/aXMHQ6oLAH4i3VHSW3A==
X-Google-Smtp-Source: APBJJlGLY/JCFHLpqHxC1oKpUPyJvF7kYQiXWEFjX323i/90V6LtxLIpabl9qDoFSu4vgV6EadlDAQCk73/N3FIeTak=
X-Received: by 2002:a17:90a:8c4:b0:263:f521:da3e with SMTP id
 4-20020a17090a08c400b00263f521da3emr4431779pjn.2.1689803042099; Wed, 19 Jul
 2023 14:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
 <20230719-confront-grass-6d0eb304b94f@spud>
In-Reply-To: <20230719-confront-grass-6d0eb304b94f@spud>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Wed, 19 Jul 2023 14:43:51 -0700
Message-ID: <CAH2o1u5pZQ6iKThFLgnn+_BBZ=j8fu91URYYxwWbfVt3OyerAA@mail.gmail.com>
Subject: Re: [PATCH 01/11] RISC-V: drivers/iommu: Add RISC-V IOMMU - Ziommu support.
To: Conor Dooley <conor@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Anup Patel <apatel@ventanamicro.com>, Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com, 
	linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nick Kossifidis <mick@ics.forth.gr>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 1:50=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> Hey Tomasz,
>
> On Wed, Jul 19, 2023 at 12:33:45PM -0700, Tomasz Jeznach wrote:
> > The patch introduces skeleton IOMMU device driver implementation as def=
ined
>
> This commit message reads like a cover letter IMO. At whatever point
> you send a v2, could you re-write this focusing on what is done in the
> patch itself?
>

ack. will amend the commit message.


> Also, since I am not going to reply to any of these iommu driver patches
> in a meaningful capacity, please run checkpatch.pl on your work. There
> are well over 100 style etc complaints that it has highlighted. Sparse
> has also gone a bit nuts, with many warnings along the lines of:
> drivers/iommu/riscv/iommu.c:1568:29: warning: incorrect type in assignmen=
t (different base types)
> drivers/iommu/riscv/iommu.c:1568:29:    expected unsigned long long [user=
type] iohgatp
> drivers/iommu/riscv/iommu.c:1568:29:    got restricted __le64 [usertype]
>
> I can provide you the full list when the patchwork automation has run
> through the series.
>

Thank you, a list of used lint checkers definitely would help.


> Anyway, what I wanted to ask was whether it was valid to use the IOMMU
> in a system if Ziommu is not present in whatever the ISA extension
> communication mechanism is? Eg, riscv,isa or the ISA string property in
> the ACPI tables.
>

Yes, this has been pointed out to me already. As far as I can recall,
there was a discussion
at some point to introduce those as Ziommu extensions, later agreeing
not to call IOMMU
using ISA string conventions.  Will remove remaining occurrences of
Ziommu from the series.


> Thanks,
> Conor.
>
> > References:
> >  - [1] https://github.com/riscv-non-isa/riscv-iommu
> >  - [2] https://github.com/tjeznach/linux/tree/tjeznach/riscv-iommu
> >  - [3] https://github.com/tjeznach/qemu/tree/tjeznach/riscv-iommu
>
> FYI, we have the Link: tag/trailer for this.
>


Thanks,
- Tomasz
