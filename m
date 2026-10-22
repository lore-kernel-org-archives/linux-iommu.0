Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792663831;
	b=PDryTENMimhv7etVuLaUxILhMFcDckfffzwvfQ0bU53CQYk4hl0Og/Elh/CuL5gF1tFT
	 i1UX7EEnHUjavOLfhb0AfZolYee7Z8HCq+3DDt2IMql/z8MqIvP+DXoF+PfTzsTT7L7gV
	 ukaraGQkgoNuaAkitF3i9Cptm4U9ClXVUsfGODQoCRnz17g+mF4VfeYbNkdUrhfp67YB1
	 1D//uRXaSvsUo+w20cOrG/h7OL7lp0xz0r9C7pVhWFRM4sxfR6Kl9XIvj2gsVbim3fpMi
	 k0Q1yJORbw+8uKfF1asdpcoh7V4fm3+JQ/yLR+DNkRNxTOYDSHWXiMp9cC2dR/ffI8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663831;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=fbKLGq9PyipegVYiZapN8cQvPdSHH8CKY+98Y1mqjhY=;
	b=C39xNrge6PsMc6Mrt3eLd01yX31V0GLsGzrYyP/PczE37IggRUJUddfpZ0avtv6qGOLw
	 ojVlfP46X60dYah9KG6If+fAUpciJp2FuqQqB2FRtPPT/6/sUYcnjaWKPoaruPqQTfDwE
	 VKsOydVEQbYLdPpvK9YqK2HcDqBTTHuq3P1EQfWBzY2R8TbyLXmmql5ekv7z/nLnhoNcG
	 Wnhd29NLCgj4S3K2/rofUT+V2kEteSyI1ISc3v40nACN9H0lXhsv7LO/NxecIbuOOmyop
	 2L61LCJxluDZXm9c+RLs+y67vVn1bC7nZe1XUkDWmiD+gMh2iLmgvkvCWe3guaLY7uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QU0Webh+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DmXwu+WI;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1733606A320
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 10:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1733606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QU0Webh+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DmXwu+WI
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA0LW63995639
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 10:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fbKLGq9PyipegVYiZapN8cQv
	PdSHH8CKY+98Y1mqjhY=; b=QU0Webh+X8+jU6IBgNvZcDg6N/kD+t0REZyXD2YJ
	/p8FBZJkvhj6GDn4hMzgSZi6ZbWPzC9vMwMKs2C49wFrrFP2NYZ7MFB7aPzKtPWT
	66jrEIPjbFE1CDIQVEtP1Ay4pyMP78zyFVMMkB8YBzuO9RspfMfXDJDmrkPV0XXn
	/tlxP45MqKFdV7qsLdPdj1ReD1ERCwx7GN09CLY6rqnG9YBbmmdg/2/fJgXuxQ+R
	SOYyNYFVNX0OkZCYZmbLfpSazF76pZHYe40fY6c2tiHuM55oNupzVihSLXEh1a1K
	3t7JecY5+WZ/Zz64JhTumhF8SrmyB0n8L8IoxzxFJTZ4JA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93c9tjv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 10:10:29 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f32050e72so541561285a.1
        for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 03:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792663829; x=1793268629; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fbKLGq9PyipegVYiZapN8cQvPdSHH8CKY+98Y1mqjhY=;
        b=DmXwu+WIJgCycDGhxPNPZqvDMSrXTroq1zJDJt9T3mFsQoIXF3G6bDripq8+S/GGzQ
         tvLX7ZcRhytcEqZkXJVVhh70JSUndZtBbM6retxwOQR6fNdwAaFCZfa6D2TnRtfoGquR
         5Y+FJ67+4Yt44B8jgqw9ckdHEeZi4BbjrHQCF0InB6Za5w6u90lsuQ02vb9t9moU2OhW
         F/HYaD20oh5zOM7mmhKx7l1UynbAzmcT7gVDNxlawAOetbFhBmd4DECLCYPKKzOExgP9
         IaDTzl1hK20Elzly+NF7hXR+9rw/fDa9Np9V7fEaa9v3Ji48iqry0JUCg9i4Owl6f1Sw
         3NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792663829; x=1793268629;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fbKLGq9PyipegVYiZapN8cQvPdSHH8CKY+98Y1mqjhY=;
        b=bcMxC/SM5OQ4qU+JyDPixRwcLbR7lFHftczwfAR3s+9h4jmKaJgHW4sddD3s+YknJq
         pOTN6FSjGHSSHbcnTFsh+Vv6Ye9uZdD1OcUpBBOmLIEqOP0vGujyCEJQ7dAXF5JDj87Q
         3k0t1VP0sAJQ8l9cIdhoTda5xAvRwwRKy6sHfd5rHC5JsPwT9/lzxFqwKzbBLM69fUM/
         tpUnOdMYFd3U12pkqZrr6xTV4WrtUqdn+t91OLgZHQ0/nZOVa2g3YRAgH2ky4CcxMTzk
         vBKV3m4umD1hmzzHAHYy1MhkMuVW73HOMLlg+9ugLO4tS/ya2FCttt7/4RQY9J8tjOFv
         DBHw==
X-Forwarded-Encrypted: i=1; AKwUvBzbQkwb5xzEPdsIFAWFG35MICBDAr3XEV3Wz/P/t+Y2FGngKRAIwRMWr2J/CHxLEjbrAaeCsw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJAqn/I7ZLMOthkx5M/1dxtcOKmlNr4rjbIZeNTcyeKsZ33GnnK
	Hm/uwf2+JjvL4ICOmbG/Dy/lD2fAY+L2pHWJMWfn2//C2NHneMFdJmaDpn0qKfgBeIpaiJlMh0P
	/p0M06hZD7yghftIwPsU5PveImycKkUcZ1nbRK1Oio9//By/hdCgSHuYIug==
X-Gm-Gg: AYBFou1wd/LGkpl24oTm8xpRCjMtljPy6uXKO7jedc6MtE3eXuKKEC65aS+PGJVENc+
	7gwV8hqlqrSYbmL+u90r5Iam9RcBAv8Wqmsffg+/BDiv/f7azZfIpRcYjz1nHGYjrEralcSsix8
	u/rYB6/C3n7c1yvqXlzhpO3ejZqMr21yvNPH2lcIBDOOuy2+tdOkbixwqUiIKqvQvH05z41/7Tf
	JX3ljqHgRto8Zr7kYsomdyVK7ZttDlEfoAzReKvNMgoiBJ9k6eMxPclQhvMX+YcR9vByzZ5toOn
	/awvVj6v0Owc0kWzPhmv+mJtxqvELOO4TyRkHExps/L3UD+67pA7D2vaUjX3iIH9ub1utftCKom
	PCNltxc9zSbumpCIZJtBqutlEe24IRuycBCgoz3xui4C8rZHYg4II6404UZVxs6S18j+B5ibmCy
	Vijw/hNMEPznhT
X-Received: by 2002:a05:620a:688e:b0:93e:d364:c9fe with SMTP id af79cd13be357-93f57f5129emr848794585a.40.1792663828375;
        Thu, 22 Oct 2026 03:10:28 -0700 (PDT)
X-Received: by 2002:a05:620a:688e:b0:93e:d364:c9fe with SMTP id af79cd13be357-93f57f5129emr848789785a.40.1792663827828;
        Thu, 22 Oct 2026 03:10:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfa1244ee8sm1026945e87.84.2026.10.22.03.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 03:10:25 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:10:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Abel Vesa <abelvesa@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v5 04/13] iommu: of_iommu: Add support for "iommu-ranges"
 on a device node
Message-ID: <325qovw4tt75qgk5uncamb4ca6ql5ulyivkgocumi3bwogmkwn@ijk62fhpxptb>
References: <20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com>
 <20260926-vpu_iommu_iova_handling-v5-4-0322ca5dc10c@oss.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926-vpu_iommu_iova_handling-v5-4-0322ca5dc10c@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0MCBTYWx0ZWRfXy8ALXHxddY72
 L4YR8t/mwtda5RvScW/A0xryuuGcVbYKtfSWSAJHCjovAp/vJQ5qN2BESirfKAm3kl57BvNmB4F
 nCkCtKs3trRWhOe3fg8KfvaxTqq1P0Y=
X-Authority-Analysis: v=2.4 cv=ReAFmFtv c=1 sm=1 tr=0 ts=6ad9e115 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=AypnKj6NB4iKfuN-KaAA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: ctMD2-ippQTLySOyPNZ1LFA_QhJRcZxS
X-Proofpoint-ORIG-GUID: ctMD2-ippQTLySOyPNZ1LFA_QhJRcZxS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0MCBTYWx0ZWRfX5Bdhlvlgx6CI
 KYBR2KJzhbt/+Nesp/oJBzrA8Ar9lOx1D77YUChnXXq80wE2r//qIrZR+7DikkvZ/1kVKvWW9ad
 9WbgMFqoizsGnijDKI+mXmqEHPMP77dffuE+91xcymYS4npN8Q0Z8gFITOUO9o1tP7yGjgBZbVr
 VmyrmWlrjjFIuzVq73DIgbyAcQ4rbkIKvNYTFTDa1UCfLpfOvI6ugUVDJkWa42tK5TDL8DWXVgs
 LhRW78Muh6C7qW1znMrkwkwAHXUItjWzhq+esMJrBTGKeS1f7ou43DTRTxqmN3AbfeIvrdGN2OB
 Ao4GSSyxvUU4TAf4mQAeGLe3JM0nYNPF7vQqNSbNydk+U1ZSMYB5e8cB0mILsm4O9fHDMn7ywgi
 xc++3fH1ZvlJCc5O0MUIse2lZCvMMwqNv12ycGn0qZR4AfoYhTiSnKsXx1TPIPTGFQUR10HGznB
 NG2MVBAnhkL9vOjiB5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220040

On Sat, Sep 26, 2026 at 12:04:03PM +0530, Vikash Garodia wrote:
> Reserving an IOVA address using "iommu-addresses" requires it to be
> placed in the reserved-memory node. But when "iommu-addresses" is the
> only property being described and there is no backing "reg" (i.e. no
> actual reserved system memory), it does not really belong under
> /reserved-memory. A device IOVA range is specific to its own address
> space, and does not describe the system physical memory to make it
> qualify under reserved-memory. Given this, place "iommu-addresses"
> inside reserved-memory only when it is paired with a "reg", otherwise,
> define it within the device own node. It was discussed here:
> https://lore.kernel.org/all/662f7093-fb0a-4564-9ca0-98e03e68ba9a@kernel.org
> 
> Existing "iommu-addresses" property expects a phandle, which does
> not make sense when the property is defined within the device node.
> Introduce a new property, "iommu-ranges", to specify the device
> specific IOVA ranges when there is no backing "reg".
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/iommu/of_iommu.c | 128 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 121 insertions(+), 7 deletions(-)
> 
> +
> +	list_for_each_entry_safe(pos, next_range, &ranges, node) {
> +		if (pos->start > next) {
> +			region = iommu_alloc_resv_region(next, pos->start - next, prot,

As pointed out by Sashiko, this can overflow on 32-bit LPAE platforms.

Other than that:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

As a note, we'd need this patch for the upcoming Qualcomm DCP display
driver (posted a week ago).

-- 
With best wishes
Dmitry
