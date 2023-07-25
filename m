Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581B8134CC
	for <iommu@lists.linux.dev>; Tue, 25 Jul 2023 08:06:58 +0000 (UTC)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-55e1a9ff9d4so3783698eaf.1
        for <iommu@lists.linux.dev>; Tue, 25 Jul 2023 01:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690272417; x=1690877217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQlid0H2jkWZz9fgcu7Ae/8sWUNA4lIusDDxBLqkgag=;
        b=N/RwH41ntlp8cr8ydFYUpFpoqiW4MZC9W726ahHb9rNeZN/BQhgjRUvW43TbQVMkww
         1hCXeYujuKghA2smFO10Eh5xisYmN+xqOiTFdmPXOlm6hy3SklxNH+j2c1J98sHXJzuZ
         BNTho6g2LvDsx1alHYU1iVCYl+J2TFEdw9Yjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690272417; x=1690877217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQlid0H2jkWZz9fgcu7Ae/8sWUNA4lIusDDxBLqkgag=;
        b=h5w9z0EK98A5wIzD85A+19tF0BpVr37hLD5QbQduvXGwXUKAlot2brVvZkJA6EWwj1
         WYrCtvn5XhLvjxw2skzO3OJb4BmTKYI5kakc8Q7gtHH+dKi2Qf1Ei8eQCAHb6NCw5gDr
         ZsWaUuB7bT40JuUX5PDlA4RCZNyf+M6rNViX8ySZsnITnXMw078HMEPiEqdYPW4J00op
         HNgtu/p7EQ6L0o6yUmXCL3fvGL+H/GKjhad0m6/9Jjv+VeFJIaFYMs6QkyH+LirfMAT2
         n0yB3Sp2ysOkRe0Jti2Kb+55G8vxmem8r97IKB9b2mqlMB8muIZHGlxoMa3IzVWIxoad
         3lXw==
X-Gm-Message-State: ABy/qLZjJiTFbweS0nDhi9XqD8A4Oowcq7qG19X3vV5/KIOZs7gsh47R
	lTytklGw3x7yneGcbbLIp+vIX4cV5K57TRGhIEw=
X-Google-Smtp-Source: APBJJlHhpvDnd6aTbUwCR0z+VI+fvqZszoXe3tRaG5l6nV72ftVSjU+aAOcL0T3wdEmI3GAw34WKAA==
X-Received: by 2002:a4a:344a:0:b0:567:4e58:6aae with SMTP id n10-20020a4a344a000000b005674e586aaemr1493299oof.0.1690272416974;
        Tue, 25 Jul 2023 01:06:56 -0700 (PDT)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id q130-20020a4a3388000000b00541fbbbcd31sm5252400ooq.5.2023.07.25.01.06.56
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 01:06:56 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6b9cf17f69cso3322159a34.0
        for <iommu@lists.linux.dev>; Tue, 25 Jul 2023 01:06:56 -0700 (PDT)
X-Received: by 2002:a6b:8d82:0:b0:789:dcd1:8eb9 with SMTP id
 p124-20020a6b8d82000000b00789dcd18eb9mr1029181iod.6.1690272036013; Tue, 25
 Jul 2023 01:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230602090227.7264-1-yong.wu@mediatek.com>
In-Reply-To: <20230602090227.7264-1-yong.wu@mediatek.com>
From: Fei Shao <fshao@chromium.org>
Date: Tue, 25 Jul 2023 15:59:59 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhgkj5zh-Oa+OJjZKmkNMfG63+WjSefB2swybm29KxDXA@mail.gmail.com>
Message-ID: <CAC=S1nhgkj5zh-Oa+OJjZKmkNMfG63+WjSefB2swybm29KxDXA@mail.gmail.com>
Subject: Re: [PATCH v12 0/7] MT8188 IOMMU SUPPORT
To: Yong Wu <yong.wu@mediatek.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, iommu@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	mingyuan.ma@mediatek.com, yf.wang@mediatek.com, jianjiao.zeng@mediatek.com, 
	chengci.xu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 2, 2023 at 5:03=E2=80=AFPM Yong Wu <yong.wu@mediatek.com> wrote=
:
>
> MT8188 have 3 IOMMU HWs. 2 IOMMU HW is for multimedia, and 1 IOMMU HW
> is for infra-master, like PCIe.
>
> About the 2 MM IOMMU HW, the connection could be something like this:
>
>         IOMMU(VDO)          IOMMU(VPP)
>            |                   |
>       SMI_COMMON(VDO)      SMI_COMMON(VPP)
>       ---------------     ----------------
>       |      |   ...      |      |     ...
>     larb0 larb2  ...    larb1 larb3    ...
>
> INFRA IOMMU does not have SMI, the master connects to IOMMU directly.
>
> Although multiple banks supported in MT8188, we only use one of them,
> which means PCIe is put in bank0 of INFRA IOMMU.
>
> So we have two pgtable for MT8188, specifically, these two MM IOMMU HW
> share a pgtable while INFRA IOMMU HW use a independent pgtable.
>
> Another change is that we add some SMC command for INFRA master to
> enable INFRA IOMMU in ATF considering security concerns.
>
> We also adjust the flow of mtk_iommu_config to reduce indention.

A friendly ping - this series was reviewed, but I'm not sure if it's
still on the radar today.
This can be cleanly applied on top of next-20230725.

To give more confidence, I also tested the basic multimedia and infra
functionalities on my MT8188 with this series, so

Tested-by: Fei Shao <fshao@chromium.org>

to the entire v12 series.

Regards,
Fei
