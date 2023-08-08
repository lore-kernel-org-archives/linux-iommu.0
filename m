Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A181C2D
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 10:32:00 +0000 (UTC)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4477b141804so2272357137.3
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 03:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691490719; x=1692095519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuLpUzj425ksYkwQNwyCuqLBetYDot3qhVx39suIMw0=;
        b=CW1wmSS3XnGDPuztAUvBaWlWSmKupzqD7zKqc2IMowY3PPppepGN4v5MgAqnF9DH02
         AdD5qc49aYsLGv23+ZifJ1z6ilNUrRVGCerE30r2PozoroL1KW70ZvhPs6F72OOA+gqI
         pliAgJFlXTEHnNhobcHkrX952OYeH8QLgP2tM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691490719; x=1692095519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuLpUzj425ksYkwQNwyCuqLBetYDot3qhVx39suIMw0=;
        b=hxxhGOTvYh9jqN3jCaLyfXYpHIkVvS4odklNqQkOEGyuCNg6aG/UPKtnn9WqI05SjT
         H0qtX1Qx/Gp+moD2AoEIJoS9+yvoX4S4s2rOfk0e0D37ZhV4aJFp9/anBYAi927I3x2Q
         C+fvoaap8icgYmj0x2CTVEjbmohG4vKKkUXVjFPL2iDbA2PosVqvqalki+bKYUoPoSAy
         AtF53qGJ3kjBbR3CpFvkd01+KfyDZ+YMKVUX3edTreTcurprEdBYZkR2fkD3W+8CFdkK
         m8jwfNTIVaTeieae67KIYygDrh9E6I6yCNxe3LsjC3VgnISvmT0Lzfqst9V/VmZqPOk0
         owFA==
X-Gm-Message-State: AOJu0YzaH7zcNlDNDV7AmNLDNd802uzwOjSU/XZRwtG1aNS3uvVvpC1B
	qsNLlqqN/XRFNOugWUQO4ItM+C4PP+gD8FnDtqQUEA==
X-Google-Smtp-Source: AGHT+IHe//IfhEQskoa+DmwWaMX7MNnPiXh2Oww7kuRlFj5Ce4sr0YypupqEhLK7goxUc4ZTN1/MKRprjeA1YzeduZA=
X-Received: by 2002:a05:6102:150:b0:437:e5ce:7e8f with SMTP id
 a16-20020a056102015000b00437e5ce7e8fmr6782940vsr.4.1691490719095; Tue, 08 Aug
 2023 03:31:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com> <ZNDpfCoeFxA56ZlU@8bytes.org>
In-Reply-To: <ZNDpfCoeFxA56ZlU@8bytes.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 8 Aug 2023 18:31:47 +0800
Message-ID: <CAGXv+5E-f9AteAYkmXYzVDZFSA_royc7-bS5LcrzzuHDnXccwA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Refine the locking for dev->iommu_group
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	David Woodhouse <dwmw2@infradead.org>, Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Orson Zhai <orsonzhai@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>, Will Deacon <will@kernel.org>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 7, 2023 at 8:54=E2=80=AFPM Joerg Roedel <joro@8bytes.org> wrote=
:
>
> On Mon, Jul 31, 2023 at 02:50:23PM -0300, Jason Gunthorpe wrote:
> > Jason Gunthorpe (10):
> >   iommu: Remove useless group refcounting
> >   iommu: Add a lockdep assertion for remaining dev->iommu_group reads
> >   iommu: Add generic_single_device_group()
> >   iommu/sun50i: Convert to generic_single_device_group()
> >   iommu/sprd: Convert to generic_single_device_group()
> >   iommu/rockchip: Convert to generic_single_device_group()
> >   iommu/ipmmu-vmsa: Convert to generic_single_device_group()
> >   iommu/omap: Convert to generic_single_device_group()
> >   iommu: Complete the locking for dev->iommu_group
> >   iommu/intel: Fix missing locking for show_device_domain_translation()
> >
> >  drivers/iommu/intel/debugfs.c  |  34 ++++----
> >  drivers/iommu/iommu.c          | 155 +++++++++++++++++++++------------
> >  drivers/iommu/ipmmu-vmsa.c     |  22 ++---
> >  drivers/iommu/omap-iommu.c     |  30 +------
> >  drivers/iommu/omap-iommu.h     |   2 +-
> >  drivers/iommu/rockchip-iommu.c |  22 +----
> >  drivers/iommu/sprd-iommu.c     |  24 +----
> >  drivers/iommu/sun50i-iommu.c   |  29 ++----
> >  include/linux/iommu.h          |   3 +
> >  9 files changed, 138 insertions(+), 183 deletions(-)
>
> Applied, thanks for the nice cleanup!

This series seems to cause a hung task during boot on MediaTek platforms.
It hangs with next-20230808. Reverting the 10 commits from this series
makes the system boot up again.

ChenYu

Logs follow.

INFO: task swapper/0:1 blocked for more than 122 seconds.
      Not tainted 6.5.0-rc5-next-20230808-08004-g396bbe23dbf4 #859
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:swapper/0       state:D stack:0     pid:1     ppid:0      flags:0x0000=
0008
Call trace:
 __switch_to+0x138/0x1e8
 __schedule+0x728/0x1388
 schedule+0xa8/0x170
 schedule_timeout+0x19c/0x1b8
 __wait_for_common+0x250/0x2c0
 wait_for_completion+0x28/0x40
 __flush_work+0x37c/0x6c0
 flush_work+0x1c/0x30
 deferred_probe_initcall+0x60/0xd0
 do_one_initcall+0xe0/0x4a0
 kernel_init_freeable+0x3a4/0x730
 kernel_init+0x2c/0x1f8
 ret_from_fork+0x10/0x20
INFO: task kworker/u18:1:67 blocked for more than 122 seconds.
      Not tainted 6.5.0-rc5-next-20230808-08004-g396bbe23dbf4 #859
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u18:1   state:D stack:0     pid:67    ppid:2      flags:0x0000=
0008
Workqueue: events_unbound deferred_probe_work_func
Call trace:
 __switch_to+0x138/0x1e8
 __schedule+0x728/0x1388
 schedule+0xa8/0x170
 schedule_preempt_disabled+0x44/0x80
 __mutex_lock+0x3fc/0x598
 mutex_lock_nested+0x2c/0x40
 __iommu_probe_device+0xb8/0x6e0
 probe_iommu_group+0x18/0x38
 bus_for_each_dev+0xe4/0x168
 bus_iommu_probe+0x8c/0x240
 iommu_device_register+0x120/0x1b0
 mtk_iommu_probe+0x494/0x7a0
 platform_probe+0x94/0x100
 really_probe+0x1e4/0x3e8
 __driver_probe_device+0xc0/0x1a0
 driver_probe_device+0x110/0x1f0
 __device_attach_driver+0xf0/0x1b0
 bus_for_each_drv+0xf0/0x170
 __device_attach+0x120/0x240
 device_initial_probe+0x1c/0x30
 bus_probe_device+0xdc/0xe8
 deferred_probe_work_func+0xf0/0x140
 process_one_work+0x3b0/0x910
 worker_thread+0x33c/0x610
 kthread+0x1dc/0x1f0
 ret_from_fork+0x10/0x20

Showing all locks held in the system:
4 locks held by kworker/u18:1/67:
 #0: ffffff80c001b538 ((wq_completion)events_unbound){+.+.}-{0:0}, at:
process_one_work+0x2c4/0x910
 #1: ffffffc080777d40 (deferred_probe_work){+.+.}-{0:0}, at:
process_one_work+0x2c4/0x910
 #2: ffffff80c14090f8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8c/0=
x240
 #3: ffffff80c14090f8 (&dev->mutex){....}-{3:3}, at:
__iommu_probe_device+0xb8/0x6e0
1 lock held by khungtaskd/70:
 #0: ffffffe379f945a0 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x24/0x220

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Kernel panic - not syncing: hung_task: blocked tasks
CPU: 4 PID: 70 Comm: khungtaskd Not tainted
6.5.0-rc5-next-20230808-08004-g396bbe23dbf4 #859
55426859c267064a381312eb869e94c28566a87f
Hardware name: Google juniper sku16 board (DT)
Call trace:
 dump_backtrace+0xa0/0x100
 show_stack+0x20/0x38
 dump_stack_lvl+0xdc/0x148
 dump_stack+0x1c/0x28
 panic+0x460/0x4d8
 watchdog+0x4a4/0x9d0
 kthread+0x1dc/0x1f0
 ret_from_fork+0x10/0x20
SMP: stopping secondary CPUs
Kernel Offset: 0x22f7000000 from 0xffffffc080000000
PHYS_OFFSET: 0x40000000
CPU features: 0x0000000c,92010000,0800421b
Memory Limit: none
Rebooting in 30 seconds..
