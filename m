Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE021E5213
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675741; cv=none; b=D0u9t02qSzu/p3hgMOn0ShDemcw/+qmC1EFK9/0hQEL1+SceRTBcTmsLvSsqCLkQ3kssKLCx1roCKvyfXYjR78uTYPT9zjo9DsaDhXbcFf6PyAmUWomI6dSOpVEXQ0xGXE2PC6RTtVZq6+Imjq1q4ddxMnt6Mr9KGzlQAR+MBrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675741; c=relaxed/simple;
	bh=HzXwiqqDnfe41YiTu6uYFU8UDZG1ohDw66m7kk99BP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nimol+y63yRfzeUAekfCl6xFkSn3DFX+qDl0zSuytPpqy8FqA+13Q6+mk+nkn2TSmRssqiC7mKXmXDrWDq6dsxJ8ejhOluP4U/igBiEMrtjLzC3yw9lD+PS+Pm+C/AU8m+HWac/e7fjFB25grX6IWYM2tVXASXd3jXtpWVtUe0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U8+bwQv3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U8+bwQv3"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2350fc2591dso9612945ad.1
        for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 07:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752675735; x=1753280535; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuHTPSN5ob/sxMMWugl2mb75NZygOdwpDw39+8JfWkw=;
        b=U8+bwQv3YHoGhH6uofvUyNkUkaTxm5bB6DWhDTZM7FfdAlxagmo6wCnUOo7fXUkawq
         V6efpdyUDEHsuPkN1xikSVPJKD40QEyyxhoMGuRq+MXUP2TKTlrUpRxS7mkIi55cVMem
         PFzPPrF4xGaF5Lf9YFV0QNR61gA4yXM4c8pL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752675735; x=1753280535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuHTPSN5ob/sxMMWugl2mb75NZygOdwpDw39+8JfWkw=;
        b=lGcdPXkU3+XpSyjIShnZL38Y0wj1ZbkLOZNk82pkQVORLPcvn6/W7BNuI73w16dLqv
         /rf2rFtVhb0Wy83TqQHbDnan5i6ZUhEiqQJONms8cQzNVXxHef1W1hqGhHo76/BPxumb
         Df/PMJi3KBwAs3KyuUAykKSwIj/YNkKx9uEkLNvYwNTS7SQVQ/1EmazM17H6zYAu67qY
         s2S+scMsLq7ht4ZcmIbprqqUOT5LKV28qWl+1KNjpvg9w5CugL9GqaiLoxWXjgx5xNPs
         ZeemEg5iuIvADvhBweAnftQyaB4S4/BFPjm45peuvdIjKLc7xymEJnPq5URQo+j7KuKh
         lyxw==
X-Forwarded-Encrypted: i=1; AJvYcCVC9G6/PZGzZYE8gsn9IFXU4ABFfPFvMI27dZ99B14yQ6EPuxwcHnwaOJG19lDaRyed4hL67A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz86+gVcekYefUZzbB4CZrgGlMcfOXwtYmDImtV4FT3WVyM4cK0
	u5XFEeI5JMulv2XZuE5Mv1gj9SG7UgruQXPPD7T2GYS8iO0JVoa1MBmC9W/8KlAAsOeFNg2Yq6v
	RDqQ=
X-Gm-Gg: ASbGncunZ/8+82PHZDnND5vt4dgTgh/MpEr2Czai8mv/d+zeZLOwC85wduZ5mRmQIX7
	2MHiRpqlK0y5gLVx8QcqqTzmFByzoxR9esdofgLQf9e4709+J+G0gT/ztaN24eNCx5QdTroghqH
	j1AR18gz4z1O7AKAVxHwD3yn9sMQubzhXwnYkWfBAJ7bBl8xqU2yGZQ7+GpaUZguUoExfV5sRWA
	1RbO7Bcc9uAOhnrnZ6iw/tqYg6pl9LHHsXKyi7wmWTOZoc2kTObos6A7i2QtUzGzPIBaUJzVoM1
	/spM1O0w/U7CwcM7Y1tK1nKAUB9daspKu69UwIDJfSKq1A4ex6/86qYGvI+QlwDx2EwE6lYNZIb
	YZbHVfAO0YrbVfzZDAir9Qrh8M9DvzMTE/Emy6HXAeSAf7IrdpSlu3RV3FUAERA==
X-Google-Smtp-Source: AGHT+IFDUFmIgoVJwEBagndXEIfxWJmXNhoUoIXuHslylFt4MM4lzYDmpJT+Hk7Et1tvu+eN9gVrRA==
X-Received: by 2002:a17:902:cec6:b0:235:e5aa:f51a with SMTP id d9443c01a7336-23e1a43a3demr106550695ad.7.1752675734863;
        Wed, 16 Jul 2025 07:22:14 -0700 (PDT)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com. [209.85.216.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4285ee1sm126752405ad.38.2025.07.16.07.22.04
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:22:07 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-312e747d2d8so763275a91.0
        for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 07:22:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgAhd8xnDXiFu2hfb0xV/sEIFIM7sb73EBfUPNjG4LjgoPTy0IxMMzICi7zVcworl4qWlnxA==@lists.linux.dev
X-Received: by 2002:a17:90b:3e45:b0:310:c8ec:4192 with SMTP id
 98e67ed59e1d1-31c8f9bab05mr11330150a91.10.1752675724138; Wed, 16 Jul 2025
 07:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250716-topic-goodnight_cheza-v2-0-6fa8d3261813@oss.qualcomm.com>
 <20250716-topic-goodnight_cheza-v2-3-6fa8d3261813@oss.qualcomm.com>
In-Reply-To: <20250716-topic-goodnight_cheza-v2-3-6fa8d3261813@oss.qualcomm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 16 Jul 2025 07:21:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XmwiA_gX9pF5Dja1vezson7f21WHC8u8+Rhg_6OUJ+rw@mail.gmail.com>
X-Gm-Features: Ac12FXxTIFX6vNFTUbNM5dNMu4K5yloNK1nFrEKpkxnVSSYFOEXl7o-QWsvciQ8
Message-ID: <CAD=FV=XmwiA_gX9pF5Dja1vezson7f21WHC8u8+Rhg_6OUJ+rw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: arm-smmu: Remove sdm845-cheza
 specific entry
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robin.clark@oss.qualcomm.com>, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 16, 2025 at 3:16=E2=80=AFAM 'Konrad Dybcio' via
cros-qcom-dts-watchers <cros-qcom-dts-watchers@chromium.org> wrote:
>
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> The firmware on SDM845-based Cheza boards did not provide the same
> level of feature support for SMMUs (particularly around the Adreno
> GPU integration).
>
> Now that Cheza is being removed from the kernel (almost none exist at
> this point in time), retire the entry as well.
>
> Most notably, it's not being marked as deprecated instead, as there is
> no indication that any more of those ~7 year old devboards will be
> built.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Docu=
mentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 7b9d5507d6ccd6b845a57eeae59fe80ba75cc652..646814ec7d15f6d8a0136de73=
b7eaddae232ea64 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -132,10 +132,6 @@ properties:
>                - qcom,sm7150-smmu-v2
>            - const: qcom,adreno-smmu
>            - const: qcom,smmu-v2
> -      - description: Qcom Adreno GPUs on Google Cheza platform
> -        items:
> -          - const: qcom,sdm845-smmu-v2
> -          - const: qcom,smmu-v2

The code supporting this can also be removed then, right?

drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c:     { .compatible =3D
"qcom,sdm845-smmu-v2", .data =3D &qcom_smmu_v2_data },

Reviewed-by: Douglas Anderson <dianders@chromium.org>
