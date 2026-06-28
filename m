Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A869371CF9
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 22:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782687247; cv=none; b=fYQBe9NSE2ytQ+yX/NY/i7hdWM06K7t4DkuT+JQtZCO2NkgpZiDKItbtyTBnSCp1ALTMWugAS2kj0mSlcjlbGzosq0s3kZpRZm509ttBp3IQUEHM31fCK0fo7oHopzCcfvrOGxIvtdxUFXL3qYqMIMfHxDf6ilHCxyYzqdaqShM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782687247; c=relaxed/simple;
	bh=FHM9I7MAjyy1mXqIUPgsWC9RtHIBPLm8K4VhaRELGzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dk9tKdtxB+nI7aE8xOF6MrDxrBMM6gmePDEue32Sdu3ytoC1vpVzHFigkgd9+f6T0tMhbra+hV0y5MA4Z2dA1zt4sssH8tViuAgwAQd86dRujhzpn10ehOgRdsS+UpzP7Ze7+NgKXSaHpJKjmWr+QbISlaV1zYKK4EAsbTRZvjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IVTj4Z6w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SJmMTiDX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IVTj4Z6w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SJmMTiDX"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65SMAWoG989195
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 22:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qaaIg3gvt+W7J5Dpnsp8EdV5
	SRcVyaxwovZUztMqYmM=; b=IVTj4Z6w48vDnABsrjEnb363TqfizJ+SNkX0KG6E
	XLKlk2hyKGozaj8SZ3OT0/Nenbli2kQMw7PIRzIyG2Wybv3CEC3TpRtig0023lvM
	wvTCfKvokAjF8rIxyx1ULFNUmunw2mDYeZuYqP/hNDXkoEV/LvkpJddGPGzWn5wS
	U+LAqFEgwMks/TqoY/12WvTSGaXSJGUiN8HMyMzqllue4V37eDb4BeHCdasWgyyi
	zxdvWOuW/HN1RbGkOm2maJ83M38RCA+66D7NTZ3NUPrQymz70Ue6BVw/4b3TnYuv
	9qPGRYUNyXM5WfZT/I0R50loFRbaf6sk6PGWZxxDyGYnTQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26x8ksm8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 22:54:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92d1cae5740so104430185a.0
        for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 15:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782687244; x=1783292044; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qaaIg3gvt+W7J5Dpnsp8EdV5SRcVyaxwovZUztMqYmM=;
        b=SJmMTiDX7rYZSdQ7SjZd8RVvJLMNJboxbf5+d1zqRDYDc31Ey4eCzqGlLCK7q7UPco
         XA2Hl/7DnAjiHEP1rogMSYZYwQEGPdUTC4CPW89PP6fZKHAuGdFVMIflZoRr3qXygQ7V
         9Hpje2flkYgrYPIfTlv3Pup9Xdwj3ZcSl4p9rZCj7fxIZMSJlm2/aeKwjJ8qUt3Tz+Lt
         2d8mjFmMvv5be2uVS+yPJfZcOMCbylgxCxDl1VIr5ruCRyyX9u9dqWA++W7IEdRbc+Pq
         3rhHD7SykKY4IvxwmO6GQ+CSftbimG2QHkHMlVYwtAilojvlIPGJkK6XXdNf/8QusFA6
         hlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782687244; x=1783292044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaaIg3gvt+W7J5Dpnsp8EdV5SRcVyaxwovZUztMqYmM=;
        b=Y8XD6Qxe3tSuFAk3jILytQTvmIuarU4smE4B21UxRvLbMexYXniZKGGz9bRv3Ag1vn
         gr8X85JURfm496Gkv+/5wRXksr1jyUEWHnX8CfBCtUo0Xb1kwEhgQAGW4VKu3goKs2vN
         M6JRSm3F4iL1CFjAQn+/P1jaYhZaQrbw+RhFuYCCFU39Nk1FBQPgewf9RBEGwyH+DpDc
         k48pNjmaEVabz9bQO48Ri53ge59IGhhZiDW4SSx0SUFOcawJAxayaFHJD1Jmubl2cUDi
         Eu8E1pKId6LowAAgJxrq5aEP4p9LVW9sGsLZ5N5h/piTTLubZfQteJaqqHsNFRK8qMmF
         000g==
X-Forwarded-Encrypted: i=1; AFNElJ9tInmntpM9g98nlld/9PXJn/XVbZDCMCDuoqXz5cusZQ75Mz31xWh3kYm7oBGxeCAgcY5Xzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxAgTN3JMaXAqS7jNaybavRrHLojeNc1l0lpjKpsIJA+RhM+KH
	D8a+7T7ntzOH/4a3kazj+6WSE2c4qOtI+WuyOgduqOrQLsDesq96fFv9AR2IhTD9MRkUx0Txxjp
	7Fy3TMp0tJBMJxEcU3pcTirgzgBGZb/YdJ/Ml+XYqv/4fCPXpbT7Vqqn1lQ==
X-Gm-Gg: AfdE7clCbtBja2EgXP0nF1YqDqDTRJcPkCSolQal1WR0IbNnjjxnu6Ot//5Q5W5kPYi
	/w+1nj5Xp3UgqZuTiuGRkXQGT9Ob7XUgBkH427Yzjp5AQlaw2Zsiora/j7yI30ArYCxBQ7RIZSB
	5jNnnjgzlizsTQrEiy8PeLIFBFr+SWASlxUkUQySqYJIpLx56exO6yZWIthUrXPVAFSP9IT5v0u
	VlDbYjl4HWRoiwUGIW3NGWsyJzuCO9cbvFAUJ19S9WQdu7HuPXCphI0Aasy2vvOBgI8puEyjbfM
	F4VkJ3LMruPIZI7xhrCD66BYn1gX7jpiGKu9pcNlYye45GHaS0BrXeH+YWjn4f+/g6YA5M6kYD2
	3q3aKbOTcGJg2U7y1xXpKaYKVDS6MHujyhdmviGZGX3+BxdMICjxfR0tpkzLrS70UYZbNjxXHxm
	cfUo+8GcyIfn6Mf3fwc6TKvJs0
X-Received: by 2002:a05:620a:414c:b0:92e:51ee:7945 with SMTP id af79cd13be357-92e51ee8ae6mr177013785a.30.1782687244488;
        Sun, 28 Jun 2026 15:54:04 -0700 (PDT)
X-Received: by 2002:a05:620a:414c:b0:92e:51ee:7945 with SMTP id af79cd13be357-92e51ee8ae6mr177010785a.30.1782687243961;
        Sun, 28 Jun 2026 15:54:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad69585b6bsm5327111e87.80.2026.06.28.15.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 15:54:01 -0700 (PDT)
Date: Mon, 29 Jun 2026 01:53:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Aditya Sherawat <asherawa@qti.qualcomm.com>
Subject: Re: [PATCH v3 8/8] arm64: dts: qcom: shikra-iqs-evk: Enable A704 GPU
Message-ID: <kz5fw4hqblmumabhooyupyxqmfwadkas57brxs2qxvnbn37v6r@jjrmk5ckqbc7>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
 <20260628-shikra-gpu-v3-8-9b28a3b167e1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628-shikra-gpu-v3-8-9b28a3b167e1@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDIwNyBTYWx0ZWRfX5IH65VJTNFrw
 i6EMPK/IYi0gzqkrmeGAw1TnHzqwYRcdaOdPQrHhRQcAqtDEobxWOsB1xob1D885GnBXGLL8/AB
 n+2LL0fkpbCPZIGsQlIsbKmXkuOE0Vs=
X-Authority-Analysis: v=2.4 cv=D+N37PRj c=1 sm=1 tr=0 ts=6a41a60d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=UQAiW8fk4jwks4S4FoYA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: vFH28rsNCJkm_sUjFo8X53PhRYZfT2Yw
X-Proofpoint-ORIG-GUID: vFH28rsNCJkm_sUjFo8X53PhRYZfT2Yw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDIwNyBTYWx0ZWRfX3myvIPF6R5Vq
 a7wkIxgpooPH1rZB+CLTor3E/CoLasv08c0NE50ULS539W/1kVjt67FSn35OowW+mGnKOoPkQf0
 W6OApoYNvGKdEjm7JSe0Wfe5t2lu55TKGcq1j9JM5mE5Q+KikykxWzAqx8VovUT8fxtRVVY43wc
 v7au1XwrkepXo4ohhHq568a/YpUwUNOoeB7zHSUO1yW+bE3b42TMRYRmqNIFI+HQxx0m/9YtyT3
 Qd6iSa1NLUtNDaeS4GQV8ZHbSP1PbkmxTGJTIukaznc5Oy5Vlait0+5l+1z7T9ur0a+0MwjlZwB
 Rzc0Of3+jvzC5OOmWfDfBefVlRaicaTMv6uWdlyNmPojtZUFcc14RDB2ydCs8Wel/0G0bWTw6Fc
 GgUX9mkppPQLy7CA6IGNX/5yB47Ty44Xpl98JW/E4M5R8mg64HQtPF2KLssyZlHVR4dXzzwvjci
 3KRcYeNAnSEKmE7UXmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280207

On Sun, Jun 28, 2026 at 11:54:01PM +0530, Akhil P Oommen wrote:
> From: Aditya Sherawat <asherawa@qti.qualcomm.com>
> 
> Enable the A704 GPU and configure its zap-shader firmware on the
> Shikra IQS EVK board.
> 
> Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
