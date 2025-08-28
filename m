Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290A313DDAA
	for <iommu@lists.linux.dev>; Thu, 28 Aug 2025 06:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756362740; cv=none; b=OJXbKd+GgCOjWuSsDYEY56xGghLUUiBUfcPy/WwCQDZLkGRDYzqFLA8H54xe+blfcvY163uAdCCANikt90/z50qLq72rpk+vUIqWKR1omryjLcclgp7mJtiLLfAooi4IwwY3KOd896FalOTCvpgX4IZj9pNsFtsicddcU9v3VP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756362740; c=relaxed/simple;
	bh=Q2021Pe34K0Sr8t6+35XLrrYTx646DxiOfOHLWWB3DQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PtEFRV1kfLlaR5jXOfcJDOxU4fdeuR1PRzGl/s5cDcFJkZyn8eXfSZiiaTzskjYLH+CvHaQ8I78t28MGs3FXBC1Dl9LtKPrIL6kHapp7wJmBJghCtd+z9ipaHRBerfDLRATY3MEXZY33P1j1pmj6NLsaoLqVcUOrDP2+uWWLL54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SqmU7GkQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SqmU7GkQ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S5eJNS029266
	for <iommu@lists.linux.dev>; Thu, 28 Aug 2025 06:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zTj1+Lvk1yn7ZHBLETS3UVFva4Pjn5rnBY/gKCJ4AmA=; b=SqmU7GkQ91YJIPT7
	FinQAMTtWqPHkC19SvuTZDsfCeDlJqvHUKpyvkzqrHkI8lJ4MoMjwJx5yMu1aGGM
	XIWitkwKvEj7ACIhewAAv6iv9Oky0OSeWZPCTCgMP8HKxQYryXNuTvsbvWNCDkB1
	MgCme5Lhba4cm94HCt8Zhsjkh7PQVVZPVIQkm9+PwqeUKazzuHvSBgtcP7Wu6COA
	ga0E/igxbnDiSVHbqovEERKIspBIG9jE7t9ywvIandIgNGZ32XdW/ul7alQCfMVo
	xczpNuV+ahkVqT883jKV6bkpEiOz7CVFGceABSrFRx/xLtMofvD4TfR9qdMydzMu
	6XTh/A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5umfapn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 28 Aug 2025 06:32:18 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-323766e64d5so1489654a91.0
        for <iommu@lists.linux.dev>; Wed, 27 Aug 2025 23:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756362737; x=1756967537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTj1+Lvk1yn7ZHBLETS3UVFva4Pjn5rnBY/gKCJ4AmA=;
        b=bEs6DNj0Z6gTQUEmB8Oo0a3wwm9QL6RT2TfZdSqDuiF0A/fRv1z/WU8ZTdna3Z/0vi
         1Ri4aUULr1e7R1/Bl1vYwsp+GehHLhSRB8l5slJXhV+iPJ+mGDqqdOubrGivWCBO5XgR
         dqyhat/6czLeM7WP3/Eo0LvqDEds5mC1KlNhXKpMJrfuAh22PvMvDLjlSK9/53sv+NeS
         0b+Il6QJTib9Ew969BkM1UDI1MN2IEYJeN175O84S6mLODKtxU41k9s0gJrtG/4xKn7f
         Y0wegq5XJgBgfFTbiz2RxCFWINA056I6n73HVK3JYRkvRCMsOi/w0rPaWrOhh4mPV4Wh
         i+eg==
X-Forwarded-Encrypted: i=1; AJvYcCWNYplvGn7Pp1BtaYxa7rMYaPgoFaUFvCREtNBWGdyDxmMDmP/U+oDCb42gxbhMoYuRc/boEg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZw70dBCLPwZSOcB3j3jV4041QjFuHplgNf6d8WCwKKeJ+qpXc
	hk6qnKqbjBqPl95v0P1D5RSVidotjKHYpdiHbG+4NQNI9rKehHNg0+c9IdmInQlT4EdO2YaUueL
	noYUgEwzcuT9pzMAvhOK6DuLKM2tHvBwQ5ziBudZVWDQAQly+AdMlcn6qfw==
X-Gm-Gg: ASbGncujPS010wsa93kjbPWz5nYL0d5mWCtZ+7KHLNMFrqoDP/YvPvdMbuCUMZ2//sp
	Oo2aDSpbZibhW/4MVpXQawqKaEDzBQHgdSHbk7B7VzUuIoQ7D6TKEGRFvIlxvZJLmbkcd1yXfgN
	iYw5AJ50hfF7/j+Bu9iwuC45ay25o82PvKRts7fQHohqrkTRI8neX6eAt1LroAuQrRTXllfzKvL
	9ezzhz2ESYoxFg7KCdSG/Fi+Jb+KSwdeJmjoqqLgLFIhF7wY+o5JV8KChvfrkr5kXJtjIM9+5cp
	vlig7qL6D+gg8pU75wVcGJX/8Seg1dMBHFhIbirExM/wJ1N/XRFr2Y21deyzFgOZiSaoACVDzYU
	KxCF1B7mArKB8z14VTuT1y07UrXfcz+guW8y21Q==
X-Received: by 2002:a17:90b:5246:b0:321:82a0:fe50 with SMTP id 98e67ed59e1d1-3275085dabemr10058702a91.5.1756362737236;
        Wed, 27 Aug 2025 23:32:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzi0sS96jT+LA7Vd4RQyv9GmttL0b1pHYtJpEfUGzXSzx0mdrwZTiyymIqRanTlSNCHIuSdg==
X-Received: by 2002:a17:90b:5246:b0:321:82a0:fe50 with SMTP id 98e67ed59e1d1-3275085dabemr10058660a91.5.1756362736751;
        Wed, 27 Aug 2025 23:32:16 -0700 (PDT)
Received: from [10.133.33.184] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f59e29csm4065656a91.12.2025.08.27.23.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 23:32:16 -0700 (PDT)
Message-ID: <ceee4a15-b31b-4c8c-9a8f-7093b85f99cf@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 14:32:11 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: is dma_mapping_error() check necessary for
 dma_alloc_noncoherent()?
To: Christoph Hellwig <hch@infradead.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jeff Johnson <jjohnson@kernel.org>, iommu@lists.linux.dev,
        "linux-kernel@vger.kernel.org >> linux-kernel"
 <linux-kernel@vger.kernel.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
References: <ff6c1fe6-820f-4e58-8395-df06aa91706c@oss.qualcomm.com>
 <aK60Py3r25U43k1E@infradead.org>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <aK60Py3r25U43k1E@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VtIjA/2n c=1 sm=1 tr=0 ts=68aff7f2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=d_vTzFHel96VW_NBT_kA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMiBTYWx0ZWRfX5rb4GQAk625L
 8JF3NSu8q4lhIEHixhyyDudHa87kuql6hLiu6OusTfpft5TaYQPHqRSu5oX8PwN/mknSIWzsmrh
 ALOBeTw4eaOStAdSLs87zxs7Hz0HvK46TeMN9wFXpLlTCqoAs9+CsxfLkmdwc73uZCfk+Bddx0A
 SCwq10N/1fVTHezjnncvRbu6b8fqDhfY5MqYMIWUQ1bqVBOpJwldZIZFoh3nM3Mb0aenYpcPSmF
 Mvxhaxgr77e8wEYxQx/GKqH6D5E7yPkK6LI4KBhIJBaN6PukYvq30uhdXJtUw4RLvXBzCc6W+Q6
 71zduTvlAyw6Txp7LAaoSCVS0JM/5O8Ft5voVahbT9kyiEKAW4zRx0VE4QEIny14AoR41UDCOJI
 6QcEpjFe
X-Proofpoint-GUID: LZzZWJcYmtoZWhsRJ88_21DFkyBnC9A4
X-Proofpoint-ORIG-GUID: LZzZWJcYmtoZWhsRJ88_21DFkyBnC9A4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230032



On 8/27/2025 3:31 PM, Christoph Hellwig wrote:
> On Tue, Aug 26, 2025 at 05:44:42PM +0800, Baochen Qiang wrote:
>> Checking code gives me the impression that I should do dma_mapping_error() check as well.
>> And indeed with below diff the warning is gone:
>>
>> +       dma_mapping_error(ab->dev, paddr);
>>
>> However this does not make sense to me since IMO testing the CPU address is good enough, I
>> can not imagine a valid case where DMA alloc/map fails while returning a valid CPU
>> address, no?
> 
> Yes, this doesn't make sense.  dma_mapping_error exists to provide a
> error handling path for dma_map_*, which return the dma address only.
> 
> For the dma_alloc_* interfaces that return a pointer and can signal
> with a NULL return it should not be needed and dma-debug needs to
> be fixed.
> 
>> If I was right, should we remove invocation to debug_dma_map_page() in dma_alloc_pages()?
>>
> 
> That allocation still needs to be tracked, so it can't just be removed
> but needs to be changed to record the kind of allocation.

Thanks, I will submit a patch to fix this.

