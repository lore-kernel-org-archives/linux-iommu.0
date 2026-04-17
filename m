Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED60D325483
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439804; cv=none; b=NzLb8t4SUTI79mDFxEsqVXrxNul+KaU0sBbkR1de5SkH/OxUzobmms1vhLY97MPSaxCF/xJztkAm6b8UN40fAHCBTr2QxR7jyWrsWJbI0s+RuGDk+jSqinTopBD+EdX3lw9VapZlgGKPo8QoTXotYAYwLXuPAeKBDg2GGXjgJMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439804; c=relaxed/simple;
	bh=GMFw8UwlvWUDdGB4tOpqJjYQSXWL1VCmb5a+aZUVTx0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MVCrgBC0FaIuKRVc6PZ/IdGxeKjnYtR9AJ5SHm17sCgfA/MDJJCxECnZUOgx7kcoVSgIZHF7aLY20vs6iILpqc/amMIck4ODpTBKR5/Mot9iokafYiJBrtblrzVccPXbMls/Q9dVicGpS7mKAdeaEQkDsswogr2gQcSysg32WTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CrS8oMg2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CHL8Wmw/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CrS8oMg2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CHL8Wmw/"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H9kc9F1042262
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C1RZc4rE6GguQQXCpB0wcbOaTb2Bi4UlZ5HuicWVuYU=; b=CrS8oMg2o47dY/Mv
	p8xTqV7huanvPDeI9l4dOGNQsIGBuB7WohisKEWPAlWn1k+Bpub7XgC2v3oip/u2
	Y+kAWYK1v/AlbPm3l9meCMwxNuvqH8JEboV+Y3GA6WJ+EZGJOJPutNfqVcgGZRU2
	NoarZax3g17DUT+IRq58De/KuiY+jcqie3Iz9WyK2mxt2nLjc8kEIE3v+gKMXjgM
	pelWcGLuTXnk53/HAJMrlszoxOIQI2i9QfyliHWaCfWJvTmEKztrJdMLl6RL9PE4
	bP4HKeF8LnbPhvATwhJ9s+l85Y2wOCR73ocz3xJaJn8gO5A1FjumJqhD/kAZD37P
	DcZ32g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkjhds65u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:30:01 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2eba42b8dso7736705ad.0
        for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 08:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776439801; x=1777044601; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C1RZc4rE6GguQQXCpB0wcbOaTb2Bi4UlZ5HuicWVuYU=;
        b=CHL8Wmw/l24vELwuJ8wKzX0Y0TkpNTFvr+xpSMbeR50htBLKhsFe18FRAF6VXKKb1U
         GA1flK2J/l5sRdORbywFmNbwsP730PFZSBGNnHKnl3vJ10ZMO/l2kjfgh6JW77PabxzO
         hSRQOslVIz13XtvT37ExmTCPT9TBfay4qon3wL0UxXT7sHKAW1bV/kugXMLIn9BYJ+S7
         UYT4NsVVyf+RFNH00XaN1qi7N0/oTrfLHytI2dKvZBXHu7Ntdu5Z3OkAWGcG1PpuvLRa
         2OZxbOfXNY5P5PIRZRklC3l4H4tgixftnyt/YaFa9/uc59+64Iub99VEC0B31t7JN1GL
         tuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776439801; x=1777044601;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1RZc4rE6GguQQXCpB0wcbOaTb2Bi4UlZ5HuicWVuYU=;
        b=bOQ5TXbCYQKH+1/os88ujfwJ9MUtjKAJbRIeMkCeBMgfxIwqFXP3nQjiXiZdrCZhr6
         4GVTKzJgSHsyPzB01jr3rA5QyGP9Q7hEMIPV0j0mHhVYKdq7vhYDu9UlA3vAoreXlALD
         YmO1Fux8oKP4881WeGv+iv52p73zoiHYqm+KeYRgS8V0PCDO0XcguNz0Dk1Hr9A08Z3n
         ghAwiCqLHArIGxLyO4eb4RDiw+BK0rM2vStRTCqUlDVqxkiPa3aYqDy7ujDgcunSOClj
         4UKzp0hq2fIupqp31zWS4YWW/WLLAXJUHuEye3emiLWQu2l1l9f5CTsITycr16Tpl6/J
         9wcA==
X-Forwarded-Encrypted: i=1; AFNElJ/KEUCfXDWPogHBrWFQG036n4kby8yJrlhBk8Esml7JSph4hsGzjwzB46/gL6GITmpGZKYoXw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywi7TEk7w9FMXMX5Hbtx8OFr9S+pQBp0QWqKqaJcr2eXo0CoiKC
	epWicjR84JcUX4T1fKQxQWRMIffQXQ/J5s//TZlx94tPxcxuuuEglgI1NBDN4l9EV9zjqOCHhRk
	oxLUY0MjKJlGfpXKX3FOzIBloIU0uOBHt+Vw1cWyheRzDQans3bbKAQ8+ag==
X-Gm-Gg: AeBDieu4joe/lhzWQZdcz32ko4SaTswzJea6YwxJSXJM1NzfH0znl/2/qwMl8/f75Ib
	hQVtIVAayku08Ck2z1+0LpETE8mMaacLgwUf354MuEoeeGZVQae46O3tjV/8wenT9+RPJf9hnH7
	JT4YqEQq1aDN0fyhX5cwvxpaNrQMVmrlW1sMy+RlIYNGP4O4lr9m1LLEtMu3mUTzV4Del6K6JBL
	JhcCd8PC1IuJXW0mVI0fBzfW2TFShy6H04CNXeqKwwNB9YG+wrw4bkkKDZqC6LxnIHLi9qFV9gt
	hBlVQMQHV92VzD/jwTRSTUN7GaSzRyK6QBhyhznlBjLeUNeTJsR9CLEf2eyboCQmJ0RRlqN6iPZ
	GOzta81WgNewjfGsTEG74gQo1NVaqhR7PJt92L4JWBCheXBXWTTOYq5sjh8GTBDaF
X-Received: by 2002:a17:902:c211:b0:2b2:d5aa:e373 with SMTP id d9443c01a7336-2b5f9ed0d19mr26411895ad.14.1776439800785;
        Fri, 17 Apr 2026 08:30:00 -0700 (PDT)
X-Received: by 2002:a17:902:c211:b0:2b2:d5aa:e373 with SMTP id d9443c01a7336-2b5f9ed0d19mr26411675ad.14.1776439800235;
        Fri, 17 Apr 2026 08:30:00 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab54c2dsm21664015ad.83.2026.04.17.08.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 08:29:59 -0700 (PDT)
Message-ID: <06395bd6-b3c6-fcc4-bc5e-9e4faa50fa99@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 20:59:50 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH 06/11] media: iris: Fix VM count passed to firmware
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
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        stable@vger.kernel.org
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-6-7d3d1cf57b16@oss.qualcomm.com>
 <otikvdonnfakykra57z4fingdyfm7xebw2h3lmykzk6sbk7emq@xptiwpx5lvjl>
Content-Language: en-US
In-Reply-To: <otikvdonnfakykra57z4fingdyfm7xebw2h3lmykzk6sbk7emq@xptiwpx5lvjl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0qE1x1I3oL-syQtyHO1l1hKPnpdGXspg
X-Authority-Analysis: v=2.4 cv=YpQ/gYYX c=1 sm=1 tr=0 ts=69e251f9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5Xy_6AgtP5T3jK3p2aAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE1NSBTYWx0ZWRfXyhYSYDCsyZge
 FMBbfIqteH9iHlk4FYQ0d85FXgvCgHJdofIcKOumgtrZuKU3MNE7VjltRWeQWsvvGnvaoYYmtFH
 mbg9XtuLaI8sLD4utez1BsJnvpMBsjpzNVYiOgAIkYJ3rRSxacNxxuPe7UmIaCJFkNGZZO9CCmi
 Z+c2+rGq1Wsx1FR20GwJmSEoK6vsCpDO71EZ3UGJe6pYHLR6pg57aHw55xQ3INEr7EqGr9/IUtM
 YUfG1CLHelOy8s0/93ccybwujIlcgtnmP14aZnsGA94xQwNDOMqzQMfJ7I91QplBuNEvnst69kV
 +PqjlVKFYMh3Hs6vjX5tf8/zJqYXlBoJRkDP1xBtwrG1eKzhKU0pJm2ExCG4Btpk6928iaHIkO1
 n/QN4cH96eq3tc3tqEjKwilQdz+Lgvm4EqbjtVGKeCbRrVLQaFxnPlAFzRpEBL3xyKES7MeDvFx
 12nukz6VX99Q+BjCwgQ==
X-Proofpoint-ORIG-GUID: 0qE1x1I3oL-syQtyHO1l1hKPnpdGXspg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170155


On 4/14/2026 8:50 PM, Dmitry Baryshkov wrote:
> On Tue, Apr 14, 2026 at 10:30:02AM +0530, Vishnu Reddy wrote:
>> On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
>> the number of virtual machines (VMs) and internally adds 1 to it. Writing
> Does this apply to Glymur only or to other platforms too?

Only Glymur firmware is currently reading this register and other 
platform firmwares are
ignoring this.

Thanks,
Vishnu Reddy.

>> 1 causes firmware to treat it as 2 VMs. Since only one VM is required,
>> remove this write to leave the register at its reset value of 0. This does
>> not affect other platforms as only Glymur firmware uses this register,
>> earlier platform firmwares ignore it.
>>
>> Fixes: abf5bac63f68a ("media: iris: implement the boot sequence of the firmware")
>> Cc:stable@vger.kernel.org
>> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
>> ---
>>   drivers/media/platform/qcom/iris/iris_vpu_common.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
>> index 548e5f1727fd..bfd1e762c38e 100644
>> --- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
>> +++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
>> @@ -78,7 +78,6 @@ int iris_vpu_boot_firmware(struct iris_core *core)
>>   	iris_vpu_setup_ucregion_memory_map(core);
>>   
>>   	writel(ctrl_init, core->reg_base + CTRL_INIT);
>> -	writel(0x1, core->reg_base + CPU_CS_SCIACMDARG3);
>>   
>>   	while (!ctrl_status && count < max_tries) {
>>   		ctrl_status = readl(core->reg_base + CTRL_STATUS);
>>
>> -- 
>> 2.34.1
>>
