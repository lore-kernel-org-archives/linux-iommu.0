Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827833AEF5A
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565904; cv=none; b=efbMnbTuyh8+kQhCWS+DcVbGm8Z0elQzGSD/JGPvWgryj8Xz/D3W02eKQEf6pnrUswoQB/ruDCK9oD9+L7YBG/ALgQcyKhHt1X/S1TgOTSQZIT7FWqzFmjNs5F4/ZCPdcPhnYUA5LOK0wR+3nn7U2FQC0W0fUqyMgNY9KqLa+Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565904; c=relaxed/simple;
	bh=tCXPfjbfeyr9jATJREVrmtfpm482cc9JqBuaA4EqFHI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EzaoZriM0bqIWbVLBSU8Fk9AsvFHpXcsWKu7MEo8+C9F58dXgv9lGXSZWrcTm8XqhhaibiAR1FFZ4l3lMYZMETu2TKRGOIfYtz9VLr0wk+gDDoV2jQiiDsf4bYkfWY/A9UE+z5kKAG2qBlTTq7me6fWv0gOPUxKdxqOAZcZfTfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=HW0GOYVL; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="HW0GOYVL"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a20319d030so4876706a12.2
        for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 03:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1787565901; x=1788170701; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z+EXhzdCNyL7BX1v534o+kUhKJJy7+6exCGtwlOH/1M=;
        b=HW0GOYVLunDRagcvzBWo6W4S447GSUWvB/Yv50osFPoLqGU4zw3Ij7mhw9bOkqj/6W
         NDatN2RM6B3h+deNzoInU9DeamegnbMzM9vB0lZnAxHqYqfE+Rg7uZry6sy/14PLnJ47
         SOvO2MsUt4CH8TS6B5xAsm7RzwxM3+o3PEcRcMlZy06XhD3O7BsSVHs05yZJf6y5XwAy
         7/UFfmQA0YTd1/0PIxtkRYIAZEEhjzH2TLZbCjmxY7W47tRjPsv5fAdllRlG1ZCacZeV
         R7bLGGblheWXvGUanmib6B3d7AJ4sEN/O1ufuKgOeoCwkOsr8+NIxn4/p0sSdwDRG23D
         N2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787565901; x=1788170701;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z+EXhzdCNyL7BX1v534o+kUhKJJy7+6exCGtwlOH/1M=;
        b=RS6ZBuSDQjqift9Ncq4rfQ1AitdHEJcKk4tmaThl0k4e1ynnXKteP0IKbG7RmbCwQa
         O8LRFsBUyXLTRMj5KqBhRA0/KOgJRBZ6mEP2mShHFdQPN6w1VNdnkmeAQa7ISZp+q8CR
         6ibhog5N2a2sw9PHBXgytZQ79tmf6jSRzyoW7qQTwVW+1NmuOmEjnpzExZHxDJ6AlF8S
         zaIgd5jm7dLQM8PL4FjjVHFO1hIyZm6zptXzIwXcFWcHSe6p9k3yyHWWdkzMit8Msj2b
         ZLHdNFCVACnQFxPD4ZOASD6Q7LNih9phkOKIQwmgGrqwDO/HcNTFOY3r3JCzVgJ8APMi
         Dqaw==
X-Forwarded-Encrypted: i=1; AHgh+Ro2qD/BpTHvOxRZvadTPe0Xs3xKUt9yjPLGbseN+h2RVZZPAI67vFKCCq1hWCDRuSvsJqf5lA==@lists.linux.dev
X-Gm-Message-State: AFuF++nsvyBZHws14TzFbKUqo9kDKxcR42m+R9IKTtCLPIJv9CF+a5LM
	w4VhvLDVq2f2fecQQuKI5LUW5NSVSJMqb9bHaUpTXtGxAMwK6e+X9qOMtEiV1VPtloc=
X-Gm-Gg: AR+sD11uoNFlAjxQzMYjgqxN/ymx6odntjauDy8lbbb9GyKuBB1lkGDdF9DuopZOwnA
	zEPnKdZ3WOsvQH6PfgNCNLSZMr4oZUCEKD7R5xAvsM2a/1rG0fgxrQsGDlYRNTU3h7C3zguf+0n
	T3uXxX2bjZBWzAc+TQKWsOuCM2Yj+D+453BGSIkgLozkggvlmFK9YxOGCXzR4kirWn2IUF9NPO9
	FfyGv92vnIYDVsINsInbjVu8VmpBMLVgKw9MWeArrMYD8Ddv0FWj7wBVhCG/Oxou1ozGXOqTsvl
	S/PpKSDLWPia7f5woWL+XsUzVC5LAwQOg+MuxvNnBQy8wpK07CPxdpVbJ8QoctaPC9J7smZGPg/
	DGTmUIURTCqzYFsjVcP4XoKuO9Yrz5cDA4i+TB9LaPp1smye8UW03iaXe2jJ2bka7iP3Tj+MYjs
	zjM20K35fpHC5kU8qVmGx1vG10JHddrEt69nWuuo2ASniF7uHXg5BZYLQixDLKkBCqy/xSBj1yL
	HtjLkHz3lnmr7VwkMSA1XDIp/aQs0i3pg==
X-Received: by 2002:a05:6402:21dc:b0:6a3:fee5:adcf with SMTP id 4fb4d7f45d1cf-6a42f14d952mr27894029a12.1.1787565898379;
        Mon, 24 Aug 2026 03:04:58 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e2da49bsm8922721a12.29.2026.08.24.03.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 03:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 12:04:57 +0200
Message-Id: <DKX384NK76OS.3NNOMAH72PV2P@fairphone.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>,
 "Robin Murphy" <robin.murphy@arm.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Rob
 Clark" <robin.clark@oss.qualcomm.com>, "Bjorn Andersson"
 <andersson@kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 00/12] iommu: qcom_iommu: implement support for
 instances on MSM8974
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com> <DKL6P7G0WTM7.UJ6KZERQZDFK@fairphone.com> <iv5radfllym2bjvkrdu4ffs25bqixyos7k3ymncpcdtc2uobn2@zlhsybrj3pwz>
In-Reply-To: <iv5radfllym2bjvkrdu4ffs25bqixyos7k3ymncpcdtc2uobn2@zlhsybrj3pwz>

Hi Dmitry,

On Tue Aug 11, 2026 at 2:43 PM CEST, Dmitry Baryshkov wrote:
> On Mon, Aug 10, 2026 at 12:16:19PM +0200, Luca Weiss wrote:
>> Hi Dmitry,
>>=20
>> Many thanks for working on this and sending this patch series!
>>=20
>> On Sun Aug 9, 2026 at 10:15 PM CEST, Dmitry Baryshkov wrote:
>> > Qualcomm MSM8974 platform has five SMMU instances, used by display, GP=
U,
>> > Venus, VFE (camera) and JPEG encoder. Each of them follows ARM SMMU v1
>> > spec, however they differ from other Qualcomm platforms in the
>> > implementation-specific registers and also in interaction with TZ.
>> > Venus, MDP and VFE SMMUs are secured and require programming only of
>> > CBs, while GPU and JPEG require full programming.
>> >
>> > This series skips IOMMUs which can't be tested right now (VFE and JPEG=
),
>> > and adds only MDP, GPU and Venus (although untested, it is required fo=
r
>> > display to work) SMMU instances.
>>=20
>> I do have a patch series (sent years ago to the mailing lists as well)
>> for CAMSS so I can definitely test this in the future.
>
> Ok, let's land these first, unless VFE IOMMU blocks display on your
> platform (Venus was blocking display on APQ8074 DragonBoard).
>
>> > Note, to get display to work properly one fix is necessary, [1]
>> >
>> > [1] https://patch.msgid.link/20260809-msm8974-mmcc-fix-v1-1-50f2dcf18d=
2e@oss.qualcomm.com
>>=20
>> I've applied this series on v7.2-rc7, with the extra commits between
>> that and linux-next for qcom_iommu.c backported so that your series
>> applies without conflicts.
>>=20
>> So far I'm stuck with the GPU not being able to probe, adding some
>> printk's shows that in msm_iommu_new() the call for
>> iommu_attach_device() is failing.
>>=20
>> [    5.971154] msm_mdp fd900100.display-controller: failed to load adren=
o gpu
>> [    5.972991] msm_mdp fd900100.display-controller: failed to bind fdb00=
000.gpu (ops a3xx_ops [msm]): -16
>> [    5.974073] msm_mdp fd900100.display-controller: adev bind failed: -1=
6
>> [    5.974152] panel-s6d6fa1 fd922800.dsi.0: error -EBUSY: Failed to att=
ach to DSI host
>> [    5.974230] panel-s6d6fa1 fd922800.dsi.0: probe with driver panel-s6d=
6fa1 failed with error -16
>
> See the patch [1], it's picked up for 7.3

I missed replying to you, with this patch the display lights up again!

Unfortunately the GPU still seems to have issues, I don't have a log
right now (I think even SSH was dropping then with a bunch of log lines
appearing in kernel log on screen). I assume kmscube + more complex
workloads worked fine for you?

Regards
Luca

>
>
> [1] https://lore.kernel.org/r/20260730-fix-qcom-smmu-v2-3-18e0daf2d836@os=
s.qualcomm.com
>
>>=20
>> ~ # dmesg | grep iommu
>> [    0.127014] iommu: Default domain type: Translated
>> [    0.127052] iommu: DMA domain TLB invalidation policy: strict mode
>> [    0.739899] platform fdb00000.gpu: Adding to iommu group 0
>> [    0.741358] qcom-iommu fdc84000.iommu: iommu sec: pgtable size: 90112
>> [    6.006877] platform fd900100.display-controller: Adding to iommu gro=
up 1
>>=20
>> Have you seen any issues like this?

