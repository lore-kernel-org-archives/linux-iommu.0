Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C7317CB
	for <iommu@lists.linux.dev>; Tue,  7 Feb 2023 03:33:29 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id bg10-20020a17090b0d8a00b00230c7f312d4so4125532pjb.3
        for <iommu@lists.linux.dev>; Mon, 06 Feb 2023 19:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jZ+4hAwmP/Wq7HMXGBwWwMQ58wAzyvKIfT8l5MVctqA=;
        b=GEvRbWsdrNSjNTj8GEescS6JrVW0Ycs6jHwPtsXuvZCNQqQ8fjp4Y/bEcCjfGuVfvC
         o1tY+Fq8A5guU8wf5aqYziykIYyFFLojmBqUpuZszBewyLlfUFLluBbeYphG1QlPflT7
         MbPiavJcyehwbCxK9Wf89KafdwV59QGm9sdELqOAkPg+jqT54HmyTID2PZphVfKb7uID
         NTsvPZY+1vPd2ewKh0pmoMSNESrVwP6vlJn0DPYV32uB25cppCz7b9CD2sO5XzYaAgQX
         oMZkK64uGSkTw/+ce8QkuRAhh86nb8fPnfwgGLsM05bC0/bsyn4VHQEoHXsObPaVVGxR
         Z6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZ+4hAwmP/Wq7HMXGBwWwMQ58wAzyvKIfT8l5MVctqA=;
        b=FiVL/Fp0yQvV4OfCepqS8eH/vFz73nJPUzgosepOxq5KD6tdH4SLfIA52tT4Yy547J
         ECHxGw0M2p4gET8s3Ss6RI+8GhJog2QxIV1oGttfxsazeqocbnfWHlLJ+fo19slkROi1
         Yf0gHgOxUPjxWempy6iW9zs84aPYREz7gZ3YujafWFxFOfa3WhDQWAz9P3tgHs4jFnL1
         F+jPLW8OOkSjomugmnIbKFeVqEw9OtaERHccQ8f1hroIiqLc53ztTdmdS4p+UOrT9iYy
         x8u5q8U0Uo9ra83E8aTcpC88bw8rwZvRyRdTE7MNJeibyyyPFKMWGBcM+SUmVknim6Ha
         T7uQ==
X-Gm-Message-State: AO0yUKVkh7gvb2neBgWCBQ99KE1kDPZAS2quxnGHEbzASm74bOiFy9CL
	lT6ylr1tUkuv1LidsOylqlP9mvRlpj7ingyxh+rrQA==
X-Google-Smtp-Source: AK7set8/tdh3z8+hwGRprHytiFQk4NEtrGhWl5Yoj/Zs4oIXQ4+pkldjQzMwuNY1PSyLGTcyeZ30Y0LRa22tyDhdiPw=
X-Received: by 2002:a17:902:714b:b0:194:6253:d685 with SMTP id
 u11-20020a170902714b00b001946253d685mr332680plm.3.1675740808337; Mon, 06 Feb
 2023 19:33:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20221103195201eucas1p2a6ec2df41ebac3d9ccbb0b252c2cad34@eucas1p2.samsung.com>
 <20221103195154.21495-1-semen.protsenko@linaro.org> <a7d9cd18-a328-209c-c89f-afdcb7db3eb0@samsung.com>
 <b7ad6444-e7d2-1150-6134-3dae8129dcdb@samsung.com> <CAPLW+4=Y6qZG2XjJR_BkX-ar4GWdETKO1tteJjfbxVc664e4Kg@mail.gmail.com>
In-Reply-To: <CAPLW+4=Y6qZG2XjJR_BkX-ar4GWdETKO1tteJjfbxVc664e4Kg@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 6 Feb 2023 19:32:51 -0800
Message-ID: <CAGETcx9ApZFvKjEaxvvgsoHDzOq06ZiROZ5npYt+suNdE4KWDg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] iommu/exynos: Convert to a module
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Janghyuck Kim <janghyuck.kim@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, 
	Daniel Mentz <danielmentz@google.com>, David Virag <virag.david003@gmail.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 11, 2022 at 5:30 AM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> On Thu, 10 Nov 2022 at 15:36, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> [snip]

Hi Marek and Sam,

I'm replying to both of your comments in this email.

> > I've finally made Exynos IOMMU working as a module on Exynos5433 based
> > TM2e board. It looks that this will be a bit longer journey that I've
> > initially thought. I've posted a simple update of the fix for the driver
> > initialization sequence, but the real problem is in the platform driver
> > framework and OF helpers.
> >
> > Basically to get it working as a module I had to apply the following
> > changes:
> >
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index 3dda62503102..f6921f5fcab6 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -257,7 +257,7 @@ static int deferred_devs_show(struct seq_file *s,
> > void *data)
> >   DEFINE_SHOW_ATTRIBUTE(deferred_devs);
> >
> >   #ifdef CONFIG_MODULES
> > -int driver_deferred_probe_timeout = 10;
> > +int driver_deferred_probe_timeout = 30;
> >   #else
> >   int driver_deferred_probe_timeout;
> >   #endif
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index 967f79b59016..e5df6672fee6 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1384,7 +1384,7 @@ static struct device_node *parse_interrupts(struct
> > device_node *np,
> >   static const struct supplier_bindings of_supplier_bindings[] = {
> >          { .parse_prop = parse_clocks, },
> >          { .parse_prop = parse_interconnects, },
> > -       { .parse_prop = parse_iommus, .optional = true, },
> > +       { .parse_prop = parse_iommus, },
> >          { .parse_prop = parse_iommu_maps, .optional = true, },
> >          { .parse_prop = parse_mboxes, },
> >          { .parse_prop = parse_io_channels, },
> >
> > Without that a really nasty things happened.

I have a command line option to do this without code changes. Use
fw_devlink.strict=1. That makes all optional properties into mandatory
ones.

I sent out a series[1] that tried to make fw_devlink.strict=1 the
default and then use the timeout behavior (more details) to handle
cases where iommu and dmas (or any other supplier) are optional on a
specific board. The cover letter of [1] should give some more context.

> > Initialization of the built-in drivers and loading modules takes time,
> > so the default 10s deferred probe timeout is not enough to ensure that
> > the built-in driver won't be probed before the Exynos IOMMU driver is
> > loaded.

The 10 second is the minimum delay from the time we hit late_initcall.
If a driver is registered before the 10s expires, then the timer will
be extended by another 10s. This behavior landed sometime around the
end of May 2022. So it should have been in your tree when you tested
this. I'm surprised this isn't sufficient for your case. Is there
really a 10s gap in your boot sequence where no module is being loaded
and then IOMMU modules get loaded later on? I'm kinda surprised by
this. Is it this long because some serial UART is enabled and it's
slowing down boot? Or something else?

I'm not saying your case isn't valid or we shouldn't extend the
timeout. I'm just trying to understand why the current timer behavior
wasn't able to cover your case.

> Yeah, the whole time-based sync looks nasty... I remember coming
> across the slides by Andrzej Hajda called "Deferred Problem" [1], but
> I guess the proposed solution was never applied. Just hope that
> increasing the timeout is upstreamable solution.
>
> [1] https://events19.linuxfoundation.org/wp-content/uploads/2017/12/Deferred-Problem-Issues-With-Complex-Dependencies-Between-Devices-in-Linux-Kernel-Andrzej-Hajda-Samsung.pdf

Sam, I kinda skimmed the slides right now. Looks like it talks about
device links and why they aren't sufficient and makes an alternate
proposal. fw_devlink is a solution that uses device links and I think
addresses a lot of the issues that were raised about device links.
There's still a bunch of TODOs left, but I think the end goal is the
same. I'm hoping to keep chipping away at it. For now, I've tried to
make the timer a bit more smart about detecting when modules are
getting loaded and extending the timer. fw_devlink also enables
something called sync_state() that's invaluable on a fully modular
system (search lore for references to that to get some idea).

The slides talk about a solution that will allow devices to probe with
limited functionality with whatever suppliers are available and then
reprobe as more suppliers are available. I'm not sure how well that'll
work across the board. It's going to be a bit weird if your phone
display goes off and then comes on again because an IOMMU driver got
loaded (and it can now do DRM playback). For now, I'm not going to
focus on that option because there are enough existing issues/TODOs to
work on for fw_devlink.

> > The second change fixes the problem that driver core probes Exynos IOMMU
> > controllers in parallel to probing the master devices, what results in
> > calling exynos_iommu_of_xlate() and exynos_iommu_probe_device() even on
> > the partially initialized IOMMU controllers or initializing the dma_ops
> > under the already probed and working master device. This was easy to
> > observe especially on the master devices with multiple IOMMU
> > controllers. I wasn't able to solve this concurrency/race issues inside
> > the Exynos IOMMU driver.
> >
> > Frankly speaking I don't know what is the rationale for making the
> > 'iommus' property optional, but this simply doesn't work well with IOMMU
> > driver being a module. CCed Saravana and Rob for this.
> >
>
> The patch which makes 'iommus' optional doesn't provide much of
> insight on reasons in commit message either.

This was the commit text:

    Not all DT bindings are mandatory bindings. Add support for optional DT
    bindings and mark iommus, iommu-map, dmas as optional DT bindings.

I thought it was obvious enough, but I guess I could have done better.
Geert convinced me that iommu's aren't always necessary and devices
could work perfectly well without them or dmas. And he has a bunch of
boards like that. So I went with adding optional and then introducing
fw_devlink.strict.

However, at this point in time, I believe none of them should be
marked as optional because technically any property can be optional
depending on what the firmware has set up and what the driver does. We
should figure this out at runtime on a board level -- which is what
[1] is trying to do. Yeah, not very pretty, but there hasn't been a
better solution that's not "have userspace tell us it's done loading
modules" (that's a "kernel depends on userspace to work correctly"
thing that no one likes). I've fixed some of the issues raised in [1]
in a fw_devlink improvement series[2] and I plan on continuing to work
on this until hopefully [1] can land.

> > Without fixing the above issues, I would add a warning that compiling
> > the driver as a module leads to serious issues.
> >
>
> Nice catch! It doesn't reproduce on my platform, alas. Can I expect
> you to submit those patches? If so, I'll probably just wait for those
> to be applied, and then re-send my modularization series on top of it.
> Does that sounds reasonable?

For now, maybe we could add a config to enable fw_devlink.strict=1 by
default and then select it if you make specific iommu drivers into
modules? And then Geert won't set it for his driver, but you can set
it for your driver?

Thanks,
Saravana

[1] - https://lore.kernel.org/lkml/20220601070707.3946847-1-saravanak@google.com/
[2] - https://lore.kernel.org/lkml/20230207014207.1678715-1-saravanak@google.com/
