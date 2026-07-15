Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DE53B71AD
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 05:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784094962; cv=none; b=FcCPfv4aK9IP1Kb+vqFSr42R3aox5w9lG3j0Q1icQIFQxebegRtQfiISqqKI1BTC+xGpHeWjaZkkZCYfiE1gDl0p6l6mpIN2FpoAyjwnl0NzsEyYPo44J8+HIvIqSLy7DcgNeIrP7gnzQq3KF20Ll5JTrNJnEhjxwIC8YrWKbas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784094962; c=relaxed/simple;
	bh=5HTXX++gicPMEiTjJp/dz1aR1JmBPBM9RA7EJEs+w58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgMzW82icWCts+ptC+u2e2xUcVXhzyyxmQFIMjkfN3BpCGJHfrJHiq3+AoR+wgmoeqr61mzT11RygY4C0V/QsrSDEe5TBcxJE7En7O319mjlZdi8tgIbZHRz/t9wp8qgKMyi7zxPie4b3eYe0RE1jwQgo40b1lAZji6nkvnRXf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L9w7LnyF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dN9d5aMI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L9w7LnyF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dN9d5aMI"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3l6er2596174
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 05:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pB/j4DvH2ZOcHrab8vDDXcKtg1x5ii9LH73zX87n3Ko=; b=L9w7LnyFUmzSTGLy
	yK2/duhNZU8lZP+CmJGkP12TeN1qlqOHUgI4rMbR7OQVLjvLvgd9afCBbQuXrUr+
	ZqJUp0wmuFzSDngL1udumNVEj0hCuv08mZi1Y2f9SeZsv8+/6spv5FTfgza4x1IF
	fNEce1u0eLMc5e/suI5aYAfswvCcbnoxb+MC1trsZc9S2iMNwSOubGNTP+7mFl6w
	j5tRExgm3kDrWzzjXAwC5XmQawIX6IpFwNBjUGbBhyQ72BR3dfVOv5rnoBg3q3EA
	zO5nNb/j9MRaK7z/baBtednwF0k0s6KGI6KBvG3WvqWoA7pjyfnVoLg+huXqN/eS
	F/iVzg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdmjq3f13-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 05:55:57 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e22137fb3so828406a91.0
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 22:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784094957; x=1784699757; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pB/j4DvH2ZOcHrab8vDDXcKtg1x5ii9LH73zX87n3Ko=;
        b=dN9d5aMIre6XKXahAVbQjJ580LgQ0rpLOH1y3MIbTel9KgHCgRXJfZyv3snfqKS46z
         lroOc55kEz+EdM2uW80Hnd7szPQehYji4EZSJh/KMkKU6VTtNBf51sFUoU7JiirVVGnd
         tJ5G9BvZlOUp9tQ0ETnt8SHM+W1830d+MCTy/dfSNm0Cd3tc32/GzwMoBpcH8rwafGSv
         xsYmD0aJ94hhXlNWFgU+EWxNd0a25ia1ogzliNY0NRLa3kv2o93H7w5kaPL0Sr89Fr7f
         rkiPRBJT0Avbc3kEb19+p9PJdBhKCNFXaODuhrufR1bYgcVMtFtuXutCd/0Nl9AqQc/o
         JkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784094957; x=1784699757;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pB/j4DvH2ZOcHrab8vDDXcKtg1x5ii9LH73zX87n3Ko=;
        b=Cper/etwvVKPVWtxTnADuSwxtpKstp+VS++Ck2yNpzVj+HeQQBI1gm/JLyrXWz7H6s
         zhmIQiw/ydHGaSDbd2Jr4mSAaKkIYH5AT1xvxW+sJLDY/KbfhHuUx/yyAkZH5FpS8IQ+
         Cb5nxMpseyU+FU41YrklIQXZ/8PBstYehbOGdTE5+aGPa3+8g23DxVi7Dj5uc+Y/v+YK
         hsKsFDrb72PQzJDk+DdQHLO8HFf31ingeqb++gQpvUZ611t84kUYXHcLNe+MBHA+iK+S
         +wCpKkXWC01AP5sUbSyPVpj8+jdgleDiywNLs6nXAYiFxM3HzPNG0Nm87goFPF3QGbRs
         7W7w==
X-Forwarded-Encrypted: i=1; AHgh+RpQob/PZxX2SkXQ8UXIYud0KTSbXTiq7iy22MQ1mivdQBSoxkxoTx7qhNkt8c/wqWZAUEilog==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1tDSJXbc+rTUJHZkzq1uQ5N2YZyOZsIpdw4o7bvbSFbNOCFxr
	k0ODcrCKr3T53dwQVI/icdfYsFYKnT1TDmDA9fvYFGzZKrakQBNQUmdtat5sdCH4SozHDLdjOmW
	Tft4PiWfqTuXl+ZI99nqdHsce1hTob9lC5id5WyfszClERo4tic+ML+cxlw==
X-Gm-Gg: AfdE7clUAwzTYtEKX83NZK0/67ZR4vx82s+hxzL7LnFEAuXzCyJpaJW4nXqVXupX/mz
	sG+p/O+KjT1f62jx5TNRLjGhbmDhqN5LkEWmmmLDrt5bAGYc2EEC8mEqDhvcPEMbAcedgcHKmzq
	MtBd5ICeNajU/5KvH5dI7VYieVjJIhX7dIPdd61oihROdwL9IxG3wLtGkh0kxsx/8mY9wJt7mFz
	bQCjyD+cj/pI23/PYtD0ntI5WTE8Js1CkrfRYMefK7RH5rUnCLeAAuCnxIQCtL/a/HrzLew16TQ
	w6wcEEMsSx9LMtaSXGWJP4kLoSYPeD7GyckNgTFHQGCXWNql+pYCVMOzuv1EBGQmKG0+SawmU9f
	6WgCSM4ehjrLe2Xv4tzitbJM+9v7B+XSIIF9l7FFl1mDN
X-Received: by 2002:a17:90b:4a:b0:388:cf45:d72c with SMTP id 98e67ed59e1d1-38e1aedd604mr5217133a91.15.1784094956852;
        Tue, 14 Jul 2026 22:55:56 -0700 (PDT)
X-Received: by 2002:a17:90b:4a:b0:388:cf45:d72c with SMTP id 98e67ed59e1d1-38e1aedd604mr5217113a91.15.1784094956377;
        Tue, 14 Jul 2026 22:55:56 -0700 (PDT)
Received: from [10.218.39.50] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172fd17asm2560963a91.12.2026.07.14.22.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 22:55:56 -0700 (PDT)
Message-ID: <b7224dff-7e51-49cb-8421-14d090492dfc@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 11:25:42 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/io-pgtable-arm: Add support for contiguous hint bit
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>
References: <20260618-iommu_contig_hint-v1-1-4502a59e6388@oss.qualcomm.com>
 <20260703161228.GA1948451@nvidia.com>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <20260703161228.GA1948451@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LqmiDHdc c=1 sm=1 tr=0 ts=6a5720ed cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=fcmBhDXz9gjiIA-sPNYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: Hee3AmMoiLpAN9-5OkcCmZqNJOwnYYkk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA1MyBTYWx0ZWRfX0rPL52zRtsMG
 GqH54WEjizqCDIWeCaZJZGgSOozoZn1H2LMCXb/PYcWYNevPaWhXymcmCg49gO/mD669dl9FvnX
 MUUqWpnPlvH3kiefUoxu/BhkNPKrodkVnoCSbKNzEwh62IYUXu+HJsVk6HjZ34YLeJ2pKiiQLHa
 vasaZWfBugJuDtfTKZ2vFlVJrHCUb/vPk+vxFSLoCYwqO2sExS9gaCBQW31eLefymWCRMlBVv+l
 kTEHCkitn5Tb2yWhTWu2icWhFY/1Tf0xPa5Qrv4JsLGuHXCPD1jxIMQtocwdjQYHIH8o9GmdHh+
 HmXeGIzly9zxY+FyEIMAdIK5uXYArgIUxkCtIa4Z1VrwaF7q0oOV0Tl/MF9n5wkDZWIsdNnS4B/
 a0UOoEvHVlh6ojDw5s34XCYkr5T8UDMqa/i76JVJpfGlZRFtCUqqRbad0tuOOx8aMvtn8uduD0S
 IO4Tp4p2xk3vNgRQ9gA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA1MyBTYWx0ZWRfXwHKpGIdSyEMM
 C54RlOf+5uUQ6IL5ujn61MbO/erfkNhx4QeJIzq0mRKwA3AM8olJeew9F/6osSGUXY8p7hOdeYk
 DU91GHYc5yzq7ZzBNXiHkuPKGLBiBB8=
X-Proofpoint-ORIG-GUID: Hee3AmMoiLpAN9-5OkcCmZqNJOwnYYkk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150053



On 7/3/2026 9:42 PM, Jason Gunthorpe wrote:
> On Thu, Jun 18, 2026 at 02:32:09PM +0530, Vijayanand Jitta wrote:
>> From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
>>
>> Add support for the contiguous hint (CONT) bit in ARM LPAE page tables.
>> When a set of consecutive PTEs map a naturally-aligned contiguous block
>> of memory, the CONT bit can be set on all entries in the group to allow
>> the hardware to combine them into a single TLB entry, improving TLB
>> utilization.
>>
>> The contiguous hint sizes per granule are:
>>
>>   Page Size | CONT PTE |  PMD  | CONT PMD
>>   ----------+----------+-------+---------
>>       4K    |   64K    |   2M  |   32M
>>      16K    |    2M    |  32M  |    1G
>>      64K    |    2M    | 512M  |   16G
> 
> My series to convert smmuv3 to the iommupt takes care of this and
> supports all the orders too. I'd rather we move forward with that then
> try to patch up this.
> 

Thanks for details, I have gone through your series. As this patch
targets io-pgtable-arm.c directly and would benefit all its users (SMMUv2,
Apple DART, etc.), not just SMMUv3. I think there will still be value in
this patch for the other users.

>> Support is gated behind CONFIG_IOMMU_IO_PGTABLE_CONTIG_HINT, which
>> provides a compile-time opt-out for hardware affected by SMMU errata
>> related to the contiguous bit.
> 
> I reviewed the errata and didn't find any related to contig that
> required disabling contig, the driver was OK with the ones I
> found.. Did you find something specific?
> 
>> On the unmapping side, the CONT bit is cleared from all PTEs in the
>> affected contiguous group before any individual entry is invalidated,
>> following the Break-Before-Make requirement of the architecture.
> 
> BBM means you make it non-present and flush, it doesn't mean you clear
> CONT, this is wrong..
> 
> Jason

You're right. The arm_lpae_cont_clear() step was introduced to support
partial unmaps of a contiguous group — clearing CONT first so that
individual entries could then be invalidated one by one. However, as
Daniel also pointed out, partial unmap of a contiguous group should not
be supported at all. Since v2 will enforce that an unmap must exactly
match the full aligned contiguous range, arm_lpae_cont_clear() is no
longer needed and will be removed. The unmap path will simply write
invalid entries for all PTEs in the contiguous group and issue a single
range TLB flush covering the entire range thereby following BBM.

Thanks,
Vijay
