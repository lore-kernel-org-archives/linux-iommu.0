Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4779D1AFB3E;
	Mon,  7 Oct 2024 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728295468; cv=none; b=R3MxRtU7onTCrhKWrrJrmJXoC+NMSw1iw532nbbdkwB5DsdWAnYEqFjXGOkNdsvGc/XK2GiR2/ol7g1LGBC8tjjXlhCNAgEp/gwSd77OgByqqX0maLzMu38T5CRDWtfNK7lzBPhP/pFpLuz99DinXk6uio6IuwOdzEnR/o0y6D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728295468; c=relaxed/simple;
	bh=EiKaK+wNOB/xWHp7Dr+hJAI83LLfdUOkwnue9ETryhc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=YZVT+4zxDhrRHcdGeNRzzJH1YiADGMgh5b1EpEiTaRDZAJcttWXWMJmV2Qy086e5R85x6STE4be8WzZGG7tdd3TDQ7zr0tKbFkW1GkU8ZTKskDzcMwBMTqPiUFQgTiI55fxm3s3HoijTNen3SHUdQsSvpXKeRPmiTV5ccyUKQtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fMNqxoyW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fMNqxoyW"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4974Spx6004197;
	Mon, 7 Oct 2024 10:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QCIboNDi0+QF4x956SfXdlu4UjpNYXVD4wRwQLp6HOA=; b=fMNqxoyWIUFRQBAM
	I3C0D9wgbjx78VJxsOrXdxFHf+4UVA0rVuzkbw8qhIZxsUx1ZbAI74WglF4qrzv1
	APRlVFs17H6UbQK/FNWyxLwrYmMLTaTq/87o1jcmxmZvuAViGbtAveXYRtv5iiwh
	qdMfPI19M7fxeXHkkkSOW5psk68VACwJ5vL8ZU5lxlzfz6up6xduiQ9CMQ/p4y6b
	nsms4SSFsXj5HIeOPbfSYbHCJgGWRCdalKJSf1IEAzcgJf7ki+oNYYPTtTP2vbsS
	JIuwF2eIDoC/yADD1U0kUER/AKqB9GwfJ8T8DedFBqj/o5J/iyyH3aiXKt99OApc
	yqTqHQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xqnup6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 10:04:07 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 497A46lY014009
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 7 Oct 2024 10:04:06 GMT
Received: from [10.131.117.146] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 7 Oct 2024
 03:04:02 -0700
Message-ID: <98d56e5e-47ca-45d8-8e0e-07c204fcc04b@quicinc.com>
Date: Mon, 7 Oct 2024 15:33:52 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu: Don't disable next-page prefetcher on
 devices it works on
From: Pankaj Patil <quic_pankpati@quicinc.com>
To: Doug Anderson <dianders@chromium.org>, Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Stephen Boyd <swboyd@chromium.org>, Chen Lin <chen45464546@163.com>,
        <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_sibis@quicinc.com>
References: <20240513161343.1.I5db5530070a1335e6cc3c55e056c2a84b1031308@changeid>
 <20240517163742.GA525@willie-the-truck>
 <CAD=FV=UEXjD=w41Hj_gE--DXhkSjNdfPnkc7X=FrZJ5_90Jq0g@mail.gmail.com>
 <b143a3c3-8a12-4ac9-bb0f-3b4b9ea976a1@quicinc.com>
Content-Language: en-US
In-Reply-To: <b143a3c3-8a12-4ac9-bb0f-3b4b9ea976a1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wZ3g98OVtQqnb7P1DzBI_wgju32o5mUP
X-Proofpoint-GUID: wZ3g98OVtQqnb7P1DzBI_wgju32o5mUP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070070

On 9/4/2024 1:59 PM, Pankaj Patil wrote:
> On 5/17/2024 10:49 PM, Doug Anderson wrote:
>> Hi,
>>
>> On Fri, May 17, 2024 at 9:37 AM Will Deacon <will@kernel.org> wrote:
>>>
>>> Hi Doug,
>>>
>>> On Mon, May 13, 2024 at 04:13:47PM -0700, Douglas Anderson wrote:
>>>> On sc7180 trogdor devices we get a scary warning at bootup:
>>>>   arm-smmu 15000000.iommu:
>>>>   Failed to disable prefetcher [errata #841119 and #826419], check ACR.CACHE_LOCK
>>>>
>>>> We spent some time trying to figure out how we were going to fix these
>>>> errata and whether we needed to do a firmware update. Upon closer
>>>> inspection, however, we realized that the errata don't apply to us.
>>>> Specifically, the errata document says that for these errata:
>>>> * Found in: r0p0
>>>> * Fixed in: r2p2
>>>>
>>>> ...and trogdor devices appear to be running r2p4. That means that they
>>>> are unaffected despite the scary warning.
>>>>
>>>> The issue is that the kernel unconditionally tries to disable the
>>>> prefetcher even on unaffected devices and then warns when it's unable
>>>> to.
>>>>
>>>> Let's change the kernel to only disable the prefetcher on affected
>>>> devices, which will get rid of the scary warning on devices that are
>>>> unaffected. As per the comment the prefetcher is
>>>> "not-particularly-beneficial" but it shouldn't hurt to leave it on for
>>>> devices where it doesn't cause problems.
>>>>
>>>> Fixes: f87f6e5b4539 ("iommu/arm-smmu: Warn once when the perfetcher errata patch fails to apply")
>>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>>> ---
>>>>
>>>>  drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 21 +++++++++++++--------
>>>>  1 file changed, 13 insertions(+), 8 deletions(-)
>>>
>>>
>>> Just curious, but did you see any performance impact (good or bad) as a
>>> result of this patch? The next-page prefetcher has always looked a little
>>> naive to me and, with a tendency for tiny TLBs in some implementations,
>>> there's a possibility it could do more harm than good.
>>
>> This patch actually makes no difference on trogdor today other than
>> getting rid of the scary warning. Specifically on trogdor the
>> ACR.CACHE_LOCK bit seems to be set so the kernel is unable to change
>> the setting anyway and has never been able to. We are working on
>> figuring out how to fix the firmware and then we have to get a
>> firmware spin before we can really see any changes. I'll keep an eye
>> out to see if performance numbers change when the firmware uprevs.
>>
>> BTW: any idea how big of a deal these errata are? We're _just_
>> finishing a firmware uprev process and there is always pushback
>> against kicking off a new one unless the issue is important. Given
>> that we've been living with this issue since devices shipped I'm going
>> to assume we don't need to rush a firmware update, but if this is
>> really scary and needs to be addressed sooner we can figure that out.
>>
>> -Doug
> 
> Receiving the warning on pre-silicon platforms as well, despite being unaffected. If merged, it will help in reducing log clutter.
> The patch applies cleanly on the tip of linux-next, tag: next-20240904.
> 
Following up on the patch. Please let me know if any additional 
changes are required.
