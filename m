Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93AB44CAFB
	for <iommu@lists.linux.dev>; Fri, 31 Jul 2026 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519157; cv=none; b=Aw9pvgDpWlfm85Y/Dv4A8Kd8DEJBX/Z5WSCRVnehhvRhusJMuqYSurm1AM0QZW63gTse0Gqp9Jy8Pbxzk2CS5+I8P5cnLGpoBvzJ9u9v8Y9+9zjomd6TcWWD2J5Yx5n7yxJAZcjPke+n7HvsJKB2DuVrQRuxFEGzcDyotH8ovc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519157; c=relaxed/simple;
	bh=lfiBaO5QGv6Lp1bhosrvX2pSIoKoq68SwookOCaMwlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0AnoWH00Knvi8kv1AaoLE1BYoRyxc3hfWJDAzcj1olcjKwVQfu75Dvy+WuOnNScy6ZL4jeOsAsYTbnZBAEkmtEqbUdT9+iSfNf1X1WeOc0fFUf0KQmpcLi1scmhRYT6x0qtEJ+SF65EqDDxxKl6fb/wi4jsxbZr0euL3JaX77c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W7Dae6mM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jLOYqyGo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W7Dae6mM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jLOYqyGo"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFONiT205390
	for <iommu@lists.linux.dev>; Fri, 31 Jul 2026 17:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6vGxhq2ex9tSeI+6MBOrQmpyMTBbgvQgQ2jOrma0YmM=; b=W7Dae6mMd7B8Xguk
	RCs7+k4O+sXWGrgAjIAxLuiBo49HuLHLBYsdc9Mov4Y9fYHnomOHeYJsEi8XRtF3
	R6azAPpoZ0OAn/JADMMSgIW2njDK0rDZFjyPR/c8iCZ3YsufHCD7apznH0e9BCC1
	fahzVxEUYFW7Zdz+5zotT9gfC1Auhzg+WQn2iTsnoCDk3xCxZtRCWnBkD4fSvHLS
	K6rj3oU4HNil3NzJx7VhcxPquWx9OHakelvmUtIYFm4jQRVak+arQGqvyrYmtXEf
	qMkzBaKqF0bM1NT3GjxenOXjWRHU8yTEVu3qyvZZgeFqpc4U+YoY/BVy5QRHktFw
	T6TQeg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru5dhn55-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 31 Jul 2026 17:32:34 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c07313be5so1873151cf.2
        for <iommu@lists.linux.dev>; Fri, 31 Jul 2026 10:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785519154; x=1786123954; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6vGxhq2ex9tSeI+6MBOrQmpyMTBbgvQgQ2jOrma0YmM=;
        b=jLOYqyGo3nuvx+y2/bqN7zGm+eofMun55g71IO8VTWUAwkNZfVYUjq67a5ulzUaRI3
         SmG+auSTSqcKNuhQwS8ICidEd4wa9cChkz9Wia9UbBCAZFljPkOT+vMl036UZ3mpIq15
         dhr/xmTrbioRgOaK4KfLjfaHaFherHnMdniU3mx/zDZwHb8ZBSI/fs8mgZhpSBa1peea
         fcJcq841+6urd58yHQpo7rKHzWe4IFF1NmWKlNWwGjXG0i5ykgqivfQdYzhTcuJJ3HKx
         6iyRyb7CbKIsQFTfIhe1eXjCwk+wGXLaxy+b59RUmDO0W7t33Qix+/DmMEdWpQVkKYyS
         4jGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785519154; x=1786123954;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6vGxhq2ex9tSeI+6MBOrQmpyMTBbgvQgQ2jOrma0YmM=;
        b=rBWoBx+wtfkIWsCgoYtupjywdXsV0Y1uIVIpKwzn7A107YJBgCdGPYXoWNLI65cdSr
         EkghJMwzJzXYsuxZQF+taloZo96cYU6+ZAzPMqpi51DsqTf+tEoc0jPxYGiZwQIddzuy
         rkDSpK7T/1NFTBfuokIaMvl7iq+DQR/38usz63ZE2vMJFJ1i4U+MLR3odXcc8KHYwO3J
         Uv4J1QYUHkBZxPFM7isCN5MU+ao9ndK0Eh9qRA3HVAVHqo6mb3WGYH+agFKas63GwMFt
         7FRPWvrXqe33EFTQfEe4Whj3Q/EI0lMq2Xis8bufXOZ80Qb5hJiaZzi7g9ywTXzPfhvU
         48kg==
X-Forwarded-Encrypted: i=1; AHgh+RpBlrYKkd8l7l/66h3dSlmMkMNhQVh0snq6KAVxBfomHw9PVhVjy5/3QbxHuOubOcpHdl46NQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMa2RvQFayqmDVg1m7x4tGTslE+KzmbODt9kxDDWasxLD9I4rU
	sefd00OR7VqTdRbFvpHwyDxFpqWWNObTB7VbXRZZK4qNvx8M0XswjOIvTGl6W51euxJfIQKSAJ9
	hXYWW2NmSmYLJmuIlLxAeBJDI1qc26G1AXCIxhGMvP5CyC9Gq72TmqF0nDA==
X-Gm-Gg: AR+sD133TEwEbnWDuBM30wKS5LXEQ169QkmzpP7dK4EnAMbJc0biCnzIALCiM6KzPeQ
	5aUCu2a0mMqhZLj71gyb8Zv7KiL8CsSB1riOug+r7u6FoFDJQWzBpacOfShhHK1vqGAjnE6UQV1
	mUYHllhmnxBJ0cUxUnQR2n0aBZ6AwAQvjf5I56yZgqD6aDHhc8I/N0LJE8s9osa9C8MBWxET3m+
	J4yzIxW85qGJIRUiw8HcvTsxs2Upe/XROyVkEgj/uq0yivpibJbjpyfL8knmM1ubhaoWPf21ziP
	m7RLJaAWYgpwSNxXvRwByxo1dGHaD+HaY6Xw/pn/xkX4z6CvYfCZ5wPMiTbayyoiU/7ht0MKyhV
	PMRpce4WSLLWWRibc3fT7Qnwa
X-Received: by 2002:a05:622a:e09b:20b0:52b:4ec6:52c1 with SMTP id d75a77b69052e-52b567c681fmr11518581cf.3.1785519154205;
        Fri, 31 Jul 2026 10:32:34 -0700 (PDT)
X-Received: by 2002:a05:622a:e09b:20b0:52b:4ec6:52c1 with SMTP id d75a77b69052e-52b567c681fmr11518191cf.3.1785519153665;
        Fri, 31 Jul 2026 10:32:33 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd4454321sm210966466b.31.2026.07.31.10.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 10:32:32 -0700 (PDT)
Message-ID: <7cb43d04-30b5-4c92-9ece-43847a166e0b@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 19:32:29 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/14] media: iris: Add support for glymur platform
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, Daniel J Blueman <daniel@quora.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
References: <20260726-glymur-v10-0-de451559e88b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260726-glymur-v10-0-de451559e88b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: p40zof1kVuUKFKbHrPQQ0Q-dpnr10hNR
X-Proofpoint-GUID: p40zof1kVuUKFKbHrPQQ0Q-dpnr10hNR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzNCBTYWx0ZWRfXxo5mQvQvA9ok
 e2ldQACMSwghfUMNLTTwa0bQFQAsLWTh4gJ2HP+G1/3axVX6uXqH7Q0VBMhAvd2qaV5FU8Lb8dj
 L6C8osu4O76vhQg9ol9KqAxBBh0WEKtOSCJUFZQwRUKiFcvLXTC70JuuEYZN/1gcC97w6GQj9Ee
 XBqSoOOp+1O3JNOrOf+ZRir55TnT/MhPDRNh+WNkISNOIpsSc3Qkukc/i5SLViVeXohyROnYUU2
 g+rrAc0XKHCJKCPsURYrbk1bq0GBaP3Fo8yFZJa7y5RTZil/hEaQ7vzJxGDRPNzntIyp6VLw1po
 auNbwYmos/pCIkgxQTmZfrrtN35Neqp9Hq9OikvTP2RuDclzBziPCKp6ji5drBbf8ygSJbX6rwB
 3O5U3CDyvmZzIuJT/QlP29AdmTH13PiLG5+2EPvMCQlLTvy+d924p/bsZbiCsopfbx0DRg1Cmaz
 ZTZXGYak2hLtOFPuhYQ==
X-Authority-Analysis: v=2.4 cv=SKZykuvH c=1 sm=1 tr=0 ts=6a6cdc32 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4jJV9Or6y_G4DHxeOVoA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzNCBTYWx0ZWRfX4Aq1gJEdvEW9
 YiEDQIun2D48dyIaOl33IDzDj/9gMoRuEY1dL7hfH/zOG55Oez+kABQRtviJcMnNta8CsoE7ELv
 wQTJrv7Y5dO3X36Wqqe19NJFVCAYoP8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310134

On 7/26/26 7:49 AM, Vishnu Reddy wrote:
> Glymur is a new generation video codec that supports dual hardware cores
> along with additional power domains and clocks.
> This series adds platform specific support in the iris driver to handle
> the extra cores, power domains, and clock requirements introduced by
> glymur. Add support for firmware loading through context bank firmware
> device.
> The sub node approach for representing the context banks (non-pixel,
> pixel and firmware) was discussed here:
> https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org/
> Following that discussion, an RFC series migrating some existing iris
> targets to this sub node approach was posted here:
> https://lore.kernel.org/all/20260709-vpu_iommu_iova_handling-v1-0-72bb62cb2dfd@oss.qualcomm.com/
> This glymur series also adopts the same sub node approach.

FWIW this doesn't apply on next-20260731, conflicting with 
the change made to iris_probe() in:

412a2e5955e0 ("media: iris: Add Gen2 firmware autodetect and fallback")

the following patches also conflict

Konrad
