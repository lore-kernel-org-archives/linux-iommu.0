Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E1452BE34
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688871; cv=pass; b=LdQ93Nft3jAJqG6WbWBZfUkhBVZvs0GVZjGSO4/0hfBKm3qYfjHbKgJZctRsRIqLE4DOSkYBJ6YfkaAFc/C/ue54FtkgSYNDKWVAtT6z/Wjk9VWjPnQ/zabzX2Brh+PNN2Kmyb1EtA/QfffkeOBe4QxBVQEUyGILgTjlxqP8Fjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688871; c=relaxed/simple;
	bh=aatIQCpb5b6E18tOT607YiK+lREgF4JTQbKPFrO+iVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBQB6ubOErzCiNPnC+yXzxVCFmZA6/lf0BGsVMITOY5hoKfv3Xc35rhvTlKSfNuwTG70HguQ0gbin/NvJSLf90m2ffS3aLPFFREbMsTBaOW5hjN24cMMXPoOajwS2A+V9LCbrXnGWAvWaZSiNsN02e7n2MMSmjmUYwT4jWmptwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hk6mvLlV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c7ILVOdK; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hk6mvLlV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c7ILVOdK"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCql6q205001
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 13:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ApZtp9mCDzFhUghEqNRHfpNQRpHQIPz3H5GND00+/Q8=; b=hk6mvLlVWv66MepN
	iXjqUBQgGPOer5qnBJte12x4wjPvxOCEYL7J06CYjn0EHwKp/mQIZhzGf/7PTCrr
	JPVMRa5P31yNjd0syZbjgMb1SqSQl0EhM88wLqYun1EFTHMdFhjcUQaYctLQJvLB
	m8rrLNP8N82Uo9R+rz0dot2NO2Ag+BRrRZy3QHNaATzsOSBlDlmyQoF67xxVYAwr
	6AvhbgJpiztMCqAaEVjfmc1yrAp8Qnex8FnEzTZH2Oi00Q9D6r5JmaAxiFebRClG
	r3l0ApPic+NoNoV0+qGAVh5h3Rn6Nx3BILxnO83SaAFd/J++STdI9TWC1odBWbQy
	41skTw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0144u7nr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 13:34:28 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2db8e9fe9c7so43544715ad.0
        for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 06:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790688867; cv=none;
        d=google.com; s=arc-20260327;
        b=EaZF9h/IGw0LUBCskDyuBwtlPUyhxzi+nO79FZXupUrZ6d5tU/Q+k0gE88dfIpwl+p
         RNXWWhQqujOkax582P28d/a2Xp5ipubpdjBkw6FzmGv7LwTHaOWjd9GmJNiGZ8v8eGJv
         3HblMuhykN467epmeThdKzul35/lXWL1VkcycJjXZUHRgXaYph5s9XI9HsRfEkt/sfAW
         N31HIxy6LWJosG7DYoRGi7+XGd7YvSyx7aAC5WKrjHPxqiYUL10t3vdzj4oUVf2AYYSw
         slIZj3w2kel15M8w4LIDRHI8WVSeoepT1Ns0oLqlcid+ahQz+YxrLqiRClC3mZp6eUdN
         qsPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ApZtp9mCDzFhUghEqNRHfpNQRpHQIPz3H5GND00+/Q8=;
        fh=Wstxkp3UTpTRluowXJyqrjLlGuq0m9CozqpB5864ZfM=;
        b=dDsnl+7sz0SP6ldHZJnUFZRogFmt+VyxGTGEOLO5ware1PVQiSNEErLcnEXA8M8GYl
         4mSJXjNmbD5sflCLou5+wyDCwAOjZwSnxCytvUc9NQ99ErAKS16CDZnTg8JgHAoytg2j
         JFNrNc4PCb+GAIhBgSU+3g+scB/vSwLZwiTWRApQVIJ1z38DstgHKWBkO4JImhUscQ4D
         1YZuYfOxV8xOtncpC0/T0dmahOY4e61w2VmjqHTm3TwnF7rkCnjne2sUzFR3aCXWaF0U
         9yqYh4VwejZl1d4koqDBvUKWRAXXncgtqtCBKPnr8eWiQsPqATJj4ypNw+j3sq/QmZ/8
         wrWw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790688867; x=1791293667; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ApZtp9mCDzFhUghEqNRHfpNQRpHQIPz3H5GND00+/Q8=;
        b=c7ILVOdKlBF9ErWUd5khpFOsmlFzaomPMXmkgrUIOvGDX8BCXxDeWyYQIxUKc++mVu
         hpaaDuPL7Lfb23n8wAjlBjvXMG+F7GxqGUUtz6XKVhd361fet3XjX3Sw3FngwuETQduN
         BbqyuygEzfghRjpR8D4QQ/i14xS812/MvTQR33/eyV5XAlOlPeSct9xMEnva+t99KMCj
         9zQ3iBR8uXRxi26y7U9VtjwnbDuD5hDrtHNrI/075zr+AM1Ldwi8fYo3JtC51RkwZpy/
         pF31KXVTaNXjvCEdXSV1b+f4ChXcEqbHh3170DI3XixT2+wydfd4DYv0XaN4Oy5X7wK+
         FqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790688867; x=1791293667;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ApZtp9mCDzFhUghEqNRHfpNQRpHQIPz3H5GND00+/Q8=;
        b=K7/V9SvJoZy+qJ1/YXwPvH2WucTxGULSqpZfmXZbJnTC8C8zzOacmXGgE35wqLVw6k
         NzFuKPOrQ8VVHa1OizlldpNRmBkOLNdlumm4q/VAIo+XjoSXwme5SzTlfrNrzZsnx/mK
         ovnRbNH73XXUDdL9Pvhap4pd+eoGr7VG9SPfJB3TBe3MC8ts7N4D3W9ieGCMuz7dAnIH
         9x0OV1e116WfyUojImXZvaHn/OYgK0DjjWWI+hPGk0uMtCHB/pXSQmVJ5Oa/LHty32x1
         8w26BTmt+QUJdVyEqBMWe4C2K2Z0NoihQNpZK3hMVEw2NhX4nCD5scHfUoRj1adP3ii7
         yOUA==
X-Forwarded-Encrypted: i=1; AKwUvBycZQzVXVOvLS35rRZxM11TMjurho3+RDkuF3O9W9rpZFulBghS9oGJKb3WGQqWyQ+SBJHpSw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIxiFO9/uloN+u5o6ZTzkbPuD6mPSLVywpcCXSBhtPTxTbH389+
	cG+nVhGERSDFA50V4mrE31YIQW1hfSa11ujX0mztg6tUZK8aEwZPnB1Y28DV1H/gYvjgPyZQF9d
	TcBo0hoJE8J3fQWjOO2WMCP/qXpomh/i9SZw5ay9p7ANCVQXAyox/ebiAkM4yJ38/ub5mLjtqi2
	qNIHD8R3jfynzh5CoVzsfEJuiOM6Kb+6bf
X-Gm-Gg: AYBFou0KEWMKGSrg8QFZv6z7viqWpR3a7rY9sLr50M0GHAVh/kMG4FC3fGSAx18jhDg
	2d0Yu0LdlVEFN5XPKcA3ynCT8aOlVG7IUBYtUta7BxnT/vCKyZG/azJuv2GTj3fur7EOVxvF687
	d6esG5BgK4xcaKW49j2W4YqmPAeV2qI4L4vW9tIwdlV3wCNvLkw2Gv8VACfQ==
X-Received: by 2002:a17:90b:2b8c:b0:3a0:574f:5854 with SMTP id 98e67ed59e1d1-3a0bb60e74cmr11071564a91.39.1790688867373;
        Tue, 29 Sep 2026 06:34:27 -0700 (PDT)
X-Received: by 2002:a17:90b:2b8c:b0:3a0:574f:5854 with SMTP id
 98e67ed59e1d1-3a0bb60e74cmr11071507a91.39.1790688866886; Tue, 29 Sep 2026
 06:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-5-b96fd3fe298b@mainlining.org>
In-Reply-To: <20260921-msm8952-initial-support-v3-5-b96fd3fe298b@mainlining.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 15:34:16 +0200
X-Gm-Features: AclHuK_IsoMVZ8jA--KFIskLK5LDOvw3Q0lyiLyhAEn2l6B1awM5w3Hl8Ax8gbg
Message-ID: <CAPx+jO9qPRgae_VqWrGQ8bhDOHBf+zDzw3A-BxCMa25XfPaa7Q@mail.gmail.com>
Subject: Re: [PATCH v3 05/19] dt-bindings: mmc: sdhci-msm: Add MSM8952 compatible
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1MyBTYWx0ZWRfX0ZGQlPGaflbU
 ZPWDJiUlcemmhapJXBIcIFIXMoOezG5tnUIWnXp+kGESUZe6tFreXwcjjVg7wL1J450yz7g2kcZ
 XhJnWGFHLXLm593aq1zuwH3IOiEQtCtRzInfMl6nEJ0UG7gC82gsRDoPcewV8q2+OVlQNUUFbka
 JQc+7/8UAmrf/5vU2RSHeZoThQ+3dcO5jMKiSimR2/s+Eftay4GUebxtK8jiL0HPuyai2JBgAXf
 XqmEuCKQ1Bduc/bs978BOqVJ2MzB/K6HEE9ZtTBYEiurgH0Rk5WgyGHOMFHUhXZUl1PGkTh49cc
 qtXs8y3hBXtJGEuF6whI+l+wYF7OGVzlLG/k3e9d0zK5EyfBDe/d8KN0YuIlZU5GoK01RgFi805
 fFnF3Gag6VgD5mN6ZPQTP1kjpglDWXkvFNcNkBNXokcNR62XIssSQzgpiRCdHa8cdBZgodL/vj7
 vSc5C78BVRFLPgUyoOg==
X-Authority-Analysis: v=2.4 cv=FJSOVOos c=1 sm=1 tr=0 ts=6abbbe64 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=OuZLqq7tAAAA:8
 a=wO7LUizMVtHDz2nkp9wA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: tlcRHbvD6mtNSbYgpW1emgteudzzTIHA
X-Proofpoint-GUID: tlcRHbvD6mtNSbYgpW1emgteudzzTIHA
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1MyBTYWx0ZWRfXwy4LMvSz67/Q
 dhYz6wfZcHywpTWVlyegZ28JykBSeeHbhxop+QAYvRbtPO7OgeyBhwfgjG/oYOgt+6lMyiJNdqU
 Mnp4k3hZWPebyqvDMf6C1Ie587OU6Us=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290053

On Mon, Sep 21, 2026 at 8:19=E2=80=AFPM Muzaffer Kadir via B4 Relay
<devnull+muzafferkadir.mainlining.org@kernel.org> wrote:
>
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>
> Document the compatible string for the SDHCI controller on the
> MSM8952 platform.
>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml b/=
Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> index 69bd44e65ad7..9d4409c958fa 100644
> --- a/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> @@ -26,6 +26,7 @@ properties:
>                - qcom,ipq4019-sdhci
>                - qcom,ipq8074-sdhci
>                - qcom,msm8226-sdhci
> +              - qcom,msm8952-sdhci
>                - qcom,msm8953-sdhci
>                - qcom,msm8974-sdhci
>                - qcom,msm8976-sdhci
>
> --
> 2.55.0
>
>
