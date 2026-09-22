Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189FB48488E
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100624; cv=none; b=XJZFNt/f/Bvy2fbqOOWZSUqkCPi0PlCNeit5X3fmFuqdshVF1Ft5kB4azqhmn0HdCjnO11nDIdgcU4V0O0/AHyiugP1rT5ujn0XzLPSBb8/n1NWk4dZp1epSCR2wZ5vRhkCFfHtRaHTFV0UPBENMHTPn+OA4VKPC+PqxvC4abug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100624; c=relaxed/simple;
	bh=Lhqa5FPuJI/7ZwHwFoc5BJR+w4pkCdSYjJUWN29IEeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=na8VXiHxpSzA2LKklKa/3VT+Xg9Qu6gMsMMfmVuq0b/0el4FNn9sjY9eHs8tBEipb6HQONHCjFH66qX56B7hQ+/T6o45cEmExD90ZyvvZb9SpaRnAIxMdwlwI2oVAooVoCFBQWv2L8kC7XY7Vt/c8lyw/sBh+B1wZkvYGMBYWMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XFYlyaf7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eLVlx3ZU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XFYlyaf7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eLVlx3ZU"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MI7CD0368055
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 18:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cMGKbEn4nCSVnNp4HH/7UejWSUwgcuvmnhDSDi2jIhg=; b=XFYlyaf717HVkhsH
	x/3xzhnZ591xx/EVvHKtXKpI9L+0t46d6c21gZ1K5QucT95MNcJ5cRR746X8XctU
	Mok2bflXxqBsMLYrE0lw88JSiGXhL1pyPEzYYjrUAoU3tZTqfwHxW6SfYdgBc3zP
	pbGSUU/zsY7Nkw/z2Rsv8Go65VUw0Pguxo2Ee+Tq1bzpAQp13ta+ERJQXMoNWZEP
	h/RlRcUUQyugbTiZVvam6M237EXum+CzYK7RY0rsI4HOjPALDl5Lh4N3srgj8e9P
	v1ZqcYJNNTuSpIftuVrJctUBrmi12inSokzidqbIJP2FNGrZPSao6ZU5cDkxCIDO
	FdGuLw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gurnta372-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 18:10:22 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-333543ac378so66013eec.1
        for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 11:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790100622; x=1790705422; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cMGKbEn4nCSVnNp4HH/7UejWSUwgcuvmnhDSDi2jIhg=;
        b=eLVlx3ZUyPkFY1hSRznChvctxa9CAQ8yGPgNpyv2YojgE/yg0TBophdedvsa8KG2PQ
         Xd+CyeL7InxpfPjB+FZpYCmS8YyJDVNOgsK7CPuQjk3k3u44kFyL7f6AADqW5jAifrmc
         ssvFiCos/cDjF0BLIDDbHlqodM/2M4oTSu1iHejD12eBKqJuWcHRcu7W6nYaD8zwFWyf
         JVYZM/B7GesrBIdnXCt0TnD2xneUJw7D5q6pk+Y//b3BFDpvNXAuVClSmpzWRAOSIu59
         xFSiCvZr/juXhtmJJoHEEGNJVrgv0WxgyDNO3D7fDdMDp5ys4CmPcxvUAdWAo1U7GvrA
         bhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790100622; x=1790705422;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cMGKbEn4nCSVnNp4HH/7UejWSUwgcuvmnhDSDi2jIhg=;
        b=zfiSgOpTrARyjqEYuNRvUwOsBQi7SvLOvNN5OxqIl9kv8q07jWFCvRBL+IxJeceUbS
         ozjiy469WbW//IOn4I2kAia8YsvhZMvG5mWjs9+YTH9h2SOMAzJMxgfqaH+a5atEv1Ge
         ZaCrkOxG9+YmdT/b4MckcEJw+KfPt/q+kWl7xlmkyKtSLyoNPIKApDOh0eppm24pnZXA
         v+fXrw+8VvnkbG1TDxEFa/IOTj25ELbnrqVoQLZs/JGXD1ePGondnfgudObT4tY9o4mb
         1n2g0xIEwIGWD8hO8qHA/iOFbTKjIUjsfplg8vy5DNzdyHLIGghhIKG2MVHinckhTAUC
         DRYA==
X-Forwarded-Encrypted: i=1; AKwUvBy7+GotLi7UdG7K4H+0U/dpOWRwweW+weU1To1Q7s72Hwr+C99FpBy9kBGUBG+Yg1hLLx5zIw==@lists.linux.dev
X-Gm-Message-State: AFuF++kF4ycKSSrxgZOMtqOR0dvzFiMcFNM9lz1UDWk/szv4EN/WPkTi
	VuvKGnFUtE9THwTxBgU34QHcB/TBaM4RBt86zRsLYo8ed2KWCNuAALQmtYEZ9vw56ADrXRC5nEp
	qbgzy1Xid8CtVALCncWrvZs/SkRjGSyPwM/KYlkF7Fh0uq2g8VK/5epuKww==
X-Gm-Gg: AYBFou2HmAQN75nlhWVFt10/kxhXMhErtwx3uyh4Buai7t5RCTv9WAC/aU7EoeZn9Cy
	q4vBW7yym+OsZONrxZlm7W12SEnjCIVIBOTwIC+h0jEyv8w3jRAZvx8CCzfiqpqcQP/re0XJwEM
	xGutrAVfR1Ad2ZZqTZ9XyCD2L3JxEDav6FFcJ+BAjEQu4CPCrU9vxe0XNATX2vqvUa8yMxL5J9j
	ignOWupuOXVxKWi0RsIp5hwumeRu+gIbNs02jmtJVvrjMUPkxUlZa3f+y7uFnbXBARhwna7dX8p
	3CtnoLmXVKs8yH3b1PzfDMuYkBto68Hvuwa6tnk964QkT5yBOoBAWZ0doFFAyGaUqZrOzyvuXJJ
	Ev6CQYJgQ5kQirg25tO2IEfI0dZYfbMYofg==
X-Received: by 2002:a05:693c:60cd:b0:334:6c90:61bb with SMTP id 5a478bee46e88-33e8e1b1b66mr132184eec.28.1790100621397;
        Tue, 22 Sep 2026 11:10:21 -0700 (PDT)
X-Received: by 2002:a05:693c:60cd:b0:334:6c90:61bb with SMTP id 5a478bee46e88-33e8e1b1b66mr132120eec.28.1790100620512;
        Tue, 22 Sep 2026 11:10:20 -0700 (PDT)
Received: from [192.168.0.172] ([183.83.143.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7c63bsm12881eec.10.2026.09.22.11.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 11:10:20 -0700 (PDT)
Message-ID: <3e4dbdc6-692d-4caa-8f60-f0d82e894141@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 23:40:10 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 5/9] media: iris: Handle CPU_CS_SCIACMDARG3 register
 write via program bootup registers hook
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260917-glymur-v11-0-e0c8bc914742@oss.qualcomm.com>
 <20260917-glymur-v11-5-e0c8bc914742@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260917-glymur-v11-5-e0c8bc914742@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: R4wTQElpSnQS56AxP2r09qaLfacP1ttT
X-Authority-Analysis: v=2.4 cv=eauo7LEH c=1 sm=1 tr=0 ts=6ab2c48e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=d+GKXRUq2vCLDWIvqUj1TA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=bJ2oX7-cLgL2xx1Iw9EA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI2NSBTYWx0ZWRfX0J/A4rVUIgVj
 ArQYgjWxBeOhvRFGX++YAtNCL+EuSrHrXKN+EiFlsykbeaajcgFaoDDckbqU1oMW+desNy4m0d7
 twChznSEJOY4YqXuFV9L2M8y9wHcDVl6M6DSCMmXFelFNy0PoTJmwFDGsEoy68NaDkiidxuutQg
 PsXLU++pTC1Dk/GyVBr65l2Td2rWlZhqmWsHVGkcHTUrh4C/b5Upv8AaHLNBDM2DVUxhKdljA1u
 wjrbul2wQcQP01YmnYvDwvMIgEvnIvKZqcHtSITa4H41+iupVqpEwAZQitl0sssLtyWoUIaJ6kG
 q6eJ6NVsoUCT2gc16CWWVVe1fo45EnAIP83uxgIBwYmgHh+QxaE1/RFbTV6xrlwzMZTNj1/4MrM
 u7OQZ1u3pmjncyRN3/UyoQVbEefNVw+6NLAfn3t9xJDMw5isE3GB0naWGfExh5OCXdpI+QfPkK8
 sW5GtKsJzHeri3Flr6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI2NSBTYWx0ZWRfX4yo6DUWNHaI2
 smZaYujlz/jbyDTxrVJo68ZEp46YUvSRLJiuC3nUf8AfE+j2VSAAzxX3dvbQ0IHGkecT2SNWGkL
 vSTBEJMkN2DKbpaexhtLrVvCs95UTBA=
X-Proofpoint-GUID: R4wTQElpSnQS56AxP2r09qaLfacP1ttT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220265


On 9/17/2026 10:30 AM, Vishnu Reddy wrote:
> On the Glymur platform, the firmware reads CPU_CS_SCIACMDARG3 during boot
> to determine the VM count and increments it by 1. Writing the default 0x1
> causes the firmware to treat the VM count as 2. To avoid that write 0x0 to
> CPU_CS_SCIACMDARG3 as a Glymur platform specific.
> 
> Reviewed-by: Dmitry Baryshkov<dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_vpu3x.c                | 6 ++++++
>   drivers/media/platform/qcom/iris/iris_vpu_common.c           | 4 ++--
>   drivers/media/platform/qcom/iris/iris_vpu_register_defines.h | 1 +
>   3 files changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

