Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB6A2D94BC
	for <iommu@lists.linux.dev>; Tue,  4 Nov 2025 10:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253843; cv=none; b=g3SQN9yKm1QYWLl5s/wTuMykrtL8ecc7ktZ3ZBilFCyp6oGP7zBj5PrbOeNDo7NDiM4av3GY9jhYlKdaG1mA+1OUSfVRxW1FVHTFlZbvzrcoc4CWWWish8rzvL5OnS7SLKz6IXAYRkp3DeL/bMjuI9kXjbKHsgTd++j7WOQhRIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253843; c=relaxed/simple;
	bh=xD40Qn7ySb+G4ifOmdQ3plBa87zSBnrJ9YWsryZpG9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQWl1nzO7I929VExfHmYb1W+oZmq/25TLlFxRRybsdzr6emgqxaNvmjzVeGLfjNkZOtoLv8i+QpTANpVCnmBlhYb65UqddYGqryj4ll6/2C5nqzUOb6j2VG1dEqN1lOZZ/8YCXPQ2QDYFV7y/U1v66Ovs98jr+2wRxoDgTqWG/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Eef/FjtS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HkouxXb+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Eef/FjtS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HkouxXb+"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A48ggWm1459189
	for <iommu@lists.linux.dev>; Tue, 4 Nov 2025 10:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	17iSZ0rQq9YOzSnIopSJVXFyQroZzaAj5ZsSQQp9i8A=; b=Eef/FjtSWHTDe0pl
	nB9UI/jxuKZvowzXTbsRmCAI07UniPq/9bJ2pFTZDTGO6wc0Xqb7mAk7FxQP4HfU
	RffICIUjQ6IkcOX9PsakdnXepvGebd1VQa1PXawQt9Ii5eOpB0f94Qju87IZBpzU
	+B3dEy+jqRrUpsJ1RPtLVwPrCyoYKXYWYah9Z6YJNrzy7FiBxrAu4tL+E4/w3Kwh
	9iXqhsXxY7xESbNpGA/t3b0Y65ESGDIFbWPJ7YBVvwYbzWfNI7gNrTGj7MnPBKJ/
	kjCq0KEsA10Dw+kyzkNCG7BgjdH/YHXD+ymBYE87Uah9WvqDTw0iWCM5NVtshkwZ
	+xbyiQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70geamwq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 04 Nov 2025 10:57:21 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7a26485fc5dso5202139b3a.1
        for <iommu@lists.linux.dev>; Tue, 04 Nov 2025 02:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762253841; x=1762858641; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=17iSZ0rQq9YOzSnIopSJVXFyQroZzaAj5ZsSQQp9i8A=;
        b=HkouxXb+hraiirgB9jHRIWj9tj9hZBSuYw5HCp379hYIAouieo6V5SA0xeY8k/lJiO
         WLTjB9QOSoS0ZDRy0Kpcjbd9dsrIro3fLPqaWAA1p2qkvPqwC/xbxdsi2ieVIBxMDgg6
         OceKdu/f8vZv/AEofVthpOQI8y/KHMyaZs8if5RxDUYA1WJ1RYtOMT+vsPZR+2Q9uTH2
         lFyx5C71fhV7380oF9zk4uC5TNIhUlp+64HbF/9DSK54T8l8Mjj4yfK0yNxvSsGOOY/c
         Becor5Th4zl3J6U8liCijvrxkXPBKqb0FhcygQi2nkpWSSmomDk13B6BI7vJZCsjtGxs
         kYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762253841; x=1762858641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17iSZ0rQq9YOzSnIopSJVXFyQroZzaAj5ZsSQQp9i8A=;
        b=m5cH4NYxWQUSF9X13ILkpybTBTNascJ21FLtHPVgvdxoYdocWKSzqupiLTYGJeJCVI
         fSq1pjgPigAbSbabClDqJEDQenAbMpwY/JbvkpMpNyz39c4Rqgi1dJZVUZP1WGIaDpEK
         sGc6nhXhNGlWcA1K2/HzfYr35t5Zq1/D1kgbJbiVnIc1twSzzLcFx2eyF+SxeZBNhWD9
         3UXuELrw59rPMp1k2ZA574VUei3fnol8z6hPUR3HUvbaJDhRQgdxa9YskK5yfO0E8T4v
         GR0zjEwMKDCE30VqXzwfbQSqTdRXEaDaPCXh1TeTNIrk5hvVaG8ebl/3Fo9Q47SXvjBG
         FShw==
X-Forwarded-Encrypted: i=1; AJvYcCVNXNJR1jp1LtkphOzQv+5OJsghv5qQAzObulbcWYC0A+m88D+cIN/mIvdd8q9Ct+whksZK6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWU6BEtYr4KkQrK4UaQXZQYgkoGRRM18uxFCQQEoZzceV8CMOy
	hHMBaM6ObJLI0RqBqg4ewfFFnuNcVeA4NpN1dm7ZBMBwpHUyjwZFf8S1N0iovEOMrb7RaVBH5sN
	KAbkiffAWdSfHBhapd2sOfuFSTtw53ri8HPpZtAz1RuUYATeW5Eb9aYKU7w==
X-Gm-Gg: ASbGncttieG7qZwmdfaJFUp+Cioy8BU+Q8DrAMhdcubQj3hm9eD84DqAPYdEE+VrvJz
	or/7wE86xtE0PA7SUO+lKyGQn1kbMyLzeftYMe7YvGNUI6NEG7UCchwCW288xr4/vJDIAilDx2o
	N35DFKLQBhcRbrSDblrAedY8nNi0TRg1/Nkd/WawmnRWLnDUGpoQRmYL9a0OoWM4pVnPJrVZntB
	nQq/vl9KHHGFVOOGHr+ukBtctaCkM2uENcIwvGbOZo89UabSawdTiFleijto62hRE1odQlRG+cH
	LnGkFeZMXhwHDPUFuyPGHt1k9/xGJkPhgx6h3fm8s3HmWzEv3Afgbzs+1nnzPU4/gx2c0jiMS87
	ghc5y9nRpoe5yRhgC4NeChSRfhPo=
X-Received: by 2002:a05:6a00:28cb:b0:7aa:4b8:179 with SMTP id d2e1a72fcca58-7aa04b80436mr8377819b3a.1.1762253841086;
        Tue, 04 Nov 2025 02:57:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHeauPRKvSaQfwjZoWhPXPVkD5UEZgsLll5lxQv70Owt2nEGVc1ASjz7ivNXbz+Pbfiny4nw==
X-Received: by 2002:a05:6a00:28cb:b0:7aa:4b8:179 with SMTP id d2e1a72fcca58-7aa04b80436mr8377780b3a.1.1762253840541;
        Tue, 04 Nov 2025 02:57:20 -0800 (PST)
Received: from [10.219.56.14] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd382ad96sm2563399b3a.22.2025.11.04.02.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 02:57:20 -0800 (PST)
Message-ID: <2dd128f2-d41f-4eda-a393-260098749a07@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 16:27:12 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] of: add infra to parse iommu-map per IOMMU cell count
To: kernel test robot <lkp@intel.com>, robin.murphy@arm.com, will@kernel.org,
        joro@8bytes.org, robh@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
        bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
        saravanak@google.com, prakash.gupta@oss.qualcomm.com,
        vikash.garodia@oss.qualcomm.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <74d4ddf90c0fb485fda1feec5116dc38e5fd23cf.1762235099.git.charan.kalla@oss.qualcomm.com>
 <202511041853.IxYgvWlc-lkp@intel.com>
Content-Language: en-US
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
In-Reply-To: <202511041853.IxYgvWlc-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: p3Nx-UIZ9IeL--kTRx4zx3881jnomgq1
X-Authority-Analysis: v=2.4 cv=bqBBxUai c=1 sm=1 tr=0 ts=6909dc11 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yE59AjuNBYSqEwnZTzMA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA5MCBTYWx0ZWRfX7NQrppM4jpbV
 NAvCQ/JuAWUUSx69WEOf8E56VQZSaDYJkQjPfxgK3NKprcYALLulystlQRYwTKOkrdIFD+AxQVR
 Xd3KnGYe3bwNtbBG93vvsUcd/SpPqmJPQR5gxSfQ2/QSlJ9EZ7ka/246fjQTmbSOfBIPiFbTfHW
 EEHUl3gjqoD6Nq/hm1vXcevWRPcPeN+oliAI9H1eYBbb7UenkmKqvLkl4g0SVN7ZSo9ndcuWS2g
 to3d6IwS9/0Ta2nmt6tNd8VaYPJ9QhWKoj16wVCZ1Fai7V6Nvii/SpMK9TZFOaLYGq+fFSgWd6R
 RBIYWuUh8bpWfKThj13ZMRSguHr5rNNcw08y3Wl8bpCHTmlMk57/lQizHx7Or1H71YQ3s46Qiw4
 jxQ/AHW+rp95VcesCFPGv+PO0+ilHw==
X-Proofpoint-GUID: p3Nx-UIZ9IeL--kTRx4zx3881jnomgq1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040090



On 11/4/2025 4:16 PM, kernel test robot wrote:
>>> drivers/of/base.c:2127:6: warning: variable 'legacy_iommu_cells' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>     2127 |         if (map_len % 4 != 0)
>          |             ^~~~~~~~~~~~~~~~
>    drivers/of/base.c:2130:9: note: uninitialized use occurs here
>     2130 |         return legacy_iommu_cells ? : of_iommu_map_id_actual_cell_count(map, map_len, cells);
>          |                ^~~~~~~~~~~~~~~~~~
>    drivers/of/base.c:2127:2: note: remove the 'if' if its condition is always true
>     2127 |         if (map_len % 4 != 0)
>          |         ^~~~~~~~~~~~~~~~~~~~~
>     2128 |                 legacy_iommu_cells = of_iommu_map_id_legacy_cell_count(map, map_len);
>    drivers/of/base.c:2125:24: note: initialize the variable 'legacy_iommu_cells' to silence this warning
>     2125 |         u32 legacy_iommu_cells;
>          |                               ^
>          |                                = 0
>    1 warning generated.
Will wait for additional comments and take care of this in the next spin.
