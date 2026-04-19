Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B1F3002BB
	for <iommu@lists.linux.dev>; Sun, 19 Apr 2026 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776592340; cv=none; b=OZTRc8JdVsPUQAvV5MWEpBWJMe9LewzC6Ujyzq7PDbhwGi5cmneCYG6U7lIfmQLx7KzvlF8mX4p/BulG2OqWf2hMltx/g3UfhFAHPqZchRDk1XP8U+qNxt7n1luCUnIYYyeBXlZwaLECZ5sbPHq+1ZdKo+N7tZZpc9PM1QTlIo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776592340; c=relaxed/simple;
	bh=E0HvCgJX/7g4mDSi7loqmioSNLi/qoK3a2PhrolbZy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MC2/7hI5oCIcIQMLxEwMPq1j6Z+RLirtmYBmyGUBTtYphSW9IiiVR2Bgl8aKX5zsueEbrWJ9JKyezo8VkyLe9kX6F/X5SUeXboVIs4MSiyjvDOTEpPUogfjXBzNSSCaT0T9JdLKrIvHbGyhOA7ATwefUaSGPZQQOUctHoqpl6yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=al+xqVad; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c81gHMFh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="al+xqVad";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c81gHMFh"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63J4jfF53212941
	for <iommu@lists.linux.dev>; Sun, 19 Apr 2026 09:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XEo2oTEcsG7l3+0lO7xxDJBT
	jTSe7sGpcaQQHTUMBQ4=; b=al+xqVad34Y/bw7J9fDIIbwH24QaohImnwDm6pGa
	gx6jPzlcOjHPgGY0a9S84+nvdXyfkcizkgdraOpsrljazqANG/kOaPgStN9sXt+e
	EHrJphjGkh74TcCUIe7gVJ/s8CO2Tqkbe4EHDZjPTZznH6WSFrYAI+EJBCtmRhPj
	4xFnc7anee0zBmWvqhSE8/mYqRyidloYwxtWPbvoS5IdpIXFb3khqRjKYwMD/A04
	Ld+nEu41Ot/Qrmhh/4Cdi2Z6nGl43YaDAzUKiKtmg6H0hOdIozkChRF4BMohoOnY
	Xm0E0ZdY1aKIO1dQiFTPRR9xnFWouvPhLNduqQyEsCqqXw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm0wr2f54-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 19 Apr 2026 09:52:18 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-127876be621so1925990c88.1
        for <iommu@lists.linux.dev>; Sun, 19 Apr 2026 02:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776592338; x=1777197138; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XEo2oTEcsG7l3+0lO7xxDJBTjTSe7sGpcaQQHTUMBQ4=;
        b=c81gHMFhh+R/v75pb+e1i+Sf2CCegJpiaeGkV5RA5f9fqMGDVKr0+1P38nxRmV1H7F
         +ui4rd0NF0wDbI1bd8QZOEIWtFI7GsTkOju/6JdNWcqVm9ZeGc9g/XBLae8FwgAzFSx0
         DVe5fEinezJNA73nNr5S1r+LVWvjz9ZLYcrJXfeHh4G+OJfvBZoxDSc0uYH53FX0xqED
         CPuvselzlHnzMaCqJAmmNab1SHxKs4F0iWhudzjCs7i767sBNd7bDxLhwSipQ/anVy2F
         bshXvM5QqvtB7HaUzcZqAxcwUA1zQ7rgLz1v/QqEH5KMy6+N/XaoZAU2fR/hbAGqb/Xx
         FNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776592338; x=1777197138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEo2oTEcsG7l3+0lO7xxDJBTjTSe7sGpcaQQHTUMBQ4=;
        b=lO4M5OEcKX6w0ox8dB+3WuJTLQP/Hh60u1E4M+uFJlMxFI/4/50scTuc4/F5BEc9o1
         /LpGru18g5rk/tVJ2hTvWTEsgOEMO1fJL33Cgi90mLZNiEQc7o2lvQTt2SP4BOLTuy76
         tKCBprrLh3IO33XJ5Npsq3FyYBA5cC3Xdt51WhW8GYWd/qs7O9G5mC/IVyecyN9iGWFR
         73QN4qpIWu48fvLfu5dN5EqplTeUxXXHDMXvWrEOBDZRfT2fJwXE+f718Ruua40t0cly
         swDzsFnTRe3Wy1Xh6/iZxrIfldbpKjcnnTYofC9AxYWfmUtXEMpXwp2Ho99BTNyaVn2d
         0Fxw==
X-Forwarded-Encrypted: i=1; AFNElJ/emea9OANUhKqpu4aUyr/KZrcYkQHoIGKoVXykcdP3xBi/GZaHfQRonGUJS7MkOJzlA6zldQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YysTIyKpMKF1TinPw3pusNquX3OM5TvnbG1T4qRT9pSsdOXFpOk
	iCWMJsz8+bGzeIM/ufgfu9felH8DVracmB1t1ah/kh11UPGccqX7UVmHk4uQidjmXh4afkiqIFF
	G0y/e250xW/hjqiOzlRobPQuenPSrB6QRF/5s616dC9sWx1eoJYYYmwxr7xjwo/+GLJcy
X-Gm-Gg: AeBDieuiZUFpQrsNAXH2DWBxUGcBW7YmC9cArno9OaQnpZ9ncRZjTdO97RaQNvqm8va
	RAye26eAxuDs6UvvoQq30HjIFGyFTxlvdCwtlTn5Y/uhXemGXM0a7IKrkQ6LZiua7mso7Uh+Ji6
	sY5C+16nzkaU32p/ricSOPhYAlHy0mVLGbzSt0jhlUqKTcAn19lXp+J1GAziluxuOzMXBc+2XRE
	GjozJ6CsJeVUH/g8XNIvQZhxKKPp9pFD3+1GZJ1yd7INH5SJlJ4RxYIElc3hlX41eBqCcdBlUwB
	vTB4jgMkyWrMeYFwsCVKKHek/hxPia7qAmtROku3BQWsYN2BhmYePhAxgSlZGxlWZMsuiFjFMEN
	3yXmVbeE4/WuC714PGx0hTP5xpbEIVxzLN76Rx/JXB3AeNMOsXcoqJlZfZZ0EUOxxgFfOXdHSk1
	g=
X-Received: by 2002:a05:7022:4186:b0:12c:3d1c:b325 with SMTP id a92af1059eb24-12c73b2bd66mr3631741c88.14.1776592337884;
        Sun, 19 Apr 2026 02:52:17 -0700 (PDT)
X-Received: by 2002:a05:7022:4186:b0:12c:3d1c:b325 with SMTP id a92af1059eb24-12c73b2bd66mr3631727c88.14.1776592337343;
        Sun, 19 Apr 2026 02:52:17 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cfd3esm9308003eec.21.2026.04.19.02.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 02:52:17 -0700 (PDT)
Date: Sun, 19 Apr 2026 17:52:11 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: bibek.patro@oss.qualcomm.com
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Dmitry Baryshkov <lumag@kernel.org>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, srinivas.kandagatla@oss.qualcomm.com
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Fix fastrpc compatible string in
 ACTLR client match table
Message-ID: <aeSly0N7IkXHYExB@QCOM-aGQu4IUr3Y>
References: <20260408130825.3268733-1-bibek.patro@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408130825.3268733-1-bibek.patro@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDEwMiBTYWx0ZWRfX/9waf9m6Q6vA
 FWg1hrjFszqUyhM6tZGhb/rsHdmf1Qm1a+4NKwQCg2vmkxcS1Hijq4h8nv3y5A+Xbp3y7kGjTlI
 YDnacvm0PnEUVT2bqXxSupj8iqx02eNmsWxfpiwoKV9hr1Q38X1M+16ltw2Nrunxr3gYRdtvLwS
 E0wfyPn8nlKja5DF17YuBth/G1lULwHdUATKiV3g9GzTbIzLnFN0qLNAOmaRHSffhOoDbbCMGhm
 UoO1IHJuBPLJBe8WROBaMVvU3FiC1Y8K2fCJlfvmr+iPAwIakcQzYRr5th7eIPEAeWCFKS5D0bE
 E/PYzY44C8fK3I9gfRD/rMb9fVVrjBoORCc3/XAkYIKYQmFc+e8dPL8x6Lluzso70oSERylPlfc
 JDJZsPMoKTZyD50KGHZcwPGNvn9QKV/XVdXmemx8+rq/YoxMxwU46JkVSn8PFS7QOvEuhCnmp7Q
 oWH/AuBNY4rcwbxjufw==
X-Authority-Analysis: v=2.4 cv=G9Ys1dk5 c=1 sm=1 tr=0 ts=69e4a5d2 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=R4lqVJv_ZxSicD1_n0oA:9 a=CjuIK1q_8ugA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: hG_Qv4LFeHkrfxM4hEZvvUGyUu0ZQh8I
X-Proofpoint-GUID: hG_Qv4LFeHkrfxM4hEZvvUGyUu0ZQh8I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_03,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190102

On Wed, Apr 08, 2026 at 06:38:25PM +0530, bibek.patro@oss.qualcomm.com wrote:
> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
...
> Assisted-by: Anthropic:claude-4-6-sonnet

Nit - coding-assistants.rst suggests format:

  Assisted-by: AGENT_NAME:MODEL_VERSION

So I guess this might be better?

  Assisted-by: Claude:claude-4-6-sonnet

Shawn

> Fixes: 3e35c3e725de ("iommu/arm-smmu: Add ACTLR data and support for qcom_smmu_500")
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
