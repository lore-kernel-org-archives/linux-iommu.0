Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A2918AE2
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 14:56:52 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-39c4c3da9cbso659918b6e.2
        for <iommu@lists.linux.dev>; Fri, 09 Jun 2023 07:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686322611; x=1688914611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5P30yTVObjCNWePFrPZlTAmy25U125Eu2KEScJ+3Q+g=;
        b=DiS+tAYV8rfbWIbHRCpGArV53sDOTNWWuaxxiYJkEDzhscawVJagxGAHwzNWLaqwgc
         YGozAa1IoPB+RSWtvhCwgM3Zs3NkLYepHEaDIaKQbmHWQTuIHlEwA1YUzjPK2L4Ma3wS
         MVA3ehcOIOGbJNbt9Lg4CMuG+vHbUTmwpqsQFRSjDX8vzp/bTOQh3J39klectF02yxfF
         gCSraKM82LukA3+xXvX2N8pd41a4kdevnusmT5DZxAk8KOQIHnsHISOy52Upt+ZngN2F
         4VV5ZTxgZ+Utt2hhv7XJBhjVPYq71c1p31B3EiF5rVkENTYx0/UD8XKjZjdvDAFV/Cps
         PdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686322611; x=1688914611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5P30yTVObjCNWePFrPZlTAmy25U125Eu2KEScJ+3Q+g=;
        b=jGk6lzBdN2NyZOHlCt0byG8XeGxQ/23rJf2MJRZImXdhrfKyf6KQPO94Dp5cNbRC5d
         stlCKVNdjJZRx1LLbrmOTIH+iB1WfLH6JjTGAM3ne/Yb9yKFE6YGcDSoZJk8yKHzmYic
         dz1FqieF8uSjz4NfW7k+8h/Uyv4/GptAuzNAlFGUmPrExWwKH0xBpXWfu9T3kOnbMPnW
         ya9TZhvjAKbhblgGDFqv7R383MxxgsnRXzmSuj2t9p+VVooytXvps+PWR8fy+nzEck2b
         OcKyy/D93/JbOYbWRSsALzRoTD4RPezrPXOmlfz94Z6dzENHJimXaZZwnybQnotljmlM
         ydSg==
X-Gm-Message-State: AC+VfDx5wcVsU7zFJHUHDRn9oVmBg/w24P2jjdGuf0aESSJ8r4TIjh6d
	7EAWw0+8gZTz0gphJrRaLSsspQbnhVUvMlZ/vgHmgQ==
X-Google-Smtp-Source: ACHHUZ4nFpTpj3lsBdccjwaqtlsCznyPJ13GRyEpdzMAWcin+xTZz2n7mc55BitUQ9Mi+bJLBYRdi7BCReqlTQKBHw8=
X-Received: by 2002:a05:6358:bb92:b0:129:c3fc:ff5c with SMTP id
 df18-20020a056358bb9200b00129c3fcff5cmr1385785rwb.24.1686322610069; Fri, 09
 Jun 2023 07:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230609054141.18938-1-quic_ppareek@quicinc.com>
 <79206b05-674b-1f6c-6eb1-ed45e6bd5637@linaro.org> <20230609125631.GA29252@hu-ppareek-blr.qualcomm.com>
 <2881f374-70e2-0057-f43e-7be12d32ae22@arm.com> <c3c12574-fc38-84ae-2a94-3c80fb9fb363@linaro.org>
In-Reply-To: <c3c12574-fc38-84ae-2a94-3c80fb9fb363@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 9 Jun 2023 17:56:39 +0300
Message-ID: <CAA8EJprqfq0ey2hgBXxf9Zg1Y_MwHP_73EQkwg-W-sRYS7VE8w@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: dts: qcom: sa8775p: Add interconnect to SMMU
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Parikshit Pareek <quic_ppareek@quicinc.com>, 
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Adam Skladowski <a39.skl@gmail.com>, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, 
	"linux-kernel @ vger . kernel . org Prasanna Kumar" <quic_kprasan@quicinc.com>, Shazad Hussain <quic_shazhuss@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 9 Jun 2023 at 17:52, Konrad Dybcio <konrad.dybcio@linaro.org> wrote=
:
>
>
>
> On 9.06.2023 16:45, Robin Murphy wrote:
> > On 2023-06-09 13:56, Parikshit Pareek wrote:
> >> On Fri, Jun 09, 2023 at 10:52:26AM +0200, Konrad Dybcio wrote:
> >>>
> >>>
> >>> On 9.06.2023 07:41, Parikshit Pareek wrote:
> >>>> Some qcom SoCs have SMMUs, which need the interconnect bandwidth to =
be
> >>>> This series introduce the due support for associated interconnect, a=
nd
> >>>> setting of the due interconnect-bandwidth. Setting due interconnect
> >>>> bandwidth is needed to avoid the issues like [1], caused by not havi=
ng
> >>>> due clock votes(indirectly dependent upon interconnect bandwidth).
> >>>
> >>> [1] ???
> >>
> >> My bad. Intended to mention following:
> >> https://lore.kernel.org/linux-arm-msm/20230418165224.vmok75fwcjqdxspe@=
echanude/
> >
> > This sounds super-dodgy - do you really have to rely on configuration o=
f the interconnect path from the SMMU's pagetable walker to RAM to keep a c=
ompletely different interconnect path clocked for the CPU to access SMMU re=
gisters? You can't just request the programming interface clock directly li=
ke on other SoCs?
> On Qualcomm platforms, particularly so with the more recent ones, some
> clocks are managed by various remote cores. Half of what the interconnect
> infra does on these SoCs is telling one such core to change the internall=
y
> managed clock's rate based on the requested bw.

But enabling PCIe interconnect to keep SMMU working sounds strange to
me too. Does the fault come from some outstanding PCIe transaction?


--=20
With best wishes
Dmitry
