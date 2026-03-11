Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C8B31F9BD
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194858; cv=pass; b=DLJhZg1vEa9FE1srKAyKxWb9hp276YWNrquSTgYzaODrr0zY3mf3IDl6ccFgvoBlCPYy2ZVw3+lBTwnAoO4Mh11t9Q4svWOg8NKiIwSazkr0/AiMuQnhCBArYPSqu3e4crZIxB7VUUUYAYV0lblzMiL8JoJNurbm6I/ZHeNlIVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194858; c=relaxed/simple;
	bh=8UJnLa/DDQ+b65RDSHa97nR/Rm6zetnRjswOkVb13wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snJuYo3fqbl8fSS2MTeR2h0QCBqMI4PFpTX0JXMSxpU3yQotrOwLb6sBbfeFpFtoCHlCWb1Fi5/bYUGBNRhcPIlWrNItXe1NU3/Wm2hZE9SuL2+wHkY0gAqfj/rAf6ocZ+INmUrmV04ZsVUvVl9Mi5hiDnaVe97L1v4YUpKnblE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G46rxFFc; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G46rxFFc"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so8038073e87.0
        for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 19:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773194852; cv=none;
        d=google.com; s=arc-20240605;
        b=lsm+xjgqoAAugacaWePY21SAqrFIsMeqdPwOaO87PAT4TuwI/ZD3KmPSK3w0fVUDtv
         F7LCJ2IMiCtUvtN/QFGXTr45nTKVhCr8U7EKwpcg5Dk5O0ORS3i/Oq5WrJcJHiHLmXs9
         9kdtM9jv+Z9p2fHvInCCCAk8EphhHNtZ8j2SNAXkGnDUKJC0HpkYkTuc0vk2c9VpeTPc
         8NcAvGSxqeKGiuWOfRqf9g3GE4GO73s9Nntz+yu9DQu+VMPFFKpQlqrXoYlvHuccEzPO
         4D11TLSBLS9wWD/y0APf9V7lFTS9ZjAyUGytZxmGcGcKXBKiN2BV06iT4ueFHX1T3hH7
         pPWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
        fh=EMcjOLNnTxzzmVPRkn94PcZJHLk4oYO1BRucPnWoTw8=;
        b=FUa/F3JTvZAPUiaCEir0pKuWuinlnMc/v8ztQ9qi7/g6LOJDJq5dceA0bTBjRq5sFY
         CgfD44CGIFoAeEU8k+hOTHDQii0Dg1JJQTKb1f9kMa+aJaXTqRLVo0S4TDTq+Zi/nHez
         bgLXHfkY0r2um5O3I41HesH608KTf8cty8Pg2905NfObJFp0tBZIS4QVtCe4CabylbxY
         WTHBpkGz6aC6iTr/Sksap0lx2feRDEsVoQmS7bznkI/KVXsVDRblv1U0v94YjojlhmNF
         fubuYT1HP8Xpq0T9sRH2tAQL7t2ou+FuNNyjO5aJOfdQLKw+bNrP48d9aE8Q6kOD3gdr
         N1Yw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773194852; x=1773799652; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
        b=G46rxFFcX1hnQKxUUrTijJdlDpB5OBfdKVt7tJqloBNXcNg5JAjWvjlGBTrQCSFpEL
         kw5r/kEngKAkJ0pkN558AqUScugTYRjvdhsBLXq38oLpcnNpxGDuEjo6TpPJTbZMKzhC
         YhKhvGGnSCYDK9QQnvadjQAxBlN7qho59qSI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773194852; x=1773799652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
        b=Nu6KDsEcZQWtLmwiTg7dBYPBV2SKOKl/r2JAKi3Fb3EpfUVsVakXLggDMBzl+T3y0J
         bojb0SAO0fS33d47Y8jFYUjAYVahDJm9PGeG+CqhB9V40rUzGDjAwM4s1aSrXVj75mxg
         nvA4VKW+8Bj5KOl6zxrcan4M2V7UUIBTVDuahvn+XM95ack5tE0TQ/dqR09uW4S4Dxnu
         ps3YThbmO4id4XMHnRPo1eS6YTsjeyXwNYGLhDB/UOK377eA7eZWGm9XIDuw9zmJlC1z
         cY0PghFbObFeh+n5w6tsx1UW4qQ/JTdhgr6c9o8IHYRP1XvWF9DQgJFblzc2MFJbl4bD
         pahw==
X-Forwarded-Encrypted: i=1; AJvYcCUqpRArgjoVt/SbeHinN89Cbn0USmuE7O1/P1A+HN0qgv3BHHgG9CyzmpvfVByiiMsPkqqMsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjcA4ZSyCapaIhPvWTx1Q/oolljD3X/u5y+6/f5vyBvDrNi9F5
	ba0MlUMohBnnp99z3gIf/ZMRMM6CJCqBHifCwgfo2lQkR611XU7/KOU4NHZDsuUmaUJFjm/2Bo+
	dgVewV4dzHxDccAoxiDtmmiUscfU6iS5WQoessY7s
X-Gm-Gg: ATEYQzzU6K5sM3Qo71xKcB9Ww497469XPFr/PNVd+ionqT1wp/h/HQzADklKSJv5FAv
	CNbbPFuUrv4OQM4c/PAAcZaI9mKj8iZm5UqKsxsbMGaYsRkCkMONpNYqcXTYJqj05Kjr9jS9bX4
	3X8nVOIO5s8vOWaSRHIlHgmflro8kJnwkIpr0CCeK0mfDX9JKbrD+ZQw+McCfd6cUh/wN3UO+PQ
	Del2yzCD/5xQVGs1RryCDlHb7CdvxdvVrL+5rShdE0rcXXX3kEzH/J4RNjfNuSifm9cvzhj5XhJ
	cy47E5yhGg==
X-Received: by 2002:ac2:4427:0:b0:5a1:3134:9bac with SMTP id
 2adb3069b0e04-5a156cbd1bbmr169453e87.28.1773194852284; Tue, 10 Mar 2026
 19:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 11 Mar 2026 11:07:21 +0900
X-Gm-Features: AaiRm5028PWt8n-JnveiRgn8oYMksdR_-_nk4JOkvxMfplWs-GDr7RRk-OxICyw
Message-ID: <CAGXv+5FQAVaJjqhv+Xq-ysOc4SHQn2mCNTgCAp8XocmWBWGGoA@mail.gmail.com>
Subject: Re: [PATCH 56/61] clk: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 9:57=E2=80=AFPM Philipp Hahn <phahn-oss@avm.de> wro=
te:
>
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Semantich change: Previously the code only printed the warning on error,
> but not when the pointer was NULL. Now the warning is printed in both
> cases!
>
> Change found with coccinelle.
>
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> To: Daniel Lezcano <daniel.lezcano@kernel.org>
> To: Thomas Gleixner <tglx@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  drivers/clk/clk.c               | 4 ++--
>  drivers/clocksource/timer-pxa.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 47093cda9df32223c1120c3710261296027c4cd3..35146e3869a7dd93741d10b72=
23d4488a9216ed1 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4558,7 +4558,7 @@ void clk_unregister(struct clk *clk)
>         unsigned long flags;
>         const struct clk_ops *ops;
>
> -       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> +       if (WARN_ON_ONCE(IS_ERR_OR_NULL(clk)))
>                 return;
>
>         clk_debug_unregister(clk->core);
> @@ -4744,7 +4744,7 @@ void __clk_put(struct clk *clk)
>  {
>         struct module *owner;
>
> -       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> +       if (WARN_ON_ONCE(IS_ERR_OR_NULL(clk)))

clk_get_optional() returns NULL if the clk isn't present.

Drivers would just pass this to clk_put(). Your change here would cause
this pattern to emit a very big warning.

I don't think this change should be landed.


ChenYu

>                 return;
>
>         clk_prepare_lock();
> diff --git a/drivers/clocksource/timer-pxa.c b/drivers/clocksource/timer-=
pxa.c
> index 7ad0e5adb2ffac4125c34710fc67f4b45f30331d..f65fb0b7fc318b766227e5e7a=
4c0fb08ba11c8f9 100644
> --- a/drivers/clocksource/timer-pxa.c
> +++ b/drivers/clocksource/timer-pxa.c
> @@ -218,7 +218,7 @@ void __init pxa_timer_nodt_init(int irq, void __iomem=
 *base)
>
>         timer_base =3D base;
>         clk =3D clk_get(NULL, "OSTIMER0");
> -       if (clk && !IS_ERR(clk)) {
> +       if (!IS_ERR_OR_NULL(clk)) {
>                 clk_prepare_enable(clk);
>                 pxa_timer_common_init(irq, clk_get_rate(clk));
>         } else {
>
> --
> 2.43.0
>
>
