Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48A7F4E0
	for <iommu@lists.linux.dev>; Wed, 27 Dec 2023 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga8MIWd4"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6dbfbd2be99so684330a34.1
        for <iommu@lists.linux.dev>; Wed, 27 Dec 2023 01:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703667773; x=1704272573; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=62EGL1QvBkU3z3zaiHwmHMdg6GkLmVh2kc3PbxBdNDI=;
        b=ga8MIWd4vDAAdMYUA/wyiGdliHhHVVTDLATV657xA2QBDxLbhuBD7Cu7rMB3aUAFGN
         9h/C0Zq/3JE+D8g/deiYZhO6q1HOuezo1BFoB2TQu5LzZ4eiwlwaAeb/h0ZSYY1vFQKo
         oD036emH7N1Icsd/irDlsIoZ2OXLhC1hKZAZBJT5r3jcnW3BarJfqFP77XIoQeXF4Cam
         kdJ6CiSkhggHzrFM0Sga8dCZgogUNswLKQmVQlS8XOTr9JhRWO0KPWKpscL4wuqIBWlt
         Jk0y4ciib2o0/jo27P533XtzdP5n+ftvdgf3HOq2gcNf8Ed456NIaVAnXNxYrd9yKqiw
         q5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703667773; x=1704272573;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=62EGL1QvBkU3z3zaiHwmHMdg6GkLmVh2kc3PbxBdNDI=;
        b=Bi2fs4hv4bEVN0TGsbZfi9sAYDc2o1C5zrMl0mQcumlzqWUnkaECQlenzVaa0WCFpT
         wFh/pyxyY+yqE3F6iy8HEiF67txzdm4FygZY+ssvX5iJ2sTajpGsmAHFF0eRlNCQ6XZo
         h3KTrxR6hNVNrA402YrfEAFHSH6UxsGhMkWu6d4QCadyPPBzIA74Da2edYrdO2DWQ40L
         krphMIzbnRutdkscnnfIVE1A1XD7HfsxJ+GT0jU3D8QfL0y9nJy1ihJP6Un9siy2BbgA
         gpmUyD++CM/q/9hZ/h+en/mI5nF970MAEdL4fmovO+bXOU1Kdmae2xGN7z7N6lUy1eJy
         bQ7g==
X-Gm-Message-State: AOJu0YzTRqfaLK3P5SH8yvEBlKbZLQRay1q6fH/oDzH38mDChsYbzkK+
	ZMC+IeiCHw4mwfmhjxxBzgzQpv5E5SrXB6q0Ffs=
X-Google-Smtp-Source: AGHT+IGBoCA0pq5mKruv+7MymaPk+7QWuEARqDwNctU7hLR4p2vurtc9iFIAovqe0bZoGcIrzN+5S3jAdBj7Avd9zAQ=
X-Received: by 2002:a05:6830:22ce:b0:6dc:36:2f91 with SMTP id
 q14-20020a05683022ce00b006dc00362f91mr927458otc.33.1703667772756; Wed, 27 Dec
 2023 01:02:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Zhang Zhiyu <zhiyuzhang999@gmail.com>
Date: Wed, 27 Dec 2023 17:02:41 +0800
Message-ID: <CALf2hKsJjDY3OhtMCxhHh7rS=2S4Oq9Ns=t-NFq1MPD=f0K02Q@mail.gmail.com>
Subject: A bug was found in Linux Kernel 6.6+: KASAN: slab-use-after-free in
 iommufd_test (with POC)
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jgg@ziepe.ca, 
	kevin.tian@intel.com, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Content-Type: text/plain; charset="UTF-8"

Hi upstream community,

I am fuzzing a LTS version of Linux kernel 6.6 with my modified
syzkaller and I find a bug named "KASAN: slab-use-after-free in
iommufd_test". By analyzing the call trace in bug report, I address
the root cause of this bug at drivers/iommu/iommufd. An iommufd_object
is allocated in one task through
iommufd_fops_ioctl->iommufd_ioas_alloc_ioctl->iommufd_ioas_alloc and
freed in another task through iommufd_fops_ioctl->iommufd_destroy.
Then when the kernel invokes the calls
iommufd_fops_ioctl->iommufd_test->iommufd_test_add_reserved->iommufd_put_object,
an use-after-free read will occur. Detailed report, log, repro, config
can be found in this google drive link:
https://drive.usercontent.google.com/download?id=1nDJWUstYJNcC1zJ6q1rhB5zB0uV2yGvg&export=download&authuser=0&confirm=t

The steps to reproduce the bug:
1. compile the kernel 6.6 with provided Linux-6.6.config
2. boot a qemu vm that runs the compiled kernel
3. scp the repro.c (repro.prog is not recommended) to the vm and
compile it with gcc -pthread repro.c -o repro
4. execute ./repro and you will see the output stucks for a while and
then KASAN is triggered and kernel panic.
5. you can speed up the crash by setting up another ssh shell to
execute ./repro again.

I have reproduced it on 6.6 and 6.6.1 (but haven't verified on the
latest ver 6.6.8 yet). I didn't find any related reports on the
internet, which indicates that it may be a 0day. Hope the upstream can
help check and fix it. And I'll be happy to assist if needed.

Best,
Zhiyu Zhang
