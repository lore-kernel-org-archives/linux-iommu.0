Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3B93B2FC2
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486487; cv=none; b=rp508ar3fDZ1Axj0FgcoGA4qFGUKcQEbpmOiPr++D1MUzDzc8ay42R587fSHcLJJQ7Zk24FFVbo8GM2E/eTSEYdkjJUMnguoAgMwi/PGa96tKYqk5c1pOlToTrHapcVJAeQsfcx2s5S7ZmLigWnpw8iAFwrWbRFAKdGhNR2lmyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486487; c=relaxed/simple;
	bh=9At6bN/HQOqxg3TZidbgne5rrgZKG4x7j0HUT9ppzqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoWN4XJAe6bnBXYZTFUYd1z0PhBo3f6vyuso5JKjEgUK2DboS2lLJGxcj3XxtSkjfaO3UEU8oNgMlUg2WDgPQGCUWzgtu091gu4wvCBx3Q7g4MW7v78lnKgnXvB6L1GRUklXcCJgiG4a8snUtaaHIinJ80HReYsE+jdkePo6lso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NHGqlV7b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZZaXTCDS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NHGqlV7b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZZaXTCDS"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B7AEBw1258762
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 08:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wTnLLM3bNR0ig+1jIwsqUgQH
	Tql4t8I0K2Rs/RNYSTs=; b=NHGqlV7bdneSmgiHoUkYtNdrrfJhGYPO8Kc7tJyE
	t60BBdC1OACJgYvTOx5bMS+2QeQeKOYU0uiFq8Mt5gQrYVM89GJEfsREC/yrvanT
	kwomtX4dDcMzwFIqjP6hevdd2PW6DsA4L45bporqi9lo6kj5GuRz/b4n4G7kDYkB
	s3mEFUpz+jRl+nhIJmGwp1Zkt5nbTYsaa9Wtp3dnT9/qsRQAvpGArbWwB89y3t72
	1C8kB6IccymXwRFrAKaUprYHtd4fHbhHarrvoOvdJJPFEhcLRvyOeYzpH/Ss0zZx
	JCGRJiLjskLNChBK87AL5TEgiyMox+wLaC3i+IlK7lZYIg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3ag205nv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 08:01:15 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ba86e35aa1so60971995ad.1
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 01:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778486475; x=1779091275; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wTnLLM3bNR0ig+1jIwsqUgQHTql4t8I0K2Rs/RNYSTs=;
        b=ZZaXTCDSEboSz4ItxHD/ywyzdaZushdsnGVc9O/ur4rDxyoLtBF26emcJUFIC57+Im
         cI+EAUgv3JVtEhi+UJN2HASFvWDWS0VCT1HUFWX90aNHLOH011iNPPBEba1SadE2yXt9
         YlRPkkT5JocvkKknrefkOVJYXoLDsjplBi5b/gVYlQzJBSyyvLSaSK0pQHtvEv1369aB
         KcHXsKJgtqprAlR7bOK105LPuCRzgLQzrZBFkGFwdQlw3Bv+39qET1sTW8UqJmALD0cf
         upA4siETB9V8/aeDj1hX2AllicmxtDuEY3tNfKsYv72FlDYzn8Mkvd/FA+zkGTxVNf8o
         pS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778486475; x=1779091275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTnLLM3bNR0ig+1jIwsqUgQHTql4t8I0K2Rs/RNYSTs=;
        b=jCEGwj0BXx8fci2ZesqM+9W7LPVJ7nM9Vx5tseMR5+1dOMoKl9IDFm2a9cBJfZK4Qf
         9Tkh4tU8x7UplfwrF4e3T5lxSrKCUfHR9eGJDoDAL8WD7rpG6OtcGastAe7jiYZATEHE
         kUni9LaDvrA8I4A9uXYBkDLbi9FKMszm5D5Q68AuBhKg+QjnwS4dazHtnwWmj/KUJbtM
         LxdmBdBTYddkidY5hMo+N5MWnF1pBFG8v1H1pxhWUDe2u3sSODMgNe0OxJ5nxtCznn4Y
         ICYQfGqf8OInJwgu+b/y33IFkWdl9whIr8KEo+skt1KrDWS1DUbpuUX2Rd9R+MmPIQ4+
         9ZNA==
X-Forwarded-Encrypted: i=1; AFNElJ9SnhRZaEKbBL1ZoqEnpaIhVOjlhv3JGWqw3Y8z9TXTUnLdguviliGBTMebvD1duzUT8H26lw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrCWTIUuUcH0pazpURaAI0QYzmFVI/7sX8CVHdswYoOCMx6a6u
	MpYrGjeGfdaL0Y6Jkpa03zXLQ7z/sQkfuU0FB7EQE2PgJkrDhxgJGSiTXkUv6siT6WbiK2vrMlO
	cYEbMRisdvx5cQTNwewtSiOs0Nmqj5Ykjtm21PgOtx1GO6frEc+HwFril0g==
X-Gm-Gg: Acq92OHc8M9pOb5Tgy1gxQzQ2aGsIMh3YfSvzmZExrmfqe7iJOPY3ic1dVqrLANfXLs
	V7+nTTlg8t0IYlkY/BqCXJNcqiaC9YoNsZzBu21UPumD6i7mrG11Yqyw9O66aAjForiWenW7/a9
	kPXTPvk7dzoNtG2T1xzKIfRir+SLvKf1b4nYaHnQNFt/Z0BWqJybPzJdoupSvOArusX9UuCVIs9
	FDat5AVnuezvVKz6n78kgboVwwhZ42Hsx0sPf+ikKmFrjEDsD3ngGgSrNe1btzErtFy/3Jp7MNo
	hXq6D+r3fzb19mjfmWQhFaLecrIFofJW7z/2u1hoUWbEJ9Kvvgh25a29cTR5hrCVeEWQywyabUn
	QjadDzqK3sW2zoF0ft8lujuyU1zilYPQsRKhpVUMN1zNqLBQS
X-Received: by 2002:a17:903:1ad0:b0:2b0:6e60:9586 with SMTP id d9443c01a7336-2ba792a0c08mr261081815ad.17.1778486474725;
        Mon, 11 May 2026 01:01:14 -0700 (PDT)
X-Received: by 2002:a17:903:1ad0:b0:2b0:6e60:9586 with SMTP id d9443c01a7336-2ba792a0c08mr261081065ad.17.1778486473994;
        Mon, 11 May 2026 01:01:13 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e374besm98532815ad.47.2026.05.11.01.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:01:13 -0700 (PDT)
Date: Mon, 11 May 2026 13:31:04 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 07/14] media: iris: Enable Secure PAS support with
 IOMMU managed by Linux
Message-ID: <20260511080104.c4nhhmm2xgzm67fi@hu-mojha-hyd.qualcomm.com>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-7-7fbb340c5dbd@oss.qualcomm.com>
 <elhlmmmisecn7vylpsboiicn7dn4umrggktabyixthmevdv7eo@a4keayee2um7>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <elhlmmmisecn7vylpsboiicn7dn4umrggktabyixthmevdv7eo@a4keayee2um7>
X-Proofpoint-ORIG-GUID: xkq0YDe0g4A3g52ZPkV-LP0lpM_a7hie
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA4NyBTYWx0ZWRfX9bqGk7/49pD5
 2rlFT8cL0byvSpxFS2Rs/iwhyrRgyFx1HwxYdpCuEv1mWNH37aAWrv1T1hPkyvNh9NA1lBegep6
 g/63C3EukudxJL+GQV226ybArt2PLdgJpFNf1AcPSDJIQym1F/u4+OwuFp01WHAFwc0I0Mz4zXA
 ymYfyLtNdNSzoBDesyMsvZKKC1GUJkzHgP0TGR542SpyJTnKEvf0zeY7iX3sKaqEwJgU0qu1CA0
 +gcfAVcYoGK+Gj6A1apopHwD8fA5gMri5pnBaFjZm2f58+iCl5VYhPwI1kbFzMVX24QNl7Hzc3Q
 L4vwAK4rS7ncK7PheVUJlKegjTM6Vi9C+oDhfJr11JOra+XTf+m3qoZsreToJXA8qDaVdP0UYde
 mz2nhzb8HlFPCMI2KKMmLB59TiCsz6hK/ql7GIQAlyyoHXSxF6fuYwb3ELovgYD2muR9qypYUz+
 xPqClMPqI6pKPISpMsg==
X-Proofpoint-GUID: xkq0YDe0g4A3g52ZPkV-LP0lpM_a7hie
X-Authority-Analysis: v=2.4 cv=NODlPU6g c=1 sm=1 tr=0 ts=6a018ccb cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DTHjRCbF17pgsZGT9MoA:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110087

On Fri, May 08, 2026 at 11:20:06PM +0300, Dmitry Baryshkov wrote:
> On Sat, May 09, 2026 at 12:29:56AM +0530, Vishnu Reddy wrote:
> > From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > 
> > Most Qualcomm platforms feature a proprietary hypervisor (such as Gunyah
> > or QHEE), which typically handles IOMMU configuration. This includes
> > mapping memory regions and device memory resources for remote processors
> > by intercepting qcom_scm_pas_auth_and_reset() calls. These mappings are
> 
> No the calls to those functions are not intercepted. Doesn't hypervisor
> simply implement the SCM calls?

All the SMC calls are intercepted whenever Gunyah or QHEE hypervisor is present
and in most of the case the preparational work for the TZ like in case of
qcom_scm_pas_auth_and_reset() it does create/register SHMbridge over PIL memory
so that the TZ can access the memory and then calls same SMC call to TZ for
authentication and once done it comes back does mapping the PIL region
and call bring up sequence of the co-processor.

    SMC  SHM setup    SMC (auth)        map memory/resource and trigger reset sequence
HLOS ==> Gunyah(QHEE)   ==> TZ    ==>    Gunyah(QHEE)        === ==>      IRIS 


> 
> > later removed during teardown. Additionally, SHM bridge setup is required
> > to enable memory protection for both remoteproc metadata and its memory
> > regions.
> > 
> > When the hypervisor is absent, the operating system must perform these
> > configurations instead.
> > 
> > Support for handling IOMMU and SHM setup in the absence of a hypervisor
> > is now in place. Extend the Iris driver to enable this functionality on
> > platforms where IOMMU is managed by Linux (i.e., non-Gunyah, non-QHEE).
> 
> I fail to identify, which changes correspond to this description. If
> it's about the PAS context creation, could you please be more specific?

I think, commit text is trying to tell the Infra to support any Secure PIL when IOMMU is
managed by Linux at EL2 and the dependency related to SHM set up in Linux are done as
part of [1] are in upstream.

[1]
https://lore.kernel.org/lkml/20260105-kvmrprocv10-v10-0-022e96815380@oss.qualcomm.com/

> 
> > 
> > Additionally, the Iris driver must map the firmware and its required
> > resources to the firmware SID, which is now specified via iommu-map in
> > the device tree.
> 
> Why? You miss the most important part here.

Sorry, I did not get.. are you looking for explaination here, why via iommu-map in
commit text ?

> 
> > 
> > Reviewed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > Co-developed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > ---
> >  drivers/media/platform/qcom/iris/iris_core.h     |  4 ++
> >  drivers/media/platform/qcom/iris/iris_firmware.c | 72 ++++++++++++++++++++----
> >  2 files changed, 66 insertions(+), 10 deletions(-)
> > 
> 
> -- 
> With best wishes
> Dmitry

-- 
-Mukesh Ojha
