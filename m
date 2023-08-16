Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4F617E8
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 02:16:48 +0000 (UTC)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3491568afd4so19286895ab.0
        for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 19:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1692152207; x=1692757007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5huse4n9suq/IRdDuONMgabd7JYMxtoLtQg6/wMeyM=;
        b=IscYDGR4az4TTZH0SjNN8xrwfiOJ3+5fCWmMPGTcsGwlqldoMp99VOy7NUfjYa0b1h
         OvNhjMP8ZCxAcM2mBpcSEJKYteHvo2dwg56cp91saAzxpsxkcXnsfxTMQab/VeKkpHq4
         Sfiz3/Ufi2biWbNcH00M1BuRC7ij5pfGk64GmXXdkmqt/I6IAnv13w4Dekp9hsTVmM+W
         oW4JnVGnUBzRtk4wSTvyWWR9dkY3EZjGjq5EE1N6pASrB5WNNDQOejcUqAq8sXeO0CCF
         0doLQk/SKkZ8R50scXnMLKF9OqmfuQz4BVNF2gF47Ydx/JJdJg5/whBDeMuker/9Kzne
         ofUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692152207; x=1692757007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5huse4n9suq/IRdDuONMgabd7JYMxtoLtQg6/wMeyM=;
        b=GKFQdu35cyq86/QdeEFxqfiRUMBKT4pEH9xX9ipcJ0/fH9DwqKlfhFT5TlMNsQXKo9
         qabTL2KqStHVlVpoKUV+ZtIJoiEslGd3syd9vqT/BJQ5EbsuU+bbOcqN6auMNRo8vAPX
         XipXzfZkcXG4eTziE/mPdgP/GOexZpdviItkDEDed38HrS5DlJ7uo8xTX+wAHdMaZc2+
         TIK3IqvbgPCnPQaIJdr9BvnYU9FdHmPoZOAweFfyvQC3NxEMpy/6gwPXPTr1f31OGZ2W
         o8nWwNC7Hkjs2/d9r6NRQuaHPVJENab1I/XYY07m8AGA9gJ756VWi6Md09TmpCLpZpuF
         f1Pg==
X-Gm-Message-State: AOJu0YxGo/5rxQZD2x/MGnGD0mjCQ3msoj2nCkOl5d8Nv9gIwbpxAYj4
	TWCIoc04h9AQ0hwTFBb6M//1d6mc/YSrZlRUrpCU+Q==
X-Google-Smtp-Source: AGHT+IH431ilN76iz617qfeJ/MYCKOhQ/JnGxm4Dea7qJyl3nVI1JisTa9E0HD2OrPtsfVR4zKyTC/1t/Hb8Kb3ObSs=
X-Received: by 2002:a05:6e02:1a2b:b0:349:8811:fc51 with SMTP id
 g11-20020a056e021a2b00b003498811fc51mr904026ile.20.1692152207491; Tue, 15 Aug
 2023 19:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAK9=C2Vg9eR5LJPeqDDQ0pHZcrT5DOUzA8_wYEVEjfnhb6s8pw@mail.gmail.com>
 <CANXhq0oTrU_-OQroW7H+hvxcU7YROhkgdCF9g_WtPTzVFQL7gA@mail.gmail.com>
 <CAK9=C2XoQjPzZ5yB5jfTbee4-Pb8GgFAZRbfcMwMk9pyo39WxQ@mail.gmail.com>
 <CANXhq0q7R9Srx6U=fReq7LDLFgW6rMmjKH=o6MzDT5AWNRXP6w@mail.gmail.com>
 <592edb17-7fa4-3b5b-2803-e8c50c322eee@linux.intel.com> <CANXhq0pS_=YxgrxSKbdfrFdGcBduzk3LTyC4vp_hqoJTbX3e0g@mail.gmail.com>
 <ZMEO1kNGfGjN6kZM@ziepe.ca> <CANXhq0qMWS_j0n_aUO8BVFSedYCjuMM=Z_tsnK05ZhG+Ob6pqw@mail.gmail.com>
 <ZNOpbac4i5zfmHj4@ziepe.ca> <CANXhq0rzz1Sn8dKvNt7acvKN_g5yXFN9u6XPiRHr9ay7q2VbzA@mail.gmail.com>
 <ZNvGH91EmlOAaxBK@ziepe.ca>
In-Reply-To: <ZNvGH91EmlOAaxBK@ziepe.ca>
From: Zong Li <zong.li@sifive.com>
Date: Wed, 16 Aug 2023 10:16:36 +0800
Message-ID: <CANXhq0pQ5wisNtbVjm031btUiO=y_MmA9rfbWwnMFo_1y2d50w@mail.gmail.com>
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

On Wed, Aug 16, 2023 at 2:38=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Aug 15, 2023 at 09:28:54AM +0800, Zong Li wrote:
> > On Wed, Aug 9, 2023 at 10:57=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
> > >
> > > On Thu, Jul 27, 2023 at 10:42:47AM +0800, Zong Li wrote:
> > >
> > > > Perhaps this question could be related to the scenarios in which
> > > > devices wish to be in bypass mode when the IOMMU is in translation
> > > > mode, and why IOMMU defines/supports this case. Currently, I could
> > > > envision a scenario where a device is already connected to the IOMM=
U
> > > > in hardware, but it is not functioning correctly, or there are
> > > > performance impacts. If modifying the hardware is not feasible, a
> > > > default configuration that allows bypass mode could be provided as =
a
> > > > solution. There might be other scenarios that I might have overlook=
ed.
> > > > It seems to me since IOMMU supports this configuration, it would be
> > > > advantageous to have an approach to achieve it, and DT might be a
> > > > flexible way.
> > >
> > > So far we've taken the approach that broken hardware is quirked in th=
e
> > > kernel by matching OF compatible string pattners. This is HW that is
> > > completely broken and the IOMMU doesn't work at all for it.
> > >
> > > HW that is slow or whatever is not quirked and this is an admin polic=
y
> > > choice where the system should land on the security/performance
> > > spectrum.
> > >
> > > So I'm not sure adding DT makes sense here.
> > >
> >
> > Hi Jason,
> > Sorry for being late here, I hadn't noticed this reply earlier. The
> > approach seems to address the situation. Could you kindly provide
> > information about the location of the patches? I was wondering about
> > further details regarding this particular implementation. Thanks
>
> There are a couple versions, eg
>  arm_smmu_def_domain_type()
>  qcom_smmu_def_domain_type()
>

I thought what you mentioned earlier is that there is a new approach
being considered for this. I think what you point out is the same as
Anup mentioned. However, as I mentioned earlier, I am exploring a more
flexible approach to achieve this objective. This way, we can avoid
hard coding anything (i.e.list compatible string) in the driver or
requiring a kernel rebuild every time we need to change the mode for
specific devices. For example, the driver could parse the device node
to determine and record if a device will be set to bypass, and then
the .def_domain_type could be used to set to IOMMU_DOMAIN_IDENTITY by
the record. I'm not sure if it makes sense for everyone, it seems to
me that it would be great if there is a way to do this. :)

> Jason
