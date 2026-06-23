Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33892609EE
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230454; cv=none; b=Y95Ein9oSWLN9ojkK9uXZTPYCIeDwj6VXWOr3CfhQPktB9KaDCg35C/dXZXxSL1BolP5PRBbrHbDc98Ay2qiaSNMcybiI+OF4OtaYDNGqrY8LyZMQ9ui+5Ayk7C+7O7ZXLdW9nkbiXqLYAGkl0S922Bd08sFvK1o/0RWEl9z5eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230454; c=relaxed/simple;
	bh=7zC9pfHYsK99ZK3cKWoS4K4CNMWolRWecCBf9kpQFw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RmFhOZUOxNbYVIrQE8QK43w9QY/PkZlYkp2j6b0QE1sdm7wcbzLYkn6pabOdEVCTHm63nxMNGAAeNY3FH8/hQ52A07vMa49A9MgmzBiIOparxoHdRj55CkdWuvteOAbPF/EXhpZVD7Hi6xMwdNm5H4oeBy1RqtFa7hsoTEVoo+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UC5r/Aak; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=clOdimYV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UC5r/Aak";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="clOdimYV"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NDFplb270608
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 16:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5n9k4KX04Bj2DP4+GCETxqUImU32jpS5w2W/MeCTA4c=; b=UC5r/AakEX9tCSnR
	VOKYIjJdRnOiPqu6HM3UlLAsyB0P/Rxmuq7LQeKZw5mYYiSewz+euND5UpiqVO/B
	P6SQSUZ8QrqvO0jheBqCj5tUnBqg947l72FUOAeZYF69QvqdCmb53kSx8HTal3y8
	Hg0stY5vl+KWipBw17oOAAQG3sYels5wwH028j4TaPwxfh62Mzcm5tiMeyZyKfLy
	a7h8QNl0aD2DMEt2vwrz0Lno0HM0/VXB1U1tSc0iIpJhNeKwfL7XBY9H0iA+thC3
	0y0ewCkjOtCfNUTYuxtuoFdoytX7pSJmppCp2DPrDe76l0n1llYt9J6Oc30LvYj5
	WnaBmg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eytvh0rc4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 16:00:50 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8df26121c8aso182876d6.3
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 09:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782230450; x=1782835250; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5n9k4KX04Bj2DP4+GCETxqUImU32jpS5w2W/MeCTA4c=;
        b=clOdimYVTC1wivpg4DxeCpLWRSNY68xZTYyxfMsFZEh33uJ2ddz4tDGtvD2KOuMua7
         G2AGZX0aJtiGTmIaMG+uvm6A5Xix1ws5YZH5AxTXTojvLZ+LVWl6fTAjyRHQjVUxkXia
         ZkXhv1sOuNMluPJ5V8XmUkIwD1eX4xNYX87tuu1itx1UAHAbpEYoDk59b3114lpLTNxN
         Te8Oj4yEpZ2P37T/b1rKxhUrr5OSKzSYGBAwF+tYe83Df+0D7SgLLOMakCnGe35V8Eou
         P8u4k0WSoBgQtbcTg0c+VWOLjdvPKvPyupExul5ybdQyKcUDKy5vUJ5VNkW3qqN3rLIM
         HVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782230450; x=1782835250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5n9k4KX04Bj2DP4+GCETxqUImU32jpS5w2W/MeCTA4c=;
        b=TpGZo2X6EiRQvd+rKhwBnreJXlN3gpQmD0FikDCZVsW2U30ti4JbSOHmfFLgWBsmIg
         uy8y5/Sy/m/7sVwkTgwM0Hpw9IglRodEJg7wSDDls2m5PAkywK+Pwd4NY2HSm4qjNbVd
         DpGXuXeLESY0Rc9r2N2tgPS3m2CDxLN/v2iEwMoK2VHPE3TxAjFieR8DZKs+wMJePpEo
         0L8SyelLYCpKK/RMMqUAJ9cGUOEZU3BloatVFz4F4k2Ez0c5tnd59R5uC/Uz6v5VrnNJ
         +sdYplzQhtxDBW5Nd+/WnmwJI8un6aJji37M3re/h4IfnNEWhUmFKNlr8BIXXHSPbJw5
         r8sA==
X-Forwarded-Encrypted: i=1; AFNElJ866wqVHdNUDSrIfGsABJjGx0W+PKRj2k4Jbgz5f2hsC1qUySe1Sg7kejqYf5ec5RWbQQNMRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwekQSr+v15CYZVjBQwvqvnRFiPh5xGiHaAfsqMGp/4pKR4xMLk
	HKtiILQEW8jLkZ8q4L7etrDgRFbe2JovbD3EGCkSOkT4nl2IPqIvI4h1ZAVnpth8p2nBsBXqTJD
	L6zSa3OQ5viIbb24/b3hUcDVEf1itnLYeFFdH+uI03eXtOilrE5t8qRu2vg==
X-Gm-Gg: AfdE7cko5XcG5OFzP5nJCR3t9Qil41/E08zF4We5nTx4KOUOZpNhdzyyWTj1Z3z5/px
	a0jz8SjuMJNF2uFUyOu7V8nwh6Kfosxiuug/bSFs1bs0xUPhDoKv+15F5/p22uAuhJ7k27Q4BEL
	89Wau3g0V6gjOT+EExn5ejLACD7mjWlYy6iIieVSIQ9cFsR2IpnjKmo83AUrw6txv3Y7waenI/X
	T1C1TEVvOsK7/tkZN4PKzpVKGyHyp4/rJW+vszCKRVTGdAVpa+YFJHX7R9JIaINJZ4MkFHnuXx+
	mLpd7Ap1Dkul0bjbqU2n/QH693Unr03bPz7UK5hh8J/vu0yIMGYWdHe26QPH6h9K65HbUi22ywz
	ajR7ZH+MgAnEFcYpdn5k8mCWD0JOjmo71qRI=
X-Received: by 2002:a05:622a:24e:b0:517:76dd:4c2a with SMTP id d75a77b69052e-51a4f4e1e4dmr56837461cf.7.1782230449982;
        Tue, 23 Jun 2026 09:00:49 -0700 (PDT)
X-Received: by 2002:a05:622a:24e:b0:517:76dd:4c2a with SMTP id d75a77b69052e-51a4f4e1e4dmr56836611cf.7.1782230449107;
        Tue, 23 Jun 2026 09:00:49 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e497e88sm550111866b.11.2026.06.23.09.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 09:00:48 -0700 (PDT)
Message-ID: <5417d960-85ee-4e56-8121-959b01511285@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 18:00:46 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] iommu/qcom: Fix missing pm_runtime_disable() in
 qcom_iommu_device_remove()
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260623122034.1166295-1-mukesh.ojha@oss.qualcomm.com>
 <20260623122034.1166295-3-mukesh.ojha@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260623122034.1166295-3-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEzMSBTYWx0ZWRfX8LXW/bonu7k5
 HH9ZO+birNIe0AfXSyvybBZVAMaLaAXudpYR4MCAw1FAnLOxuT8r4iu8BgeJs2j80NpwuU6eEO8
 3BZwzVLzrZ493s+qCG6SmqQnu1m6hlF5OmUARkSpD20CdZg+xvyKRpGqWcVkIkVlVEz1c4rOH5J
 mKLMXprm2wMqZBjtrxyx/TjT8HXChmcDhmccg4nRvDMKAFM9isixaT9xdalg2Wm3OUdOScaMJ8e
 q3XwIYM+4JwPjx+CU1f3RvRrzMtqUFgE1ZfRpsUVAWffy+ltccE9kgJdxoxWN1FQniCRqQDHK79
 hE6eJPh68S+N4zB6GcVSXtcIXCYd9B/o0S0Tu/mOftmFjmxF2Fn/+8WIB9Do7mpwai9rU+yJz7u
 Q8otX1sUAK8gwzWHpMjn3dY2f6ZBnOAUz9D9slHq6NzirifV3lWdb4RIdNkV52Ost+UMBV3dRX7
 VV7CqdvqqQzxbl6zQTg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEzMSBTYWx0ZWRfXzuGMiPOZU4aO
 8IaERhN8I+Y087MfXR/fGa9eAWoVgpI0J97w9882RjbwZhByTtWQxD/1mbg+jSfQYHKfmv9yzcs
 CsAz7H3s+JC8Wz5f3ch4Ld9mjngGL/Q=
X-Proofpoint-GUID: zmZAaoAZXfXxYhO8EhTA11BrZzqoiGpS
X-Authority-Analysis: v=2.4 cv=AJDhMgPs c=1 sm=1 tr=0 ts=6a3aadb2 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=CVC24o2f5RenLrmZXHoA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: zmZAaoAZXfXxYhO8EhTA11BrZzqoiGpS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230131

On 6/23/26 2:20 PM, Mukesh Ojha wrote:
> qcom_iommu_device_probe() calls pm_runtime_enable() but
> qcom_iommu_device_remove() only calls pm_runtime_force_suspend() without
> a matching pm_runtime_disable(). This leaves runtime PM enabled after the
> driver unbinds, which can cause issues on rebind or if any code races to
> resume the device after removal.
> 
> Add pm_runtime_disable() in the remove path to balance the enable in probe.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index 09f2ee6be988..cb43276f4a39 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -878,6 +878,7 @@ static void qcom_iommu_device_remove(struct platform_device *pdev)
>  	struct qcom_iommu_dev *qcom_iommu = platform_get_drvdata(pdev);
>  
>  	pm_runtime_force_suspend(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);

devm_ would be neater

Konrad
