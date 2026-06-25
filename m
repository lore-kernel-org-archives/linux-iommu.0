Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A19329E7E
	for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782412251; cv=none; b=ezzofSQ+dddN+7YRLcsU9f/O4UyEE+S5PC8WuiIS0e1jrf7MJ/x1Xqz0zQNhvJZUCaU8h10Q7fTCjETiKyd0qID7WseyLkVBrfxDBQJd7w1Hp9gZ51rdAeEaRoB/3gzSxXdxCYcBkpvS7F0heVfgOVGA4I+w3LA+CUfMkHSnr5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782412251; c=relaxed/simple;
	bh=wea4vTFuQdFMSRwnqQ9PsLw9OXFYJ7XzeLLBM39fAWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CimAge3cM+QnVsvgT3xbJQZ0V1pcjrqK41WGdf4VwpImAygmFk1aHWZiL8n9UkcYlANo3kGEpH6gl7a6vDWIdO429mTwSAIeQ72BIOFeX5XLaETnLGH/zzOYajkQvZ5L0noFOHmePcAcyUk/58H/OMw+cZGfKV216Ui130WxRCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BbYjkpv+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XNT7gP/e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BbYjkpv+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XNT7gP/e"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65PFdk3v2510434
	for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 18:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=S85snYOLC4IM2seGB/bGs+Bs
	UAcoAt0rGdmX2hVFgYs=; b=BbYjkpv+6hV1hBwAR9rAvB4GQTT4z+NtvQjxmejC
	d2UQvwHBquVipvfA35DKvcHeGZ/LANHH7heO2S4sVfsIQImpi97VpB6R/Lh4bOMb
	of9u50fsIYCDqK5VLONi1F2OM9Saa8upyHGsfFi1fZD9dYORzSiTeEnsvFgLePOk
	nPBg1EVOK8dxQFk599m/TlVps6OVBn8NsaOLuILZMis0IY8OKerlQ18GmowWCsoy
	VF/SzDDyNAK5pstTxePzyBRlRx0NfTkzSE9pKESKEwPOpgolkAVsuto4U4uSskFi
	yQ78nKyXeTEjqsWfbiwVct/YsollkVoOUNQSY+oZcXIXWg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f16jg8y6m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 18:30:48 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c95b0e22aso513221eec.1
        for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 11:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782412248; x=1783017048; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S85snYOLC4IM2seGB/bGs+BsUAcoAt0rGdmX2hVFgYs=;
        b=XNT7gP/eIafFeomchy3OrQPO0EN7dlS478+Ah5oyjQzL3RzeociZpzsCJAQ0kdafG2
         isYVxS0d/q2XqhUVwkJVgmiGPy6CLCJzpzVRBvjLgu06+Mn/1F/tNg/vN9iRxOx5wfgb
         opyy1R9OrqNc+oVXD1drAWBsVuIH6+x+7pYGqrI0sm+EfLoZooj99swqnChX0nxbcFq7
         xBzzCZMC6onKrbXveIubMm2vyRI7LYI+MoNAOkYG8CrgeqSdD/x++7f/NCgJcjehmvt2
         7oKwXdZGAc7OhI5/O/DGE6rYp045JTVMmfRqSGdNA1mIqnntHiQXaNFkbHaXlA4eBBTs
         5J/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782412248; x=1783017048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S85snYOLC4IM2seGB/bGs+BsUAcoAt0rGdmX2hVFgYs=;
        b=Wwh1aEpQIz1ujM9mvZpMmSUGTqx+6fj8GXtpzW8iDRFAuvC+/hjs8BI7NICLQWv72Q
         7w3cIT6dHfRJ9r6RaEEUN7JhHBrscUM49J6/lN8cwZg7XPAf1/rgP9AwnJyZ8Zk7c3AW
         enM4sV8nzopb4fqdlNpmHu8d9+uUkid5aA8+FSnOWHN9fw4k34FYmPq9l/vpbU7Re3BU
         4YkGF6dip5p6BTWevWLbfAO97pb8H1EnznZzlH3d6pAVHXljZGePT1XZENC+Ve/7bkjy
         R5Jbqu6oIFdGV/c9ZP9qFaSyRRIxlbOO7VmPwy2tJjuQwZqYV/zjgDAembLzhHwaQD3O
         LWTg==
X-Forwarded-Encrypted: i=1; AHgh+Ro40ct0Lr0CeREP5U0ak9h4nUKrV4F9/QqnwBlUdaAT9jVL490gcR7hYu4Y7wdQhbGXucTqCg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxzy77ynUajf8TXf+EHTWt3qrykd22PERFCvlWVTB5giXysdBKP
	bZ2Kdg69HE/rXQWLuNqeJCSCwfBsVPak/XCrGm9v06PMZtZEdlG7xRDkAMpqkQtLXrrUUxxieia
	g9q7Ua2cLU10QXBWxeY1JBe83C69NrP6uQbGxufVsxc6q8XDwTj4H5zKknA==
X-Gm-Gg: AfdE7ckQSX2NFmO8j/E8sgwevyeL4EWf4y5xz/i80VqF3qpTKeYEmtZX1t8lagOVbHM
	ZaB/cI6AMU+wB/SuA9df0QfrL2h5R3fRTs618utPrNpIkEHAqKDJZWVqeLk1KUpoiM5QS7/xzwI
	kaoeufLf+wbaoqsJIj8pP9RmBrrtPHztUIO/ScysgGIAKOCADJieQt9Dd2ER8zkUFuBRpZmfwiR
	BYCqqaPuUw76nfe9avom+1C9C6mGpzuRreb84Y5pOXTINSWzkWGkFLrdC6YwjVeeWbtppd42EW6
	oKAgIF4qcbiUBrAtJ9VTfANtPvqJmlFxHDLTPh6fBsScHIR3VQtUA7gky411D7fmenFCiOccKUf
	XhujIfP5uHiBRNEx02IhGPNirNCTG0aA9+deU5KZbJAr1XvffqlvsGRa1SkyI
X-Received: by 2002:a05:7300:547:b0:30c:38ed:46b5 with SMTP id 5a478bee46e88-30c84c0506amr4388481eec.12.1782412247821;
        Thu, 25 Jun 2026 11:30:47 -0700 (PDT)
X-Received: by 2002:a05:7300:547:b0:30c:38ed:46b5 with SMTP id 5a478bee46e88-30c84c0506amr4388446eec.12.1782412247268;
        Thu, 25 Jun 2026 11:30:47 -0700 (PDT)
Received: from hu-ashoraj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7cab28fasm10605750eec.30.2026.06.25.11.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 11:30:46 -0700 (PDT)
Date: Thu, 25 Jun 2026 11:30:44 -0700
From: Ashok Raj <ashok.raj@oss.qualcomm.com>
To: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, robin.murphy@arm.com,
        joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, jgg@ziepe.ca,
        kyle@mcmartin.ca,
        "ashok.raj@oss.qualcomm.com" <ashok.raj@oss.qualcomm.com>
Subject: Re: [PATCH 0/3] convert iova to maple tree
Message-ID: <aj1z1Go5TfC75oAz@hu-ashoraj-lv.qualcomm.com>
References: <20260624030853.2340880-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260624030853.2340880-1-riel@surriel.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE1OSBTYWx0ZWRfX0yJqWPLpADl2
 h21QJSLLIThImB96+bpSqjr3NoRcO7upV2CL1YaC4knZ/TzHXe7iAHAgDG3gOysAhz+IVv7noEq
 RpA9LITKTj0HOB+/xc05s2tuYDE9ibBOS0sHzabv/qRC1Kg/rvpOZshgJ8J3J+H1nh8Ids5khM6
 i7V4sgyq1n54gUeM26ZEzYY4v/JCncyxveGNkj2IgM3VUacVELSf7pFdmRpDk4ve2qjdxKwqCbo
 tPlDm1xvP7kgff18mYbh9JY8lnVDtOmQRHrP/eChhC8BTCJu6z/+5Du7wPwiIG0UNN+QIQrzW6j
 J3lTfomy1c9xm2wIi1yXqlKRmQHw9xM8RcrJAyY+t7GrCRD9vQFz8zPfyQYqf0gbQIl1ht/zLKB
 FAgs+Yr4r3d8oBuWP2cAMlDVpDyVkxx7nvGCJfh4xBFXfnfXtpAUuS2UXd+N5enNOCiI555qDhr
 099qemvxFCNJgUUExhQ==
X-Proofpoint-ORIG-GUID: sVTqlAIaS-hkh0JKZUPA2khv_UVVsVGF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE1OSBTYWx0ZWRfX+RS6Tbj9aK/4
 cM78ltJelycgD6oGKK51lgWUFF3ofn3x5CgQHTXLxiaDRhogEUq/q5KFLTZsGfRds46XXjG14ti
 rwc9aE81Wuv+Nuz4nFLgdsf3si1eefI=
X-Authority-Analysis: v=2.4 cv=daqwG3Xe c=1 sm=1 tr=0 ts=6a3d73d8 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=_fJX-B647VwgLxwyQlsA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: sVTqlAIaS-hkh0JKZUPA2khv_UVVsVGF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250159

On Tue, Jun 23, 2026 at 11:07:33PM -0400, Rik van Riel wrote:
> Based on 5d6919055dec Linux 7.1-rc3
> 
> v4:
>  - reduce the size of struct iova to 16 bytes
>  - simplify the (hopefully rare) remove_iova GFP_ATOMIC failure path
>  - test case for the deferred free code

Somehow the v4 in the subject got dropped out. 

> v3:
>  - switch to maple tree (suggested by Robin Murphy)
> v2:
>  - clean up selftests (thanks Jason Gunthorpe)
>  - address Sashiko concerns
>  - drop the search-with-alignment, since most iova requests
>    should be of similar sizes, so the worst case behavior
>    is unlikely to hit once ranges are excluded by the augmented
>    rbtree
> 
> 

-- 
/ashok.raj
ashok.raj@oss.qualcomm.com
Qualcomm Inc
