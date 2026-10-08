Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B49F370AE7
	for <iommu@lists.linux.dev>; Thu,  8 Oct 2026 06:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791441986; cv=pass; b=Yffu+J94+4HGqtZIWtstEAIb/d/aWoa8xRUKDB2pHkria4wsywRMhKTi27rTuTMT/x8KiUYeD55gYmpApV723kHpDnPHS8pCEh5ELMOQZ8BeRaAgwyHu7qvmzOG9rCu3RsChgwYYblzQ/iMFcjI4tTly2jMuWPTrH7qaJw7KMLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791441986; c=relaxed/simple;
	bh=5QtGSacmsoONB87IdoPl0Fn+Eom9ihnvfpDZQqc0fEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQFGE68FMTWL2fCorFLabf3/6jX7HDRBHguGPbhlmM0cTByX0AMCK9tpUCsmh0H8XKHqG8+S7nHFbC5V+WwnYwULtTfW6NWcoamcj4132yqrYxfytmG4YZncYt+PYClqZPlHKtP1N1fRPPlLlKStDlha3zISe4GaabbVfNnfMBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nro0vkm5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a/qRB3r5; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nro0vkm5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a/qRB3r5"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6984Bm6x1433860
	for <iommu@lists.linux.dev>; Thu, 8 Oct 2026 06:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ynir5UKDYCHKsIV/SiEktgpoNpmpfZkJi8BxEZtVkn0=; b=Nro0vkm5wMnB3qtP
	+4w2I/Fyky8W2z1/nU7SV8mP+TXgGrsM2pSj55S4cKFo/ftJqddEZcRYWfkVOSaD
	VZV9Cuu4v1XAvIls3hC2ZfCVrvR8YKSp/DEJhsPnZOcoY9UWEefVy572jTGOK4a6
	UkSnVOtkVVpwqnx2+boFXZHyok+t3FSC4VPALXjC6SumxoiH8JZ+ktoIIlONkhXr
	o0+BNnDECXDJDTFGTT72UNdje9kVss2wlkfu4Iu6xw0FvFFyWhnrEJ1V1xEBhIyu
	qsGdfU0aVS87GIzlWu+jv0r0WynzNWsKzNYs2y14p2kH/QGIiGlPf5VXcxWoa6dj
	PkKk2g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe3hm9r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 08 Oct 2026 06:46:24 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbb92868263so2925974a12.2
        for <iommu@lists.linux.dev>; Wed, 07 Oct 2026 23:46:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791441983; cv=none;
        d=google.com; s=arc-20260327;
        b=tCdJMjpbFLEcGw2vZ1qUaljULF3TFhos7ujcjtfGHPBQbpaAaiH0SvtJ7YTrnMoLPD
         /vkMHJ3fMvXb3tavb47lIPKEYRCz+TEgDY87SaS4G2dv9V7+t4iF35nHuSKMM23FndS9
         B/K/+F2FF5EhVTpQMMLt/KMQknx0fktshemq8ipzoVJ8M+AfSoKG6laoK1oVtgnnYaew
         Wu6EFUIgzPxHrbTLR8jdD0jblE1/hfQgwnrUhWk4MXxGFkRV2pWNhZkdZtyZg2EBCLOl
         ebMAyeCffPAktyWhOIiLuJ32EpyZiZuiLCvfJmPJQcQVNdzVb8ZyD5T/ZN2hBTDq6tU2
         i4gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ynir5UKDYCHKsIV/SiEktgpoNpmpfZkJi8BxEZtVkn0=;
        fh=5Qw6/6xuXtdCr7wRQ7En+cH8imLt58Za0297UO2KeTA=;
        b=ceWwC7YrG4VHQ85/lp5pDUmRQ7YLFi5ewd0ejZdYV+z0ewKNgTi8JUybfifvU4EEat
         E4rLSboiATr3i5tYF1/q0ef/Ppzr42XAfyMead7A3eVSQ5PDnydZ5FiKW+wLPfRB9ZnP
         /KiqhDM6KZS19AyABDthmOu6UOcgCCQVyXqcZ25czACmSWoTBwv/CUQ2qlw6dgGB0KUP
         eUM8Mh41pJgy69xUJNgSCyeeaJaXXeyd4YDaC6iBW6jAlOPQf/AbrCiqQKZJL+jG0+lS
         L+0WPZn2pqxf7RIdVLh8cjXJHyjTYUE1TQc8Y4ltm55a86+D1pMGCukXzCRWcmK3Y8Yd
         kL9A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791441983; x=1792046783; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ynir5UKDYCHKsIV/SiEktgpoNpmpfZkJi8BxEZtVkn0=;
        b=a/qRB3r5b98hPvfjQfjncaBkOJyggPEJG07IVOGlm3khpkkjTZ15ImEEGljSQ2GQhA
         1kgYeGBZ9f3Q0VJbUqOkQ7WBnWVnAn4wouW8Cp9wMCstGuIZlO0Pu2BkvNH+lgxitnfs
         1lJBxaSLbGR3m3LA4OhFLFpb288Kg7AMBd0Hr6kSky6IcHAcj4/1tMWqC/A2eyn6kxR7
         kv0tb4iHfxLyzniHSCKQgixTYDMeKRveZVQXP+0jU+MtnKv7a/EufuIV4lvDDM5S2hzi
         eyg925xNP8BVLslVdxss/sFjWbbytrG/Yo9DGurEBNurklkvIKo+HPq+qI825Lm/n0vP
         ZgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791441983; x=1792046783;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ynir5UKDYCHKsIV/SiEktgpoNpmpfZkJi8BxEZtVkn0=;
        b=oodp3OX9GG3Quti+6XXHL2EMyr7TYl0XLAFX4jACRFCtIlV0kh/0RdEPJrDemnXYi7
         c1TmYhlmBvU3IIu/sMz1S/+JDnCnv6yOhKhKVvmX4mC0Akx7XdFTwvRsieAs76BvDeYX
         T9wbQNnL3Kl9SJlQmSO/VtKJXRgdSZZouIEI1fOxV6BWA4yr6w11C83I4bkGLfgBoZc4
         /EmfIOAEQEpvBbyqIFLODdVZZadMfwqOoGZqfZdpaQovU9K8BPcMo8MGwul/q8gzddV3
         dCfy+O/0LoXk/kFtpAu1hCJGOlP9sSmHlUOOmRjk7OclzT8D1KUQkY7rasvNqQ5jdjvn
         w3VQ==
X-Forwarded-Encrypted: i=1; AKwUvByojGCpJ7DiNyjpo1d1SR+XqHnr+WiRA2NoQo0RZWKx3XEqcJpqJltQGHfRA+aUAzx8aNh3qg==@lists.linux.dev
X-Gm-Message-State: AFuF++l0Dcqb8lDcUrjUOtWqJ8bvmEYz/c7Db8evNX0t6gaqtRxXEzYP
	AHo821QXnNTcXBGK55HRo7FJPIo6HgAruCaH0ZxGe1feLPR/NmEiNRM2TufUI2feZsqUp5YH811
	VDy9BKMz5O/cSp6QQd9C39t8uSwvSmXisJvOxW5NQzruqEaz8leysKBWYercbQGCGPJ/xsXEuK8
	bknceExZTReQkHiAHAZTF1SaimuB9bgv9s
X-Gm-Gg: AYBFou1vSIEsZje6XloA5SJTCkC6qkJfhIh1bJgmiEO5t4zSCBhYBN/9Q5/kW5j1PSg
	Ph/l6vFu4u97woYwmPZCDrE9Ym5HvUthmPRzs87BTn1OjhEKzjpHnDocxwCDvyspo9nVr3lMCml
	Rw+FrFDU6IwaEBg3FuxVBgfMdEpyxvjaHe9Fz8WLfd/4Mlx1MUyw2l6x+1BA==
X-Received: by 2002:a05:6a21:62c2:b0:3d3:adbf:7781 with SMTP id adf61e73a8af0-3e13403e252mr3919083637.22.1791441982812;
        Wed, 07 Oct 2026 23:46:22 -0700 (PDT)
X-Received: by 2002:a05:6a21:62c2:b0:3d3:adbf:7781 with SMTP id
 adf61e73a8af0-3e13403e252mr3919033637.22.1791441981779; Wed, 07 Oct 2026
 23:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com>
 <20260926-vpu_iommu_iova_handling-v5-1-0322ca5dc10c@oss.qualcomm.com>
In-Reply-To: <20260926-vpu_iommu_iova_handling-v5-1-0322ca5dc10c@oss.qualcomm.com>
From: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 14:46:10 +0800
X-Gm-Features: AclHuK9cxR2Z8imM67b3vN_Ew1tvSO6gdzHAd9wpAvyBxUcgGM14SQWbw8GocXc
Message-ID: <CAFkd8hujKYhXveemgPCbsUk5DFB=fQSxqK_-69fP5aPzoWSzbQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/13] dt-bindings: media: qcom,venus: Add context bank
 subnodes to common schema
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        "Bryan O'Donoghue" <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Abel Vesa <abelvesa@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAyNiBTYWx0ZWRfX2uOOSYFZvhBd
 2IFO4TxLwtklolir7723w35MJhcBeMnRciMZE94uaBVwUuCF2i8aR9uASJKbvCL6YIybL+D98KS
 DRqXeOgLdXu19CM/r9xeB+jf7AB+ozA=
X-Proofpoint-ORIG-GUID: qbkxjV_s_8GtKiYCnMX0GBQd2373j52V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAyNiBTYWx0ZWRfXxZUQPafyFKDn
 fCQd/eF+EMY/GeLgvc53kJWQLz/wJknNwmDeuJ+uliVkEG03wrHXESdVov75KkaPGyKiYb+Pp2/
 DKZD7xtE/jUkz0TDnFibAsefwQMH/sav6WLW+flBqpzarduJ1ff0uEteObYG3sT15wiXhPbW5tn
 n2Q8c1mPhdDpdkqucqAFOrKkoAi7TGIf56KTdYGP2wEmFvVuxCF0lW58g839JNzhAcm0/aXXVGA
 UxMIAEr0Pn/mqAUc68ZxLAGdP46L3AECBF0yXqa0gEZ7sa+9N0q0d8URp4o/YPemVtPUZJYn4QO
 r4Z0D2P8Tm0gWagJcdqkiKTdIu/6g89eTUOGfLnf3ilJ6Qw0MWHostcfT+oJfvDO543dZPm5bpW
 GALRxxdZZOMFs4NKwYNZXJ0YL/R5Bp8lQHG/cJcOtOzzwWwQgc6+6ogV5NrUX/O7uLnacHB1hBA
 +KC19KJzbucbdfbaKfg==
X-Authority-Analysis: v=2.4 cv=IIuXmQvG c=1 sm=1 tr=0 ts=6ac73c40 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=INH18kujmAq1onTB90cA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: qbkxjV_s_8GtKiYCnMX0GBQd2373j52V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080026

On Sat, Sep 26, 2026 at 2:38=E2=80=AFPM Vikash Garodia
<vikash.garodia@oss.qualcomm.com> wrote:
>
> The VPU issues DMA through several SMMU streams, and the hardware does
> not give every stream the same addressable range. The non-pixel stream
> cannot address the low 600MB of IOVA space, while the pixel stream can
> address the full range:
>     +-----------------------------------------------------------+
>     | non-pixel stream addressable range (600 MB - 3.5 GB)      |
>     | 0x25800000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+
>     | pixel stream addressable range (0 - 3.5 GB)               |
>     | 0x00000000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+
> A single "iommus" property on the video-codec node puts every stream in
> one IOMMU domain sharing one IOVA allocator, so nothing restricts a
> non-pixel buffer to avoid 0 to 600MB. Once an allocation lands below
> that boundary the hardware faults, which shows up as unhandled SMMU page
> faults and spontaneous reboots:
> https://gitlab.freedesktop.org/drm/msm/-/work_items/100
>
> Given that the address range restriction is for specific VPU stream, it
> should be ideally be moved to that stream. To achieve the same, a subset
> of streams is now represented as subnodes, so that each can be
> associated with its respective addressable range. The design was
> discussed and agreed by mainatiners here
> https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.o=
rg
>
> In the past, this limitation was addressed with an iommu-map approach,
> with the iris driver dynamically creating the devices. That approach was
> later concluded to be a hack to avoid having subnodes, and was NAKed by
> the iommu maintainers. It was discussed in detail here:
> https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.o=
rg/
>
> "iommu-ranges" on the subnode describes the *allowed* IOVA range that
> stream is allowed to use, so the IOVA is allocated from the specified
> range only. Define all the possible subnodes so as to describe all the
> VPU hardware iommu interfaces, both secure as well as non secure.
>
> address-cells, size-cells and dma-ranges declares the 1:1 DMA
> translation into the parent.
>
> The parent "iommus" is kept as an alternative via "oneOf", so platforms
> that have not been converted to subnodes still validate. New platforms
> should use the subnode form.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  .../bindings/media/qcom,sc7180-venus.yaml          | 15 ----
>  .../bindings/media/qcom,venus-common.yaml          | 97 ++++++++++++++++=
++++++
>  2 files changed, 97 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.ya=
ml b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
> index b21bed314848480b82153e49602f0b19e08e7335..bfd8b1ad473128c974bce8463=
9cb0aff59d8c2cc 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
> @@ -91,21 +91,6 @@ properties:
>      deprecated: true
>      additionalProperties: false
>
> -  video-firmware:
> -    type: object
> -    additionalProperties: false
> -
> -    description: |
> -      Firmware subnode is needed when the platform does not
> -      have TrustZone.
> -
> -    properties:
> -      iommus:
> -        maxItems: 1
> -
> -    required:
> -      - iommus
> -
>  required:
>    - compatible
>    - power-domain-names
> diff --git a/Documentation/devicetree/bindings/media/qcom,venus-common.ya=
ml b/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
> index 59a3fde846d2196ab1e4588eb396012ba6860712..68d5e592a028c5eecde04ce72=
cd5ae6815ba5c82 100644
> --- a/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
> @@ -47,6 +47,93 @@ properties:
>      minItems: 1
>      maxItems: 4
>
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  dma-ranges:
> +    maxItems: 1
> +
> +  non-pixel:
> +    type: object
> +    description:
> +      Context bank for VPU non-pixel buffers, including compressed and i=
nternal buffers.
> +    additionalProperties: false
> +
> +    properties:
> +      iommus:
> +        maxItems: 1
> +      iommu-ranges:
> +        maxItems: 1
> +    required:
> +      - iommus
> +      - iommu-ranges
> +
> +  pixel:
> +    type: object
> +    description:
> +      Context bank for VPU pixel buffers containing uncompressed video d=
ata.
> +    additionalProperties: false
> +
> +    properties:
> +      iommus:
> +        maxItems: 1
> +    required:
> +      - iommus
> +
> +  video-firmware:
> +    type: object
> +    description:
> +      Context bank for the VPU firmware processing domain.
> +    additionalProperties: false
> +
> +    properties:
> +      iommus:
> +        maxItems: 1
> +    required:
> +      - iommus
> +
> +  secure-non-pixel:
> +    type: object
> +    description:
> +      Context bank for VPU secure non-pixel buffers.
> +    additionalProperties: false
> +
> +    properties:
> +      iommus:
> +        maxItems: 1
> +      iommu-ranges:
> +        maxItems: 1
> +    required:
> +      - iommus
> +      - iommu-ranges
> +
> +  secure-pixel:
> +    type: object
> +    description:
> +      Context bank for VPU secure pixel buffers containing uncompressed =
video data.
> +    additionalProperties: false
> +
> +    properties:
> +      iommus:
> +        maxItems: 1
> +    required:
> +      - iommus
> +
> +  secure-bitstream:
> +    type: object
> +    description:
> +      Context bank for VPU secure bitstream buffers containing compresse=
d video data.
> +    additionalProperties: false
> +
> +    properties:
> +      iommus:
> +        maxItems: 1
> +    required:
> +      - iommus
> +
>  required:
>    - reg
>    - clocks
> @@ -55,4 +142,14 @@ required:
>    - memory-region
>    - power-domains
>
> +oneOf:
> +  - required:
> +      - iommus
> +  - required:
> +      - '#address-cells'
> +      - '#size-cells'
> +      - dma-ranges
> +      - non-pixel
> +      - pixel
> +
>  additionalProperties: true
>
Got this warning:
arch/arm64/boot/dts/qcom/nord-rrd.dtb: non-pixel: iommu-ranges:
b'%\x80\x00\x00\xda`\x00\x00' is not of type 'object', 'integer',
'array', 'boolean', 'null'
arch/arm64/boot/dts/qcom/nord-ride-embedded.dtb: non-pixel:
iommu-ranges: b'%\x80\x00\x00\xda`\x00\x00' is not of type 'object',
'integer', 'array', 'boolean', 'null'

Need
--- a/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
@@ -67,7 +67,9 @@ properties:
         minItems: 1
         maxItems: 3
       iommu-ranges:
-        maxItems: 1
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        minItems: 2
+        maxItems: 2
     required:
       - iommus
       - iommu-ranges
@@ -106,7 +108,9 @@ properties:
       iommus:
         maxItems: 1
       iommu-ranges:
-        maxItems: 1
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        minItems: 2
+        maxItems: 2
     required:
       - iommus
       - iommu-ranges

Thanks
