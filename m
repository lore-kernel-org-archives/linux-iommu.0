Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12F463CD
	for <iommu@lists.linux.dev>; Thu, 28 Dec 2023 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPk+Kjb/"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-427b1bf1896so41164791cf.3
        for <iommu@lists.linux.dev>; Thu, 28 Dec 2023 02:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703758736; x=1704363536; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76rIf+guTp5lw4RDD2pSw8InhFr5B3jeNbOCct2FRek=;
        b=EPk+Kjb/jT4XRNvAUKdTCjP7J5RuQx3EDDKmh36uCNoAYVYoBiZASt8WWCbEO8ldoj
         C2donlq1IHcIrm0wd4pYcBCbvF62fmj0eJ9gFTg2EeygbXSIU34OsRv3T0rYkE4ys13B
         /m4DsZPpowaq9T+0S8YNSwKpOv2/svLVlv17fxLh/XeqVrXMVOUbqnHcZ6QwOFD2TgPp
         gvg0Ol+n/Q0YU8h7blSdfM4V7aqHHXtShCdNeWMIonjhjhifmMtbBjnGCXQv2atnWFy5
         WjErogQLyJJYxN+NAQi9Jh2U/1kyO8X2t+hkK26TXVCq0FWrxcuPb7FXQsJ7w3OV7jhW
         KNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703758736; x=1704363536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76rIf+guTp5lw4RDD2pSw8InhFr5B3jeNbOCct2FRek=;
        b=jN/6+I5Sot1ZF6JreSLMZSeNaNLTPbm3RGQY5MGOuDnE9phSPrAXrS9Rm2mqmyx/l5
         bSHCF2giO2d5mSTx9SfVAmhMqY0ddp6kHsvgO6QW1+eS8/KN68S+RpgBSqstabUYqvM5
         sqDu84a7vHxOJn3PrAS40+xrZ6zZXqKHP0Ao1bsSy8mERjrB5BZIdtE/Mynjrm7ZqVJv
         QvGLreEk3Xsm0vQlR8Gn2jDnhpwwdYW342DuaGTTGx0ZwfgXuUTTsRqddUl3T6VWnACo
         1x/paVBpiMu/Rx+nBymCZduMxqoRMiOfabfbcWzQrUd39TI/STFHpZ3uTyRtu0r8rdgA
         qJTA==
X-Gm-Message-State: AOJu0YwXzRmEZQT/dFnnfGZ+bauwgrf4YZAHFAL15cpK6izki1wDwaof
	hn7O9VbwBqysxNtUCn8AhYGu3XDUx6s31TrInuU=
X-Google-Smtp-Source: AGHT+IGc5juyCyPvlpop20qPG41SPtHggp6E0LAvoyXGl9OdrSTesJK6ueLr8UHDG8CIjesk6/YLo24CrzHUZboLkkg=
X-Received: by 2002:a05:622a:1813:b0:427:f931:bdbc with SMTP id
 t19-20020a05622a181300b00427f931bdbcmr860721qtc.111.1703758735612; Thu, 28
 Dec 2023 02:18:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CALf2hKsJjDY3OhtMCxhHh7rS=2S4Oq9Ns=t-NFq1MPD=f0K02Q@mail.gmail.com>
 <BN9PR11MB52761AA391479A55533BFE718C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB52761AA391479A55533BFE718C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Zhang Zhiyu <zhiyuzhang999@gmail.com>
Date: Thu, 28 Dec 2023 18:18:44 +0800
Message-ID: <CALf2hKvjrUFDqPnZxv9RVZ=cxgUUwUBoMv2TVTcZHuMmca+MPQ@mail.gmail.com>
Subject: Re: A bug was found in Linux Kernel 6.6+: KASAN: slab-use-after-free
 in iommufd_test (with POC)
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, 
	"robin.murphy@arm.com" <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

Thanks for your advice.

I check the patch which has been applied in Linux-6.7-rc5+, while not
in the latest stable Linux-6.6.8. As a result, my poc is still
reproducible on 6.6.8, but not on 6.7-rc5+. Maybe the stable line of
Linux kernel should apply the patch asap.

Seems that I am late to this bug. Although the call trace of my poc is
slightly different from the disclosed "KASAN: slab-use-after-free Read
in iommufd_vfio_ioas"
(https://syzkaller.appspot.com/bug?extid=3Dd31adfb277377ef8fcba), they
share the same root cause.

Best,
Zhiyu

Tian, Kevin <kevin.tian@intel.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8828=E6=
=97=A5=E5=91=A8=E5=9B=9B 15:28=E5=86=99=E9=81=93=EF=BC=9A
>
> > From: Zhang Zhiyu <zhiyuzhang999@gmail.com>
> > Sent: Wednesday, December 27, 2023 5:03 PM
> >
> > Hi upstream community,
> >
> > I am fuzzing a LTS version of Linux kernel 6.6 with my modified
> > syzkaller and I find a bug named "KASAN: slab-use-after-free in
> > iommufd_test". By analyzing the call trace in bug report, I address
> > the root cause of this bug at drivers/iommu/iommufd. An iommufd_object
> > is allocated in one task through
> > iommufd_fops_ioctl->iommufd_ioas_alloc_ioctl->iommufd_ioas_alloc and
> > freed in another task through iommufd_fops_ioctl->iommufd_destroy.
> > Then when the kernel invokes the calls
> > iommufd_fops_ioctl->iommufd_test->iommufd_test_add_reserved-
> > >iommufd_put_object,
> > an use-after-free read will occur. Detailed report, log, repro, config
> > can be found in this google drive link:
> > https://drive.usercontent.google.com/download?id=3D1nDJWUstYJNcC1zJ6q1r
> > hB5zB0uV2yGvg&export=3Ddownload&authuser=3D0&confirm=3Dt
> >
> > The steps to reproduce the bug:
> > 1. compile the kernel 6.6 with provided Linux-6.6.config
> > 2. boot a qemu vm that runs the compiled kernel
> > 3. scp the repro.c (repro.prog is not recommended) to the vm and
> > compile it with gcc -pthread repro.c -o repro
> > 4. execute ./repro and you will see the output stucks for a while and
> > then KASAN is triggered and kernel panic.
> > 5. you can speed up the crash by setting up another ssh shell to
> > execute ./repro again.
> >
> > I have reproduced it on 6.6 and 6.6.1 (but haven't verified on the
> > latest ver 6.6.8 yet). I didn't find any related reports on the
> > internet, which indicates that it may be a 0day. Hope the upstream can
> > help check and fix it. And I'll be happy to assist if needed.
> >
>
> Could you try below fix? or just use latest kernel which already includes=
 it:
>
> https://lore.kernel.org/all/2-v2-ca9e00171c5b+123-iommufd_syz4_jgg@nvidia=
.com/
