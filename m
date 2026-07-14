Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE8F28033B
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 05:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784007859; cv=none; b=h3JgUBUy5SUJENRFgwzxvZfQkblJhsBM8lf7J+e6q4tCXWDHUkRDCPATdZW4Th4KED2TD9wmaKMvFnJcu8Pz+x+vgANLn8rsZZDoX0ITbHos94nLdXmj6AoWW9GXxqE/LV/zVzDnwpNua+fIdZMvneoTc2HREy9TWh9CfMhMH3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784007859; c=relaxed/simple;
	bh=IjRSdvKpxNHTgcY2XTiXrloy21QosMu+mMnSPepzBPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3TblE6P0zA+vvchw5FLfv61SlX9ooI338YCy21vwFMFJ3ccvFd1hdFy5ApGCO9STXfBRAgNcIjdj1hnC+hkLImzii+hNFBOnkkWEYlCDTW4Nlpyzb28XIWS4px93FNOayng6wBkpDKNKsgTiaUr7f0ryO07/JhCJlIjd9OTdqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ioGx4hvN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DawlAw9l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ioGx4hvN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DawlAw9l"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E381f33556455
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 05:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tuDO+eNFRlMdfIF0TORhgX34sio0UiStdpTpC0W/twk=; b=ioGx4hvNncdMvSi7
	3BpVUZVRxDmhvwliggnB32j975h/OnSD+D09qjmZVJK1148sEmW05hFiN0WugE/Y
	cuFICPSj3Y4MZTdPLSOWXO1FuVUE+XZV6H4hjzjUHZNdBHjhWGYXfAmrt2VmB2ab
	raKj2mvQ5IrTTokJOx6apLpgh1rpzqqbyI3ej/rUbvUpH/cs/Y+ob1b6w5GK+yY4
	3SKJ9esCaHwTTxFa6sI+vWQOkqhZZUesDu8hw3WpuR8NXxYwNFLSdCYReB0+BKiB
	VE1ktKhLmP+ytncuXvutoKNs+ULH3ZU9IWOwmuRp+lEdFsfRtUkaGljOSY2OvGiJ
	OS5Pdw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44ct5wp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 05:44:17 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ccbb61893fso89526275ad.0
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 22:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784007857; x=1784612657; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tuDO+eNFRlMdfIF0TORhgX34sio0UiStdpTpC0W/twk=;
        b=DawlAw9lP8grH1X0THdtJjNCbIEiAs/2HoNmHGTpEy/FMPa59QKgBe851OO1bc50Ky
         8sLGbUspJiaOUGsZRPDz0+92nK13RbhK212MaiVXH2fUhFbdsuQWhc1e4FEONhLZEgAw
         UcvEcsR23UzZQISMQdeirpNmf4erXK+BQ3WBsxW/36+tDAH7jIQkZPJMedi3JYB+sgk5
         1SdieutMWiygMd2FXr22dWaG6HHBorqNC5/LcyEXEXtM22AUnMhlXmANx7fGjqBGbx/i
         l/iL6rYozXo1sNnrjtb7SXSBBTwhcOQ3xru7n+qr1EpuIvC1hl4YD/4WA0ot5WB7IZZj
         OCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784007857; x=1784612657;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tuDO+eNFRlMdfIF0TORhgX34sio0UiStdpTpC0W/twk=;
        b=VQYWMdSheQj6U3JjA0bOQbEJcMio3p6zPMH+1opM+1iZcTxXFt71w3ZsjN7c5agPQh
         qNlD5o6ObmJCNwTtty+g6vqqqXjEdz1YB5XnDYzp74XWyHPHUzYM1qZhyd86VDujdn17
         ZXZle77UQGO9T/g8mNrNXd565IIJ0hwYi3Y1CH2daHmMsqSI9R4ozFWG/hR9G6QG0mHj
         hVBVSK2HaWec9Y3Rp5Q5MiFdlqSVuQpdfp6p9oETzztddr1rMkUB95hHBkZQbVROd1zh
         O1FRtA0yTk+EoNxyHlYg21/cC8x85CS3kqUrJPyHid9XSuANWbNEmtDwof6ji36jiLVi
         gA9A==
X-Forwarded-Encrypted: i=1; AHgh+RrGpRijqHPYrUAT86okdkvhY/KpDr4t6/M9R1ECIs/lyWjvUgmm2D2zacNkQP8kt17JoTH0qQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGh4dKrltI2Jsc8Bcq+s1lbqjvt+NQOlqrI9RmZ5pL7IYT6+vE
	HIzbwCOTeFNmt+KQVrRwhrignXqGeD0zr/d5TA/wMqY2G6e9vnMmoyMVlaDbl1brh8Grv+sU5HB
	LQtkDUP2W7MH7toUQ9/2NlqWChb5v1023/TnOjVybfTP0iUi2P74Sy14z7w==
X-Gm-Gg: AfdE7cmiWxYQQG2r+JotTuXbcr8EJvigInWFY7AuOJcaD8Zs8hnhYOsoMt5M8aaoKMz
	lvTThe2cgS8wJ+vWAHo5A/kUW29dFME+rM2chtugygAmCZZjNr380csARUT9cRBBwc4DuRcAcPM
	mZFsKK5sZXQQe2goWj/vIWPZjxKgBGwUrch7NQwiiM0NIUBJtim84MQmdiJ3moLWQetKfu3EhA1
	T5uY/6plLAmZ5AQH20U2XEmW6+kjMxWFViuuP5waSbDB8JudyaDljffMWeAQDNsBxqEl+Ys1Ksq
	B2eIyumqaRVo+IZHNCCeall16OeN045RBkOdPZTq9tSqXv6kuvqtqw8j7Nx7c593lw8pCgPLzGK
	e8JHGIMvSK55R8E/OEgUFIla/ln3H9uXNE5fMRqdc0jwzx9wL3T2HuxbvzLWzanDrv3GWU+k5Kq
	r/eiim
X-Received: by 2002:a17:903:380f:b0:2c9:c18f:7446 with SMTP id d9443c01a7336-2cef143b0aemr11672665ad.27.1784007857047;
        Mon, 13 Jul 2026 22:44:17 -0700 (PDT)
X-Received: by 2002:a17:903:380f:b0:2c9:c18f:7446 with SMTP id d9443c01a7336-2cef143b0aemr11672275ad.27.1784007856591;
        Mon, 13 Jul 2026 22:44:16 -0700 (PDT)
Received: from [10.133.33.31] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb6e2sm111538675ad.3.2026.07.13.22.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 22:44:16 -0700 (PDT)
Message-ID: <aef05058-848a-45a8-a082-a484f167e872@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 13:44:12 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: arm-smmu: qcom: Add compatible for Maili
 SoC
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260703-maili-smmu-v3-1-b48de6f5ae4a@oss.qualcomm.com>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <20260703-maili-smmu-v3-1-b48de6f5ae4a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kKE4l8q30qfw4Ns1DzfvdKRxSu6dgeYm
X-Proofpoint-ORIG-GUID: kKE4l8q30qfw4Ns1DzfvdKRxSu6dgeYm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA1NyBTYWx0ZWRfX2IQbRbY3nt0h
 0Q4cBY0O8hs6wo64z0/Xj13O8LGfRRglOZasWvXeML+p7taVeny63V6RTsZFb0MFMDP4vfyvXcX
 4y4pYNOUeNz9OKghZuB1uQW4oZkaX7k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA1NyBTYWx0ZWRfX/77RgSAdZmsQ
 PhSVKPYmAAzB7p5nV78fpPtz8maB37zbTYVnCkKzYA/fNu3b+90xaLZ5iHBiqcn2aG/xEeFq3fE
 Az/lq+3n0yaqxHxyKuAzZg5OjkxAqE7qcjNXQDkP8Jhy9wBw4lcTt4FpO2ZruszJplrRex5hjZY
 a3fajASF2SO0VvituzwKURmXajuUgRU1N+GYcWzN8yAVUR+zFBTONTr/sqaioseYxqXPWQjwTwF
 z9kB9P2mIt4V8NMujKOcmD0u2Xsx5JnnKRSesR23jlu6bYuSwINGEcKM2Eu904r3FIv81F3aGBT
 6+J9sVjNbmeCbwJ8zvhqGrF8CZPPw/aggo64xux34eiBAzErwhsUjfraVBJsCt7lE0VAYF22VXd
 cAVwDP0zO6saCFJH0efPnoqSJO12E1CdRvJTLeu1DWeY/vGnYH5dL79yYeOypOckoSCjpH0KXSb
 F92eqCImfCA9AiRS+aA==
X-Authority-Analysis: v=2.4 cv=P84KQCAu c=1 sm=1 tr=0 ts=6a55ccb1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=GanE8jRN9TD_0qqWZfcA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140057

gentle remind to pick the patch.

Thanks,
Jingyi

On 7/3/2026 3:50 PM, Jingyi Wang wrote:
> Qualcomm Maili SoC includes apps smmu that implements arm,mmu-500,
> which is used to translate device-visible virtual addresses to
> physical addresses. Add compatible for it.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
> Changes in v3:
> - add smmu binding to the block that disallows clocks
> - Link to v2: https://lore.kernel.org/r/20260628-maili-smmu-v2-1-87448a7678ec@oss.qualcomm.com
> 
> Changes in v2:
> - patch rebase
> - Link to v1: https://lore.kernel.org/r/20260524-maili-smmu-v1-1-ec85b12fda83@oss.qualcomm.com
> ---
>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index a701dec2fa0a..fd095161f6be 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -39,6 +39,7 @@ properties:
>                 - qcom,glymur-smmu-500
>                 - qcom,hawi-smmu-500
>                 - qcom,kaanapali-smmu-500
> +              - qcom,maili-smmu-500
>                 - qcom,milos-smmu-500
>                 - qcom,nord-smmu-500
>                 - qcom,qcm2290-smmu-500
> @@ -621,6 +622,7 @@ allOf:
>                   - qcom,glymur-smmu-500
>                   - qcom,hawi-smmu-500
>                   - qcom,kaanapali-smmu-500
> +                - qcom,maili-smmu-500
>                   - qcom,milos-smmu-500
>                   - qcom,nord-smmu-500
>                   - qcom,qcs615-smmu-500
> 
> ---
> base-commit: 3d5670d672ae08b8c534b7beed6f57c8b44e7b43
> change-id: 20260628-maili-smmu-9ed0f2c189ad
> 
> Best regards,

