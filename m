Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793796987;
	b=2KS2tEHH9EwNCOJgQdH+HglVlBjIcu/GpjFAK69XKw1s1ZuvMJVPboin7viGsOVABNDU
	 6M7pCfPVRgKwloh5rRHYtNDpsie/MvgTkGM+w+PigBqWlD5VHQgy1IMlyU0wA0D5b5WPf
	 yTpM7gvrJpN2McC/IIXliIlkYN5Rdcm/lwT2o9kxPzQXrefsJwionc5GrfMD9KV5Pxddr
	 KVntfV17EsM4j3u/5yYIfv8ILxPiB3wACL9bLQ1rFplCppL1h9qPOloTJwnJLOPFdGHGt
	 ERciWRU2fQb2KiMEQSFDWWZCm+WejP4J0z2yRpW05bYiPqCzWmqzhWQTYcwPIDvh3EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=a3viuefWVHlkOcjcyLognlTI0g9S7LK7g5mw2hwAeX8=;
	b=RnFw9Gs+EptlUIFhh6FLHISugx3wyOhITe1L+3D/c1IaYxT15FlSGkXyWSYO8spzTzJA
	 yEEFUTdbYrD/vmZpwbyyETY2P17yfNk5S8AzGI4o2wsi9Ol9BL8mymzJAzxwrcRP6nAb+
	 JYPiMF+GHJelekpbfOSkHOpHa5Ku1pZSlNOzGu1LHrwMos1+v1E8iiX6yvYX7znfVEfD1
	 /nDrm49v+rcfXFoFr3BpRlK6faZBuvxUg/K+ihnb9olr1So7Fzr406zTIil9GHMkridO/
	 75OfYYaDwwFzfZvncqqPgPMtGFLlEaWoN2DTVpPU9OqvivWP3z5QGEGgFIeuWd+XICg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tomeuvizoso.net;
	spf=pass smtp.mailfrom=tomeuvizoso.net;
	dkim=pass header.d=tomeuvizoso-net.20260707.gappssmtp.com header.i=@tomeuvizoso-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LLdxJpRs;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A839F606A32F
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 12:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A839F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tomeuvizoso-net.20260707.gappssmtp.com header.i=@tomeuvizoso-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LLdxJpRs
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso4022645e9.0
        for <iommu@lists.linux.dev>; Wed, 04 Nov 2026 04:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20260707.gappssmtp.com; s=20260707; t=1793796984; x=1794401784; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a3viuefWVHlkOcjcyLognlTI0g9S7LK7g5mw2hwAeX8=;
        b=LLdxJpRs2dmfAPaW3yBhOAkiVDx3HsL6M7UYqIyf9m3y11s/ABLeqA8zvUpGkzBwLg
         KjmpMsnfmlhI/0n3RIMNTMSwhUicsltHAUDY6Tzx/7lShnbxldfGgT6PrU5uHDsKi8bj
         x44AWUK4d0bFKDaJrm2g/kjt52ee/AOsHW3/jG5NrOgIQLgBdu7If0wdmUAhDGDNAP21
         fWNKp1tsUJtieBSmzOznu71SYHuNA8DhuXkrXyYF1vPaHmjNug1gbaIZx+7g2BQVkeUZ
         +BI7sNxTIn3xoc/uCQd5zgIgpdRo8BktUEifvje3xruhYTfyW5HfoJAg0vOYGVcB1zrn
         ydxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793796984; x=1794401784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a3viuefWVHlkOcjcyLognlTI0g9S7LK7g5mw2hwAeX8=;
        b=L0KS0TwlPWAKGOI+pVIoJlOdye8hkWPYXpNELn006Ru963lKetVoqKZymE7NQIsI99
         8MtufT1+feSn6idoUrkG68w5OSyciiAJTbp2W5O7xVZwJ32F2bQ7IE34A3ybqSz5m7iR
         qzqW80H5xYy97rNAtwbWzd8YMwkrxQuiNjBxyz76lk4GlK2NMFV7+uCN+CFuH8hBpRig
         ilxWzCYs46l2RW04H2D9GSc224YCilyN1DYeCdNgT7cPa/yBwwHFBTxCZV7wSjkQFTsm
         WCDhqCKTYUUjUw8gSfTayX9E45G6FeYQ6gAlqRc9x5iNoOS6q6KHAOB3S+AHhAC+vIPy
         dgCw==
X-Forwarded-Encrypted: i=1; AKwUvBzZQGcpe0DfVejX7i39lZFdE52O5PfQlTc7Eiya5mS5Vr23DUX8/8T4LfAodxziA3pEPs33ug==@lists.linux.dev
X-Gm-Message-State: APuU4Z8yHbgZ8zVVWkmBUR2qfa8A7JgzuomXOIhQJ5LTOC53ms+qKoFb
	g0N+dpezvWxXQcD5qZNU6A9xxRU+7HSMz6bRPeCYdce/NWtLcH+7+R7Obn5tzG1Fy1w=
X-Gm-Gg: AYBFou0bSdjJZqLb0l9aITo21oFUgpXsqOlvx1EtZ90e2XTuK49N1p3e0ClkZUu4Fd9
	3OM9fWYFS0SxXKNUojgtXtAYgz45oZMKuPjH36ckLfKDOmwf6p1tsMBM1aoQjvHKScF/DTpbD1l
	5JeMHLujk6QnqGOhCg1stO30SYB8H1MxwlGsGnbt3MklNG4r1ifOFSjbxWKpbAsyxxDtxWVqAMz
	RgU+xWLnSyOPiMYzDuVYRSqjoB5AQyZ9wub4RV6WYzztvIqqnHEX4GI3jsFIzVq/45IGe/skKLY
	E1CufISuYeYCZwDI7hSJRujPE2rL3q0PW+n+FgKRHgnuFEmp5JotCHc36IspFBq8NCi6De6g8Y7
	uyCvGgLUoNZs9FWna79QjdQ67wfHE/jTTrNsbIqg53WcXcFp29feXj+GOkZBnqGHCvUe1EiLbwI
	PFe+SdQYFWJIH0Ig4gAs7/I5mCQQCRoa2tffnOpG+iydiRnmgKbwBn+vAU/hXogppP70H6n7Ia2
	d6glC58uL7TYDrIVwuOO0x/LXwrQ7NVH9QJLLJzXNUZjRADasj2QVqjHKPmB78ndIHiTHep0p6t
	YsQkdRnqR7P0YEEyQRAVf5oGGeny8kiE7B+HUwR/XswDWF2/K9jr6n3LLOW1ryKjEYmQfshKprp
	shC3jm+IBHK9s7S9lWOHJstpm744T34oIk/F5Dy8tP4XD1UzFJyWRAcWwNlCua+V1bqKUjyg=
X-Received: by 2002:a05:600c:1d28:b0:4a2:1612:637a with SMTP id 5b1f17b1804b1-4ac1793fb6bmr425311395e9.16.1793796983815;
        Wed, 04 Nov 2026 04:56:23 -0800 (PST)
Received: from alcachofa.home (cst-prg-36-190.cust.vodafone.cz. [46.135.36.190])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda20935sm3705844f8f.54.2026.11.04.04.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 04:56:23 -0800 (PST)
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com,
	royalnet026@gmail.com,
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	sidong.yang@furiosa.ai,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	leonard@lausen.nl,
	jeff.hugo@oss.qualcomm.com,
	rfoss@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 03/15] accel/rocket: wait for a running IRQ handler before resetting a core
Date: Wed,  4 Nov 2026 13:55:18 +0100
Message-ID: <20261104125529.3229301-1-tomeu@tomeuvizoso.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261101082307.151957-4-gahing@gahingwoo.com>
References: <20261101082307.151957-4-gahing@gahingwoo.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Nov 01, 2026 at 09:22 PM, Jiaxing Hu <gahing@gahingwoo.com> wrote:
> drm_sched_stop() does not wait for a threaded handler that is already
> running. Call synchronize_irq() after it, outside job_lock, which the
> handler takes.
>
> Before the sync, mask the block's interrupt and clear its raw status, so
> that an active core cannot signal a completion after it. Do that under
> job_lock, since rocket_job_hw_submit() arms the same mask under that lock,
> and only when pm_runtime_get_if_active() returns a positive count: the
> reset holds no runtime PM reference, and with the domain down a register
> access takes an async SError.

The above I understand.

> Igor Paunovic's induced-reset runs on RK3588, including a two-task job that
> puts hw_submit() on the IRQ thread, found no fault; as he put it, "this
> does not show the race is closed".

This is completely out of context for a commit message. How is somebody who is
reading git log know who Igor is, and what his "induced-reset" is?

> Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail.com/
> Link: https://lore.kernel.org/all/CAEWPSH5mxTbUkNouxm6yecMZYvDowquhvYvhaXQ8HoMtHD5U1g@mail.gmail.com/
> Link: https://lore.kernel.org/all/20260912113717.6819-1-royalnet026@gmail.com/
> Link: https://lore.kernel.org/all/20260916132824.13527-1-royalnet026@gmail.com/
> Link: https://lore.kernel.org/all/20260919103422.148834-1-royalnet026@gmail.com/
> Suggested-by: Igor Paunovic <royalnet026@gmail.com>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2
> ---
>  drivers/accel/rocket/rocket_job.c | 71 +++++++++++++++++++++++++++++--
>  1 file changed, 68 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
> index 03e5f094f60b..5b2abf40b618 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -401,9 +401,74 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
>  	drm_sched_stop(&core->sched, bad);
>  
>  	/*
> -	 * Remaining interrupts have been handled, but we might still have
> -	 * stuck jobs. Let's make sure the PM counters stay balanced by
> -	 * manually calling pm_runtime_put_noidle().
> +	 * Mask the block before waiting. hw_submit() arms INTERRUPT_MASK on
> +	 * every submit and only the hardirq clears it, so on an ordinary
> +	 * timeout it is still live and a completion can arrive after the sync
> +	 * returns. The next submit re-arms it, so nothing is lost here.
> +	 *
> +	 * Only when the device is already awake, though. This function holds no
> +	 * runtime PM reference of its own: the only one in the window belongs to
> +	 * in_flight_job, and the completion path may have put it and cleared the
> +	 * pointer before the timeout worker got here. drm_sched_stop() above can
> +	 * block for a long time, and it drops every pending job's credits, so
> +	 * rocket_job_is_idle() is true and nothing keeps the core resumed. On
> +	 * this hardware a register access with the domain down takes an async
> +	 * SError, so a reset must not be the thing that causes one.
> +	 *
> +	 * Only a positive answer will do. pm_runtime_get_if_active() tests
> +	 * power.disable_depth before power.runtime_status, so -EINVAL MASKS a
> +	 * suspended device rather than excluding one: pm_runtime_force_suspend(),
> +	 * which is this driver's own system suspend callback, disables runtime PM
> +	 * first and turns the clocks off second, and rocket_core_fini() suspends
> +	 * the core and disables before it cancels the timeout worker. Both leave
> +	 * the domain down with -EINVAL on offer.
> +	 *
> +	 * The cost is the other half of that ambiguity. A core that is still up
> +	 * with runtime PM disabled (pm_runtime_force_suspend() before its
> +	 * callback has run, or CONFIG_PM=n under COMPILE_TEST) is left unmasked,
> +	 * because writing to it would mean writing to the half that is down as
> +	 * well.
> +	 *
> +	 * Clear the raw status along with the mask, the way the completion path
> +	 * does. Masking alone leaves the DPU bit latched until
> +	 * rocket_core_reset(), and the hardirq decides on raw status alone, so a
> +	 * fault from the IOMMU that shares this line would wake the thread again
> +	 * and what the comment below asserts would stop being true.
> +	 *
> +	 * UNDER job_lock, because rocket_job_hw_submit() arms this same
> +	 * register and always runs under that lock. reset.pending is set here
> +	 * without the lock and read there with it, so a submit that has already
> +	 * passed its check can re-arm the mask after this clears it, and then
> +	 * the synchronize_irq() below fences a handler that is no longer the
> +	 * one that matters: the block is left running a task with its
> +	 * interrupt live. rocket_job_handle_irq() avoids the same race on
> +	 * OPERATION_ENABLE by making its completion writes under this lock.
> +	 *
> +	 * pm_runtime_get_if_active() does not invoke a callback -- it only
> +	 * takes a reference on an already-active device -- and
> +	 * pm_runtime_put_autosuspend() is asynchronous, so neither can re-enter
> +	 * this driver's runtime PM callbacks while the lock is held.
> +	 */

This is just absurd. The driver will quickly become unmaintainable if we merge
this kind of comments. 

Please remove all LLM-generated text (cover letter, commit messages, and code
comments) from the accel/rocket patches in this series, and replace it with
your own.  I don't mind if you write it first in your native language and use a
LLM to translate it to english, but I need for you to understand the code you
submit and write yourself any communication with humans.

If you don't understand anything in the code well enough to write the commit
messages, cover letter and comments, then I suggest you use the LLM to assist
you in acquiring the knowledge that you are missing.

Also, please read:

Documentation/process/coding-assistants.rst
Documentation/process/generated-content.rst

Thanks,

Tomeu

