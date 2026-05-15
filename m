Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1213D0C13
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 10:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840698; cv=none; b=rrIlvzfVkvIIheS1OZ2sm4F+32+AzaIVVSUWhcpXy1QZKFgo/RGftNuD44YzV23SfSLjOKtY5Gu9kRTA2S4Nu3mN9cpnzytXi4zS1Z7XmZFz6NGZ3amdUOtEacidxiE0n5yY8PT6Wy7KbmyjR6FhSaeEk9yzbIjYyDRRm06yrEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840698; c=relaxed/simple;
	bh=mvPinM/tJfxm+rmtDR2dA6pZP2MRjfXid39J0izyZb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsP/u5BnlLON3t+/HG2Wr+8pGDx8P/hqIiYsyxNR1yy7ZpXYu9DBsugJ53vDKYFrNcfX+eikvKxAkrK/xn/rEpsE98Elb50DFjV3IhbpMpLjMPk+n5QyuuHvJcromuA/kZ28I9N6ZPIXtfHs5H3Jo6GIfpfI1tRPkDHSIMe8tWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gl4Jxtr6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AMpfZJBP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gl4Jxtr6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AMpfZJBP"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F5I4Vb654903
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 10:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xpt5WSbFp/AI9TGMZc5Fn3Wa
	uUNLzeYaoqSqN1ldUj0=; b=Gl4Jxtr6THbDhk0GkwCs/cA1T6ZBL/U0XFNZU/59
	GiQoq46MVjWHu3oqE/QeIXTwCBDJ1X9XlYgj87MtlGPCKJ3KqaCTx99E5URHvxRl
	v5bXBil1TomMyFxqKYNfsRnkS+6PiVk8ynN1mWnlEPDO/XpZkUA0e8p7803qA9Y6
	HBVIAvXgJY0KJcIG8089YndMFoIDrJcTKwWhKaum1LwG5Sm/dxU/WNLLs4hPaByf
	CO0E9rbuqN7dWcsRZCwCvGItOqYdzFIWzCF0uofaeGIdzk1DLqedqrm4aX2UCUkF
	P59Mx9owC63TMiJYOjhvFNIOMKwhI2/FNVMSx1SUPyyKhQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1ptvq6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 10:24:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d6bf346adso143327131cf.1
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 03:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778840694; x=1779445494; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xpt5WSbFp/AI9TGMZc5Fn3WauUNLzeYaoqSqN1ldUj0=;
        b=AMpfZJBPGdOiwvhTzoDEA481V0J3IExbMLOxEkWkBtZbZHO5uQLlEPrAtNtuYq92BF
         f1dldGfy8i9UBs/9Xp8YbkBO9Ph8kXJ9ejhSpfZn1JBocQzHkiTe5LpAbY1j8+QmMaJ6
         zNJkbEqCMi8dGx8sF9n50ywkHPE5v8NOADpUlLQz4r1fepiyHJFsAts9K4IpqvkER0I8
         rjY6qxxDKI6Lm4iDj716e1pfMOxs6c2TcJyIwkd9Y9cya+pjKomomzST/uXhcocIk6oP
         vGQ1CJsXPs78/7KPFZRT65JWl0nUTD+GA/Ii/t7F+F6SQhXlTp8MeQaCBM3uyILXMYrS
         L6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778840694; x=1779445494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpt5WSbFp/AI9TGMZc5Fn3WauUNLzeYaoqSqN1ldUj0=;
        b=RHQshgH+qPYWaZtcvkvnUzDP75eswLqkk0EbG4w0VrbjQYSxxK/dnMOojN+apui66D
         UWQWQ7gz9enuttdB8XAQZT3hqeMZMduM+CdY8FncBaBIFiroq/RtPWAmoygz/KTkBbxE
         0AIYHK1WwvZyAvsQ2bpxoWdMt4yGD4eSynkLSAE27uUb2jHxKgbPTVDsAXR5/S9FBBJj
         QXYz65tJT7guhlPP5dfduKNAlJH246GOwJgfo82LiYlUjRbQK2ZbWNtPT4SjQR+Oon2s
         tFAR2pe4OvQ/XyriwMLc0FFLatrxzcFz0RwYiw2RGzWj/zNWS3VmxlO47wbQug5BYPFX
         a3uw==
X-Forwarded-Encrypted: i=1; AFNElJ9c2xfrI6CWlQPKCyx3dtAiinLxWDDDiTwjbkPWnJzh0wK8Y6zrnAERVzUEVVJalhRy5RUyhw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzevJJECr86Id0090FfnD7WcIJxVL1uF49yP0AhNW1daQwi/8f6
	cyAVz/1DsuAv5/xjZciZsQTVVrQA6exKPPgPvgWMFwbhdtQcPiuLrMuStOGRnKszJ7xLoYb09C/
	XV+wafEw7uMcQU9iVkDxlMDyDbV9v/mCin4z9B962i0ehQj3y7B3CT35IFA==
X-Gm-Gg: Acq92OE91gI6J7xi3R1sv5matmqC/WMSpzTuEk2gjLkwkyx9T9bXLk7SXM/z9ykqnSm
	GnELnYdO+fAuKYHGoc4YUrTdKJ8PsOLwAORnhF+8hx9kSVgzV4KWNrGAPU/ffhqIAyzyj7gJim5
	h3Pgkz0hydPQ444AkkJlUD7MyqL3XwyqeZ+E8O2gq4BTdB4w18tbXe5ryGJjnQl6vIl2WvEdomt
	6Fj8/RjyOUOqVYqQjHYAvvYxHOreDtprYUFnFppvcqvA0uwCxaOisVGcI7p/uLGzLcMS6yZH7Ci
	zRvz7VBDcgUFRC1VYSfiKbYWXl/oGZ1pbPcD449HNK8IXkec8+gW7eSu1vTEJhb4PBRIrrDNjO4
	08xbcCQ+KDq9hDtUTJAkOWpcrD38WfBQtUf+IC4rEMEe4HHLyrO/6RPGN1n80pXzL9a3jLS+15a
	rCWggOvIoUNV84T9GCY0g3KhsXo4p/OBwlYcI=
X-Received: by 2002:a05:622a:90a:b0:50b:4337:179a with SMTP id d75a77b69052e-5165a011bffmr43185981cf.3.1778840694169;
        Fri, 15 May 2026 03:24:54 -0700 (PDT)
X-Received: by 2002:a05:622a:90a:b0:50b:4337:179a with SMTP id d75a77b69052e-5165a011bffmr43185541cf.3.1778840693695;
        Fri, 15 May 2026 03:24:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3945c8dc7afsm14585621fa.14.2026.05.15.03.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 03:24:52 -0700 (PDT)
Date: Fri, 15 May 2026 13:24:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
Subject: Re: [PATCH v5 08/14] media: iris: Rename clock and power domain
 macros to use vcodec prefix
Message-ID: <biphbzvvy55qz6rnqpw77taxczeuitmkrodepyfosnoxafvsxb@swme7xerynlz>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-8-7fbb340c5dbd@oss.qualcomm.com>
 <6hr42ins65rf6ftdmme5lok6ham67piz3343kdwxaff2acktcz@oipdhket32og>
 <4eef8b17-47b5-e8f0-4a44-87fdf1d69d18@oss.qualcomm.com>
 <cyjxjidbe4qpeb5pwv6u5yqwhldqffenzgp6z4irgxkloturt6@buswzuou2w7z>
 <54abb8a1-e894-44cf-87d0-2341660b7ae1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54abb8a1-e894-44cf-87d0-2341660b7ae1@oss.qualcomm.com>
X-Proofpoint-GUID: bDpOXPHaT9EKJ0QpOPa-QwZzQsHU3f5V
X-Proofpoint-ORIG-GUID: bDpOXPHaT9EKJ0QpOPa-QwZzQsHU3f5V
X-Authority-Analysis: v=2.4 cv=GrhyPE1C c=1 sm=1 tr=0 ts=6a06f477 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=JLCR6Gb03Lu4_UV5QcsA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEwNCBTYWx0ZWRfX3FE+Mu0hfbIT
 vIMVEUe37KM7JS4J6b4HUywHQF9G9VuYdQIKofoY/aN0Xn8x2lXq/ZUDhoA9HFsdQ6ScHmIAuLt
 Jdojgdep1ZWLVIJ1K6iXCzFqk6IOLYPBns9jtoAzU3NMU8T2bVE06enuDIFJnD1sfpaYHqNMYq5
 mvS8d3JZaTqY69PRzUNij4VeIa88aHuCOUDWreEm/VdfDxR7pZ3ijm4d8oKAjDvGNtFOk8p7Uso
 jcCCtXx/GrevMsXhFpo0QboLTqH24YrVPeUAsyUNCXhFTyQg/tvp/tBJNpa0HwNxKnf3a1pZ+y2
 hBoyaaufo23BqSkqfld76zK9qRwXiwcRl2vCF/6eRn4IvuDdnkVL9eZhCSXflAgSgMKrHwVQbWQ
 oYqqPQYJFNiXNw9A6NYq05UtDmLXQyYS762jU9HAZn7eyryz0m6F3yFGFlfJG+H0ZaKTFsOiGDc
 3wnrz7o3xnGzSG5yXqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150104

On Thu, May 14, 2026 at 11:15:39AM +0200, Konrad Dybcio wrote:
> On 5/13/26 3:47 PM, Dmitry Baryshkov wrote:
> > On Sat, May 09, 2026 at 10:37:20PM +0530, Vishnu Reddy wrote:
> >>
> >> On 5/9/2026 1:52 AM, Dmitry Baryshkov wrote:
> >>> On Sat, May 09, 2026 at 12:29:57AM +0530, Vishnu Reddy wrote:
> >>>> The current clock and power domain enum names are too generic. Rename
> >>>> them with a vcodec prefix to make the names more meaningful and to easily
> >>>> accommodate vcodec1 enums for the secondary core for glymur platform.
> >>>>
> >>>> No functional changes intended.
> >>>>
> >>>> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> >>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> >>>> ---
> 
> [...]
> 
> >>>>  	IRIS_CTRL_FREERUN_CLK,
> >>>> -	IRIS_HW_FREERUN_CLK,
> >>>> +	IRIS_VCODEC_FREERUN_CLK,
> >>> Can we at least group them too?
> >>>
> >>>>  	IRIS_BSE_HW_CLK,
> >>> Is BSE a core or a codec clock?
> > 
> > Unanswered
> 
> Is it the same BSE that requires a new clock on Purwa?
> 
> https://lore.kernel.org/linux-arm-msm/20260507-enable_iris_on_purwa-v6-2-48da505e23bf@oss.qualcomm.com/

Yes. But not that BSE question is simply an attempt to find a better
approach for naming the clocks.

-- 
With best wishes
Dmitry
