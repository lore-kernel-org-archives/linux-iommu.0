Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9440F17D8AA
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 21:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719351825; cv=none; b=O/9+KJTr4KQPbFshJMEeWNFXdgvJFRyIFmivKEigJtyFQuhsj15nAUrtVS/0zFS+tIi1unQSIHqN8+rXd8j731SwrjKMh0sW5VYX/IUnRUtUlbiBaO67BNJHvdX6+GuPZfu+xeO5+z7qb2T3nCUgVNvCVcJH0aAgUffQHmRXLr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719351825; c=relaxed/simple;
	bh=1WLdPZ5yF7oV56dmdSaQ19DXHumn5asxzfhfsCcMH4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aUGsSPxFNCIPlnFNJ6QTgWIggaOgRCq6ephKpbhe/hIJaRdlmJcx0eAk+zb1YzqhJzv/pt+X4/X9N5DdDVMKdH1TSYaCi4s5FrKsLpcEQ9VSxmSezHphs1T8S52bTThE+EI0xmf+f1LqjoLTNJo1kHXmaizusBnNlwr4eKeo2C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XxJR+tSx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XxJR+tSx"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PHV7Xw009082;
	Tue, 25 Jun 2024 21:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1WLdPZ5yF7oV56dmdSaQ19DXHumn5asxzfhfsCcMH4M=; b=XxJR+tSx+V7XX3Oo
	ISbazRJTFA7PRUzzVDJjm8IJmbxYkwxWEFt5VDIn6W/SR866Vi+3eWJ/B1PFfSaM
	ertxEyxW48rVxfy7XSr5yxCUg0ZR7RXf4AkM4vom/gED/9QO+k+k1QkeMM3Uj1pi
	Q29EUXdWaK27NRLsSVy/zvbsckxLv3fb2W6FnrKi34IllLQlAMJ5RqhPhiKQjitU
	4E2VCaGR3uoZ5wbHnYggC4Qh0yGyOLh9bdvcIPl9MfhUK2aiXm6mUfpRIbTKxXlx
	aYsIXpfoaWtbUdNLQ94nKtRexCGT3yVnBjdkzmoLKU9lhORtZ2P22IKLKUEWF69C
	N8HjBw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqcefuxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 21:43:24 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45PLhNYC004152
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 21:43:23 GMT
Received: from [10.110.31.38] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Jun
 2024 14:43:20 -0700
Message-ID: <c8dc6827-a757-42cc-8532-314f8da37d3a@quicinc.com>
Date: Tue, 25 Jun 2024 14:43:11 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] of: reserved_mem: Restruture how the reserved
 memory regions are processed
To: Mark Brown <broonie@kernel.org>, Nathan Chancellor <nathan@kernel.org>
CC: <robh@kernel.org>, <saravanak@google.com>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <kernel@quicinc.com>
References: <20240528223650.619532-1-quic_obabatun@quicinc.com>
 <20240528223650.619532-2-quic_obabatun@quicinc.com>
 <20240610213403.GA1697364@thelio-3990X>
 <Zmd0Zg7oMneJLyHd@finisterre.sirena.org.uk>
 <abab36b4-e9ef-40ff-adbd-fde0f016f3b8@sirena.org.uk>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <abab36b4-e9ef-40ff-adbd-fde0f016f3b8@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -B5O4HLGYcE4HdI0_vGOreeX0PHdrEIO
X-Proofpoint-ORIG-GUID: -B5O4HLGYcE4HdI0_vGOreeX0PHdrEIO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_16,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=703
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250161


On 6/25/2024 2:25 PM, Mark Brown wrote:
>> I'm also seeing issues in -next which I bisected to this commit, on the
>> original Raspberry Pi the cpufreq driver fails to come up and I see
>> (potentially separate?) backtraces:
> This is still in -next and breaking boot as reported above.
Hi Mark,

I uploaded a fix about a week ago here:
https://lore.kernel.org/all/20240620001027.2326275-1-quic_obabatun@quicinc.com/

It is still pending review and expected to be merged if everything
is okay.

You can use this and see if it works for you. If it does, you can
also add a 'Tested-by:' tag to help speed things up.

Thank you!
Oreoluwa
