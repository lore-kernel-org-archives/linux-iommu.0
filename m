Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795507618;
	b=Odc3cs1aJXCM1kdd+UwJ8xXid0lUwZcRqla+/A2g1XvmVIpKJiNUFQUxGMHzG2Lx4LdV
	 z1Ao1FGPU8KX9YCL2nAVxGjIkxqI+Xr3DfI9fM8QGhfYlPhr5M/aXsR2zjNRM52P5wlPm
	 rYnFq2xux3SKPfBfM22SnuRbqVqLaCmxRk5k6oklRPUnWy1MkIOSS9RJvM5gpWoSiveeW
	 YXiT8iP8zvEaZs4QB+6cVpAd7/pnAya8BsY3VGIorxBf8MuWXYGCICwT+D+BheOTzF06H
	 oGlXnX+530Z+E0MwjHmihL+dMHCY9duDe+FXFRg/+3KBA4SJQWUUpSZ7CXnQR8h5wBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795507618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bw6nyEiSIkuUi2FfPQWVcCbleSg58qLNpgEdKu/3YUI=;
	b=jxo6RhLjWYZsTPuEp3ykDGxkDh0xueYW+EHpl3Bto5YKWLchRC7/HMcURfFUP3KyxRFL
	 eMlbFREkpv6tWAW5h9Ynsdeof3R1maNTcBvAQ0WDx9vqBPrtC0QnyoFM7pLB3KS+uJyY1
	 TrVBALueX3xJjJzOv0oUZIZzfy7dGBZUDw7bJYwaZwDzy1gP7nlCwNXx2pTkqdVYvpPK9
	 Fsy0vPq9nj0fqE3WJ2nwfPLxqVE5qJxXw/hcM0PLElviqKWOirfL50g32nFqQQH5+VZd2
	 Q8PQImk9RmR3LQpSkx+6EoEnAlq0ZRoa+s/UtlW5FhT8bYn+BGHtT8Q6a3M+3vIa9Rg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="KBpm/ex0";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9C5606A31E
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 08:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C9C5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KBpm/ex0
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5ee3e658c72so2385834e0c.1
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 00:06:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795507616; cv=none;
        d=google.com; s=arc-20260327;
        b=WI8exSV0M0ybalz3ufRiivJSzWZXsmqm+Wq1n56YvOKXLAN4m34gJJOz+PXsmAgQzb
         kaouNmstgUQgXe4IWZTWKVmoEEGGGVpkR6rhuH2Xxmu18/qtB0cU5dYaZLF+8JfkHq7n
         6Sr4OJCtr/C08iBm5jAZyGo/ODxWyxMpDlru0G9QFH8tAMphtwRznO7S8QEQmjoSq9Hy
         +G8w0jpszx7WztUpeOChtv9jgF2Eg1aRyZeMCvpphUcoLtcMTQWRByfIZzTkviMwdNsh
         CRmpfnJwKAIrYV3nHRNerJXHnGLijaefMZZ+wwAZ4Ye+jMuQ2SMTVj8MmRSqFDQtDDn6
         MtUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bw6nyEiSIkuUi2FfPQWVcCbleSg58qLNpgEdKu/3YUI=;
        fh=TjpHn5Wde9GRlCGY0lTafd5Opook/VR/OIWPw1WH1OY=;
        b=PUsS8zykm3G+eXAfM3erCmXqu82oasYYMHXTerszE0ELMMRUqOQkd30WsB1uj8msnY
         RgaQ4LmjGet2/aldsuOTP87eVjr3pgl9GycDSie80vdumnJdm8wfXBiMMpnGpB0xIe/u
         mDMtUP7G+KkwhH9QW+GI/ofxAlsmSEvyjOMO/ckAAwl0yMtM68Lldla/roU+MK8Sy3Hj
         15fbSVVoSjoBhK4bNzcLpHK34U4qezqLgxsEN6rFfeHD2Yfoki696XxRrE6eJWO9YGyI
         /vHRCQ8J6EvUt+2A3pRZV63XnJhEPA5TyOz4MOhz64K2g48qPXOAjMXgcuZ0dOxMNjT5
         YDZA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795507616; x=1796112416; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bw6nyEiSIkuUi2FfPQWVcCbleSg58qLNpgEdKu/3YUI=;
        b=KBpm/ex0lnJHnPaYnyv5O7cLF9RRFpXhEHHowToHy0iiqKaT+PJi2zpDNh9R3vQT9g
         nbqkODgj3Lv4LhSfgTldHqFusRImPyMBuhlEpW0LpgueHZnGLf/d2NfYz+B0HWIZIJb2
         /8W521ODdDqPlflrN8/4tgG0kRgpX/NiAtqbjQ/W2aayLDAt0FhdbSCZoQ30C9ULejpE
         16YC/pmcCQz3NV6kkCvzOUcNwkmPLwJyw4iKhmNbd3JvAe6Q9vEF4H9SuME+zSm1U+nr
         mYAsn2XLYngqH3IaUA7M07mDnZD5BrRpu7EJtYmZdyrqfuSDhvgfgiDWBZE9EYTpdN8O
         eaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795507616; x=1796112416;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bw6nyEiSIkuUi2FfPQWVcCbleSg58qLNpgEdKu/3YUI=;
        b=CJchxeZAtHQlZP0zvH1+2+St77i5QsOsms2v79T0WbinMP73y9fZ8MhC8YQ5BwZGup
         hOmtWFze7FrIhjaNh6eiJBnrzJosBqMZbYH3f1IlaLdv+XqZRFFMxYX8QXAiucFZVj8e
         4f9qAKq1zx4vX9XT1SKw+Anb0KkV7i6kAFEtszWjO/dGMim9hSWYUyz0xvfUJKnyrVi1
         5UNwSLtXTtJSqD9d/P/wn/VvFa0IaLpSvkUHwlhV5GpWwkRH59uYaDIHCcHKjRiPvI57
         HtNicfglbJA53jcs+5eall4X3oWbFfNSDjvx/XWCMVB4jP8Cvb9cMkOC48m41PVkVCsg
         Rz0A==
X-Forwarded-Encrypted: i=1; AL+hErFp1RpGyGVOXYb309CA0+ZAcUpjBuYiycRjcLOBiUOqe5RLsd7m25KgG8zd1ROnU7GR6EG0iQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8VqV5Djw3oS7MIJKlfgEsLq+nNl5YJ56HbBSs8Qdr+VklnCO8p
	ueujwcpzJi2PrsJ85yoJpS+FPcOoQ5xR7MgJlJAld6W/EFILIVHtAAlsOGbhChKgl6khi29vK5T
	Z/S4Luw4K3DZ28a9sZjbNXxhWJJA/fZoUSUTGFjr2b7JQ
X-Gm-Gg: AZFdTZcMQrqGWIqpEpld7pLbC7H2qottJ+3ARY2X9xi0L3G7X/o3MyZFbKwQYdFkYLV
	Ino45qIOpAk+jxCkWobOf8ImG0/vBxBhL1Kg18gjQ3U04PUfRUpZ9/UDJk0z5qhnb4QLkIf5zxU
	NdPSUS5Nw6oRsll4O66/FbB0wWrsMyizQzPJcJaj4egRxidcCdS3mHYkXMAoqt5FLtikeh3g7w0
	A1d670OAbtZz36zLDzAzdSf3kou/BXc1QlOaaKepzgkF1YMtvQvmUxjpEpXyP75r2Vl9uCeJH6A
	cCFibLrNOEv3Ilvie0lmjZG2Ls+bLDWU8m3w4jiL1iWt4d3pQMQoAT324gvBr28cYn2UGe8BE6h
	HK9gmy0vVrjlHZLP7r9Ir5wd3oHzVUMrw06+qmIwGiVvoG7hpIVLDa5mf2ZsKy85aXDOnKztTKT
	45uKkKsGlU0RjKcFE=
X-Received: by 2002:a05:6122:130a:b0:5e9:721c:72a8 with SMTP id
 71dfb90a1353d-5ee8ad0f9ebmr7298180e0c.0.1795507616075; Tue, 24 Nov 2026
 00:06:56 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261123235154.315460-1-gahing@gahingwoo.com>
In-Reply-To: <20261123235154.315460-1-gahing@gahingwoo.com>
From: Anton Sovetov <anton.sovetov@gmail.com>
Date: Tue, 24 Nov 2026 11:06:45 +0300
X-Gm-Features: Aa3M54rUMtJHW-VAq-3nFFJeEzc6wZ6Xr6IR4ySmynSenaDrr1lXVW8oN5BrzrI
Message-ID: <CANLiQWot44KOq8A8dQGt0JNoX=BvH2T+HryMEV05qC6iLydidA@mail.gmail.com>
Subject: Re: [PATCH] iommu/rockchip: Disable paging on banks that still page
 before a force reset
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, heiko@sntech.de, 
	tomeu@tomeuvizoso.net, ddrake@baylibre.com, sidong.yang@furiosa.ai, 
	chaoyi.chen@rock-chips.com, iommu@lists.linux.dev, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, that description matches the end state I see, so it is worth tellin=
g you
where it does and does not fit my board.

Mine is an RK3566 with a single bank. The MMU node is 0x40 bytes of
registers and
the driver ends up with num_mmu =3D 1, so two banks cannot disagree. I took=
 the
nearest analogue of your fix that exists for a single bank, the one in the
Android tree: acknowledge a latched page fault with CMD_PAGE_FAULT_DONE bef=
ore
sending CMD_ENABLE_STALL, because a bank sitting in PAGE_FAULT_ACTIVE with =
no
stall ignores the stall command and the poll times out.

Measured on 6.18.24, twenty separate processes, five runs each, IOMMU mode:

- before: 3 ok, 4 wrong output, 18 timeouts (the failures are sticky, only =
a
  reboot clears them);
- with the stale-fault ack: 2 ok, 0 wrong, 18 timeouts.

No change, and more useful: dmesg has no "Enable stall request timed out" a=
nd no
"Disable paging request timed out" line at all. So on my board the
re-enable path
is never the one that fails.

What I see instead, at the first failure: the job is submitted, the
kick registers
hold what the driver wrote, and the core never runs it. INT_RAW_STATUS read=
s
0x10000 while the required mask is 0x300, task counter 0. The MMU is health=
y at
that moment, paging enabled, no fault pending. Later failures sometimes lea=
ve a
fault in the register, but the first one has none.

Two questions if you have the logs at hand:

- on your RK3576, does the hang start the same way, with a job that never
  executes, or does the MMU re-enable failure come first?
- do you ever see bit 0x10000 in the NPU's INT_RAW_STATUS on a hung
job? I cannot
  find what that bit is in the RK3566 register map, and the driver does not=
 mask
  it in, so it never raises an interrupt.

For the record, the other three things I ruled out by measurement on the sa=
me
board, in case one of them is what your patch really fixes: TLB staleness (=
full
ZAP_CACHE and a domain detach/attach before every kick), cache coherency fo=
r the
task and regcmd buffers, and the iova width (limiting the dma mask to 30 bi=
ts).
None of them moved the failure rate.

=D0=B2=D1=82, 24 =D0=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3. =D0=B2 02:5=
2, Jiaxing Hu <gahing@gahingwoo.com>:
>
> After an RK3576 NPU job timeout resets the core, the banks of its IOMMU
> can be left in different states: bank 0 is still paging while bank 1
> has been reset.
>
> In this state the existing stall and paging helpers do nothing, so the
> force reset that follows fails as well. The IOMMU can then no longer be
> enabled, and the NPU stops working.
>
> When the banks disagree, stop paging on the banks that still page
> first, then run the existing sequence.
>
> Tested on a ROCK 4D with repeated forced job timeouts. Without this
> patch, one in every 2 to 10 timeouts was not recovered from; with it,
> 20 out of 20 recovered.
>
> Fixes: cd6438c5f844 ("iommu/rockchip: Reconstruct to support multi slaves=
")
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
> Not tested on the RK3588.
>
> LLM-assisted.
>
>  drivers/iommu/rockchip-iommu.c | 61 ++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iomm=
u.c
> index 1fa3110b142a..5eabefb0ad14 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -507,6 +507,64 @@ static int rk_iommu_disable_paging(struct rk_iommu *=
iommu)
>         return ret;
>  }
>
> +/*
> + * The helpers above only act when every bank agrees. After a reset of t=
he
> + * master, one bank can still be paging; stop it bank by bank.
> + */
> +static void rk_iommu_quiesce_paging_banks(struct rk_iommu *iommu)
> +{
> +       int i, ret;
> +       u32 status;
> +
> +       for (i =3D 0; i < iommu->num_mmu; i++) {
> +               void __iomem *base =3D iommu->bases[i];
> +
> +               if (!(rk_iommu_read(base, RK_MMU_STATUS) & RK_MMU_STATUS_=
PAGING_ENABLED))
> +                       continue;
> +
> +               dev_warn_ratelimited(iommu->dev, "bank %d still paging, s=
tatus %#08x; disabling it\n",
> +                                    i, rk_iommu_read(base, RK_MMU_STATUS=
));
> +
> +               if (rk_iommu_read(base, RK_MMU_STATUS) & RK_MMU_STATUS_PA=
GE_FAULT_ACTIVE)
> +                       writel(RK_MMU_CMD_PAGE_FAULT_DONE, base + RK_MMU_=
COMMAND);
> +
> +               rk_iommu_base_command(base, RK_MMU_CMD_ENABLE_STALL);
> +               ret =3D readl_poll_timeout(base + RK_MMU_STATUS, status,
> +                                        status & RK_MMU_STATUS_STALL_ACT=
IVE,
> +                                        RK_MMU_POLL_PERIOD_US, RK_MMU_PO=
LL_TIMEOUT_US);
> +               if (ret)
> +                       dev_err(iommu->dev, "bank %d: stall timed out, st=
atus %#08x\n",
> +                               i, status);
> +
> +               rk_iommu_base_command(base, RK_MMU_CMD_DISABLE_PAGING);
> +               ret =3D readl_poll_timeout(base + RK_MMU_STATUS, status,
> +                                        !(status & RK_MMU_STATUS_PAGING_=
ENABLED),
> +                                        RK_MMU_POLL_PERIOD_US, RK_MMU_PO=
LL_TIMEOUT_US);
> +               if (ret)
> +                       dev_err(iommu->dev, "bank %d: disable paging time=
d out, status %#08x\n",
> +                               i, status);
> +
> +               rk_iommu_base_command(base, RK_MMU_CMD_DISABLE_STALL);
> +               ret =3D readl_poll_timeout(base + RK_MMU_STATUS, status,
> +                                        !(status & RK_MMU_STATUS_STALL_A=
CTIVE),
> +                                        RK_MMU_POLL_PERIOD_US, RK_MMU_PO=
LL_TIMEOUT_US);
> +               if (ret)
> +                       dev_err(iommu->dev, "bank %d: disable stall timed=
 out, status %#08x\n",
> +                               i, status);
> +       }
> +}
> +
> +static bool rk_iommu_banks_disagree_on_paging(struct rk_iommu *iommu)
> +{
> +       int i, n =3D 0;
> +
> +       for (i =3D 0; i < iommu->num_mmu; i++)
> +               n +=3D !!(rk_iommu_read(iommu->bases[i], RK_MMU_STATUS) &
> +                       RK_MMU_STATUS_PAGING_ENABLED);
> +
> +       return n && n !=3D iommu->num_mmu;
> +}
> +
>  static int rk_iommu_force_reset(struct rk_iommu *iommu)
>  {
>         int ret, i;
> @@ -947,6 +1005,9 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
>         if (ret)
>                 return ret;
>
> +       if (rk_iommu_banks_disagree_on_paging(iommu))
> +               rk_iommu_quiesce_paging_banks(iommu);
> +
>         ret =3D rk_iommu_enable_stall(iommu);
>         if (ret)
>                 goto out_disable_clocks;
>
> base-commit: 909ef7a9a30fa139e69e555e3606680f5cca7726
> --
> 2.43.0
>


--=20
With respect,
Anton Sovetov (co-Founder and CEO of 3d-club LLC")
https://3d-club.ru                        tel:+7 (999) 246-78-36
