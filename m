Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC69E2F531F
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439204; cv=none; b=Ppmq0lXBeJimGuT/QtLoyqRt4x+aVMtHUqdWl+7tTxRMqARfUXxaFWMUK0fIjaXmIfBj5xyytRnGfr4GpbkbD11bwrZdr5b6JVCYsxQyPgR1nChNuAkKyRJYO9BgEYBC0NV3dy3fxai9E52pzoWD246n9B2xj0SHhR8Tb7BzHWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439204; c=relaxed/simple;
	bh=94H9O5bKpZJFIum9FyBi6L/m0YdYgTBfbD+IuzK2avE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=F1OdBGpAWdpRpE+B1YGbV35ovif+laGrki9cz3QQ7UjWW6/TX5q/mklcMDdygDaRY1FILZI7fRgHhvSP1CIhWBeiV7vR8DhA3rjRrw0gtHyWYY+JBVXrbgv/hs7++sYUJN+SCzJzYFuiMKxsT4NNPM/crG4+NmsZYtgogN53iHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MEHa0pWc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HH9BL/xt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MEHa0pWc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HH9BL/xt"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H8nqgE3100221
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Wig1FYIP1zNSkQ75Q9iE46JSnYQwQ+jz+kMS2CZwmk=; b=MEHa0pWcmt4NO+oF
	XIOI8kb+L/JodJtIBeDcElJu/+MpF8jpLDR0GlNqqApUe2eJajsKAq8JeaYtNJxg
	H/wN4Nt7BSzlq10yeH4HIALqtTsivmqxDZUgf8/bVaap8KD+DQXenT/t32cTdh4/
	s06CZFhAe+4OsroOecp6k++stVG3vDYZ2pwcGOPs7DndR7ccnKcgdYg2HNsfJ4/i
	vauSf8nkMEm5yS5MzHOpsHJ2uKxuXC2iOVY8XbEAHNt4A42yvyPbvtjNURUSUxaY
	ntoxZgsbt7aGdKmi3iMIkZaI3HSXN0pSu0Rw3DaZEdtgeVZAEQ5hsTyX05sPD94g
	TtjIKg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkhpu1afy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:19:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2e06219cbso9697625ad.3
        for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 08:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776439195; x=1777043995; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Wig1FYIP1zNSkQ75Q9iE46JSnYQwQ+jz+kMS2CZwmk=;
        b=HH9BL/xt1LNCVr00fssnCFghQ9cXiR6B7Vfgglp35IAyvjHtOVL9GuT32MfneT8wvZ
         kjXcLCZzn91TfWlJB3k62Zy/jCZQJvmNDmAXyhgsDH0Efvm5eXNSQkEvR+3c+VZ6n5WI
         o+zWt/6iews+Q/Q2yDkJ7OQFxYr6pczlvGhRujmNjnFgJtEaT4xvKCxxa9Q5xUeCNO8D
         zcd1KSEGDoLTbak1NssfehQXWeXHF1feB9fwRcnvyR6S5rywpscoBbTrC67XR5GugICw
         0pHor8sgR7qBeOb5WcV2DbpWiHaKVE/jGIxhfNKPYLwSRyEhky/hhcUDn0JcmHJxL+Mm
         WpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776439195; x=1777043995;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Wig1FYIP1zNSkQ75Q9iE46JSnYQwQ+jz+kMS2CZwmk=;
        b=TXPaUVghSAgBRI71dEMnI97V/ypWwxc2pdW34X8p+6CtGePPzRxM06bhAqhYyMLBT7
         6ngLytqbTzsWZSHFQpcjApi07HQIL3/nshd7dICrttDXU4bEqnwXY26yvcKCFx9NioAj
         2/6wULDRf5XS4ltih4ehICybHuHM/vMTSpRavcqWMxjGD0wEwPbiUj3cdXYpxtN6bVxO
         FszztBtrZ3IXDPNVjWvvoJBvdWv3qIqlUBzRewnd8lHM6OOzkSGtA4Xa3m2IxRbGs/a6
         25Ogr7SjIMXCv++upRjwmGZjSbaN/bfCDZc2Su5D09d1hSBpfiBpYkQdx+telEFMPfqi
         vTUg==
X-Forwarded-Encrypted: i=1; AFNElJ9aysqplQg5NG2O1Z5niAAhXMrmKjqqvs6Fjbgrw4yAFUY7aAzkukYxs+zurb8bXd2IZaAGvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNUouVIgMEz+6kH94jdZaWh/qkqnzIi1eMIEwqZOkUyjKRt6PO
	R8vVSgj5uMooUCYKjuErI+prQzyr3ns/oW/+5CCN3Fasnc0CkPwwhgG1NpmKo1Bo51986Oo4AAF
	6mGzBuES6FiLENb7nx/eQ8qBqLSdSxK3PQwiwu8VSlKej/GuAyZMRAjXZxg==
X-Gm-Gg: AeBDietL0sa43K2bIGH94A9Sxh1d7gj2qvmumkYewWwHgu00EFABfJyydl+U+DalrT+
	n/qU1PSb2zr3y/wEF6ar3mizJr2ZOmDhKhfJNO1bbex2ABasIzfeMKqEAUUptuKVu7wRSLpcM58
	PHSuRaPdLJc4ZqCJbLVDhqM4zxoXLhQVqjXy65MfdwHULjytewRMBLxwEwEsM/q0Dd0/6ZXw8Ud
	zQ+j3L735FHMYd9Y6Ks7qhdTw3rPbQnO3hFfcSpIhqXdOQOxre7UYYpAXhqlBN7kYg1CWc4GfVI
	cZIkBnKGNthFS7dL4D1D/4M26Jrpz0wXPZ71w49v/OrE4xX04f4t37Dw+6Rn7Nh8e2XJ1SQJPQa
	5QUhrhVzQtlSauh+gn2wF273T0dFuWeUl2tcIs+ItG6mZ/cf2qdpYi1tOT2bq4xG1
X-Received: by 2002:a05:6a20:4326:b0:398:b178:a53f with SMTP id adf61e73a8af0-3a08d8f5c50mr4016410637.40.1776439194902;
        Fri, 17 Apr 2026 08:19:54 -0700 (PDT)
X-Received: by 2002:a05:6a20:4326:b0:398:b178:a53f with SMTP id adf61e73a8af0-3a08d8f5c50mr4016360637.40.1776439194246;
        Fri, 17 Apr 2026 08:19:54 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebcc9easm3096856b3a.39.2026.04.17.08.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 08:19:53 -0700 (PDT)
Message-ID: <b0ba2172-3f66-c912-29e9-0a48b4480987@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 20:49:44 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH 04/11] media: iris: Add helper to create a context bank
 device on iris vpu bus
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
Content-Language: en-US
In-Reply-To: <ie6dad3xewm25gdrqqne2fsroopu3jwgrqmu54sfzjliis6mo5@6qsgagvyynwx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Kd7idwYD c=1 sm=1 tr=0 ts=69e24f9c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=JgkdHvVJu_VE_hPiJvkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: JQx5IZ1-kvHLg7Xl8oQTyQ2e4qP0GMPK
X-Proofpoint-ORIG-GUID: JQx5IZ1-kvHLg7Xl8oQTyQ2e4qP0GMPK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE1NCBTYWx0ZWRfX1vAyTGp+zOoy
 lpBNu4z4cYitONcl8x4Xx+gO+a6CGD6YYB1BrDif/pQgUShL9sH4VgNxOBOXWQ8mA0SghRLbXtQ
 b+msKlvuKJDxl6qBcsHLJbL1Uy1sy015l+0HRqRL0s8t1adG+lCOIHsWNlWnko7g56ts/yLrOcY
 UmOgZddtw1/Pql/tPiOKJG+5SZn3OHpeH0r2GgKSz5rZ04cOW+M02USSH/E6jXkobTR5VVZhj6h
 65sl6DMmSMnbJVlvVMoCnqDs0yJeAYml6YgNCkq+4ffZ96Wq6VQ2rwBIzXPk4pKmYsy0c2EVh9k
 GjG0Uop523FbTyic5ofR7Eu62fQPAUqcxxzkmMfVEwenhlKVaA69EUNK13cBmapYjGzJAnlmyoQ
 A+mjvRRrMmFf6c2T2hMxQ7vHffgFQdmTKoQKJeA9N6vjWiZcnKyOmhkVo2vYPVVTXM4D0XCZnmd
 lVd1fvWJ9WmCxsUqJ5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170154


On 4/14/2026 8:48 PM, Dmitry Baryshkov wrote:
> On Tue, Apr 14, 2026 at 10:30:00AM +0530, Vishnu Reddy wrote:
>> From: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
>>
>> Add a helper function to allocate and register context bank (CB) device
>> on the iris vpu bus. The function ID associated with the CB is specified
>> from the platform data, allowing the bus dma_configure callback to apply
>> correct stream ID mapping when device is registered.
>>
>> Signed-off-by: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
>> ---
>>   drivers/media/platform/qcom/iris/iris_resources.c | 33 +++++++++++++++++++++++
>>   drivers/media/platform/qcom/iris/iris_resources.h |  1 +
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
>> index 773f6548370a..a25e0f2e9d26 100644
>> --- a/drivers/media/platform/qcom/iris/iris_resources.c
>> +++ b/drivers/media/platform/qcom/iris/iris_resources.c
>> @@ -6,6 +6,7 @@
>>   #include <linux/clk.h>
>>   #include <linux/devfreq.h>
>>   #include <linux/interconnect.h>
>> +#include <linux/iris_vpu_bus.h>
>>   #include <linux/pm_domain.h>
>>   #include <linux/pm_opp.h>
>>   #include <linux/pm_runtime.h>
>> @@ -141,3 +142,35 @@ int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type
>>   
>>   	return 0;
>>   }
>> +
>> +static void iris_release_cb_dev(struct device *dev)
>> +{
>> +	kfree(dev);
>> +}
>> +
>> +struct device *iris_create_cb_dev(struct iris_core *core, const char *name, const u32 *f_id)
> Please move into the bus code and make it generic enough.
Do you suggest to add a wrapper to pass the varying inputs to the 
generic bus, something like this
struct device* create_and_register_device(dma_mask, parent_dev, 
*release, dev_name,...)
>> +{
>> +	struct device *dev;
>> +	int ret;
>> +
>> +	dev = kzalloc_obj(*dev);
>> +	if (!dev)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	dev->release = iris_release_cb_dev;
>> +	dev->bus = &iris_vpu_bus_type;
>> +	dev->parent = core->dev;
>> +	dev->coherent_dma_mask = core->iris_platform_data->dma_mask;
>> +	dev->dma_mask = &dev->coherent_dma_mask;
> Would you also need to set the of_node? See
> device_set_of_node_from_dev()

It might be needed for FastRPC as they are following sub node approach, 
Iris does not need.
>> +
>> +	dev_set_name(dev, "%s", name);
>> +	dev_set_drvdata(dev, (void *)f_id);
>> +
>> +	ret = device_register(dev);
>> +	if (ret) {
>> +		put_device(dev);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	return dev;
>> +}
>> diff --git a/drivers/media/platform/qcom/iris/iris_resources.h b/drivers/media/platform/qcom/iris/iris_resources.h
>> index 6bfbd2dc6db0..4a494627ff23 100644
>> --- a/drivers/media/platform/qcom/iris/iris_resources.h
>> +++ b/drivers/media/platform/qcom/iris/iris_resources.h
>> @@ -15,5 +15,6 @@ int iris_unset_icc_bw(struct iris_core *core);
>>   int iris_set_icc_bw(struct iris_core *core, unsigned long icc_bw);
>>   int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type clk_type);
>>   int iris_prepare_enable_clock(struct iris_core *core, enum platform_clk_type clk_type);
>> +struct device *iris_create_cb_dev(struct iris_core *core, const char *name, const u32 *f_id);
>>   
>>   #endif
>>
>> -- 
>> 2.34.1
>>
