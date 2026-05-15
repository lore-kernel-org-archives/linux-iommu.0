Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B953F1664
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 22:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778882948; cv=none; b=oEYNxNzGonp9noQNWVFW6aZnzLKZmxsQbuE92ujoaeCTTbF6GFW9UtbBAzwV4QYJRjCsOHAYlV2ZDPshyDbZRNe965t//mS1ELYHA1CGjYTSthC+2/QUiEs/I42P34iBV/lzr5Sr1UPnjw+z1aPLYnMkqR0BuMkMwAJlD8IwybM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778882948; c=relaxed/simple;
	bh=IET5AU6rrRRsH37Au+nEzTi6bqMiuH7lodZQGEdsPl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLbN+Z02xO+yzlJN2cKtK38JlAYg3J4++ypCi6VR32AXbVBfC3NQbpzQmQBH1453uewbjAT/ICQsWnA4OIo+tPmqBFIy5TDbGAOKY0YoURbSH4he7VVlsVLKmZuIiUIxgC7U7RcpQazttVS41+BtkSnU918rxQs403YTqb/VT7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Io9+h9rw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JYSRvQRY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Io9+h9rw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JYSRvQRY"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FKKqC62651511
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 22:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YaMH5hmIAD00xqSHsQUa0nL0jAccvNpv5cFUjemkwiQ=; b=Io9+h9rwNtHe309S
	OVH+h6e78ujukoFG+67vJwR+0WA8GGWvkfs+CED7kM3wyT4k1v9lowfjIPwi1Zk+
	+6HG0ljCnzxDh37PtulhGakMBC3hAWzzqfiitC7kHCE0v8DGQuUOaLNBsjzd+0Uy
	tYfqFXE0S9X27qzlkI+MDCeT+hPOdA6OOb4QT4aQV4l03YH5e79XLqGMN/4p1pAB
	sRgAncfHAIY03FZYu7dmHCywYpzd1GvogS7gldtYuJEwrzQMNw31J+Np9vja47pj
	jyosMCP8W72ChGMJzytJE4aK0CiMbUcGRbLGSOjoEupsbn08EAUyxNsaOnW7tihV
	XD5tWw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6aep87fc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 22:09:05 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82f756ebd0dso158085b3a.1
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 15:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778882945; x=1779487745; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YaMH5hmIAD00xqSHsQUa0nL0jAccvNpv5cFUjemkwiQ=;
        b=JYSRvQRYhAkCWG4eV6wVlcigfqMZMSlZsAUsWoRebhcn1rk/yV9IgOucKS4YmnWVAS
         dglBJus2C3z6oSgvj3NPR91je0n4575/6Cvb26OTTYa06sDSyq6YT2fB5zYeqnzWnK31
         wRY3GWxHmIQDsjJa5ydMyYJ27ioDe7A4NQRjh5F8uUwiWpF8OK8bxlVjdt1rOTcD4sK7
         mOXjvYpRhJoHhHuOd3kwNbV3ZzaKbdxxxgPyXCIlFNic4QbQoI0yYotjvzTRRh3DgThj
         DSYUgPOW1ZJfnjHWangLdfsVdfPQVSzWHq8pEeLD/wueFuWAApuoHI2kbtqzefTrfqik
         9DFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778882945; x=1779487745;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YaMH5hmIAD00xqSHsQUa0nL0jAccvNpv5cFUjemkwiQ=;
        b=PXo3jY08GgfWdj0HmRELQFMlBoNGC7OufA34qBo4tXwOLOryZOdEqcBQYfLlcqZlZZ
         +Ec6AdyJYd1ZWfy9krj+4SgMVuB+q5EWUWGjOx5vaLoLvbz/0ZgM5MPXHVgf1CXVYt5W
         ahS9RqPqDczf3/b2GviNaLxwKMUOBcfXwCXuGNYDfWfvypnbGhcny+sYZVq9D+TquEGj
         Tb/jIh62tH+5feilqTEcIbtaFex3UbA6EXconHoryVsGFNyBcI/3J4/lJO8unaYhVepw
         TuOAnx9mEg+aYXRL+Qd0WQURKIAJPWXGZkb269g04Xl+8kU7aIEPp2zEm+lEexqXJ8u/
         X5mA==
X-Forwarded-Encrypted: i=1; AFNElJ+2AzmqqEVRjI7voWGgHs7kmlrzFmD08jCcZxiRNdt6OnXFQNy7/ZCsB2U3Eld+tJOkLoAwIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBovXFogoOV78NkWaNEhI2jljZbm/3MmODcnbb5BDAgIRuqso2
	5083T3slETBBXVaIDJQkSczVFSiAjm/UESpRSOjV5FN5sUEa0LuNJdLsz+VEy58yuobIGNVskJi
	8RYHOaVIaP8FuQcW8giWQkYE8c0NYrpf/DeN1oacuvb8OwlOAX7UlaLKHvw==
X-Gm-Gg: Acq92OE+MlZz5f8xpKJkzUqQPn+RvrBMY2FTPLrRIazu00VGe0jyv+LaKllbIEh/Jdw
	yih1Bk0t8VZN6j8ZHY2n0wsFiOFMyE4wn5d+UJ1RVtpEhx0t75cwWtQyG6Pt9ZlNpcipl9GvpRL
	NJ9nMjCqKMV4hJiGS2ZLlvhfA5/kF+4e//qMCbMH4RLgRemYoEF5Tated5YB5V5qG5cwH8Bk/Yp
	zJo/zqqcdiaLvIvd5cna5gVrPVrlRm9E8qWZZub+vw/XgNKmwW3YsvVaqKrFY+T1ObDZPIYTMtE
	sNZKwQ9CTv/qCWREMvP4hTA7TOAFJLbOj0qnMA1dRhbK5i44kKrtWl4p3Mui6lllKK137mFgpYy
	e8X/h1OyWIyYxrdnQuC78q5B+0S+wVcLf6wFHw0gSmB4=
X-Received: by 2002:a05:6a20:4305:b0:3a8:2339:24c4 with SMTP id adf61e73a8af0-3b22ebed4a2mr6668397637.26.1778882944651;
        Fri, 15 May 2026 15:09:04 -0700 (PDT)
X-Received: by 2002:a05:6a20:4305:b0:3a8:2339:24c4 with SMTP id adf61e73a8af0-3b22ebed4a2mr6668373637.26.1778882944158;
        Fri, 15 May 2026 15:09:04 -0700 (PDT)
Received: from [192.168.1.3] ([182.60.13.113])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb1156absm6447536a12.27.2026.05.15.15.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 15:09:03 -0700 (PDT)
Message-ID: <7d3dd8b9-8411-476d-a1ef-fdac476a1515@oss.qualcomm.com>
Date: Sat, 16 May 2026 03:38:52 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] arm64: dts: qcom: Add GPU support for Kaanapali
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-5-13e1c07c2050@oss.qualcomm.com>
 <14a2fbfd-97c1-4ba7-aa51-a07134102d3b@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <14a2fbfd-97c1-4ba7-aa51-a07134102d3b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: lQeNEAxTcrEOZ2CN2sMS29-VpUBVTe31
X-Authority-Analysis: v=2.4 cv=M6p97Sws c=1 sm=1 tr=0 ts=6a079981 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ba8plz+5YpscmDk5DVa2Cg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=mzNi1YEEKYKHT8R6ei4A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDIyMSBTYWx0ZWRfX0TXhT+d/Z+IH
 rLuaEhv+jf+7lU5XSsBHSihLd7U9yiH8q0RLB0O/OHwfg7N5MRDlXhE93UvQ7o5sIk10z1ZQzUJ
 UP5bR6BXyt5f2adGLIqFf947ynadl4ThqmmzJLq2f9idDIxHk9qfTsP7xMd8XWXS8jhqwtm9b8d
 8PPcrqWiVbOhr23v2Eiu8ufUfkH1vSCN4R7ODtxxOQxfmssEMPBIK/GLfMH+ECqEBaFYftqJ0Et
 DOWarvzJ2w93xa/7K9yVOpY/pYpy73lxHvvb6BRcN+HtXt3WlDsnENa6i2ORoRb5iD+gxzOu46d
 t40N15s9M5xHS97qoT/sEdSQOJ+UbD1OQEDRah3fZNR+lga1+2QaYWzDuDUIZizdZ/h14s8ywoy
 z58XW0/fBIs3YxwckLCS+sQivMAItTYj8sI3xdOugNNxejBVYtt+F3f0XjvCjJK3zJHoj+LmwXH
 8h4u/5hROiiOhBu1owQ==
X-Proofpoint-GUID: lQeNEAxTcrEOZ2CN2sMS29-VpUBVTe31
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_05,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150221

On 5/14/2026 6:13 PM, Konrad Dybcio wrote:
> On 5/12/26 12:23 AM, Akhil P Oommen wrote:
>> Adreno 840 present in Kaanapali SoC is the second generation GPU in
>> A8x family. It is based on the new slice architecture with 3 slices,
>> higher GMEM/caches etc.
>>
>> There is some re-arrangement in the reglist to properly cover maximum
>> register region. Other than this, the DT description is mostly similar
>> to the existing chipsets except the OPP tables.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +			gpu_opp_table: opp-table {
>> +				compatible = "operating-points-v2-adreno",
>> +					     "operating-points-v2";
>> +
>> +				opp-222000000 {
>> +					opp-hz = /bits/ 64 <222000000>;
>> +					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
>> +					opp-peak-kBps = <2136718>;
>> +					opp-supported-hw = <0x0f>;
>> +					/* ACD is disabled */
>> +				};
> 
> The clock plan also has a 160 MHz OPP @ LOWSVS_D3 and there's a couple of
> interim OPPs that you have that aren't part of it (but maybe you have
> better docs)

I somehow assumed that the 160Mhz was a thermal-only corner. Seems it is
not. Let me revisit the OPP table again. Yeah, the doc is outdated.
Looks like there was some last minute updates to the OPP table.

Also, we should update a6xx_hfi.h to accommodate more than 16 GX levels.

-Akhil.

> 
> Otherwise lgtm but the size of the GPU region and the GMU base look
> slightly confusing when I'm comparing them against the reg map
> 
> Konrad

