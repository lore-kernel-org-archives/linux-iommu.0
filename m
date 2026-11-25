Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795620283;
	b=vi/mRjGm901ojB49uuxCUS+65djJM51g8ad1TBPA3C+zj0WHYujByF1VMXxf8Og/df6j
	 L5LsqAmrkme2vm1ykceVvNy19vSWzZy89HKJhuBnvDqzbBuHB3eq04Z05A2nbzRoEE64W
	 dDojXVCrHhH4JI9MwtLS3r+CSw3i/Ej2pEcnZseL0yJn1CMyigfHAUScvtuu46CL5bOTq
	 RvSskE9d39odaUpjArioqHb+U5cxSo8L0DxVGQmKc0WSysP2CL6PHb8XhQ9QidB8c2/Ld
	 qFPdkodxMavRdDLE/BU7uoW/fBqis+yGWbb5pLWgnPYwtuTeVScQsKQMITvypgtN9jA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620283;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=BWI0oTPS6UWP+KHreqzTyFzt/bLKfNI1fMUEgGA2TjQ=;
	b=gr0sKCLBvGuf+D4QN6ZTivM5pZUatLjWL1vV1aMEAfoIDWkc1IgqFzVKMNw4O3KbAtBV
	 5HhOBi9qi8jMPvPbxiRKntKPW5rLhVwziz8u+EXhEtD1XlROjkAFzzghuHr5c4Pnu/IiD
	 KuObPXYu9hDNNLohtZYSAIW6ahLpSS2BNATtMtSoOTISKBWdubS86Mo9RhohO/HRBc9x3
	 lNZ5QwrbVKdKZrrU+A0voBPCrRdrGJqTNIsNQwKLWVt5s32rnHjVU5uM2MKwNOOvflHox
	 aVTbyFSuPljZW6PcH+Mx9sy8s6NRHkZ60/Y/hGYrIH56lZ3mzQsDfs6DtHdh6lkog2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="OpB6FU//";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EOL4OJbx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFD3606A335
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 15:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACFD3606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OpB6FU//;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EOL4OJbx
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APEM3pX724468
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 15:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BWI0oTPS6UWP+KHreqzTyFzt/bLKfNI1fMUEgGA2TjQ=; b=OpB6FU//8xOqb7OS
	5fVG54KpU7ZjNVKjctadQgIBzM1pOMtfT+p8RLJQKyYAAI7DZyJ5qt+UOaP/9pq4
	u8sBWRPln3bzRSPYJOuCVV7hYFjGloUQUfoatqf+FTAUdrFoUXI8IRA4nJgD5hO1
	itivGuWNLrBgEQ4KnYHzi73YpEIkNS2hpwNeAhy7ZKl8SxdU6IFb+LEhb4BFL6GZ
	DmcN5Y+58aqVqcFdGV9uBwFeAW+ByxC0qjFbCfgk8N4RUZhVJhAGLOUIiB4jt5Kz
	fAq9A5IwNKwk2eFTo41CSn49JtybruJZBKPkwkWdyxqWMvEUDUxgC06m1qXnG5Yg
	jtr1nw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5yaxrs58-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 15:24:42 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b505a2bb1cso156197a91.2
        for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 07:24:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795620281; cv=none;
        d=google.com; s=arc-20260327;
        b=GLHuZpDdouJPezIe9NjA4JWxjF9lKo1lzaWHq1VbNxOTzNiV58rdu+mW4xLNNIkUqz
         xsW28ZSStRMjG6RItjfA4zs5dyuVyGKCIdQ2XT303v56vaTBv6jOoGh34nOCyXyDbBgX
         adYg7Pv2ehXMnLOLk09b0la0N8/MkI3Fb28ESYNd2xif9rI3Qfak+Rb6m63YCcoKQgyZ
         7W3jSxe4E+LlGTso1dRM1JIOr4PrbmfDJDtCEbOPMB9C1xsOetMgHGFhmPOBgW/sJ1uu
         cSxenuGexOk+EtpQf/FwS7xOt8Pv5rbN0xGVtM+9LFUAkTuEOZ7n9Xtqbh7RcJjzNOuE
         KH5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BWI0oTPS6UWP+KHreqzTyFzt/bLKfNI1fMUEgGA2TjQ=;
        fh=JuRmEibJOpJma2nl/kY1G/GgmH5eD3RVvYT7mbCzzNQ=;
        b=fOwNhmaBh76OhcG3cWYDqH+zu6oqzQoKSr1GtPVDhU/3wSASbLDbKRo9ZjIY00nBFr
         gFhcTG4O/L8HUHCsOk9eyzynqLNtYsf9m9doPlDVF1554976rQYTJ83wp+9PdfdgZtrp
         STVWLh3ZrFqN1/vbN2AK/tLF0ILE5eKU8IKAA8+WIYPcUkeTywcN8kULmt9XCPVA1232
         qb4cOo0t1gSfCQU4pS+7cR3WZ59MFm6773nDA16X5+HpI23X4P+EK96eqVV7ipkDzN/D
         mYK1o1ReJQMaNZOnwFFKby0TklglplGsX3G0WHwnkmkN5g796rbRsjYDD0n5D4G77jWR
         eQPg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795620281; x=1796225081; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BWI0oTPS6UWP+KHreqzTyFzt/bLKfNI1fMUEgGA2TjQ=;
        b=EOL4OJbx+h1hN3QydstWVKUf9YmJwPuAechWpQ/R3Qa6GZbAwNdAj12+k29vyrXqai
         UEbgwI7VcSSnrjp+QrH+FZZocwnYZM/HGHiI0XPnUX3aCEgoqkqAVBT7baO83FGmLaW9
         fi9mD2qf6r73Esf/+Hy+U/KrMC4Gxk2miqG3LNOXMG/PKCeJTw7+LyZRdt+OwiJo1Xci
         FEx2EhF6J14QgQAQFUjy/S1Qsa2PzKho09NMGT1nOjKqF8jf1mgqpSL7KTTQRu129O+v
         mDUmdD0kHJ/jRcCl5K5eFIfKmYz81QLn0soL9JiEIisEgEy6q0gOsUSt5lKAAc8rFiHt
         NiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620281; x=1796225081;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BWI0oTPS6UWP+KHreqzTyFzt/bLKfNI1fMUEgGA2TjQ=;
        b=Mpq8+VDZgDOSsSVL8Q2pblESSv1guv0OB1xuQcnNz87shpieKqu/1dS4Ev3yOz2dFE
         Qhfofc55vTQ4QshyeXVcGbGjmUsYGPmJ7fU6lIHubCLb2dY5c8xQggqYhXq0bC2nqQEX
         BxRWNQrm98wFDw9qtxD3WNi9jxg+SsfjqGMI4oxPEY5PwcPJ+unE7+MyhJXClYZiPMBL
         Gunepr0ELuXIfbtcvxMBtokFm30TcQ/FJU1TjHLYVtHNcrYexUrXsT0JD6LwxtytYAL7
         I7YnpDSuqsr7++dEYSH2kPIeacuxlo6OV+ACuEcEM9J9k63a7lJFkTs7OyNVWyWjmBvs
         q7YA==
X-Forwarded-Encrypted: i=1; AL+hErETfjDKLFUtzor96jU7oUnVKQlodJ0MyCW9tuULGLBH8sqW6IjaltdUWQuvE7NX2HgLUoWe9g==@lists.linux.dev
X-Gm-Message-State: APuU4Z/TISVXmINjs+8Bz4piEyn/Kyq4CLdpgZmNYB7YrxDCs4fjojFV
	cqn2CV+qkf1lk7Dz6PcmJ4fsbO921TmVaSzB/ePYuJGcApqIvOghGo1uAN2KWq0cNbG5l34FZFN
	mKNAvkoCGWMV3davmWindG8blwLO65QZ2//EOSmoJJk6jXWZ1XWFHVvB7nrckqJrAoxjZNWJOBb
	1YT7xt+rKtL9dMsB78hTOXuTjcNiSO9dWS
X-Gm-Gg: AZFdTZfeD8NXFHALbwSXVf9EiYPywzPyPEdQ52v43mIw/iQnbRviIaSC5n8ZfmscAU7
	h6IQxsLieFjaa8I9H4foh/sVHuLrKVqgiES1l1aEgEOwxpuYRSCu1EuWCN9NzYt2xfrYW6Mz4U6
	AQ8qqah98kqE5M1okZ/2pww+b/SjKCbZw0vhaoWxrZwe0K1Qsgok8uKIdKgA==
X-Received: by 2002:a17:90b:2ecb:b0:3ac:8446:c1a5 with SMTP id 98e67ed59e1d1-3b41c988620mr15762964a91.48.1795620281108;
        Wed, 25 Nov 2026 07:24:41 -0800 (PST)
X-Received: by 2002:a17:90b:2ecb:b0:3ac:8446:c1a5 with SMTP id
 98e67ed59e1d1-3b41c988620mr15762922a91.48.1795620280668; Wed, 25 Nov 2026
 07:24:40 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261125-halliday-dts-v3-0-5c8311c0b70b@gmail.com> <20261125-halliday-dts-v3-2-5c8311c0b70b@gmail.com>
In-Reply-To: <20261125-halliday-dts-v3-2-5c8311c0b70b@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 16:24:29 +0100
X-Gm-Features: Aa3M54pQyww1I_PbdCBse1VupHYmzcQQ8jGP2HKCbG8YvURb7jcXXUW3MJhTLAI
Message-ID: <CAPx+jO9aHqEwVu3j5CdVTsfrhk8cMRawA5rj51EA7AdVtn-U+A@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] dt-bindings: power: qcom,rpmpd: document the
 Halliday RPMh Power Domains
To: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>,
        Stanley Jhu <stanleyjhu@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: d1KJjA1qBN1L5J6LP7JqGRMFqgvCV5Qv
X-Proofpoint-ORIG-GUID: d1KJjA1qBN1L5J6LP7JqGRMFqgvCV5Qv
X-Authority-Analysis: v=2.4 cv=ULpIjyfy c=1 sm=1 tr=0 ts=6b06fdba cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=yRSEYQ9GznzmN70rNvQA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2MSBTYWx0ZWRfX6cv5pNRETL1c
 8kgOS4XEAXsUkQitpeO/f7+ieDU86aVyCB2qHTPBFcLjlaScthIn6NaVnSd0lNd6F1TJiDfsevN
 LVE/JJ0h4cbnms6+RLORLsF1qj2GGbcWL+W20Iq1r5ygzLYLVvYmqJ2uDOIvG1Gy1hp7ZzPGUxw
 2dzJGQWV6MQByjZILj0SDvGb8Sw9cSzewAhFkdbOpmtygk/2MzMv/xJGFRa1I994bmktlIybWo1
 WhyBrILrcBot9It7wq8R81MTLhWmTjuYhHrf6ip4NnEriiyU07q/eI4fQY3nqFpUoa49XIWDa8Q
 21f1YfWqgEETkWVIW10VPVUxO35IKaw+ndt46LHVRYyFlxF3+j8fHcMJ2xmpz8+yf+L7itbVu/3
 j8E4DPYlk4Toh0yPXOha+dMQscyyK1mMTf06koFKA2ov9wGoFHphvWFTHUKVWSOBbwmj38YoYS+
 XJoDGuSYf1V8fdwdM9A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2MSBTYWx0ZWRfX+zb0B966C9n9
 R8zrr6UKM4QjhpmoWaPWbBWXpLZ4eZta3K6FvKzkso9qqxLXEZqIzX4+9Ah5K3n8tCPaFH8eqaA
 84VNJodYGwgN4zNZziglzCfPWlFFJgs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250061

On Wed, Nov 25, 2026 at 4:44=E2=80=AFAM Stanislav Aleksandrov
<lightofmysoul@gmail.com> wrote:
>
> Document the RPMh Power Domains on the Qualcomm Halliday SoC
> (SXR2250P). Its command DB has the same power domains as SM8450
> (CX, EBI, GFX, LCX, LMX, MMCX, MSS, MX and MXC), so use
> qcom,sm8450-rpmhpd as the fallback compatible.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>

Applied for next (available at the immutable dt branch as well), thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Do=
cumentation/devicetree/bindings/power/qcom,rpmpd.yaml
> index 8ee1c25a7c9d..663baae9cc64 100644
> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> @@ -82,6 +82,10 @@ properties:
>            - enum:
>                - qcom,maili-rpmhpd
>            - const: qcom,hawi-rpmhpd
> +      - items:
> +          - enum:
> +              - qcom,halliday-rpmhpd
> +          - const: qcom,sm8450-rpmhpd
>
>    '#power-domain-cells':
>      const: 1
>
> --
> 2.55.0
>
