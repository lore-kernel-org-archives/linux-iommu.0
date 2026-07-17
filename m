Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB73E2D77F7
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301797; cv=none; b=HBiL1sMmRKNR6XYQSlPIN7xHOnFDCx9P07Ci4UYC6RyJR9J38ru5XyTFguWrFqjVzHRnAwMy72CJEMy1/KTN1oe/FWf12okS8zsN35G3DOXB54XKfkoyNuvU61hHNLkRxaxN4WUgK1jALZWXe21Gsdm9ibGlXivpt2e9t1XzDTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301797; c=relaxed/simple;
	bh=PXO7mXcDt61ktsRe7mrMIbSAZ/ex/y1WeRT/rwpn2TA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amU9U236mkbLuGVntA93LSeltr6jQMolhiuiPNryjVH+f0KBaplbZiUh8QJaOoStu9oa71tFeQLW+RLUgQLsL2HKgAADg2BmrC2SZ4OBrI0dBvcS6rQuhocZS/Cw1a05LSD1l5aYi/DXQh1LWdtBnyQx0cLfA+WyRINmugbfrCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JWp6PcNk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T8z+wuJs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JWp6PcNk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T8z+wuJs"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HE7sLl1838948
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 15:23:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kg+DjNoJWRRRaQne0rluuevQFJgkNzMrGtxjrFO36JQ=; b=JWp6PcNkNCnGbC5p
	6ZlhQ53/tdiuHSSgP7E9U2cmke6LOok1RO+KLkO5WfgBJgq7dECSQHGU0TRQmtTH
	QZ4L3gUJ70lG6kt8FIZiPnapSwS78kkqGt8lbP8bI8kb1P00yBwYbB+WIbkyYbB3
	MRYNk8r0Fv36FIz6agGaOevGWb2ojofmKtvYvoFOcCsPANZXHLTrc7ONzGxbm+7d
	xHdcTTjGmmRl0cwUb72l4OaiieFszXFpbMtjYzYE+HJJZsmUCfc0c6cOlB4l9Khh
	cmld+nrpkLQDtpjiR3gdHRg+m0uFfo0vVBqVjvfmD/2jCDpX8OReHYzDzeWUun2Q
	xfCtHw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fffag9wsm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 15:23:15 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51cab6f7517so11875661cf.0
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 08:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784301794; x=1784906594; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kg+DjNoJWRRRaQne0rluuevQFJgkNzMrGtxjrFO36JQ=;
        b=T8z+wuJsBkxYFdR7ZRW0sPOox4BGVALDi4wmEqgeM5wzB59ZE3KbRFbVu12XmVk/ex
         QGeW0Y3Ap0++wpU02uFiihF76P4zu3L9S3z5bplEhAbUSuAGwnJvk1qIfJar/PJP0tei
         XLhaw7CEMd5WVp/d8ctSJ8FJ8GIWdKjyYuwP/H4dBBJi+mOHK0X/S1Rv6Jt5CSuzlmkK
         /C+Zb/fLxS+Xd12qJHxYixFvp5sdRVwt3RxwsoaaFqB5GQgLJAOf9qsg89sGljfVindb
         6TXQBdZ19z88gBLH1DaaHAiADHwNPHAbv6Yqiu0QvvVl2Vxsxd8STCEwaOFiFWdHsN24
         xOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784301794; x=1784906594;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kg+DjNoJWRRRaQne0rluuevQFJgkNzMrGtxjrFO36JQ=;
        b=lVKdWpje9LvK8mDGr9Ztu5FiYEc5IgwLGib5m8/wHaeW5eCZFWsYO47KGB5rxOUpZL
         5IDGM2w9Nv1W4slAYPFLmOPy2HaOfdSwf9ktrjx0p8rP5aKQhs+N8zBvRgNSQ3tEcNue
         JQGaPV+Zk9cey35F6kzwVghRiJwZNaYYLQl1rgRplimnAfUPbFlYEO232WVQD0TpcC3h
         upzlVP/wroO8JlrV9o8M3Yq6thaGarHyTslDh8BTDTWEa/7O+FJqg0qWBJ4nXMd1WzIs
         UEPC3ExImqDw4mKU9otRkggvYpaVtBIdswqWtZlWSm9ztaTZ1kw3hBc9wrK9lJw2xufa
         exfA==
X-Forwarded-Encrypted: i=1; AHgh+RoybWrUDx705UxkTV3KKa2w5G+QeyWcB92/4ebrwC7GLfLN9tm5qcLC87BHfwLJn3bH7T1JEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0eLjEtWgJQZaS0H0hSxbNF2akS90REaWliOcf4iRrCmXnQlZk
	u/wawiPVQx0fLdgLrUfVx9163Mrx4T0Ew5a/Dis8zLqFO0duros59qfNzxDvGsaNUELfUmz67fH
	RJa9w/MWnEB/Lg69iLXk/VIEP+psStOYn2LA/kQJpg/NA7/FUpRynlO1NVA==
X-Gm-Gg: AfdE7ckJr1GOhSpaOTmgWP0/68dHQRb4av2zAeMnrvRRmGsVXH0z+2mGYuR7G7gXMp7
	rRwmjiLX5nndpoPrkIdpf9qXiNXZRV8ru1exdYzvqicE9YiksVNdajQxZQt7YhAPXItuGl4vqrq
	hsnf4AJVZQEYrqYr4vZi7QxhrjfEwC6SPxM2x9LzmV2zt7FcVTelYqNO5NMgaO8nUFu6NJt55kC
	wiOCuxK+9o16XDnKkPwSMzp6OF9T2/0z5230LB75NPHsEcSTiIg8hajwcKzfoZPQuV2Bkv9aevP
	cUY9AYVsQrKtRC9dvVTnI3ZYOGhwo9qX0+LLZ0g3QSF7prwS6zPja5ygzxjT+pjVkHEqrxYzeER
	MZ+p369WJ/LF0/MfigS3jpNeM
X-Received: by 2002:a05:622a:aa43:20b0:50e:6311:7380 with SMTP id d75a77b69052e-5213f861e58mr17403901cf.6.1784301794119;
        Fri, 17 Jul 2026 08:23:14 -0700 (PDT)
X-Received: by 2002:a05:622a:aa43:20b0:50e:6311:7380 with SMTP id d75a77b69052e-5213f861e58mr17403631cf.6.1784301793724;
        Fri, 17 Jul 2026 08:23:13 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1724f50b83sm93452766b.45.2026.07.17.08.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 08:23:12 -0700 (PDT)
Message-ID: <1648f409-afab-4b2a-907d-a90de62d6bb2@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 17:23:09 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] iommu/qcom: Use devm_pm_runtime_enable() in
 qcom_iommu_device_probe()
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Alex Williamson <alex@shazbot.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260717144608.3216274-1-mukesh.ojha@oss.qualcomm.com>
 <20260717144608.3216274-3-mukesh.ojha@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260717144608.3216274-3-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE1NyBTYWx0ZWRfX1eYkpZzYT74O
 sNnAri7iMtLmYX1kA1XkYMVr3TPFYyN4h7ei0w/nCwp9nnwG9oNB9tlVF859WxpO/SZluXjxYLj
 iex0eiyW/4yGNXn8oZa81dMVpDFZHxHiduMKyt+mWY7Qqrjs6p/ue2inblbAjwt+062Vm+bGnEV
 /62DjFtbcvKO1AMT4bUJQnH30N3qNfljx32ysF62XH0GdEsbYHq+bHuabGstwfErJGTW0yo9s8u
 2eGTB6QVUVgLT4eiSsID3pSPRRAnilKt5nN7mAZYlLDOMLyRsszXCef3K/Xc5n+Zk9c7qnjN6ok
 vrnkDgb6nQrnKbhj8rLc4FGB+DyMS88++ZN2Kauk4Q6HXZOl4hAPJ6q9vZHqcfLMaAP2RbCFGDb
 5lHs3l2SAZSAVW4VnE6oBlkLPHxYUyCiwK5qSmnLJUCE/nn0nus+cEJ9ahpSAnjxTFK3gpwQOVA
 Q537mQ+0r/L3qDuh6jQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE1NyBTYWx0ZWRfX50bjAskkOJfV
 Hhxw9INt+/I/nDmdGYRm1C8pjIS4KlPrAcHdSobMTaUL6LdutIY47pAgq0yJDH3ccjgXrHbNLUn
 yl8eMXR7zJJspRt/1Uu3wga1KB0614A=
X-Authority-Analysis: v=2.4 cv=KZfidwYD c=1 sm=1 tr=0 ts=6a5a48e3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=xoj3hry2uz_LQgjbiWAA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: VfT4K8nFrDzyI98J-At2SR8_WmR46GC5
X-Proofpoint-ORIG-GUID: VfT4K8nFrDzyI98J-At2SR8_WmR46GC5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170157

On 7/17/26 4:46 PM, Mukesh Ojha wrote:
> Switch from pm_runtime_enable() to devm_pm_runtime_enable() so that
> the matching pm_runtime_disable() is handled automatically via devres,
> both on probe failure and on device removal.
> 
> This removes the err_pm_disable error label from the probe function and
> the explicit pm_runtime_disable() call from qcom_iommu_device_remove().
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---

the single-use goto could be inlined now, but anyway

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
