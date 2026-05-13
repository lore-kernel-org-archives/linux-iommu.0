Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD36C3AA4FA
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778699371; cv=none; b=QlkMveAUgwLKlQjlec9rRLFP+CnYhMulHVJBzF0GB+HyziCfQOLIbIN/fmKONi2af3yqqSrXE6ix2zAYDpN2SMqF/5goxWHim8Asls4lSmsYN6HuDf54JL/Kpby8OQPQtP0Au4ii4TP87dCjdfoIvlbDPuNa9+Vml9c6vmFJ7O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778699371; c=relaxed/simple;
	bh=TLEgs2j+NLTxvHfvADiUHg4zWka2Qm9LSD4iAcUsgVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtKZeeFX93w5l4rpXVbkaAJEKfObV2Sdw9S8BvSUNq4SxCT+1hobVozJAMbizimJWIMcboi7Vxo9mtJgKI2ZL30+VuLYmlaGCKf9eLzEGEnRuBIXk8zYkTEf4D1duR1oDtvjjO4iWxwwcRkxp3+yigWxkiMyXe1p6SgWtjgRhx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QISSdNBo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ej6bqH5k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QISSdNBo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ej6bqH5k"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DCRO7p2965200
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 19:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FQL5G0XdY34vSKAuhLaAvXdh
	NyGZknux7fG6J+8FZ4M=; b=QISSdNBoMhsdNEDhKG623GlSz8f8eJdoFv7deP9M
	g0qUPxfy2J0RHRgs1hXpAQ6TumnzbsEy06AJrv7s142cS+29QjG/y2tJKdh19+lQ
	O7izoHXAKb5NsPe1Oa8gh5AsSXKh/gk+/h37MfHtMgkhO9Hx36PlUP0wBFIO9ufK
	DHmyFUcDYdKqT9tAkia4K1RrXZg+xQ1SBYGpJLa3Rcgvt8i/+Tl3jiBQyNLYmLch
	ZwYwsLSXZqAJzsMunEIZUrDLirnrBu8K7J18h5pNt9aAGRqlDAM5mqjrrGtzihVX
	MWAmzTigDvB4/8Sbi45+vkLWs/aTaS5QNraUSA6SIPHhTQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4ma5b12k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 19:09:28 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-514551d5f2aso197640081cf.2
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 12:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778699368; x=1779304168; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FQL5G0XdY34vSKAuhLaAvXdhNyGZknux7fG6J+8FZ4M=;
        b=Ej6bqH5k29dnpdJ8Ie8q1xn0n5qHKn+k+62grr2jmnEoAohlavIFP82ZHBFAZ5M4dx
         j7MI3vjMbmeO9yTi1HU4qe1rdulZUVrxYBjBcox/JowhAESwyb6a3pnrRztmXN6bNNab
         /qjxn3tIlgowRNafynVeHwQiMA1y/s3EmNIsm+2kXO8V4tif+AxbhWKlGpJIAzTAagJW
         M8n9TvHQyO6GTmcE/3f1p2hNwzLc4RtjtWdEt3HQtG3UVLNlaVgG/yiemDb/Fo0xsMgC
         ii3R63TktnwZFUvD4eZpbgq0YTGhnWlOLLbu9nVJkXcNQgWEpKFDIYMh9EDInvDFgJrj
         /Q8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778699368; x=1779304168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQL5G0XdY34vSKAuhLaAvXdhNyGZknux7fG6J+8FZ4M=;
        b=TTOBl6QcEGjBdsynK2JmQVp/MO0/pthFKc1EAVE1OBN6ChrvAVF1VJFWj2QBDuL1DL
         sp9GaPFaFMXPWcjySfzTEUc54/TVTfx3RJGh+pFyZBvNM7e+I2+ZNfjKqIjsivTdwh1n
         LpVVoZ9FP71Wg6phpzYXcUniDsn430PliIn+27T8J/9UytVdUnxwkanP9OiuDPjmcq5l
         FPY5taQGrWLe2sBMwaux3CC2ZneVc7Q3x3XvRsJMWrZGWsnSu/21rGXCWJSyGny19Pj1
         BSELklRmdpJ3q3OWX4rmNjMJapdYks2o5Ab76u8HxufdGHV3vG3TyVAi3NVsy/j6eexA
         vSMA==
X-Forwarded-Encrypted: i=1; AFNElJ8YcyZJPOm6N3qjALt65/5qarEnJmqnLvbypL997bSAlfl3FoaINpXfT5O42VvTdBqUGMp0jA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxz9fjDz9gS0Wf+KMxNu9iEdGE8JIYa33RT3otBThdQCU44qBQk
	FS+eXWV5A1vRwL/YbVSTs1sUwHCCcXgSfscNqp1JjBP9Qoe9HNEwVI9evejR6y3FaE3EDlyTFGH
	rsSQadh++KphhVWhEm5qTukngPOj4MqnOXaG/8YhEP4mqaINXziOFTCQ0lA==
X-Gm-Gg: Acq92OGZtaglQSQpNxHR/SBd44lVcoLANA2K8vnYadtfgb0sSmVgH+T73YCkdgqqYxP
	rJc2bn7iG/6cS/9+mdX7biOUxBJcmCxT2BLibuPn7NROVFbllD2p0a6C+T0lL3gPBVeDJqhkxHI
	CHhpPp8oTT3KDOvUcxmI6/JQITqUH6RkvfNyvUnh9x2Yul8/InpOdDWdcFZ2kGEXoylc3oX4Bmm
	dK5bqW3G0dVlPPQ1xE3LVedgrt3dirIuC3iF3HpRPKsJ2W4u/MQXtN2HX/mhKbbHzBP38Imf16I
	Vpll6FoP2CQvS+rqOuu9l+6j9XL/zFmuzAs+/L1QecdEM7lVUXhh1MavKV1FEacycZkcfxaFChZ
	fih5RW2x8O7SoN9IY8gm/WD7vUr52TMCJ+vvLJXqPWbvtoPOXBpP3fdALXCA+D2DqPjhPlorvRw
	fPCUicWajEAq11CtV5JKtwkVcLCJzHIANbDeE=
X-Received: by 2002:a05:622a:199f:b0:50d:7135:5631 with SMTP id d75a77b69052e-5162f440d10mr61584721cf.6.1778699367540;
        Wed, 13 May 2026 12:09:27 -0700 (PDT)
X-Received: by 2002:a05:622a:199f:b0:50d:7135:5631 with SMTP id d75a77b69052e-5162f440d10mr61583951cf.6.1778699366968;
        Wed, 13 May 2026 12:09:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f11ebb0sm1313e87.36.2026.05.13.12.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 12:09:25 -0700 (PDT)
Date: Wed, 13 May 2026 22:09:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
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
Message-ID: <csiicospkjf6xmrgpzzxkto3antp24jlrrptg5zzchbm3t2xkm@kalgsyhg6i52>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-7-7fbb340c5dbd@oss.qualcomm.com>
 <elhlmmmisecn7vylpsboiicn7dn4umrggktabyixthmevdv7eo@a4keayee2um7>
 <20260511080104.c4nhhmm2xgzm67fi@hu-mojha-hyd.qualcomm.com>
 <zaq7evuw6la6p6zcv5zgv2nuehc6yxt6xxojjdd2rdflxtk73e@wr2w2kbxamv7>
 <905f5677-5daf-d6e9-437f-7b928036ea95@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <905f5677-5daf-d6e9-437f-7b928036ea95@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4OSBTYWx0ZWRfXwI+MdPH/wsk9
 7huXNMNl1SODfcli+vEoAidDwzlyMZ4ZkGvyfig6Jchf/9nnLLXuVRg+77G4M2RLDQT0xx1VH8g
 2FHlb/yTRiYW4wcHyosd3jO7/ITYRwexSIxDwBcp9OgLCvMu3eFcl1iDakj6cjUDLb0cLHyAJOS
 gvOZxhi/DGVEu/usBIAKraqothPUH/Ny65RY/cmJwmC1jzyIYwgjfCLqVy0+qeX862ZQsszkROV
 uQcidl/xAg6sqHVsSDgy9hsruLWRhORbilVdSIGqU2MSHruGOYEA+aQjFTBkycHU7QLGoBRwf4r
 100HY9DGdgYQZleDQQaLjaKLTZA1hNNHEksZduLNxU94PF5n8C+xGqyZ6ztH6zRhk3lsxdLuos4
 1ZSs1qnIe77buSMClt91j/MdH3kPQoCremoG/0/tuoLr+0OYT7tBvkSpxXWli8aR3R3mhVveLOR
 MrQbjTvxevxlK1hTV/A==
X-Proofpoint-ORIG-GUID: wNxpH1c-gxIvafBR3kPmL7oVxwbnE8pj
X-Authority-Analysis: v=2.4 cv=TJZ1jVla c=1 sm=1 tr=0 ts=6a04cc68 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=EVYz-rHPzUa4Vbhsd_4A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: wNxpH1c-gxIvafBR3kPmL7oVxwbnE8pj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130189

On Thu, May 14, 2026 at 12:24:55AM +0530, Vishnu Reddy wrote:
> 
> On 5/13/2026 7:12 PM, Dmitry Baryshkov wrote:
> > On Mon, May 11, 2026 at 01:31:04PM +0530, Mukesh Ojha wrote:
> >> On Fri, May 08, 2026 at 11:20:06PM +0300, Dmitry Baryshkov wrote:
> >>> On Sat, May 09, 2026 at 12:29:56AM +0530, Vishnu Reddy wrote:
> >>>> From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> >>>>
> >>>> Most Qualcomm platforms feature a proprietary hypervisor (such as Gunyah
> >>>> or QHEE), which typically handles IOMMU configuration. This includes
> >>>> mapping memory regions and device memory resources for remote processors
> >>>> by intercepting qcom_scm_pas_auth_and_reset() calls. These mappings are
> >>> No the calls to those functions are not intercepted. Doesn't hypervisor
> >>> simply implement the SCM calls?
> >> All the SMC calls are intercepted whenever Gunyah or QHEE hypervisor is present
> >> and in most of the case the preparational work for the TZ like in case of
> >> qcom_scm_pas_auth_and_reset() it does create/register SHMbridge over PIL memory
> >> so that the TZ can access the memory and then calls same SMC call to TZ for
> >> authentication and once done it comes back does mapping the PIL region
> >> and call bring up sequence of the co-processor.
> > I see, thanks for the explanation.
> >
> >>     SMC  SHM setup    SMC (auth)        map memory/resource and trigger reset sequence
> >> HLOS ==> Gunyah(QHEE)   ==> TZ    ==>    Gunyah(QHEE)        === ==>      IRIS 
> >>
> >>
> >>>> later removed during teardown. Additionally, SHM bridge setup is required
> >>>> to enable memory protection for both remoteproc metadata and its memory
> >>>> regions.
> >>>>
> >>>> When the hypervisor is absent, the operating system must perform these
> >>>> configurations instead.
> >>>>
> >>>> Support for handling IOMMU and SHM setup in the absence of a hypervisor
> >>>> is now in place. Extend the Iris driver to enable this functionality on
> >>>> platforms where IOMMU is managed by Linux (i.e., non-Gunyah, non-QHEE).
> >>> I fail to identify, which changes correspond to this description. If
> >>> it's about the PAS context creation, could you please be more specific?
> >> I think, commit text is trying to tell the Infra to support any Secure PIL when IOMMU is
> >> managed by Linux at EL2 and the dependency related to SHM set up in Linux are done as
> >> part of [1] are in upstream.
> > Ok... I'd say, this part of the commit message might need some
> > polishing, but I can't give an exact advice here.
> >
> >> [1]
> >> https://lore.kernel.org/lkml/20260105-kvmrprocv10-v10-0-022e96815380@oss.qualcomm.com/
> >>
> >>>> Additionally, the Iris driver must map the firmware and its required
> >>>> resources to the firmware SID, which is now specified via iommu-map in
> >>>> the device tree.
> >>> Why? You miss the most important part here.
> >> Sorry, I did not get.. are you looking for explaination here, why via iommu-map in
> >> commit text ?
> > Yes. Why are you using iommu-map instead of listing it in the main
> > iommus entry?
> 
> Without hypervisor: iommu-map is populated, so the driver creates a firmware
> device and handles the IOMMU mapping.
> 
> With Gunyah/QHEE: iommu-map is omitted, firmware device is NULL, and the driver
> skips mapping since the hypervisor takes care of it.
> 
> The main iommus entry already holds other stream IDs (pixel, non-pixel, etc.)
> and cannot be used to distinguish the firmware SID or infer hypervisor presence,
> hence the use of a separate iommu-map property.

This is not really an explanation. Would you be able to understand it if
you were shown this text?

> 
> >>>> Reviewed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> >>>> Co-developed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> >>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> >>>> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> >>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> >>>> ---
> >>>>  drivers/media/platform/qcom/iris/iris_core.h     |  4 ++
> >>>>  drivers/media/platform/qcom/iris/iris_firmware.c | 72 ++++++++++++++++++++----
> >>>>  2 files changed, 66 insertions(+), 10 deletions(-)
> >>>>
> >>> -- 
> >>> With best wishes
> >>> Dmitry
> >> -- 
> >> -Mukesh Ojha

-- 
With best wishes
Dmitry
