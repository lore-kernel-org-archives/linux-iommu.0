Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14704D37A2
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603871; cv=pass; b=btd4S25t29btvxcI8Bgm+uuTkgyt2VPyGnhm20UgtCUltLzPgxxdivIFcNzN94hBs9ChNkWBNLzS3vBZYkOMt9wzRh6WAHQycqmHG4ocdxAgPYz0ZZzuH/Z3uOkbF7QXjARzhYE2tyFB07ze3h79tYSardeqvH87wriSV/yOq6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603871; c=relaxed/simple;
	bh=N0apPBi5a5rdeR6XkE9u3uUSLlm4uI9nB9Kynheh+l0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LegwDX715uxy7kG3styXTssGHZpG2I/ezztr5G0bawYNmDt2WsKwH7RU/atwsugl7aDAfBij3K7scPyuukFHWsC4RKKmygMTkMi49PTPG2yOkv0H6CYdFPxNRZ9l7Fxv1oNFKlUMfY3m0MtBqV1UQ+hbGYfa8C2/2snEj1QMt4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z4tRZgHZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZthcBuwA; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z4tRZgHZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZthcBuwA"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBA6v41433685
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 13:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KNeJ1ZSGtxogqYjubG/I2m2j0TylLASWTRkIlPxaG/Y=; b=Z4tRZgHZskb8ptT5
	TWLgXlXd5ZEfOMXoSIMOXv3xiSCfmZPrN/BXEN2Jx/EI7xgxsl/mhtg23qiOqhBr
	lotZeIr931hrlSEd5cQ/+wfndIUB7MMIEPhy0N4qQaoL3vx0QDP3gKzGCBMkjA4K
	qZEViEARpzKBw/bZJdJ6k6fM60UXmpX36/eFY3dIVjAN/AFSwPSLBAOzinZyFOZG
	8mAxM8Svcg16uWsn2JDQlVfu7pS1jD7EKG1O73xL6IcpK9DHPvN80Fj2n8ZkDcIH
	gzgCPX/52m/fh2UgSttxIDJ4qB8q8S1LQf9euuiVEAdLjZcrqYl5RVZOicTCxXKu
	X1l8WA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj2s1tha-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 13:57:48 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86ab8302b54so2399879b3a.1
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 06:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790603868; cv=none;
        d=google.com; s=arc-20260327;
        b=ZzKiO5YpKbdw83nzj64UIMfO764w4O62+u+nC865khS21SsQPjJ+zkNtJ8iP8jUZKC
         ngA00BDPo7EKVCdW+4go01QT0uv2PnWpexxlKWJEa4s9eYxY7RU+mkyw3WGj81yDYkA6
         Wy/lXjZsKhoDfN/B7JEW8tkEqhTB7D8X+z1E7lfj4yVILXP9VBmP59s77jLHcG5WIX4m
         KB1j+ODCJtqiDIYKgt3BeaR6dMBGJAr7e9Wqdge0qMp9m/wQ3WEbd+bsrvMChx+OoGo8
         a+zQXke/vLX+5EoOvEoXJGKNnXGE8TPf9rZHQt5L8ciNkVlrFEZ1NBBeagH2g7sYkiO3
         JZnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KNeJ1ZSGtxogqYjubG/I2m2j0TylLASWTRkIlPxaG/Y=;
        fh=0PADFc8DrqhrAFpq4BJe1n53A48JSCUNOjhK2wUnruE=;
        b=EiQcjGLxckebvs870yUcDtHq1JL9PdF38nrkVyc3G+h8SwIkpUjd/vFrO1ZqkZ+0FN
         uw70l6nsErAWCgY85E5GJP5h7n9WiF2WE4dFLnbSGzD2zNSENTdMhWtxskwZaSaSsUNy
         PkMORKH7Y7we0TwC0LcSJCVNso36KuXLm91etVF96bZa/9054qsSB+Rz74vajZnqTKzQ
         wYX28m46B9EWjfTGy5KbwNdw+SnZwhs/N5uEzItserjr6ABzR0Q/d8SyJCeNW+UhljC/
         WOKo7Qn+fPAbv4G1c67KwyA4pUPVZ7kWloWdWfabqXyF7z/zD1q+3ztL/CllHJdqkS/j
         oiMg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790603868; x=1791208668; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KNeJ1ZSGtxogqYjubG/I2m2j0TylLASWTRkIlPxaG/Y=;
        b=ZthcBuwAEWkQnp4MEOseHo6os6lXCibXt7ZPWNSjVOTUcBqH7ladx65m2GXsk5cvnW
         LtVGhIgPt6mmYNg4gHwDUpl/OMHKczLBG2Zl6bRR7R2hJO1NHGgA/twFC5cueTvu+rVW
         jnT+Q63cq1CrF/6HzuPXOQ4mFSEb7T8SixORrsXlMmsftKBasoJ29oCk3Lrorfjxm+3d
         u+FFapV3BDgKpQzzGSn9TbmxqGBH5tLmrGMH87UdvmPz0FLdkxnKRzoDuNanqRUMJYAi
         0WfHiqbXXSCUkwpEgaHG7E4O0p7JhUp/vR3Rj8lSQ/51zv8XixfsUQfnXvIrD0ru7LCS
         seXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790603868; x=1791208668;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KNeJ1ZSGtxogqYjubG/I2m2j0TylLASWTRkIlPxaG/Y=;
        b=Bl7kJN1o0MS4IAlTqlvoJLI7E/J1+GzBCI1t7KbaoeOcwPWM743HVkoxoW1OOmDG6p
         tLMOTlkei66cl2ZJ2mWnPM/cb4U2FKFCmJtFDcskcCgAhl8vEjH3pvJNDitvnwnxkdcD
         wRVcXjdS9nmcHNsT6S7UPoIN0I0f8i90OodmwT/w7Q2qa8kd3G4aH16u+7dXl7DK5d7I
         QPsmsauCoelkLa4xeC41p9zqTfswjGQ/M7qDhrARjHlDnouvpiX8aIvQEXVHEQ7kyIKZ
         SzFj6XRzMxUoIZsLq3/Ub05selfHLIj94IpnNuP46fQrgBe3BMQBDngAocyxj0sV4bDt
         79ug==
X-Forwarded-Encrypted: i=1; AKwUvByfMvLS9QpqIxIR8ZqVmRJDkb+ok9z4ATX0RIRSEsxyO/wL5kTlSYYiVI46g7PQZoF4i6n9zw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJPxcqR/yzRspDbiaq2agu+ecLp7+kfzMfbBLa8PWLkpqI3adVb
	mjKE9bsE2JmldW0o5SQptcn9DAc5lv6Gpl6bT1akAJfaNmOr2NDR2PkEVo9QCPE0goytM0dFHDW
	rsIFMwBvdzH7jqKaObCzqai53UZ6xbn9CjHCT/LJvG30c3W+x/yk2U4ZTffI6iR6iOeQvpcoqsY
	i5VBBCf6YW3F52tPJaTLv6IdoCf1Ugfps0
X-Gm-Gg: AYBFou2GP7PZEwoBralAKeZ3YoOs5bFXpa8NBpgeUuYbuit3SES/fl5yowIQwXlcr4L
	YemmgoQjzQMIwn6zHZ5ZKhlKuS+/XtamGsHK7pmmPf0IcecWI70S/VdG5g9fp7NntSBeCDspXpa
	kOk+qk/yCToQox82BTvWU+3iKmNFwWNn2EPozDOZJ4aNGesGVkf3p/1KQlBA==
X-Received: by 2002:a05:6a00:950f:b0:881:c881:96e8 with SMTP id d2e1a72fcca58-881c8819a45mr4006745b3a.23.1790603868154;
        Mon, 28 Sep 2026 06:57:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:950f:b0:881:c881:96e8 with SMTP id
 d2e1a72fcca58-881c8819a45mr4006707b3a.23.1790603867726; Mon, 28 Sep 2026
 06:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-4-b96fd3fe298b@mainlining.org>
In-Reply-To: <20260921-msm8952-initial-support-v3-4-b96fd3fe298b@mainlining.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 15:57:35 +0200
X-Gm-Features: AclHuK-nE9h16BssbY-0V-0Lcqrz78yNjoqqCVRnCD5BWpC1wzqbo2Hd-T05VXY
Message-ID: <CAPx+jO9Vj=42dHEwLzTHe1b+nrvip+ibVv4iPquxwJKbFAkm=A@mail.gmail.com>
Subject: Re: [PATCH v3 04/19] dt-bindings: power: rpmpd: Add MSM8952 power domains
To: muzafferkadir@mainlining.org
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1NSBTYWx0ZWRfX2+zgZuQBwInN
 pU5X2tnlUgT3zw72JDt5xwNmr+T+csDqUa/PzBS+lcLhOnt3VdeDUwcT4gEWFIe3/9/sJyUf6Xg
 nB7PZ3qQv6Lh7V72Qf3QBpO28/IZatyLdNRnZUgv/lw1gykSQEPBXmC64VyYI0G+NZsTokghtVv
 xAMhVbSjTn4/uztSEOu7KI74fChdWxxQTgnUyL9QVMUMCtnD8fZ0/7QiOAc1D8RxqGOX+8YNt4c
 AlQc1ZZqEoYd9RJO9Yy2q0FY/c5Q7qZLJ8wskG52qzMSk4dGWEJz5pPDI2QSFyl6w4nEZxjiAR8
 bIZrZKzuQXf+GS8xNeP0bd6gL2rV/dyWXsEmROehBX2pL1EoW9+cEi3YcUzsdykc6ehT236sIQM
 Rcu5oPYSNpXNbhwjOduODgSSns4gJDR77rlHkoPTzupR+OuX5RqQmD22+cccPru9b63jM/N6olU
 7amzAKuqE2ReKqCjPPQ==
X-Proofpoint-ORIG-GUID: H7Z6GWKC9N1nFHtjmCPZ6ehBA2YJiSXP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1NSBTYWx0ZWRfX26Gi7mFJm0Tr
 WvtbooXuP8pxeyauiJXtHVqdZcq5I25O2OnppIkKLZbiZt7kYh70nK/8WS66Xg0rS0Gbpcucyb4
 eFt5P7Ce7CWKH0i0XtoAzTR2+GAn5pw=
X-Proofpoint-GUID: H7Z6GWKC9N1nFHtjmCPZ6ehBA2YJiSXP
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6aba725c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=OuZLqq7tAAAA:8
 a=xo1k5ONJVskqAlz3UKAA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280055

On Mon, Sep 21, 2026 at 8:19=E2=80=AFPM Muzaffer Kadir via B4 Relay
<devnull+muzafferkadir.mainlining.org@kernel.org> wrote:
>
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>
> Document the compatible for the rpmpd found on MSM8952.
>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Do=
cumentation/devicetree/bindings/power/qcom,rpmpd.yaml
> index a70bfacbc5d1..8ee1c25a7c9d 100644
> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> @@ -76,6 +76,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,msm8937-rpmpd
> +              - qcom,msm8952-rpmpd
>            - const: qcom,msm8917-rpmpd
>        - items:
>            - enum:
>
> --
> 2.55.0
>
>
