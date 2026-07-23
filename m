Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606A938BF67
	for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825396; cv=none; b=qk1+pkL0KUWo6GoeP1fF2hy4zA72+awT/KTShVVYvxPL3ppK/oaiq9raDexwBUgz9yMM4HVL5qpiQFwXMSsTpYD4j3VPcUzBQnYQJv9uYDBFFogFYsiZC/CadygkSYZWlNzj49B/WCVgO92UBnE3Mt3XMHkPVYaDFx7JU+ZNchI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825396; c=relaxed/simple;
	bh=dm3dowMCjPuMdklAeyOb8nCLf360PgurVePeLF/upSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A15SCKT8yL3YHpZsYeIdJlQOOH1rXK5EW96UJcSW4YRThBB6gIJq5155DdO+CglCmwR1vrViEROnVrSgXeu5haVaOxQWMM7d7ZeQGm+VM8vSqUOGal5bmORXVPNC+4s/klOU8z3odnib3b6i+uJ8C7e6h6I+X1P20Xx5akhEZL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JCY6Gehn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c6SiqeHi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JCY6Gehn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c6SiqeHi"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NCvtB4021495
	for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 16:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dPfm6ZP6GvJfr7jNxJpE88Hh
	K0+SBhZcSJwa9rTdVGA=; b=JCY6Gehn1s6VDwQyUPrbRQjtVt+HPz6AMqOs1jVf
	2imCrGJu0j6aqVwdNoJdNU0ZM9PPTtSpTCWHTp4hFj6HXXZ7h4wwwSJBejp2T94r
	zC4YWCFfEgOevCrbbtk0wKQGMi2evvv+gySqiZUr85/la+lU8SwzSbyJbCmfnZZg
	29rmCQgaFyFXSaP2k3ZT1+AUzdfqHNiFcumDZ9qTiqdB71rbSljhjqjSgNIFq12h
	w/PNg4NxO3yNAZoEtHEWW8FDW6svpWeM7XvXYi2y47qhBOjLzNSc9ostIUJvtEn0
	uKVBsH88XrKFZbh39okAy+NdnBB12Qz9uNXu5gU9uzg6Ww==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk6c7m8k7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 16:49:53 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cab048cdb3eso1172509a12.0
        for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784825393; x=1785430193; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dPfm6ZP6GvJfr7jNxJpE88HhK0+SBhZcSJwa9rTdVGA=;
        b=c6SiqeHiGbNHs6+E2NPQlBlD/X+jppnE/OmN3d26BwB7MHPdDw1OfACgduaRTAO+38
         K2kOHOyYk4an5ku6SLamvFKEqXFLKzkEJ8HhDUEJv6+InioS1U/LO/6OKrMhGe/4Ao5N
         iRz1Pt768/hAjlUK/eRjWABx65I3PU4YQ1QPcNWIk1PSySv8WsjS7FpLH585Td0JIFyO
         T9QIiFs8NzkdmGj1jPl1H4fmu3/naaxdQ6XiUcnHomcrj33zQAfWnxsv29BvdizE/nGy
         mZrPF0EMUthv+Iu3pUcJrebkndfoUbxQZvPJ6z7QohqXR/F2uVik/3I29EzrXh3xKHP/
         mhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784825393; x=1785430193;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dPfm6ZP6GvJfr7jNxJpE88HhK0+SBhZcSJwa9rTdVGA=;
        b=dSnyH7ge51mVe/bACKlW2GdVo5oddNr3sxRrTESdHNLAkIUMH1H9JaZUHnATNuRy07
         eGWRcVU1dTvMiQvEN+gdyivWRe4We3xJ+06nMgtKHh6F7TGkgp25uhQrE1ztbV0Xkh6/
         Oo+pFZ4XntuqHcq3YYlT0u95tuCHgbZnk6fpM7YRMg090+Qbq/ca6iEVhdkKf0OJr2GQ
         ci8SfaHGKenM1ukbBQz+hAl361TWnE0sjboJAJMSdRNxUXDv+yl8OjUVhA1WWS0XCzGm
         JTGpt4pk87ZFfjcLU+vKyKr8EPDEEVVjbcDU2Fo9DPpZoCFaMBG3n+vNaZ3dGjomXTdT
         Pz1w==
X-Forwarded-Encrypted: i=1; AHgh+RpRyfzvuHuqC7OeBRy22VP9V9DvVo0UqSL0z7yHhgW2476lBQVqVtZOuhnVcJOiGh6+YbTI7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgWxX17B8FVYyy8AE+WWy/ZjEgfruGgPZqNMYIe8DY8gjYuDNr
	nPOPGW2oOlY/cq2eGfO5mcwVaJJZ5KotfXrnKNYawATBdtVaYWkFR3m4vNGU+NqbMKabuv5Y9dC
	CSJ68V95427s2+3VEHLmDjd06Tx/YiYyYf4i05GgOiMYg6MVHfcwlzWgFOg==
X-Gm-Gg: AR+sD12xw1LV6rydsVljjTEapCGhhULj289RMqNQU1ZXadTGnbIhhyulGf/k+Fl9Mjm
	4sAGu/YDg8bLpFMb+tcxpoAZNifs6fwzyIFFShnPQWkHRL1nrOSZgir5iiOXMuyR7w/5bogBmFd
	sWyHaS8V7rqzrUdRFxDG9sKszLFtjp1StViR4/IlZsYUDf6tOsOBd5WUdrahwwe0Y/bKhFMGso/
	YEatW4Q2Zy/sbt+Lp17RtkDAR9M0E0fqe9HyMeAumZmkwpJnTI/kLaOBGTZT0kGdixFCxjL84l6
	h0qk2RF+xPTyBnyd3vGRxyHo2hC881myDgXmmixTSmkaIpki+vHv+lBL1m65JD4es0x0yHiX8dd
	uWJu+iGgvoc7jTkmIT/wFG4mTGbI=
X-Received: by 2002:a05:6a21:1fc5:b0:3c3:8222:b8c9 with SMTP id adf61e73a8af0-3c44b2740b9mr4729563637.67.1784825392848;
        Thu, 23 Jul 2026 09:49:52 -0700 (PDT)
X-Received: by 2002:a05:6a21:1fc5:b0:3c3:8222:b8c9 with SMTP id adf61e73a8af0-3c44b2740b9mr4729510637.67.1784825392260;
        Thu, 23 Jul 2026 09:49:52 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130a87e9sm16413540c88.11.2026.07.23.09.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 09:49:51 -0700 (PDT)
Date: Thu, 23 Jul 2026 22:19:44 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>
Cc: Weimin Xiong <xiongwm2026@163.com>, catalin.marinas@arm.com,
        kernel-team@android.com, robin.clark@oss.qualcomm.com, joro@8bytes.org,
        robin.murphy@arm.com, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] iommu/msm: Fix dangling list entry on probe failure
Message-ID: <20260723164944.hglmw7kgbikfgtcx@hu-mojha-hyd.qualcomm.com>
References: <20260716013229.91014-1-xiongwm2026@163.com>
 <20260716085313.207069-1-xiongwm2026@163.com>
 <178472575580.2876636.12194314237571577379.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178472575580.2876636.12194314237571577379.b4-ty@kernel.org>
X-Proofpoint-GUID: emjPoxfK2kFp-qNI0AN_6DFfUs_UTBVa
X-Proofpoint-ORIG-GUID: emjPoxfK2kFp-qNI0AN_6DFfUs_UTBVa
X-Authority-Analysis: v=2.4 cv=baZbluPB c=1 sm=1 tr=0 ts=6a624631 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=mXi61DHN7hnhVxcJtqAA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE2NSBTYWx0ZWRfX3N6EZuHepJ0i
 l1mzVOK849BTk8+/jQ/1V1EHIvwKoiwMNCL3zTOUl3ig2rI3eOVl8pwFbY4QcdUUNg/s53BlgrT
 dCmY8dhjza2BlaGc02r8OY7P+bQjLAQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE2NSBTYWx0ZWRfX0GiQZhVZ8MNg
 n6Z+mw/U/Yqj/sYu8DgmB2BAANlwU2XiKnVWDxUgY1JHeYFdWhDN23kFtwiF/hvJuwdbJhFGDH7
 kXm/5/Cbnu17ghEmAvRPP+SUrYpPl8oouD1C19SIJZfrdJt/90ITCabCY8tXfTWepzhvz5zdbXL
 jxbh4KGVVg0jY6kFFlCqBaQP4VhLMp4Fdz0yJATkxVHYYW0ZYplmnOstaDqW41b6mBPXVnbV16/
 B9aaarxrCoWK51N+OQNb49Gfuh0SKvyesUx5cJqn+4WkwfiNP2bO0Md2Q201UvUs9nyUhyW9bVj
 1Syx8CiXLBJb7anTd7bKYF+NkzzRUf+XzgEC9Bmobeg60422Kci9lQruFWn5UX2LPsesylvRcbw
 Z+b9aEUoxJ+WPfLaZUQwxdlHqFqjvTcWgX1yd1W7Ht4VUURYnofiJsShOh8FCH87OKGG36K+IfK
 7gWZnxCXUGQouV7epZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230165

On Wed, Jul 22, 2026 at 10:39:34PM +0100, Will Deacon wrote:
> On Thu, 16 Jul 2026 16:53:12 +0800, Weimin Xiong wrote:
> > Move the list_add() call to the end of msm_iommu_probe() instead of
> > adding cleanup paths, which avoids the dangling list entry problem
> > entirely (suggested by Mukesh Ojha).
> > 
> > This approach simplifies the code by ensuring the iommu device is
> > never added to the global list until after all potential failure
> > points have passed.
> > 
> > [...]
> 
> Applied to iommu (qualcomm/msm), thanks!
> 
> [1/1] iommu/msm: Fix dangling list entry on probe failure
>       https://git.kernel.org/iommu/c/6bea37b176b8

Will,

By mistake you have taken the wrong one; it should be v2, not v3 that
should be picked. Sorry for the confusion.

-- 
-Mukesh Ojha
