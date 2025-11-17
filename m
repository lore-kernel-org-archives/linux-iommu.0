Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426E6334371
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763387588; cv=none; b=FK9JIHdBpK7yuvrkccInuqpO04aCIeP3YXBHPIdWichvRr7PC4lgtPjHOP5EazacvLmx3YpJsKbcd2qamqTH2rEBzZdUbBuR0zhvQ9Mc6HY3dI1mDM8rePVzWVHclNMviBNn4Yv7jPFcRHhtZHzTteplVwoSKgbnl/wff0cD5QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763387588; c=relaxed/simple;
	bh=CksVbEKpF9SAjJut1xXJbBDF9TPaRuhoGlNshSKhwtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSdrc0QKzsvq5V/k2Anz+ZQgqUMRdaiP7t6GFCn21fNnzjng3pZv/WXLkD4UDfWxrqm6UqvTy7mwtcRZ2zXDsN6HeIgqslySSjRoALc5wwX7u1OFTDSgfIHP9o+qvkQXA/ctGsiZZpqBuSeMv9kWaw2l/YM9SoNt0LwNvzkcr4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mFtFuGK1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fqq3kZp8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mFtFuGK1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fqq3kZp8"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AHB3Wxm3517167
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 13:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Yi+BdGPgnrk+oNWxD1uiFb+dRMmL82ThS7ds7IVksSw=; b=mFtFuGK1MCuVmr12
	f9haVzaVKOz32O1RSgy/Q2GSQLp0IWB6W1rgvDBTRR86RSit5e/+gL7U9Xf4xY8P
	PpvZb8gQE910myLphQRL2OWHai4slaABAa+akYYX6cdEGm0iZinbzoeouP3lFqwB
	FiE7ADx79zOF4EWoLQio/1MMQ/F9Ipft88DUbf8M2q+dpOgrluXfim46yIfXD+Vl
	LGgURcg40mLjKu/qRRbcCHsAuhQRpz/dcSqa8Vl0cBZ6skK2SqI7rHe9TqHvZr9m
	RYZdThUlTtssyPSjrI4YTIolsb6e73tn3hD+UU+sLtYBVCq7O/CxnI8efXt0ataz
	og8aZw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag2gg8eus-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 13:53:04 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed767bf637so4326821cf.1
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 05:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763387583; x=1763992383; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yi+BdGPgnrk+oNWxD1uiFb+dRMmL82ThS7ds7IVksSw=;
        b=fqq3kZp8Mv/jgmsESNJDuFwdA1zJhxpbHSNO4LdwmhjMlYRXYoWSTA6o1j4xPmXdfV
         ya3GtpuMRt6UkyFKR7QElGJMZi7g6fQgdX3iMgAzpyA2jG024hBBe69l7OHO2/Y1UkgC
         zObSMPC9B4ozjK/66o1vIZf1P80mnwNrTJFVmIN73Ji2g5xy3BTrRS7phQzcedMxkQRB
         atuW07Px4Ws1vN52+9jKxAZ0T50rt2bRKsuNwlwTtXDPbtxrVZyJS5DPklrU0DfKgPXd
         f/+UQsguJgZhwKIra46UYQ+BRODAZyty+BS/XluOCkjt3ZKQdW5a/SglnDmzF3uCz0iJ
         bJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763387583; x=1763992383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yi+BdGPgnrk+oNWxD1uiFb+dRMmL82ThS7ds7IVksSw=;
        b=pm4HjN87+rHJBwG77A3elmEc0uqIUtCSqwe9m6mEoXtd9xezVrWf9M04NpQVYHo1UV
         IrBbtYF3wNPqddBaBjD7xGonck7keiiNoy3rmlMd6+n1ZzCus3UECqGYrp4pK3KPEM6i
         /Vi/H0pMsWgSGc0wdKoxt3A9Jddvqz/0qfywB4K3pqtztJKkzTbtNYdl1dri+UeYKb6R
         QGJh4zsPI1eixO61ZEwnFFzz9MeT7kIdkzVnhwoLGiOB9KBLPzSAgzINAkYCZEY8xuiL
         6DA3Jz1CcB3LjgVmdI3DDvfXMXvqY7k/u6SFrDVsizLJajWUk4xWeYWrCM/5lqjiQQ5N
         6D6A==
X-Forwarded-Encrypted: i=1; AJvYcCX0/QQofK9FW2brplItjqK1Oat6GpzNBCzGYK/f1U133ymu0ES2FWxurcNGQ0wOBaIPMgy33w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSWPSPbQyUvGXOZfMLhQidmEwsMAnCvBC6bAHpA6xjSJ1czHTZ
	NjOQIyYaLTODcjmzFJx/Cj6OqgpnGU1u3J0+GTZNQM0NLoUIKFkNPLtp+XGtyoX85rA332GBAZc
	h3D2lChNvmLmQjlNsKay57er1LGh3Fl5TdLcZ40m931gpxKVUCgEaXsiQiQ==
X-Gm-Gg: ASbGncuFDGrvjV7YJeeI7wJydEWoiixfbeXW6bK+Dd5KisxiqYw+lDT09w4APj+p7qY
	Q6sdFvMkBSu9+uzDrS/AvOuMVLSLnNO7oqWwu3nLybgV/Z15L+6ez/0kU8yiWwEPc3a3frFK3rX
	ZqJXl0ukf2hyEmFVtTkjppoHqCZV28FRcmReD+Esh2UePjqAsBXqQvvLMjCE9QTgnSiPVtI2CrN
	zpj2Ir215DO3Iee60MjWIIfRr2irivEMrOsqnXAKGgBv637tw1DDW5cXbkkXNB/bMljcx+Q5uwS
	4qKVvwdB69npSNJzgYAjuuy97N5n/gr6oZ+dflSUrrBZ/j2+iJhu1kI+BOQbTF/EVZ3u/MCHRyR
	+dYkvaTaEEvZgig3QSlxUaOCFSZdhqSDMVHhIpPlSCR+3q6NuEtArnD6k
X-Received: by 2002:ac8:6f08:0:b0:4ee:1063:d0f3 with SMTP id d75a77b69052e-4ee1063d7d8mr73608621cf.11.1763387583355;
        Mon, 17 Nov 2025 05:53:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFP6/ieJt0wbfNJVaOx0h7m7+0k3hS0h1MhOub3nCOiBuEQbZ7V+KAM8rQUI0q8j+iY7BfrDw==
X-Received: by 2002:ac8:6f08:0:b0:4ee:1063:d0f3 with SMTP id d75a77b69052e-4ee1063d7d8mr73608341cf.11.1763387582843;
        Mon, 17 Nov 2025 05:53:02 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fad43dfsm1089481766b.20.2025.11.17.05.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 05:53:02 -0800 (PST)
Message-ID: <73c3de56-5c60-492f-8b1a-209b5b06e7e1@oss.qualcomm.com>
Date: Mon, 17 Nov 2025 14:52:58 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/20] drm/msm/a6xx: Fix the gemnoc workaround
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse
 <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20251114-kaana-gpu-support-v3-0-92300c7ec8ff@oss.qualcomm.com>
 <20251114-kaana-gpu-support-v3-2-92300c7ec8ff@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251114-kaana-gpu-support-v3-2-92300c7ec8ff@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ybHetuWqRbqcne_vPJHYWMcjoWyckbOn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDExOCBTYWx0ZWRfXwUEf9Q5n80w2
 /2a4Kr3pDMhTJh6U9odTuyqHzCKuIeuWJYpONm7GC/BDDx6i7ITdBuebuVNgZNfTnDKDlB5/ggk
 tg3OOGDG8eLJHL3rVl/z62dMJGr5KIiRq1YfTcOm5gd3zxdbiBqRPMooZGBTZFCR6npDsuDyULj
 mpVmvSFbjcrlAuy8y0YV/eu/7C1tfwjgZMz6WvRIimBkp2njhUbFL2HwaDdnT8nSEyWGaSkLukw
 9cRgxxEy2kTqzUYsu9XvHQrsUG2fkBG+SZU7+fqdlYKpPAs1HFLz3ehGNL5czCt+MP0TldB8RLK
 ifrSw0mFWJFcxp37hVEZyf06jaKFE100BBFJUpF7y+QjUV8aDBNbAavZWdjKgZh/xPFHAD6ff9G
 4kcNmcYAqdrPIHOcMXMLWJPS4qGzCg==
X-Authority-Analysis: v=2.4 cv=Cryys34D c=1 sm=1 tr=0 ts=691b28c0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=ws8SwQwlQu7ULn3ZA60A:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: ybHetuWqRbqcne_vPJHYWMcjoWyckbOn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511170118

On 11/14/25 12:28 AM, Akhil P Oommen wrote:
> Correct the register offset and enable this workaround for all A7x
> and newer GPUs to match the recommendation. Also, downstream does this
> w/a after moving the fence to allow mode. So do the same.
> 
> Fixes: dbfbb376b50c ("drm/msm/a6xx: Add A621 support")
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
