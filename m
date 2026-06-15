Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5830A3B19B7
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 06:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781506597; cv=none; b=FM5JMbTDRHnanQJ26Uf93wC0b5qHJ6xwvigNTUJ6dbqJmOz6W6xyzcQCar0P6lIxuHYx8CBfOT882ah9oKQataEhZ3MWRylwvjIbic0UGqQ8MPIzK1pAhoUkOde8BZghwcYY+mL3Xc9AFtiSpnIPCMF6SaQVtymRTiMAa+sY6M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781506597; c=relaxed/simple;
	bh=VhRbl3votj3DkChC23JYZLTe2jkD4YtFTMppnhoSaoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LV7j6UFQX2qMvqGH4bAim1cqr5ZujST4gaCqvf+fBSoCvMRx6LXWi0O0GDcdlDuqS8SJrgMYRrSUvOgpBVvIxkt8Vxp7Z5FCGzrOZ1Cf+MdhnYDt/o5dnwgMX5oZnq6nS0D2AutytqpDIr91ZZx8CRUde/6B3ySV+3W0VOZ3NZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AZYFKOgo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SFgyrF6f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AZYFKOgo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SFgyrF6f"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6J1J63327530
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 06:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LVIkiUalj7kmCYffsOKMUSZ85BbQoEwmJuQ8RR6Nb+4=; b=AZYFKOgo+xLopqNl
	ugAc3z03AnWZplpyjAOhnm2crTWP1SxqR5MKUS9/2vl1sGTQ0G4nRajSshH9K+ub
	lEp8OnQ8lExxYT7opwQQyHWnnQPPzr3RpU9lomL1sIsqMJZimhsU+iu9kVC78ddX
	bQA18Khk5anOwWlLeKjIj0y/ejwaVrtCC9516GW7ufqmPJYQhFO/Ye01fbZ/IF++
	6BKv0WyRL6jNcAfaG4uysNGNL6ncc4LTRPF9nKMf+Cal3bZobmu1n6vh9dhB1mcB
	meBwm+DYHcOHcxjQFNayp1FxNItEFV82avDN7FWpq4s8IYpCQBmaouV1fy/vwP9Z
	Y9hwvQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4es0cgnx0y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 06:56:35 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9157f453a27so460149385a.1
        for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 23:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781506595; x=1782111395; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LVIkiUalj7kmCYffsOKMUSZ85BbQoEwmJuQ8RR6Nb+4=;
        b=SFgyrF6fadf+r2XTUib5G93mtSUJ+/COM5PaJLPAulr0EndDJVp1EBLzN5WkydNKds
         bzPGXhafKp0iHOl52NP+rymz5YIQN6op9DaV7Kmu2FS5ZzVJj1PBIPEOBTFYw/3kFmCR
         VTbTyvb5Wvl2xJpNv2uvlyZuHOkBuhssiueuRUhJmlTJeRhijQpqwc6C6Aq+8I0U3ULq
         5oJpe6sFb8LWYZdTD19nrnArnmonTVObX7SQEUHXyJG1bmapOwa2mFzbcsSAbzgG4Noc
         C/746ZxPq4YhX6QP2JhY5IyeWw4QBPKuSedWgqYAzIARWx5+m1B3hUH/VhgHvYdwJAi6
         E00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781506595; x=1782111395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVIkiUalj7kmCYffsOKMUSZ85BbQoEwmJuQ8RR6Nb+4=;
        b=jh3kupwqd48Ujm37XrIE/pNm+u/SEzma7oBGY7ddRGVuFNV3X0JF5j/WVXZxqURvWf
         wvwZY9VxCMmqBGhQmIz/fRvthId5Eg2kTZoywiBovROYnIqYKwpTl5t2pQMdgIYK9SYH
         EogTAdAeoqELWNhhz9uIAwo1zzLKw0zS93RR7ukkzidWM9JbyLKjXjdOkhnqYcCC+2YB
         4qiC+ln7faHiFOksNIh3njNNbCqF4Wzc5l6F/+iq/n6EV35LTNYbJuSvSC1QKuQYqt0j
         ZCSn34VawtZOMCG34bPZtVLmVtwwLUwFoLnpNM7s4WH+75xhmM8Y+T37iSZhsJtaFCXb
         qhIw==
X-Forwarded-Encrypted: i=1; AFNElJ+8xIwJ7Bv/mWRJzLmBJeQsEmLyGDly3QRJZfMCCslIpr10hfZB5T/joX+HhkcfP4LYhYbbUg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfvZuL5y3/G84tGmKSvwHq3o+KwETRGnChY1YCuweJorJPSz/Q
	Dw2F0uXrdgcNLQRj8JXM6hidTR2JFNf1bnQcYaZZ28ghFdVzngTsOh2RnoNsd4U5c8HBfgS8/bS
	C5G1C5xhg0thFXkxqLPGap361QcSoK5xVVs6qJii0/BzaXVq/Sh7lg//1nA==
X-Gm-Gg: Acq92OFbTgGvcoFFx4LEKWGjwPLzdqXcpE5X1UigtDyptvLgu3bokluz7zwP83JIWnM
	j6RdN7Tin8RCBTn74YKxUIOoF0IOBRV6PWnI/o/7a1k4cu1EKZk+ShkdqOWco403tC5wBFHV5fH
	zoeNDx52TsJeJA7HaR1e+CSLVUE3K2OkbsUxEWyX7JvKxP+l5xZB3OTD1OO1pRn77bCdExNNOAv
	MkO+zv5fBu6gat6JXfoGNWqblwsjSau0kMCfYNTH1F6VsHpXmuTCNFdsDz1Izq3VnyZ7VNW44sg
	h/ITrjXhESnjoLrnW6v6kzLfP+V5fDCuLwjNQGXW9uK1lnZUlsw4VobX8DpH83INHn78bmMlW90
	q1Ni9KMr5GU1U9gsj9x108AZrqOqEPyHw+hgPNcCFrab/8N0zkuJhdM6A
X-Received: by 2002:a05:620a:2722:b0:916:12ec:12a7 with SMTP id af79cd13be357-9161bc59545mr1936589385a.18.1781506594610;
        Sun, 14 Jun 2026 23:56:34 -0700 (PDT)
X-Received: by 2002:a05:620a:2722:b0:916:12ec:12a7 with SMTP id af79cd13be357-9161bc59545mr1936588085a.18.1781506594162;
        Sun, 14 Jun 2026 23:56:34 -0700 (PDT)
Received: from [192.168.0.172] ([49.205.249.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb442083esm405057266b.3.2026.06.14.23.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 23:56:33 -0700 (PDT)
Message-ID: <da77c21d-25b3-46c3-a48f-71f0549e9f5f@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:26:25 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-iommu: Introduce API to reserve IOVA regions for
 dynamically created devices
To: Jason Gunthorpe <jgg@ziepe.ca>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
        m.szyprowski@samsung.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, dikshita.agarwal@oss.qualcomm.com
References: <20260119054936.3350128-1-busanna.reddy@oss.qualcomm.com>
 <cfd23f75-8952-4463-abd5-815b995031b0@arm.com>
 <bb59f07e-ca7e-f012-6a4b-0a148350b69c@oss.qualcomm.com>
 <20260612172649.GM1066031@ziepe.ca>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260612172649.GM1066031@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: C67TisqJhDvykH1S_1Va1yESue0RaCoS
X-Authority-Analysis: v=2.4 cv=NPLlPU6g c=1 sm=1 tr=0 ts=6a2fa223 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=1BxbLvcILuCGMxPr/bnfdA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=i1ClbB10qyHwisSbbGoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: C67TisqJhDvykH1S_1Va1yESue0RaCoS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3MCBTYWx0ZWRfX3QhjdVioUwVr
 SuOlFQfpf5EclO+ec9wFYr5dJ1eJL5gARBCctConXlEyXlihtRrAF5Rcu6cclOXzI99inUDi0bl
 YDKDQ93evXRsMv8AqJ33m7y75GztXnw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3MCBTYWx0ZWRfX1CF2+JyJiXyG
 kl+TXMxnvCmmdmOsQbq/jraowd9C4epQQBDkugyJIuegpb4jhd/bC02gZGeop4rHY/hSjaPT50s
 8XHqYXwQKMqMa9D36dpFxGPmyn+PVA4SJWmifGgnMbYufBRUCFoZopvZFs2tOPJroluyItzimQD
 8DpUf0Nu1InkuhluopoO8VqsWdfqfKLk+aUwVxIhScqFJCycVJIs/1eNlwySY9pp+0lb7JWlEua
 kUNgAMnVy9T1T0/iUSlfjMVDdhC4T8ARC5ULObwMNsqX5v52XNsuy+D/0BvvyBkte48jb2NJFI4
 A2f9KrTiJ8NqbSNVSpT/Q10qP7nkxeFMpHKgjimwj6Zu4U5XfGyPTQuE0yKQppAWbsemuRDL97v
 AI14g59dVoHMBp8CNwTXY/yP0NZIbw4+7Plz3AIIEnBD4+mVeAQzKJ7YJa0GDowiWPyq+jkO9nc
 zskApCl+EdeNVTaOttw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150070



On 6/12/2026 10:56 PM, Jason Gunthorpe wrote:
> On Wed, Jun 10, 2026 at 07:57:50PM +0530, Vishnu Reddy wrote:
> 
>>    +--------------------------------------------------+
>>    |                  VPU Hardware                    |
>>    |                                                  |
>>    |  +------------+   SID-0   IOVA: 600MB - 3500MB   |
>>    |  |  Block 0   |                                  |
>>    |  +------------+                                  |
>>    |                                                  |
>>    |  +------------+   SID-1   IOVA: 0MB  - 3500MB    |
>>    |  |  Block 1   |                                  |
>>    |  +------------+                                  |
>>    |                                                  |
>>    |  +------------+   SID-2   IOVA: 16MB - 600MB     |
>>    |  |  Block 2   |                                  |
>>    |  +------------+                                  |
>>    +--------------------------------------------------+
>>
>> Each Stream ID maps to a distinct IOMMU context bank, and each context
>> bank enforces a different IOVA range.
> 
> I think Robin is saying you have to describe your HW properly in
> device tree. In Linux a single struct device should not own multiple
> *different* IOMMU contexts.
> 
> So your DT should describe all those blocks as unique DT nodes with
> the proper dma ranges and related data so they can do DMA
> correctly. Then the parent device has to assemble itself from that
> collection of struct devices.

For VPUs, these devices(or blocks) shares everything with the parent 
except the IOVA aspects associated with the stream-IDs from these block, 
something like

Iris {
   reg = <>;
   interrupts = <>;

   block1 {
     iommus = <>
     iommu-addresses = <>;
   }

   block2 {
     iommus = <>
     iommu-addresses = <>;
   }
.....
....
   blockN {
     iommus = <>
     iommu-addresses = <>;
   }

}

To handle such case, we create the device dynamically and associated the 
distinct IOVA range to them,via the api introduced in this patch.
This was prototyped in recent SOC here [1]

[1] 
https://lore.kernel.org/linux-media/20260313-kaanapali-iris-v3-1-9c0d1a67af4b@oss.qualcomm.com/

> 
>> These are synthetic child devices created at runtime and do not have their
>> own of_node. Inheriting the parent of_node might not be the correct way.
> 
> Why would you create child devices at runtime? Linux doesn't really
> have a good way to create a fully DMA capable struct device at runtime
> without a DT backing description. The fact you immediately hit API
> problems like this is a big clue :)

Other than this API to associate the iova, i think we did not hit any 
other problem so far.

Regards,
Vikash

> 
> Jason

