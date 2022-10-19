Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CEC53BD
	for <iommu@lists.linux.dev>; Wed, 19 Oct 2022 23:26:02 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id g8-20020a17090a128800b0020c79f987ceso1620034pja.5
        for <iommu@lists.linux.dev>; Wed, 19 Oct 2022 16:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kCrr6LO18tP6wCxlMLOmJl4WHU24uqHWyJMDkciIfOM=;
        b=D9WAlepLYOvpEI9BMIVW4Omoei0ha7QnTRjMRHuteVnS8NNaHh1vHePnL7Sl2L0ReM
         SM44jAcXK11dLpXlD8U/l0Talg1011mYDTL3lpia+XPEg6Wv/n51LWkQ7keTjGfX6PHv
         XVelW4uRs/VmsLZ2QaFy5/pJH9B1nM4ZDF1yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kCrr6LO18tP6wCxlMLOmJl4WHU24uqHWyJMDkciIfOM=;
        b=4s1KWIqK6mbIYoSLY1f12Pr06mfakXVqwj49GkfCM8b77ReniGIvTNV6MaphSK4to2
         /KUMJMM7MB1CDZeqbRdZleChSj8+iTQ6B1IKrf+SWAEBTy+zx9FH+n535c7x2oKjhAa4
         dM92GC3FXiw2pmMUvzNFoBssi/tSGQ0IhcSlOWfzi1TC/2YDaKSsO6bVphZE9VcFeFq0
         jxHcPWyP+1cxzTtUpmfXVAbUH6eHfXFn7RsImZBRvRw1+o+TOHr/rPUL5yJEDhcBccf7
         1km4bpW09YM0eulpThs0phtEhMaD6DsEAWcb0qDTnRpkxh1aP4TMZVYhOjs2SnxCJsG1
         ZXyw==
X-Gm-Message-State: ACrzQf0CsYLvvIyAeQaHJkcb+6slIA3AtRtLxVsAdHJxIy9uoJ/0NvAe
	Cq0GmgscE7NEKW+M6WwvVMUAYQ==
X-Google-Smtp-Source: AMsMyM7FTMweQNUfPOqsaOfzenyvSJOYLZ9Di7+HWbhbgERN9EsEsFmZWA8hfx2TbLwm7g+6alGjNg==
X-Received: by 2002:a17:903:200a:b0:184:1881:bfd1 with SMTP id s10-20020a170903200a00b001841881bfd1mr11109156pla.95.1666221961958;
        Wed, 19 Oct 2022 16:26:01 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:57b7:1f0e:44d1:f252])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090a64cb00b00205db4ff6dfsm423554pjm.46.2022.10.19.16.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 16:26:01 -0700 (PDT)
Date: Wed, 19 Oct 2022 16:25:59 -0700
From: Brian Norris <briannorris@chromium.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: 6.1-rc1 regression: bisected to 57365a04c921 iommu: Move bus setup
 to IOMMU device registration
Message-ID: <Y1CHh2oM5wyHs06J@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I'm testing out asynchronous probe (that's, kernel cmdline
'driver_async_probe=*' or similar), and I've identified a regression in
v6.1-rc1 due to this:

commit 57365a04c92126525a58bf7a1599ddfa832415e9
Author: Robin Murphy <robin.murphy@arm.com>
Date:   Mon Aug 15 17:20:06 2022 +0100

    iommu: Move bus setup to IOMMU device registration

In particular, I'm testing a Rockchip RK3399 system with
'driver_async_probe=rk_iommu', and finding I crash like this:

[    0.180480] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
...
[    0.180583] CPU: 2 PID: 49 Comm: kworker/u12:1 Not tainted 6.1.0-rc1 #57
[    0.180593] Hardware name: Google Scarlet (DT)
[    0.180602] Workqueue: events_unbound async_run_entry_fn
[    0.180622] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.180632] pc : dev_iommu_free+0x24/0x54
[    0.180644] lr : __iommu_probe_device+0x110/0x180
...
[    0.180785] Call trace:
[    0.180791]  dev_iommu_free+0x24/0x54
[    0.180800]  __iommu_probe_device+0x110/0x180
[    0.180807]  probe_iommu_group+0x40/0x58
[    0.180816]  bus_for_each_dev+0x8c/0xd8
[    0.180829]  bus_iommu_probe+0x5c/0x2d0
[    0.180840]  iommu_device_register+0xbc/0x104
[    0.180851]  rk_iommu_probe+0x260/0x354
[    0.180861]  platform_probe+0xb4/0xd4
[    0.180872]  really_probe+0xfc/0x284
[    0.180884]  __driver_probe_device+0xc0/0xec
[    0.180894]  driver_probe_device+0x4c/0xd4
[    0.180905]  __driver_attach_async_helper+0x3c/0x60
[    0.180915]  async_run_entry_fn+0x34/0xd4
[    0.180926]  process_one_work+0x1e0/0x3b4
[    0.180936]  worker_thread+0x120/0x404
[    0.180942] [drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
[    0.180944]  kthread+0xf4/0x14c
[    0.180953]  ret_from_fork+0x10/0x20
[    0.180968] Code: f9000bf3 910003fd f9416c13 f9016c1f (f9401a68) 
[    0.180981] ---[ end trace 0000000000000000 ]---

I find if I revert the above commit (and 29e932295bfa ("iommu: Clean up
bus_set_iommu()"), to keep the reverts clean), things start working again.

I haven't worked out exactly what's going wrong, but the patch looks like it
isn't async safe at all, due to the way each device is poking (without locking)
at the global iommu_buses[].

Is this a regression worth tracking (e.g., potentially reverting commit
57365a04c921)? Or should we just accept that iommu drivers cannot probe
asynchronously (and thus set PROBE_FORCE_SYNCHRONOUS for all iommu drivers)?

In the meantime, I'll see if I can figure out a reasonable non-revert solution
that is async safe, but I wanted to report this now, in case I don't
have much luck or enough time.

Thanks,
Brian
