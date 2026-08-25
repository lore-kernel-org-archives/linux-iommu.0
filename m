Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F131430CD9
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661145; cv=pass; b=WDElCDqSHVHFgdOpLArVRWlno7NTPT8Fdji9H3LEy3i30YFCat2nMv9y8d19UhTqBqvRCpsAZRbSWBNR1n4wyM19qAQlT1LpvEZ2dJuPHPFiCUVOUudbOgn0MZva7P4RgFAcbS9/fl96GAi3Y8UOwicmLFrs3Xu8D0iAeJzYFU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661145; c=relaxed/simple;
	bh=YnBg80Q6tdwJGKBmxQ6+aA3hP7hvRLocxQztM7gBv+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQ/yYSiqGJM/A84ewZz21tbl77LeQG8uGNM4llccmvZvyIVISk2ke1869VHRNrSOP60Fv0lgoY7XrQ6ohfF9dOmOGvuIuiCMu1WvEYYJXf1qoH0B9E9Zn2Ld/tTQi8OCsLOgT8pwEPvZ0wFos5A0jvO+UAfsTOyikDq89Rh3mQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+CdvjyK; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+CdvjyK"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-85569d3a6f7so199557b3.3
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 05:32:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787661138; cv=none;
        d=google.com; s=arc-20260327;
        b=TKzzEWNIEanlJXWXceDRPkXPlLmxT6+r+JOHC79OKnFv1CFJw5kybDzgSdbmiyVAnq
         dpR7ZZsz2ar2NAtMIsjjdDdbCrGsN0kTR4NMt+5FjWsda5X32W0Hb7/w86ya3FN6AnDv
         QIY+xHdGadb9FKe78TW+h3IntWu/cUcJCyErsrqtm04W17DQsAmo7yIhp1J8/BlulaYx
         roYvyKoOA7bAjIjxZ9a++2p5bD5yc1BPDozt4MkWiczCWqSjyhuCjBHcPb51f8kl3hB8
         3Z3SeczfRTNvHAdQdljXuxoJD3Yl+FB/0nY5CMPH3ia/DUYR0FdbeXutgNKl2Ybgi/7e
         pEcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yC0ABnqL3afPD/T9bA9JOpYrNE4Kd3K+0Xw3e1dg3hQ=;
        fh=AN0G3Va78HeUxU3f0Bj5zwxZRwVpx2uE3OB+J29ra+U=;
        b=RabPalACMTziXkEG4seD1WqPIWJNCZ+4KSyHK+Xj4QMxI4SCrRNVYJNYMb6gX4O32v
         eqxH8aWyA7aCvWy+khvj/L1/23exs4IjEUtzoynLU/HisBMQfGXSLuDa/+i2QRctUcaK
         zPYUS9jf1+MIcqtnx/jYXAKhvIwnQjhtMwPJlXchQgW0nA1kLpJ4MVlvK4eVaXdDcrxh
         16X3g34envqvlIP9QKMS7WPGMZgs5aV/LlFBKXg8PMiXI9i61mCXIbF0ptUu81r4GE74
         wr/g498ytu+TpG9VmI0OSbeEYEQM51zpGMcUugftSifbAKubHd0l4Bu8Ur2ExrTW0W4p
         81lA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787661138; x=1788265938; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yC0ABnqL3afPD/T9bA9JOpYrNE4Kd3K+0Xw3e1dg3hQ=;
        b=d+CdvjyKmNCESaV3TkG5IGmSe3Cjfhpx3XHEJD3xr3xmgyz+duCXsRzvb8i07qIvUj
         h2jDk/ExUr7RDBBYHl3jV/W+YlfJ3r7ZkS231CWV7Yvu4KujLdKZIbeJGmkf7yIEG7wn
         knJKzqVJVzi7HXByLP0OeFucrtVTi7eqEKIU2adSfzpFAaL2kGOOOlBdoKz6aAb7qY/G
         zbq6BwJBu0X0YmI05Eg5DYg5Vi+FdP1fKVQ4KSabj8apvZiDilo+Ijkkm/12zNNpI4RA
         hVSjg5wYi3cz7y906MM8okx/mf850NSWWjphfJkBKO4wztforpc7B3UQVaCsEThaSU7W
         xAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787661138; x=1788265938;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yC0ABnqL3afPD/T9bA9JOpYrNE4Kd3K+0Xw3e1dg3hQ=;
        b=Z6O4C6x+H6Loz50G6h5BInsnB5PKzbFSr1OfBu9ADHM4VG/D7WW3acZxVeq7T+pJBu
         7bhZh/WX89zbs5tdBIxGHt3J8f/jBkHt+hE3T7RbRU5KiIdeDzi8UtOZRC1LIGtaIIgQ
         +6Q8pra8H867RBTcPe1V9nlhaiOY3Jg5sP24dt3l9FJYQIh4yUNtQS+daVMnWgFicwnQ
         MDQxKzpbcNP5aAKh+15QYanNG7MGfcRVMTG5W5cUPt0yA/eO3tmDbLxWLqsywhEPORW0
         XSYAEZQHw8f2Y7ToL/qzxUS5I1nxco8zT95ikZahru6g/Iu87xz2gL7Mg7AN5UDF1MzM
         ycvA==
X-Forwarded-Encrypted: i=1; AHgh+RpK/U8RJtNzSAegoLpiyU1xIQifkrwLeODwwYiY837D+W5Mo/MRCAAaSiIMFSZtl/ihvVsBBQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lwXiAcxYZm4xZp5uSmMjmTy3LLgQ/BhnWP7DTdUWcbSP6rEt42
	7hlTgymLxM4g8kG42GLGvcJUrLbTdxoAlnNgSI3kOpMR1+ugfaRB2Vf9iERk6R/qT+ssNuGpPM9
	fPou199xY92ejphfrzBT2JRWaik0CJXE=
X-Gm-Gg: AR+sD10ar2dpFfgkQ4P7a9I8V8I/+6gdl0SaLjJNrqLiOC/q2SiR+BQjhqpJ7pDg1su
	Ik0DP2vQZJ0M3zzilR1KHRqBlOpAHXvSezKfeItBgGTIsHJDC55qvxIFGggSamPmw1P58Pf62LN
	tCkq+2I7CkACtXSKJbcJWnWzaK+wQn8EtqO/oYiuGui9m75XEPpiEQAlOUICPza8B9qFF0hBxDN
	PQLfBieo5vUsJZ28IQTI6pD1928oz0lyTrmkpv07gKaMh23kmyJq7aV3QwbsytT/mJ3gP5RLcdf
	vBJdTDesDbV9QDSB+14jp9JtJLne8mdcMKQlBJQQRrNBbav+U7y885s1
X-Received: by 2002:a05:690c:6e01:b0:80b:d006:6436 with SMTP id
 00721157ae682-854c6f01138mr19294437b3.4.1787661138041; Tue, 25 Aug 2026
 05:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
 <b5265e47492897d0ada844c2ff7f477bb715cd07.1787568944.git.gahing@gahingwoo.com>
In-Reply-To: <b5265e47492897d0ada844c2ff7f477bb715cd07.1787568944.git.gahing@gahingwoo.com>
From: Igor Paunovic <royalnet026@gmail.com>
Date: Tue, 25 Aug 2026 14:32:06 +0200
X-Gm-Features: AcwNN1V1tG9pfMaEZxfyNcf1kB3QFf3O-ye-4Ztbjbyn2rv0eJ21NSEcDStkJdA
Message-ID: <CAEWPSH5MVzoQMaFOEQ93+1pOPmcXCDNfuXsv5j-X8Lb1fy_hrg@mail.gmail.com>
Subject: Re: [PATCH v9 03/13] accel/rocket: let the core suspend after a reset
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de, 
	ogabbay@kernel.org, zhangqing@rock-chips.com, u.kleine-koenig@baylibre.com, 
	chaoyi.chen@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net, 
	dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
	iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiaxing,

On top of the as-is protocol re-run I reported on 2/13, I ran
one more arm with this patch added on top of 1/13 and 2/13,
same machine, same tree, same config, same JOB_TIMEOUT_MS=3D2.

Two passes (console_loglevel 8 and 4), 13 and 13 induced
resets, all recovered, oracle 48/48 throughout, including after
a forced autosuspend and resume.

The behavioural change is visible on RK3588. On the 1+2 arm, a
round that ends in a timeout leaves the affected core
runtime-active even through a forced autosuspend - the leak
from my earlier report. With this patch applied the same
sequence leaves all three cores suspended, and the next
inference still scores 48/48.

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three
cores, induced reset, JOB_TIMEOUT_MS=3D2

Regards,
Igor

On Mon, Aug 24, 2026 at 1:09=E2=80=AFPM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> rocket_reset() drops the in-flight job's runtime PM reference with
> pm_runtime_put_noidle(), a bare decrement that requests nothing. The core
> is left at usage_count 0 but still runtime-active with no idle request
> pending, so it does not suspend until something else asks, and on a
> platform whose power domain does work on power-on that work never happens=
.
>
> On RK3576 that work is a bus interface reset the domain cycles when it
> comes up. Without it the NPU's IOMMU stops answering, and the job after a
> timeout returns a surface of the output zero point with rk_iommu reportin=
g
> that MMU_DTE_ADDR is not functioning.
>
> Measured on a ROCK 4D in one boot, three runs, one variable between them.
> With the bare put the core reads runtime-active with its rail still up
> after the reset, the IOMMU reports the failure on the next attach and the
> inference returns 0 of 128 channels. With the reference put back through
> pm_runtime_put_autosuspend() the core reads suspended with the rail down,
> there is no IOMMU message, and the same inference returns 128 of 128. A
> third run repeating the first failed the same way.
>
> It also matches the put in the completion path a few lines away, so the
> reset path no longer leaves the device in a state the rest of the driver
> never produces. The remaining put, on the error path in rocket_job_run(),
> is a plain pm_runtime_put() and is left alone here: it unwinds a
> get_sync() that never reached the hardware, and changing it belongs in
> its own patch.
>
> Igor Paunovic ran the differential on RK3588: 45 induced resets across
> three cores, with and without the two preceding patches, and the domain
> dropped every single time with no MMU message on either kernel. So this
> is not rocket-wide. His conditions cross a healthy block with a lowered
> timeout rather than a hung one, which he was careful to say his protocol
> cannot settle, but it is what scopes the change to RK3576.
>
> Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail=
.com/
> Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  drivers/accel/rocket/rocket_job.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 3c0ed4605..a89ab49e1 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -406,12 +406,12 @@ rocket_reset(struct rocket_core *core, struct drm_s=
ched_job *bad)
>
>         /*
>          * No handler is running now, but we might still have stuck jobs.=
 Let's
> -        * make sure the PM counters stay balanced by manually calling
> -        * pm_runtime_put_noidle().
> +        * make sure the PM counters stay balanced by putting the referen=
ce the
> +        * job took, and request idle while doing it so the core can susp=
end.
>          */
>         scoped_guard(mutex, &core->job_lock) {
>                 if (core->in_flight_job)
> -                       pm_runtime_put_noidle(core->dev);
> +                       pm_runtime_put_autosuspend(core->dev);
>
>                 iommu_detach_group(NULL, core->iommu_group);
>
> --
> 2.43.0
>
