Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A559035B653
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693797; cv=none; b=G6r59xEdGmjD3Kedl36a38WdM4SMZnFm6h4aDjvT0NuoKnwA1RlEiGmT5rPojFp46SAJS9gFuWZVxaQM2AlIy8oqRMrcDCvI+J23b98WNgqpHqU/caP/v6ycmM96W7oUfE86UVpAbZfZrSYpsJACvMiF5r1XBxXsuvtxsIsrcz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693797; c=relaxed/simple;
	bh=MFjbkJTZcf0W5RN6m5rEwf61YAjBi4ZAenyKuAV8xLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVAGx5tT/qmTZse5keD36HOF5RjRzIbDT68fDAGsX1tJVl/SJYhaNPlKP1Mg/PH+xAGahhJzqHBd2qB+4q7ziSi/09zjY25IYDiafuDzLddyGgn+NFCt01fC90r5faATrwQUonpZnrHCKjw6d5X5xuGD5TKDF2w6vuZhLmDIJLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KNSCQwRK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J1Ldq7mK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KNSCQwRK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J1Ldq7mK"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K9J48Y785491
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 14:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qmwoyEYOD3qeVLU9J7onMjI6vup1YjLazMtiXioAv4k=; b=KNSCQwRKLR5tCprq
	ji6xxEgwvaDWbMmkITYQ0Z5gQnvVxx90rqTjCn18qoU9e7DRFbDTmd9XBoUAq99m
	rjOfGuzBT1ikoHlFJLpLPcxpx2rbcPPEI6g5vk2PMxSEO4i5lzN0NyFwKewvaTcH
	kcWZMVrKtWfL8atNIobs8ePKv9ddL74B78TyWkPyw8R67RPuIfKgaiGg1LI8LitW
	t453K+AiHNr5s3wPBACAVmUsj1F4jz4hanEb9kEw+NzB/9K4Z+CO0Ll+nNOkGoVX
	m1SXQKkW9lajC2AABAIir2LvQ2K6+jUSoCuCTIRYtqVN3VjLBk4lKJPpUpOG5DK0
	OxGqNg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnhdhgymp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 14:03:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b465bf993cso31562425ad.1
        for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 07:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776693794; x=1777298594; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qmwoyEYOD3qeVLU9J7onMjI6vup1YjLazMtiXioAv4k=;
        b=J1Ldq7mKYdVdWqm5revvqwVK3+Uy8T21dmfzpE11SvAmi34xZ/4+tosk45be4eZ+gG
         K8k8n8GykWn3jaDAmKU2xSIw/C/9VWDfAVLiOst1ohFV2T2Md2QWdwriO1WGZxcC26Yz
         aSY0nukcIYQZ2HHO2wRR2zz55q+NhWFZ3VmJgoFyJyBiqnO3wSYsWVQyHi5ftEBIkASc
         PJUI+rOoVkXHZ0xu0tgLsbH5uQIK3r4+FCwRm5pL7ydr3NfOK36+ZHrz+JeQoNzcGh9H
         JBPxJ7TZMe9vCRwauefRlODbxtRvkABraW784IAVjae4CHv620/uwiTk2aepd5GKxy51
         xTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776693794; x=1777298594;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmwoyEYOD3qeVLU9J7onMjI6vup1YjLazMtiXioAv4k=;
        b=Qok0iuhNWRW+ScnYTr3n7j2YSJB0VLmd8UV2VoP2EH4wnKqaOoDaLk5qy1ymLM6v3c
         6VY81TcbefxZ4hmYdLZPIr36j2jm05TZuKZVB38HUdyf58wmo/2haq/ZQBFQ76qQK20z
         lSknT0N+g7MyPfseHtOBsMXiNO+R5mhcDQgnJBsO53hyMqLXpXbY0ra4H8fMfG5SApj6
         K/FYfSPZBi8bdAT6R9a+XNUAH76MQLVgr3God5pc57De+gb/EBSl3SpuqxNAH68OYQE9
         FHxJkGqKs7ONDq8WrYQEwCo1XyrIs9U7UtL9x5TboRe+KwmLxccjPQ5B4fFUPBbj88nj
         +jBw==
X-Forwarded-Encrypted: i=1; AFNElJ+feXz6DoTPG6sr2OOGgOqoACZAIU3PuuACJOvimMKjCq4SdLCvCYpDvMxiv+bF+/mOVDeYyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzbG3znGxT6QH/4CJhQ5Vqesj/xMPJAqWOXyh8KhMGOPsX4N74f
	lR6o7/unxgA/J5pJdqIMXdKOpVxpoPyg5jibb2w1kBS4r4MuBdcbKcp7MgMmksLIRMdSH95BlvE
	aLtTipFXhZyIAtMxU4r5D0I0QuTPalNuMbQoQfUipVA3YcOjoTPCqWZ9ztg==
X-Gm-Gg: AeBDiesXuGruGft4vzAkeTO25ReRgzmQM8m9Zej+MLC2XWwNUduwk9nWGqz9d6VgTeq
	m7HcxRLVoUcfRTIjVov94S/c+woWume+r/5IBZNdJCT8yxqlx9sT+VDszq7ziTy+9aE3nBcpycB
	j/Sn/nplBiD7uhqSABY8FC8yh6pjZPGzMdrn1o/MlVBpqTqzv1KeOF0CxIiq1pOh9eNG55NDp0Z
	sEYve9zjRD9dMoJajb7LuQy6j8yn3t1uk0gbligs7AsV/WlaX9ObLaiGLxOBzVk5gnNH+O1RYqZ
	Y4S8+d8CH/iyktQk9aj1RSaPPgnJONfhdaw8CJrqvVQYFD2Wl0c8jxStd+edK1vUJRb0nAuPkfP
	wDNjAusi+dqPLFjurfmUqYJJcYmXROlq1W+WvYkOvJBXlxU4FBzF/9Pod5NVrh3G2
X-Received: by 2002:a17:902:ef11:b0:2b0:67cc:adc3 with SMTP id d9443c01a7336-2b5f9ec6e37mr132050695ad.14.1776693793823;
        Mon, 20 Apr 2026 07:03:13 -0700 (PDT)
X-Received: by 2002:a17:902:ef11:b0:2b0:67cc:adc3 with SMTP id d9443c01a7336-2b5f9ec6e37mr132049645ad.14.1776693793075;
        Mon, 20 Apr 2026 07:03:13 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa34ea7sm105061225ad.34.2026.04.20.07.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 07:03:10 -0700 (PDT)
Message-ID: <bab7f899-dc05-7c9d-aed5-fed1910aa32b@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 19:33:01 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 04/11] media: iris: Add helper to create a context bank
 device on iris vpu bus
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-4-7d3d1cf57b16@oss.qualcomm.com>
 <ie6dad3xewm25gdrqqne2fsroopu3jwgrqmu54sfzjliis6mo5@6qsgagvyynwx>
 <b0ba2172-3f66-c912-29e9-0a48b4480987@oss.qualcomm.com>
 <sqg2db63gsjg3cxfdfbmndhxibzlprgviarbcl4l6isza36nc3@ljgg23nkuooi>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <sqg2db63gsjg3cxfdfbmndhxibzlprgviarbcl4l6isza36nc3@ljgg23nkuooi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: M4zOv5hihIn_T1umqkf4pP3pe0e7pPec
X-Authority-Analysis: v=2.4 cv=IMgyzAvG c=1 sm=1 tr=0 ts=69e63222 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=N0hD6JmQrVrYO7jJexcA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: M4zOv5hihIn_T1umqkf4pP3pe0e7pPec
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEzNyBTYWx0ZWRfXxYzL3vXlIN2S
 9vIVlU7FX8GTybrT1YGcvjYSYuDg8Ma6IswbaKMrPvaZFE3cfhHj469PjHvki6VH94fl+ypLkQX
 mCh99v2Ddyy8BOV/1+bQSOhr1YUwP9gseHvJFJ2zopalUGk+WmgLuwiKQC0qy4dKqxljgr70fAL
 /RMs04PxeKmCbxnazt+CyhXtqyvPknRczIGzNlWmFz0NUxbMIUkR9CgcEYRXNQ7OEl7bUtVBsVl
 XU7YMAgLXxdwMHBMI9lhQnjE6i/cfr6Z71l5bviXWPU3TvMFSZ7kSRMV9b4VioYrmDjX83RoeH1
 cmQKpKy0Ld1cgkBA0UQBvy16cH9KufGdQUpYMGvafTezMCgEJpLgiOxAfrAJkn05oqU4qR+fdKN
 B8JBFKt3mwFX6TdRmwNyzyYTBurjedH68yCsWiIA6uIXZZrXt0SH7vIDfIom55Y5Tgh/zz8NVGt
 WlPPtvcVS+Z/uPEFXJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200137


On 4/17/2026 11:53 PM, Dmitry Baryshkov wrote:
> On Fri, Apr 17, 2026 at 08:49:44PM +0530, Vishnu Reddy wrote:
>> On 4/14/2026 8:48 PM, Dmitry Baryshkov wrote:
>>> On Tue, Apr 14, 2026 at 10:30:00AM +0530, Vishnu Reddy wrote:
>>>> From: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
>>>>
>>>> Add a helper function to allocate and register context bank (CB) device
>>>> on the iris vpu bus. The function ID associated with the CB is specified
>>>> from the platform data, allowing the bus dma_configure callback to apply
>>>> correct stream ID mapping when device is registered.
>>>>
>>>> Signed-off-by: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
>>>> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
>>>> ---
>>>>   drivers/media/platform/qcom/iris/iris_resources.c | 33 +++++++++++++++++++++++
>>>>   drivers/media/platform/qcom/iris/iris_resources.h |  1 +
>>>>   2 files changed, 34 insertions(+)
>>>>
>>>> diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
>>>> index 773f6548370a..a25e0f2e9d26 100644
>>>> --- a/drivers/media/platform/qcom/iris/iris_resources.c
>>>> +++ b/drivers/media/platform/qcom/iris/iris_resources.c
>>>> @@ -6,6 +6,7 @@
>>>>   #include <linux/clk.h>
>>>>   #include <linux/devfreq.h>
>>>>   #include <linux/interconnect.h>
>>>> +#include <linux/iris_vpu_bus.h>
>>>>   #include <linux/pm_domain.h>
>>>>   #include <linux/pm_opp.h>
>>>>   #include <linux/pm_runtime.h>
>>>> @@ -141,3 +142,35 @@ int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type
>>>>   	return 0;
>>>>   }
>>>> +
>>>> +static void iris_release_cb_dev(struct device *dev)
>>>> +{
>>>> +	kfree(dev);
>>>> +}
>>>> +
>>>> +struct device *iris_create_cb_dev(struct iris_core *core, const char *name, const u32 *f_id)
>>> Please move into the bus code and make it generic enough.
>> Do you suggest to add a wrapper to pass the varying inputs to the generic
>> bus, something like this
>> struct device* create_and_register_device(dma_mask, parent_dev, *release,
>> dev_name,...)
> Definitely not the release function. The devname is also not that
> important. The rest, yes, you are correct.
>
>>>> +{
>>>> +	struct device *dev;
>>>> +	int ret;
>>>> +
>>>> +	dev = kzalloc_obj(*dev);
>>>> +	if (!dev)
>>>> +		return ERR_PTR(-ENOMEM);
>>>> +
>>>> +	dev->release = iris_release_cb_dev;
>>>> +	dev->bus = &iris_vpu_bus_type;
>>>> +	dev->parent = core->dev;
>>>> +	dev->coherent_dma_mask = core->iris_platform_data->dma_mask;
>>>> +	dev->dma_mask = &dev->coherent_dma_mask;
>>> Would you also need to set the of_node? See
>>> device_set_of_node_from_dev()
>> It might be needed for FastRPC as they are following sub node approach, Iris
>> does not need.
> Wouldn't it save you from passing it to of_dma_configure_id()?
Iris will pass parent device of_node, setting parent device is enough.
>>>> +
>>>> +	dev_set_name(dev, "%s", name);
>>>> +	dev_set_drvdata(dev, (void *)f_id);
>>>> +
>>>> +	ret = device_register(dev);
>>>> +	if (ret) {
>>>> +		put_device(dev);
>>>> +		return ERR_PTR(ret);
>>>> +	}
>>>> +
>>>> +	return dev;
>>>> +}
>>>> diff --git a/drivers/media/platform/qcom/iris/iris_resources.h b/drivers/media/platform/qcom/iris/iris_resources.h
>>>> index 6bfbd2dc6db0..4a494627ff23 100644
>>>> --- a/drivers/media/platform/qcom/iris/iris_resources.h
>>>> +++ b/drivers/media/platform/qcom/iris/iris_resources.h
>>>> @@ -15,5 +15,6 @@ int iris_unset_icc_bw(struct iris_core *core);
>>>>   int iris_set_icc_bw(struct iris_core *core, unsigned long icc_bw);
>>>>   int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type clk_type);
>>>>   int iris_prepare_enable_clock(struct iris_core *core, enum platform_clk_type clk_type);
>>>> +struct device *iris_create_cb_dev(struct iris_core *core, const char *name, const u32 *f_id);
>>>>   #endif
>>>>
>>>> -- 
>>>> 2.34.1
>>>>
