Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4053A4AA585
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148652; cv=none; b=jthTnJ2k74ZSkJe94guqXd1P3sBND25FcuaQVkaor/ext/7GdGnGFZ+lbv8HQZmnnVfrBvGBtZolVv3D4xLNEA3f8mbhKeAS0VVGLtbewQpUb2fdQcoWCOJHa6CLpwQYY7d+LLjd2L2Qd51fzt++8SMELGrWE78Qa1ptfH2Z0Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148652; c=relaxed/simple;
	bh=iSPOqrPEqNzouRgsfdtXLZvJztzijYXXcFDpMwJ0MLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qjdjr83iw0iXEMCDRBs186UItwREFVQ9znq4PXhHO83OzEPF+tyb0Ptdf/JLgAUH/Nlgx5+BjQbxjBwNIpKP6ZMZHCliy+fZid336Faut8ekLgSD3inFoaN8gdUFTrHoLmW4mG+e8O+fDmCJYqqkA4Xs81m/Fu2khxJoCWc6PNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n4IDtP6q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KaQgauph; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n4IDtP6q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KaQgauph"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BHWVEM972042
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 17:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DgHv3EdPhIoOXyHYgFVg1PHeH4W7/S2tlAAVOYQ4qy8=; b=n4IDtP6qSCRsrs5Q
	Ci4u+5w6+EkIJ71oFw1Y1zQstpX89A/BA76Y5fXofq8whvtRYA60+EDh++ODP6je
	093MTlj0PZIJ9QWlFP+CTD4uZZMyeiGMunBt7EcTEScrl+C01OLfh7GHre4s12y1
	p1emmt65w4qtjfhKGdQ0ybxnk3ASvHxEWv4UMubu4tDmyIPnDgj9gYU53c/dwkf2
	FvTwmMILkTRQLxInIObPo6sbKMLwJc3pzEHDkZlbI1ur/FbH7M7BQO++fEB6M6AC
	1K4lQ4UInF8h8uKQJHH7mm5sHbSuXVZkUgL19Gd7LkJbRFxbUT0AZfrhu4yu0VMT
	UWsiCQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmm22rkra-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 17:44:04 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39906175917so1507207a91.2
        for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 10:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789148644; x=1789753444; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DgHv3EdPhIoOXyHYgFVg1PHeH4W7/S2tlAAVOYQ4qy8=;
        b=KaQgauph13MmQU+zcYdOfyodD87fxeImFWFljMzDwCLrVsNaoUrGW/iaC9nP3nHalW
         L6XcUNvne5L/7imGLd3N0+riP60URCp0Q1c0TnQW39T1QK/v7mLSXzuAmc1OQJOQ44XH
         myYvd2o56waT5YZ7hG19OR7CYMuUA2oKStQdkxFh/ylBRLg+5lEJnJV9KEtgsyvd3l7J
         muUeHtBN+bMLU56Q1z+R0jnH/VZcTXRQIsSsxrpqPeZDGVxm6J0p96qz/l2yE/ZSOELj
         hNTJacT7vEp/K2XjR0d01R/fIpGinq+zqQ6OIImgNoRAprOzi3Rg48H14UAhRk92MDi/
         70NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789148644; x=1789753444;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DgHv3EdPhIoOXyHYgFVg1PHeH4W7/S2tlAAVOYQ4qy8=;
        b=P3/KgNj7cHN2GvIkCQ2a7xxmgoAp5WCJ2ocyvjJsFjUARCRPVmKTkU9YOveMXSw7e1
         1lMG09bjgg9F5onEZ28KbAVouXkIW1Lu6nigxQm4a7j5fPPAprvI/c9julNvzZczxX0w
         SzStjMu+rHmPXRYGqlXNr4Pq/X3e+DK9+Fkk3wIAEACZwtDg15HZcTBZn2fsUIMbgexG
         Sk3nxtB3Uwl14uiyeZbTkhcsa7z9FkgCfK1d7WmV/AoKGEVxIHfPbschl7Dff0xv73jm
         H9fKMFQA20whF4BWQ2oBvaSLzCZPADpXJjp9stUpgrFNVaIeiCRqhCpbKzKeQOIpQoPg
         QkTg==
X-Forwarded-Encrypted: i=1; AKwUvBxM7sbSvMT86DD4OFxYc9qR/4qayUSy5xSznWWmBenolV4Rj6/Lq+esvxH8eCseRa8VAJ9azQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kzTCF7PFaud20nIgKtxH5F1fqSPIZ9cIO/cCodH5Qotg933cq0
	UkSUBL7VglebbJlSTfGkVvrrNzxuQFDFGTu1h6cTr7GIQ8HjxZY3+T5rZkRztgwcQ/pK0O2eIMM
	F75D7FaH8B860xvgeLQxG0BQ0h55qZhBeRKpodMQgspV7nPPAQGUvZG/l/RVjRpeg9w==
X-Gm-Gg: AYBFou2Uep7XBhM/XdAUcOaqEbXMP0Zi3o1RedRWvECFclLhsHZDFG+AGUWJ4JARNNE
	BtyYl6IufJRiDaOaiAq3vNUix+GRsueXmVTHl5buMN+GLjjYHyypciu9C69cpnBcAfC7+A+NNB2
	MqP8+f+Ve4NCekLfZqlZuYCuWttCdvJ3RYwq0g0tuiSY8w8zMtXPB3uSnLDaTuYVKwWUYRpgPeR
	sF7ZAEfEOYli/h1UREu7XDouF4ZhO4qW1uXJIes2mQ5UbkO6IH54LbuA67sR9NfpBcQo53t9PGN
	HMfNUIrvWNnxlVPiJWwoZuZJGlloYBwa1097r3Mditn2VvSk2u1eCy1G7i3yW7yYyonwatadSzh
	+w//pCpqwQZ1w6TTtljJC0Ul1QZFPvrsnqxg=
X-Received: by 2002:a17:90b:2689:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-39d9bbc81damr9099637a91.1.1789148643606;
        Fri, 11 Sep 2026 10:44:03 -0700 (PDT)
X-Received: by 2002:a17:90b:2689:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-39d9bbc81damr9099566a91.1.1789148643138;
        Fri, 11 Sep 2026 10:44:03 -0700 (PDT)
Received: from [192.168.0.172] ([183.83.137.104])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b78d59sm7652016c88.8.2026.09.11.10.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 10:44:02 -0700 (PDT)
Message-ID: <ccd42f9e-935a-438e-b5c8-2643cd5cedf9@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 23:13:53 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/13] dt-bindings: media: qcom,venus: Add context bank
 subnodes to common schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio
 <konrad.dybcio@oss.qualcomm.com>, iommu@lists.linux.dev,
        Daniel J Blueman <daniel@quora.org>
References: <20260909-vpu_iommu_iova_handling-v3-0-2fe43ae45495@oss.qualcomm.com>
 <20260909-vpu_iommu_iova_handling-v3-1-2fe43ae45495@oss.qualcomm.com>
 <20260910-careful-finch-of-fame-eeeac7@quoll>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260910-careful-finch-of-fame-eeeac7@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDI0OCBTYWx0ZWRfX44jBVWGhj4oJ
 EOCAbr+nXIRBktGFtvViMkK1aX+vSkmd/ybduRTYl1HeEBn2AN4oDvVxxzGs6FJ4xXfuAfgdRhx
 zQiUi+rJsHKiCl5YprRKwlbb9SWLlT6FwOcCyriu75JcAiWMTjJNoP3+/aqwLAsu8WmF5+GNfqZ
 UlOigysiMNb435eYd1VEWeOKBB2NBJDiDDbzGxgDMXB4JJpy3PDDzEln544SgYC/odvvYkefWe8
 gFFVQPzW6GU2UwAwSH0JdeiHyxKhbGHaucQRzul5rNLaXZWFHNaH2fEPryoYJVe0P2Lth2/QmGy
 d+/kvfC6uhPDDT2apKG5w6Tl6/cCXRvzPto35wc/47ot+mNLX0WPZrjTo1aSm3/DSG62J+7cesD
 bZvCdOJ1cNJDM94KoL+60BvLO+LXTOCQVEDBIdp/UXNxA+6mUetxqOuPpCeu0h5+YIYiJ6uNSHU
 fGivW65E+vXdKZImxlg==
X-Authority-Analysis: v=2.4 cv=LPDz05W9 c=1 sm=1 tr=0 ts=6aa43de4 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=TwCXObd+TJU0JWB7kQOUgw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=t9ty7G3lAAAA:8
 a=EUspDBNiAAAA:8 a=gweAf5VaqOsLJRT3hzwA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=Vxmtnl_E_bksehYqCbjh:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-ORIG-GUID: iGxXNoxy4gCFpuc-o7HD3wkQjRgKuMlp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDI0OCBTYWx0ZWRfX/Dy6OzzQfUmP
 MVS9XXZckYP3VYhp7Jh6XxZF3ZMlwNJJUdhxAXd8fh6ZkoaVaJt4lk216woha6VRIdruyJ9Q+Ld
 BOgCEVKTaowewBwvx0eUKk+kkJFa9z0=
X-Proofpoint-GUID: iGxXNoxy4gCFpuc-o7HD3wkQjRgKuMlp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110248



On 9/10/2026 12:29 PM, Krzysztof Kozlowski wrote:
> On Wed, Sep 09, 2026 at 08:27:08PM +0530, Vikash Garodia wrote:
>> The VPU issues DMA through several SMMU streams, and the hardware does
>> not give every stream the same addressable range. The non-pixel stream
>> cannot address the low 600MB of IOVA space, while the pixel stream can
>> address the full range:
>>      +-----------------------------------------------------------+
>>      | non-pixel stream addressable range (600 MB - 3.5 GB)      |
>>      | 0x25800000 - 0xe0000000                                   |
>>      +-----------------------------------------------------------+
>>      | pixel stream addressable range (0 - 3.5 GB)               |
>>      | 0x00000000 - 0xe0000000                                   |
>>      +-----------------------------------------------------------+
>> A single "iommus" property on the video-codec node puts every stream in
>> one IOMMU domain sharing one IOVA allocator, so nothing restricts a
>> non-pixel buffer to avoid 0 to 600MB. Once an allocation lands below
>> that boundary the hardware faults, which shows up as unhandled SMMU page
>> faults and spontaneous reboots:
>> https://gitlab.freedesktop.org/drm/msm/-/work_items/100
>>
>> Given that the address range restriction is for specific VPU stream, it
>> should be ideally be moved to that stream. To achieve the same, a subset
>> of streams is now represented as subnodes, so that each can be
>> associated with its respective addressable range. The design was
>> discussed and agreed by mainatiners here
>> https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org
>>
>> In the past, this limitation was addressed with an iommu-map approach,
>> with the iris driver dynamically creating the devices. That approach was
>> later concluded to be a hack to avoid having subnodes, and was NAKed by
>> the iommu maintainers. It was discussed in detail here:
>> https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org/
>>
>> "iommu-ranges" on the subnode describes the *allowed* IOVA range that
>> stream is allowed to use, so the IOVA is allocated from the specified
>> range only. Define all the possible subnodes so as to describe all the
>> VPU hardware iommu interfaces, both secure as well as non secure.
>>
>> address-cells, size-cells and dma-ranges declares the 1:1 DMA
>> translation into the parent.
>>
>> The parent "iommus" is kept as an alternative via "oneOf", so platforms
>> that have not been converted to subnodes still validate. New platforms
>> should use the subnode form.
>>
>> This patch depends-on:
>> https://github.com/devicetree-org/dt-schema/pull/207
> 
> Please drop, not suitable for commit, keep it in the changelog
> 

Sure, will add this to changelog.

>>
>>   Tested-by: Daniel J Blueman <daniel@quora.org>
> 
> Plese drop, not true here
> 

ok, got picked in b4 trailers, will drop.

> 
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
>>   .../bindings/media/qcom,sc7180-venus.yaml          | 15 ----
>>   .../bindings/media/qcom,venus-common.yaml          | 97 ++++++++++++++++++++++
>>   2 files changed, 97 insertions(+), 15 deletions(-)
>>
> 
> I see this causes DT checks failures but I don't see the report, so
> probably it was because of schema dependency.
> 
> Best regards,
> Krzysztof

