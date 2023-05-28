Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24297E
	for <iommu@lists.linux.dev>; Sun, 28 May 2023 10:36:10 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-bacfa9fa329so1883170276.0
        for <iommu@lists.linux.dev>; Sun, 28 May 2023 03:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1685270170; x=1687862170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEIjdMc3t6uK7VpqqvFnGReSqnMu5+aJcFJu5s74a2g=;
        b=K2W9+l1X1Tid3+EJqQQ/fY94BEwTMIpxSrR/hZk7F4AFiiSNIyMXuJNFcqN0IRU5HC
         RgA8PBpQi/Ktc+8+3pl7cM5hXsBD5HEdwmHxdFgHTbeHMkE/yZ1IvmvO4RE/H5u57qFy
         Il09BBOsVDeXUDjTqR5KOm6H9CozAYVh7EeUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685270170; x=1687862170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEIjdMc3t6uK7VpqqvFnGReSqnMu5+aJcFJu5s74a2g=;
        b=OF0eeDNndq1VfwahwltV+O7hc4rSAsMTeod0oGbMTYMQFyffdUDUH21jDvTusVpWCz
         LQpNSCgD/H35/GwWAingPre2zS6jlt18zPN7ULAToGvXYm2h55Cb+CletWQ8fgHsD1Zn
         +zHrFPNyrU+bYN5c53RRgruePlprt/nWbTv5hHvpc4sWEWAx4sNWCGw1mnYbL9HA/q4M
         71+K+oq/MxMfngP7vaVwLIXowJ06vSKjNLdjFASywj/vkF83hi+kKxH4oBz/btCZSl73
         zJmg+dUJAoiqGV/yaFf0mlo1AgmCcGuT0n2apUAIWbQNe3lhgjwfMYFYUM+zF4S8xixg
         Lv/g==
X-Gm-Message-State: AC+VfDywN1GoBBZyo4jNF1y1mfHpQWlhXhLVsD0K8l3vGUQgKcxJObxi
	uatFb/CRwDG7Gj3bUf0wWAesvxsHk5674GEsEsh0cA==
X-Google-Smtp-Source: ACHHUZ73RHrAo0cPXE0nt0Rv8+FrnJMoVr33kCNPQ9rE3gthn+TWULk+JsMWs3UrFpgcDWlFPFcPjawxAM8CJnkIoSY=
X-Received: by 2002:a25:a549:0:b0:ba8:1089:3338 with SMTP id
 h67-20020a25a549000000b00ba810893338mr7609381ybi.39.1685270169679; Sun, 28
 May 2023 03:36:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230330131746.1475514-1-jagan@amarulasolutions.com>
 <20230330131746.1475514-2-jagan@amarulasolutions.com> <beae35a5-b094-087a-8443-5f669a2a37c6@arm.com>
 <CAMty3ZBD8Eca4ECd03c1WD_tKTrd_=Tx1FF3KeihLAXySTVL8A@mail.gmail.com>
In-Reply-To: <CAMty3ZBD8Eca4ECd03c1WD_tKTrd_=Tx1FF3KeihLAXySTVL8A@mail.gmail.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Sun, 28 May 2023 16:05:57 +0530
Message-ID: <CAMty3ZAnx2V_gWgi-jpRHbdyVnGYn9Vyyv8H0HVqTijOcCBycA@mail.gmail.com>
Subject: Re: [PATCH 2/3] iommu/rockchip: Disable the device link during resume
To: Robin Murphy <robin.murphy@arm.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, iommu@lists.linux.dev, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, 
	linux-amarula <linux-amarula@amarulasolutions.com>, Simon Xue <xxm@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Robin,

On Tue, Apr 4, 2023 at 1:21=E2=80=AFPM Jagan Teki <jagan@amarulasolutions.c=
om> wrote:
>
> On Thu, Mar 30, 2023 at 7:13=E2=80=AFPM Robin Murphy <robin.murphy@arm.co=
m> wrote:
> >
> > On 2023-03-30 14:17, Jagan Teki wrote:
> > > Rockchip iommu is trying to enable the associated device at runtime
> > > resume however some devices might enable the iommu during their pm
> > > runtime resume operation which indeed leads iommu to use the wrong
> > > domain and this leads to device iommu page fault.
> > >
> > > An example of this behavior has been observed in Rockchip RK3328, whe=
re
> > > iommu stalls request timeout dring VOP device enablement.
> > >
> > > Here is the dmesg log for the same:
> > >
> > > rockchip-drm display-subsystem: bound ff370000.vop (ops vop_component=
_ops)
> > > dwhdmi-rockchip ff3c0000.hdmi: supply avdd-0v9 not found, using dummy=
 regulator
> > > rk_iommu ff373f00.iommu: Enable stall request timed out, status: 0x00=
004b
> > > dwhdmi-rockchip ff3c0000.hdmi: supply avdd-1v8 not found, using dummy=
 regulator
> > > rk_iommu ff373f00.iommu: Disable paging request timed out, status: 0x=
00004b
> > > dwhdmi-rockchip ff3c0000.hdmi: Detected HDMI TX controller v2.11a wit=
h HDCP (inno_dw_hdmi_phy2)
> > > dwhdmi-rockchip ff3c0000.hdmi: registered DesignWare HDMI I2C bus dri=
ver
> > > rockchip-drm display-subsystem: bound ff3c0000.hdmi (ops dw_hdmi_rock=
chip_ops)
> > > [drm] Initialized rockchip 1.0.0 20140818 for display-subsystem on mi=
nor 0
> > >
> > > This issue is reproduced if we enable the display in U-Boot however
> > > U-Boot is not even touched any iommu register as the U-Boot display
> > > uses the simple frame buffer like other Rockchip platforms RK3399,
> > > and RK3328 do.
> > >
> > > When VOP is trying to enable the iommu using runtime resume call
> > > pm_runtime_resume_and_get from @vop_enable then the iommu runtime
> > > resume call @rk_iommu_resume will try to attach the VOP in the wrong
> > > domain via @rk_iommu_enable will lead to the vop iommu page fault.
> >
> > That sounds like a driver bug. The whole point of the device link is
>
> Do you mean the bug in rockchip-iommu.c or vop?

Any further comments on this? Issue seems to reproducing on latest RK SoC's=
.

Thanks,
Jagan.
