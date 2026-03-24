Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA20283FCE
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 05:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774329327; cv=none; b=DVc8mhsJ+JBg0fhlMJT8PwJpNLESejxVN74Pb8EppqM3xY0ZUuLJCHOhbasWu/N5eWLOcRuyxwXdoMb4pJIUahjss1UmxuaNBn+/NNsIYugF5NG6kzpIEkUkUyKeKtVmT0LxB4Dtry2JMG5YArLX+AZ7W4uTp6lLx+BjDOXfz+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774329327; c=relaxed/simple;
	bh=mFSN/Scch+iSBbvGZ6JEeuNoSUnRF4fKrQBINnoNrnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZErtY13pVlBv25kfrz+PbAt3xZMRCUdAdvk3HSAEaMFOaoaUEayIHqIr+PTB7NRDdxcnEgJS3JnIohWMkEWvHHsACHJnKyiAhp9UHle/giwwmz4jy91MWogOcF/bV6ePLEZndZzPhtLWtkfwfxnJdXH2ibU4Fa7MtHlCxctn1xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LKWhIp53; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C2w1ctlH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LKWhIp53";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C2w1ctlH"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O39SSG3934869
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 05:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fV7aXshRMXgRNymfOfiTCp/pI6NQFCBxOCj9Tnvy50U=; b=LKWhIp53IeBe/dwx
	4urY0ObI825FLxF3O8dMSncDZ8V/u23uu/QS9JN2JF5rU4YqGKbMGkKzttcR62r3
	br9Jt0Fi/OZpglK5hXZr4uWxhfG8l2OQz35eu4nxVoWpviLjURzHjFYI8W+Bccd3
	mz8mQLFaam8XxQ2FCVfTzykwH0DVQWEt8doRtHz9RFgnC1b8fq2COu4leHEThhLa
	j7n9X/vQ0cTRSeF/DM0EUsY/0DV0jNEVnYsbcbyAl88EHA6y9bS/hD7qcj7K8Nxx
	2ofjNGepfdwaRNWxsNZg/CM/C1MmgxXjKb1owNKz/A50DhIBDYYaz340FYBMDDM8
	kza3ww==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d37a0jstu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 05:15:25 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b064f043adso70817275ad.0
        for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 22:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774329325; x=1774934125; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fV7aXshRMXgRNymfOfiTCp/pI6NQFCBxOCj9Tnvy50U=;
        b=C2w1ctlHGOohC9/m8d0DhZwRj4v8RwFsyRV+X/DoHnSmJMiSjM2WH4JMM6TElIJ1kY
         dhEkYaOBicVdkv2X9TA5oMqHZVdbIm67Z/uiNq0r3oWjKIHFZsQUuXBhozhKW4i0pmLk
         gP/apKcGriI+aBg2ocdmp4PMeoFhZ/K1yjo9gYYjt50425wNYF7r3mLL5xu1supkkFbk
         GGYodinFGcWOuFnMzH6Obilfaek7FFmYmNb7OKRNrU2qJLdN/Lso8TyAhztHpcPrR/Ph
         7C0K6xs/AoNBTuHWVezX+/EElt8ZTz5qRk/JULcdIjsx84WI4nerMc4/AlxydxOW3Asg
         Jzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774329325; x=1774934125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fV7aXshRMXgRNymfOfiTCp/pI6NQFCBxOCj9Tnvy50U=;
        b=YYM18OfLos6tINl1LlqXGnyByNPLv1W23lTZT4w8fNqij8Im5yIsbDvvD99ugM6eUR
         h0yhVgIPf3VrQKXi81e6btCkbx8UIb1Gn+mm6r1W48Q8VdauLeHGCb06ph3P1SkwPv58
         +32hsNkyE6mVuP7aM1hblb+1P63rNOSWG37ZZ8KZHm9lT7VCzyf6Bk3aXPtqlugcLTOk
         trEk3E7fRthlHOuTlsu8Mi4Dr9jZdrbtBxI1HrCjZDY8+nMxxlTE+joIDxK9H8gNy5/M
         00K/B4x9PeK+eevd9NGrAR82jBMSv8WUHPL+kUML4veXZFAmM/3aTQtnjgZY1eW6XNKe
         1Byg==
X-Forwarded-Encrypted: i=1; AJvYcCX/Meu8Mah4IPToSiR+wmQsPjZfOndBDk0nWkkO1ZT637PLZXMCuq7c0RFWWIW7RbWrVP2QMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDPDWNW5uVjWBJjd6klTDtFOkwFf8a+UO0xBiEZO+bx+LDg+41
	ETpBsNx3lRT/lOMJH370nkia55dp2GnUvetuOdsvXmy65ohmDjy+LZsd+9xEgBBKnxmpXhd9TmP
	YyWNvgTaJcXIdHMqg+18xofCIK0GrOUIHaAxcIEvdLg/L+LSaXgz/fu3mikIsH6Vfkg==
X-Gm-Gg: ATEYQzwO6H+SUInuIwzXudGfK+Lg0wcS5vC9M6pZT6iRGYug4osBGWASzD/cHWkLpjU
	CZl+jOifhm/Q1ytCsHdDFD0QAtB/gwvJY/FqqMa+2GA3Rp2GD9HbFmBWP/o/7VZ+0s87GdKCaf4
	Vh3M5BZMWXBCD4H4leNoYAAGoMAWGuhoVgLDe0+lXFgC02B8IAgdD9AYNqGLFizpOV+PMSEXA9x
	4w/dYSjj/Pr9a8dda+oubJgXf+K5XPHLcYMkK+88aQsBNhivg6atb/Lpa+6F1arAj5Zrs6rw8XH
	XzvoWIPnxmYn6zmzAv+BQuxX+pGp5FIhWt0tESAUhqxbIkKmU7pytz1MW4QkU1x9jaYXUYJppof
	AoM9yfws6M5oSyriRKnsBWgORiUJsuP8UxgEfy0fLxMIpm+ZCssP+XQ==
X-Received: by 2002:a17:902:d48a:b0:2ae:6457:3099 with SMTP id d9443c01a7336-2b08277cae4mr133308525ad.26.1774329324523;
        Mon, 23 Mar 2026 22:15:24 -0700 (PDT)
X-Received: by 2002:a17:902:d48a:b0:2ae:6457:3099 with SMTP id d9443c01a7336-2b08277cae4mr133308175ad.26.1774329323989;
        Mon, 23 Mar 2026 22:15:23 -0700 (PDT)
Received: from [10.0.0.3] ([106.222.233.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08366c74dsm174187005ad.62.2026.03.23.22.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 22:15:23 -0700 (PDT)
Message-ID: <9fa40f68-54f4-d684-9e80-511c1ab230f2@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 10:45:16 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/7] media: iris: switch to hardware mode after
 firmware boot
Content-Language: en-US
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20260313-kaanapali-iris-v3-0-9c0d1a67af4b@oss.qualcomm.com>
 <20260313-kaanapali-iris-v3-2-9c0d1a67af4b@oss.qualcomm.com>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20260313-kaanapali-iris-v3-2-9c0d1a67af4b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GIIF0+NK c=1 sm=1 tr=0 ts=69c21ded cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=hbzS8gabZINpAvasuVNEhA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=dE1MpONsbtOZy1RxgbwA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA0MiBTYWx0ZWRfX3gA803zn0SV3
 6TG33Y7fw64wYYe4PnJR/Cbtvw9FzwTCYzxP/Mjr4YJtPfgzsQu4opkgekPYBKXn9m+Qrln+HP5
 8mJPaeFJADGw2HbpOWjF7f4KzjyywbI7rhJ3DXLC/xFY67sF/0JKICfH9+XWBBhyCGqyx6cLPQB
 T94+S4kInVYD8YxQcJjE3A6GTT3mVGlImmNWMLDnoBgdN0uhIMyptAGPRI+xPDx/qCj9S5en+Tg
 Fxw2CKRoAKYL2yx7FW8mDGdo3w7xF2BtWJIhf6Ux/zf6QI2/HRoJZQgnZ9snb8mCtTr0whQU1o5
 H22o4vYZGeNy6g2tARX+GouVR4R3aqkpvGC8Gcv3xZHvjm+brSeQceiPeJY08a+HQk3/0H72Css
 kkHmFhu3OMJVV98FXm2a4qSzUqYFiIy5Macwrhp5TrCF4oyvuWdSqQft9Y+6hT+LNJr32e8sgVD
 3KbPsrbf21iEdkDQzlw==
X-Proofpoint-GUID: zx6jZMydXAmONGZwfDDe4vn-o4n3XuTl
X-Proofpoint-ORIG-GUID: zx6jZMydXAmONGZwfDDe4vn-o4n3XuTl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_01,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240042



On 3/13/2026 6:49 PM, Vikash Garodia wrote:
> Currently the driver switches the vcodec GDSC to hardware (HW) mode
> before firmware load and boot sequence. GDSC can be powered off, keeping
> in hw mode, thereby the vcodec registers programmed in TrustZone (TZ)
> carry default (reset) values.
> Move the transition to HW mode after firmware load and boot sequence.
> 
> The bug was exposed with driver configuring different stream ids to
> different devices via iommu-map. With registers carrying reset values,
> VPU would not generate desired stream-id, thereby leading to SMMU fault.
> 
> For vpu4, when GDSC is switched to HW mode, there is a need to perform
> the reset operation. Without reset, there are occassional issues of
> register corruption observed. Hence the vpu GDSC switch also involves
> the reset.
> 
> Fixes: dde659d37036 ("media: iris: Introduce vpu ops for vpu4 with necessary hooks")
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_core.c       |  4 ++++
>  drivers/media/platform/qcom/iris/iris_hfi_common.c |  4 ++++
>  drivers/media/platform/qcom/iris/iris_vpu2.c       |  1 +
>  drivers/media/platform/qcom/iris/iris_vpu3x.c      |  9 +++-----
>  drivers/media/platform/qcom/iris/iris_vpu4x.c      | 24 ++++++++++++----------
>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 16 +++++++++------
>  drivers/media/platform/qcom/iris/iris_vpu_common.h |  3 +++
>  7 files changed, 38 insertions(+), 23 deletions(-)
> 

Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

Thanks,
Dikshita
