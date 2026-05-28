Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF0B34CFC2
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779965955; cv=none; b=bU1uj0bmZBn1Eps5TvxyesLeYyjghmAXhtKgQQxwLu1CLbEyq/MR7HukMZVWGBLZqHfr554G9AI7/xjwYoCiYX0cQk+55sk+X9Ex1PYbD07MoohMHFJ/n2h0XupPVdd+EQP/6T4l8bzDKqANOcA+swNnKcbD19kQn/UkHEB4ubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779965955; c=relaxed/simple;
	bh=JDEi2oo0P4BLqlVpKWL2iOe4Zq/zpTK5W3KPcRGwS2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqHPLVcugXlxJbtFM9uACrxjuphbvPAUUqwbWNNWKxTnSy5m4MEl6Gv463BiyrbjWwstoVZJA3l2t5cMkXpHXriaGW+tBJzItD/A6jRL8JeuiOvdv1tDXD9VW7GlUHXc1TuurZ5keaN8stG1r9048PO7hVwVWOI4x8UrUxljCnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZKfb0qan; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KXBKAgvJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZKfb0qan";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KXBKAgvJ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64S8vlR9298259
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 10:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OQykVN7zbGGObjLJasSgT0TV
	owil6BekcefmkEti1dk=; b=ZKfb0qan8ATcNGiJGr0uXfXU+nEvhd+XoDg0UFlw
	+46xOzRax0PcRFNWfdG0a3XtM8x5o8UVZPDruu27v1uV7uvdfsi9H+iBQ1aILszE
	PyDg/e92h0d43X6iQVaiARMxQ7dyhil4deXO/37DROU7Hv/tnRoT0PrPDJ7QXEMZ
	6KAgcoA34OWqncCiwPAR14KjAuVdm7r5NAg9A7T+WalvcY8fcfA1k8daFQsrQfvH
	fRSdKIFV8FsDKf4WTZB9KFEYVJWfgA93jc3IFFfUZo4XgE/U/hZr+oqQ8rVaZ3pu
	DPz1IPqPDq4sE9OmpolUAosQT0ae2i/qh3//Lqke+/JghQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7yajehy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 10:59:12 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-516ceea1984so134493931cf.1
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 03:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779965952; x=1780570752; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OQykVN7zbGGObjLJasSgT0TVowil6BekcefmkEti1dk=;
        b=KXBKAgvJrln0mf3oO75/iMp8+HPSj3CW5r6nMft9Cz3qjbflEteT4wVxbNL9uijDai
         0m5tg8t9q6MrpVwKNJoU7wbgdkUdkDIzEid0tQhgzxa8mmgwXwEYi/3vwXJAMgz5jdNV
         RI9U7wS/i6u4P1NKDbKrVhzOj08V0cxKtVBAEmsE2ZJ+5o9Y0ozzN0H4R018P/OTCAD1
         mfliBBNzsYeoCvZxh4GHMGPU7ayh4z0KqUgV50L7f/m9pLAKJYNO3IE5se8wpninxYTx
         npd7V+v9Nxzw/Wxi4Tcx4T3EGQxTOIYH/EwSp2pcyH2zbFnguAoxAAy5z667preyFb8m
         Z+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779965952; x=1780570752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQykVN7zbGGObjLJasSgT0TVowil6BekcefmkEti1dk=;
        b=Hvj9KXOkZMNvw7MyEYLniBNVKqzcGYyo7RCTq3W4l/6EARYEJ5J/m6ipHuEPfIgP6b
         aRYNF+ziVFb5E3SxTqFNDsXtG1bvPCgiUU1GLFtTkStie6mEjeo3t75uQLTahK064mOm
         8rNPC6g/nLONI47UylVFcKCjFHcVsapwfH5fU60ClynWfpKzV90VyGzQeeQ3EHkP5R+z
         tDIOmwtQqQCeMaRmcTmbgUyG/rdER/tq8conyisZTQtfGIgbMEXqE5gnXxTixRok5hMO
         VTDJEw066KHMqNCcZZEsp4eGPQtZhYbMNmGipSnSaLC3eQtYMwwwDbpsIkyWh/VUMd7n
         uVTA==
X-Forwarded-Encrypted: i=1; AFNElJ8eT9oFcbBy5qhZnzaGvZROIvh2fNmxeXZNw8VHdBKnUgeOyfjCo9IbUJMupD4DLe3RbuYONA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPlCbIcpYDckiOQgNpmQOn0lFjkP9WXdukweQhRZz/JfAgRPxt
	iIoX9ExWfJPRji85nVn8dCiWCAmFTApfCqkmw9Z78xAmBU16k+q2Y5128ZhI7Te/pa9J96yLods
	2LSt2ycQi+LSvMmJ+ZwU+m73/lOnEy1BYnp+C1BxBXaNhD85eQQmdnroBNg==
X-Gm-Gg: Acq92OEySk1ecXmpUmWNKZYQ+hQGrufmYOiZstpvmyt/VLVwr/3RuBEKvrws1HR5vP9
	NTE5ZDq3WBsl4UroxG/DvxcNuEI3HlYXUAsH+bvNEYtEwvuEB57rfU3TMcmdx2axW/3nF5JVtD3
	EFbkyNL8LFBz8/VQyDk6+TWkhwhrmBZvkusmtd6DcqPGPempbG8eGjsq6CIObb6oFVfXJGoeaf5
	ItP4wDyUPyP0oo5Xz1Rbk4dVYJ07AH+yYN/xP/gth8nEXwAQwQQ9uXilDb9yTw/awF41a3S8Evk
	YQU/bN3LDsiFH6K+IKcE63hPI7vtlaLZ+2MZcZOxuLYokPprfVnLm7L9VnRZMRkdXZMX/8cV1wA
	bpQtP+sx2GUncfT6HqwGrxYaUQ7RfgsNmbD10tFZHVMPTkK8DqJs+NM83pc4sU9KD+CxwxFtCiN
	Lesl0NKMaNdJ73BfxsYNgWUu0zfTFIOoQkOq8WGgHer4LV7g==
X-Received: by 2002:a05:622a:684c:10b0:50b:4e4e:1a20 with SMTP id d75a77b69052e-516d440e798mr181630871cf.59.1779965952195;
        Thu, 28 May 2026 03:59:12 -0700 (PDT)
X-Received: by 2002:a05:622a:684c:10b0:50b:4e4e:1a20 with SMTP id d75a77b69052e-516d440e798mr181630531cf.59.1779965951660;
        Thu, 28 May 2026 03:59:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa4bae942csm1105133e87.36.2026.05.28.03.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 03:59:10 -0700 (PDT)
Date: Thu, 28 May 2026 13:59:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
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
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 06/14] media: iris: Add context bank hooks for
 platform specific initialization
Message-ID: <6gbdp4zycx72y5dpbhsvxrv22khetqaovylmazusp3qanqp62x@o334xpoh7gkt>
References: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
 <20260515-glymur-v6-6-f6a99cb43a24@oss.qualcomm.com>
 <sqjbcmcy3wohzdiftb36i7ztfyt2k7mnxkrzxk5yuocpe7kfy6@ev2ouxxnf6cc>
 <b1888f5c-2613-99ca-ee12-fb4717a40731@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1888f5c-2613-99ca-ee12-fb4717a40731@oss.qualcomm.com>
X-Proofpoint-GUID: HLA9rdDOAGBLXcu1qlrRjdoEic5yfFgu
X-Proofpoint-ORIG-GUID: HLA9rdDOAGBLXcu1qlrRjdoEic5yfFgu
X-Authority-Analysis: v=2.4 cv=CaE4Irrl c=1 sm=1 tr=0 ts=6a182000 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=5AEaNukWL0ruuHmld-sA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDExMSBTYWx0ZWRfX8fwTqHFbhvtt
 eoJpCntdArrOik871hgbHYl3ujWjut/fR8H2thKB7v9a8EcIJ6/r1RzAQBwYV6xoRPJOEy/ULp9
 6PokdtyihktAZxLQO1fegkwmEgCwgDodRsBOroMhAo6rnw4Fk8t5I26y2xzl30ZI9tFpAgDN027
 eKmRBfb4QVgj0IeMBCopxcxI6yzWR4B+TjI8wbBOdWExPOioxqRmL+lFUbgDioQe1/VHZv0Ipl0
 ERBqXdiSnKnjaKMy7J92Ov0015zH9BaocEIhq3YwFCHNRUKTzpOMAdOU0GSqD0jThyiUfm1SJII
 IQlNgO8S300VD5Xmip3MkLiG068rVJ63OII0tcHd9XPoWVSk2aEgtltkbFntNnoDS9k59x/1qnc
 ni8YWIQ6nzXGB0yul8stLSGjCXyL59I87zDoDtMXd4kc3qzSg73MB5hRvP2jXZvPCCJIdO51W1V
 XWtZZ3vLPY/Uk+Wrd8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280111

On Tue, May 26, 2026 at 04:51:52PM +0530, Vishnu Reddy wrote:
> 
> On 5/17/2026 11:05 PM, Dmitry Baryshkov wrote:
> > On Fri, May 15, 2026 at 04:51:21PM +0530, Vishnu Reddy wrote:
> >> The Glymur platform requires a dedicated firmware context bank device
> >> which is mapped to the firmware stream ID to load the firmware.
> > Why is it required on Glymur? Is it _only_ on Glymur?
> 
> It is required for firmware booting on platforms where Linux runs as the
> hypervisor (KVM/EL2), where the driver needs to manually manage the firmware
> IOMMU mapping via a dedicated context bank device. This is currently specific
> to Glymur.

Is it explained in the commit message? Usually, reviewer's 'why'
questions mean only one thing: there is no good enough problem
description in the commit message.

> 
> >> Add init and deinit hooks in the platform data for context bank setup.
> >> These hooks allow platform specific code to initialize and tear down
> >> context banks.
> >>
> >> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> >> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> >> ---
> >>  .../platform/qcom/iris/iris_platform_common.h      |  2 ++
> >>  drivers/media/platform/qcom/iris/iris_probe.c      | 23 +++++++++++++++++++++-
> >>  2 files changed, 24 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> >> index 6a108173be35..84fc68128c70 100644
> >> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> >> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> >> @@ -263,6 +263,8 @@ struct iris_platform_data {
> >>  	 */
> >>  	const struct iris_firmware_desc *firmware_desc;
> >>  
> >> +	int (*init_cb_devs)(struct iris_core *core);
> >> +	void (*deinit_cb_devs)(struct iris_core *core);
> > Why are they being added directly to iris_platform_data? Why not the
> > vpu_ops?
> 
> Some vpu_ops are shared across more than one platform because of same
> power sequence.

That's still fine, it's better to have vpu_ops with same callbacks
(except for this one) rather than having a one-off callback not matching
anything else in struct.

> 
> >>  	const struct vpu_ops *vpu_ops;
> >>  	const struct icc_info *icc_tbl;
> >>  	unsigned int icc_tbl_size;

-- 
With best wishes
Dmitry
