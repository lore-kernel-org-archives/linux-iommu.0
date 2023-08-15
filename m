Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA74F17C4
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 01:29:06 +0000 (UTC)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-349a7cb1a5cso14516815ab.0
        for <iommu@lists.linux.dev>; Mon, 14 Aug 2023 18:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1692062945; x=1692667745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7/FNZ+/kn2EN/jZotOHGG2mqO/LoJv2hq7cxgzJU0c=;
        b=lbhrr8uBFXl29L3W+33eTVbMaroAQxnceIFgwppNlBLVMefUy7eDcjWUt4KIW83CMQ
         xs0wxbuqj4QYKrrG3jEbYQxLkNBB8xhyzZJ0lKO+QmbpnDKQ9M3trfWfW5wHK5qfY/Lp
         v9FjwaPH7p249FyuVU1mP8raMsabFvcGvXifimINyHSEWHtcBS9gix8/LRVIO6ed/ekV
         fWjo4sFNJPaFLF9CPk2HCX2nWWfdLtpT4ROFxZ7Bi3nCMQzwFGIqBhkZuTutvViH5wtV
         YOq481ZyyK2m1eDDb/M1cqyOjmErgvSVcyTBfV6BW1bjkGl8smhMibEvhRXkxdRaFXXr
         rKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692062945; x=1692667745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7/FNZ+/kn2EN/jZotOHGG2mqO/LoJv2hq7cxgzJU0c=;
        b=WAEerour+yxy3+RRy+sh2qM6YHJ9z7cxOBnXrpff5CYw5vGZjUu0xauH+aenyak3As
         HCWYY68wJQCVdUYNeLVD28h0BQ/m9IZP3td0lL6mAJTVTEiMYX/GZcdBVSc2antbZtb+
         1j60mYzza/hu6TpoxvZhg/u1CqrtAxC1le20KGCAG6Ix7D8LhALj5B5tXaSQ+VYXxEQy
         Va1I1txvoYgHvVw7tCni0iSFRqmnFCShUifm2CxKVHALR+1/S7Wl5RxHw2N6kfV1pKhr
         x0+5ZZyMEGeIocsp4kbaZl/WAQr6uXqwkGGrrNTJ0PB7IQvv8njzKA9SQWU5Xyus1h4D
         QXFw==
X-Gm-Message-State: AOJu0YwOIqV6y/y9SFLtGa3JGF2ednE7gadiYlHiiCXB1fseJc9XKu5J
	263vUpXu45DsTSO3h0WWOr4b9FzQD6svJCUmnuY85g==
X-Google-Smtp-Source: AGHT+IH9fTgdlitNkb6EBHqBlRxGk0okfJiotZadNreJXeHoK0oyZVb3KFtPGjg2dfY+aKFJWqcw0nu5oBMqLfit85w=
X-Received: by 2002:a05:6e02:1d18:b0:349:862e:a862 with SMTP id
 i24-20020a056e021d1800b00349862ea862mr18151358ila.20.1692062945654; Mon, 14
 Aug 2023 18:29:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <d62ceb33620cab766d809e6bbf30eaf5b46bc955.1689792825.git.tjeznach@rivosinc.com>
 <CANXhq0r=2eqpy9wLjVt1U0J7=LpnJLcKV7N9d90jvCss=7+Fzg@mail.gmail.com>
 <CAK9=C2Vg9eR5LJPeqDDQ0pHZcrT5DOUzA8_wYEVEjfnhb6s8pw@mail.gmail.com>
 <CANXhq0oTrU_-OQroW7H+hvxcU7YROhkgdCF9g_WtPTzVFQL7gA@mail.gmail.com>
 <CAK9=C2XoQjPzZ5yB5jfTbee4-Pb8GgFAZRbfcMwMk9pyo39WxQ@mail.gmail.com>
 <CANXhq0q7R9Srx6U=fReq7LDLFgW6rMmjKH=o6MzDT5AWNRXP6w@mail.gmail.com>
 <592edb17-7fa4-3b5b-2803-e8c50c322eee@linux.intel.com> <CANXhq0pS_=YxgrxSKbdfrFdGcBduzk3LTyC4vp_hqoJTbX3e0g@mail.gmail.com>
 <ZMEO1kNGfGjN6kZM@ziepe.ca> <CANXhq0qMWS_j0n_aUO8BVFSedYCjuMM=Z_tsnK05ZhG+Ob6pqw@mail.gmail.com>
 <ZNOpbac4i5zfmHj4@ziepe.ca>
In-Reply-To: <ZNOpbac4i5zfmHj4@ziepe.ca>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 15 Aug 2023 09:28:54 +0800
Message-ID: <CANXhq0rzz1Sn8dKvNt7acvKN_g5yXFN9u6XPiRHr9ay7q2VbzA@mail.gmail.com>
Subject: Re: [PATCH 03/11] dt-bindings: Add RISC-V IOMMU bindings
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Anup Patel <apatel@ventanamicro.com>, 
	Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com, linux-kernel@vger.kernel.org, 
	Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nick Kossifidis <mick@ics.forth.gr>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 9, 2023 at 10:57=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Thu, Jul 27, 2023 at 10:42:47AM +0800, Zong Li wrote:
>
> > Perhaps this question could be related to the scenarios in which
> > devices wish to be in bypass mode when the IOMMU is in translation
> > mode, and why IOMMU defines/supports this case. Currently, I could
> > envision a scenario where a device is already connected to the IOMMU
> > in hardware, but it is not functioning correctly, or there are
> > performance impacts. If modifying the hardware is not feasible, a
> > default configuration that allows bypass mode could be provided as a
> > solution. There might be other scenarios that I might have overlooked.
> > It seems to me since IOMMU supports this configuration, it would be
> > advantageous to have an approach to achieve it, and DT might be a
> > flexible way.
>
> So far we've taken the approach that broken hardware is quirked in the
> kernel by matching OF compatible string pattners. This is HW that is
> completely broken and the IOMMU doesn't work at all for it.
>
> HW that is slow or whatever is not quirked and this is an admin policy
> choice where the system should land on the security/performance
> spectrum.
>
> So I'm not sure adding DT makes sense here.
>

Hi Jason,
Sorry for being late here, I hadn't noticed this reply earlier. The
approach seems to address the situation. Could you kindly provide
information about the location of the patches? I was wondering about
further details regarding this particular implementation. Thanks

> Jason
