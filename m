Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7249F1F2BB5
	for <iommu@lists.linux.dev>; Mon,  5 May 2025 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454738; cv=none; b=MUcv/bL20yz7VxSD4P50isFdiHVL5OMbmpoqiwv0zySDgpshdsEGpzfFbxWg4WmcBKAH7J9DyIPQ0gPtadBFS95JzKoFqbXW9cieo9GoYBXjSInnc44n8fV75xAEnIYDVXoYWniYdccuzB8k04K0WQURyGtAsOCk+hgLTPAWcP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454738; c=relaxed/simple;
	bh=3Vf+AaQhANAKR4iErxV8pfkN6oisAXDi42nAcHc040E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RhkSnVydVa/E/jgXNT3yKX0uN3mhEKJ5Y1gTdkYaW1WKSSFjKBWaUpimA0un2G5ZgT+6Aay+qIlTLqsOkpM41V5K3P8HRorgqtPNnqaBC1dNdqg2uZtrDY44bT9BX3brjt5W6C/xKbAUE4nQ2iup3DnPWH8VzwI431mWV/r9IOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b4PAbizK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b4PAbizK"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545AnoK1004816
	for <iommu@lists.linux.dev>; Mon, 5 May 2025 14:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4OMp8lVlfqOS6nQjtVYiy+vsTT7GaERnrIvMt0I4OI8=; b=b4PAbizKQdgKo4Sz
	hAnB7gq3XzspJ7yxkI0rAfW/7gt8MI6H80NV0PqEJqNV3uxySOCpIdYv4a0kcI2M
	g1H+XyC3/zZ8nd+XzuT6p7yv5WQH3G5GZtwy8+MHRWRMP7nTsg1OhRLVB8Ao2Q2x
	LkOtxTrcjQC+ePkmFGRmr3CN7it78qUDiXOhLLNJydEezJTaB/wbSUgoAEn3EOEG
	rKFYA+c7uVYVYrRyokY177Tx7LL2A80L42El0vWjD1xeGlYr1oHgT2qD08MrheoD
	BeqGEQ6MFyy3CrqaZ4pB2puT0olee4bxczYriQ4HokKGlV5XmOK/jOHNeDjjVuKv
	NniVyQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46da3rvbnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 05 May 2025 14:18:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c760637fe5so200681085a.0
        for <iommu@lists.linux.dev>; Mon, 05 May 2025 07:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746454734; x=1747059534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4OMp8lVlfqOS6nQjtVYiy+vsTT7GaERnrIvMt0I4OI8=;
        b=T90+cqtkcrvj7Bo1BMnfZOnI/6mpvlCihkBat9itXCr4TcqYzwcPsoDljF+pEZg5VE
         jgdsxQJ1oRX6Kb6n8l7qIWIlcB3TbD07SrYgGT/T4lkUMz733Kg4fKmIlge8BjCzFMdz
         FUC9MPLEf5r5Pj/TaEBOrzussVorcsz2d+56iK0907JRRdSbpQsNLae3NGwXSO1HFChm
         D2oqeZlAYnCdw+j+a90WvXx/MNo3o9cZ0sURsBoj2aESQbZp39vumhXcR/yUfNRKmoTT
         KKYXaDL/pfDFtK6UcJFldEVW8GjCobJbJF1msbe7MrTpyHnt/XyN8yz+2aFgQy1qw6Kb
         v29w==
X-Forwarded-Encrypted: i=1; AJvYcCXcdYaoKNPcPjDlIamj13kWOpdEKeWmaSTP3tRo09qRiX1CZDM+vA+gPsQqTa8BqnBDTI6Olg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZ2daDfdGXAB6/g/a/nAUvIObV+fGC+THpd23Lz3orp3yYXKwr
	5xMafQgadi5JU7iI6BgUhDSqUo4JmDjvT9zydb23d3iJETxHaz/fdM//RYRkXovZ+1KFOqARk3g
	12vYlsG4aKRU/HvzL5qLp2bp88kCP7XbPTTpNOJqh6b0NCUM6/7m/FA==
X-Gm-Gg: ASbGncuywE0i0KxWMaJHtGPN4tVjsfXD4F3Zjw5bTfcTkhXtt6LZRUjxyqaPAxN8LU5
	pfcotbsCbfZiVytT8lNRTLhC+zkgbBYTQ3bXMwzU22vCMke58Ud9xMwVPxWpj1CBrCCp1E8mX9E
	u+wxux6qYQ8fWdgaeepDjLGD80/XYSk2+z5ebsIZYIRmxF5PLnjlMKUihAvnqgf9WirAHgQ04Gs
	thrmBky8lU/uLhDvtrjI0l/14QXtpEnyprN/4dMKuJkG0MSwFAuozhqnAKECozrdd7yuIR7NTzZ
	6knGYEWgzVQIavVgp2yIQ4wA7n+H0Ui5b22Gd+aqSE38ktIpP5/V6zir6TCucWZ12XFq6MwnKP2
	9uFFs2mFknTkL0CGfc84WBAy0rJjHPEgyuPdLRuKtCC5prHj4y4IzlpV4ajWdd65/gHma
X-Received: by 2002:a05:620a:1a0e:b0:7c5:e283:7d0a with SMTP id af79cd13be357-7cadfe15ab6mr1528030585a.30.1746454733843;
        Mon, 05 May 2025 07:18:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxLIuDmlMk0BDjjG/jcKroZx3ooAtnxfCFD86oCFhHuF1R3mpWcw+w7OoB3Ift4T6LrXoRzw==
X-Received: by 2002:a05:620a:1a0e:b0:7c5:e283:7d0a with SMTP id af79cd13be357-7cadfe15ab6mr1528024685a.30.1746454733441;
        Mon, 05 May 2025 07:18:53 -0700 (PDT)
Received: from ?IPV6:2001:14bb:671:42db:147e:6740:cd7c:7688? (2001-14bb-671-42db-147e-6740-cd7c-7688.rev.dnainternet.fi. [2001:14bb:671:42db:147e:6740:cd7c:7688])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94f2043sm1707308e87.179.2025.05.05.07.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 07:18:52 -0700 (PDT)
Message-ID: <4a186d4f-9966-4569-bee2-77e237cf0c54@oss.qualcomm.com>
Date: Mon, 5 May 2025 17:18:49 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Various dt-bindings fixes
To: Rob Herring <robh@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Robert Foss <rfoss@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Kyle Deng <quic_chunkaid@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-usb@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250306-topic-dt_bindings_fixups-v1-0-0c84aceb0ef9@oss.qualcomm.com>
 <174637445759.1385605.15383087742490646226.b4-ty@oss.qualcomm.com>
 <CAL_JsqKr8Xd8uxFzE0YJTyD+V6N++VV8SX-GB5Xt0_BKkeoGUQ@mail.gmail.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <CAL_JsqKr8Xd8uxFzE0YJTyD+V6N++VV8SX-GB5Xt0_BKkeoGUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -hhltTU69XW5xe-Q10MSc7-Ua7XqG0Fi
X-Authority-Analysis: v=2.4 cv=cpWbk04i c=1 sm=1 tr=0 ts=6818c8cf cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=e5mUnYsNAAAA:8 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Y8Lu5Vov3j2QtJBI0v0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=Vxmtnl_E_bksehYqCbjh:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: -hhltTU69XW5xe-Q10MSc7-Ua7XqG0Fi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDEzOCBTYWx0ZWRfX+AmHOqAZTm3l
 a7r4edGcgDPpdsWfZOb/WGWnT+MA2O1zflT+iam+kKNQVxTGMrQuGwRg5syqpJoCe5M3AODan0x
 7n15R7x7TCUFTnhUpj8NPdFRktnDpmIeRjqrdXEW2EJouU+NjFHxjKgEbK41WfKb1vvdoxswU16
 EMadHA8d8NSLo1D9wCy1sCQ05CXH0mdsP+Zyaduw8gUW3YToEII0apTBhcOAeuf7a9Ura8VwP2k
 o02dAPyUhcrMozxq7fOJmpxKyHwHbzlA323nxvxkGqHKMx1DJ5MVU56IwCXJ44Af3UCyzBPh8ut
 EU5si69KuYQLQ1UMv+TJSYYSwZ0FtvP1r8KxFaDfwK9EWUY5frAoJMI2y4dZQGtLMZ5pFET+CAd
 u9zKe0A9C+7lhrfTfIPi6RV2sT9xlCa3Y/FsIK5dqRKbrnNRLHcuXyFDYoXll3b7YRNrewtl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_06,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050138

On 05/05/2025 14:56, Rob Herring wrote:
> On Sun, May 4, 2025 at 11:13 AM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>>
>>
>> On Thu, 06 Mar 2025 19:11:12 +0100, Konrad Dybcio wrote:
>>> A set of not quite related bindings warnings fixes.
>>>
>>>
>>
>> Applied, thanks!
>>
>> [02/11] dt-bindings: display: msm: sm8350-mdss: Describe the CPU-CFG icc path
>>          https://gitlab.freedesktop.org/lumag/msm/-/commit/60b8d3a2365a
> 
> And now there's a warning in linux-next:
> 
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.example.dtb:
> display-subsystem@ae00000 (qcom,sm8350-mdss): interconnect-names:
> ['mdp0-mem', 'mdp1-mem'] is too short
>          from schema $id:
> http://devicetree.org/schemas/display/msm/qcom,sm8350-mdss.yaml#
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.example.dtb:
> display-subsystem@ae00000 (qcom,sm8350-mdss): interconnects:
> [[4294967295, 7, 0, 4294967295, 1, 0], [4294967295, 8, 0, 4294967295,
> 1, 0]] is too short
>          from schema $id:
> http://devicetree.org/schemas/display/msm/qcom,sm8350-mdss.yaml#

I've sent a patch fixing the issue, 
https://lore.kernel.org/linux-arm-msm/20250505-sm8350-fix-example-v1-1-36d5d9ccba66@oss.qualcomm.com/

-- 
With best wishes
Dmitry
