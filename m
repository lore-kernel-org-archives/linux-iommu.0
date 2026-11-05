Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885990;
	b=Unf8zlImZ9XrVpP6Jz4/k8PNf/5VaBS7R+0gwNVSmAq0VhkBBoxVN+jFM8hja5zOUhWz
	 bB8b1bFBwjFbV18A9UPRrrPcLd3JqdTtVAiYJfQMeO1eqeH6sCWs/XnFoqkCNdHFRmOT3
	 umERd7Ze8klc9XbVH3zolqWaAwzxcgtHkogR7rdKqE4P55Z6fHzvkqJqWPVWYvKEDf8sO
	 K4D9bGOol00ZqrQAaBv0c+6wgb5qflUATYj/L3XcGDMGb7hri++SruxumompdBjYXKShY
	 VeFsJGOVAnY0F0+VhJkGBCnatJ0x7GvrfAwNxvdCK84gi33l2fIw/DI0DqhKxrooCRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885990;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Ca75OONoSil29mOME3yxUZukBMpNuAXeGO/o4FyBT1k=;
	b=vzBC32nhfb1j/Ny7R96+qEQc6knLHmscyYfG9zM5w0nu1lXNdjgwo5qSTDk85nBIzdc1
	 jW1+mO3gDUh3qZNhLsAIJltiDRCVYLrD7uTcXgngHKlHcucG+mXWXGW6fT221uberteGA
	 BN+Z59zqPp9kaaNOnLkFUZxv3vSh8wKiCa/OaEFF+vifPqEs8R2oG7buO2d75d3qCwgfX
	 gLYGEUBAbdyhDscgz3B9xBNtBOYGZUe4yr1YjXzcl6lunqREHwcbP6NgXFjumWKf+BqZb
	 KxvryJySRpKuif4wqnV4FPzbZ2XfXa5h5WgEliu85HJCYb2SzLEnrjkKNERFMAgJJMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CClOpqWi;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ekEpDu2m;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3096F606A326
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 13:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3096F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CClOpqWi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ekEpDu2m
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tQMF433387
	for <iommu@lists.linux.dev>; Thu, 5 Nov 2026 13:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ca75OONoSil29mOME3yxUZukBMpNuAXeGO/o4FyBT1k=; b=CClOpqWiTvqkA03E
	ytnL7SM0+W+sCOnUnxqSaoBQS7OcqQR1mhJF8edLeQQtPhGLvG7IpgErn/E+4vrM
	l4HuE4tHLfdNcLfum8Gku0xiQJfBimzs/Cn+Ryam4yafeo7Ft6ly2Ub9vHiPMGvU
	O+KdHkf1LUD0sS0E4H+MbuDZ6z2uNOV3fx8MaU7Be0GlMrWnqh78rvsu1pSAN2KZ
	UEBWZBtl+uRBrivSlv6Eo9cuikEbxgdlwJ/6fazpYuprtx0gGIAsei8WL44Ya6DO
	KOC6WT5+C2hrdLZmmdyV7pqD5nqI3IEMj1X9YdzYEgMMMUacY+Vy08/oL704tM9C
	L19VWQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrmcd9t2n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 05 Nov 2026 13:39:49 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cdaf2073b0cso1064688a12.0
        for <iommu@lists.linux.dev>; Thu, 05 Nov 2026 05:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793885988; x=1794490788; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ca75OONoSil29mOME3yxUZukBMpNuAXeGO/o4FyBT1k=;
        b=ekEpDu2mcyKl+3d1Pkca6ad3q8O3iJ6oero3EE6XZNHcgz/5I60mPz2/PfYcZqyBtN
         +SGF/h377PUbtUyoNTeLFx51Ay5m63+4MNLWEzwHAxt6nKUAAweYciNXq4uK+GO5f52L
         KNGExtD6WwSlKp+GScRvcM63sqzBxauTRUA2STEN2+yiEVR5z5acVWwCi3e1C6latnBW
         8n/Bjyg+xcJOhprBqtf9ATG7zP711tPcpHs/eHVxOrIGIebCTt2oYivZzGGeAS00BkR2
         mTFyDyV0Ud3fTUmw4LQdtNwobplKcFHoimOHm0bpiGTwfGj0Rtki9OCnNxqc1U8rHHyz
         biWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793885988; x=1794490788;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ca75OONoSil29mOME3yxUZukBMpNuAXeGO/o4FyBT1k=;
        b=1p2cBe83k+T5db7GxcqXTifNMRDUQN3dibHBye8MwothGViEorXUDqVrsijImaa3d7
         p3sESm4doV8oeKG70ICt40V3PkimVMmIzZG86R5mI+b+sbvZ7+O9YA7vEqjoIqeKeG6v
         tiWhtQ4xsfZzns1/riM0KHYAowuqSvpqO1fQbRIDHOrqL/i2dSJlzVcvKyYPZ+TmRJfc
         n7gG7LA6AKKKZr6vP++290Yisr4tHefF7JwcZj9wBv8gnJT309fHj9B8Yc8N/bjmA97B
         /CcB6Sq4lHzVNivJ3SPITSf5YHei2xvVra273GtvAXcPSsg/UjmgT94MqLWzZEPqYiXO
         1pmg==
X-Forwarded-Encrypted: i=1; AKwUvByGvzjIn8maTJ1kJjWc7Ydc1OjSCEDkFAIcYu6lS0WQPX+qqGdhc/JvWmvxT3t6FaK+sGS/8w==@lists.linux.dev
X-Gm-Message-State: APuU4Z8m/Bkf61ldcCkpCAntochYjg+7rVUzoP8lNuWLsku9zkg7Sm6c
	qAo9yVS/wXK9nBLpZe5WQkYGxIM0FTvFKgFPPfhIrwUzO5wiW+PYP0zqjPK6PK5JjJYasnOJWNn
	K7E+/KLI4bWmqGn7U0dXrYzL3Xr2rJRezIjffuDSOS7h4H+6op38+fw1UFw==
X-Gm-Gg: AYBFou28nT7JcFsP8Pc3zHoay+mmY1EiVCJlUaRAxwsG+ArbIDqzNVUlzRqFMBi+r/v
	LoHpqWf7/LTrDe2VQvvHEyf5y6btgpuLQ5ol5v1o8ffSqdZ+A9CEwz4YowHnHdxT2hBklXo+8ix
	UMMPI2IE2ifTnld4chreJJ/mJZoQauU/+eAaD6domLgBXk8Q8wVW023WtykxSdp8iB2+JnMBzo/
	5r0t8kyaOAV3QvsFZ1TzumN4kPxg1+RorUGnMVieu98Ig1HgYJSIcPP+RK70CvHWx0zPtg7egwF
	h3f6ZOwLTyy73vUn/I8QPVvUmb29nktMUXqiJRqtZ/p9jS1suj2WNG6Gv1NtpNiS2YxVPujAII5
	d9uP2qvSglRFi005b5oP/fLrp+wf6ADj3zRXAbidBpkHKVBKuhiKkmYCIICaTP8lI3lDjM0kwyB
	Hq9g==
X-Received: by 2002:a17:90a:da86:b0:39e:21a7:5df5 with SMTP id 98e67ed59e1d1-3ae897f61aamr16476336a91.24.1793885987710;
        Thu, 05 Nov 2026 05:39:47 -0800 (PST)
X-Received: by 2002:a17:90a:da86:b0:39e:21a7:5df5 with SMTP id 98e67ed59e1d1-3ae897f61aamr16476312a91.24.1793885987137;
        Thu, 05 Nov 2026 05:39:47 -0800 (PST)
Received: from [10.206.97.48] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb4691d431sm2208325a12.11.2026.11.05.05.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 05:39:46 -0800 (PST)
Message-ID: <e7d81da2-c083-4aca-8fe9-38a068613ddd@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 19:09:38 +0530
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] of: Add support for "iommu-ranges" on a device
 node
To: Rob Herring <robh@kernel.org>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20261103-add_iommu_ranges-v6-0-361f3921a133@oss.qualcomm.com>
 <20261103-add_iommu_ranges-v6-2-361f3921a133@oss.qualcomm.com>
 <20261104160346.GD3951195-robh@kernel.org>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20261104160346.GD3951195-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EOGTQFZC c=1 sm=1 tr=0 ts=6aec8725 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=e-HLqTR_PI6rTb-hZFoA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: __h2m4NFuqlGC7j9bMXkLXgD5j0REJI8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1NCBTYWx0ZWRfX/RKzmvkl8mkV
 TLkBDFfExVVzATmDNKdZZML/1zY9XFVqjtuK4uPHdGEqq2WgR7fQCLD9+AJltI4u5Z2Xa/MrUzl
 rUlSW94hoXJNlsl8hPEBaqta+lQYt8c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1NCBTYWx0ZWRfX+2j/qatD7BLm
 lwCY/KsBWR/WZ2GFwnWGlZS5nmUF7MxsgbPQZ8AbuTwqEfvtn5RRecTlM8rAehM4Ugq6v+3ssFW
 jvCPu6TsBmFBXhle/DCYvf0gYUataMRXjSafE9ZxyHtshXRNy52VjCuOdiIR5wZYMshr2ZR9jAZ
 KCgZrVLk9y3Fgh0irbL8fDJDAWmNHY9g6Qa3i/ER58MJOzhKfce8LMj1j6DhkdbV/3BATwSY6dK
 9BKnuG+vp1h8Be1Drko+PJNGxDRr9CVSJXbunH842cDzyML7cd7sZat018ADJUjOv6CEeCV/0Kn
 z+sefTcKWnqUi3eM7e4DICkTcB4rEfSK3Cz/GCHbAwNsg5PSO7dfTUDiDsrMA9JjG8bYP6lyeZb
 YA+D1NFzWKsEFpl989tg+nh+6+Pf86U2tOOY9hnLvSUfgcohIcbvyb3bCSs2znaZ5JGRuQjtY02
 cGjA6WgTANT54CUfLCQ==
X-Proofpoint-ORIG-GUID: __h2m4NFuqlGC7j9bMXkLXgD5j0REJI8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050054

Hi Rob,

Appreciate your reviews/suggestions on this patch.

On 11/4/2026 9:33 PM, Rob Herring wrote:
> On Tue, Nov 03, 2026 at 08:59:33PM +0530, Vikash Garodia wrote:
>> Reserving an IOVA address using "iommu-addresses" requires it to be
>> placed in the reserved-memory node. But when "iommu-addresses" is the
>> only property being described and there is no backing "reg" (i.e. no
>> actual reserved system memory), it does not really belong under
>> /reserved-memory. A device IOVA range is specific to its own address
>> space, and does not describe the system physical memory to make it
>> qualify under reserved-memory. Given this, place "iommu-addresses"
>> inside reserved-memory only when it is paired with a "reg", otherwise,
>> define it within the device own node. It was discussed here:
>> https://lore.kernel.org/all/662f7093-fb0a-4564-9ca0-98e03e68ba9a@kernel.org
>>
>> Existing "iommu-addresses" property expects a phandle, which does
>> not make sense when the property is defined within the device node.
>> "iommu-ranges" was introduced to specify the device specific IOVA ranges
>> when there is no backing "reg".
>>
>> Suggested-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
>>   drivers/iommu/of_iommu.c | 134 +++++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 125 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index 5c266511db78910d6fd221af5437cecff4931c22..0428ceb50dec58f11872b4fb64e283fa8d9046a3 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -185,11 +185,118 @@ iommu_resv_region_get_type(struct device *dev,
>>   	if (start == phys->start && end == phys->end)
>>   		return IOMMU_RESV_DIRECT;
>>   
>> -	dev_warn(dev, "treating non-direct mapping [%pr] -> [%pap-%pap] as reservation\n", phys,
>> -		 &start, &end);
>> +	dev_err(dev, "non-direct mapping [%pr] -> [%pap-%pap] is not supported\n", phys,
>> +		&start, &end);
>>   	return IOMMU_RESV_RESERVED;
>>   }
>>   
>> +/**
>> + * of_iommu_derive_resv_regions - derive reserved regions which
>> + *                                are outside of iommu-ranges
>> + * @dev: device for which to get reserved regions
>> + * @list: reserved region list
>> + *
>> + * A device can describe its own usable IOVA ranges directly on its node
>> + * via "iommu-ranges". Everything not under those ranges is derived
>> + * as a reserved region so the IOMMU allocator won't use it. Entries may
>> + * appear in any order in the property.
>> + */
>> +#if IS_ENABLED(CONFIG_OF_ADDRESS)
> 
> Is this really needed? Assuming CONFIG_OF is enabled, this is only false
> on Sparc. I don't think Sparc needs anything in this file. There
> aren't any IOMMU drivers for Sparc unless COMPILE_TEST is enabled. So
> maybe building of_iommu.c as a whole should depend on CONFIG_OF_ADDRESS?

Agree, that's much better than adding the check, will drop from other 
places too and make it conditional compilation.

Regards,
Vikash

> 
> Rob

