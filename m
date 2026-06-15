Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7352E7374
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545918; cv=none; b=OvdZGAQFto9mJCiWJrlvtHNpGfWwPIrhr3j3MCJ+w8xiBs+Ul2NbvWOV3hitmeQBrpXeCVacCx78kmD5+ldzcdt6sEhhZ+egC2KSYYWy6Mzl7DHvOszjCmIktIxyjOI/xOh+swBqjENTQ3pJiqdMO3zJvmeIuNKoTiemuWQvCb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545918; c=relaxed/simple;
	bh=jRBOymtAD5Zax1YDEFOJtJc65qKSsvi6ja5n8PcXrVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=McmTB+XQhyLMWAgneXXLDz3cKihJY0fbpzzvnbXAsvRz4CVsd4/uJYtI101sWmFKI+qlnvvi8Zu32e0KpHXgbvVv8EyawRQbNK1Fl4/5h8WskzH8Jae1Um0AlGHDW3529GB9paDGVzJ3+AsK2E700Zemp5giuoBc58ELne20Ll8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FCu358r/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hsEmgNZa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FCu358r/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hsEmgNZa"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFiVCY956315
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 17:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qZK8gIrw4sJMg/RWkW+3S8oTqB2g5fpkwTdzQW5NIdU=; b=FCu358r/FhlaTP/4
	EccVyTT3a7iO4ApIbAMOZTtgMr0frC6jDMn/q9I9ciwAPlwsMiiAqn3KrK8rANW2
	9DYhyonELhphHchHBQi7m7a6v9iaMMD8zYGr6sa9c+8LSKtRrThdimDa5k9SHgH3
	Ubvi1wWUdyn2LnDieDXZX7nw+Tx5hGylzcP8rxfKGntBExIjcbevQhIy5N1hYlIz
	X4D4LVNTIDtukzSM3oIyGM2q9loEIcjnetdkBy0kaNsUq4vsr5CdS1HEyqBlPQkw
	6Q1R7/4xcVD9kViNdIvLm8XfD0j0d9ZrMTVHD8fa5w+sWoZC0Gs9DvH0mR8rVkaP
	C/taZQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eter225xy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 17:51:56 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0bfcd629eso41916585ad.2
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 10:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781545915; x=1782150715; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qZK8gIrw4sJMg/RWkW+3S8oTqB2g5fpkwTdzQW5NIdU=;
        b=hsEmgNZagtPBrHylNwDRUE9wbnaILhZul0b0+YYOF+S8KeoAAM/HkV9Gt8x1ZmefDo
         oP5u44zRM0/fowqomXaMgdm8IJKpQn98UaaDn5ufH6ewdMhFkBq/sTURmnWz80GRpygk
         jCkuSgaP/yNOM0vJUSg22m/dnCnzCbynKRUrE8Yd3z7PZ4Z90RoyrcEfQPcxlcE/+Ubj
         hF5z3/9lgnQvZuT8ILAn1AK9yH3lUDNNXMhE10onsyl6y7uCvL2wyxDdorUY5zixnzBU
         bnffUG9NjYdl0CnBfBbay8sX8QE8Cy33Q48HrHFceUdO18CATmHnNpS+B32qP+2vTTmM
         9vPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781545915; x=1782150715;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZK8gIrw4sJMg/RWkW+3S8oTqB2g5fpkwTdzQW5NIdU=;
        b=pNc47R65GAxliLjFotfH8hTYnoKqo3+NJyv7dIcO9FNiVv4YOL2vrRrV/QmKyMoOWk
         4DcjhukheoMNznXj+W7wjkuVJ1h3a42v5s/YY8tv0j2188c5P08p2u37w4nj+wthl8bp
         /M2LLnaR4QocxmE9kL34COXsDP0Bpc61NNaW7Bf02J9UTUabqc+BQHO3hnzYCmJsvmd9
         FxsFhZ9Q5U+McvLGtmutIGUPnjlrNdoLzUp8RVVuRo4AJcHOZbCAE0e8GMx+6oeUKxWu
         LfX9cVal+fRxtDdntNSaC59+CnNx/X3+vhAe2QeSWqeORoYihvutl+o4YA+EoYsnUPf4
         ytAA==
X-Forwarded-Encrypted: i=1; AFNElJ92/ft/KuYyBJOGC/1Q821nu4ETAW6MnaiMaTFHFTdtNMnsQqgUTwbkZl8RtiLv6MokZeQlVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywo+i3jDTrKvRhOTUJKirpwWjMNZMfly9LUxAUZ1SnfDjefBnL5
	GOZzA3HXwNQHrL4kTmeWcu/BKe0u1knvZnlFqf5mWns4UatVsQsZfo1RvUA0MtS2TM+XfGS1Dfq
	hJS/Q6lDyzOWnfMvkrohDoKD4/4BDf+ic67kXx2jFtGJ8/yBmhfut+Iv98g==
X-Gm-Gg: Acq92OEyQE4F8Pat3KLn4e1V1056obcKefkQIQhPpd+JjyoUox2HGz/4xkjMngs5WAp
	TPwTt0vQ1UfW8+RjupzCqLw3075YIl4TJ/wi82qIgKzNEBQY6R7Tr56zfg5CVnijbsrjeSgtpko
	OhtI8MA3LbW5YNeFy+BZ0OKG8HCKFCvfRiN9tB3A3AcHlqZWK2zbfqtNpj8bnuq23uKqMyKtbT/
	2O1C9ipY2wRspVaXX+jS8Uv+ED+3nWP7Mm9voI5XzdBdedZg1Zyq6+aIGQ00e5H9J3afS3+BwnP
	adjt+zETg1qiPwpDHuFjjxt5/3mI2cDp79ctKcN3l/OC6PEqJRwbGgfwaXTVUwFwvob9Su/zXR9
	ANtYYwVjv/mqjrkvw2paLys71EdNW/az1T5f/dAjuGh+TmiFhJJRU7DNS
X-Received: by 2002:a17:903:3bcf:b0:2be:39bd:8dd8 with SMTP id d9443c01a7336-2c66429433bmr125719765ad.33.1781545915150;
        Mon, 15 Jun 2026 10:51:55 -0700 (PDT)
X-Received: by 2002:a17:903:3bcf:b0:2be:39bd:8dd8 with SMTP id d9443c01a7336-2c66429433bmr125719415ad.33.1781545914674;
        Mon, 15 Jun 2026 10:51:54 -0700 (PDT)
Received: from [10.187.126.18] ([106.221.183.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c433460a60sm130287695ad.76.2026.06.15.10.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 10:51:53 -0700 (PDT)
Message-ID: <dcc0d02e-91fb-ddbe-399a-0191bab94c4f@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 23:21:45 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dma-iommu: Introduce API to reserve IOVA regions for
 dynamically created devices
To: Jason Gunthorpe <jgg@ziepe.ca>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
        m.szyprowski@samsung.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, dikshita.agarwal@oss.qualcomm.com
References: <20260119054936.3350128-1-busanna.reddy@oss.qualcomm.com>
 <cfd23f75-8952-4463-abd5-815b995031b0@arm.com>
 <bb59f07e-ca7e-f012-6a4b-0a148350b69c@oss.qualcomm.com>
 <20260612172649.GM1066031@ziepe.ca>
 <da77c21d-25b3-46c3-a48f-71f0549e9f5f@oss.qualcomm.com>
 <20260615125257.GS1066031@ziepe.ca>
Content-Language: en-US
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <20260615125257.GS1066031@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4OSBTYWx0ZWRfX0UPaH8auZVtV
 oi2vYKNezuoNwQ3MHwqVoxwr5+7MgOdrQ4EPBosQ1aA4J5LPErTtkV0Oz4D6fGrCUIbd5aZv6Mm
 qCZTzgyptdGeC9DCxOacXpnCdySu8GU=
X-Proofpoint-GUID: IZ9ey1B1DMiMjKqK3Vf0ZLOnVrQyA7iV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4OSBTYWx0ZWRfXxMBZ5OfN363Z
 IwhGXCztCC1eyePMk6GxXmWD/lCx8f0S3ELFMW8fG0lFWS/6beLryQ4Za0O9hQ205Iebnem2J9E
 Zbv3PxsSTtKEF8LuexBFoCsXyt8Pu0FqnoiWuqo+HXGwoToF4sCxE7bvjL71dVcRZTOFkGclUt7
 qpi5zUBTT7UzaH/2sgCe19m5W65R5QMiwsSzjAiqKHt5OccoRDcELGWraiM+tvItR17U/n+udbi
 7CRVM/xYaCpZon172k0BnNDgu7rdlyE02dV89KcTocmnNSpoi0WaiD99O2Eq4JmZpYxgxeIDQUC
 vdjhjAgTYYfBU+aI/C64t9BYDVM2hDZ3fxET3mR35AyUiQsaYEch9ohd5rSgKFSM2QigjENxnxm
 PSYtcVCXihvtm0GNjUz98KMh2HP9VsoIZdg9cNc89i5sWH6de5M7+/buxoMf3KWnWl7tYixxXqV
 fdnaaKcL4BSR5bP15ug==
X-Authority-Analysis: v=2.4 cv=F4tnsKhN c=1 sm=1 tr=0 ts=6a303bbc cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ym48ABLkKUHSTpi9L/JoRg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QHREdudD40185EaPPEQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: IZ9ey1B1DMiMjKqK3Vf0ZLOnVrQyA7iV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150189


On 6/15/2026 6:22 PM, Jason Gunthorpe wrote:
> On Mon, Jun 15, 2026 at 12:26:25PM +0530, Vikash Garodia wrote:
>
>> To handle such case, we create the device dynamically and associated the
>> distinct IOVA range to them,via the api introduced in this patch.
>> This was prototyped in recent SOC here [1]
>>
>> [1] https://lore.kernel.org/linux-media/20260313-kaanapali-iris-v3-1-9c0d1a67af4b@oss.qualcomm.com/
> Well, I'm not enthused by this:
>
> +static int iris_vpu_bus_dma_configure(struct device *dev)
> +{
> +       struct iris_context_bank *cb = dev_get_drvdata(dev);
> +
> +       if (!cb)
> +               return -ENODEV;
> +
> +       return of_dma_configure_id(dev, dev->parent->of_node, true, &cb->f_id);
> +}
>
> A custom bus and then calling configure_id on the parent which would
> have already called of_dma_configure on that same of_node seems very
> hacky to me.

Hi Jason,

Here, the parent node does not have an iommus property — it only has iommu-map,
like example below:

iommu-map = <0x0 &apps_smmu 0x1940 0x0 0x1>,  /* function_id 0 → SID 0x1940 */
            <0x1 &apps_smmu 0x1943 0x0 0x1>,  /* function_id 1 → SID 0x1943 */
            <0x2 &apps_smmu 0x1944 0x0 0x1>;  /* function_id 2 → SID 0x1944 */

When the parent device is probed, of_dma_configure() is called, which
internally invokes of_dma_configure_id() with NULL as the function ID. Since
there is no iommus entry, no stream ID gets mapped to the parent device.

The child devices are created at runtime and have no of_node of their own. The
only place the iommu-map property exists is on the parent's of_node. So when
configuring a child device, we pass the parent's of_node along with the child's
specific function_id — this is how of_dma_configure_id() finds and maps the
correct stream ID to the child device only.

So to be clear — the parent of_node is not being configured again. It is just
being used as a lookup source for the iommu-map property, since the child has
no of_node of its own.

Thanks,
Vishnu Reddy.

> Jason
