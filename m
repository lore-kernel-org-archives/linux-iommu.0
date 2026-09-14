Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37387477281
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395686; cv=none; b=uqCNSTHUkZVgi6rJLao9yAbeEIbWK+U9t1KHkQximYqRFDe9WuJ05qk1dyteHgOp8D6oo8KZUnb3isZpLlBioYWXQ/LoCL1gmLsfQpOAlsi6aM+Wt1Zw5Ai7rAQlfnKHJYE11fs30E/cnNIa6cPAAO2etaeVKEtOfQBwt4FkXEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395686; c=relaxed/simple;
	bh=qpr20bFoWIAVz6Uu6SDBY1Onol/yGpj70dm5w/7HmbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXi3Gki57Tyy/TWwN4po66K8f6VShyROxR03akVb/gPssxbh24K2jYfvdbJA7t0lMqS5ogGxKgSeVVzbosUQ0GjhdXksgSLTyZEUUwopZ6iOvU/DBMlqUGHh1g3EJQC/ANUqHBdG+e5ZyURKSuojBSUcMYxNCVvS2GN2bOGpJ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZAA0sVec; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XEgVtt/C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZAA0sVec";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XEgVtt/C"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED0j92135908
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 14:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hsC/n5G/ysH1TDMPqrs15Xr5
	Fe1eAaS5X/4GfDOh5vA=; b=ZAA0sVecotuQbIutF2EPWz8avV8PBXwK/D22V4EB
	T7JIXLLQ1Pw29b6EVFSY0wTE0TlLHg8qvV6Ovch1DnuNa6WKDmsBAgDOqC5PTuHw
	CixdNiZOG/sxPSsQUkr2Jpm8dKWiAr/QMr+AD9bvsFRLx/2dX/P8Syg4vKCUUFV0
	L1N+4XVPHfeVUI6LLy/0yu5JJQapY83jolFHwcayTw30aMwBkLJUNgcQzrjDmiuy
	EtLVZFaInA13UVi4sYGXkQg5Tur2Nc3gNJ1GHg1TMmmKRltzL3ZNdMRdbhd0y4qk
	MjDsMNpT3yqlYInbKgzhkCs/Kot+rkHfPMWXQuX82Ttt7Q==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpeuq902m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 14:21:22 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-798c310ebb9so1089651137.2
        for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 07:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789395681; x=1790000481; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hsC/n5G/ysH1TDMPqrs15Xr5Fe1eAaS5X/4GfDOh5vA=;
        b=XEgVtt/Ceyjmx33ea2Y2eNd2WHvgoX47n7txwQkXNxVn3iXKJ6kqFsVBMc/lUBQB6M
         wn09MU4OkXUSiivFu+YBaNpKmnXQhhfSWWNTiIQ3C/GD40+FYDzZUjVt2PhRDU0pBTKg
         WlWn743pf6hG/H8BLkNVKljzNo6RzMxuio38VOdw/ZmbHQPlqD+h1BlKH9Yn+hLjInHf
         BYiPocD+6JKmBX3gCPtHyMfNYeC4rWLc+VnWqC2bIA78MVoYXjh6ywEkKTxS8jWITd28
         kZCshm7buqfQ3S7eCu16qxKHNlhhx+D1cD8lcvxvsgDNqMbdi3HpHNFt6uAX0PKj6ewq
         T2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789395681; x=1790000481;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hsC/n5G/ysH1TDMPqrs15Xr5Fe1eAaS5X/4GfDOh5vA=;
        b=DGGTJkvRgEpCnUeJ5fTfVnO/mprglTxrAV9ag9Vs6WMOISvBV3OfUHywcuLlQHyPMr
         nzIpZvdhnkFyxlzh35Tun2O3QFNnQL2oH9Nm6+aKRLBml9MVxk+ZzZkM5OFB5IlJ1tp4
         5X0ejIQ1ZIATTYHMRQLgCQNgD9qgz/7PwUXsvDJtOB37XOdYRheOmLemUTsAp+bqRoka
         d99czpb0vtkIpMzCAc9D554mwQbCZliquxcadpt1tfCgHsvsksl2ooq8ywdEbOdQDCQo
         6i7SApBLxSO5YDgoiH6/LRyWt/ubryZzGl5Qgjcx+3RPJDyB26hOLiLkyauzsN12b4AB
         xuxQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbYSVowTrO83+NgVnCVY0h7VPR32RTxsONKdgQzk1NRsSo1Z+SQtzsW5HtIMjGcroo67EFbg==@lists.linux.dev
X-Gm-Message-State: AFuF++mPVl35uyJeOgvHAZglbIprbHu+x8cPkMN0XCuKLy5jQdVmMjev
	6MUTZ+bz9jhJPQyWBsd6dEY//GGjoLc/jyeYhgr/XAfBxLB+482zmWWCnGJ5EZT+3nNO6eMIA43
	Eu90NhoOeVOl2MOe42vlIkn9/3GazI78gYcgNU4jHVLKQzxKtc5wpsYy3MA==
X-Gm-Gg: AYBFou2EHMAtEOLODqVT1VHG2df7t9Rzj1zDVBgWRDUHGY5+mOcFRYgPDE+EB8bwkDJ
	mOvU+Lqm+gVvgEIF+unvNj+FcWICPYcPkZD+p0cLMsb93bUiahJwxU0e7UTluGdxI7NQfqUf/Iq
	qqsBtt8eG8l5cimMzcJhNgG4Zs+jfgMNA34jyhqSnqmcjVWy4Hx5q+U+W/jE1WOqQIVYqGsn4IJ
	wvL283e2p8umaUP5MOvK+HOAKFOHjbYBK8iS9xTy9EzwvgMcYQLqQ0lteksstpNs6xHCJ0kLP+k
	VE9YqMOOWVjw0or07dCuIZDK2a7d4ZmDZJx03HBOjlSzMpHxur3rY85BU7jj97G7tuI20XQ3T31
	h81QxmegP+RZUpr4=
X-Received: by 2002:a05:6102:548a:b0:79b:dfbd:d0f7 with SMTP id ada2fe7eead31-79bdfbded2bmr1731000137.0.1789395679750;
        Mon, 14 Sep 2026 07:21:19 -0700 (PDT)
X-Received: by 2002:a05:6102:548a:b0:79b:dfbd:d0f7 with SMTP id ada2fe7eead31-79bdfbded2bmr1730677137.0.1789395677612;
        Mon, 14 Sep 2026 07:21:17 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6499d57bsm477423505e9.3.2026.09.14.07.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 07:21:16 -0700 (PDT)
Date: Mon, 14 Sep 2026 17:21:12 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Muzaffer Kadir <muzafferkadir@mainlining.org>
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
        David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>,
        phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        iommu@lists.linux.dev, mfd@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH RFC 15/20] soc: qcom: ubwc: Add UBWC config for MSM8952
Message-ID: <z7rjt5237gdtytb35chtyjposyvqpgqfsxhov2all4g2527aix@dabjw24dluwa>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-15-0e742578b524@mainlining.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912-msm8952-initial-support-v1-15-0e742578b524@mainlining.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIwNSBTYWx0ZWRfX6N+ZPs8F3rL1
 Vg5syf7UghYGCJrXb5rqEYkFRH9WV9vTZQRNUvmBFWKcnu2kVA5/hAvtfug4E1GYs5hrdoJqcpL
 yVp7U0tLzqJVcGH5Pvn0W22x+3oJpEjbxmtU/NE1ivFJK4gsYcgwjqLVtt3dPlj9yFmpD0dUeY7
 3A8/+Pmb20Hl3tke0j8BwrdQC2OkBmrmOaivTM7NKSb1eDQLNhirF+a5yfwzj6xrvla7CechnEv
 dP1E04d8eAfL2vO0sBssLgnnvrRUSzcbupREsL7amp898AvCG9y/QSQkqrG8qRcGRhKJyVk7OLQ
 Zgp3+2GRhJ90KSzK1ErTEpg/cs40b4JaFZ+NCkR8IAYjtq7Qd4DNVChHBR9GWG+SQuoYd0ZtqUy
 wdkZLDNyqSYAe7IbAgq8w+N9OabltLRMyoC2lGpKhLbJVNT4QC4ymIMBlj0cCnHThLxi5+hYVd0
 /52NtxDpHfmTCEXdCZw==
X-Authority-Analysis: v=2.4 cv=TrFzFzXh c=1 sm=1 tr=0 ts=6aa802e2 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=OvtQcJRYg_U4C0nSOkMA:9 a=CjuIK1q_8ugA:10
 a=TpgoBOgV9RAA:10 a=crWF4MFLhNY0qMRaF8an:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: 1ao9RbYMhowKx5FlQuB-_X9i2WPXX6q8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIwNSBTYWx0ZWRfXxmMy6HKQwqR2
 1HzsPgNGpF7m9KtpE+AWtbyX4kCrIF/gwiBDhWUjBBGvHOkaGRuQ4+1VOcQXmqW+Xtid+rNLz5c
 EmHGpjdUPJvZlst/Bp2N8c4WBTM8+S0=
X-Proofpoint-GUID: 1ao9RbYMhowKx5FlQuB-_X9i2WPXX6q8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140205

On 26-09-12 11:39:24, Muzaffer Kadir wrote:
> MSM8952 uses Adreno 405 and predates ubwc just like MSM8939.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
