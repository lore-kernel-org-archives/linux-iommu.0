Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248B8435A83
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783442648; cv=none; b=pQXEk3EKzQdnZz+DSRs5OIkbONp1GPnDQoy38RiIL1xIc/8U4arwJ6cBmZl7j5ZRBmFiWU5jdnJWwh8+Ta2vs3ITrGGumfUe69uOIu19sZFq9DrakhZNbKopKY+iRAKai10F8cGrItcYOb9TJ00rN4nCIU8C1MVZcURpHWOiqGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783442648; c=relaxed/simple;
	bh=EWR8a47plqgBBVMdf1PmjfxiUoXmk7R5ZJ2ApF+iNyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAVLyHxZXttb0y5oLX/4LnJFiSGhEQ7iZ+PuUlqS+2w+nYJ3eqehBJIBj1EXU4EajLQSmtH+rpuY280L4l8kLVNwcLUqlQYNNVkzhcFceOWg54PNteR8+ECbEqYDyMGN5YitE/CgVanY8efMaa9DKhORkdEH3v8ZdCQ7Y5LxfBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dNHpq9Wb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P4oty20x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dNHpq9Wb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P4oty20x"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667FTAuZ4194016
	for <iommu@lists.linux.dev>; Tue, 7 Jul 2026 16:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=msao9II978EcbWLPZnJCBt9s
	YRcY8oZ8a4mvsNrHSi4=; b=dNHpq9WbgYw1Yh7gHPw96BHub3pYOw90FAbN9wm0
	3LCNHMJwMcJ2fRRj7gjnHZzTMUmAqr3Ps4CiSZ+Akp49ZkxWWvR5RdRVwHr0W/ZN
	Tf5nyFuGg9QGqjcOiB0hpzdd2N7ao60Fs9LTyxu4WbO2xHPpBhp/qmyNk6qC7qIR
	Jvpewwb+cF/Ln0+Ec3NBwkb8EFuG2d24UjrjqmhbWMpLuJZM9Og8yNJxW146sRr9
	QLWEPOZXsfm/VEssXLxUr6lXo0DkVBg9et/mQv+txWMU0j6AASXTpmukXTZhn6eP
	GYUJ4bg9xfhjv6LLo8R7gcsGIMCaaSNSSTJ0LTnWXnhB9A==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v9aaj8n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 16:44:06 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-739b4a4301dso4142238137.0
        for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 09:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783442645; x=1784047445; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=msao9II978EcbWLPZnJCBt9sYRcY8oZ8a4mvsNrHSi4=;
        b=P4oty20xuq53I5kScmz6tHZU2UwazH3B3osY+vCo4JaIQ2iEiPHUwQQSgpM102jC21
         CoeqRjE57VmJsi/Aco46jTBkedzL9KWMv2uOy8J8g/zXzXr4iyck2b/XFTzvIb6csjr+
         V8DWh4pWGrgheIMPKwToZLJC9gWR+qyTgnns4z2A9HVSN7I7KND+WI45X+4MoHnTe/+3
         99fZpfdscj3PBXLufWLEtCLkFJ5Rh+wSyyfcXomoWW/pjdpSjegEx7W2o0PYP0nulL+9
         /QQGK5Ruzv7/TEYmhQx8mc0xBQr+hBTUEh14CYt9AhdDlb2cFhWMLFccPWs5fByl9Dmt
         JwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783442645; x=1784047445;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=msao9II978EcbWLPZnJCBt9sYRcY8oZ8a4mvsNrHSi4=;
        b=gGjgYGi4s+Uqjc3d1wz4cbj9tK8TB6kewH1+giMGBQ82yUCQAkY2jTceWJi8O3oV1T
         YlgU+1JnnitGIc62e2npghdNrooPKS3O9OhPW3DtlUqeyP4Lf//uMepvnrmiMC/sOFN6
         ftKJ3pIWdv0HpBXKRb1GjcjK990hlTlGue6fBcAlZvHbudYbSJPwvsKNdM1Ry4cmtVJ9
         ToyHUw8V1XHyd0vUwcuEJHjuYaricaxeCdEd/6HKCKTcVu46u6vmxMuidZ+ksh5be/VE
         LsN6r2RuXfJ+uqXEgkFrdJoTLT9V6b95hnBTeTKalyjruAxqKFQziq3vTPdSrjIOMSdt
         ISLg==
X-Forwarded-Encrypted: i=1; AHgh+RqIXhDclpo1Cv6TOZ/YbXDzusQn6PkmCkAQEQxNo2KMhmWliU51uVkPkj0i27CkritEd/evvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkzAdfF9YSfbLZhKHdKN8fPJRWdH/jOdt6zuvR3zGtuVulFlbQ
	AoTRPLgfmgqvPZ8oi3KceNs/plC2Upu6YUxGG/uqx3x9VfYzQy9hD9PyRkC4YK+oI3D7u8vvhTd
	8EVI4TCQQCUBZyDTsJw1edzNeHO7ce6241oCt8lR/jacgTr/1jJUNFo2zuw==
X-Gm-Gg: AfdE7clTxin3piJ9DOulvpD/kcYpwTK/Z2h9mcl395kgGeTt5TBeqqgt8xOoyRI/PSz
	y8nklpdlSgTZGPKxwI0zj/GnuagQtARxG8YtFCTRYaPZHJkHPLWP33v+gnHCjhm5v1goYb6OA0F
	iIvixPq3qGvGDqnJDGyVtXokqosdXw6e5Y/qrd3qh2ZCPPaLDbH6pkCB1wy7+Bqfb3pBnNDS1oR
	HYVTfMkth9Cmuv2I3OBoSEiTN330/55MWLJt3uTBz6RCG7i0P15de/Ss8PV8m+yvsewEr2Hm13h
	IccP22tcZPQynZ492JZyaL2DhRd6Bs2SKdETYXY3eQZERMT2KoUdKH1qQzvU1S1Mtavdh46JnZI
	PhIIaQZZAw/8BZ6Eu1zb5Dp2rcyM6YbbFbhAUWJKZi4dnxP5yyZa4rEoBz1ggqVjA1E6MTjB6Ug
	crM3JJX1bDdWWVQ3tQUlYfqsms
X-Received: by 2002:a05:6102:a54:b0:738:6994:eb8 with SMTP id ada2fe7eead31-744b7826cd0mr3376475137.0.1783442645240;
        Tue, 07 Jul 2026 09:44:05 -0700 (PDT)
X-Received: by 2002:a05:6102:a54:b0:738:6994:eb8 with SMTP id ada2fe7eead31-744b7826cd0mr3376435137.0.1783442644651;
        Tue, 07 Jul 2026 09:44:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13bbbbbsm3826799e87.43.2026.07.07.09.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:44:03 -0700 (PDT)
Date: Tue, 7 Jul 2026 19:44:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 3/6] arm64: dts: qcom: kodiak: Add GEM_NOC
 interconnect for adreno SMMU
Message-ID: <a4f5sod3aflubxkk4mm4k5ozddydqcnqeac4s6vnozkd2nvxbi@hmh6zclsw5z3>
References: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
 <20260706-smmu_interconnect_addition-v3-3-afdca0125a65@oss.qualcomm.com>
 <h6opbtr2ced3sannj3ym573qc2sjk7ek3clpto5j5mtqfrfk6w@34sk2zraoqtj>
 <807f145d-88d3-460a-9862-b63fe2a52cf7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <807f145d-88d3-460a-9862-b63fe2a52cf7@oss.qualcomm.com>
X-Proofpoint-GUID: 6DjkTzzmOY6lfGTZeAj2aUU4L8EbfLQw
X-Proofpoint-ORIG-GUID: 6DjkTzzmOY6lfGTZeAj2aUU4L8EbfLQw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE2NCBTYWx0ZWRfX3ZCh4V6rl5Dg
 JOdTUcBLKlpsYGJBCHImwpORVLQ2Xa46Wc+LSifT8fpK7SJzTc+aXtrU2eEi+UEpqagjH91Znwj
 mz9fZca+d/e/DFO72zUekXUpM/hY/gE=
X-Authority-Analysis: v=2.4 cv=b9yCJNGx c=1 sm=1 tr=0 ts=6a4d2cd6 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=c3lE_UrMKrngV7lMyMoA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE2NCBTYWx0ZWRfX6xAQ54OWCO9V
 FduHwoy0io0h1P11SluuKMvz7ZVPhR4t5ghG0TU1EdvP9yJjfnBpxloxJ9vmO4bkfboFuQGpGyl
 RocNZDlG2kAdsFUuXVU11kCWUCvayRcqB02+99m9dFpdtmVcqcZ89CMjL93PFtW8Y4sHNE5I+ne
 HEJRH4lx1AcKlu6YxL1G7lLzB1cSaeTOkjCjsueB/T1p445/spHmPTw05GXu3Dar+FGW9eauUVq
 QeiodeX20y1wj1xi7Z+LPgMhLUQgXd2iV0BrV5n63J80SmriFiXjq30Gjlkh9IYz4xtqafM0H4+
 whnJN/rUrkayOabiYHy9vlOACYcA+oH4ab3QP3fKgpMhjLvV5vhbFaDAjEd+ljmRO+fiE8noeZ3
 MreHVGD/FHzBkV6pewWXMMg2T3EmW2Pn+JIOwBsHRIT9ZBzQtKIJqV9JLt0GobzoCgRzZAzM6HZ
 wfZBE9TNyw4kEyr7Ygg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070164

On Tue, Jul 07, 2026 at 06:37:24PM +0530, Bibek Kumar Patro wrote:
> 
> 
> On 7/6/2026 11:12 PM, Dmitry Baryshkov wrote:
> > On Mon, Jul 06, 2026 at 10:26:36PM +0530, Bibek Kumar Patro wrote:
> > > On Kodiak platforms, the Adreno SMMU requires a bandwidth vote on
> > > the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
> > > are accessible. Without this vote, the SMMU may become unreachable,
> > > leading to intermittent probe failures and runtime issues.
> > > 
> > > Add the required interconnect to ensure reliable register access.
> > > 
> > > Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/kodiak.dtsi | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> > > index 90e50c245c0c..721526f023dd 100644
> > > --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> > > @@ -3389,6 +3389,8 @@ adreno_smmu: iommu@3da0000 {
> > >   			power-domains = <&gpucc GPU_CC_CX_GDSC>;
> > >   			dma-coherent;
> > > +			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
> > > +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
> > 
> > Why is it ALWAYS? Would it be better to declare it as ACTIVE_ONLY and
> 
> Added QCOM_ICC_TAG_ALWAYS, to hold the vote in SLEEP bucket as well
> preventing gem_noc going to sleep when icc_set_bw is being called.

_why_?

> 
> > then drop the extra suspend/resume play?
> 
> Not sure if I understood it correctly.
> Did you mean the extra suspend/resume play in arm_smmu_runtime_suspend
> or in arm_smmu_device_shutdown() path?

runtime_suspend/resume. I might be incorrect here, but I think it is
exactly what you need.

> 
> Thanks & regards,
> Bibek
> 
> > 
> > >   		};
> > >   		gfx_0_tbu: tbu@3dd9000 {
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> 

-- 
With best wishes
Dmitry
