Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0192040BE
	for <iommu@lists.linux.dev>; Mon,  2 Dec 2024 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149831; cv=none; b=mNMvUHH8r2lRvg4s3rdRytW/525U5hsPU/eBsD3jhUPqK6oep1guGFfa0136TtVKnXGGE4uHmwyqYq+oUSjPT26R+T7lF0uPSTGrpnHgDdudjyJnalHcG3nc8ZgsgoxAjWxXx40J2ZC0RrUiP7fSsoqklTefsFg7XkRm/OtFzrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149831; c=relaxed/simple;
	bh=JKudxHQZAMvenvuQlThpOxs+MgeFGbhhq/9B/KOCpcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZyevMKDkSJA5x7ABEAnenwjiPI8Le8UgET9daHZr2wiOHDqKpQj6epsMEUlsfN1pn5s+VpWvDKmCLqNgN4MCI3e2kiGWJgkP+7GPEQd52wG/dj3c6RnkSBuDaMkSYt7iSKAu/zcIFV7UGKvoDqo5ooiW+PlU+jbYG12nLgKqWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VquWEe1R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VquWEe1R"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2930rW026565
	for <iommu@lists.linux.dev>; Mon, 2 Dec 2024 14:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	opJ/u7aIb+6rMXmWGckJvu/bfCwMl33RWOEqNCV31vY=; b=VquWEe1RLGrvadi4
	+COaUnJRyGGhjYHqZppe4bZ3jhOGa3g7ml2a8SJItS7czFte2OnVMCgqstXlugDQ
	K8WV6oj9zg+8cnX6uEe8vYyd+v7XVpD0WeoM86U6l0z+KdpnLwE1PdwwRxyIpIWz
	2lb4jTivnzC/L6WtEc0a0cnM4V4B92QHYZPnsPfwv1dk9Tm1P0CxLAGxT+LVsocC
	43qFwMOpKUhuA46lS57Tk675247+Gwl778zVT+96U94uOpqV4wW5cdUvZZLzESf+
	w3/ci0PcUmLJgijw5td2xAteFTUmsZQhTHTVhj2riitEMatjxOL3eNnho5rc7odE
	Yu2jrA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437ta2w27e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 02 Dec 2024 14:30:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4668c9aa8c7so6728961cf.0
        for <iommu@lists.linux.dev>; Mon, 02 Dec 2024 06:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733149828; x=1733754628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opJ/u7aIb+6rMXmWGckJvu/bfCwMl33RWOEqNCV31vY=;
        b=BdG0D9WpwtSCB6TyoYJcc9glT1sKBNW+g9dkhqmzae3iYE+G60696OVfmFZX3uXu6g
         NvKYNeXNgpxXS9PBanM12XyQFJxpWiS8n50e/RTJIjp51+IxKhwml+i70+OiT6s51L/s
         QX12O9HnDmRZW3MWY0I82GROvKFbnFNvbdv46AOAz8Keq3V099nBipCt+V/WHAyQ4xKS
         ph56buR32WYMIwJui9wGIQvA63bmR2TnRT3eqOurRIFuY/rvm50VyNLNlj9g077ZD8ZB
         3WRPk2VXZcI5R8MRw6en/TWsT13Nwdyv73b/A43zxk7LmkdP2c6XRSvenWA45ejx0yLb
         w2yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWOh5x4kPQE6b1F8PvPRh/SScdRyHHdcx9rZaZMTtd/vrUcp5vzzd/wgJ2lTKXy3bbK7iQ5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKNAdFjf8ofVHzkiqb2iGBQK974xUET2eGNEYk9S0VF2tsShGT
	RX8+hcui4pb7RzmuAUPc9s1iCW9YTe49ulhddylVRHDx2C/T9Qlmza8+SkMD2macUY16eOrYqhD
	YBGdRax8dM/nZd2buov+kj5rNTmyrdVKkzRkzj0NRsic+Dm1RkH6TPQ==
X-Gm-Gg: ASbGncvJr/Ybn25dLjT/oIbQKmrKjPO9wyiIMXCXqSZzBjIvtplXPrr0qSmCi7Yehy0
	71tlE9RIoL2RlM1WAtoKMUFQiKL14q7ZTnTSEtVyHAXSYNaagQOH04rC5+GS/6961HCHvljFyg/
	PiULhJ1UagM3AFGgZtenRzI7pNir4Gw9yza2l2BzLQX1FJOjOKWxtpfNsWPMnWT8vGKnjebzOGs
	RXwxTwyqO3xe0KmxS+tqfojpbPUaAwNy4yXFXrigY9BdpcyPJx/+AwJIdyRiL+0ttFk5G4uNJZl
	HcVqdQZGnF3O5YPFQsGUlx/1eUPplL4=
X-Received: by 2002:a05:622a:1a13:b0:460:62a1:70be with SMTP id d75a77b69052e-466b36737d2mr150946501cf.13.1733149827285;
        Mon, 02 Dec 2024 06:30:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyWUKeBXhhoq1965fOPrse19lfgFS9Hoi0RqhL/1OBQ3mXf5NYh73GoEjiIReak/2sYFLgpQ==
X-Received: by 2002:a05:622a:1a13:b0:460:62a1:70be with SMTP id d75a77b69052e-466b36737d2mr150945211cf.13.1733149824157;
        Mon, 02 Dec 2024 06:30:24 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0c04ac64dsm3519962a12.68.2024.12.02.06.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 06:30:23 -0800 (PST)
Message-ID: <7ae4bed8-c170-411c-8ece-d685271aeeab@oss.qualcomm.com>
Date: Mon, 2 Dec 2024 15:30:21 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: qcs615: add the APPS SMMU node
To: Qingqing Zhou <quic_qqzhou@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robimarko@gmail.com, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20241105032107.9552-1-quic_qqzhou@quicinc.com>
 <20241105032107.9552-4-quic_qqzhou@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241105032107.9552-4-quic_qqzhou@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GkiqIx1UXUvjgMwfQ64hacbut7SAU5Z1
X-Proofpoint-GUID: GkiqIx1UXUvjgMwfQ64hacbut7SAU5Z1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=917
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412020124

On 5.11.2024 4:21 AM, Qingqing Zhou wrote:
> Add the APPS SMMU node for QCS615 platform. Add the dma-ranges
> to limit DMA address range to 36bit width to align with system
> architecture.
> 
> Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
