Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E68B423A9E
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078580; cv=none; b=FGHm/pmO02Y51C0zFNRsLNmeiE0E3QmzRkCbGyVFxBPNbf998EHdRJ5zcmh9HiM/ku3tpFZb7aFURJzrKTKdliRWUqorSA5o50NV89VyKw0n8HTX2nAHodmFwCysSeuSyQ/BmN1nnG1Ku40JkJ/G0X1zaR3p/CMhqBAUb6zhoOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078580; c=relaxed/simple;
	bh=7xdBxUBZ3lcN5J3YExFEy/pYiR+GDtAc2KfJFebVAlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+QEf4n7LSej30SbPo8n6dSD3yZlWvl4z0Qq3CeQJGmcWsXXlcfEuVecwd+K4DgbeacJ+A9RtgmfoFYvj5CAlhcMAtjUMAjcyjtKUKUmBwNAfyQIo+0KCYzQOfz61Cud+OEKMmXW4IWWZ2viP1wlFPPRIjVjYau2XqRTdg4weOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MfTmOtAX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jsMX9hKY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MfTmOtAX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jsMX9hKY"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646A3Z551953203
	for <iommu@lists.linux.dev>; Wed, 6 May 2026 14:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UyV+NsfUbKRpPF/fp/3F8J5Jj8lRx18O6qDLkdl/xpI=; b=MfTmOtAXC8Ic6Ykf
	j/xClSdgcYtwkN36SXrm2olPyJXKIZLSnsmA9P5iWHLYpe8gkgC13UvDJIuxJFbp
	kgXjegjKGXC5kvB140BaMj60aJJKMFuh78B13koLPviQVa2vt7mry3XXR758Mdvp
	Fj9lE2HNta44qz/tmYA8q2wSEiAFzpanxa5NMGaHKTxPAp0FLh9BwORGhPnqFK1C
	1wLtNXzlHfGchTvr/0ybbO203pV5FFvTIBG7zB5qSLAekfsIBDVosacQnvWYNu/w
	RQnHmW5O8V3dR4zsVXwuRun0J9ILKY/VIxDrkEOI4docvkI7h4+YEja2C+BuHxYa
	7hVw8A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e03jc101j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 06 May 2026 14:42:54 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b4654f9bb6so67186105ad.2
        for <iommu@lists.linux.dev>; Wed, 06 May 2026 07:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778078573; x=1778683373; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UyV+NsfUbKRpPF/fp/3F8J5Jj8lRx18O6qDLkdl/xpI=;
        b=jsMX9hKY3qf1bmulB1sq8AmcoEUa/OpwSTeLCvQCAJRzYJxexC2DBpEqF/1ht7XUq+
         SEy11q1JVbQ4bKMJdmUsBZoovz43mu8bzpF276LMKmrVVLUjkyvPg0kcPnX+vp6SOjcI
         hKckrUnCeukutZUkkTEpty5DWZA9ku9AX2LnLRx6Zh+uBRf4wWTotBKdoyc7B0DVR6br
         /WLt0VcjdF+BO0w0apmI8AEzpguS/cAawS70aZPI1D9BD9VAUhATy64lUeAL2XXfNL2B
         O0xlw1NTicWjcBW2vJsIMrqJo2kovhYebMwpXZb/9+0j6/fGNQrREmw8Lry/Pt1hYJfC
         fTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778078573; x=1778683373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UyV+NsfUbKRpPF/fp/3F8J5Jj8lRx18O6qDLkdl/xpI=;
        b=D3m9mrinzTv17ELkgEGfPEDSl8ftapk+SfEAz+wIUcNIlBh3XWSIHUE4Yz4uM1ToR4
         3m+0PF32DQ7Ny0Vqeyp+AQr0ZP6yxwW++2gRE81m9g9TZB2FYYFqct1d9gaA/t2aUVbu
         g5y5UdlEh1j9LCyxJKsGslepbXKO2eBZNqXcEgrZ0KZHc7z5TniVQF2BsejFvCNQfbRj
         nVttn17coAD3kkIsAU5rETPNIIvaiix+PzozGWncsMZ+DBvxSXKUg66uKK104+ZYCzYs
         /QgmZhERFxGvZ4YIO7p1PnNbQotfnb/H37pVfmDP7gj/a7IRDANW3AQoUKGge9aiSQnD
         eqeg==
X-Forwarded-Encrypted: i=1; AFNElJ+PoqF+Eszy0nMELg4d9nPRGmq/+Ik+qScxsFJfxLgzaFdC++MAg3/Yr+J+Uk4esR9+9MsNPw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7kE/zYst0CKD4jUgCr+d6lbGzYx5eP4144Dao2H6Cg+w7xYxp
	rIYsAZ1qs9TISQR4GC4X/B7hhBITUuixXxYlKH/DAi37gvdDplHVWYVoER3m8eqq6IgBr2Gvx7B
	D1/6idmWDfD0CPO+6FKBnxlLnJwdmWtU+o1q0pqAGmjtb1otrjP9vD2Kp1A==
X-Gm-Gg: AeBDiet2TG+JWszdsUKUzifYdB+mLzTvhNELGQ99uO7kBfUcJTaEqjgYAoNTAujY4xE
	vjv3vxAB4ZKfFci2fgNkC31Oxg54HmH36zfXzE19w1ypYRT0fTwcVknokdRE6PoBbR3nAL7leI+
	sMCD3VxTh5WhjFkFNx7waQoBqEiV2PZpxziNr/POODF7d/oulcL0bXc5HdCO6dUkjZWvHE2OeWD
	YbHLhLahnkmpGRqFVLo1y71pncjNaeSGC/8wF63YTr7SUzZWsKa3ZEkOLN/Ff+RE8LhUnsSnkWC
	++tXpEbAI+8aERgBNXnd3kKuV4ouiWdjzuq+KMeUoUa6zqbUZEhwoFx8jIKLkWcV6q3AunxjI6J
	t2ShT20kcgl+8OQeyMIuOpajp7oFWp/cWhDeRYLPDNnnD8jf0wiSJhmeDR6ClOTJJ
X-Received: by 2002:a17:903:187:b0:2b9:fb9a:1103 with SMTP id d9443c01a7336-2ba79ad08e6mr40451895ad.38.1778078573435;
        Wed, 06 May 2026 07:42:53 -0700 (PDT)
X-Received: by 2002:a17:903:187:b0:2b9:fb9a:1103 with SMTP id d9443c01a7336-2ba79ad08e6mr40451375ad.38.1778078572916;
        Wed, 06 May 2026 07:42:52 -0700 (PDT)
Received: from [10.204.101.47] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7bf2c6c1sm27899755ad.21.2026.05.06.07.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 07:42:52 -0700 (PDT)
Message-ID: <b24018b8-8c28-42fc-82da-7b26d3175ed6@oss.qualcomm.com>
Date: Wed, 6 May 2026 20:12:44 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/13] media: iris: Rename clock and power domain
 macros to use vcodec prefix
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev
References: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
 <20260505-glymur-v4-8-17571dbd1caa@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260505-glymur-v4-8-17571dbd1caa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE0NSBTYWx0ZWRfXw3cFnFX8n7Ey
 q77Fwd8diwQrgS/Wcz3QZGAFVhnn2JT1tR7LM6nxFWIiBmN1gWrG+gxvpmeN3FeIoTGQoaEdBAk
 mO4lDAIVBwog6QMQx87bglJCP/ZkQN0z2L2dvYKBJuTLXN+7z6PGuVSsBNS9MkuW6wmIry9+7bF
 bIu1CMzXzyQP0f7wPf8jCcvY1SSh1GDpoMt4Cp15yl8PqpfomdtdIMBSJvJ0wVXwMutiwUXUlEZ
 gFKeR6yEpadp4RCMjVYnmSaKZb6vJNlzoGDGhKMu/w9FydYgsDq4WumjRQye0/MG59fZGlqGgpY
 h1s01QKxMc/ZhJt8Onl2bhvKrN3P29UvVj6ctBFfluVmabcb19Ze2NTL48TO4kUzy12V6pogmy6
 HkeVWU/h1U51YqtmchsEw75e7v17lOx6RyRZ32OuL/QlZose2T9RFSbyAzkFnL7YWZSVtwyptUX
 ORiws1Z4AtVKpPRxr2Q==
X-Proofpoint-ORIG-GUID: 0c1OIVqKr6NmyViTkk6QZnYea72WPPBf
X-Proofpoint-GUID: 0c1OIVqKr6NmyViTkk6QZnYea72WPPBf
X-Authority-Analysis: v=2.4 cv=EpHiaycA c=1 sm=1 tr=0 ts=69fb536e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=XbLICjIVyITgExBpphIA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060145



On 5/5/2026 12:29 PM, Vishnu Reddy wrote:
> The current clock and power domain enum names are too generic. Rename
> them with a vcodec prefix to make the names more meaningful and to easily
> accommodate vcodec1 enums for the secondary core for glymur platform.
> 
> No functional changes intended.
> 
> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> ---

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
