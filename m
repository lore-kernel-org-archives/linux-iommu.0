Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08AB7E
	for <iommu@lists.linux.dev>; Mon,  1 May 2023 10:29:34 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-2f9b9aa9d75so1309924f8f.0
        for <iommu@lists.linux.dev>; Mon, 01 May 2023 03:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20221208.gappssmtp.com; s=20221208; t=1682936973; x=1685528973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWWgbJng3QlsGMyIJqreh5oaPIaSgIU51OJYfzdQOEs=;
        b=Parphb/6pDkmvdzTHfBkKhRuyFB2PBQ7wnTzGkzoiSyHwidlGuqZhQOYEpzt2Dnwzq
         MAWgBgYPIkEwtzFC2PgDixd0LijCGaD4BwAAkynUl674eKsVSKKOY8EADXToyaK4EWn0
         W3mUyEcbedVNbYazYflgDeAhnmsJHq9d/WJDDwjQWBYvZz5F5yiTdmVcZJgOVMTAO1CU
         NUI40aeRyGsjAPjF+C2W9G0I4nlAmPyWBNRYB4fDfiHuv4QyzDxPeNqjMIswoApQV1YB
         jH+OUvE71SF4/dMeMeCVOtbS/bbJzzPE1O+kpIAkFcvaPaiN8J9HB+Eqyk7KeHpz4xA2
         tHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682936973; x=1685528973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWWgbJng3QlsGMyIJqreh5oaPIaSgIU51OJYfzdQOEs=;
        b=STS/4UVXwITHF2BQZGv+mi7rTY+5zGdL8bYdzVg+ekD8SZGTiPk/QMtHecU0/sWozF
         i0si/J7UZuaeVu1Xm8snl3fZj+V4xm7aCwvH74qUQU0GcZP9L0NmANjgiTUPOLZ+doQE
         jaB2oLFz0gVgXKBOv+XdEga11URzGn7lIx0oCnO/N5bzWrbXEdskqoQnWoqri+/SlKq8
         GaDG7/Zstz6kfAElJISmBLpLGaTN7mPdnb4l9UzMXAhXsMnWhKRILf9ElXDDVputeo8i
         ndfmpu3Kno8HeE1OqJE9LUAAXBTgpBMp3IUA0lVxvEAUOWd52p9ym8TL3PGSjI8ZMKvK
         ghmg==
X-Gm-Message-State: AC+VfDwRqd6F2kvTQQPJ21LQVgpz4LR8J7VkRBr+t2LD19B2WS4UL9bi
	k9nl7KGGrXYD+p1BOQEmHa5P9xNo0ZIyC+jA5GGj2A==
X-Google-Smtp-Source: ACHHUZ4/5DlSz4ZKMdiwfULaU9Jzfkp7OiWVIIfSpb+pzBRWZYW11FoDM126mfYFtjemcBUjFPagMttEJCEYqwgNt1I=
X-Received: by 2002:a5d:5703:0:b0:306:2c01:4f08 with SMTP id
 a3-20020a5d5703000000b003062c014f08mr2844543wrv.21.1682936972778; Mon, 01 May
 2023 03:29:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1681898595.git.petr.tesarik.ext@huawei.com>
 <CAHbf0-HwQhFsYW8cp0t9660877b9tTxZBego7VSfx0ayAwKePQ@mail.gmail.com> <20230428110735.4348511d@meshulam.tesarici.cz>
In-Reply-To: <20230428110735.4348511d@meshulam.tesarici.cz>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Mon, 1 May 2023 11:29:21 +0100
Message-ID: <CAHbf0-HnctoNN3AQoCeCfd-d7ppKBhWJHD+EbfmbfeTkbS1jqg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Allow dynamic allocation of software IO TLB bounce buffers
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Borislav Petkov <bp@suse.de>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Zhen Lei <thunder.leizhen@huawei.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, 
	Kim Phillips <kim.phillips@amd.com>, "Steven Rostedt (Google)" <rostedt@goodmis.org>, 
	Muchun Song <muchun.song@linux.dev>, Ondrej Zary <linux@zary.sk>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Petr Tesarik <petr.tesarik.ext@huawei.com>, 
	Hans de Goede <hdegoede@redhat.com>, Dan Williams <dan.j.williams@intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kees Cook <keescook@chromium.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Won Chung <wonchung@google.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

I've not had any issues since using this, but I imagine most people
won't know how to set swiotlb=3Ddynamic if they start seeing this (when
it lands)

Any clue as to why this broke last cycle?

Thanks

Mike

On Fri, 28 Apr 2023 at 10:07, Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wro=
te:
>
> On Fri, 28 Apr 2023 09:53:38 +0100
> Mike Lothian <mike@fireburn.co.uk> wrote:
>
> > On Wed, 19 Apr 2023 at 11:05, Petr Tesarik <petrtesarik@huaweicloud.com=
> wrote:
> > >
> > > From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> > >
> > > The goal of my work is to provide more flexibility in the sizing of
> > > SWIOTLB.
> > >
> > > The software IO TLB was designed with these assumptions:
> > >
> > > 1. It would not be used much, especially on 64-bit systems.
> > > 2. A small fixed memory area (64 MiB by default) is sufficient to
> > >    handle the few cases which require a bounce buffer.
> > > 3. 64 MiB is little enough that it has no impact on the rest of the
> > >    system.
> > >
> > > First, if SEV is active, all DMA must be done through shared
> > > unencrypted pages, and SWIOTLB is used to make this happen without
> > > changing device drivers. The software IO TLB size is increased to
> > > 6% of total memory in sev_setup_arch(), but that is more of an
> > > approximation. The actual requirements may vary depending on the
> > > amount of I/O and which drivers are used. These factors may not be
> > > know at boot time, i.e. when SWIOTLB is allocated.
> > >
> > > Second, other colleagues have noticed that they can reliably get
> > > rid of occasional OOM kills on an Arm embedded device by reducing
> > > the SWIOTLB size. This can be achieved with a kernel parameter, but
> > > determining the right value puts additional burden on pre-release
> > > testing, which could be avoided if SWIOTLB is allocated small and
> > > grows only when necessary.
> > >
> > > Changes from v1-devel-v7:
> > > - Add comments to acquire/release barriers
> > > - Fix whitespace issues reported by checkpatch.pl
> > >
> > > Changes from v1-devel-v6:
> > > - Provide long description of functions
> > > - Fix kernel-doc (Returns: to Return:)
> > > - Rename __lookup_dyn_slot() to lookup_dyn_slot_locked()
> > >
> > > Changes from RFC:
> > > - Track dynamic buffers per device instead of per swiotlb
> > > - Use a linked list instead of a maple tree
> > > - Move initialization of swiotlb fields of struct device to a
> > >   helper function
> > > - Rename __lookup_dyn_slot() to lookup_dyn_slot_locked()
> > > - Introduce per-device flag if dynamic buffers are in use
> > > - Add one more user of DMA_ATTR_MAY_SLEEP
> > > - Add kernel-doc comments for new (and some old) code
> > > - Properly escape '*' in dma-attributes.rst
> > >
> > > Petr Tesarik (7):
> > >   swiotlb: Use a helper to initialize swiotlb fields in struct device
> > >   swiotlb: Move code around in preparation for dynamic bounce buffers
> > >   dma-mapping: introduce the DMA_ATTR_MAY_SLEEP attribute
> > >   swiotlb: Dynamically allocated bounce buffers
> > >   swiotlb: Add a boot option to enable dynamic bounce buffers
> > >   drm: Use DMA_ATTR_MAY_SLEEP from process context
> > >   swiotlb: per-device flag if there are dynamically allocated buffers
> > >
> > >  .../admin-guide/kernel-parameters.txt         |   6 +-
> > >  Documentation/core-api/dma-attributes.rst     |  10 +
> > >  drivers/base/core.c                           |   4 +-
> > >  drivers/gpu/drm/drm_gem_shmem_helper.c        |   2 +-
> > >  drivers/gpu/drm/drm_prime.c                   |   2 +-
> > >  include/linux/device.h                        |  12 +
> > >  include/linux/dma-mapping.h                   |   6 +
> > >  include/linux/swiotlb.h                       |  54 ++-
> > >  kernel/dma/swiotlb.c                          | 382 ++++++++++++++++=
--
> > >  9 files changed, 443 insertions(+), 35 deletions(-)
> > >
> > > --
> > > 2.25.1
> > >
> >
> > Hi
> >
> > Is this a potential fix for
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D217310 where I'm manually
> > setting bigger buffers to keep my wifi working?
>
> Yes. With these patches applied, your system should run just fine with
> swiotlb=3Ddynamic. However, keep in mind that this implementation adds a
> bit of overhead. In short, it trades a bit of performance for not
> having to figure out the optimal swiotlb size at boot time.
>
> Petr T
