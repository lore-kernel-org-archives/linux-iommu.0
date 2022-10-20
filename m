Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF7F3D60
	for <iommu@lists.linux.dev>; Thu, 20 Oct 2022 16:21:16 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id j12so2086664plj.5
        for <iommu@lists.linux.dev>; Thu, 20 Oct 2022 09:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=plOOD7cVd6m0ayR0WngHA5VzJY/ih3n9oBQSnCn1imE=;
        b=gfrRQJVth66JTluBm/IV9RjNih1diET/yN81fJNO+7A/9jBP6/Kw0sjGPFq4VFkHbD
         zvNz99iBHO/vz0BflPXAZ1XSd3kIiVm7eDYQqqd1bC/GOTRfrTuzFUdS08KKn2b+aphj
         hfM9cPO3lI9SSGaa/V6FpDfAUq9lZY3bPsnFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plOOD7cVd6m0ayR0WngHA5VzJY/ih3n9oBQSnCn1imE=;
        b=FNvuNK0GSDBgelhbd23l56iT3zexkgKaO0pKMiWyJFv/XsDS095kgiyC53At83ArIz
         2r3/mNO7cOVtRxWGxwMfCfN6kBbMdfvmAf/Jdzl7kcGnpjDDChtOgECXDcKC1WYN28Wb
         c83bDF8ca18mT4Zm+lJ7SsS8PbJ3y8ai8JoOuySFCjnLEx2NkQB8rzpLaIYFwnZANkwM
         3T3MQ4KFf34NpGYHHWV026X8L4yT4aiwa0+yckgbJ4KrFOT0R6VSmwpXde9FywMCRcNA
         PTS0dkpllXxBDteZEu5tzo9d011M3L7euZLmwgsVdOvMRdONIGbTHlUdMJp9+x0+qHpg
         q2NA==
X-Gm-Message-State: ACrzQf0/6MtViCN3IULtwBihafyPlRi9XhxcdhgN2Y2EarZC7jvSUAOq
	QrX0Y28PMSxqiR6+hYRIGPS3wgaEDLzUsg==
X-Google-Smtp-Source: AMsMyM6TTBcdYg5hMgTgMPFyj9z7SojwECecgH8dVjYo3AiRIoMJbn8XaUhT2ty7xsvM4P3kuD9deg==
X-Received: by 2002:a17:902:f54d:b0:185:4ca4:2641 with SMTP id h13-20020a170902f54d00b001854ca42641mr14463917plf.50.1666282864857;
        Thu, 20 Oct 2022 09:21:04 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:57b7:1f0e:44d1:f252])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902bd4400b0016d72804664sm12908567plx.205.2022.10.20.09.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 09:21:04 -0700 (PDT)
Date: Thu, 20 Oct 2022 09:21:01 -0700
From: Brian Norris <briannorris@chromium.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: 6.1-rc1 regression: bisected to 57365a04c921 iommu: Move bus
 setup to IOMMU device registration
Message-ID: <Y1F1bbaVX4/bmbS0@google.com>
References: <Y1CHh2oM5wyHs06J@google.com>
 <5933d917-a026-7150-2e05-2cb283a73174@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5933d917-a026-7150-2e05-2cb283a73174@arm.com>

On Thu, Oct 20, 2022 at 11:02:23AM +0100, Robin Murphy wrote:
> We shouldn't really need locking for iommu_buses itself, but I guess to
> support async probe we would need per-device locking in
> iommu_probe_device() to prevent multiple threads trying to probe the
> same device at once, which must be what's happening in your case to
> cause a double-dev_iommu_free().

Perhaps. I still haven't spent enough time trying to learn the expected
behavior here.

> I'll see what I can do ASAP, since I
> think that's worthwhile.

Awesome!

> In the meantime, as to why you're hitting the
> failure path at all, I think that's another subtle oversight on my part,

Ah, I didn't even pay attention to the fact we were hitting an error
path here.

The comments you move ("Use the first registered IOMMU device") might
suggest that some of the problems could be more fundamental to rk_iommu,
since with async probe, there is no such "first registerered device".
(Well, they get serialized into some lists eventually, but for the most
part we have to consider them unordered.)

> does something like the diff below help?

I get a different crash at least!

[    0.183048] Unable to handle kernel NULL pointer dereference at virtual address 00000000000002a0
...
[    0.183133] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc1+ #66
[    0.183143] Hardware name: Google Scarlet (DT)
...
[    0.183314] Call trace:
[    0.183319]  _raw_spin_lock_irqsave+0x44/0x9c
[    0.183328]  devres_add+0x34/0x64
[    0.183336]  devm_kmalloc+0xac/0xcc
[    0.183345]  rk_iommu_of_xlate+0x3c/0x80
[    0.183358]  of_iommu_xlate+0x8c/0xd0
[    0.183367]  of_iommu_configure+0x120/0x1d0
[    0.183377]  of_dma_configure_id+0x190/0x244
[    0.183387]  platform_dma_configure+0x40/0x88
[    0.183397]  really_probe+0xac/0x284
[    0.183409]  __driver_probe_device+0xc0/0xec
[    0.183419]  driver_probe_device+0x4c/0xd4
[    0.183429]  __driver_attach+0xb8/0x10c
[    0.183439]  bus_for_each_dev+0x8c/0xd8
[    0.183448]  driver_attach+0x30/0x3c
[    0.183458]  bus_add_driver+0x118/0x1f8
[    0.183467]  driver_register+0x70/0x10c
[    0.183475]  __platform_register_drivers+0x5c/0xcc
[    0.183484]  rockchip_drm_init+0x74/0xc4
[    0.183495]  do_one_initcall+0x154/0x2e0
[    0.183505]  do_initcall_level+0x134/0x160
[    0.183515]  do_initcalls+0x60/0xa0
[    0.183524]  do_basic_setup+0x28/0x34
[    0.183532]  kernel_init_freeable+0xf8/0x150
[    0.183541]  kernel_init+0x2c/0x12c
[    0.183551]  ret_from_fork+0x10/0x20
[    0.183567] Code: 5280002b 1100054a b900092a f9800011 (885ffc01)
[    0.183574] ---[ end trace 0000000000000000 ]---

Brian
