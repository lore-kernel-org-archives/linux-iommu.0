Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBAC39734D
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349852; cv=none; b=Y9WYSmKxI8uSpE8LxaXS64mCL80Hg1gji5gi2JljnvTYFcSWtV2ItxrYqlsWriWWi6EtlJzZaTuIzXjl9iK7D23ygDlIk4Gwi8SDb54zSz2KIGY35mdaGNgF5rF2bXlmM0WBE/a7OaQadDkHgUmRvLq70luipqQIq4JkEpF05UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349852; c=relaxed/simple;
	bh=euY+KmOhlsqbzFJHjgYGwPowl25OoEPkxAZqHFyBFRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCsc6vsKV6DU9DUynLq7l9sqcA/dt73bKJQ8zr5hE+J6aXAWQ6IPiMnK517lZLbIKUnWpEbYwiOd4bnh6zo2hD6mNRtinleY64UUS30rA9NrXvqg8JQWn9q6G4LVRPebylJ08opWmsrXP+j2vdjeVlNSneuUbp9D2djmLRq9zIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lw7Z7xvm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z3wWbcJz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lw7Z7xvm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z3wWbcJz"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666EEGMV828409
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 14:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hYCsnJxlsCoVEAci2Y2tWdW2
	BwZ2uRLCnXO1hko98pw=; b=lw7Z7xvmkSruIL2Cbny55zDYJFedy2/3xwd50Z5j
	L9GVNUAAUXgvKpTtHKCzGZ2z6mQbVIVdMycWmLXXoy4PX3/mPfdI4dOQcSrboFLu
	CSDXJdlrzr8N6R0OSwp64XRjG3TsvlhXIo9A9TnwE/xPhhLC/4NP+q7PB5713PL0
	4vlh+NlzOYN48uRJK6ogNfxfsKVIvQ4fHbxsWVfeaxlrJT5LQr0BT0nE/wldH8sl
	Ahc9qq3hv2RZLemwEYWfHqlA/MqimVnqJljhJUcmiXTMUSScyr5aWROWsY7I7aRm
	O+lo05VSAJ+nZjUlCWJC3kKv0srswoDukX8rmZpB3hXr0Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r18tm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 14:57:28 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e820609d9so230824585a.2
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 07:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783349848; x=1783954648; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hYCsnJxlsCoVEAci2Y2tWdW2BwZ2uRLCnXO1hko98pw=;
        b=Z3wWbcJzInOhOz+P4HJGljTSiu6zKUA3oCP996cUBDc2vU5J+wBpOUz3nf8LqFPkwv
         OzuNNTn7sI4PdWUcQyRDhaowb6HhKniPoB493uDijVTx2yeVVxbD6yBQ3fg2stx1s373
         BUFPXyFqw5HyQR/q4DdIdSCPPJIPYEPfp0Aiyvx76FlXk8oSVuOWlAFyToYbF6h6GlL0
         kYhU+S4LYYkkvv6h2jGo76Q2Z0MECRnDo+FamAOp2qqy5UQA26Ngobh4/Qk1Q6pEg0Zt
         X1sLuNW/hsVCehnJskx0rEee3SNpF1AnemIK5PWjEsS0fv/MDMxOjKDahw7nT2cgF663
         fGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783349848; x=1783954648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYCsnJxlsCoVEAci2Y2tWdW2BwZ2uRLCnXO1hko98pw=;
        b=ac2skIc+1yumS0YeTMyPNJqvwsBP9MV2T13rsPsQ2x4ja3txuFLk3pS+g/eWCcFfKq
         Gd270kg1Iy8VN2loI7WCcsHRI4Y+A1/JBKwRkQLbvF58bq6c95HtPWMa/fAXAyFoL/Lp
         E/M8iKHbG28mjgqPjyJLEN96pOp6C8CY1K29SVbLFbkYFEdodskFC4f0BCufHEDFLSxT
         cD4xOc+WCBqnhDLXfEnBx3x4rKTIotE5id84Ktkt2McCpO97q0+oqCpKI0wZ2AWC1w1Y
         qBlzYf4TWIYXY0CuJRvuFRCWlYz/dq7PGedkCEXpSQahwHveWmtmoZwDRcsyomXvc1CH
         x/PQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqii7e9Rk+vp/dFkM780FWA/3IOK0I1yVAm2VGFhkco8rdnMftzKmsTi4isbkLcP9S5B5qv8g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyk8ES+H1/tlQYWuWhz3FgeZZ0DLoD+ONmdBqMBp0UzMXN5Cb8h
	oJ3m+YQCqX3bR96BmFwSMWwKF7VGVCA5mos1RxRFVlflDFo7lqsVJSPsSnvFO0ynmDWW/5t99O7
	YcPB5a7snFrQBe2hUnoCcDe4DR+bqp8psEyjzfavvd0un1KZSCqHxWNOyLA==
X-Gm-Gg: AfdE7clep7TW8NFZTbNITK+kfhrV5hLNKvuprPc37PLWZ2En7xWZLs3uMFJflUUU+rp
	JwD7+gmoKDSxzIUa05Ijxiyy5sDs04KvJcr/nR5MKcG00i/HLcr2Rf1wwbPQvGkDRGx67UqUyW0
	0zMN5Vpqlq0mKCgj6dDE6NyXOyooZxAnoAvMA6JpEYR4ZRLmvspP+8WODcGoQJonf2UXn4li2D0
	T7qfO/vgx9Yd+zvIHl9BRMRMpk6PmQr4RoMP2BeAGaEYDKWqqmYak/xWHZ8PEm5FQ9uke4Jjgv0
	O8Xs2m3L5f8MezWjgytOV1KruKgNoNf6WfcBPbZ7BhB9hrc3e2EijNpq1hbMo/HT0hwDpm2fnhW
	9TTAIB80GU1K2vl8YhQl/sn1Ytxn8Rc9GmdbXaGlduhn8oxdKLzMlNVGzBV1PkuyHm1Nf6kW9az
	Nz/wqpSlfyez+Lpd+bre7MKVQL
X-Received: by 2002:a05:620a:4101:b0:92e:8256:8226 with SMTP id af79cd13be357-92ebb56a788mr122717185a.44.1783349848287;
        Mon, 06 Jul 2026 07:57:28 -0700 (PDT)
X-Received: by 2002:a05:620a:4101:b0:92e:8256:8226 with SMTP id af79cd13be357-92ebb56a788mr122711185a.44.1783349847690;
        Mon, 06 Jul 2026 07:57:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39b4ad35edfsm23456681fa.13.2026.07.06.07.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:57:25 -0700 (PDT)
Date: Mon, 6 Jul 2026 17:57:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 00/13] Enable LPAC on a7xx series GPUs
Message-ID: <mn7dmfbyt2hnvlb7u2vnxurqef3w45rrjanhkd5ei65sgasfnl@l73s4c6yqxbe>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE1MiBTYWx0ZWRfX4oLDy+nmlw59
 cbIbKcuy3sdqI0nm4iG24nHjKIPJx9rUg3FMCa51mY3aoDI9D35IC1AKHWWd1fEWD+xkxXSJoXM
 Erq9XWob42TL8BvhkV5a2IRCTNU/aT7uHpdZIey/sBlvbELOivS2vOnQRcIkYTFRq9jdW880bFd
 gkLdQt1uCjFdnP3TcBQfvMFZWNzSDfXZ1AGYCO0bohwP5cWgv6X6U+PqCW/xYSSlT1jGwiCTkEi
 6CufUdmCdf5MOldCMa7T+MUcxNmaYthHjJt3OzmkoSeQYv0Y//C+zKF/PzveP2lu6k1cv8Ah3pm
 xpLa5rXNf30pQ+MfCVbdsDDWzfg/pkGzNztyV6LXzv10pxna4Z5jFmEEixEuBNvSIpmCf4tI5Pc
 E7ty5XFhWVI08h/37PGf5Olbtc37gG3PM6P4cQn8e+daqNKOQHokL0YCaG+qcO+Tb9iKdG5DUrP
 q84pnyw+N518W/D53Uw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE1MiBTYWx0ZWRfX6G0aQ8bw7Fbu
 37i42WvmWpat/m5H1mOJlthybyF45qUMkGrOYS/iwDbTqg9zRFPclAmjeA+tOQDT4ZtVga9+aqB
 F7NGBgNuDFMk+MDpRLIBQ6Sf1k80sYE=
X-Proofpoint-GUID: YC_i2EtwmoebTI5Sy-GxmW0_QzYcorA5
X-Proofpoint-ORIG-GUID: YC_i2EtwmoebTI5Sy-GxmW0_QzYcorA5
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4bc258 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=5ytNcvzt7bZj-gOGiacA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060152

On Sun, Jul 05, 2026 at 09:13:34PM +0200, Anna Maniscalco wrote:
> This series enables LPAC on a7xx GPUs

What is LPAC? Please explain (or at least expand it once) it here and in
the first commit goes to each subsystem

> 
> Currently hangcheck and recovery are broken as the patches to make them
> work depend on https://lore.kernel.org/linux-arm-msm/20250911-preemption_aware_hangcheck-v1-0-974819876819@gmail.com/
> 
> The series also depends on https://lore.kernel.org/linux-arm-msm/177919116291.814652.1720687887970998122.b4-ty@kernel.org/
> to work correctly.
> 
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>

-- 
With best wishes
Dmitry
