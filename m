Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF4E3B42F6
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784282363; cv=none; b=jj1ZsXgnYFCrHEGxsUpu5+YJ0IkI9YLPVmBltAWgqMihckakH0K73NWcT7XGrBZ0Rbw3VKFeJaORJi4ZnsbPheMxO+zPLiXCzNxf7yfaxzmXh7eTfUspN3LEcJHy4hWqp36e2rJ2H5lKzm67gEXFJaHDMYEafdb+ClvXdV+PoYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784282363; c=relaxed/simple;
	bh=jL3mrOok8MADLcpmY7jdHUknhxvySR86Mx3M++52+aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIfBTbSC3JlQJbNlVEQOot+PoJB2cPM+gzN3AUG6Ngqgbezqw2/tTNJeIkeix4L1foTn1OfRqmEnPoKAVq19/u45JUf0OZAuWgD10PCpNI1vM961cjeksbfsuL4IetA+IAk+k2ZNZbd7dUEe4G7sei9T625a1B4vxlFux/7Uu6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qov3sl3X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jzy5RM7u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qov3sl3X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jzy5RM7u"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6cTsn851707
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 09:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4m4mhHCdwe+iD4gbi28L8euNiv4IB7P2LYKO26utpc4=; b=Qov3sl3XOGvuaaS9
	FzJ64v8p+4oY/aWx3GR75C+9X6OpIO2Ur6Y/TrlskZq7xyE4qWVcdLzgAK1OkjcW
	/O1PfaH+hCukscfvU0Usf//CEk+9veVwA/G6+tNr3UL5NsUHHrdRVPTjn/Y0TlEb
	LEVvhlslkKG67+QUs0vgfT3Af3AdvBk+sINzKnG390ybx+UpMIayENdJnYE4m9q+
	c7Cr5MyXPrw54nkerytxqHoMPPoGxBTdNvngbm3R4fwW13K8hB0gqkBkCFZ1fwq/
	eESdJxByGALHzIP2JC5Y3tAe5udjJlu/OgjRhjaDv5y/gVkCUi4NqZU3eFfD3YZG
	4XXPdw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9p8rx4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 09:59:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e9c0c4492so152839385a.2
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 02:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784282359; x=1784887159; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4m4mhHCdwe+iD4gbi28L8euNiv4IB7P2LYKO26utpc4=;
        b=Jzy5RM7u1TVQ1smKSaI2Bxc7gwxM15cdJGHwgC410MT3iD4CRsAc5rkZchuE7EExWE
         b9AXQCiXJSaNkpYQ0PZ8MChCFUSFjd2VlHVlZttAx/zS2t5iXRqTOBImTX/1zXNoTyiU
         9q/8ntLzW7hq7SyJGzFKBLgRtweiDqFeOEarK0tZGE/DCiv2zz5gyLBpHJHtZCor+UXD
         EvmVBRXdYoek/YIfs7Kijlp2RmcPmtHSVjCLf4GdX1E57shXuloACx80tMUtm7BTro7y
         LZ3S/rGoAnuZTrBy3CxenPEbD8jc0s2/+9+jtNwW1oQ3kvzl703hMiFLh6DeTl7i74sn
         K7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784282359; x=1784887159;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4m4mhHCdwe+iD4gbi28L8euNiv4IB7P2LYKO26utpc4=;
        b=SkV/oqeZBAmldg7fPtEVnll3+a/rn6rqI5r6vxpM/RDIE8fkkVSkMxcM2xkQPg0DeT
         zR8UHW82lozUGtKR0vgAx/pvlMN49Uc9/tUcXHWoAH0dYLnL9QkGQbpXT5FjajnsNsy2
         lapLC3XfVhwy7QrqmoyUCaaTwE1CQ4HNvFHS9TDjWdzI/LPiAOQqlb5IpsrNqoygrtC1
         2JCIiQ+/xt3dlobHQ5bJDkQ28hQJgSzb4lGwuzrI2DGtlcykXPLh4SyOGZQJrks4CFpk
         tyxayQUFoUzIWkhTgJyMm/oS+YHyQ0JjTkm7rjS+bB+p9GNsDCf+uMHEktNtWL6kHFfr
         stEg==
X-Forwarded-Encrypted: i=1; AHgh+RrPL36nsSZChJS7gTPmTQPUpa5sE325Q89hW88cHFqsbgw2IOyCrdSZ4psmlo25ZHEM3Wv2mQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx55UL+QYEcYowgJqDAwS7Rw9OID2dpQg853bYAX5ebmuE015wu
	8TJcz0cRqL9gpTq+Y20njyN/hHkc7vcUCIH7LqFVBRMoGG+YugO0yhoRTLAoDbRXpPA3rXaisYL
	sdWxvz84sDV6XE8e+LBbiCjUuKCbKj1s6NGF1ABgpPoYkFOuc8Gf+GnrhqQ==
X-Gm-Gg: AfdE7cmWVQ2AXgiHAK/rWLmLhlttIYdeqNid91dVL5iPBsykDT1ncHApu6JUy0KUi7s
	yEp+g/Hxfj8rIInum6iJR3ujp6iLU5YyXUlpdxlA2B7pwuSW0UtedmfLXEfVd7KCZoWL8m1il3B
	K5ngTBdM3tak+F8wNEz02YrP3hckMIiVxNPPyovxs/O+NBbeHfJiZcKX9AjyXPLZKhtHZJHcHEV
	+QdQ+0rdkXbRBpxmQYm/w1Tl4Z3+pjVYRpELXfdDXCbaXUoyBa2iDmGUfaJ9FGMWa8aZ2dGgewg
	bGNDJ2wAnF4TntuqCh+ZoU4CSLN4iKeuA8fDq0amgjCzdPBv1jv5+DzbGbrlYUqNwfz+fs01zmz
	rwgRWC2WIqe7FZxi1G/vvas2E
X-Received: by 2002:a05:620a:4396:b0:92a:228:1bfc with SMTP id af79cd13be357-930b3e2e4famr170491285a.2.1784282359422;
        Fri, 17 Jul 2026 02:59:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4396:b0:92a:228:1bfc with SMTP id af79cd13be357-930b3e2e4famr170487485a.2.1784282359012;
        Fri, 17 Jul 2026 02:59:19 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1740bf5df5sm50044466b.61.2026.07.17.02.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 02:59:18 -0700 (PDT)
Message-ID: <f7de5852-c255-4a17-b87d-c9a4542255f7@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 11:59:14 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] arm64: dts: qcom: eliza: Add GPU SMMU node
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-6-c9f1354dbd29@oss.qualcomm.com>
 <10b0ad51-8766-449c-a51c-979364e6c781@oss.qualcomm.com>
 <5fcc0bc1-7f9e-4611-be77-42860e0f4c74@oss.qualcomm.com>
 <e8255fe2-a67c-490e-a905-ed056c6af950@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e8255fe2-a67c-490e-a905-ed056c6af950@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JtI346X1FDNTcd3aY5cgN7YSOi8U3ctc
X-Proofpoint-ORIG-GUID: JtI346X1FDNTcd3aY5cgN7YSOi8U3ctc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA5OSBTYWx0ZWRfXzrNLr//oTCaN
 Lj5UcC3lDDDrUQUplWBQ7izI1TrsvpjIqSJmf+ER/tg0gJ+KLNSrMmyM7NkEdawxf9tOAorEeuQ
 GQjKnvufhuqv58oLmcKl1yE0Fuq+lt0AvPqDZqoXqF0rGPlPobwOLDyR7A98kHTtYyxEhZGZcsf
 iYpeufhihdZrNKTwXvuJG3BT7CkS8c25YGb0SVqV34h8gqJCyjlJXfiOgJJ8XaEGk5d2IdWCwWS
 9lB4WMYLc6BE5XkYZ6jQNxZ5TUIK/CmVLyZhmk6UEkzXi3Kd/MBZIO4Uc376G8vSmX5LFGZbWNB
 dzp59SUKS6W/UbVxR4i8mShGeYiRdPBg2qrQFrb8/bVzZ9me42WHxrcY3Dco6miSacl2vdEg2Qf
 pEBDwLDho2kpnvusXePgwVpwfz67A8EVc9/m8Sjhg15xwIoa6kDAuFYQg/x2KeJLxBEeHE7ab2m
 LwX2+peYfp43sOM2sFg==
X-Authority-Analysis: v=2.4 cv=TaqmcxQh c=1 sm=1 tr=0 ts=6a59fcf8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=hbrWYzUuUx-UyiL5C5EA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA5OSBTYWx0ZWRfX2h1My8/wPmg4
 P6YUMK/mpCU7Usyrh4oDZASZbs8WxUuXx/wSJ1DM65Bt1Qr6c7zgU0g4345rdNWAuz9ofZIPAh9
 L+rVZp81cu6EafJJoTYLAxih/jnMw+g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170099

On 7/13/26 9:47 PM, Akhil P Oommen wrote:
> On 7/6/2026 4:38 PM, Konrad Dybcio wrote:
>> On 7/6/26 1:07 PM, Konrad Dybcio wrote:
>>> On 7/5/26 10:14 AM, Akhil P Oommen wrote:
>>>> From: Abel Vesa <abel.vesa@oss.qualcomm.com>
>>>>
>>>> Add the nodes to describe the GPU SMMU.
>>>>
>>>> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/eliza.dtsi | 38 +++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 38 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
>>>> index c5635f22e2a7..e5b8377e6c3a 100644
>>>> --- a/arch/arm64/boot/dts/qcom/eliza.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
>>>> @@ -2674,6 +2674,44 @@ mdss_dp0_out: endpoint {
>>>>  			};
>>>>  		};
>>>>  
>>>> +		adreno_smmu: iommu@3da0000 {
>>>> +			compatible = "qcom,eliza-smmu-500", "qcom,adreno-smmu",
>>>> +				     "qcom,smmu-500", "arm,mmu-500";
>>>> +			reg = <0x0 0x03da0000 0x0 0x40000>;
>>>> +			#iommu-cells = <2>;
>>>> +			#global-interrupts = <1>;
>>>> +			interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
>>>
>>> 674 is the correct globla
>>
>> (modulo the issue i explained below)
>>
>> [...]
>>
>>> This list is not quite correct. It must be sorted by the context index,
>>> to which a given interrupt corresponds to - the driver relies on that
>>> to give you information about where a context fault happens
>>>
>>> Moreover, I see that the interrupt sheet has the bug where some
>>> interrupts are offset by 32 from the base vector, and others are offset
>>> by 31 (i.e. the SPI number doesn't equal irq vector - 32) - please find
>>> out which mapping is correct with the right folks
> 
> I reviewed this and looks correct to me. Also, this matches the
> downstream configuration. Did you confuse with Dest Port vs Vector ID in
> the documentation?

What I'm trying to say is that the documentation is confusing, we've had
that issue in the past on other platforms. If you see that the correct
irqs are firing, it's fine

Konrad
