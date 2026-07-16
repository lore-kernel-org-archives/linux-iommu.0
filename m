Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9E941E6BE
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204405; cv=none; b=XUHSMFoc3H2EMQ6mBIFvDFDWZUDCoraVdtYCYL41DIyiy+MUk+dBSUQwpZG31e93siCXZSvhA3/mRqiPhXxwFmu1IVtDPCPophZAS0JTNuUEj42Bjj7F097pvpndCGP3AKBXyJ3gdnOn0j1f6eK4vNFklMrzYsOAmdc3JpzpVoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204405; c=relaxed/simple;
	bh=IvihLxTzJw1YuxfZsmv2OMWXoTk1psFfLCiJdYU77uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm7+vsoVydgjUgCfElMqsjOvXTrFOCfjwd1q275RMqzrgivPNZCL4vGDdjClYOkpLUXTFGiie0f2YQkKJv6zXPFZ8zu0wEXXzQOJ06TFR+cu04RyItvAzvBr8raafFMjsLmoDrtjmlU/b24TD4fzvB/Rqer8RjNjgOem85C2/3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Oo8ny8Zo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D19MNrR7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oo8ny8Zo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D19MNrR7"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GBk2b12744289
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 12:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gnfV8mXoh8bJi/aMBOJjTI3s
	rvXjZPgofaMn/qDqyNA=; b=Oo8ny8ZocNouag3A4omFy8V+TOzzij2pOY5yAJ/G
	5kmCXudd6cVjO6qO8hS/VrMwcaB3QjXMpuDvCxx4Ozup9nV52IQdqSe3Eq8JX0eb
	5W+vlORkhKU0KbHu80oYT9560uQuQy8aBCIvN9hj+xiiHdBWXJtqnA4MYvghPY3b
	xb4f4LquG1ga3qzdHrf11TIDxgT2INR4RYwvQmqfMbTk8dqgKk+6+WTK7+gQYphQ
	qjFC5orxY29bcCjFHDPfLb+pQtVlzuJm2Srh9RVqjR89+7mH2qGgZPJrEFjBW1B8
	tAfkeMHdOmi9hfwM9aH5bkRdC1t33yvJ++os3qTYQ0wwtg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feeg1ksbm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 12:20:00 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-ca8aee88725so9752912a12.3
        for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 05:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784204399; x=1784809199; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gnfV8mXoh8bJi/aMBOJjTI3srvXjZPgofaMn/qDqyNA=;
        b=D19MNrR7vbexHqCbHHv09H79qnNuhUD33HPKw1rC5wMfMHJRCK2sOd9UJB9oTK0n1t
         tUl+NuqfHNVMrFPu9QHA0esS9P9B4lHOVue9txDZsI0N2s86RX5PFeefUMZoBPpm6fEr
         Y16bQHVscemuUZ/HIN+LX7eTVHnBqCUs2EfgFNsqL72BtHiOTMGiBbz64dMBvie6en42
         9nTqklmHIQtHcHZkMaWZ8z0RMNYavUDqfRFQ5pRCH330zWYmGf5uyGaxtumnG/qUuRKH
         eRL5jwMFsrAcITtr49anpNEEqHAltrg+maUc9b1QD8NGar8kOfD2jJ3a7eNg2PoC8keD
         I3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784204399; x=1784809199;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gnfV8mXoh8bJi/aMBOJjTI3srvXjZPgofaMn/qDqyNA=;
        b=eQMbiKN/4f3QLSvckv0d18ByyrR0gkiZHbfk9g2pzqxGvN4i1G/fZYeqgJJ+9+uhHZ
         R68Zq6GrY0ci73K2kLNqkn/PCixWnf6ZqNHDVraknCcpc5EPoZ0InM1XEZNU1WNIvAAu
         daUTmHGgybXqtR4Ch8RovsH8164WyPNQIXjsUmMKfM480rG0MAVzBJ59+nppt4Bnl0BO
         QmB9oPi5OlYMFDCK0MNpQLaq8brJMEAAzpn19FL1zSw8E2m6ra1a953KV5hCZ9dRlmBj
         /lzIXFFi8Y0+5gpeuQq8LarlY9g6v4lr6glG1eTCZ3uNReQPJylQXzZf2rR8xRINnTl7
         U7Gg==
X-Forwarded-Encrypted: i=1; AHgh+Rp+d+CZoZb2EVECRmTSP/JW6IxrjO2MRFxdrT4Wp0YXmIp3Y8mU52Gacu7cL9C+JabAaP4+sA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgmU+hvYx550mPM+5TOKJSiOwF6/bu4lZh4Drkh3uOOnSRHfPO
	MjP8eRgCVtHI2PdTDPajxt1y9Qhw9CHOc6TGrC28iz1HSJLZqG0rGKou/RTJePkQj+8KsyPSf5X
	nuGQ86Em1gx1vs/pt74qLDlmF2/EmxYEUV4ow1IznwjiS2MY1Ti3uusC/9Q==
X-Gm-Gg: AfdE7cnuFIYd4XXAhNZFmDnEU0uAF1HO4UDwV8z+P9pmgA+de/amOu3skkikl2vxJgp
	fFH1FGYfAXp0iMoDN7MjlG+cvUULKNxYWUN/jA3GKEv1RL7NmuBxE9vRIzv+Vt71Axzq6BE8ygA
	nwY8LqZ5it4rn6YiPFY5m/OFhgGF4GvHOaxXGXH58UjuCTWabpT8qnbQdcxvuctUH0r7xHqm5/R
	356J66E7YU0fRNUOWheA2f/PrIkqJQWOaXRwkWEodaFVQPrfjmPhL4SvAN/56kLqpg8WqUwuOdE
	2K3+KB57wqO4g/tV5YTOO377DPQ+ns8RCRkvXouZQurNtZ7xjYi98djQiWKNGR9R7hUjyDL9kiW
	pxAiWPE7ZitNZ6w5Re21ZowmE4PU=
X-Received: by 2002:a05:6a20:c786:b0:3c3:9ed1:2549 with SMTP id adf61e73a8af0-3c39ed1356dmr135374637.41.1784204399464;
        Thu, 16 Jul 2026 05:19:59 -0700 (PDT)
X-Received: by 2002:a05:6a20:c786:b0:3c3:9ed1:2549 with SMTP id adf61e73a8af0-3c39ed1356dmr135323637.41.1784204398889;
        Thu, 16 Jul 2026 05:19:58 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cdc4accf4sm2336066c88.10.2026.07.16.05.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:19:58 -0700 (PDT)
Date: Thu, 16 Jul 2026 17:49:52 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Weimin Xiong <xiongwm2026@163.com>, robin.clark@oss.qualcomm.com,
        joro@8bytes.org, will@kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] iommu/msm: Fix dangling list entry on probe failure
Message-ID: <20260716121952.rccgie7y7ymkuh54@hu-mojha-hyd.qualcomm.com>
References: <20260716013229.91014-1-xiongwm2026@163.com>
 <20260716085313.207069-1-xiongwm2026@163.com>
 <6caf8ca0-8be5-4935-9766-10d21c71ac37@oss.qualcomm.com>
 <0f5ef1fe-7d15-4354-90eb-a7e42623ae94@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f5ef1fe-7d15-4354-90eb-a7e42623ae94@arm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyNyBTYWx0ZWRfX3akPgVpSsJ6Y
 zgb3851A21q4smPaYhuLsLJGM+ymIXjfjdwnKVt+MaWi7yuj7yQX8hVbBXKKfGrPwoJnVU+ZdYg
 ElHiRO+m1lsFybMmsPMvsaBCOdTPKVVsrs3VJhIeL7G5G5arTjc/A9ffbSl4v7ZZ4fcrkkpho+t
 WylCt5De4C9G9q+LjiuYfCCahgPQ/qJAKrXikElwLAKLM2RNjsdTvZoCs9gcwv/VH9UthhiPTLI
 jCmJydT6M65gKoHdd4RnjIPn+OYLXIsqBZabPp8O2AHcTLbEQ5tTVx5V4hrllKbQ6mv4GuEml36
 dK9ycgIrvnVbpw17FtixYwRNR+eZ6FlW0gnQvFf6mRlQCVMVybvKbdRnt0beQ1KVOBwIb+w3xxl
 E8uHvRSNOb4nW1s17yC5Ihd+QWpJtwnjuawCfGZZZE861Nm+c2L9Awhy3PAbpVcvQiDt3fI565f
 seDPnqCq/i9IvodJ6Fw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyNyBTYWx0ZWRfX64EVUjDEsEnQ
 Zimkv3kZPT7807WFHopwgUZSuVNybCQ8tAnJSSNzg8zQ1N6Nk5BdGVWUeyDd39Nno1++cfQa/Q1
 ovCfJj48msU5zQGButOyZTVJW740zYQ=
X-Proofpoint-GUID: B2wrUQOdAkndTsYB4GxBIdH_bIj0QuFS
X-Proofpoint-ORIG-GUID: B2wrUQOdAkndTsYB4GxBIdH_bIj0QuFS
X-Authority-Analysis: v=2.4 cv=SsOgLvO0 c=1 sm=1 tr=0 ts=6a58cc70 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=3MspdcVbyA1qY6HslxQA:9 a=CjuIK1q_8ugA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160127

On Thu, Jul 16, 2026 at 01:05:57PM +0100, Robin Murphy wrote:
> On 16/07/2026 10:42 am, Konrad Dybcio wrote:
> > On 7/16/26 10:53 AM, Weimin Xiong wrote:
> > > Move the list_add() call to the end of msm_iommu_probe() instead of
> > > adding cleanup paths, which avoids the dangling list entry problem
> > > entirely (suggested by Mukesh Ojha).
> > > 
> > > This approach simplifies the code by ensuring the iommu device is
> > > never added to the global list until after all potential failure
> > > points have passed.
> > > 
> > > Changes in v3:
> > > - Move list_add() to the end instead of adding cleanup labels
> > >    (suggested by Mukesh Ojha)
> > 
> > I think this approach introduces a race condition, because e.g.
> > iommu_ops->of_xlate() depends on the item being present in this list
> 
> Yes, the IOMMU instance must be ready to be fully functional *before*
> calling iommu_device_register(), since that can start probing and attaching
> client devices before it returns.

Right..I overlooked it.

v2 is fine ..


@Weimin,  JFYI, Always send patch revision as a new thread not as a reply of
previous version.

-- 
-Mukesh Ojha
