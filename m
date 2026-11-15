Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794735958;
	b=Lct52kzXi1928NYDbalViSTmvEjPiTulZh2EcQxLNEQIKKWa5ne0lz4weGt8XW6q/FOt
	 f/J/XquSj+oUZlhUmjAnqhlle3GrpVjZcV8xTluPTEwK5eELzz4M7Cej/lUbLnoD06OVU
	 brE9g6w3+tFPMfhf2YZelo8T15hKY9AZ3I/SK+8V9U+aMgxzU6fEhYlbSGd8LkPIbZMsQ
	 OQ84OCtT8mg8d5qiAl0BxATDQ6BnKNmJU4Q4mm+2B1v5z4qz4NVPiD75kTKPyUbVB/Zws
	 f2tYXkpWbPhq+euZEKW3fwu62rJRri2kN08wxIeTCGdlvRWNexWh8EhEBYkkQhTpS8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794735958;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/H7ist9tJ0po06viy1vxuJ3/qEXrpm4LsgaJ7Obvc10=;
	b=uAgx2cGWu+alAUxHSdacrfTloxOHxpu6JsurKlHABV1hLfyyGKhF0N0ZdmCb1i982QOY
	 dhmTESy9Nq1kcKI2IuhcSuN4Yj7pL4qq5gj4HMK0E6QUtre7dAhRp9K1wEufUZmw8FUuD
	 icpM0G7J16mdI8NLahgRemzuGyA35hPxDnvFFOokWCZ3KY3PYjub4qKxL3VUVlD5QhmQi
	 MtFZCAMMyTLYOZ4TTlh8Mt/dlRk11sM1EhfVuTFVQn65mABF145oamVQFMDlEcqnHi6yN
	 Rd5qiUG57oHHSGJnc657wnZY8nL8oPlxWm8DAkbM5z0KGXntuxGa4xDJzSi0KJFPqYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UTXdv+nO;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237FC606A31A
	for <iommu@lists.linux.dev>; Sun, 15 Nov 2026 09:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 237FC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UTXdv+nO
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AF7xdeR3780179;
	Sun, 15 Nov 2026 09:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/H7ist9tJ0po06viy1vxuJ3/qEXrpm4LsgaJ7Obvc10=; b=UTXdv+nO8OZ8Cc9K
	gd0ALDQficAKwW9yH3MsH02kOqksuFmHkpMfFiv4eJopGePEqCtRha9KcWLgwKHi
	pFcJTUHlwr+pS5IoFChujYBKY86bCfGrdL8TR6NVOJQ1MDi+UvUszW+S4ur78miq
	i3iRAmU+ZH9a71HPF0ffOJ2NKphCdPGC0IM1rZwDHSHQDrF8CusKgcTTs9mlzjzl
	IngWrYvlYDFAq7UpFqJDoVNVxcCCw62n/n8jaU+s20kX24bPvx0QRGGhZtc00b1W
	4pAU9SCqzdzGqN76q8N/I7kv8jqQAOjCbqcQFMTsmb2io7PqLxvgCTRauvbSGdfD
	2KAQIg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhm8tm86-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 15 Nov 2026 09:45:45 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AF9jhKW2604307;
	Sun, 15 Nov 2026 09:45:43 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-bibekkum-hyd.qualcomm.com [10.147.243.199])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AF9jgmu2604298
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 15 Nov 2026 09:45:42 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4253010)
	id 99C045FF; Sun, 15 Nov 2026 15:15:41 +0530 (+0530)
Date: Sun, 15 Nov 2026 15:15:41 +0530
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
To: Val Packett <val@packett.cool>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 3/6] arm64: dts: qcom: kodiak: Add GEM_NOC
 interconnect for adreno SMMU
Message-ID: <20261115094541.axsybs55kedvlank@hu-bibekkum-hyd.qualcomm.com>
References: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
 <20260706-smmu_interconnect_addition-v3-3-afdca0125a65@oss.qualcomm.com>
 <h6opbtr2ced3sannj3ym573qc2sjk7ek3clpto5j5mtqfrfk6w@34sk2zraoqtj>
 <807f145d-88d3-460a-9862-b63fe2a52cf7@oss.qualcomm.com>
 <a4f5sod3aflubxkk4mm4k5ozddydqcnqeac4s6vnozkd2nvxbi@hmh6zclsw5z3>
 <4e5a3d82-b946-4490-885a-ea7061939c32@oss.qualcomm.com>
 <ak5qkRKk2eHHLYmo@baldur>
 <2c21041d-f84c-4fa7-a977-555f9203d8b5@oss.qualcomm.com>
 <4ce436ed-63b7-4764-afc5-dc5ffa4f0ba1@packett.cool>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ce436ed-63b7-4764-afc5-dc5ffa4f0ba1@packett.cool>
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=ItKL47/g c=1 sm=1 tr=0 ts=6af97f49 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=pq1cc4_aG4dz-00lW3QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDAzOCBTYWx0ZWRfXzsV0SrSfIXpR
 /0wykZDNvcv4ZERAEqt41SugVaLDzT6ujBhPpjCKfjXAMUvZc+S4e305U2nfxQbHAsBHstsusl1
 wMzd/npCxHAGzVIuAumMyIqqR+wLt6g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDAzOCBTYWx0ZWRfXzu+QoH68rj9B
 lHgtNsDWouxEPvzmlkd5pGrqcWS+V8DjK5mDcR6z4kahuGIXmmznL1xszZThYM1dwzfEDFn7Rxc
 hit7i2iVapBy1WKB1FJdX1SdopJ/yUgMbRCy/yympDpLdJvKo3q2+Ex9mszfzGlERhLRxWCpKpT
 MQmRnkYpbsjLPUcKtHaou29kPEfxJ0UQR9a0CWpUK3fJDzNASVfiH8XTp4IkiFL9en/fwGAj98T
 NUMfgii9Z3vunuLC8JACxUeK8tsfJNBTb2/YRACofwjhz/49ajWlt8oOVneUyX5nXOefkWAefLH
 EGF2KvIaRQQETN9NomuXzAP3dv5YoYEyDE2X9aIW1dRh+eIZqPHSm+gcW3iI6U1rxm1S0UoDCtz
 UdyZqfpQGxjxcuD9K/jUXGo3Y8v2Ufw4xnLM6B70gBX25O+6wVWd5+9WYV9db4U0bI/tUZJaGVf
 WxW9yv1iq2yVKJ3cUqw==
X-Proofpoint-ORIG-GUID: eLMBCF6MfO3K9RJdKnVhAf8HqjIlwkPZ
X-Proofpoint-GUID: eLMBCF6MfO3K9RJdKnVhAf8HqjIlwkPZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611150038

On Nov 13, Val Packett wrote:
>Hi,
>
>On 7/17/26 8:40 AM, Bibek Kumar Patro wrote:
>>
>>
>>On 7/8/2026 8:56 PM, Bjorn Andersson wrote:
>>>On Wed, Jul 08, 2026 at 03:31:07PM +0530, Bibek Kumar Patro wrote:
>>>>
>>>>
>>>>On 7/7/2026 10:14 PM, Dmitry Baryshkov wrote:
>>>>>On Tue, Jul 07, 2026 at 06:37:24PM +0530, Bibek Kumar Patro wrote:
>>>>>>
>>>>>>
>>>>>>On 7/6/2026 11:12 PM, Dmitry Baryshkov wrote:
>>>>>>>On Mon, Jul 06, 2026 at 10:26:36PM +0530, Bibek Kumar Patro wrote:
>>>>>>>>On Kodiak platforms, the Adreno SMMU requires a bandwidth vote on
>>>>>>>>the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before 
>>>>>>>>its registers
>>>>>>>>are accessible. Without this vote, the SMMU may become unreachable,
>>>>>>>>leading to intermittent probe failures and runtime issues.
>>>>>>>>
>>>>>>>>Add the required interconnect to ensure reliable register access.
>>>>>>>>
>>>>>>>>Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>>>>>>>---
>>>>>>>>    arch/arm64/boot/dts/qcom/kodiak.dtsi | 2 ++
>>>>>>>>    1 file changed, 2 insertions(+)
>>>>>>>>
>>>>>>>>diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi 
>>>>>>>>b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>>>>>>>>index 90e50c245c0c..721526f023dd 100644
>>>>>>>>--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
>>>>>>>>+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>>>>>>>>@@ -3389,6 +3389,8 @@ adreno_smmu: iommu@3da0000 {
>>>>>>>>                power-domains = <&gpucc GPU_CC_CX_GDSC>;
>>>>>>>>                dma-coherent;
>>>>>>>>+            interconnects = <&gem_noc MASTER_GPU_TCU 
>>>>>>>>QCOM_ICC_TAG_ALWAYS
>>>>>>>>+                     &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
>>>>>>>
>>>>>>>Why is it ALWAYS? Would it be better to declare it as 
>>>>>>>ACTIVE_ONLY and
>>>>>>
>>>>>>Added QCOM_ICC_TAG_ALWAYS, to hold the vote in SLEEP bucket as well
>>>>>>preventing gem_noc going to sleep when icc_set_bw is being called.
>>>>>
>>>>>_why_?
>>>>>
>>>>
>>>>Now when i think of where we implemented the hooks, ALWAYS is 
>>>>not needed. We
>>>>should keep it ACTIVE_ONLY since we are already voting it
>>>>back in resume pah. I'll fix it in next revision.
>>>>
>>>
>>>The path is between the SMMU and DDR, so clearly it has to do with the
>>>TCU's ability to fetch things from DDR.
>>>
>>
>>Yes as you rightly mentioned, this series is helping to resolve the 
>>race in TCU DDR clink
>>
>>>ACTIVE_ONLY states that the vote should only be applied when the
>>>application subsystem (CPUSS) is not in low-power mode (CPU is active).
>>>
>>>So, are you saying that in all cases that cpuidle might select such
>>>low-power state the GPU TCU is "stopped", and does not need to perform
>>>any memory transactions?
>>>
>>
>>I rechecked the architectural block diagram, GPU TCU is
>>independent of the CPUSS, unlike system TCU.
>>
>>This means CPUSS can be powered down while the GPU TCU remains voted 
>>up. While this series was intended to avoid a DDR voting race 
>>between the
>>GPU TCU and its clients, using ACTIVE_ONLY could have possibly
>>introduced a race between CPUSS and the GPU TCU itself.
>>
>>Thanks for catching this in my reply Bjorn.
>>
>>ACTIVE_ONLY would have been suitable for system TCU (apps_smmu)
>>for which the interconnect field is anyways not needed, but
>>unsuitable for GPU TCU.
>>
>>>
>>>To me these two are orthogonal and TAG_ALWAYS is logically correct, but
>>>perhaps there's some practical dependency that I'm missing?
>>>
>>
>>We can ignore my acknowledgment [1] on previous response, Dmitry.
>>ALWAYS TAG is correct here instead of ACTIVE_ONLY in the 
>>interconnect field for adreno SMMU.
>
>
>This series seems to help with a really annoying bug on Kodiak phones 
>like sm7325-motorola-dubai where often boot would hang when 
>initializing the display panel (so it took a few reboots to 
>successfully boot the device).
>
>And indeed it only helps with the ALWAYS tag..
>
>I've had this patch applied for a while (without even realizing that 
>it fixed that!! thought the issue was gone because of something else) 
>and today I went around kodiak.dtsi trying to remove 
>unnecessary ALWAYS votes… first boot after changing this tag 
>to ACTIVE_ONLY and boom, hang.
>
>
>Tested-by: Val Packett <val@packett.cool> # sm7325-motorola-dubai
>
>(for patch 2 i.e. the driver code as well)
>

Thanks Val for reporting your issue scenarios and providing a
Tested-by tag — this issue has been tough to reproduce consistently in our test setups.

As I understand your scenario, without the patch:

   arm_smmu_runtime_resume() enables clocks and immediately calls
   arm_smmu_device_reset() to write SMMU registers. At that point there
   is no GEM_NOC voter — the GMU may not be active yet and therefore holds
   no vote on GEM_NOC either — leading to the observed hang.

With the patch, the sequence in arm_smmu_runtime_resume() becomes:

    1. impl->runtime_resume()   -> icc_set_bw(icc_path, 0, 1)
                                   (SMMU holds its own GEM_NOC vote)
    2. clk_bulk_enable()        -> clocks on
    3. arm_smmu_device_reset()  -> register writes, GEM_NOC is live

And the reverse in arm_smmu_runtime_suspend():

    1. clk_bulk_disable()       -> clocks off
    2. impl->runtime_suspend()  -> icc_set_bw(icc_path, 0, 0)
                                   (vote released after clocks are off)
								  
I'll address all v3 comments and send out v4 shortly with your
Tested-by tag. Patch 2 will have minor structural changes (no functional
difference), so your tag can be carried as-is.

Thanks & regards,
Bibek

>
>Thanks,
>~val
>
