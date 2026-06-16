Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098EB257827
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 00:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781571421; cv=none; b=SJNBiiE0nsYejq9/bTc4MH8b5wJbnYQZurQ93wVykUamzX0TSgkGXbxSfLbwX+dItnh29Vj4GmzdgqjScs1Xys7GpS+mNhq6a/FxEFgl6jeZOHHD3cp1VfEEvYqhUh386sFgxPBoPwMCnR1tHK3G3fRUo99NU+4y4KqiK2tszoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781571421; c=relaxed/simple;
	bh=eSV9WPMekMGnDs84RVMY+Sp8QhufZfVIYVV6rqC3r7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQE9ZWwh046/4Mj+BFL4G+hrAX0QLLCquKnc/9tXd/4tCl8CRtsf3UbuZq/zjwD7ZjZlKy8AXMM6vaTV3D6yguAH0iRynQZ0aT+o1YDLKhaPEDk8zIS5oCuyxGSQilCKbCunEJdDimigXi78MwxBvpXtZzVJdMZGEwIBIYZyUyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LA9/oC2S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VlB67XGj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LA9/oC2S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VlB67XGj"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G0Nxex1584893
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 00:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1kbaM76E9XIMD3rRvXUXjCdg
	vz/AxED9u3Llq8yAVaY=; b=LA9/oC2SG+bp/2vSC+T5fzx9421r2DAAaLl7vYxz
	5gVHBtNNd61dUXxs+P2hgXdQKwhII/PoVX9+LOmFK2TACn0bv3phWGb9O2G1tSFu
	0XKm98eBi5wBxbGMv8NnmJcXsN/FCMmNEKxK9jKd+qjreQJ6IIhL8nRbon8fvdvz
	FWtK6yg1qIIDlB1xOI4IxB0u6/I/Jdjna/QcrjRtOlui2t0vwfV+S429YTzNiiuK
	tGPx/9CgYRamLstltjtBA6crY3Wi+5zdSqF5fDk0OJwD9wEZxer6xX6WR26ZUnDH
	SWkQO5fvFF2aqg/RGrVZXaDVR5kKdPPLVw1GdMniOg+o9A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etew0kw7e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 00:56:59 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9157f1be083so681825885a.3
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 17:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781571418; x=1782176218; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1kbaM76E9XIMD3rRvXUXjCdgvz/AxED9u3Llq8yAVaY=;
        b=VlB67XGjjaNrqk4c5fv2t6lWVprzOZ5xOCfEv19WDRCBdFmNKmqA5Qt28tLcpJBkE+
         w8bCp/FWf3Gm5KdlWbVDGWJgm3hIdUEXROVSA/wazKj0LSDFDY9ioD2Qqg9jb1TNcwws
         sc4zeJMrFCjhJA5D0ZT0bGlFdDDv5avUnGU8YZh+bCCzQEq4uLPjV7QvKgBvvjzwknvu
         X6EnzSpRGUUIZZup+i+uL8GzG6Iq5UkAxCOLKEf32VXKy2N+cxUTo+j+NNa2NRACKc2P
         YoXrg0QTVh0jwIEIWYg3kHF/tIJaUhs9/T9MVaY928/+r5iBzDkVJD2mBtpoOyCassft
         KAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781571418; x=1782176218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kbaM76E9XIMD3rRvXUXjCdgvz/AxED9u3Llq8yAVaY=;
        b=o3+WDDPD7wws3/Vwl+V8RX7UzaZk+2VHOwfvBnD70B3HXzXY0zj6kb7eNE8UiP2nq2
         /EmXD/zPxM2HVYeYJ8jOxJZUOqoX0IMWx5oCdc3cQGWKUXNsoDRtEw9cErvdv5B9ymn5
         a1d8loC9gyQ7O2AnN0BPkm/h3+XQTlHXeOtOD1PGNukjjlzdcRjCfUGxv1WUZV7wWNE5
         eJLjha1iN7CZzdOL0KoUzjBBKtEJHAGw0j2zGuSijYrnRP+y3Si/XODsTh1qtgEdrKc+
         jFk+WxwwcQdI2rr3F/AChmEiqMbaatOFLBf6T62U6RLn9MLeC6atKnBdSazxSW/pzvTB
         hYiQ==
X-Forwarded-Encrypted: i=1; AFNElJ+xPQHhl+sLyg/8c1Eq7a5MlNwFxPW8Tx7y+/tVdk45z0Mlvg5OUAoIWw7w9yF/sNsUSM3HHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYFZKyAMMb3DiLB8l0GdiElsCiaTXtgF7MFZASrVX3OPJcPGCd
	M6Kv6aZEqvE8NEusqGkcPa1rtR54ERFF65xzubMcU09Kh4TFUroVmQLcP4EGYN1PhfMUfPNGWuj
	w/KR5ZjtvcNbD7gQHe4MyFMxgaNOMVU4UpigLxLTrcO9wIVvzuQcp9ofjpg==
X-Gm-Gg: Acq92OF41DuDlyJsTUKtQc+s7vdnyTPtVLlqT1gYovYE0ZGQ09wP0SrZa1ifzGCS/8y
	ag2RMd4uNiqDYyUEGdgjM1x3KGIRTUmqCNXE9IcC3Pt9xgUyVcOaZ1fEB0dTv0vwX4pzuv/pm2d
	sw0Mxw5z5Woa8/sQIx7lWAcZAnRuYIFdDzgxoEyXaHYjBNmY0NYoETf9LQ7C+Wu5ukKrRfCEQSy
	G1BTTt0zQlzd0uO3isKwtKBKq6vEuxa97gfang51cWHg+ALAUeTHn6AAylBdZn9sSMFROxoyzNq
	UE2/SfAUOX4jnLtepH16xN/UFZWDLz0DjtLsRJ9k0XTi5e02qJaM1zAE5ZvLJc6oGcpqKeTp2u6
	puq0I0Kc8ewMipW+pNL8BDGlLbV902q/pOEFuBFWPlLX0A0vJq9Hkee2+ZkySELmcx3Y5hL+cTI
	ffwY1AubJNvE4mD1+lyat3dltI3SmCr5QtA9s=
X-Received: by 2002:a05:620a:258f:b0:915:d5cd:8ce5 with SMTP id af79cd13be357-91c24579d0cmr350393585a.20.1781571418323;
        Mon, 15 Jun 2026 17:56:58 -0700 (PDT)
X-Received: by 2002:a05:620a:258f:b0:915:d5cd:8ce5 with SMTP id af79cd13be357-91c24579d0cmr350389685a.20.1781571417856;
        Mon, 15 Jun 2026 17:56:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad3d51f20fsm925671e87.61.2026.06.15.17.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 17:56:55 -0700 (PDT)
Date: Tue, 16 Jun 2026 03:56:52 +0300
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
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Aditya Sherawat <asherawa@qti.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/3] drm/msm/adreno: Add support for A704 GPU
Message-ID: <yldxcxtrdgsh7c5s5llnoobdmgnass6spyty6mg6yfvcrype7j@xhgga6vafd7n>
References: <20260615-shikra-gpu-v2-0-2f2d1347c3fb@oss.qualcomm.com>
 <20260615-shikra-gpu-v2-2-2f2d1347c3fb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-shikra-gpu-v2-2-2f2d1347c3fb@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAwNiBTYWx0ZWRfX+uWWhia4sC0R
 sZw7sXu4JnLRQkLMKLfRp+aqo3qP0BA3QJk3jVEdC0xZQKTAa+aKBdRayyzg3R9xk8jh1Aogstb
 R73gDxJ4AHldmBX63d8Vw1C/53K7Ewk=
X-Authority-Analysis: v=2.4 cv=QLlYgALL c=1 sm=1 tr=0 ts=6a309f5b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=EcFSykfY_HSBU6426B8A:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAwNiBTYWx0ZWRfX4cnaklw1bCWR
 aHIeZWPZRrEvD6RqUuCwvSEZLC6Po6LD05EB1C2qe3xVNnaQ2KAj6se53BWAHMvEQEUPfRb8/P0
 jVRl2bogQyx/hZDo2A1e72HvhKHSZ/crEvxK8FCG4QVEitucdmjwAS57SxYnnPoNAQgN/xeGjIG
 SaimC9+DBgOI38SiCh/2UmgKjK5UlNqd/0F2X2u/WTedpW/iOMU+A8QNx9h1iqpO1dj3oTSdI2r
 WBN6rI9HxLwQtfvrgHYxeL6P2p4HLThe6h+G+JyHZUhu7Qh6jVtRSlZ/KgqZOya35hriJdGckgn
 PhQKl+/0nO0RB+UXCQnc9lW3N4N58KTvihHlHThkahGQ7J2iyI3uh7+BYRChQRbYuvrxiGKuCBb
 at4wHFx/mJ+bMDABG/VjEkYv05hG/hKvCALB4k93EVrBRiue32eaYQ6sbROqNPhwCF1rnwQe4rA
 T7IU7k89ZQ/NuwC6KLw==
X-Proofpoint-GUID: m-9u_4TFnItwAt_mPTeBf2Dn8WRvyRxA
X-Proofpoint-ORIG-GUID: m-9u_4TFnItwAt_mPTeBf2Dn8WRvyRxA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160006

On Mon, Jun 15, 2026 at 03:02:58AM +0530, Akhil P Oommen wrote:
> From: Aditya Sherawat <asherawa@qti.qualcomm.com>
> 
> Adreno A704 GPU found in Shikra is an IP reuse of A702 GPU with very
> minimal changes. The only KMD facing difference is the chipid and the
> zap firmware which is specified via devicetree.
> 
> Just add the new chipid to enable support for A704 GPU in Shikra.
> 
> Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
