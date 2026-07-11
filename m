Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04A13AD51F
	for <iommu@lists.linux.dev>; Sat, 11 Jul 2026 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783793052; cv=none; b=VZyqC14xGtuPX6ReQYbjR1Bvt4gurux0/9drnio74A/Ye+7/Pl1yeZ5Qz15UuO+JI1A1uX9Y3504G6/OgP4n6j4giqRd9c5pkEtu3Ggm3+C+IrbpiCzCmUfcsIEXnf8i7J6Vh/q4Go5gqLbIX3TjgHE1ImyMcUFt3StosXV2/d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783793052; c=relaxed/simple;
	bh=fMoeKDL01AH/hbKIXK7dj8/vhNF5UG/sgOmRbn0CUYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JX/HxuPNjGArqqudk7npHsD8IjR7GUnSuQpeVy3XohIqrmSKj2P2X66Dq9wZCgVEuYBDfF3wsQOD9M0Og2OnEdY35PRlPUCqO6tYZ3ISkj8JDlFVSH1mh1nf9Q//bvkAGyG3JE6wKMQ/XhxtS8sPKc9eeap0M3a9J6O5q7QUPHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nlhG9iGs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KvLDokZu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nlhG9iGs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KvLDokZu"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66BHn7wx393391
	for <iommu@lists.linux.dev>; Sat, 11 Jul 2026 18:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gi7mAsPzRKDSQ0PcWw7D/RRQ
	waT6XIdXYVfkOrbW+f8=; b=nlhG9iGsUHzeL/pnhekXb0cQ7HhewmN3YpC/275Q
	H7XLy/KMwJ1+b2ZI6OhPtuAo6Z8h0M3Sk93fuuw6etBHnbb8uhshs9nhBrbH7cXK
	kLDDcoqjYUC/3uGM5+45SVW8p+6sZSFJfJv0b3z3xXUPkUl11kDeKHHj+2yU1iqn
	MfZ4lmy07AiA54I8IgdSVpsGf3QdoK2PhqnNf55ddEZm42f6cBpi2GhxyMIqsFRI
	K2/6eB0NZjIc0yVfUEniZZQd0WjQ01GTIzxTbQbZZsqw2JnKlWlBiJz0tCyvOI1n
	LdoYGMsVVVbE0IVeC74yZovJiDk1dx993brLSt+EelMtHQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeaf9b08-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 11 Jul 2026 18:04:10 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c075c1e25so15919311cf.3
        for <iommu@lists.linux.dev>; Sat, 11 Jul 2026 11:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783793049; x=1784397849; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gi7mAsPzRKDSQ0PcWw7D/RRQwaT6XIdXYVfkOrbW+f8=;
        b=KvLDokZusxk/HDp5bLxWUUIXP4ANEENRPzoIM1zJjT3wiaakZpjY8nygJObfF+OcEW
         CdeZ37xnxf2emdpCUIbsQYhvC+HE/RJt6STGeN/f7scALA4osjSJ5pikjYWnYzTyxeZT
         4yq1dHNlaDvxIMg39EOeL6Wzf2YpyQCnHoTHhdDwuibKssu+2Y1p2f+PIi20rHhC/Z98
         okOLCQCHUjuJgC1YT6+r//JCUz4HrSeVIzseuY/OBVZpEhaXKZfX/36bs07kgxc6apSg
         K8ieDaLB1TOpbT+yONaot9pcsyb6B70BrYD/99OjnoEZ6F3w76oiNpT8bucPT0e+8emT
         A6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783793049; x=1784397849;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gi7mAsPzRKDSQ0PcWw7D/RRQwaT6XIdXYVfkOrbW+f8=;
        b=Hfic5gww0Rg+IsPcoPJmmrq9ojr+mNPaC9cXDDh+6C/EXLhKkjSf818AGLEKgaMhZW
         24GraCaDz3z2UUeAhSX37YnZSAGJY8gANYdZ3nFanfA2yVQTIPkL0XztBeEyc423kmb5
         acD1yJxGdMKz7tcgiI3+tndrEL+qsh2uh/6j6HxPVkcBip3IQfCaTqQCSFUuPUV6VgbP
         Npc9lQD6H46wgZ+GRg0bYKVpXv5kw8ZK3/XKR5CbeaGr0D1WQHX8GLIjsNGLyTzjbHli
         Ir2OHb+nbev8nm+oYQF0+GDj2YJm4DN2XJcW4QCvJ77rOGFf6L6c7X3n4LQMDldyjVAu
         vV5g==
X-Forwarded-Encrypted: i=1; AHgh+RpICQEMo+YoOgSQOIe6p4tAJarD40JrV/lS4rmoyXHYqXwbZ6WgfnlSNGVWAmsj1nivRXDozw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5+WdTFgrOmLJEKnH4VhXBmCmmB48710s4VyfNBUHKoSIZn6ON
	v/E26n+wCSljMFRiU70Kpu/KPGTvuC1k/+eS0YAY+bPCLwuIsmVXBp6HdVTn1OBtg7t4Qf3z+Gb
	Vyteab6BWSDExB5MNJdMPACIwaMzDzC/JQkB3WhB/PCwiuHWVLMAvI8x1zQ==
X-Gm-Gg: AfdE7cm+Wyw2jKuum/t1y4yLDallw68f5sPgWdke0KHteD1r1J2chqQNvjGKFgZN2rf
	CjWQj/8XEzzTbdyHTUwQxrYvBxEzuX2pMEPhO6Q30cz/E3XZqh2S5h69IzD8zeaA7tkGFbtrID4
	B5NM72HDXmHrT0zhNH4L/UzFptyl/VEtQniC5Akjp5oZmHHS3dFqAhL4Q3Kuo/hFeb4iWYGXrAE
	uwyTw0ri99okhcewzzqOrIB2V2lsGoseEQvCQR+o4z78N+esFF3Ze80NXdrlwQzFv/JHrShZ90F
	30W3xCi5Cw/b7o8vFwGtsAj5G0mKZWYXeEyXQLidvnGs7rPFTwe9OfkrC2518dLgtzqIrEclfXX
	y/VmSDtZQGslGwutTxEKKtqTfYNvX6TYST5puLZAYKTmuby/h+OkAZ3G3gZi8ImZ/ucfwYDqqlB
	6Gp6tBNmdSBZubwSd9nLz80xjH
X-Received: by 2002:a05:622a:58cd:b0:519:ef86:127d with SMTP id d75a77b69052e-51cbf07149dmr36273481cf.18.1783793048974;
        Sat, 11 Jul 2026 11:04:08 -0700 (PDT)
X-Received: by 2002:a05:622a:58cd:b0:519:ef86:127d with SMTP id d75a77b69052e-51cbf07149dmr36273101cf.18.1783793048432;
        Sat, 11 Jul 2026 11:04:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca9ddfbsm1478518e87.54.2026.07.11.11.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 11:04:07 -0700 (PDT)
Date: Sat, 11 Jul 2026 21:04:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Esteban Urrutia <esteuwu@proton.me>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 2/8] arm64: dts: qcom: sm8450: Remove unneeded reserved
 memory nodes
Message-ID: <vbsdddrjoq73h2tal77rdm573ydomwsagr7fujjh7znw3dnbka@olj35zj5pyzn>
References: <20260622-sm8450-qol-v1-0-37e2ee8df9da@proton.me>
 <20260622-sm8450-qol-v1-2-37e2ee8df9da@proton.me>
 <e1e492ab-884e-442b-8410-cc100c54fd5f@oss.qualcomm.com>
 <6123a923-21dd-4f69-9ac5-02165963027c@oss.qualcomm.com>
 <b3541802-3035-40ee-8327-a65bd5d2dfee@proton.me>
 <4g6y4q2udludhwmoqc34afwj5svra4a4j5bmpqza7h3av2oov7@6k5r7a4meruk>
 <c11f9ddd-8533-426c-8a88-0ed461f6a30e@proton.me>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c11f9ddd-8533-426c-8a88-0ed461f6a30e@proton.me>
X-Proofpoint-ORIG-GUID: O6NvpQex0qT4WGCBq-LKBXFxyeurOd5G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDE4MyBTYWx0ZWRfX0AKc25UYeyHd
 GpQn+HpWF0fuG15AAPT+zWDDvjnVMZL7f1vkO515BwSNBw1poJPBkPS5TYwUmSGq7+ms//Kyht3
 yLJ0ti6b+IdSrjoYPsrL+QUpQoU2fr08YSxVzh/zy02yHpAxoZJh6CqSQHr21SSl2wpR2y/TXcq
 q/Nsh7L6S8gvXn78Lo0TLeWqHeIeabfcVaVbV3q4RRxaTBYoifQVmvI6GMRLjvCBJKrz6h4iWm5
 KXbix4n4RQRQAZR10XFdTJLuURuzIPB0ZRD+VH7+SyiAww5GEUK8jSV8bHNtOckpGEf2c41lYfD
 tCZKOHgpLklMb0XkM0U99jDPA2glDIkEm4WwIvOM3IjpDMQxZV1fLCOtKnuTcfCJJSKMLPjI3kX
 QyQ+iXEkiZlVmdY1U5Cuzmx9C8nSKMYbO6UN7zEktKgQQ5ZJZ50swq3uVJq8Fwg+hux6RD75g2b
 GF5topHIojX6Ca1ROxQ==
X-Authority-Analysis: v=2.4 cv=O5MJeh9W c=1 sm=1 tr=0 ts=6a52859a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=A3yFiG93vv4HRecOgxcA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: O6NvpQex0qT4WGCBq-LKBXFxyeurOd5G
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDE4MyBTYWx0ZWRfX5BDxa3HzWpwO
 Al2O0sNBxeSIXFo9TdPv+l6Q8uP7xplIYqsvUKAaomKW6Liyn+0yCM4DT5RqARgWWVs4Gq8f28S
 4uLbH3LCuwyPFY//KRPS9O+7MaR0cqU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110183

On Tue, Jul 07, 2026 at 03:19:22AM +0000, Esteban Urrutia wrote:
> On 7/6/26 2:24 PM, Dmitry Baryshkov wrote:
> > Please verify that you can actually access those areas (boot with
> > memtest=1)
> 
> Thanks for the suggestion!
> 
> I actually did boot an SM8475 based device I'm mainlining (motorola-bronco)
> with this parameter.
> Deleted regions in DT are as follows:
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
