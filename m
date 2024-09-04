Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCADE1865E7;
	Wed,  4 Sep 2024 08:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438612; cv=none; b=ZnS1vtxePQv41//q1QKJaZ1VNFm1u0BhEnX8PTWqh4yVzT2tRkIHy5ASD/O/rVEogYezIBFLBATacIyOBGAOBE/vYB0kos4nCg22zAwHVzzTJ5aq3sZ0AAQOwYd4wHELiCONrUTGx3yi08KZIn7GHwzTO5anTuaa/mA2UeMc85U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438612; c=relaxed/simple;
	bh=L5zcVEr5rIFzQVfdK/YrFSWmGXeDLvZo8OR4UU7NjZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WqB4z3Qdtz1scgjqLQ7RW+OrjTzNrBhAkTl0ehIFc3081DnZT8pjfgamj4Bhoq+xDULn1Huv8hgS9O1o4t+qMyBaj2VHYPKLNuM3ZTMilm9AvstfhA4qSR7cmmOGxevRnSRABxOo6RcbVhm7jlao8TRR/sU7oQnMmTXwfcaW79M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UjKb9fer; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UjKb9fer"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4840DhPN015921;
	Wed, 4 Sep 2024 08:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KzIKAsJu/wdUWk2sEUxvPTMam1vZyNmKG0fNcBCt++4=; b=UjKb9ferOL1ma8SN
	uV9PGV7EgUfZTe3VEO124hTAVhqulk90TmRxRlO4tPeVjRxTEhacy5tjk16w9ab3
	RdmXiq+EvzmxzzIuAjQE5D2vtFqX9uZirSPLoMFgWFmZjdoEh0fjsnz83y5gZ+Au
	AtVr+AgURCqGFaGtpnllD8Z6B9ASybr5cp5o0vOlJf6vnxQ2M41ESoyaFF8O1YyV
	1QZpSyulus3GvX3zwjdlOJU/KA/TT2rdcF3vhcdFEm3PoA9sYXLQBnojpehzAXiZ
	CLdtBZ5KNCJcdVS0guwGwjpOSos5LjnRrzPLsc8nu21QAdruvgkwFBeiQypwpBQV
	KBAIhA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bu8ut4r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 08:29:50 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4848Tn8E022676
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 08:29:49 GMT
Received: from [10.131.117.146] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 01:29:45 -0700
Message-ID: <b143a3c3-8a12-4ac9-bb0f-3b4b9ea976a1@quicinc.com>
Date: Wed, 4 Sep 2024 13:59:38 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu: Don't disable next-page prefetcher on
 devices it works on
To: Doug Anderson <dianders@chromium.org>, Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Stephen Boyd <swboyd@chromium.org>, Chen Lin <chen45464546@163.com>,
        <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_sibis@quicinc.com>
References: <20240513161343.1.I5db5530070a1335e6cc3c55e056c2a84b1031308@changeid>
 <20240517163742.GA525@willie-the-truck>
 <CAD=FV=UEXjD=w41Hj_gE--DXhkSjNdfPnkc7X=FrZJ5_90Jq0g@mail.gmail.com>
Content-Language: en-US
From: Pankaj Patil <quic_pankpati@quicinc.com>
In-Reply-To: <CAD=FV=UEXjD=w41Hj_gE--DXhkSjNdfPnkc7X=FrZJ5_90Jq0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4JxAi8u3j0kxiKsTL1aYbT-sgNV0zrmI
X-Proofpoint-GUID: 4JxAi8u3j0kxiKsTL1aYbT-sgNV0zrmI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_05,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 clxscore=1011 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040065

On 5/17/2024 10:49 PM, Doug Anderson wrote:
> Hi,
> 
> On Fri, May 17, 2024 at 9:37 AM Will Deacon <will@kernel.org> wrote:
>>
>> Hi Doug,
>>
>> On Mon, May 13, 2024 at 04:13:47PM -0700, Douglas Anderson wrote:
>>> On sc7180 trogdor devices we get a scary warning at bootup:
>>>   arm-smmu 15000000.iommu:
>>>   Failed to disable prefetcher [errata #841119 and #826419], check ACR.CACHE_LOCK
>>>
>>> We spent some time trying to figure out how we were going to fix these
>>> errata and whether we needed to do a firmware update. Upon closer
>>> inspection, however, we realized that the errata don't apply to us.
>>> Specifically, the errata document says that for these errata:
>>> * Found in: r0p0
>>> * Fixed in: r2p2
>>>
>>> ...and trogdor devices appear to be running r2p4. That means that they
>>> are unaffected despite the scary warning.
>>>
>>> The issue is that the kernel unconditionally tries to disable the
>>> prefetcher even on unaffected devices and then warns when it's unable
>>> to.
>>>
>>> Let's change the kernel to only disable the prefetcher on affected
>>> devices, which will get rid of the scary warning on devices that are
>>> unaffected. As per the comment the prefetcher is
>>> "not-particularly-beneficial" but it shouldn't hurt to leave it on for
>>> devices where it doesn't cause problems.
>>>
>>> Fixes: f87f6e5b4539 ("iommu/arm-smmu: Warn once when the perfetcher errata patch fails to apply")
>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>> ---
>>>
>>>  drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 21 +++++++++++++--------
>>>  1 file changed, 13 insertions(+), 8 deletions(-)
>>
>>
>> Just curious, but did you see any performance impact (good or bad) as a
>> result of this patch? The next-page prefetcher has always looked a little
>> naive to me and, with a tendency for tiny TLBs in some implementations,
>> there's a possibility it could do more harm than good.
> 
> This patch actually makes no difference on trogdor today other than
> getting rid of the scary warning. Specifically on trogdor the
> ACR.CACHE_LOCK bit seems to be set so the kernel is unable to change
> the setting anyway and has never been able to. We are working on
> figuring out how to fix the firmware and then we have to get a
> firmware spin before we can really see any changes. I'll keep an eye
> out to see if performance numbers change when the firmware uprevs.
> 
> BTW: any idea how big of a deal these errata are? We're _just_
> finishing a firmware uprev process and there is always pushback
> against kicking off a new one unless the issue is important. Given
> that we've been living with this issue since devices shipped I'm going
> to assume we don't need to rush a firmware update, but if this is
> really scary and needs to be addressed sooner we can figure that out.
> 
> -Doug

Receiving the warning on pre-silicon platforms as well, despite being unaffected. If merged, it will help in reducing log clutter.
The patch applies cleanly on the tip of linux-next, tag: next-20240904.

