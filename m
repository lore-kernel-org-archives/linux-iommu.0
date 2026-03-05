Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E71D27A133
	for <iommu@lists.linux.dev>; Thu,  5 Mar 2026 03:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772682068; cv=none; b=mFHmR+89QDYzjSRvqoxC8TzMRIkKGOvyKirMQ6C9C2iNYvwX0/vom2II+kKYV1plxpMphGTidHFcuvlk4JzNEBIzErPJcnaedV2u26Q9LQFleSl+CGkRAjETGFBYbKf5Nzgc+K/6AYc8qjsZ1ud8v6HTmYGgQhohla/LWA7kWOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772682068; c=relaxed/simple;
	bh=HaNITUyfD+GBmdX1X/Vb2Jcxk5484wXAuiJIkuXv0LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/Mhly0U5ANBy2X70Jj60dJ27M6ggPvPXC5LLCvU+khWpgWzqIsT80oc82Yd8Gwo0hVjOZk+A1BiXmeKQxnUWGvwsNDbuVoOcfS4MrCd2vkYl8gKa62PgRJuIDhrsnCxMuEhShNTt+PYj9BisyUckiNGGCwdDv5pziT6KcYRsNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GqfYzYRF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fgt/CXfx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GqfYzYRF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fgt/CXfx"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6251Bl2V3604196
	for <iommu@lists.linux.dev>; Thu, 5 Mar 2026 03:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Y4BdL9DSWsAx+T+ghZWQ0w/E
	FG7qShwRNJI0u4mTcF4=; b=GqfYzYRFZ6WP459QoXUoGydQK3jYL5uWr06eBv59
	92K6kWYHQNe1wODK9sAfT+HtjAJQPwwZg6hQ34PVLtTOzYlKSZkHsu6o8D6ULbL2
	Yz+Fum7hB+KYF67vr1VrnEw+t3/OwdMSQwuyz9C2JVPe5kMvx4paIdsnYgG7//yL
	55UW5NCU1SrH4dcTKD2KQBh7k34mIVuRRaaLqz2ZVJDkt1HiepxYWYkUSeL3XsRV
	bo3LjY+RiJJdM96DTwnNjmDEV5Koj1k7naAjnYiQxoX0WFh/NRm2Ni1FgFv4OSrW
	i7jv3vY1bXwawaonsEcKJ6wA87Clyxr+R62tKhzNKr9giw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0w9k2r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 05 Mar 2026 03:41:06 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb4b8e9112so660248285a.2
        for <iommu@lists.linux.dev>; Wed, 04 Mar 2026 19:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772682066; x=1773286866; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4BdL9DSWsAx+T+ghZWQ0w/EFG7qShwRNJI0u4mTcF4=;
        b=fgt/CXfxEeAaYQg6I99AUVYHMg3VU4tZciDTfafHZF91bxBOIfeiSso0UiwKD8IwJ4
         DH/WsnqftgekfTphvdK6MCQQPK72xgC+VSDJFgX2JHB5ispeDunCTNkUq6X7gu0qCuqQ
         uzNJ/KsJWh8RwzNBfPQNNHXe8k74rjaIK0W7/+4cCCaCRJEOhEHBI6Q7YV23urRTq/8G
         JL3SJVmOT1jIXLZ/RTxSO0oa3PiDMRvxckT6I6pcYyJnnEAlzlxicHXLtLk+tYKg9vvR
         wBthuS+jHoIztb9H5R6h/Y40PiblfA+XGllAVYHemAjgUoPnvNpGdFLy/zaNipvy1STI
         sJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772682066; x=1773286866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4BdL9DSWsAx+T+ghZWQ0w/EFG7qShwRNJI0u4mTcF4=;
        b=G0eTBQUIM5ZInNM1+zYg9f/EhqKQoc2K+G5WHNvIJOys5dRqSbM9d8CzGzmOrPLnLl
         t+E8c9WceUaQHQsX7sXoISn8BcAl5As5B0/ikm6XRSg1M6mOj81lmt7NFfw+ov18EBh1
         u76n3JrBmDs5IfSfdnyuaxwXnqeeyNjBB/IsM/Pfvme4ECr/J0EYgpcUPjuqq11wR1rB
         LAxDabXZKS4aP4L5BWPEDmLV65r/xatEXBx9Pz4nLvGWyNR496G4GdCUTRMadCfIMHEq
         iJE9Q32HIs7PXkuymTjQXIptuQCoYu9aMrAnE4XsWfo1zM7V//8lfdxOmpFCFRmwpPlB
         Ggkg==
X-Forwarded-Encrypted: i=1; AJvYcCVRZEQdp9EggYPgpjOZwQIIPRoteDVAcMQTRmDtIpt55RilRsi9z5+yl7mRjTsk4+DWAOSgzA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxj6clmmdQmXvL+7qq+5GbuTsWDMtmEjHbOherwZH8Nfdgm5fOP
	jv3zTKlAgXZs+ql1g4lRHQx5c6tamQpqRcn9255CgEnelgSYVGIN4iA+eUHN6fFlbHsbXmztw7b
	5SVm8Vdg2dV/mHFhPnT2FDQ92FFu9DZykJbKq51gpte97XQ+to8X4W/S/mQ==
X-Gm-Gg: ATEYQzzKMIYC6RYv1KGKnNTDZzdKeMyLAy78HqBq5mBWfTTq3oPBxSBL2rtDp7AYg20
	pvBgoGn9mqgyrZR8grE8XzpZeYmJflxWHGJfwD/3OY0XrlI/nSYXPzhS764Lg+3qaEcz8cL82XZ
	YDK8OQVzAi/s67wiag6Sm6uc9v1587EQGSLTaHe39VVLK/pt11DxZiLfn9HjCpnQLbZ10iGLCw3
	9RX9uhUR0hqS0m7Ktds8yzyvEykymzRWI1q9t1ou4UKO3e0XbHO0us+8BwGvZT2vhNkv3zXZiud
	HtS8u0IQ2CPhd/VcfBo/3zTlF+0WOw0hzy7I+6L84dFpQrHRwpLCNrgckl8M/2pOqhoAJCSFqge
	EHm65w6SKzYid04A85JmgWr+Cn8wICMVl4PgSBw6UaB8HgtJkzoC7aFGzcatN/K1/kyJsl3vi9h
	BrnWPcccjvDpYT2x6OALydK2HDyvbIuwG89Zw=
X-Received: by 2002:a05:620a:318f:b0:8c7:136f:3fb5 with SMTP id af79cd13be357-8cd5af9e0bamr543314585a.54.1772682065769;
        Wed, 04 Mar 2026 19:41:05 -0800 (PST)
X-Received: by 2002:a05:620a:318f:b0:8c7:136f:3fb5 with SMTP id af79cd13be357-8cd5af9e0bamr543312685a.54.1772682065184;
        Wed, 04 Mar 2026 19:41:05 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a12e56544dsm577958e87.29.2026.03.04.19.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 19:41:03 -0800 (PST)
Date: Thu, 5 Mar 2026 05:41:00 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v2 6/7] media: iris: add iris4 specific H265 line buffer
 calculation
Message-ID: <mp32nyambs6jrois2w4qysztdtcw3xtcqmpo6lim7d5pjlgvyw@soltgnfpytgs>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-6-850043ac3933@oss.qualcomm.com>
 <cbwz5wtd55enswdi2zvvy3d66nsxlemyzdypheibvljnewmkax@kybx63aveepn>
 <ce80e60e-90ca-415d-83af-4fe2e86ffd91@oss.qualcomm.com>
 <hrjwyqz4r6usqvxhnsvtap4byfu2zvumji6whudda55vuym5yk@u6s4heswm4rc>
 <22534cad-8940-43c5-a7b9-01d002943093@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22534cad-8940-43c5-a7b9-01d002943093@oss.qualcomm.com>
X-Proofpoint-GUID: Yzp4pLxcJCOvGZVitDr5uuqHAGXn046B
X-Authority-Analysis: v=2.4 cv=BNK+bVQG c=1 sm=1 tr=0 ts=69a8fb52 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=P-IC7800AAAA:8
 a=AZpcuS3xHcn0W0hrMwMA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDAyNiBTYWx0ZWRfX1wiogCq0PHvw
 pcMOcsiCwgYyuJvSd4CkMFWOTBoCal5yZgC58Kxjhs1Y6IO1p9gMFhWNRJI47ZkNWW/wYySSM+7
 TYWecAPku8jWHoQ175MMb2uZG3NpyAZOtvpVFT6zW6XxBoh0P50ztHdq3qrUfsICYxK4uAU+eI8
 nHWT8odWbK3PdRIAP/sWEG3m1ZbGxd6T46Qfrjx6+3fv2oHNLkWCIhyHROLRYeB/C7QMrSKHz6j
 hR/1g21hB91HoA0lsIRw0DOI2gi3HZOtujnUxvSeMykMTAkLwCl7lrK0Yr/5qDa7yWKjS+EkIW5
 hWGLZ2AJNgsvz6RqLD4dOn78XDoVYgvkSEGvZIon+ONQZT0rD8A5kumQVYT1wp0zLajNrSEGQuD
 +gaj2dlO/y5kigxiP0vRQpq8cBDmBp0ZKk18ZWHrsDPPLya8Vyvl13asp2JNrPXrmQdrem9D9pb
 0C36sPLoeRxjDYwuoHg==
X-Proofpoint-ORIG-GUID: Yzp4pLxcJCOvGZVitDr5uuqHAGXn046B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_09,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050026

On Wed, Mar 04, 2026 at 09:10:33PM +0530, Vikash Garodia wrote:
> 
> On 3/4/2026 3:58 AM, Dmitry Baryshkov wrote:
> > On Wed, Mar 04, 2026 at 12:18:58AM +0530, Vikash Garodia wrote:
> > > 
> > > On 2/28/2026 1:58 AM, Dmitry Baryshkov wrote:
> > > > On Fri, Feb 27, 2026 at 07:41:22PM +0530, Vikash Garodia wrote:
> > > > > The H265 decoder line buffer size calculation for iris4 (VPU4) was
> > > > > previously reusing the iris3 formula. While this works for most
> > > > > resolutions, certain configurations require a larger buffer size on
> > > > > iris4, causing firmware errors during decode. This resolves firmware
> > > > > failures seen with specific test vectors on kaanapali (iris4), and fixes
> > > > > the following failing fluster tests
> > > > > - PICSIZE_C_Bossen_1
> > > > > - WPP_E_ericsson_MAIN_2
> > > > 
> > > > This reminds me of the commit fixing SC7280 support. Should SC7280 or
> > > > all VPU2.0 platforms also use separate formula?
> > > > 
> > > for vpu2, there is already a separate formula
> > 
> > It was more of "do we need separate formulas within vpu2".
> 
> vpu2/3 uses the same one currently here [1].
> 
> vpu4 seems to be using quite a different formula to consider it within
> vpu2/3.
> 
> [1]https://elixir.bootlin.com/linux/v6.19.3/source/drivers/media/platform/qcom/iris/iris_vpu_buffer.c#L313

Ack

-- 
With best wishes
Dmitry
