Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5E023FC41
	for <iommu@lists.linux.dev>; Sun, 12 Oct 2025 22:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760309285; cv=none; b=YrarvtVqlUDgeQWI+Q4A+6rEjlTFriea/2SOJ0Fg0r9tCVKJ3c+gcwRBJ0HwqF7d0mdLt1bxiHEKRr0U/91Ibfgp5fICpjX+IqvMwQgkYP7V70grRAH8BRyzuf/I6dDSfhEDun9lPHEuQqQj9nN3wBYpZ06nUuxGA+W8qWQYyxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760309285; c=relaxed/simple;
	bh=7YIsxHbsYDS2Sk/FTdI+x+Y7REmzyOChbYzg5mWOODA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6S1SN1W9+thF2ajz3nY37bnJAqsWKCNjVJfCaHZA5NS8625A3kwy6j9KxON/oyGKu7SalA4Iatp4lCGank4fflH9GH8/xXSghqlhstZzSNlS28Dg/uKHco7QibG2PPPezWXiTGL2bui+RI+xw0cnqh1i87w+AQuNgQGVdqrm5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CmG4xQ/V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CmG4xQ/V"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59CLe1gR014309
	for <iommu@lists.linux.dev>; Sun, 12 Oct 2025 22:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Y11DKgD333T1qsM6ehnOP1sp
	qKRvk3U3pw5ASKcgB/M=; b=CmG4xQ/VxHwIeohXzn3BoaCMI1GOvNDwrwnhQUwy
	V5xbVeGpXJhRXw57CYmz56+ybhloINjCXEQeJdP9XClm2+rh31Vckxr2vDVrHopp
	ZxWWO9IcTgnHmIt37AOuqfGH5I0AUq4vPbRgp0zJ4xnThP25n3nO/Kutf6fqmiIZ
	r+hUB/iIP4xLEUL9TbAIwDCjxHqFolXoQzWJXXCfeN2lI/V20XjEuas9ttYTuS8L
	fyoLoMIIGFf64ydA00XraeR34dfCmrFslI5YOQdJTG6yNS5I6RrZMF3ykA4fFgFD
	8RD+wqN/mIgJFrYWenZZBNlSqS6/pquNBuO6BfIpm1KVbw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff0jmk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 12 Oct 2025 22:48:02 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8635d475527so2689998385a.0
        for <iommu@lists.linux.dev>; Sun, 12 Oct 2025 15:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760309281; x=1760914081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y11DKgD333T1qsM6ehnOP1spqKRvk3U3pw5ASKcgB/M=;
        b=vXHt+cqswWYnQAGw3dfduDY4jZnf/CUK0snJgz7vvfx+3pS2uGY2XnW+JOVMBKfo/T
         EU7C/ejiTjWIH30k+8Kv3MUhYxHg4H3bJANCac0KgwX8VDfdWz4tr+/4DO7YctBceW8H
         gfaCDqehn53PAUjC751+rKU2rIT9YP6CXRlHnOPPztypiCPiCsJTYAlLnShGjy8nj2oH
         68QMEEqasReczgACOBdAuB+ca8uYF2fMLn4kTVvtsVsNIhdMZZyXagT34RyRjm/pW4Eg
         qLmoC4cEDsUB809y+S8GuZQv0kVsjlMl07qkw8dz0U9XSxlsTKfP525gPR86s5pOyAm/
         0EdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh5UXc/xvkWaujHNuPddZkQ2XF21ZBH3XvJM7GcLukAA9rRe2r803otZC+4mRHT3c/FrD2Pw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqeCNAuHbXJNsTBknEjGeY48VlengtDg0Xf1yXHxSKA2/qLRdF
	jVFpmjOrc/vixnMXYnyd0ucQ2i+C3AhdFuy5zpSZaxEdlGlo9ShxKrwJ5/WuE4ek42Pft5nSX6B
	DqWJst/IrpSD767zP0DG3rKy6BlcVsnV3YkuYB/mXXwtZZ3AwwQgCdcn9mQ==
X-Gm-Gg: ASbGncuwfYPprtFyuZaE5v51pg++061vbnE/LouCOT4i4t/c347SzvLhBCoujV0RXx8
	PpdE2Es40g0uIb816YbtCtzmXcOnvY0Jj6wac3jVNnzb/7CRnUWraBaSPj+stoZriYc0Yz2fm0s
	3ozuB4XPhT8K97ADsBnjmalG8wt/5ErtmB1NF1pGV0zexXh/RAh6JQ8QCfQL40S2ZQgSY+My4GL
	QQ3f7FJi6pT/QxuFxtmKFlanspvOoIZXSsQieMR1D9Iq+u9jdnrL1ZFlhzS8yiIMPmWpdXAhlV0
	5afOZ4UCZzUNXhVdDffJoLa7deC7SBktAYn6P4HCjA/Z5T64CadyLs0rvDSmNBDPjU7u0A+L56H
	QB5z679LYZDYwwL6GtzrNjXGZnPDv3eydX+IyqalJ6G5rKLB/8dc1
X-Received: by 2002:a05:622a:a0e:b0:4d5:d752:74e9 with SMTP id d75a77b69052e-4e6eacb38ffmr301929381cf.4.1760309281335;
        Sun, 12 Oct 2025 15:48:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP1CTT2JKn6MGS4Bea63p6+bXJviKZnZxUnGd24v9XoMzgZrNTfGYWPkogi0Ki6vp16l5r0Q==
X-Received: by 2002:a05:622a:a0e:b0:4d5:d752:74e9 with SMTP id d75a77b69052e-4e6eacb38ffmr301929001cf.4.1760309280744;
        Sun, 12 Oct 2025 15:48:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762eb6aa32sm25334251fa.62.2025.10.12.15.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 15:47:58 -0700 (PDT)
Date: Mon, 13 Oct 2025 01:47:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>
Cc: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
        Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
        saravanak@google.com, conor+dt@kernel.org, robh@kernel.org,
        mchehab@kernel.org, krzk+dt@kernel.org, abhinav.kumar@linux.dev,
        vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        bjorn.andersson@oss.qualcomm.com, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/3] Introduce iommu-map-masked for platform devices
Message-ID: <mtt7x2fqvuotwko6ztczosiep5ofyaupayumyggch6e2piqxmr@4v5tb5u2a5u3>
References: <20250928171718.436440-1-charan.kalla@oss.qualcomm.com>
 <aec0f40a-8346-4194-8b18-1022fe3366bb@arm.com>
 <0d0560cc-9757-4c7b-8de4-170148d99481@oss.qualcomm.com>
 <ead7cf8b-fbc4-4242-a9da-b313dded1abc@arm.com>
 <nzqte4glwtpjs5bhkxz43yhdufelxvqvzmg5tepudxwetimir3@bvlw5csjizsh>
 <9d3eeb9f-b8ea-48e5-a1d9-0865f63ef991@arm.com>
 <fhb4woejzh3r6v5dxvdiopnsbuwstucfuuzbiymxg4wrxrjc7t@dt3z3utq6lwd>
 <0zcQcB2YYWH_ufElq3ptqtLsGDsxvMEAkHCt_jYaSpwV597VFc22pFWzyMz0rSY-DKqWCQgOCiKpsIRNA0Fisw==@protonmail.internalid>
 <c863f6a7-b117-4444-ae6d-1d525b572be2@oss.qualcomm.com>
 <3c1eb276-abde-4af4-ab39-c934c30aa447@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c1eb276-abde-4af4-ab39-c934c30aa447@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX8sRJ/xxZJwzs
 txcH8noBv1kFMIB6UCamdMOsJ0L73HFPKoQHpD4Yh8G5ECRaOwYA0byf/SoqchE4i3r2K0dFRcn
 3ZBBcTC+Yk5YxTDtP7JfgjBXOZJlg3sD4bmOeBtcY9y3v+MW0a+NPrrsUYUTxiCBIiheVuZDdux
 j1vwBEOI6J8dEOYx9IBz5JyjDk5lRkqPwueHMGXFZYfP76Zgh6S/gjjEVuek5QgD/6P8g2UWfq8
 i7F4IcZ/cLjA3XDHx/3Penjz3QGWzzzDx3HXp9OD7OiJvFRRFPakTOrdyf9mSL2Iq5Ac/8Uf8mK
 mltc6FhPvds9VAoe33wY/GNXovJNyUDLHljJAyPAnScWQfS653Tnx/xdRIYFLJha9Z7Bp/lYZOU
 yoKuiI+Quom4Rr+QTSP6mcaUEgd0xg==
X-Proofpoint-GUID: MdK8EfsW0X-KZO2ZPpHYdgF11LCvXTjw
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68ec3022 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=q6wQ8xeR6lWqMPcijXcA:9
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: MdK8EfsW0X-KZO2ZPpHYdgF11LCvXTjw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-12_09,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Sun, Oct 12, 2025 at 09:44:43PM +0100, Bryan O'Donoghue wrote:
> On 10/10/2025 20:53, Charan Teja Kalla wrote:
> > I don't want to dilute what Dmitry is saying here, but the below is what
> > i can make out of Robin comments, please CMIW:
> > 
> > iommu {
> > 	#iommu-cells = <2>;
> > }
> > 
> > video {
> >     iommu = <iommu sid1 mask1>, <iommu sid2 mask2>;
> >     #iommu-map-cells = 2; /* does it look weird to define here, even if
> > it is SMMU property? */
> >     iommu-map = <0 smmu sid3 mask3>,
> > 	       <0 smmu sid4 mask4>;
> > };
> 
> 
> This whole iommu-map thing is a wrong direction, its a workaround.
> 
> It stems from here:
> 
> 1. Vikash posted a series adding a platform device
> https://lore.kernel.org/linux-media/20250627-video_cb-v3-0-51e18c0ffbce@quicinc.com/
> 
>    The two objectives of this are
> 
>    a. Allow Linux, the APPS as qcom calls it,@ EL1 or EL2
>       to setup iommu entries for function_ids that are
>       not the APPS @ EL1/EL2.

No.

Up to now we were talking only about the non-pixel bitstreams and secure
en-/decoding data.  None of that is related to anything except Linux
running in EL1/EL2. Only Linux consumes / provides normal non-pixel
data. Only Linux handles decoded secure buffers. Only Linux sets up the
video decoding of secure data and then blending of that data inside DPU.

>       For example the APPS running in TEE or one of the
>       various co-processors - like say the Compute DSP cDSP.

How did CDSP or TEE get into the picture?

> 
>    b. Allowing for each device to have a full IOVA range.
> 
> 2. Krzysztof queried about changing _existing_ entries e.g.
> https://lore.kernel.org/linux-media/6fd3fa34-69e1-484f-ad6f-8caa852f1a6c@kernel.org/
> 
>    The point about ABI breakage.
> 
> 3. This proposal to introduce iommu-map as a workaround
>    Gets the FUNCTION_ID APPS v cDSP v TZ into the DT

It's neither CDSP nor TZ. The source or the consumer of the data might
be crypto core or just Linux process. For non-secured non-pixel data it
_is_ Linux process.

> 
>    So it solves 1/a I'm not sure it solves 1/b
> 
>    However if you were designing from scratch you wouldn't
>    have a motivation to assign this additional property.
> 
>    The motivation is to not break the ABI I think.
> 
> 4. Robin said
> 
>    "And if you want individual StreamIDs for logical functions to be
>     attachable to distinct contexts then those functions absolutely
>     must be visible to the IOMMU layer and the SMMU driver as
>     independent devices"

Correct. But it doesn't require separate OF device nodes. See
host1x_memory_context_list_init().

> 
> 5. If you think about this, its actually the right long term solution
> 
>    - Individual devices means something like:
> 
>      video-codec@aa00000 {
>          /* Any SID mapping to S1_VIDEO_HLOS belongs here */
>          compatible = "qcom,sm8550-iris";
>          iommus = <&apps_smmu 0x1947 0x0000>;
>      };
> 
>      video-codec-non-pixel {
>          /* Any SID mapping to S1_VIDEO_HLOS_P belongs here */
>          compatible = "qcom,sm8550-iris-non-pixel";
>          iommus = <&apps_smmu 0x1940 0x0000>;
>      };

Which piece of hardware is described by this node? Why is it separate
from the main video-codec? The IOMMU stream doesn't have any specifics,
it's just a part of the video codec core.

> 
>    - Or do something like that above again in platform code.
> 
> 6. We should on introduction of a new SoC
> 
>    - Fix the iommus = <> for "qcom,newsoc-iris" to contain
>      only what is pertinent to S1_VIDEO_HLOS
> 
>    - Make new devices in the DT for each FUNCTION_ID
> 
>    - Then look at how - if - that fix can be brought back to Lemans
> 
> My problem with introducing the iommu-map is that it bakes into the video
> codec definitions a fixup which then gets carried forward.
> 
> But the right thing to do is individual devices so, let's do that and worry
> about how to back-port that fix to older SoCs once done.

-- 
With best wishes
Dmitry
