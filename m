Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2B43101A6
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778682653; cv=none; b=LiumOt1gPZbhblN3o0DBpSdGWNtTF6QoSDrj+fyQxLhe5JleiIP3WJfxDqyxJgOIZGqeuJMv8HnPKNNN0laK9K8FuABt4zDv1cc+lYnpg9BF+nnNuVaTqNj/9cCrlM73MJ1BnX6LsNS1g7Zg+orrGPrR5CmSyrrQVll6ePtigPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778682653; c=relaxed/simple;
	bh=9vwn9p/G3SBynF/R6x9abjmpGFFEqEuhbl5fGpI/Xo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Os/5SB4HvVjmhlHADHOQcgVfMy8tkqsU7GLHFHjQi7kNJV36tlUjnQgCMyK0JOfTEzVg7R3UamEneCQ0Ga3hDzhLkfkQ1tDHkEVIi/DuClnSyLjppgxk1JdJkRENj5Kpmj9FoRh/GbWUuyvQe18XmmHtYifZZmSnbRNObkb7tBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZV2cLJMZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dNLycbkO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZV2cLJMZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dNLycbkO"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D8mGud3474786
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 14:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kRdRHlj/4FYDgqpaQppw+iq5ofthvt61GQTIwvPfv54=; b=ZV2cLJMZDRi4atUp
	7gvRykW+ST4ITAgk7scyikVL3gdndFwbo8rKTvUhKXHkmRh/l9CrpfFMY8yQXqfG
	fT9sv3BgWY/Wsuqf8WPUwAkc/+JoL1+oobkfZhbjbqrzfufmDCbHaF2fSMCVmocp
	rmcAijS8MpXPFEyF2JSxlejK06CsckT/SHVM++3DHpn0MHHMBpcl7Slt/x74oKsa
	dRsXBYABpnZuaBFVG4o5QVV47Kd1LSVnr7DLXBmIWFlT8seqt/qaU2Wpm5nQC6M9
	Ge4mMXfPQ5jIZjrneJpkuiyZr+GPzqaZqdGvHV0iuchr69jgVvf+sq5L6y8SRclh
	tYEGog==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p4199q3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 14:30:50 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8353df9bc7eso6367379b3a.2
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 07:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778682650; x=1779287450; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kRdRHlj/4FYDgqpaQppw+iq5ofthvt61GQTIwvPfv54=;
        b=dNLycbkOAXBoIvFJhbqIK2sWVytAcz91Wf//1In5aPhnxe0Nd16+F36P04MBvGLXkV
         Lz81raoKyRAu8ZY70GaDoPPLt1uPPvxfpFOEC3k4cCL1y2FMTkPlfhM8dKl90/zPx/LE
         1e2Dtk/LC+SR7m1I/I0YOeztqVOjaozfDRCnPdEr1SRwrSFmZKZGSr7Zd1d2ZDYZ9TiZ
         iLcyV+VpCNEv3R6ctX4sBrdVVonYwJ63Qk2UDbnHGhXujizWX7Xwrfwfd62OScN/vPZH
         /qCAmWpWLwhigJV2hXW55c4woAJQn3wtU/ZdIc61OfCiLLzLnwXoe89kUx9sOc7kCRYR
         aHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778682650; x=1779287450;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRdRHlj/4FYDgqpaQppw+iq5ofthvt61GQTIwvPfv54=;
        b=E/g7zZx6hwOvD3PzjWinXrKiVYmLIxbExgeFxqHayfDtwXkuakuvGIOyi8lfWKmIyj
         XA2r70wrmLYgB3uDDRR8Jq37I82rmPNuGCHU24vgg/zPWq0zgogqoP/hTeWl1YDlhIoX
         CbqehKT2JIqnuQ+tosEj4QeVlu2AxyviA0nyktuxsDG17DV6rRSSLW6m7q2n8RL9Pqie
         GAqVV8uB/4WtpyRKTilsfFv9JmE1xbFhH3ez7JCWpkIlDrHQO0lSuOy0zXMeQQxk797Z
         Oi0IquT6KOMHm/BDss2SyizZYc6GHqoEPtIU3tqf3YRcgWoTr/tD1V7RqqRvRykVm3ep
         Tdug==
X-Forwarded-Encrypted: i=1; AFNElJ+02IjrH5AtfDZ68xBsRLb3lC2E7zba1d6Sr5iIzN3v1glzLlb1P/Lz7V+N/eUqYWqudfgc0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoXRFGC9D9qAmfSptk5oFAgEBkTgDamsIaU7J4BPuFgS8ppHun
	ksXtXplXc95OkWYFvDqPRvGBMRN3HzBfIHigA9se9cFUMYa+lj0ATJ8s/Rpp6pX/HdAe7mR/HZp
	SybZ8YpVbxJL6ioEzFTQBFZdRog0K25QCsCowYQpr9uJuuzo97WKOuvh1LQ==
X-Gm-Gg: Acq92OGUtTrAHhaRvtqn0di5ZJFWX23BHByH/XFy9mZMKnyKgOKFUYR5mizUrGOWt8X
	g5nIVhZXMCU7iOrgM4ywYwASX5mIKm4d0MYUKqAlTj69Drs0TWp+KAWHUNcTJPKS2peXelkJPIu
	tIPwKRrj3gEuiYqb2Q8nam3NpdIscITUGUyfrb4Gy2O/mxyL5uoN/9i457s64tQAQdJHvUheLSk
	73SRdjjJiYDSTngNwuglL0H4QhWqrKvqpy307MaJly93rNbMNqS7muwhUxC/yEnaXCodzqpgVW/
	3XZoszCkgYgKYOCAPxwgXDXglFm4rA/QNieMdor+wpu8H8xs/Cr+34y5uMuqWkq3NIrKxjOHFDX
	KDCiyFQ9QyDoDBvoea4cCihJm/ShZCXnWH8mfMXWkC7J/MKiTNncr1NI=
X-Received: by 2002:a05:6a00:22c6:b0:82c:dfea:9e2a with SMTP id d2e1a72fcca58-83f0542d985mr3656138b3a.2.1778682649598;
        Wed, 13 May 2026 07:30:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:22c6:b0:82c:dfea:9e2a with SMTP id d2e1a72fcca58-83f0542d985mr3656058b3a.2.1778682649050;
        Wed, 13 May 2026 07:30:49 -0700 (PDT)
Received: from [10.204.101.125] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbcf16sm31628277b3a.40.2026.05.13.07.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 07:30:48 -0700 (PDT)
Message-ID: <ad875fcf-531a-49af-b58e-575185c12d77@oss.qualcomm.com>
Date: Wed, 13 May 2026 20:00:39 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/14] media: iris: Add platform data for glymur
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-12-7fbb340c5dbd@oss.qualcomm.com>
 <jfypqc5ise7uezog3lwmmrzddbsctir6ze24ma4vp4zgcuwjbf@4443jqib6nxw>
 <b6dc6b32-26ad-6f2e-dfd4-551e7fd0481e@oss.qualcomm.com>
 <wequp7ogk2az3d7yzfxn7wwlr6k5ng2jwrg6anaidseteuwlev@v47yoo4j2gbz>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <wequp7ogk2az3d7yzfxn7wwlr6k5ng2jwrg6anaidseteuwlev@v47yoo4j2gbz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=df+wG3Xe c=1 sm=1 tr=0 ts=6a048b1a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=AkRF1kMk2nwCDGt8pKAA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE0OSBTYWx0ZWRfX9lR2XmUFMZWw
 F6ECq7ommvDthaasYZeT+q9D+WHwTM69h8v3OGXdTuDabWkjd0xokJ6lDXxJD3ntf43hd+4QSEt
 GlibiI3trTAf3thZehymSqtWCbaU3Ct6SfUUYb+LO48JOlPz7oMkjqVktrirj+jRIEahRRb01b+
 g+CIi84i0h/S1pTEGjeZhlhCVtkfH+1oect+f8DbX97NG2yPwRuqMCvDARgQhfUcQp1wk3Dj8e+
 GMFgt/O7jkMSeYRzembUqFqgpBHyQ47bLWf3hu1D/JlFySsvQwCQ1WP9ukAgfApW+Gn3WqkrZpl
 abXhmMTVJlgRX/FA5NNEG9T2qgjN0N8I66h83BVUFQmWYGLCnEIDv5abi24K1QyZzKjStZ1TrBg
 4KcugtbxC3y7KEI8z2CN4hVex/+4LjdkOxz85A4IR1avuk7vkN6ZIFB2fLFQ8SarF2jX9VlPAs7
 E+wK5fd2wyhPIJMtIrw==
X-Proofpoint-GUID: 9eJQkQ-K6KMwTWJwl4hNY5GlI8Be0QVd
X-Proofpoint-ORIG-GUID: 9eJQkQ-K6KMwTWJwl4hNY5GlI8Be0QVd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130149



On 5/13/2026 7:47 PM, Dmitry Baryshkov wrote:
> On Mon, May 11, 2026 at 09:45:01PM +0530, Vishnu Reddy wrote:
>>
>> On 5/9/2026 2:35 AM, Dmitry Baryshkov wrote:
>>> On Sat, May 09, 2026 at 12:30:01AM +0530, Vishnu Reddy wrote:
>>>> On glymur platform, the iris core shares most properties with the
>>>> iris core on the SM8550 platform. The major difference is that glymur
>>>> integrates two codec cores (vcodec0 and vcodec1), while SM8550 has only
>>>> one. Add glymur specific platform data, reusing SM8550 definitions
>>>> wherever applicable.
>>> This leave me in confusion. Having two cores, each with its own set of
>>> clocks and pm domains, I'd have expected that each core scales
>>> independently. I.e. if the load is pushed to the core0, it requires
>>> core0 clocks to go higher (while core1 clocks can stay at the low freq).
>>> Or, at least, the clocks would be set to the frequency corresponding to
>>> the max of the workloads (if for some reason the cores should stay in
>>> sync).
>>>
>>> However, I don't see it in the code. All clocks and all power domains
>>> seem do be scaled using the common workload. If my assumptions were not
>>> correct, please explain it in the commit message.
>>
>> The OPP core logic sets the rpmhpd level and clock rate based on the OPP table
>> defined in the DT node, where the clock frequency and power rail level are
>> tightly coupled together. Since vcodec0 and vcodec1 share the same power rails,
>> independently scaling one clock high while keeping the other low is not
>> straightforward within this OPP framework.
>>
>> Do you have any suggestion on how best to handle per core independent clock
>> scaling within these constraints?
> 
> This would require more plumbing and driver changes, but:
> 
> 	iris: video-codec@foo {
> 		compatible = "qcom,glymur-iris",
> 		clocks = <only-core-clocks>;
> 		resets = <only-core-resets>;
> 
> 		/* or core@0 */
> 		codec@0 {
> 			clocks, resets, power-domains;
> 			operating-points-v2 = <&iris_opp_table>
> 		};
> 
> 		/* or core@1 */
> 		codec@1 {
> 			clocks, resets, power-domains;
> 			operating-points-v2 = <&iris_opp_table>
> 		};
> 
> 		iris_opp_table: opp-table {
> 			compatible = "operating-points-v2"
> 		};
> 	};
> 

clock source "video_cc_mvs0_clk_src" is common for both the cores. It 
would not matter if core0 is scaled for a specific workload and core1 is 
scaled for different (let say lower), as the common PLL would always 
generate the higher of them.

Infact, going with the approach of exclusive scaling would be an issue 
here. The later core scaling command would bring down/up the corner for 
other core, and could lead to under/over-voting.
>>
>>>> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>> ---
>>>>   drivers/media/platform/qcom/iris/Makefile          |  1 +
>>>>   .../platform/qcom/iris/iris_platform_common.h      |  5 ++
>>>>   .../media/platform/qcom/iris/iris_platform_gen2.c  | 99 ++++++++++++++++++++++
>>>>   .../platform/qcom/iris/iris_platform_glymur.c      | 97 +++++++++++++++++++++
>>>>   .../platform/qcom/iris/iris_platform_glymur.h      | 17 ++++
>>>>   drivers/media/platform/qcom/iris/iris_probe.c      |  4 +
>>>>   6 files changed, 223 insertions(+)
>>>>
> 

