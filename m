Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FC336C0BD
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776843464; cv=none; b=PeK/UEGmq+w6+XzmLlSMXgj1Uq2icxl0bGY0o4dhdFBSwZZUPbBtnxpy+R26MPocDCJiXvT4zwZDuq1+KlZDOwjc6qymGrh3Y5WXoI4u5JHkGVq8v97NsZaqd8hexBuFDyL+eq7rfCXoZDueXq+YG/P8hx8iDM41y67B2oUjlUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776843464; c=relaxed/simple;
	bh=yC9ooREPFoPevEeFC7MzV3MUhKTTHk8Dwuly7lWrnGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNug/jY60pRoPDRAYVg0+Og31NU6iNtS7q5Xa2wLMiPV1w2fLiLPGugzmH5nKsrFnsExd1D4cLmDEFLXjQK67ZvJyMMAc74fAi6pnSmmGsvbYO3qCtuqgYz3aT17Eabvh9DauuvVslpkHLDgEoMdkZNZqtIUmLhI9ysrTrWZPTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ft4JlUQc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dg9IkAnZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ft4JlUQc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dg9IkAnZ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M5dtAF2123589
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 07:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g710tN5HVbxOu4aj5AjgHTCieRGwwYofyR2aDtM7hfs=; b=Ft4JlUQcj8//lmDb
	NFgPRyBG7tuG4sEwV+3ofOBpu5eo1UOpO4mhhvW5tu93Oi115wWu2io/ytfiGxGF
	k9WCXGSfZJsqSE7tAg6ZVUibMf5MmlIU01cajoLQj2zSU3zIsvMUyh52HD2Lr/Jf
	J2PrdD5NFDG6mKghjj6Whgxu3KTRuEibX6dLBWTZyxsJVMCIj0ehjnhWYdhosOrb
	5iIO1Vh8GSecZa9wz//zFsKhSIc1aqy3QTza2yg0tislg68jP8abx4FKgVN+kdZG
	0wVe+SNOEZn/FElHMI6PLNelIYDyArN7XjrBAXI6lBDY4m4JUHdZ+9SPeNMivQ6+
	P4TOUg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenft9xf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 07:37:42 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c79943d2fbfso795750a12.1
        for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 00:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776843462; x=1777448262; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g710tN5HVbxOu4aj5AjgHTCieRGwwYofyR2aDtM7hfs=;
        b=dg9IkAnZolO7kDbOSrTgRXvJCYEWQ9XdZE6PTmmdLXGqlwA0qMPk/FGYPea3MoAxPk
         zvlGBXPfVE7JuwAi5OivT9PmoD4eAXbv66cGQa+yevrNF/OoYn2is5ldxWP8SBOt4joN
         G2quHDyX2biqdVG1BqF71U6D39DjGgNX7X8c/jt0JN7Um7zVwpskQwO5fDQslFV+vNKG
         aTXGv2GCyeSKia0N4QmrOvxSsCwECSe4IVqecif7KiFQWBZ+TIpOcrvawjycqvxQWA/S
         nRWhXvPuqhv+JNbALiymnI+XXaA5dNx4cgjvlJsVFGJnExvAqIKNg39qCgIuBVTO8Y08
         pJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776843462; x=1777448262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g710tN5HVbxOu4aj5AjgHTCieRGwwYofyR2aDtM7hfs=;
        b=HZ4JExWmdSTYqZKmsRYSHGScG4ws7cRx+6BI88QLNs9ScwU/Hp53U2VOd05no79k8O
         GtitxXQNuHPT9FTx1t2bZip+Ql4SfVqHnHx+2llEGJMnv0X7hroNJbtA0e2Lo/ej2ykN
         dqPLBaBab2suVTvLLyX+JSxf6LXmbjoKz2/raY3RZIJYp11R5bJvTLoEoDQoQZn6fKBt
         I4iUd981ZVyRSybrh9ubcF6Z92eSbF++OJHe/ygddoClDF3yACK4B4qKcwRZykcncWof
         pnstKiRUSafyGdg4npn/N7AphVE1dlyaDcBj5cK+L0keAEaT5ND3a1Wv7Xk5exy1Au4A
         A8bg==
X-Forwarded-Encrypted: i=1; AFNElJ/DFmKdWol3GT1Vy/rw4g7deViLaKtRJ5LZ/FkGlVBSGauLaz+djUZTC9jEx4PgwOHSnDa/tA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyn1UiH5LDh3rjKUY3/PKJDva1CgCmPo5cKJ136X3P00thUg16d
	7jLDT+NmymFUhyLxBbnIzEdfpF0qSQxVvwT7teyK+TU3K6BwmCa4ozWbVegcrEUBqdKjkcjd5X0
	KYPiOpwWa/sPn72eaft1QrC58q8khquiPYf6eTQqlmUk62lZgNUOaw4rl2A==
X-Gm-Gg: AeBDiev7e8bMdDvOrySsSJmkwP+mQtHtOFc0RP7fgch7gS1JR4ZLxyPwgLEgvsPbFdo
	ED2evTMEUStsyS14FhrFMSj0JEiYGBJlG9sHMTlMkDbd959+oi1ZVd5B5jQ78HXLpGGEicDzw/g
	vFc5ExQBePK31+7gHyEHP1mlolJ5s9nQE2UOFjf81+z3dhlr51HZoueuUvHh3v2xfwKAY/VvaHN
	gF95mt0QWEv/8pgCD2rQ6jT90qOF7/oRDIxOCgST9iXc7TuJR4xGFqviXSVHWNsRLeYjXncMe8Z
	Op1UZ0h7qXWeUpTj3qKOTtqVP6FJ0qR+L2A/I33MUDxp6tatEwLVe/7kildEWKseg+xOR4iv08K
	dCMntH6sb2tR4f8XntN9y4GSmoIr5NUTxf7gZ+n+BNL6YJP+TkziCv0LPUUq7fUrn
X-Received: by 2002:a05:6a20:2590:b0:3a0:bc61:62e5 with SMTP id adf61e73a8af0-3a0bc6165damr16766846637.44.1776843461654;
        Wed, 22 Apr 2026 00:37:41 -0700 (PDT)
X-Received: by 2002:a05:6a20:2590:b0:3a0:bc61:62e5 with SMTP id adf61e73a8af0-3a0bc6165damr16766815637.44.1776843461143;
        Wed, 22 Apr 2026 00:37:41 -0700 (PDT)
Received: from [10.206.101.19] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79770512afsm12391799a12.31.2026.04.22.00.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 00:37:40 -0700 (PDT)
Message-ID: <88b38699-aa1a-42b9-8d2e-6139c1ced4fb@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 13:07:10 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] media: iris: Fix VM count passed to firmware
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
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
        Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, stable@vger.kernel.org
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-6-7d3d1cf57b16@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260414-glymur-v1-6-7d3d1cf57b16@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OdioyBTY c=1 sm=1 tr=0 ts=69e87ac6 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UlvO0n_oXqfwqGaIblEA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: uUnxIZ3d5B1usMcCtcNy7QhyAAGHv0Hc
X-Proofpoint-GUID: uUnxIZ3d5B1usMcCtcNy7QhyAAGHv0Hc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA3MSBTYWx0ZWRfX7QY+YKnpRzrn
 fYF1JQAMc7M8q3qnVzOKFncpcerDer9XY92mqZVcn/cvx2NZsUWPI8W1WtAySj2p4q71zTCFjDK
 SfOzW/f6igSddcN/D6N27pc+uaQ7l+n00fQJ5FV1iAV3DtoV/7muJcA23yU2z/VKKlcwUbcpM3F
 OErzNwQgKmxFbt2JG0AV0r9swRap7M7bCHXIPxC1Hxt1G4OHnPgEjxS8DXnaqsMUcl5hqzjklmB
 jgI+vZhyJJFGfTmtUFd6hHBL47NWhavz7esk5qSDTLbCxPrbPXNZxTinhWxaRaOqB1+12rd8UA8
 xRZ6BVErOb8mJ7vAv2gS0YWOLloVxKp7ILZuaY7q4UOBxtEzKkS2W4+8qB29fVRQtnBKZih0QjZ
 q2Me0PJH1+ZdRdtJ/UC8V2f2BOAuEYYqwVpYyx84twtr840+tYGjhswTw6vF2I1XH8UCzMBoQJe
 Bv9k0V9gg39Fv9yLnHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220071


On 4/14/2026 10:30 AM, Vishnu Reddy wrote:
> On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
> the number of virtual machines (VMs) and internally adds 1 to it. Writing
> 1 causes firmware to treat it as 2 VMs. Since only one VM is required,
> remove this write to leave the register at its reset value of 0. This does
> not affect other platforms as only Glymur firmware uses this register,
> earlier platform firmwares ignore it.
> 
> Fixes: abf5bac63f68a ("media: iris: implement the boot sequence of the firmware")
> Cc:stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> ---

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
