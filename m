Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613507;
	b=U6MT3Wmxg65u41bM0rgCUFlkFORnET0pX/aNCz26UcuZveMxM49dhUm7HH1dSOETOETd
	 /QeaUFPPNcDCcXYClXpx6AN+d/pkEN72HoZEX7LymNvOLfLHEE6Nn6DxRMmtIvJNmUnQl
	 Iz+LJh981cMM+VNsu5qmZOUH6cXw3I/O8fJbiIwXi0KhuuLnQ9ubBcqovPkNJ/NqXci1+
	 jIMZPKJndpPo0y5+M1wgDMR6QaQCUCPK97oVtFu0tBMsIQwGyj+niGJqVtLCwjo0vcAEb
	 pTKzfdk5njiUYKOhOXR1U+bOcHv1DPt6rviuc/+Ks1ew1V8a9wtWaSKH6ER7LsSWIfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613507;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=xv2AKf702Amb8kE7FInOdGlSjutL7r+KnslMQbW9EJs=;
	b=k+ZfPctbSd2JxwIQ9+6hL6mnG7nGnNWJY76xpIIejYTqLJSC/CKa07Qdqn7Alv2Q1Q5i
	 8XMNHpOh5KFqhGWbPiLY4R4PrKtWvXz7gceHHMRmYWyjdoVVWTHIUI951Kai4HI7f6kgJ
	 8V+zeAq/7JPAteX0oy/wVPuaCBbSQnnPUevbR3L4qmT+b2ixDNSLYqoyisa9fN+tUC0n0
	 GDBO9a463JpwfWy2jB+Jn1E0678fnr4N/07wqSZYyrLWp9r9y6a9LSYg92uRiVH6gbdkD
	 IyRhaDiBPmhlmRTw853TK7UfT5CsfmdGWy5QYFfG+Ci+XX72GBVKEK4YdW0UCCdKRYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=futowQ+d;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FNVj4JVF;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCD9606A329
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 09:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FCD9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=futowQ+d;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FNVj4JVF
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29A6ZP213984
	for <iommu@lists.linux.dev>; Mon, 2 Nov 2026 09:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xv2AKf702Amb8kE7FInOdGlSjutL7r+KnslMQbW9EJs=; b=futowQ+d0AVA1wU7
	Fe1XnXE/6MhUV0vCnUohaHpa4xmem+tbtDGUqss/w8e9mNFe0pfjfGLIzDjRJv7/
	Qi62eDUiaiggCl1vQ5n14Dm5rg2lkf74M5bZnRbMXdwDJd12WDjugSY3430cu7zU
	hfhEsPR6TaZv9HGFuMHH63Cy0wQ+aslg7XXogVCuYQ47ezT7G3/D8qZB2CkMUm2M
	Z/YhAZ7TW95TPXR/cm9jZfjtvHNkDi7dZfw1NUbuVNqOFhZMWT9eOL/2w9N9i2jW
	vlyY77cH9lHj8aKWug1zLLrcLFp1ltLZtpx/te/g7LFq327mChW+XccuC8QwnAHO
	xVCKxw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpmf1s0w8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 02 Nov 2026 09:58:26 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91c7a26f892so32939616d6.0
        for <iommu@lists.linux.dev>; Mon, 02 Nov 2026 01:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793613505; x=1794218305; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xv2AKf702Amb8kE7FInOdGlSjutL7r+KnslMQbW9EJs=;
        b=FNVj4JVF4f0AHnfLFG+AMvivoKFNbu+FafbQr6dNJjmhVaCtRwmUX/cHDYY4XcAR3A
         FrQZpyTDVFzCd22wSk8Mxl3BVsk7Ky+iI+oBTTor09degFFE+0unLJi46N4vKiJADltf
         B97fswRQr6NDoaMFc+4j8a/N0yArynecL1/3u4Jpw/OsxUbBvL4riJEYOANC4dh/zHDm
         s2BrY5YAn8TNLIHPJXZgeCQjCffFvN4sK7657iwaxKmDMk5RKRAqxDGGXS31EXiqUuuY
         uxDsmFXQQySJRqYACbiNrevZOxs45uDdEjnPeqxIQOaWt0mF9cN6O0T/9qfV9Yd54Qoc
         xpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793613505; x=1794218305;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xv2AKf702Amb8kE7FInOdGlSjutL7r+KnslMQbW9EJs=;
        b=AUhUL5VEhvw4Z+KcMcGzgjk3TynSPE9NGKTuxLl/aGvLz02x7pO6V6qYmfPH0PNgYb
         3zT786UN3ghCdG3BIT60NoW85lIsZ4LKbJmsWeaWsDjFItOa7T4x/RSiVqVYVEyDJW8B
         t7f3OY9LgxyrMterohWul+Bcdup/pMEg4Sm5v18IdFyZ50wKV3iLwBUAQcfj4A9UisRz
         BI9fE8Q1CaZCn0RXzFBm8tgemSZTPSH1YOcjolFdD0Mkcmat8NFGD8Y5lN3z0AupoZoO
         e62i/67SKf6DKCtmKiTePYuffps64eipg72A86K52valE+Z/9d5KEFra8NtgxpuiYa0A
         Ktmw==
X-Forwarded-Encrypted: i=1; AKwUvBxvu38G28j19dHNBhb7isC1/JUfFPV3FoXqvX4pWBcSWbga1rAOnknhkj13/zp05psVQx1TcA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/JiPOBCZUsXIuOmC3WDFvhl2Yj/uA46yeJJehjfi5F+JZPeMmb
	3+HNodyH/G71+/iqUzl/ITfYr/HQj81pRFYe5UziCESFnwIRFUf9WoXW/i3q34GGIFgYyJKC0Xf
	ZKL312xwzwJH5kils9PDckoQEZvS5GTtH32pRMEt3YmChigzo87Vjmct04w==
X-Gm-Gg: AYBFou06jJjn3SDVTxUowbKESLxQieb/AvYbQmZ7PnK/VWNyeTp7MTBmvDSZbnmGWq3
	wJVvWWFHZszat8ZZCUc2FUizJknCdxlfblIyjd0Vdvcgp4zhquoTE0GzwPgOYLX0GCKCnsz/UKO
	tT7XHX6M3ZY8/KMvvuXraGx1r/+wEdWToHP6LjLc47xW2+HgXjKL5YL2AdNs+3zHej26j3uvH4F
	hExWnBjgZ1Tq0UC51FYyVkfY1/u7HUsZ77QiSpkdcWFWHH3jfR0JfYK9P4FjsKIoJ620wfhe9bd
	jcfiY9uJsfA8QW/B8sfSrDZdilPNWfyxrWVHZ9oDwjf6DCi2DyGuxO8K0bP9PUQXAiKR8Okljwd
	XZaRwdXgVxGofQhUxAQ3qbhZdTCuDTxsQoJCs4nS/wS7qFqyRldO8uKu5looQ/3RRxxltSlzn0T
	TcsteVhtANSSffIWwHDHdtrQQcOaasGymi12xc4MBCnXJwj5oA3vkR13tgwqnU
X-Received: by 2002:a05:6214:3909:b0:91b:5d3b:4aca with SMTP id 6a1803df08f44-91ca4b980d0mr164013216d6.51.1793613505263;
        Mon, 02 Nov 2026 01:58:25 -0800 (PST)
X-Received: by 2002:a05:6214:3909:b0:91b:5d3b:4aca with SMTP id 6a1803df08f44-91ca4b980d0mr164013006d6.51.1793613504569;
        Mon, 02 Nov 2026 01:58:24 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3acbbedf87dsm19739631fa.17.2026.11.02.01.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 01:58:22 -0800 (PST)
Date: Mon, 2 Nov 2026 11:58:20 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iommu: qcom: Fix the MSM GPU and display with
 DMA-address based mappings
Message-ID: <vfpvxwe54n66qmdy5f6hopfo5szlwrl4gcu667mplv2eplu3br@aqpupbzslcgi>
References: <20261031-msm-smmu-identity-v1-0-a2a70580eebd@oss.qualcomm.com>
 <CACSVV02xa+emUMd7Dp1rDSwa0e3wpyQBcPeZg-bXPL4U3kzQvg@mail.gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV02xa+emUMd7Dp1rDSwa0e3wpyQBcPeZg-bXPL4U3kzQvg@mail.gmail.com>
X-Proofpoint-ORIG-GUID: cuJSUGMj5uKxGnHPCo7qfWUbq4MnJ5hI
X-Authority-Analysis: v=2.4 cv=bNaDs/+Z c=1 sm=1 tr=0 ts=6ae85ec2 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=wZccLAYvN7ng3IXnx9gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzOSBTYWx0ZWRfXyHO6bVwes8Nd
 C94uxRBKhX7gkQz5vu7vXtRGGoXKRWsJylaW6wKEY32lbaBrskh3uA09wycroR7zr8ru3CbYLAL
 n9xh4CHXnepdybQJ4TOX80k0pL/Ie0m9acZm9LpkihME4ctj+9xpGtYsjUHMnNoe0MoWOQb2jpd
 LN75uDzZtnTkKZJ0PgP/Zg/QSZMRIcVDph/1Z4ieab+WKAwsLl4BwbaTdIqGjwgTPbZP42KvKtb
 hFu5cs//MhIb1BtBAakCAkU9uyj+U1HvGyokRsrJMkIO/RGxVdIgBm0kwvmvyTiwp5NPYaDfemb
 JD+Hp40jGQF5sGUUu0OhyIUGgPwtxrNDyCAjkgglx+aHVriJ+Pcjey+VFLKpNmUyR/xCDGTDQry
 3lVh7ajESYV4v3eCSDJ+1+NJQ6TvOsH7jDsYjAjZr49GP732H5bX6YXkCrxl3idUIuFECC1zYbP
 jymzJDGhI5D+kqM6ImQ==
X-Proofpoint-GUID: cuJSUGMj5uKxGnHPCo7qfWUbq4MnJ5hI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzOSBTYWx0ZWRfX9i/4TIKg4DVE
 EE/FP6+Rpq3vrg/Vpcv2LhEOMCbefNT8y41o2uXy2vpdqcqwUKzPZSTacyztYjtCcAHkUfbnjqM
 3KRUZGS7QdZKvlefBGMUfmP2u4oW/68=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020039

On Sat, Oct 31, 2026 at 08:33:06AM -0700, Rob Clark wrote:
> On Fri, Oct 30, 2026 at 3:05 PM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > Rob's drm/msm series [1] writes the addresses dma_map_sgtable() returns
> > for the DRM device into the GPU and display page tables, so they have to
> > be physical addresses, i.e. the device must not use iommu-dma. On DPU
> > platforms that holds, the DRM device has no iommus of its own. On MDP5
> > platforms it is the MDP5 device, which ends up with iommu-dma: the GPU
> > then fails to start on db410c and sda660 and resets db820c. The last
> > two patches give it an identity default domain in qcom_iommu and
> > arm-smmu-qcom.
> >
> > The first patch fixes qcom_iommu's flush_iotlb_all, which never
> > invalidated the TLB. Nothing relies on it today, but the series above
> > does, hence no Fixes tag.
> >
> > The patches are independent of [1] and a no-op for the current drm/msm,
> > but have to land before it. Tested on top of [1] on db410c, db820c and
> > IFC6560 with and without these patches, and on Open-Q 835 (DPU) as a
> > control.
> 
> Thanks, this should mostly supersede my untested series[1], but I
> think msm_iommu.c still needs the same treatment?  Hopefully just the
> def_domain_type() part?

The msm_iommu.c needed more fixes. I will refresh my old series and
include fixes necessary for the dmabuf debug to work.

-- 
With best wishes
Dmitry
