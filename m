Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587A035F8D2
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771333753; cv=none; b=j/nq2FcB5cYTdt9pi/RU+/xbh+7FlaurUgoyWqllOYYKi3pt0b4CaoZ5ofzTQPIkPdujoD3P6TUV3uCq3ldjTGe4fHxeIB/HjGrX16jDBcPLFVM/xUeH9ozCuUKQ/Dl7Xb01BE548AqR2Tw3hHw4WJPzgpiOIHCAfo7DoLsKX48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771333753; c=relaxed/simple;
	bh=08/3OoJXMaNcdEliZZW5uDgDHXHc6I9x7HTVt6Q4+tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNJAEUJZTFIxEWY9GuPiUJrDoz5WCrvBRWg1z0sunzve3QHFtu7hyfJNkROTNwqYS0YvQmiew0Sylj9eNjBd0LSebJj91xsIvUxd3ye5Lmde2d31YggPuRhQJRHwJvA2dbezWs2ZTMKnB073R2sh+w7dupiGPwDC0ouAVYoJTsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dybNB+Ib; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=StMXUBUa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dybNB+Ib";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="StMXUBUa"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H89Qh2048812
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 13:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ifylqg/fOmpo0N2XrSn2luRh1AIgqY3MN7R1u/QkYd0=; b=dybNB+IbtgzBOO1s
	5Ya+F27i4OYAhp00K5Nedr2c1YK6zn4RDOMh2HYVCMvKoCPIc1kVHtYFj2AithNB
	djKxZ36SQnZ/GAt863XAz/2t5WJBaETfSdfd7+dKTZpddSOuli7g0CBpvt0a/ejD
	/bBWPzAqwSiWtQU+7byN+qViBbf26rgFJP8rZLa/07PrvCfpJ0kPaJjEVqZvdUbr
	DTA3QBDrh3FdsSlr/uHlpeMzfcvmePnBfB4koG5AVrgCJQMOhQb9a7Cr3PFMnVoh
	DT91N87XyUEwrFadIBvh9lv5jzSawKrmlTpIJhEegajfTDbFOi+5RV9kPsvTzymD
	2HaXbA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6d82fjj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 13:09:07 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c6df833e1efso14411671a12.2
        for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 05:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771333747; x=1771938547; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ifylqg/fOmpo0N2XrSn2luRh1AIgqY3MN7R1u/QkYd0=;
        b=StMXUBUaJkGvvsANUAfDGjcd2mm5hx7jrWIHcBEB3628v6nXM9ddTDJ58hYYtVoRHD
         k7F5sf3HqYjnqm9ewAgJ934eBt/CKW+aDmGP0aUG8AYBYFxgoDeF+eEna/pWHC0reUwp
         cBlxcGaOmAJHv1vSsTn6TcSjlLZ9+T4qCXdMM28Uuo8eCH7BnO6p55VDxr6Ml7TgGNeh
         lHjMuAkQoo/gZsokaD9zIZg6jVf3ePM8sL9jrT9cSCUgFYlUM258zMA0NtiHoH/1/oGk
         BXz6bd8kl4wHnlWPJtf5F8ETXyfngPI8a+6GCgdjRA2IefPkQz+mGYjivSgVtbEH1AH/
         QgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771333747; x=1771938547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifylqg/fOmpo0N2XrSn2luRh1AIgqY3MN7R1u/QkYd0=;
        b=U3rf+0AwSN65yjKywi86PKtDGEohU4ix54Wmv5LaJOSIsTaGOWw19HDftLU1sMdnyR
         b0ZjJMbNg9zESQUo6ufqZOQsqt2GxpO77s0KRxQZyrPNm5TUQ/gHMrL/bHfps+TBcHr3
         oHHfz/MVVt8glPtOS5NtaELXqa+fXVBeYPRMY3g4hnbC4mGKRPfjN7YADbUgaYGwezzc
         ok0iLNyQEdIyTcj0J41R+nEcAlsurB0WnDOe9TnBivxFGRS85MAa2PciJcefpTkZSkWy
         6F7ZYLv9s3LNrs/kU2Z7EbDp2qwC7TFbdj6dDWrexqKPkn8odRj/RHLD/HgFXmAdBhiO
         ZPkw==
X-Forwarded-Encrypted: i=1; AJvYcCUuJQAiJ7OFpKHV6Bxk9GN0ytWPE0+jNVtG/Wee145tERxY57NH8fNolx2OP40nSPAvcXEd+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yznb0Br0YCfem8M0HbTTv3OfWelBHGXXKFSyZzB5oiUciueW/zy
	JUJUknA7K0J3mDgd/dp4jrbJOFsNEAu10f4NYFm6TJWsiwF0eG23ufrnKjDUG/RAX9e7xP2XvaK
	UdmdmLSs3wNrhlKGGcH5WW3qfuJKeBzrZWm6cLpCitRi2vfW0A6KvrFloNg==
X-Gm-Gg: AZuq6aIXa3btgXqhULmswe4LYrlJxLCRuON2pswaA92hVeoJiK6INhWMkji9gGTptp1
	VQRY9OZI4MP0R42QFOtSJ9bRosVN6sFzeBy/Wkb6o/ugyJwVIfgoHSvGSK51AUrRrs537MhCPZq
	IP/nHN0o7cjuKAGtW0KnApqABf7fDQ6gfAmFDR+35NPXCDSC6ec0uHQsn7OixvWn4EMO+pLyOR2
	n5Q0JvvsFsbU4Msmh5Mp2zQphnbgZQNlORrQQoU5SOMgAFQIMsT6Vkt++iombkoNQ2z5xYEXqJO
	x1pol6hnCL/8N2KAzpSBMTx+NTtTkp8O2LyUjb6QVLjXLiNdsgfN+/+dJFnYP6GeCbXYbTxTKtw
	NBPbV+aArreUgiPyB2HNW1M6Kjr8Mraaif1PXM/yX0vmF1luYQWaL0w==
X-Received: by 2002:a05:6a21:b98:b0:38f:df47:87a0 with SMTP id adf61e73a8af0-3946733d9b8mr13246205637.61.1771333746653;
        Tue, 17 Feb 2026 05:09:06 -0800 (PST)
X-Received: by 2002:a05:6a21:b98:b0:38f:df47:87a0 with SMTP id adf61e73a8af0-3946733d9b8mr13246155637.61.1771333746130;
        Tue, 17 Feb 2026 05:09:06 -0800 (PST)
Received: from [10.204.100.45] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e5332e0d1sm9782405a12.31.2026.02.17.05.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 05:09:05 -0800 (PST)
Message-ID: <1c3c36b9-7367-462f-8280-16477d3ad20d@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 18:38:56 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] of/iommu: add multi-map support
To: Robin Murphy <robin.murphy@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
 <20260126-kaanapali-iris-v1-3-e2646246bfc1@oss.qualcomm.com>
 <hunwsdkmeo6efpv3yt3izkgmarelnubd74dywj3scryxrreq6p@njijwtoyjh46>
 <78ffd1ce-5408-4bf5-a782-0c4ca14017b1@arm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <78ffd1ce-5408-4bf5-a782-0c4ca14017b1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bqVBxUai c=1 sm=1 tr=0 ts=69946873 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=pTTk568K-quJkV0nBCAA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEwNiBTYWx0ZWRfXywyOpi7fkJBt
 sBCCrgj+7E2iSJ9bdtjhCPFE+OYihR1Ox/IAqCoezu9SvWQrBOaYHjXMuTAQWgLnCtYoshsCDNS
 2CNW9FK1JZaSaCi5bM8a5VZ10x1sU5rNEThKMLqZAaXGYmyXRtoT50XQbOqmBl8YcqHAbixOHKz
 xyDVbRxVF51LhX7VBhIruUmEBiPK2ZVsjyMuFLzD7eDGVWj/Erl0hvS1uTiaZJRWT322+ZIsSOf
 UhtylFsYalOhlQnLgqfIS4w8/ptzgxIC46wREE/Oo7jvi9AS6GwFYz8e7LB/sQceBfBkNQ0TRMX
 QIxk28CGb6XpKioA8DK9OK85z/3yeIXz0n8v5hMXY5eND8B9N39tducnYA6Pb67qYHJF/UfAWlZ
 rKj8cNSpJ0aP8oOjWULWOP+OiRa7tRCXLnOb/usjyaUpnqUEvMw6NPJx3VFJDuJHafJI8uRdU9b
 6/6ZAXesvkuX7qk/n2Q==
X-Proofpoint-GUID: lEdNNOzm75JQbxEtiGf__D12fjQ0WfzU
X-Proofpoint-ORIG-GUID: lEdNNOzm75JQbxEtiGf__D12fjQ0WfzU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170106


On 1/27/2026 7:50 PM, Robin Murphy wrote:
> On 2026-01-27 11:45 am, Dmitry Baryshkov wrote:
>> On Mon, Jan 26, 2026 at 05:55:46PM +0530, Vikash Garodia wrote:
>>> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>>>
>>> When multiple mappings are present for an input id, linux matches just
>>> the first one. There is a usecase[1] where all the mappings are to be
>>> maintained in parallel for an iommu-map entry of a same input id.
>>
>> This contradicts the IOMMU idealogy (at least as far as I understood it
>> fom the maintainers): the device (driver) doesn't control which IOMMUs
>> are getting used. Instead _all_ defined entries should get used. For
>> iommu-map it means that if the map defines several entries for a single
>> function, then all entries should always get mapped.
> 
> Indeed there is no concept of "multi-map" - if a single input ID 
> represents more than one thing then that notion of "input ID" is 
> fundamentally wrong. A single *device* may have multiple IDs, as in the 
> case of PCI bridge aliasing, but in that case there are multiple things 
> to map.

Let me take examples of kaanapali and sm8550 and describe the vpu stream 
id generation part,

kaanapali:
iommu-map = <0x100 &apps_smmu 0x1940 0x0 0x1>,
             <0x100 &apps_smmu 0x1a20 0x0 0x1>,
             ....

sm8550:
iommus = <&apps_smmu 0x1940 0>,
	 <&apps_smmu 0x1947 0>;

In kaanapali, 0x1940 and 0x1a20 are the *resultant* stream-IDs. The 
resultant stream-id is generated based on
c-SID --> generated by vpu hardware, controlled by video firmware 
programming.
Topo ID --> port id, port at which vpu is connected to NOC, decided by 
vpu hardware.
TBU - smmu translation buffer unit, decided at soc design time.

Now if we take 0x1940 and 0x1a20, c-SID is same i.e 0. Within VPU, we 
have video engine (vcodec) and processor, both have different TOPO ID in 
kaanapali, whereas in sm8550, both have same TOPO ID. So vcodec and 
processor may (sm8550) or may not (kaanapali) have same stream-id.

There are some buffers, like internal buffers, are accessed by both, 
which then need both the stream-ids to be mapped into single context bank.

If you see sm8550, the requirement for both those hardware to access 
internal buffer is still there, since they have same c-SID, same topo id 
and tbu id, they have same stream id (0x1940)

Regards,
Vikash
> 
> Thanks,
> Robin.

