Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349360;
	b=zb9gV+3rg2aalND9ZvWXWdcMgpp+QIkusXxzOkcrmEecvHAjqy75ZpVDS0qVzmXU5n4B
	 DjTD2no1eIkgXQCL7eG4gUiuuRd5QxIkUC7xliX8N28VENzks+614RNpknsrN3U3Uq0e2
	 w31OprrkVq0gRgJnPvHp4Da0ohk1qfGhESVb5hequUq6mFv6TX2P2oisatM/R5kT9MDRt
	 jK+NZE0sNkNsi3MNp7ylYxU7mLhdQKAcvF9JNjzr3UNZHABcjapVfZktvqmXaO2Ogcle5
	 fSX6KStv7zr/ma5osEImWVAf6IyjZToUdeIBkpUNRHPCLbpgw+aXHa7FkdIVBsDhi1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349360;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6J7KmcYhp8MGRmEKR/ajQMu5IWDgP6+2nxjcEbK+xzU=;
	b=meOzxoz6eRgIvOFWlEXq30SVC+Am4CCeE0dwAiLkfjDgdeigKMw8+rksCt+YFz1Q6WVv
	 5uSbSx8PTaM2FIl5w2RgJ2YLDOiZoPsCG89Xos+kCBQ+qJUEXa/QWo7g34Dd3tdKoLvMk
	 mkDBdSM1R0O6A3jUnm0+FbixmDmpcuRha65H1Zg+7FbFyVQvkLJYscwRrlgRmKcyydLsB
	 8hQzx3OhGJUHZO3s/yl71Phz91lFEzszQQzsDKGe2GOKpy8aMfku9Dks5YU30OpBnc2he
	 pm/ZgAUGV4iI7D3mgwf3drertTX+oTVPsNWdMT+OIvGPfTQ2voiySopHZCYo9XHlP7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MH7riAKZ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hMni3GQp;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0737660A2616
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 08:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0737660A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MH7riAKZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hMni3GQp
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8FU1Y1663561
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 08:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6J7KmcYhp8MGRmEKR/ajQMu5IWDgP6+2nxjcEbK+xzU=; b=MH7riAKZSiGO2jEj
	XWVxCXJWjvOyDK46m8K/q/ILwUqX9k6gFaLTogXB/2J8GB79vCfCdnesV59nhls9
	L9MrX8TwCcYGAWDMrRXRsrgUfOwHKeWZmyRLd1Aj6JLLzVKD6r2FEMnQdiOpiCu7
	vYTQRXh5WHeDpg0AYvMZM0PVeyb/YKAE2EFzohUHHmLqpGZpYW+xj2WNsZElYPLG
	h/fthvX3S0HPUPOpNSdJJwT3Yyz+ULZaz61AHXj+u6HBZjnDm1ZdhhYCHQ55QoZv
	QB3BjlYVJQo5Q6nAmiL2N9lDmngunpWR+Gl1zbaccZ2A2qdYXzyoZVSMfLX7NSC7
	ge7BHg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p22vj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 08:35:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93ea6b66e53so10119985a.2
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 01:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793349358; x=1793954158; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6J7KmcYhp8MGRmEKR/ajQMu5IWDgP6+2nxjcEbK+xzU=;
        b=hMni3GQpc4wIU/4aH7cNsOgIRuS8YxzKKY5P6zFMI7obOvo30Bcn7ADXWWduEkTOgw
         LX8GA0gbw1y+PwCk+Ypd2mHvW+7RAKGdsfUqAVI3aOCnicko3VyFSgWjjqtuf1gPCuns
         SY77HIq41CDL8CZUCWSlDF+J3yCnmN6YkV+ls3RbeveVR4PlSrBzAioPdDFYfQCGnB6q
         1NTiopAxJU6Xero2PRWUWjWJFpuYkneZs1Cl+PDcpn4jsPUoODUp4lyZGQtSBqCEh+LK
         1z26LuKHU3RK5KUJ/PSXcVvAtukI1S7H0n1cUJRqMGy2Ho7jmiSeHWH8grFhLH/pxLrT
         IDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793349358; x=1793954158;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6J7KmcYhp8MGRmEKR/ajQMu5IWDgP6+2nxjcEbK+xzU=;
        b=Y8L6zPpHB0HQkqscKIZ15FJ324S3MgSVoUagfE2z18L7x0HEemc0eg1FN0B39lLh8G
         9wqcM8thUWNQz61lJg2au12fgYa4Iey8YRfpH15yd3cppmrOF57++tWatgTLPa8JwkZd
         4S/RzZUZ0ftLwXnOrk680DzblNP0ghrP+p6KVnuEcijENY9BRNAeUjwTbRw8oQ5QXOLr
         7tSkXdBjKTFmH4yszMREWuPuY2oeRFklpmZhwYCrS92qWHsDRhMMoyZgixFkx3sVnpC0
         bF+CTPyTKYalo+6Em4uPJYe2u6kzh4OPiuUa/CZ4RwnusFnivQLQfnl7hbteBbK4qqcK
         Zhyg==
X-Forwarded-Encrypted: i=1; AKwUvBw6eUNP8e63s7cB4kfJ7jL47J51CqGrHZM40nkeg4xMQhbXb05wR8/5tDnaC+8ugxY1tZwZ6Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ4lhPu+tUxaH9dE3sD9wQSXGAjOMhuB9cJZgnNgmxq/ir6V9xK
	kmX/alCzYrU5XCJjHnIzar86r0m2ysldo8NwM7hfZpGPfhapqWeA0/1Z2CX9VQgQfxbzzUcpgRL
	nppaJ+qmsFyEYjkPqcYckv8EWlRNIoPUnYhdRb4rSehTb76x4nEJZDSnZzw==
X-Gm-Gg: AYBFou0Ils4QXvPWJvfxg+bkAKq8+YCXSCI/jOImfhtsIfBHrb5PNuO2JNG/bQdUqxk
	7XeMJLlPUO+/U3N8rHk7XqF0rnpsCsQln/BXWTOroAUsL47jh7H6ltrJbxMRJpu0ywQ52JbcQrC
	Hcno1cbZP4CugnYmxWJnnPCNSIBmX2DARGL7PQubXtcmLoVYoGAaBQF8MRNZ3SlTkygxZn6Fr+v
	BTINj3wr9qz8vFpfh+zgMG+ngSrfXD46HliqLGPKAcrxgHIl/2ZG3d+Djc62089FO24ZuNJSm5x
	NwW6K3dbuTLN8IPML359QduOAKEW+EkuKmiColz5qULovnVnrxWRw22sVujAnML6dExC9x0wfyM
	WeD4aMO28J9bTJAGOmCQ76ImXGK7AxvRr/49YEDk7v9ix7ncpWBSaZZOqYprpA8XofWR2vYw=
X-Received: by 2002:a05:620a:870a:20b0:944:127d:f192 with SMTP id af79cd13be357-9442179be1fmr261458185a.5.1793349358229;
        Fri, 30 Oct 2026 01:35:58 -0700 (PDT)
X-Received: by 2002:a05:620a:870a:20b0:944:127d:f192 with SMTP id af79cd13be357-9442179be1fmr261455385a.5.1793349357748;
        Fri, 30 Oct 2026 01:35:57 -0700 (PDT)
Received: from [192.168.226.64] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe0f504sm39083766b.36.2026.10.30.01.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 01:35:56 -0700 (PDT)
Message-ID: <dc2c51b8-41cc-4abd-b52f-ef2072593d1e@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 09:35:55 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/msm: Use identity domain for GPU and display
To: Rob Clark <robin.clark@oss.qualcomm.com>, iommu@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20261029212344.346069-1-robin.clark@oss.qualcomm.com>
 <20261029212344.346069-3-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261029212344.346069-3-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzNCBTYWx0ZWRfX9pAOHUEpMULb
 kW7E9wRBp0AcJcSBPVBdOln4G3HFCugqC6rUTvXO9pkSZBb2THsxf6s1hhL+eAvRjIpH+8flM2W
 GKSVLBUBDVbpgLScGJS1Iqj6v2jfFqnrANBbpysbep9M45aCyHM8PJc8aHMa2Q/nFgeP7tz+rSP
 VBC+Uo0HdxpC1Fg6O0+BEYLZvqY4ri1qF9hzag1S5hmdCvr3za/05TgFJSOA1ZVRIRPTw2QViUH
 iyjDkWtmsMUQo2IQ+B7hsFV5QoT2zhqThuZQCasmEs+E3HpTvJou88xLYRc22pgHebIytTJ+3sb
 mTR95TkFGDRRSI50jnoJP2vSSO0DzhTdyosfjvyd4dTpUTX7VRvjEbai0CKuCokHCGDCTIQ2hoD
 AspCcDtktI4uCOC/3w0HU6vrtZm0wmHDTx+Q9WvFMXyRUPgFvQyj/v9dM0iWhw/Yxrjw4FUDVAD
 A3BZqiufb0SxZcGV9Ng==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzNCBTYWx0ZWRfX09T9E11rwM6f
 mHabAyI1sKAs8XHSCgYSfi8M9qTyCqp1AiVwsnLFR9jmrhVsXSkzVnhQL1nD5tkV1UVr1ZdUHCc
 sqniGeJG5UKaQlolL3YUiOM65TfNJg4=
X-Proofpoint-ORIG-GUID: DjdY8SUiOUDpgbWju0z_DINaROksOyqJ
X-Proofpoint-GUID: DjdY8SUiOUDpgbWju0z_DINaROksOyqJ
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae456ee cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=nPYanoZRiyYWTCGofB4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300034

On 10/29/26 10:23 PM, Rob Clark wrote:
> Similar to commit 0e764a01015d ("iommu/arm-smmu: Allow client devices to
> select direct mapping") for arm-smmu-qcom, match GPU and display compat
> strings to pick identity domain time.
> 
> The drm/msm driver attaches it's own domain, which it manages directly,
> so we don't want an iommu managed domain interfering.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
