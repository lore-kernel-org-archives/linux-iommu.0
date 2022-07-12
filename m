Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAEA4414
	for <iommu@lists.linux.dev>; Tue, 12 Jul 2022 15:55:10 +0000 (UTC)
Received: by mail-vs1-f52.google.com with SMTP id t127so8212689vsb.8
        for <iommu@lists.linux.dev>; Tue, 12 Jul 2022 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kB/z5t1/aYZZoyuHqOsKcjs7J443j6ARAbJ8NU1g3Ds=;
        b=b+gzlYHWBVk9NSmPHZc0hUNbXilQym/253PL37ZAudqkv7suZ9ZAk7Ann1uPYqlPsS
         HUrZ6/9a7lWNF6qMv3AthcWlkX3JLqh1YaMRWuomOiEymyGsvKWlcDoxhhuumomlYus8
         DvLYBY1vHS+I2oViRbYcQq2074aOFeYEfLpUJ22XrNfqhIGuy5ruEP2P2x/dC/nQpyYL
         F6piobhREn3N+MvzwwYCIMsmqbgsJl2ieGT6EdaHVozhh6DodbzzDqXCdQbCLMxwK+DV
         Srq44omBJLxWSRpJkCE95zeyudj8qv3iT8//wxIK6HaIQ+6Am1st0COhv3l22hKGf6qm
         mLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kB/z5t1/aYZZoyuHqOsKcjs7J443j6ARAbJ8NU1g3Ds=;
        b=LuHUGufr11ZPZnHs2VnggHl6N1PszfN0pY5SAREz7oM7jaAMgGploxquh1RSfaTzbR
         +P6m3ZJMTdGpbvTT27nusLb5giD7B87G3iCyjJnpuFyvqEf5ByZV+/esiqQTCOa88RIz
         9uGJcq7EcLrFk0pnqUY/PsTkTzvLSwfDqbi8/TjqMV2D+pPQ65QNwfMWRsbIz0/+EIXT
         Denu3bfSs8jAwLpDNc0CGSK8U+lhTAyWEDslF1z9da2ckf3F+EAnieJDnAVWMB7FpAVM
         J6w+mXszLUdkhXk4bcFfKq1G7wwjEbfILhL4iI5ycEE3Het6sSfN8lJT8LPq7vDCu26u
         4BlA==
X-Gm-Message-State: AJIora/apozCPnYq3dPavPljnEJle1I3ZtwkAy3YX8nZ9yj0Luz15pWe
	7knoEWM8bVVI+UAzct9XfLilaauBS81X4ZuGWd8=
X-Google-Smtp-Source: AGRyM1to+myzTVZsBuKMW6P5XHCJeFLggvuCY6M7H+mpbQAd0rpNfme/fobGNIoTbLh+HtiFoLdU3tQGo1ELSArw+fI=
X-Received: by 2002:a67:df04:0:b0:356:f32d:148d with SMTP id
 s4-20020a67df04000000b00356f32d148dmr9083422vsk.60.1657641309682; Tue, 12 Jul
 2022 08:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220712153836.41599-1-alexandr.lobakin@intel.com> <20220712154407.42196-1-alexandr.lobakin@intel.com>
In-Reply-To: <20220712154407.42196-1-alexandr.lobakin@intel.com>
From: Yury Norov <yury.norov@gmail.com>
Date: Tue, 12 Jul 2022 08:54:58 -0700
Message-ID: <CAAH8bW8-JL=q_4c_AKROsjC7KyuRWDMFNKBz=6uT+d1mStTE2A@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: avoid invalid memory access via node_online(NUMA_NO_NODE)
To: Alexander Lobakin <alexandr.lobakin@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Suresh Siddha <suresh.b.siddha@intel.com>, kernel test robot <oliver.sang@intel.com>, iommu@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 12, 2022 at 8:45 AM Alexander Lobakin
<alexandr.lobakin@intel.com> wrote:
>
> From: Alexander Lobakin <alexandr.lobakin@intel.com>
> Date: Tue, 12 Jul 2022 17:38:36 +0200
>
> > KASAN reports:
> >
> > [ 4.668325][ T0] BUG: KASAN: wild-memory-access in dmar_parse_one_rhsa =
(arch/x86/include/asm/bitops.h:214 arch/x86/include/asm/bitops.h:226 includ=
e/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/nodemask.h=
:415 drivers/iommu/intel/dmar.c:497)
> > [    4.676149][    T0] Read of size 8 at addr 1fffffff85115558 by task =
swapper/0/0
> > [    4.683454][    T0]
> > [    4.685638][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0=
-rc3-00004-g0e862838f290 #1
> > [    4.694331][    T0] Hardware name: Supermicro SYS-5018D-FN4T/X10SDV-=
8C-TLN4F, BIOS 1.1 03/02/2016
> > [    4.703196][    T0] Call Trace:
> > [    4.706334][    T0]  <TASK>
> > [ 4.709133][ T0] ? dmar_parse_one_rhsa (arch/x86/include/asm/bitops.h:2=
14 arch/x86/include/asm/bitops.h:226 include/asm-generic/bitops/instrumente=
d-non-atomic.h:142 include/linux/nodemask.h:415 drivers/iommu/intel/dmar.c:=
497)
> >
> > after converting the type of the first argument (@nr, bit number)
> > of arch_test_bit() from `long` to `unsigned long`[0].
> >
> > Under certain conditions (for example, when ACPI NUMA is disabled
> > via command line), pxm_to_node() can return %NUMA_NO_NODE (-1).
> > It is valid 'magic' number of NUMA node, but not valid bit number
> > to use in bitops.
> > node_online() eventually descends to test_bit() without checking
> > for the input, assuming it's on caller side (which might be good
> > for perf-critical tasks). There, -1 becomes %ULONG_MAX which leads
> > to an insane array index when calculating bit position in memory.
> >
> > For now, add an explicit check for @node being not %NUMA_NO_NODE
> > before calling test_bit(). The actual logics didn't change here
> > at all.
>
> Bah, forgot to insert the link here. Hope not worth resending ._.
>
> [0] https://github.com/norov/linux/commit/0e862838f290147ea9c16db852d8d49=
4b552d38d

I'll add this link and apply the patch to the bitmap-for-next, after
some testing.

Thanks,
Yury
