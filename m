Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3443876DE
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259215; cv=pass; b=jpGViy6mt71uvmwUgf8xYqeAoRGWNeTM+DC4w8zjaiwWDiBhaJ1/QUX2biGz8YdX5MRgNHiyesilBxKnNdc2Bk/WeB3HDmrvb6maI0wy936geHAvSYM2prSomAELUcp5fX1s4e/1CLXfdjuGXTz5lQ+TSe0OeeHu5AAIxLSQZEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259215; c=relaxed/simple;
	bh=lKB6Rjz90KQTF5VbQz6LXHB9OgSHptSq81FKTHCNTiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKbirUavkF/kCYAv3ei2B05/rQgVRKiMQV7dOH8K/bqVPWorDaWWL2UC5ch+sWBV82aKz2p1qMYfEGlhOOYx92sgpAjeGuTnaVM8kE0vK28+FPmOKtidwXaowVGZVTtKE47ILwGF/WGTTXHIX2jZpruf+QmT1+y9VATu56/Sxkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=gkdyCJyi; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gkdyCJyi"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a985e8fcddso2897855a12.3
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 07:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790259210; cv=none;
        d=google.com; s=arc-20260327;
        b=HYcoONsq4MSzTENxVijTaT+TJ8CCQ1BOr2BHojuSA23LKalH7QevFif4egrvtWMl9W
         NLhBu9AN3Xkie9rxGDvro0+N8V/Qw0Tknnm816wd11SkHzDvzGvXiZl4VFrfjQ8Pu/7g
         imWUlwimrKvHTyFYcJD/RWRS1uwVM5xfvFx5fpCQKC39q+kas8ZOu5tXlsw2HBTCoHll
         HQ2OLlUzeQuwXq2lyFFu9QckKtPREVeWygW8cAgP86Cpy6W4FD2jdoI9jzVDHgsQgFIn
         cjjmOWBIFj/t9vXiqNzl9jeyRg58dxYqneqZZWL3c/418OF8ojZJdNRn/6ifaQOltZLb
         hu5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lKB6Rjz90KQTF5VbQz6LXHB9OgSHptSq81FKTHCNTiY=;
        fh=Mq6RgO6g6FFz++Bz8BdFcpz8Fn//Hpx2G1JyWMKdM+k=;
        b=fCCLKAoDUv6uWRI5Eqxf5I5TDtxJfZNSqasTwc5JpzDMqG/E+si2ZODcvahJTCP1Gk
         Bx8SxhYMNz3Ct0yzD+gtGWE9JEg5zurxJyoNtrOXR+7p8B02Ho9/i9BlI4KMh+0nF3O9
         s+oZ8NiQPvCmEfHgYoqxvHmGzlPFe8KLw2hd61akSQs05NUkl9/mbh4GKGEMTgrnC7Z9
         WJ1q2SHTGcxyU0OMSYTvH44GlTaMNE3shGvqYFQ2Yp02vi2Xv6aYTe0OQeavIwQqcsNJ
         A8Ha8hSQjzHuM6XduRzcjAbHSmbmeGe9/kLZujTohM1f+uTVp8zYxrQ/FZMdDIFLMu4J
         we8A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1790259210; x=1790864010; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lKB6Rjz90KQTF5VbQz6LXHB9OgSHptSq81FKTHCNTiY=;
        b=gkdyCJyiRO/gcbmlVIGeVkW1Rh59a/WkiXchWoo0o7vX+ZfFYwSc/bQFMaaiTnXFM1
         5HFBQf+6Qq4oS1QCoMPMP1OgElogRsjy5Xekn/pwV25cPb5ykFZALjFotxYVgtHHjmTg
         DJWa2iW2r19dgKnv2bosnS+44efRsmfbOKZC2Tkkomx6EiL7GOqzQxsM7uteEBJzTIXn
         kuno41rMIQrvhWcSIXkt2PuQmB1qpn506r7k5g7i/rSmXvJL/WPOswiC7X1a2cY5Pf3W
         wosJPR6cmtSBsI1FqAIOlb0tPi9oMfGkEP3lSx0A0IPhaGOrxsCc/2AcGf3gfJwd66Bs
         CheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790259210; x=1790864010;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lKB6Rjz90KQTF5VbQz6LXHB9OgSHptSq81FKTHCNTiY=;
        b=WGGC5v5AzBDbxtGpI7jU0l2e8zxgyirjMMIciFRVu10Avtjt0uZCT3wexzuaMWMkeG
         6JNSSVGoIxksvAvDdtnHHvQLTbObpWpZFZ3HUqHPGwkRX5K5ZWePui8l9xzCodV8VFSs
         tRY6BiN/igyX9ZwHL+Tl2O04fBWNl8KGnUQUkJSZVqApOXURlj+u2v+yLxWwp3DfB/Th
         58IVgqlnmn/UmFvYlX/L0EQI/zoWMHgjUNpYZVOQgJjdTrHVT3zsqshoXo6FqlZxk2rT
         IDxH24AaGKA2XP9P1l1DufbLk73WvybSYlxRs6P/FJkFBYqBFchrBsUOYDHRt+iIvpTA
         I9XQ==
X-Forwarded-Encrypted: i=1; AKwUvByCQXl9vtQoRlJ/ibdoQXqSYhk+g0M3JStnothFY0lQI0GbEwII56tQTlVKblzZGB/yxzf74Q==@lists.linux.dev
X-Gm-Message-State: AFuF++mECBCBZq/6xwWRhlqalgbFDDpdZh9lqxC+IirP9XZl6twYlIp0
	MEjuSvjT2r/+7vUXguwC8/ESc8/N3m+HNNatAsHLG39dO8N4WMG+9ByAyvoMIrNRJULpj7NCk07
	1dqakmHMkF39XCi/OzgaZ1VJNRXeKP5oZNt7CF9eaiw==
X-Gm-Gg: AYBFou1hE/O6x5sq3rWaVnqbAIziRDjRPIkpBo5Dd7t3CV0se2IFgySYmsbdDtgX4Ck
	0cjSrDq472i2kbdPYoBABU2lMrcvY4T31VqEUsHsw7pAcNJNX+jctPvK2RpDw22Iq4B4DYJcWri
	mi+zJWkM7yEbu8qxqZ/VdOodO9yCV6phdeDk6iyOvJZOgBc0lwRL3yMUJCvTtCjipqHcNgLfusd
	9Tz9vgn2zoei+GcFYpfVH6yXKIcp/hzc98GZGJV3CPqad8jYvL+sMBzJWEK2CqyI4YVWTkU+DDA
	V2dgXrNfa4UoquOvehPc1edVl5ucVOq590nyONeqKEzKt8gKzhcUETVrRg==
X-Received: by 2002:a05:6402:52c9:b0:6a9:984b:4c71 with SMTP id
 4fb4d7f45d1cf-6aac90dca01mr2240458a12.33.1790259210418; Thu, 24 Sep 2026
 07:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260924100106.2054127-1-zong.li@sifive.com> <arUSRcgzWurL-YrL@8bytes.org>
In-Reply-To: <arUSRcgzWurL-YrL@8bytes.org>
From: Zong Li <zong.li@sifive.com>
Date: Thu, 24 Sep 2026 22:13:18 +0800
X-Gm-Features: AclHuK-bIWWUadjBwDkFnhXkUVbzOHGI5rymQuXxYOn79n8X8KsdtkoE0POTC7w
Message-ID: <CANXhq0qL5qwejCXcfLNYfK025AYaMbMOzf=p0EP-NOkThL30Ug@mail.gmail.com>
Subject: Re: [PATCH v14 0/2] RISC-V IOMMU HPM support
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: tomasz.jeznach@linux.dev, will@kernel.org, robin.murphy@arm.com, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	mark.rutland@arm.com, andrew.jones@oss.qualcomm.com, guoren@kernel.org, 
	david.laight.linux@gmail.com, zhangzhanpeng.jasper@bytedance.com, 
	yang.yicong@picoheart.com, nutty.liu@hotmail.com, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 8:07=E2=80=AFPM J=C3=B6rg R=C3=B6del <joro@8bytes.o=
rg> wrote:
>
> On Thu, Sep 24, 2026 at 03:01:03AM -0700, Zong Li wrote:
> > This series implements support for the RISC-V IOMMU hardware performanc=
e
> > monitor.
>
> Do you have a link to the specification of the HPM (and additionally the =
IOMMU
> itself)?
>

Here is the download link for the latest release specification:
https://github.com/riscv-non-isa/riscv-iommu/releases/download/20260222/ris=
cv-iommu.pdf
Alternatively, you can reference the GitHub repository:
https://github.com/riscv-non-isa/riscv-iommu
This specification includes both the IOMMU and HPM parts (sections 6.19 - 6=
.23).
Thanks
