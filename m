Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E3B224AFA
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783624427; cv=none; b=lI1vLzr1/yvdKm9DcuxH8KIj/5UEg4KbGjpH6EA6dQdvE54/8oDb+NoMgXXqofWkkW8laGn901FdWGXhX0qkhL1RGXum4CrbFBDz0gQer7+i9ITSSz80A9eu5UX/K08Z8TdBrgvF7T42NQJKGCcfPQiicdA76ekHmSwl4GhObDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783624427; c=relaxed/simple;
	bh=BUKK0ZC2pEiS4Dm4MMXPIkIVgQy8fsNEZuYUy1kPR0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E9xhMWohX/LPkusGr5DgctK9OLSjFZ1DxY/8WOTse4sJUCtQIOf1MADO7hFp37Hhh1/6p/tWRgo/IMxb/khhOdh8C0P9URK+mFzYHItPBM+la0I2h8NgEjDojXqIYQ77v9LFQPDJ7sc5pqbqjZAOM4e0AbI4A0qZ8u+nv1Zd86Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KNheesOf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OW0PY398; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KNheesOf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OW0PY398"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669HXiqC2474036
	for <iommu@lists.linux.dev>; Thu, 9 Jul 2026 19:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ukg8K27ZNplR+yNjefMWINfSHgjifpE3C2eq9F7iWjM=; b=KNheesOfomsVUduc
	CcvE8SZac96fJwdfD/TF5VQoEEcRgWj7I7Frf00hqvY9YqdBKm+Q4GHzmND/guqL
	btUvlew9kmRNw+mfAP2J5jKDtmluhG7B4jpcDaecLJDHLua6GQA6kXhzFr+ldrb5
	jq0mhLmSnUMZWsb9Obz8avq6lEubhe6hzOH4+7RJzLx85w70UhKvzl6DAzRxb0So
	b/XFXEOcEn+TUYyz7rsBbLtMnbUfuTClcpfLx7lfS6duopKQc1jj+ivBPNAwOUCh
	ZWXzokrJCv4KqAa8umDnUVMD6E43C8+9lcMn7+xCHPtCFduKmq8bbtZE1nNfKuRt
	Jz7J5Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4facqphmfp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 19:13:44 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-901fdbfc3abso1141256d6.3
        for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 12:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783624424; x=1784229224; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ukg8K27ZNplR+yNjefMWINfSHgjifpE3C2eq9F7iWjM=;
        b=OW0PY398tACgFsyGAo64RlXZCrgmu6K+NL68EVFoDwReILkST1ZRadoNMPpisJfnhz
         xsF86MYUyPiOazO0u97y+/PxXnJt7F2q/0TlFFxQ/DTqi654jTszD43WuKG8Axf+CWMa
         KjUG0XuBYdQIzXJT7LMrJPCdX4pomsmxLZdATHc9epXaMdiU5hxYZtHGlpfahpxh9wTJ
         /R41woqPWcgzHlFc+tdnBK8bEUj2IiG8aQz+dK+uracbWWvI8CHE5rEu3zQwTOu/N4zg
         tQJ+Z0ztXcNV1aI6pfPjeYNXA3dbCaHRDzxSuOtofiIIdpg+39ahjQJ4H9yy7GneHp96
         5SQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783624424; x=1784229224;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ukg8K27ZNplR+yNjefMWINfSHgjifpE3C2eq9F7iWjM=;
        b=kbvRsNHWtIBJHYtHGxBY245X99a19lHD14ycXiL7ChbJmUJrQ1OvGoqYZjtHUawdeU
         CX6Bgytuti8ogdXaf4CmT4MBSzX+i0kUH3nnSik6jFLgy4dyGSb4gF5up9Y/oe1T7k2q
         47gL76O/fwEWsSskAKoJA+C9MQXFK9uKbPcfcENO8tCZc+QGu4Pzxm23BF88OGhqEikn
         MogOKP4gPUwHXKcpU5koExXbsFUJ/D1U7Rc8J/Dyr3AjqPKjQdd90bZVxQbOFIlSapga
         DKLdZLzlrtPDzBo7iv+bPgbepAw9sVgBGqeAr6mTZjO/xWCoMh7nVPXRwQzaOR+Px5j6
         lxiQ==
X-Forwarded-Encrypted: i=1; AHgh+RqhQsOB91talSoQhUt5MFYiyrhtcQPcEIBTY6cu3OtklO3zwso4Su1zlAd50LJ2zvh1CKoLOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJcPVhkTX/pTDHY1Zp11i62qhNCIESzu0Q8fJlb/DNIewKf7eG
	mmQ0eT4B89/snyulHoN6MkTJOY4GGYblGTZ2daea4m+FXdbsCf34xur3EKWLps0M02yvbxikZDt
	kKmn2Y+9w1LBEDm4fm2DppbrEK8LgJ1veNtkBAVsosXSMRjZovJl5bMp63g==
X-Gm-Gg: AfdE7clr8NoqMcITQSQpoIK1sHeD8tDzpRjohqgOnp6CzKaemmQhubLywSituYCzSCO
	4uz7hCWhhHHm10FAM2TkXyMTTMSPcZCb7X20z4Aop02cScRzptqRkzpNJxBOLvzDBubmGDJuml1
	+HF4xo15kgq4Wc90gt6tjaSAhxjT2JwN2vZ4bL/pWKZ24DJSEKq5Qrd7t4eR9N3NpuZK493c3Nz
	/ME4kCJak38N3oA2YcTbBN0evsHys/PbXUjovy1jw98qosG4YwuMuBiu+jzK5oZyCzSmFLBHm+a
	Sibl0DgKZD0Dd1sOOTu7CcNGk672OVWNzDDpKZswh7f3UIw6lWubg847zYLh1K9JNZnTQlyQ0xb
	YKZINIHatc6+ILB7ILF1jmdxhjTakYhPhtOI=
X-Received: by 2002:a05:6214:529c:b0:8eb:1061:552c with SMTP id 6a1803df08f44-8ff941c2fc6mr52515876d6.5.1783624424239;
        Thu, 09 Jul 2026 12:13:44 -0700 (PDT)
X-Received: by 2002:a05:6214:529c:b0:8eb:1061:552c with SMTP id 6a1803df08f44-8ff941c2fc6mr52515356d6.5.1783624423732;
        Thu, 09 Jul 2026 12:13:43 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69c14972fc7sm595785a12.22.2026.07.09.12.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 12:13:42 -0700 (PDT)
Message-ID: <88edd673-1220-43ca-805f-675890be0cfc@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 21:13:37 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/7] arm64: dts: qcom: shikra: Add GPU cooling
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Aastha Pandey <aastha.pandey@oss.qualcomm.com>
References: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
 <20260710-shikra-gpu-v6-6-b388ec5dce77@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260710-shikra-gpu-v6-6-b388ec5dce77@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4OSBTYWx0ZWRfX953l38reeUS5
 Nb3ociak8OvTwj/v+RiE9Ej24mfiVyMISaSSgqmCXsHVeXEQcWV/+jiIu6HWfzD7XynC7KHaLU7
 vy0tVlA1XvnExKFCyVzumIHxyWaPAEatNH1JeB/mm/CK5yoRgEyIN1hMiqaDmn2ADpxwF7ie7FM
 +Q0wdSZPj5RnhmoFGWTm0p1nSl3pPbBnATJBxiFhBRJeuQ1dc/J8isTyJpXPvezcDkdJXAjpr4r
 FIgKoCt+nJg7iouW/s3cKYwod3S4iQxQ4RKyqR3xDY1qLZi7B3SNQ5QdyzUlVgF2ErSXuRsYLjH
 zC56YeEZGSlyRmA/c5M6Ybbr385eDztUN7an5mfBuDHCBoWWzN9+8HraNNpjdjjSseLd7eHNmgW
 SQzPZ0Td5mH2c/4bd/efjx7Xkt5kMmC2ItgeYeyt3sw65RP0lTO+vXEpNCDZV+WwUYxRiI5J9W/
 /SxYD4m+cim2my3lAoA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4OSBTYWx0ZWRfX+4aQp/ukepOD
 9y4FPHddCDKicBvqkmF8fvCMQAmQ3o3I4045Xlx3N3NqWu4mATZR5whG4eQLHtmVgH1fM0JAnwj
 r9a6QR7GwGyHyEVlOP+ES+H26j+BQJ8=
X-Proofpoint-GUID: W6ZDn5mArm47Q7I6jkAUWE6moxGs8-ho
X-Proofpoint-ORIG-GUID: W6ZDn5mArm47Q7I6jkAUWE6moxGs8-ho
X-Authority-Analysis: v=2.4 cv=GJ441ONK c=1 sm=1 tr=0 ts=6a4ff2e8 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=QDjCMyA0A8yHJihhU1wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090189

On 7/9/26 8:42 PM, Akhil P Oommen wrote:
> From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> 
> Unlike the CPU, the GPU does not throttle its speed automatically when it
> reaches high temperatures. Set up GPU cooling by throttling the GPU speed
> when reaching 115°C.
> 
> Without passive_delay, the governor fires only on trip crossing
> interrupts. Temperature stabilizing between two trips generates no
> interrupt, so not all cooling levels are applied. Set passive_delay to
> enable periodic polling to ensure all cooling levels are applied.
> 
> Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
