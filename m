Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7F334B669
	for <iommu@lists.linux.dev>; Wed,  5 Aug 2026 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785938878; cv=pass; b=cEora73ChpIz8qcO6mu0bnBDcNvjfugagPYyS+aPpBihqU7NTXgIJAAIpVGjd0pP5JNC5K0zym045jFtJVTbeYxkpXE6FNJzFAj84J2dcQo8Bf769MWd6Co7AKF4p7tYqE6gNxdOQD7Cy4XjYfY5CoXvlLMJUoR8G+RcdvHA42o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785938878; c=relaxed/simple;
	bh=73tBq2OewaRbdq1DyK6U08xUdF5zIDBIdCMyYcrqNAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdiVzfnvmlqHNaNNCAW7XoYwPfUCp8ivu/LzL4ifm2H56Eh9DwTz7G/rAnVZCokHugcu67ltCMgsTp9zGMEuO574BI/4yShXIyC4rn2BvQgSd2ZZzk08SEupQmjwxCU8BPQS4Kx5js7BqM414IV21i1cEQB5AOJCJ5BsVDPbxJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gV++lwXg; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV++lwXg"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66898920476so148544d50.3
        for <iommu@lists.linux.dev>; Wed, 05 Aug 2026 07:07:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785938872; cv=none;
        d=google.com; s=arc-20260327;
        b=aw/meP5Xbm4oEoJetFc7CnBaNI95U+3ZQoLgf/IVPNxSeGmFTE6sjFcqCA6fJH3em/
         8WQ6UHOLQZFNN6bWtfMwUf9HtUy9dmPl/jY4ShDxDOCyD6BNx7RElq4mEUe+7OfV+akX
         +nRIVno1KWQvB1h4qljGTH8WFg7SCFFKnxgZUQYzuYSCWKKOgdFQ/ib4zbulUyBw2ss2
         WCwZzp9ZJu49A4wlqMx4PO8ii8Z+4rOK6UeE9PN3WHKT5uEQFyydF92C822JqIrlk2wG
         FTn1KCPfAgmHTKqmgcQSFNpnBeW5YIeU5ydcE2EH5KCGbZR5kjpIJmh8LurfHyxqmSHA
         qplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C38CFYrfv7iGRzSwLxu9EmPCGBFSgeFoe1tVmloXpg8=;
        fh=kEqT2UwXnby3lxeRBl/XBdWwqQ7V4fefbFCp/ldpiqU=;
        b=BURIL2sz/No1U6gQ9hFlFb40H5bjQfC0g4O0DYTCz7BafwLn6ZXXLDX+5XN1K/lMF0
         BQYJVQAESNHusApYkLMKnwN+//FN+2xUTGTcWIutqdBk4Q8KlDebtZ5865X8l5x9ir+l
         /32VgxBKOqmwr/NIHQIdFXcNtn+vAYQVfNwNnt6if8s5TaiXTTsWErOM6BZXh9uQBgZ6
         acbQENW1XwQzBUh0ku86musV3CS8Bi7g7bCgX8UzTM+fhE3JCv5DDiUo70JA+dZ+HdiK
         c11Bm5Hmsm4KgO07oMbji2IqYIDA4UGyM8LYQ1FirmMjHg7YqWKixiRuXJlhF9LhV5mu
         iuNQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785938872; x=1786543672; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C38CFYrfv7iGRzSwLxu9EmPCGBFSgeFoe1tVmloXpg8=;
        b=gV++lwXgPMi2BhC1gVWP5K5bNYvlwTkmicCyjGHKx9JR4QcILruI76NJ6nszNN/Nu9
         esz/Ysz5hOxrio1aLMyaFbgrS7laDyUzgGTsaLK6vU/52NAKGVr+L8HQNnwxphM+X7Pt
         MeZ8idPZezIHJXSwJj/RlzObugngi3tFKQoSN9GgovLJe+HhJUXbb5w12dJ6wropZ0Jz
         Qv34iT46xBEgzB6jg3DfpTiWhFrsEIdernFYHIzM5wh49m0NNu3UWUd0McpJGWDQati6
         ky0uaEHi/CrNpwXs9VrIRDOJzYBDHmPN4rcCsbWww9ng042xAg75jHoj0JibpuylL/zA
         9AEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785938872; x=1786543672;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C38CFYrfv7iGRzSwLxu9EmPCGBFSgeFoe1tVmloXpg8=;
        b=cIxBj82n9SD+a3EW7zv2qccNiFMFAcISu4bGEVpAp6fd2AMWWu4Pl4EgM21/5MkiGt
         Ntx0zRMqmMzUYtGNSkMF7ugRrnhnckuzveZYZ9Opg7m94RPeIc5VGFcuxPijiMmtYl5S
         UXyIyCOQubPBo74g2QbR5AVkpC1g0CdFdzqYOIIlA8BrLLTNqfs5V7oyIaaGeZHl/rh4
         ZXUD6iVDLT/kzaRtmTr/vezpLe2OvYw+D44ofYRlDS0YCZGhH6pUjQEyBQFySpcfr3vB
         bxIrGhk3nTeJiEamBUfXTTb8Z1jFGlzRfDgPfhgxhdeRHOMFI5svlYjvZxfUkE4+Wox+
         DjbQ==
X-Forwarded-Encrypted: i=1; AHgh+RobDuxPsCN8Pfhx7Qj4ojmyZlDqw4otQz3QB8YD5KMKqPjQF1TsLkVIP7UZwm25Is/62BinwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywd5lUP4i98n53K7Uq2jLRJC9IlgJCBWRkdbOxm6bXBn9tx/q7F
	cksMzB4e30swEbXAdFezkk282itlTMAtski+om4qTB3ljI2MAe8ejHMZPntEPIhVB3ArcDFIErI
	kEYTuAb6yelaosnNzZZuLYep+GbmAe3A=
X-Gm-Gg: AR+sD13IBGVr/UY4hjBJtgnw3zUt/iiv5s+L3f6whse25zi6RyQMeexU2fPoEgn/qWd
	yNs9dNgyNoa2HZ5FDTjy/hCDwCSJqGveVYTRycIV8g7swwUaA2aqPnsRFPzYXwuBt04YiP09ROT
	lB9kYiBBbQIOWtG7pzNreMQnFyp5DNKC1154i9CB2mBUDQE5RVBBwqf+/J8ObTbpi9Nurd2h78Y
	aDk7Oao2SVpu1xr8uVMEsPoXj7IWetXjRGLLoQ1V1pMmlJNTBHlMOmGEokZF4b01aO7ccVa+j9g
	8UyKyLWLhIDuhH2URhMcUf1cMzU3xw/uGvrWq380oEkcKHvplVsu72r8w168Ydglv+N2X8eqhQ5
	Atfc=
X-Received: by 2002:a05:690c:c511:b0:81f:45f0:21d7 with SMTP id
 00721157ae682-8201ba296c4mr35594537b3.0.1785938871052; Wed, 05 Aug 2026
 07:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260805063826.95682-1-gahing@gahingwoo.com> <20260805063826.95682-7-gahing@gahingwoo.com>
 <DKH0VYV0DMRB.3F9GXE6E2TSZ@cknow-tech.com> <CAEWPSH7wEWYZK=sXo1BjQuJuKhNpgr+AzsSjOj7vHmAVDSDz6A@mail.gmail.com>
In-Reply-To: <CAEWPSH7wEWYZK=sXo1BjQuJuKhNpgr+AzsSjOj7vHmAVDSDz6A@mail.gmail.com>
From: Igor Paunovic <royalnet026@gmail.com>
Date: Wed, 5 Aug 2026 16:07:39 +0200
X-Gm-Features: AUfX_myppmSsmPzKKajr2h0WDHF7QLAOMjTWlzyM5oYCxmuCcOpjZY-Fp4L27AY
Message-ID: <CAEWPSH5iQ=u78eXFt6p3KKQwHvszYz4GbOEKu2Ef9D1LYUH0Rg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 v5 6/8] accel/rocket: add RK3576 NPU (RKNN) support
To: Diederik de Haas <diederik@cknow-tech.com>
Cc: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net, heiko@sntech.de, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org, 
	p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com, 
	alchark@flipper.net, chaoyi.chen@rock-chips.com, 
	dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
	iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Diederik,

Seconding this, with a data point that may help make the case.

I have my own fix in flight that touches the same function, "accel/rocket:
request the core clocks by name":

  https://lore.kernel.org/linux-rockchip/20260729130743.128876-1-royalnet02=
6@gmail.com/

It carries Jiaxing's Reviewed-by and a Tested-by from Sidong Yang and is
waiting on Tomeu. Earlier today I built 6/8 on top of a tree that already
has it, to characterise the RK3588 side on hardware. git apply refused the
patch outright, and with fuzz everything applied except one hunk, the
resets-and-clocks hunk in rocket_core_init(), which I had to resolve by
hand. So the two RK3588-affecting changes in this patch are already
colliding in practice, not just in principle.

That hunk is doing three separate things at once: it re-adds the four
clks[].id assignments that my standalone fix adds, it grows the array and
switches both bulk counts to soc->num_clks and soc->num_resets, and it adds
the two RK3576 CBUF entries. Only the last of those is RK3576 enablement.
The first is a bugfix that exists independently, and the middle one is
exactly the "prepare for different implementations" step you are asking
for.

Split the way you suggest, the ordering problem goes away on its own. The
preparation patch would carry the soc_data plumbing and the count changes,
rebased on whatever landed first, and the RK3576 patch would carry the CBUF
entries and the poll path. Nothing would need to be sequenced by hand, and
the commit message could stop claiming the RK3588 path is behaviourally
unchanged, which is the part I raised separately on this patch and which is
only true once the bugfix is not being carried along with the enablement.

Igor

On Wed, Aug 5, 2026 at 4:06=E2=80=AFPM Igor Paunovic <royalnet026@gmail.com=
> wrote:
>
> Hi Jiaxing,
>
> Here is the RK3588 characterisation I promised on the cover letter. Short
> version: I cannot measure any effect from this patch on RK3588. The outpu=
t
> is bit-identical and the interrupt accounting is unchanged to within
> 0.0001 interrupts per inference.
>
> What was compared
> -----------------
>
> Both sides were built from the same tree, from the same headers, with onl=
y
> your 6/8 between them:
>
>   base: v7.2-rc6 rocket + the four fixes I have in flight
>         (Guangshuo Li's "clear rdev on device init failure", my two
>         lifecycle patches, and "request the core clocks by name")
>   test: the same tree + this patch, hand resolved, see below
>
>   running kernel 7.2.0-rc6-rk3588-igor-claude+, tree pinned at Collabora
>   rockchip-devel 8c70065a3207, which sits on 075b74841bd0 =3D Linux 7.2-r=
c6.
>   Not a v7.2 tag; that does not exist yet.
>
>   base module srcversion 97DECECF73741ABE56685D2
>   test module srcversion 57A4D5369E495870E651EEC
>
> I deliberately left my local devfreq work out of both sides. It touches
> rocket_job.c, you do not have it, and it would have changed the clock
> during the runs. The consequence is that the NPU ran at the firmware
> default rate rather than the rate I normally use, so the absolute numbers
> below are around 89 inf/s where I would usually quote about 222. That doe=
s
> not matter for a difference measurement, but it means these figures are n=
ot
> comparable to any throughput number I have posted before.
>
> One thing worth reporting before the numbers: 6/8 does not apply cleanly =
on
> that base, for two separate reasons, and only one of them concerns you an=
d
> me.
>
> The first is the coordination point from my earlier mail, now measured
> rather than predicted. The clks[].id hunk in rocket_core.c conflicts with
> my standalone "request the core clocks by name" fix. I resolved it by han=
d,
> keeping your two CBUF entries and the soc->num_clks and soc->num_resets
> changes on top of the four named assignments that are already there.
>
> The second is not a conflict with anything I carry. The rocket_job.c hunk
> has "#include <linux/overflow.h>" in its context, and that line is neithe=
r
> in v7.2-rc6 rocket_job.c nor added by any patch in this series, so your
> tree is simply newer than v7.2-rc6 there. Mentioning it so that a clean
> apply on your side does not get read as a contradiction of the first poin=
t.
>
> That means this Tested-by is on the hand resolved form of 6/8, not on the
> posted hunks applied verbatim.
>
> Method
> ------
>
> Interleaved, with the order alternated per pair, because my first attempt
> was not interleaved at all. That attempt measured base and test in separa=
te
> blocks and showed a 1.6% difference on the NPU part, once the first run o=
f
> each block is dropped. It is not your patch. The two blocks ran under
> measurably different conditions: NPU thermals 43.5-49.0 C and one minute
> load average 2.9-4.4 during the base block, against 39.8-44.4 C and 2.0-3=
.1
> during the test block. And one test run behaved like a base run: same
> module, CPU part 1.87 ms, where the other three test runs sat at 1.67-1.6=
8
> ms. I believe that was my desktop client compositing while I typed in it,
> but I did not isolate it as a controlled variable, so what I can actually
> say is that the block to block gap was environmental, and that the
> interleaved rerun below shows nothing.
>
> So: three pairs, order base/test, then test/base, then base/test, module
> swapped between every single run, no interactive use of the machine, only
> the usual system timers. One honesty note on the design: the alternation
> only balances fully over an even number of pairs, and I ended up with
> three, so base occupies series positions 1, 4 and 5 against test's 2, 3 a=
nd
> 6. The series does drift slowly downwards, NPU thermals falling from 39.8=
 C
> to 37.9 C over the six runs, and that drift is therefore not entirely
> cancelled. It is well below the effect size discussed below, but it is
> there.
>
> Environment held constant: CPU governor performance at 1800/2400/2400 MHz=
,
> vdd_npu_s0 at 850 mV, NPU thermals 37.9-39.8 C. Those thermals are
> snapshots taken at the start and end of each run, not a continuous trace.
>
> MobileNetV1 through the Teflon TFLite delegate, effectively one core, 20 =
s
> x 3 blocks per run, per-run block spread 0.29-1.09%.
>
> Results, 3 runs per side
> ------------------------
>
>                     base              test           delta
>   throughput   89.0093 +-0.3568   88.9546 +-0.2270   -0.06%   inf/s
>   NPU part      9.7521 +-0.0434    9.7570 +-0.0364   +0.05%   ms/inferenc=
e
>   CPU part      1.4828 +-0.0022    1.4847 +-0.0106   +0.13%   ms/inferenc=
e
>
> The largest standard deviation on the NPU part is 0.0434 ms, 0.45% of the
> mean. The measured difference is 0.0049 ms, 0.05%, about an eighth of tha=
t
> standard deviation. This does not say the patch costs nothing; it says an=
y
> cost is below what this bench resolves. With three runs per side the 95%
> confidence bound on the difference is about +-0.9% of the mean, so one
> percent is the honest resolution figure, not half a percent.
>
> Interrupt accounting per inference:
>
>                     base                    test              delta
>   irq 99     41.11512 +-0.00046      41.11519 +-0.00029     +0.000071
>   irq 102     1.00281 +-0.00001       1.00281 +-0.00001     +0.000002
>   irq 103     0.00000 +-0.00000       0.00000 +-0.00000      0
>
> These are integer counters. The residual scatter is a window alignment
> artefact, because the counter window does not line up exactly with the
> counted iterations, which is also why the figure is 41.115 rather than 41=
.
> It is three orders of magnitude below one interrupt per inference, so a
> dropped or a doubled task boundary would be unmissable. This is the numbe=
r
> I care about most: the restructured completion path neither double counts
> nor drops a task boundary. For this model 41 completions per inference la=
nd
> on core 0 and one on core 1; irq 103 stays at zero because the third core
> is idle in this workload.
>
> The bit exact oracle passed on every run, and the reference hashes over t=
he
> five tracked tensors are identical across all six runs, 32044 inferences
> in total. Top-1 unchanged at "military uniform", 0.867.
>
> The module was loaded 13 times over the session, reporting "[drm]
> Initialized rocket 0.0.0 for rknn on minor 0" with minor 0 every time, an=
d
> there is no rocket error or warning anywhere in that boot. Twelve of thos=
e
> loads were unloaded normally. The thirteenth was still resident when the
> machine stopped, which is the last caveat below.
>
> What I did not test, and why
> ----------------------------
>
> Three things, and they are not the same kind of "not".
>
> The poll_dying latch and rocket_poll_work_fn() cannot be exercised on thi=
s
> SoC at all. The flag is written only under
>
>     if (core->soc->poll_completion)
>         WRITE_ONCE(core->poll_dying, true);
>
> poll_completion is false in rk3588_soc_data, and the poll timer is starte=
d
> under the same guard in rocket_job_hw_submit(), so neither the timer
> function nor the work function can run here. The fini path race I raised =
on
> this patch needs RK3576 for the same reason.
>
> The per-core unbind/rebind I promised on the cover was runnable here and =
I
> did not run it. That distinction matters, so: the rocket platform driver
> exposes bind and unbind in sysfs, all three cores are bound here, and
> unbinding one while the other two stay bound does reach patched code on
> RK3588, through rocket_core_fini() and rocket_job_fini() on the way out,
> and soc->num_clks and soc->num_resets on the way back in. That is not
> covered by an insmod/rmmod of the whole module. It is a gap in my testing=
,
> not a limitation of the hardware, and I will run it before v6 if you want
> it.
>
> The module unload under load I also promised is not runnable in that form=
:
> rmmod is refused by the module refcount while a DRM fd is open, and my
> harness declines the swap rather than fight it. The runnable equivalent i=
s
> an unbind under load, which I also did not run. All 13 loads above happen=
ed
> between benches with nothing attached.
>
> So the Tested-by covers what I actually measured: that this patch does no=
t
> regress the RK3588 path, in timing, in interrupt accounting or in output.
> The RK3576 specific paths are untested by me.
>
> Two caveats on the numbers.
>
> First, three runs per side rather than four. The machine went down partwa=
y
> through the fourth pair, roughly 25 seconds into the test side, with your
> module loaded and inference in flight. I am describing it that way becaus=
e
> that is what the logs support: the journal for that boot ends mid-run wit=
h
> no shutdown sequence at all, the bench's output file for that run is zero
> bytes, my script's exit trap never ran, and the following boot logs an
> orphan cleanup and a journal marked uncleanly shut down. Whether the
> desktop or the whole machine went first is not recorded. There is no oops=
,
> no kernel WARNING, no call trace and no rocket error anywhere in that boo=
t,
> and nothing that ties it to this patch, but it did happen with this patch
> loaded and I have no explanation for it. I power cycled and did not
> resume the series rather than mix a rebooted machine into it. I would
> rather report it than not.
>
> Second, the resolution bound of about one percent is a property of my
> bench, not of the patch.
>
> If there is an ordering or a workload you would rather I ran, say so and =
I
> will run it.
>
> Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, Orange Pi 5 Pl=
us
>
> Igor
>
> On Wed, Aug 5, 2026 at 2:52=E2=80=AFPM Diederik de Haas <diederik@cknow-t=
ech.com> wrote:
> >
> > On Wed Aug 5, 2026 at 8:38 AM CEST, Jiaxing Hu wrote:
> > > The RK3576 carries the same RKNN block as the RK3588, with two cores
> > > instead of three and a few platform differences:
> > >
> > >  - the CBUF (convolution buffer) has its own clock domain, so the cor=
e
> > >    needs six clocks rather than four;
> > >  - the BIU reset moved into the power domain, leaving one reset here;
> > >  - the NPU spans two power domains, and a device with more than one i=
s
> > >    skipped by the driver-core single-domain auto-attach, so the list =
has
> > >    to be attached explicitly;
> > >  - the DPU completion interrupt is armed exactly as on RK3588 but nev=
er
> > >    reaches the GIC. The completion is visible in INTERRUPT_RAW_STATUS=
,
> > >    so sample that from an hrtimer rather than wait for an interrupt t=
hat
> > >    does not come. The interrupt stays armed, so if it ever does arriv=
e
> > >    the normal handler finalises the job first.
> > >
> > > Select all of that from of_device_id match data so the RK3588 path ke=
eps
> > > its existing counts and behaviour unchanged.
> >
> > Would it make sense to split this patch up in 2 patches:
> > 1) Prepare for different NPU/RKNN implementations
> > 2) Add support for RK3576 NPU/RKNN
> >
> > It seems like you're changing the implementation for RK3588 in this pat=
ch
> > AND add support for RK3576. It's often better to split those things out=
.
> >
> > Cheers,
> >   Diederik
> >
> > > Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> > > ---
> > >  drivers/accel/rocket/rocket_core.c   |  26 +++++-
> > >  drivers/accel/rocket/rocket_core.h   |  20 ++++-
> > >  drivers/accel/rocket/rocket_device.c |   4 +
> > >  drivers/accel/rocket/rocket_drv.c    |  22 ++++-
> > >  drivers/accel/rocket/rocket_job.c    | 121 ++++++++++++++++++++++++-=
--
> > >  5 files changed, 176 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocke=
t/rocket_core.c
> > > index b3b2fa9ba..e08288c8c 100644
> > > --- a/drivers/accel/rocket/rocket_core.c
> > > +++ b/drivers/accel/rocket/rocket_core.c
> > > @@ -8,6 +8,7 @@
> > >  #include <linux/err.h>
> > >  #include <linux/iommu.h>
> > >  #include <linux/platform_device.h>
> > > +#include <linux/pm_domain.h>
> > >  #include <linux/pm_runtime.h>
> > >  #include <linux/reset.h>
> > >
> > > @@ -21,14 +22,22 @@ int rocket_core_init(struct rocket_core *core)
> > >       u32 version;
> > >       int err =3D 0;
> > >
> > > +     /* RK3576 moves the BIU reset into its power domain and takes o=
nly srst_a. */
> > >       core->resets[0].id =3D "srst_a";
> > >       core->resets[1].id =3D "srst_h";
> > > -     err =3D devm_reset_control_bulk_get_exclusive(&pdev->dev, ARRAY=
_SIZE(core->resets),
> > > +     err =3D devm_reset_control_bulk_get_exclusive(&pdev->dev, core-=
>soc->num_resets,
> > >                                                   core->resets);
> > >       if (err)
> > >               return dev_err_probe(dev, err, "failed to get resets fo=
r core %d\n", core->index);
> > >
> > > -     err =3D devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->cl=
ks);
> > > +     core->clks[0].id =3D "aclk";
> > > +     core->clks[1].id =3D "hclk";
> > > +     core->clks[2].id =3D "npu";
> > > +     core->clks[3].id =3D "pclk";
> > > +     /* RK3576 clocks the CBUF separately; the compute path stalls w=
ithout these. */
> > > +     core->clks[4].id =3D "aclk_cbuf";
> > > +     core->clks[5].id =3D "hclk_cbuf";
> > > +     err =3D devm_clk_bulk_get(dev, core->soc->num_clks, core->clks)=
;
> > >       if (err)
> > >               return dev_err_probe(dev, err, "failed to get clocks fo=
r core %d\n", core->index);
> > >
> > > @@ -65,6 +74,19 @@ int rocket_core_init(struct rocket_core *core)
> > >               return err;
> > >       }
> > >
> > > +     /*
> > > +      * RK3576 spans two power domains, and a multi-domain device is=
 skipped
> > > +      * by the driver-core single-domain auto-attach, so attach the =
list here.
> > > +      */
> > > +     if (core->soc->multi_power_domain) {
> > > +             struct dev_pm_domain_list *pd_list;
> > > +
> > > +             err =3D devm_pm_domain_attach_list(dev, NULL, &pd_list)=
;
> > > +             if (err < 0)
> > > +                     return dev_err_probe(dev, err,
> > > +                                          "failed to attach NPU powe=
r domains\n");
> > > +     }
> > > +
> > >       pm_runtime_use_autosuspend(dev);
> > >
> > >       /*
> > > diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocke=
t/rocket_core.h
> > > index f6d738285..205ff070d 100644
> > > --- a/drivers/accel/rocket/rocket_core.h
> > > +++ b/drivers/accel/rocket/rocket_core.h
> > > @@ -6,6 +6,7 @@
> > >
> > >  #include <drm/gpu_scheduler.h>
> > >  #include <linux/clk.h>
> > > +#include <linux/hrtimer.h>
> > >  #include <linux/io.h>
> > >  #include <linux/mutex_types.h>
> > >  #include <linux/reset.h>
> > > @@ -27,16 +28,25 @@
> > >  #define rocket_core_writel(core, reg, value) \
> > >       writel(value, (core)->core_iomem + (REG_CORE_##reg) - REG_CORE_=
S_STATUS)
> > >
> > > +/* Per-SoC differences, selected by the of_device_id match data. */
> > > +struct rocket_soc_data {
> > > +     unsigned int num_clks;          /* clk_bulk count: 4 base, 6 wi=
th CBUF */
> > > +     unsigned int num_resets;        /* reset_bulk count: 2 base, 1 =
on RK3576 */
> > > +     bool multi_power_domain;        /* device spans more than one P=
M domain */
> > > +     bool poll_completion;           /* completion IRQ never reaches=
 the GIC */
> > > +};
> > > +
> > >  struct rocket_core {
> > >       struct device *dev;
> > >       struct rocket_device *rdev;
> > > +     const struct rocket_soc_data *soc;
> > >       unsigned int index;
> > >
> > >       int irq;
> > >       void __iomem *pc_iomem;
> > >       void __iomem *cna_iomem;
> > >       void __iomem *core_iomem;
> > > -     struct clk_bulk_data clks[4];
> > > +     struct clk_bulk_data clks[6];
> > >       struct reset_control_bulk_data resets[2];
> > >
> > >       struct iommu_group *iommu_group;
> > > @@ -52,6 +62,14 @@ struct rocket_core {
> > >               atomic_t pending;
> > >       } reset;
> > >
> > > +     struct hrtimer poll_timer;
> > > +     struct work_struct poll_work;
> > > +     atomic_t poll_active;
> > > +     unsigned int poll_ticks;
> > > +     unsigned int poll_seq;
> > > +     unsigned int poll_work_seq;
> > > +     bool poll_dying;
> > > +
> > >       struct drm_gpu_scheduler sched;
> > >       u64 fence_context;
> > >       u64 emit_seqno;
> > > diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/roc=
ket/rocket_device.c
> > > index 46e6ee1e7..bfb00f967 100644
> > > --- a/drivers/accel/rocket/rocket_device.c
> > > +++ b/drivers/accel/rocket/rocket_device.c
> > > @@ -31,6 +31,10 @@ struct rocket_device *rocket_device_init(struct pl=
atform_device *pdev,
> > >               if (of_device_is_available(core_node))
> > >                       num_cores++;
> > >
> > > +     for_each_compatible_node(core_node, NULL, "rockchip,rk3576-rknn=
-core")
> > > +             if (of_device_is_available(core_node))
> > > +                     num_cores++;
> > > +
> > >       rdev->cores =3D devm_kcalloc(dev, num_cores, sizeof(*rdev->core=
s), GFP_KERNEL);
> > >       if (!rdev->cores)
> > >               return ERR_PTR(-ENOMEM);
> > > diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket=
/rocket_drv.c
> > > index 8bbbce594..7f7dfa374 100644
> > > --- a/drivers/accel/rocket/rocket_drv.c
> > > +++ b/drivers/accel/rocket/rocket_drv.c
> > > @@ -176,6 +176,7 @@ static int rocket_probe(struct platform_device *p=
dev)
> > >
> > >       rdev->cores[core].rdev =3D rdev;
> > >       rdev->cores[core].dev =3D &pdev->dev;
> > > +     rdev->cores[core].soc =3D of_device_get_match_data(&pdev->dev);
> > >       rdev->cores[core].index =3D core;
> > >
> > >       rdev->num_cores++;
> > > @@ -213,8 +214,23 @@ static void rocket_remove(struct platform_device=
 *pdev)
> > >       }
> > >  }
> > >
> > > +static const struct rocket_soc_data rk3588_soc_data =3D {
> > > +     .num_clks =3D 4,
> > > +     .num_resets =3D 2,
> > > +     .multi_power_domain =3D false,
> > > +     .poll_completion =3D false,
> > > +};
> > > +
> > > +static const struct rocket_soc_data rk3576_soc_data =3D {
> > > +     .num_clks =3D 6,
> > > +     .num_resets =3D 1,
> > > +     .multi_power_domain =3D true,
> > > +     .poll_completion =3D true,
> > > +};
> > > +
> > >  static const struct of_device_id dt_match[] =3D {
> > > -     { .compatible =3D "rockchip,rk3588-rknn-core" },
> > > +     { .compatible =3D "rockchip,rk3588-rknn-core", .data =3D &rk358=
8_soc_data },
> > > +     { .compatible =3D "rockchip,rk3576-rknn-core", .data =3D &rk357=
6_soc_data },
> > >       {}
> > >  };
> > >  MODULE_DEVICE_TABLE(of, dt_match);
> > > @@ -240,7 +256,7 @@ static int rocket_device_runtime_resume(struct de=
vice *dev)
> > >       if (core < 0)
> > >               return -ENODEV;
> > >
> > > -     err =3D clk_bulk_prepare_enable(ARRAY_SIZE(rdev->cores[core].cl=
ks), rdev->cores[core].clks);
> > > +     err =3D clk_bulk_prepare_enable(rdev->cores[core].soc->num_clks=
, rdev->cores[core].clks);
> > >       if (err) {
> > >               dev_err(dev, "failed to enable (%d) clocks for core %d\=
n", err, core);
> > >               return err;
> > > @@ -260,7 +276,7 @@ static int rocket_device_runtime_suspend(struct d=
evice *dev)
> > >       if (!rocket_job_is_idle(&rdev->cores[core]))
> > >               return -EBUSY;
> > >
> > > -     clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks), =
rdev->cores[core].clks);
> > > +     clk_bulk_disable_unprepare(rdev->cores[core].soc->num_clks, rde=
v->cores[core].clks);
> > >
> > >       return 0;
> > >  }
> > > diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket=
/rocket_job.c
> > > index bb77b6bf0..28845ac4e 100644
> > > --- a/drivers/accel/rocket/rocket_job.c
> > > +++ b/drivers/accel/rocket/rocket_job.c
> > > @@ -7,6 +7,7 @@
> > >  #include <drm/drm_file.h>
> > >  #include <drm/drm_gem.h>
> > >  #include <drm/rocket_accel.h>
> > > +#include <linux/hrtimer.h>
> > >  #include <linux/interrupt.h>
> > >  #include <linux/overflow.h>
> > >  #include <linux/iommu.h>
> > > @@ -21,6 +22,15 @@
> > >
> > >  #define JOB_TIMEOUT_MS 500
> > >
> > > +/*
> > > + * RK3576 arms the same DPU completion as RK3588, but the interrupt =
never
> > > + * reaches the GIC. The completion itself is visible in INTERRUPT_RA=
W_STATUS,
> > > + * so sample that instead. The tick cap bounds jobs that never raise=
 it at all,
> > > + * which is the same open problem as the wrong inference results.
> > > + */
> > > +#define RK3576_POLL_INTERVAL_NS      1000000LL       /* 1 ms */
> > > +#define RK3576_POLL_MAX_TICKS        8
> > > +
> > >  static struct rocket_job *
> > >  to_rocket_job(struct drm_sched_job *sched_job)
> > >  {
> > > @@ -151,6 +161,14 @@ static void rocket_job_hw_submit(struct rocket_c=
ore *core, struct rocket_job *jo
> > >
> > >       rocket_pc_writel(core, OPERATION_ENABLE, PC_OPERATION_ENABLE_OP=
_EN(1));
> > >
> > > +     if (core->soc->poll_completion) {
> > > +             core->poll_ticks =3D 0;
> > > +             core->poll_seq++;
> > > +             atomic_set(&core->poll_active, 1);
> > > +             hrtimer_start(&core->poll_timer, ns_to_ktime(RK3576_POL=
L_INTERVAL_NS),
> > > +                           HRTIMER_MODE_REL);
> > > +     }
> > > +
> > >       dev_dbg(core->dev, "Submitted regcmd at 0x%llx to core %d", tas=
k->regcmd, core->index);
> > >  }
> > >
> > > @@ -341,25 +359,87 @@ static struct dma_fence *rocket_job_run(struct =
drm_sched_job *sched_job)
> > >       return ERR_PTR(ret);
> > >  }
> > >
> > > +static void rocket_job_handle_irq(struct rocket_core *core);
> > > +
> > > +static enum hrtimer_restart rocket_poll_timer_fn(struct hrtimer *tim=
er)
> > > +{
> > > +     struct rocket_core *core =3D container_of(timer, struct rocket_=
core, poll_timer);
> > > +     u32 raw;
> > > +
> > > +     if (!atomic_read(&core->poll_active))
> > > +             return HRTIMER_NORESTART;
> > > +
> > > +     core->poll_work_seq =3D core->poll_seq;
> > > +
> > > +     raw =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
> > > +     if ((raw & (PC_INTERRUPT_RAW_STATUS_DPU_0 | PC_INTERRUPT_RAW_ST=
ATUS_DPU_1)) ||
> > > +         ++core->poll_ticks >=3D RK3576_POLL_MAX_TICKS) {
> > > +             atomic_set(&core->poll_active, 0);
> > > +             schedule_work(&core->poll_work);
> > > +             return HRTIMER_NORESTART;
> > > +     }
> > > +
> > > +     hrtimer_forward_now(timer, ns_to_ktime(RK3576_POLL_INTERVAL_NS)=
);
> > > +     return HRTIMER_RESTART;
> > > +}
> > > +
> > > +/* Start the job's next task, or retire it. Caller holds job_lock. *=
/
> > > +static void rocket_job_next_locked(struct rocket_core *core)
> > > +{
> > > +     lockdep_assert_held(&core->job_lock);
> > > +
> > > +     if (!core->in_flight_job)
> > > +             return;
> > > +
> > > +     if (core->in_flight_job->next_task_idx < core->in_flight_job->t=
ask_count) {
> > > +             rocket_job_hw_submit(core, core->in_flight_job);
> > > +             return;
> > > +     }
> > > +
> > > +     iommu_detach_group(NULL, iommu_group_get(core->dev));
> > > +     dma_fence_signal(core->in_flight_job->done_fence);
> > > +     pm_runtime_put_autosuspend(core->dev);
> > > +     core->in_flight_job =3D NULL;
> > > +}
> > > +
> > > +static void rocket_poll_work_fn(struct work_struct *work)
> > > +{
> > > +     struct rocket_core *core =3D container_of(work, struct rocket_c=
ore, poll_work);
> > > +
> > > +     pm_runtime_mark_last_busy(core->dev);
> > > +
> > > +     scoped_guard(mutex, &core->job_lock) {
> > > +             /*
> > > +              * The interrupt can land while this work is queued, re=
tire the job
> > > +              * and start the next task. poll_seq only moves under j=
ob_lock, in
> > > +              * hw_submit, so comparing it here says whether that ha=
ppened. Doing
> > > +              * it outside the lock would leave the window open rath=
er than close
> > > +              * it, and this work would then submit a task on top of=
 a live one.
> > > +              */
> > > +             if (READ_ONCE(core->poll_dying) || core->poll_work_seq =
!=3D core->poll_seq)
> > > +                     return;
> > > +
> > > +             rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
> > > +             rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
> > > +
> > > +             rocket_job_next_locked(core);
> > > +     }
> > > +}
> > > +
> > >  static void rocket_job_handle_irq(struct rocket_core *core)
> > >  {
> > > +     if (core->soc->poll_completion) {
> > > +             atomic_set(&core->poll_active, 0);
> > > +             hrtimer_cancel(&core->poll_timer);
> > > +     }
> > > +
> > >       pm_runtime_mark_last_busy(core->dev);
> > >
> > >       rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
> > >       rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
> > >
> > >       scoped_guard(mutex, &core->job_lock)
> > > -             if (core->in_flight_job) {
> > > -                     if (core->in_flight_job->next_task_idx < core->=
in_flight_job->task_count) {
> > > -                             rocket_job_hw_submit(core, core->in_fli=
ght_job);
> > > -                             return;
> > > -                     }
> > > -
> > > -                     iommu_detach_group(NULL, iommu_group_get(core->=
dev));
> > > -                     dma_fence_signal(core->in_flight_job->done_fenc=
e);
> > > -                     pm_runtime_put_autosuspend(core->dev);
> > > -                     core->in_flight_job =3D NULL;
> > > -             }
> > > +             rocket_job_next_locked(core);
> > >  }
> > >
> > >  static void
> > > @@ -460,6 +540,10 @@ int rocket_job_init(struct rocket_core *core)
> > >       int ret;
> > >
> > >       INIT_WORK(&core->reset.work, rocket_reset_work);
> > > +     INIT_WORK(&core->poll_work, rocket_poll_work_fn);
> > > +     hrtimer_setup(&core->poll_timer, rocket_poll_timer_fn, CLOCK_MO=
NOTONIC,
> > > +                   HRTIMER_MODE_REL);
> > > +     atomic_set(&core->poll_active, 0);
> > >       spin_lock_init(&core->fence_lock);
> > >       mutex_init(&core->job_lock);
> > >
> > > @@ -501,8 +585,23 @@ int rocket_job_init(struct rocket_core *core)
> > >
> > >  void rocket_job_fini(struct rocket_core *core)
> > >  {
> > > +     /*
> > > +      * Stop the poll from starting hardware work before tearing any=
thing
> > > +      * down: it submits the next task, and drm_sched_fini() does no=
t wait
> > > +      * for work already queued. Cancel after the scheduler is gone,=
 so a
> > > +      * job running now cannot re-arm the timer behind the cancel.
> > > +      */
> > > +     if (core->soc->poll_completion)
> > > +             WRITE_ONCE(core->poll_dying, true);
> > > +
> > >       drm_sched_fini(&core->sched);
> > >
> > > +     if (core->soc->poll_completion) {
> > > +             atomic_set(&core->poll_active, 0);
> > > +             hrtimer_cancel(&core->poll_timer);
> > > +             cancel_work_sync(&core->poll_work);
> > > +     }
> > > +
> > >       cancel_work_sync(&core->reset.work);
> > >       destroy_workqueue(core->reset.wq);
> > >  }
> >
