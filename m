Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F5148595B
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 21:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788989572; cv=none; b=FVZMxE0XaFCYSym/A7eTZ2ckXKdpcnPn8M8wCsRIpy2AAwn0kBEpE27u3Kla4N6TwOTd48puAXqN2Z7AeC2TgcqPye/fgm1OFJ3K3Z5/7S6A6jOU+WbNdCW7gpQShAB8/2vlBgd4y9rVLBHmbD7EzvIWSllKIMLONMQ2gdm0lnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788989572; c=relaxed/simple;
	bh=P9Q/Sk2LRR5jiHqUFrMFj46jAeGuhH3O/yPbygJswb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5lALsss3SlDZHKa7jllpZQPT846ACdicba2nA6vmgKAaMIGYSYqNNLcv1n84eN2Eot2ifyLp/bsVALE7KiLhHKUz6cmm73GLSs7Y/sPlFU1IxwZUrKfDSPTSU9JO1DZ34etLIbhJImkiM25VF0JSRM1y/MBtMJ5IIDU0ccKzDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mtzgKzxU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HCyhYP/9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mtzgKzxU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HCyhYP/9"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689JI65R3710918
	for <iommu@lists.linux.dev>; Wed, 9 Sep 2026 21:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=u30C1GcZOHikC8CRum1iTKpX
	ibaQx/p5h+oGQUzFnVk=; b=mtzgKzxUbr58vw0U/M8FqZn1YrWMIGm4nRC+D+FN
	mPo1CDV+N3zEUP2NEw6cpOynIvqpghXChijVC+7KsmszZtM/6l16hWJqKGFOg+kH
	udYs9D9C/SqnZfYWirU0Cd/vj92qeYt9vYNH2TDajdU7C4Zhb/L5wNapQ/q0toPY
	mlNbr7YBF67ZKhEGdSXyEVHF8h10sB26a2qDu8ZYVON1Y2iQ+pZcUBNsFRGgyL2S
	mZ6pUt6Twhw9fAxWoJPM+w7lZIvn3JyQZNKQCYhW/85DkCup1DlMqLZ37QPpwRoT
	4ho3gCtzEi1wkLQ8ZcLsRQkvgtttGkkZgPjDg5lvw3ZK5w==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcydgp8g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 21:32:36 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-78fb21aaad9so280848137.0
        for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 14:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788989555; x=1789594355; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u30C1GcZOHikC8CRum1iTKpXibaQx/p5h+oGQUzFnVk=;
        b=HCyhYP/9Ev0EmBXfA+Z9um14e9hd2GPb+7EQncoWy8ZVGLzJGOmH/mPsLVcSw774Ai
         7PrrWxPFCTmrVPmSP1LacPHlcgjFactQa7PPKmYYIt+bUUkjBU/5jaf377FaeQsXHDeA
         ljlW02zWH6D1mvIvViyq+q5aOy+Y9mmjk8Kg7xXOfk/yCNp0aqSCkHIpZkx8iAWyd9ZI
         P2O7yQphhYDSJQgHyz3MOxCCyVKiTDj/sTAS17OGRVQn8uKn3v45Zeu/CGvP2lpKZ5ld
         fu8xA6hSDzSVwKYhYR/BQG3xu7VZxO7rvyWjJznLik/MFAgn7hegmylL9nPIY5agbC//
         t3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788989555; x=1789594355;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u30C1GcZOHikC8CRum1iTKpXibaQx/p5h+oGQUzFnVk=;
        b=P+gc+8x+KKK43MlKrMh+lgHtPPO9cU6UC1jW7yQQzzLm/+puWZVp4pTdvGOM6+78pI
         KiJNkcbRp5nZ/GhR95CkN2rJLEW9UXdQlKr1eRprdYBqCRvbXdqEvl8+CF4oj7SCFxwr
         gYQTjF/YEzl2MJEP0tnyWUgbmaq5S2LoOjLGiPNUXjghsdjtdOkp7THL4tL3Vu7o6xqo
         CuweZe2BhrydpylDotDGWpFil6bEyY62KBv3mfQVHVQi8Bb9ftKF+yVCovUn0130Utu7
         XQVGKXjtIercUFEQ1FnCyvJPSZLtu0EaXiVQsjQmk5oh4zb3TbJcu0NQRyfdYlr3Z7yn
         aG3g==
X-Forwarded-Encrypted: i=1; AKwUvBx0cyYaix+XGqppW2ytl3tIObgx/sioCmuIPl4syj92txgSqQdfeu93Ubq6KIU84iwgK3GcYg==@lists.linux.dev
X-Gm-Message-State: AFuF++mIx7drBA2ZmQyPoqGn34X0t9CR+S3ZENeCrmovgXQj2GVlemLZ
	cIxgsSiIrGK2T3EgHaCPRlW76KnlfrYIANhzt9RSf5tjg6JgbosgRHsLCOZ0aPySwiMdvaLjNWo
	/5NftB8+DA6VGw5sbenjh3Ru1EfdOMKE3A3Ve/Pf3s7cF5wa4RIpaik29ncjvITrIxg==
X-Gm-Gg: AYBFou1dLNt327PevcPR1wqX9vPfJ+TKd3ZPwOenKk2VOUYdm+3xOLq/OZCDuANyAIo
	Kb4JVYHOWxCAIcmZIolOJkSxDg37gDpM7Cnc0EFpuz2jy0Kh+6Rc+9SeIYoZp8dKd6lS2un/FcB
	1/mZrmKv9TNsCeni1lHCHjWl5ErMapW5/r2I3+NwQwyCZ7nj/y0iBQNE8vKW3xBPmkihv4qTQ8/
	Pz2qXVFDpVCigI4fM4bJkkjDoEPKJvvXgrDv1dhpIZJRbBPwMvtM3Yd0sqPmasK679Oxp+ePztv
	Myzgp1Y8ZYF0sR4AFIuxSqIjXdZKPIpZq7K7ROGAuaUqwQ1lQVtzoUsO/OiVygh4ZdYWRV0usnw
	V+4ybvyIEvFjVMy4h91V6FP4utxCMyJ7N2Nq95uq+Vlr9LnEbW7xIStb0pQHMy3K0ze4cipbXiQ
	+daTVIqk9KsQth
X-Received: by 2002:a05:6102:838a:10b0:736:f95c:4bd4 with SMTP id ada2fe7eead31-790d8a0f189mr416288137.6.1788989554953;
        Wed, 09 Sep 2026 14:32:34 -0700 (PDT)
X-Received: by 2002:a05:6102:838a:10b0:736:f95c:4bd4 with SMTP id ada2fe7eead31-790d8a0f189mr416280137.6.1788989554514;
        Wed, 09 Sep 2026 14:32:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b75a0ef296sm2122050e87.38.2026.09.09.14.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 14:32:33 -0700 (PDT)
Date: Thu, 10 Sep 2026 00:32:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v3 03/13] dt-bindings: media: qcom,sm8750-iris: Add
 context bank subnodes
Message-ID: <p2rjkda4jecjd7lfaskz3s4e53a2p4zgqvnlm77kb3haqglrbk@qq47tbxlnuck>
References: <20260909-vpu_iommu_iova_handling-v3-0-2fe43ae45495@oss.qualcomm.com>
 <20260909-vpu_iommu_iova_handling-v3-3-2fe43ae45495@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-vpu_iommu_iova_handling-v3-3-2fe43ae45495@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDI0MiBTYWx0ZWRfXwPobUzIoeTwx
 TNl5+Sn363g/B/Ejg1XdPfewPelh7VrPmBhJXpndxBq9rrJLAqk7IC3ToW27TTn7KGKeS7tJgk6
 eK9fsyLPnv/iyhSXbnn6egCR3OfvRGM=
X-Authority-Analysis: v=2.4 cv=UJNIjyfy c=1 sm=1 tr=0 ts=6aa1d074 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=G2U8quZLHxfXJRKprjwA:9
 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: ZiIOsD-bmEqhP5iIs3hAsAXKa6PfvEte
X-Proofpoint-ORIG-GUID: ZiIOsD-bmEqhP5iIs3hAsAXKa6PfvEte
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDI0MiBTYWx0ZWRfXzX1BGFlNk0ak
 IkQ09biv10Q1HUQ00wM9cEGXxW/z0MqJcJHHE3rrNiXZG3vn3ctmSt8doGTkLVGrh20R09Dp+xn
 GeiIS0yU8N/twYAJeUpsr+423EHswlRq1hnvdsHDnhPOmvf2XLi6c3IOpImiTHTN72VjdM4VNaC
 KCjnvJR3j0qGmkLoSB0v7ZrtN9qCzQwLyomBHtFhUPbe0hfP5WtHTZZbY2LREHbaIkWpXy4g1Fj
 Fm7AeAXvl/7Yv15laDbpFKKpT2o9fju5lpHvmkyM4jNE81wSt/dJAgDKRi2EZsY8wzxT9NZi22G
 8cCYCjYlNRrRi6iOE9vWZxf4inqPyjundNfaqZ6ss1wMKj7RdbMBdaePTBqo3WNryLHUh2/vX7K
 vNTqtZmfBiZjt8+qroo/v79qQ7nbVaBSsr6ohyJMW565CKOrLPA0LR6SB2fq+SLmkTAeWqOQwQ+
 dDIbJXb0QhyUgv6bUFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-09_01,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609090242

On Wed, Sep 09, 2026 at 08:27:10PM +0530, Vikash Garodia wrote:
> The VPU issues DMA through several SMMU streams, and the hardware does
> not give every stream the same addressable range. The non-pixel stream
> cannot address the low 600MB of IOVA space, while the pixel stream can
> address the full range:
>     +-----------------------------------------------------------+
>     | non-pixel stream addressable range (600 MB - 3.5 GB)      |
>     | 0x25800000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+
>     | pixel stream addressable range (0 - 3.5 GB)               |
>     | 0x00000000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+
> A single "iommus" property on the video-codec node puts every stream in
> one IOMMU domain sharing one IOVA allocator, so nothing restricts a
> non-pixel buffer to avoid 0 to 600MB. Once an allocation lands below
> that boundary the hardware faults, which shows up as unhandled SMMU page
> faults and spontaneous reboots:
> https://gitlab.freedesktop.org/drm/msm/-/work_items/100
> 
> Given that the address range restriction is for specific VPU stream, it
> should be ideally be moved to that stream. To achieve the same, a subset
> of streams is now represented as subnodes, so that each can be
> associated with its respective addressable range. The design was discussed
> and agreed by mainatiners here
> https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org
> 
> In the past, this limitation was addressed with an iommu-map approach,
> with the iris driver dynamically creating the devices. That approach
> was later concluded to be a hack to avoid having subnodes, and was NAKed
> by the iommu maintainers. It was discussed in detail here:
> https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org/
> 
> Update example to the subnode form. Doing so, it picks up the supporting
> properties needed on the video-codec node, address-cells, size-cells and
> dma-ranges to declare 1:1 DMA translation into the parent. Given a soc
> with address-cells and size-cells as 2, update the video-codec "reg"
> accordingly.
> 
> This patch depends-on:
> https://github.com/devicetree-org/dt-schema/pull/207
> 
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  .../bindings/media/qcom,sm8750-iris.yaml           | 187 +++++++++++----------
>  1 file changed, 101 insertions(+), 86 deletions(-)
> 
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;

Again, drop the soc node and adapt the _example_ to use 32-bit
addresses.

> +
> +        video-codec@aa00000 {
> +            compatible = "qcom,sm8750-iris";
> +            reg = <0x0 0x0aa00000 0x0 0xf0000>;
> +

-- 
With best wishes
Dmitry
