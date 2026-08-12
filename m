Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B51349B19
	for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538901; cv=none; b=qG2lGuEHlX0I5ImgwPgTpnOrVu6393StR8Pk0RBd3le0A0mOiaj2glo8Db28Q5ZzaSuGNbg7vz2tpgoqokpER7r58NMfK2vUmqYoslurbXlFx0LichinyEQVpw4qLmjeDxvGlrmr760+WhCreLIBGeUSnhIfLTlPjd8373NCcxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538901; c=relaxed/simple;
	bh=hrHpK9mBn1HScEdTgQmCNJRC9EOtR2zYokI33zINgoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKbHvYKM+GKBQwWJojKmpozDBb7eUfHy5WNIgmdxb4LwtIu9tK4aM7lKYeWoEPXx66GXeXXY8Sdqy1wxc17CoO7fH2LEGUYBZL8st4Y67cIaxtn1zeUntytZ6NxjNY/9rwQgyd2dvqEoGfXV61cGWPbVHhNiOKg6gZe5ghzkADw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIgIbDfV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIgIbDfV"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4995df974b3so481265e9.0
        for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 05:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786538897; x=1787143697; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eTo9zPlaH3flPDssEgbhBqafK8pdC58gZr52aUiEgTc=;
        b=AIgIbDfVqnL3GoXK4uQZV/cCw84oUsyZ6CDUt1V0oeovDH24plcW2xU+6zk9xLVVEk
         V+u5l+TnZUx0kjAsLjpf4LEFLMWru7putm7ntUZBznn75J57oMIkB/sCbbvW7xSj1bI2
         KnDWaxq9+aFGEtlplYzyukrofKv7Bz9y2IeK6Vn/V2lxhPthoLTcIDATPLyGx8Cu9h5I
         JbzDaCSzhTNpJuHkrhrq4xqfdI6yBP73priduCJU0iCNxh1QbduEDzuttObxXpSI9VFW
         qUALKZ7lQSFigQAN1d7QyuPI++Z1Jrqh+Kkp0kG/nwLTPRtPgHme9/iF62nsXh8CEJjX
         U3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786538897; x=1787143697;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eTo9zPlaH3flPDssEgbhBqafK8pdC58gZr52aUiEgTc=;
        b=fcIutTkvUytg3vYN0tRsAfLpKZ3QL7M0Kd/rDRZc+GtvJdKyHT4K32ydeO5Dfk8Azv
         IMn8HPgIz7Nf/xcxq4UNSFvW+NimvudPKRZ2g1NAsLGLdBQ1tORwWp8d8AA2QzsL+XQv
         d6wZqDO3lXIXiKfcxJH2EOtScZkmtMzX/7G4u77dHVNYXztUkJ7fpd7jx46kIQYoRnlo
         UV2KeyHyo5gPuYYryEgjXOma7e+2zmjyjdA0DM/3rbbEoUfWlFtyAhbe3C6/BkfKST8m
         +7lSWJcq/pRbuBB1pC8ljoJENr+5pKE7JpSsbmZcCLHfbeUt9k3zAxtWWTIyAbqkY3ej
         j7gw==
X-Forwarded-Encrypted: i=1; AHgh+RpRFO1kgGhHATYAo5+BKvV0OqVZmWKvbJdya3Mc55s54FoQoREuwyTQntRN9RsoIcxtZyK+PA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuLP762D7h8uAOsy8MIbosGoV/+BzF1kq+JQsV4jFlo9tYUtF3
	xlXtwZc/uL2VzfdStCYLR5u+8L3sbOio7sP5w5GFP2bYjlzbPHzGPGxH
X-Gm-Gg: AR+sD102xI6aD1IbzHD0A3kb/Nt3RlHNAlJGEiXTcD28LZpAnQehIJ2lbtDBmXuSejE
	ESirVYrsbN6r4E5atO+Lxm35hN8/Uqxcu4qxIROQWiNS4fDQk0cyO8Vw9fylGOl6N6Nb+hy4E+i
	uHObe61xkLDG/xOjXI3YwdqGx88j2vMuEt6oPzMx7ERoAkA5Uy/0wpJMu+reuY/yzBpRWDwl8QS
	Twaqn0g46+gC+qREAcriogYQoRxeEZVXOe0g0qIfG6Pm9rwmgf3nfcYLlGGqEaoI8FEVtAfas1V
	sVw2UVFItJ8YleW6tGegbN9MAnRQ3epdPM6GxqBYLLTDK/OJZoYxijSAbRTzqMtej6cbU4pngJ5
	PuYuJzFNGip4vbU19Bf+EC8EQRVKhkqXmCDNOBgAoHuX2WAEDBFOh9EOH9BgoUVqMjVdabBa6ag
	ebC2MRRdkr6XFwqMHmZS3gX7bEqUV1LRF9uYlRiyXxYPraYvYoJgQjmiuGvUdz40NKytgYycQE6
	XuH8rUSb9onnqcr982Qq1bQu6DhVyNBFm5CHxIRyiEQ7Z8lNXAcC1AfaK7dFZ8S0/Yh
X-Received: by 2002:a05:600c:4688:b0:498:8e6:d463 with SMTP id 5b1f17b1804b1-4997c0ddd6amr30132445e9.1.1786538897096;
        Wed, 12 Aug 2026 05:48:17 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME (20014C4E1B84A6001A34C2DD5D9E0419.dsl.pool.telekom.hu. [2001:4c4e:1b84:a600:1a34:c2dd:5d9e:419])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997c98ce0bsm47612095e9.11.2026.08.12.05.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 05:48:16 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>,
	tomeu@tomeuvizoso.net,
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
	zhangqing@rock-chips.com
Cc: Igor Paunovic <royalnet026@gmail.com>,
	alchark@flipper.net,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/10] accel/rocket: take the completion register writes under job_lock
Date: Wed, 12 Aug 2026 14:47:52 +0200
Message-ID: <20260812124755.6507-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812094106.1391698-2-gahing@gahingwoo.com>
References: <20260812094106.1391698-1-gahing@gahingwoo.com> <20260812094106.1391698-2-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores

I ran this on an Orange Pi 5 Plus across all three NPU cores, against a
base without the series. Both modules were built the same way and
neither carried any local DVFS work.

  base:  v7.2 rocket
         + Guangshuo Li's "clear rdev on device init failure"
         + my "request the core clocks by name" v2
         + my lifecycle v2 1/2 and 2/2
  test:  the same, plus 1/10, 7/10 and 8/10 from this series

Six phases per module: all three cores bound; core 2 unbound and
rebound; core 0 unbound and rebound; all three unbound and all three
rebound. One MobileNet V1 run per phase through the Teflon delegate.
The oracle is the sha256 of the tensors that both change between
different inputs and stay stable across repeats, so a stale output
buffer cannot pass as a recomputation.

                          base    this series
    three cores           89.3       90.0   inf/s
    core 2 unbound        87.6       88.8
    core 2 rebound        88.9       88.2
    core 0 unbound        75.3       75.0
    core 0 rebound        88.6       88.4
    all three cycled      88.7       88.3

All twelve runs produce identical oracle hashes and the same
classification. Interrupts per inference are 42.75 in both, and the
distribution matches phase for phase: with core 0 bound it takes 41.7
of them and core 1 takes 1.02; with core 0 unbound the same work moves
to core 1. Neither round logged anything beyond the probe messages.

That comes to 2596 inferences and 111048 completion interrupts through
rocket_job_handle_irq() with the two writes moved under job_lock, with
no difference in result from the same count without them.

On the change itself: I could not construct the race on the normal
path. The scheduler runs one job at a time and the fence is signalled
under the same lock after the writes, so a submit cannot overlap the
completion it follows.

Where I think it is reachable is the reset path. rocket_reset() calls
drm_sched_stop() and then says "Remaining interrupts have been
handled", but drm_sched_stop() stops the scheduler, not the threaded
IRQ handler. A handler already in flight can therefore run alongside
rocket_reset(), and after drm_sched_start() alongside a fresh job.
Making the write and the decision one step is the right shape for
that. It does not stop a late handler from writing the zero into a job
that is not the one whose interrupt it is handling, though - would a
synchronize_irq(core->irq) before the guard in rocket_reset() be worth
having as well?

One note on the base, since it matters to anyone repeating this. The
core-0 rebind step needs my lifecycle series underneath. Without it,
that rebind hands the returning core the index of a core that is still
live: the driver prints "core 2" for fdab0000.npu, inference starts
returning a different answer, and the teardown that follows dies in
destroy_workqueue() under drm_sched_fini() with a poisoned list
pointer, leaving an unkillable D state. None of that is your series
doing - it reproduces with 1/10, 7/10 and 8/10 absent - but it does
mean the three-core test cannot run to completion on a tree without it.

Igor
