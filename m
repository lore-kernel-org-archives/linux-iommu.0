Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754A539901C
	for <iommu@lists.linux.dev>; Wed,  4 Mar 2026 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772616886; cv=none; b=utzAqzjlfKKaSqoGIcpdoJJEgUOTxsE/xmr0dKkVIlIeQOXCU5rqEKasJemiUEB6lrOOjWYBT76llni6YJGWCvjSfDYx9k4c9GZDeIcaA4Mitzr0OvAEdWG3U6MIxkahFiVvtX7Yj7ReHmvrfg1WcNWsO0V6YeBP3oj40gOZhvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772616886; c=relaxed/simple;
	bh=XWtG4w+RB2jIlE8XCXYlCTclLv1DMkaQyVrjOrWsDSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwmkNPjpQblGDWQDlS678m43nrLINbtmWR+MSEvFgMKZwDQJ9ClXF3tycqrqjdjNCjWBzW6iTFCAAY2yK1jIS0AZ33LCQlrnqYxqLNoVQ+SJoUQXtj2K4Y7FPdte7l8cp0vQcBKVLYJelgT3xgmTQjlYPADRxhgcTyJvIjcI+aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eKEnwxk0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K05wXut1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eKEnwxk0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K05wXut1"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SRB82861146
	for <iommu@lists.linux.dev>; Wed, 4 Mar 2026 09:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eL/MxpDDt/5/2ALudUSxO1nN1iy4vdaNTzKBdYqEsSk=; b=eKEnwxk08ZSuuIb5
	kLnhOzDXKxPW3zLqbJ5i4X54fIBV8ekw6WA+QDZnIeum2m6HgZKdTzX4cPzMLchr
	5neNVC9YrL0B3EGsnHNgfXT05VeYt225ETdM/AVXVP7//SkXB+1NzN8TeDk5RuFC
	27wO/Anxs1VGEBZa4acXnCLLVSO0dORMonWjSO3FqxuXk8a43Wx2H73d1BKdA4cE
	cxQQpibSkWaWAkJiWBDKtr7fW54WyW1SeY84/O6qB+m+jZ3tI0VcQa8JbqlDPGP8
	LB1IrM9dcfY+1udtjPx+AYfb3o7TgoA/Gyl6T/sV5VyaqTfN5LbziEYbwNJlrEhZ
	gV/dBg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp2c9kcu5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 04 Mar 2026 09:34:42 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-359918118ebso7750228a91.2
        for <iommu@lists.linux.dev>; Wed, 04 Mar 2026 01:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772616882; x=1773221682; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eL/MxpDDt/5/2ALudUSxO1nN1iy4vdaNTzKBdYqEsSk=;
        b=K05wXut19DWHpWVRYdkyUKtbXdUa9eQxI+AWZo8nF55NKZPjhYx1qOELpvAkIya1vJ
         NvC4tRQ78D0AsFi54vx8TkMsniihcAX4LaPEqRwMoj6iwP8XN2/qySEgfr7AS+TDNOrQ
         vd7lh6RGY6YuDtb5XL0y0LelBozECC0ZnAz2PcLfEDyR1DOeSBwsSCLxL09+uzIAYPms
         QwprnSEQH1Ks0osOkumedHdi8O9wPck1BVTbtSLq2XQqASVSAdKvyuDq+4NddQ3aaE73
         1M1fmgxqhtiDr/CMElKjq2SE7EEKfJm+vGPw/JLK7SDZqqPY5jkxLVpCLiNUPqdxZM/q
         lGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772616882; x=1773221682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eL/MxpDDt/5/2ALudUSxO1nN1iy4vdaNTzKBdYqEsSk=;
        b=ajxqGxe2ZkMpE54sCObSAvBEBavruOAZV1C4ImpUDtcVRGDQs4Il9pJxm5PjBczib5
         yXXjeM1w+Ohu6b0511BlGl6vaC9OoJ2CHcjBT4mxeAAJYFdvqCnHWHGVHLyiepLrzUPl
         AqnDQK8fRrrCHwb/ozNzAT1i09/4aq3/cN1bT182PTTuLY15YWWj955JRAt456zbPdXU
         D04//40UIp26jh6QX1mLCnRXiynNkrpnCv2w2FiyOFqAQKe0ubsnEAPdLtSpQYZi9/p0
         UBp1ISOgjp7rkBHSiNPFweI84l1LW21jw+cHQamOopomhOmqeN91m3LxPxDdBYPQI+pI
         3UbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgKzWFwjnfn6x6/eK5k1Fsbh4nwf5B/hjr1N32KO4gsPLhfcnhUT3eDUMgLJRf8BPpx/1MmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnszrD3KGECd175al8Dhn8hYccG5Ilpb+e+DiiVy62mapc/VUt
	/A0O+MyvNB9wZDR+n5RTB82805zBKHl4cMsuaTwBZuk1fQMg74CQkznOgLkjstKkPEuSH5aLyiX
	nZzSWhKTX5nAueK1x3ncitSh0aBd5keMtUkznTsrDtX9VfBfQ+KD/ImzvVA==
X-Gm-Gg: ATEYQzwPJqgaLY0G/qLvXEKiZ36gssiy2QaouQGJbaPvPhX1I9prD95RaIaSrpprISU
	S+QA8pdaoUaaroGSbvV+TulmLO+696lr3S/XnKJWixMs5cMYxD6ijvMWWCu6iI6FEPHnaZZjRgg
	ORjp571qQOfUIOZ/oLcrZYs77jykl3p8auRA27mJPglt/LnNrY6yhQ511oFGkEKJAz8hp5+T8fs
	XdcrhROY7fcTrkbF3PURqEy8KxUh75aDNFLN+x9kz0d6ta/iKTpSyMq8fSWEAdMVHs6Pl/aERoS
	EnQBlxIpci8zeg5yT6wbdZeCHX0vPEQQO5Q+ZKWToq5WYCtjEHuFfUdMRT3fyQM70Mm/7Mhw3+V
	Rxgb1He8aGF5VIHIXLTUekmudQhC6J59sAuqQ9wXysYIcEA2h9c8wOu/2
X-Received: by 2002:a17:90b:5784:b0:359:8cad:bcdc with SMTP id 98e67ed59e1d1-359a69d6372mr1471620a91.10.1772616881616;
        Wed, 04 Mar 2026 01:34:41 -0800 (PST)
X-Received: by 2002:a17:90b:5784:b0:359:8cad:bcdc with SMTP id 98e67ed59e1d1-359a69d6372mr1471607a91.10.1772616881094;
        Wed, 04 Mar 2026 01:34:41 -0800 (PST)
Received: from [10.219.57.109] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359a8d65b31sm500720a91.0.2026.03.04.01.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 01:34:40 -0800 (PST)
Message-ID: <ebeb6f4b-4195-4e9f-b211-a8e11a875b7a@oss.qualcomm.com>
Date: Wed, 4 Mar 2026 15:04:30 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] of: factor arguments passed to of_map_id() into a
 struct
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal
 <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, imx@lists.linux.dev,
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
References: <20260301-parse_iommu_cells-v9-0-4d1bceecc5e1@oss.qualcomm.com>
 <20260301-parse_iommu_cells-v9-2-4d1bceecc5e1@oss.qualcomm.com>
 <bo5kb53hrzvl6e5mctvnpqluobdgbpq4x3m5ca7mwtfnl53npw@7axqsph2vyqd>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <bo5kb53hrzvl6e5mctvnpqluobdgbpq4x3m5ca7mwtfnl53npw@7axqsph2vyqd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA3MiBTYWx0ZWRfX49zqGbe1x3ro
 n7ukAkFh2uua6bnpqp9jOKyQDWCgVTGccn00b4or94G9mT7Krd+fAvgzxhJbQblKP1djp7Ftl+0
 1oiThe6fT4Fgwt6fNi3p5RiCChmvB7bzHMQ36be/Li6QnUrj5P6nog0tOuckR7JiMOq9SVUnKv+
 TsTF7CnrpW4u3XAbWutTHKjwOa5p/kTIq0Q+i4hRZcrDvUIPCoIaDUgjf96AZHLY/dZXsLVrg9g
 VPjikfYkqBN5Xzxd12Dw2XmkkvrUouJlKC81KtQXqUVD8dzgAKFAalDoHfGYXlcpEIq2CCI5c3q
 JpJQbW09tZZu9qhUADHM1ffrVshCHGcFBfMMLqasR+/BS2VzB4Xz1Lo83+VI8Ad17cPwWpRQ5F9
 wXvKAvJl9fL/0tZI3StHyrzg11s7vBAzbw7lxNwF5TQVX3p2JqKjJp7i+3fvQbwPx7UaR0p0PJi
 sn60xd5ROhhk2wU9oKQ==
X-Proofpoint-ORIG-GUID: 3pNe0ZbSlOCc6GHiYyhTt2v_l8v6K9I2
X-Proofpoint-GUID: 3pNe0ZbSlOCc6GHiYyhTt2v_l8v6K9I2
X-Authority-Analysis: v=2.4 cv=EefFgfmC c=1 sm=1 tr=0 ts=69a7fcb2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=kVzFkbBwBCoyR44kgfkA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040072



On 3/1/2026 4:29 PM, Dmitry Baryshkov wrote:
> On Sun, Mar 01, 2026 at 02:04:20PM +0530, Vijayanand Jitta wrote:
>> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>>
>> Change of_map_id() to take a pointer to struct of_phandle_args
>> instead of passing target device node and translated IDs separately.
>> Update all callers accordingly.
>>
>> Subsequent patch will make use of the args_count field in
>> struct of_phandle_args.
>>
>> Suggested-by: Rob Herring (Arm) <robh@kernel.org>
>> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
>> ---
>>  drivers/iommu/of_iommu.c              |  2 +-
>>  drivers/of/base.c                     | 37 +++++++++++++++++------------------
>>  drivers/pci/controller/dwc/pci-imx6.c |  8 +++++++-
>>  drivers/pci/controller/pcie-apple.c   |  4 +++-
>>  drivers/xen/grant-dma-ops.c           |  2 +-
>>  include/linux/of.h                    | 21 +++++++++++++-------
>>  6 files changed, 44 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
>> index a0937b7b3c4d..e1d4b37d200d 100644
>> --- a/drivers/pci/controller/pcie-apple.c
>> +++ b/drivers/pci/controller/pcie-apple.c
>> @@ -755,6 +755,7 @@ static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_d
>>  {
>>  	u32 sid, rid = pci_dev_id(pdev);
>>  	struct apple_pcie_port *port;
>> +	struct of_phandle_args iommu_spec = { .args_count = 1 };
> 
> Hmm, I didn't notice this. Parsing functions are expected to ignore
> of_phandle_args before the parsing. So passing .args_count = 1 is
> strange.
> 

You're right, This is not required. I'll remove these initializations in next 
series.

Thanks,
Vijay

>>  	int idx, err;
>>  
>>  	port = apple_pcie_get_port(pdev);
> 

