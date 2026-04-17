Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFD1273803
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776434709; cv=none; b=PiBMOkYKYn/rY7eFil+yES58VNHxD9lUJwMeLKEgfDxS4lcqAsLi5tletJiJjl4IM3XynRtFFSCQNUN4v8D9BjQ9f+b7ngWraBOuDKAFIPTJpER2bMomKqHKUo+IiqpfVAj7/QQgAUMm4qRePea6wyy5L6SlGQMMqh/irAwOqA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776434709; c=relaxed/simple;
	bh=fvhCnYIXJu9NlTEK0ZhQoJC8I3uZolKOwzBRwXBuoIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLhUeq7cgnbIHGzrk1z06csWLrkcL0YockIG09YHw4IhM8GMekNHAJgyOQB+l4n9zvG0bw0QyF5NJ1fpkxYNUq7FGcWsf5/DwMaztDYhdaFKNJT1f0bj3Vq4fAnQIax2krkKt4J2mfBS9Pda4NEvJRS1ooNRtS3c4sQzMuVC00I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n+C8bZXk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=evDgwQHp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n+C8bZXk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="evDgwQHp"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HBitan727598
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 14:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=eWvWoqz9QcqhnuWEa1OGrXdT
	RlPfmGyBbK0LFPb6Ikc=; b=n+C8bZXkyZ/6jAtMlFyVUAx/PHm7DqOBUhIJKM1u
	zbCI2MoprIsQX4XftL0h/jjCPcMJ/YZI+Zt2z+9Mqa/I5rvscStelLa9qzi/UD9T
	xYuhqpTDfdId2L1yYd2sytDljfgEpbdgRR9N5TpiyisZfmHaMHt0ARJa/oblTS9X
	mu4Zw7SvjeiC8SxuODog57ePSdggcop6vZyFyeLK9ywH31vyvOA1W0KzOW3O7cxG
	hkic+4zmG3U5mv7CJxpVoFbye+OFZF0usfHhQv+Nz3v+/d54e/dCEUNBUSesktGe
	WOGZ8AY9jOs7Qn+yUB8Jm1j8/4p5p2o6wv7/uljfTyAsOw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkfyqsj5f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 14:05:06 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2d93379001eso2224645eec.1
        for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 07:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776434706; x=1777039506; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eWvWoqz9QcqhnuWEa1OGrXdTRlPfmGyBbK0LFPb6Ikc=;
        b=evDgwQHpKwdj2QBjJio5QvesAhzSYqCnoLNUCsYZeZS/pSItoGsiqlUN0aPpzVTNYF
         x9galnBNMd6M/Nxe4TOqMyY2seSCGuGdD2Ul4KcoSeTjs58d9iNS1F5JBe7ixS3snooS
         cR2sN0JMzX/pPkbCHyNP2VTa4W5uUkUOWx6k7jCHY0raTa7CeZqAFI1Z2cKRCh7iCSU6
         uHr470OmuNOSoUsFcmYj1p2ZSMyWTKwvUcTX54Frc/bem7PuMXv+gA0B3RGqXbBQlKUg
         9FysF9z5zeEycHmPRaoKu1jw5OLoIa0aog0iwEtJ1ZpYveomopeglt+527MPRsF/0IVk
         YZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776434706; x=1777039506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWvWoqz9QcqhnuWEa1OGrXdTRlPfmGyBbK0LFPb6Ikc=;
        b=AnhWPGtkrmtJ/RCp47l5myJQ/kluSGtDzxx2Q70Dme2vvvF76/sJspxXZR1svJHAgs
         wzcfL2KYD1dxTK4js/1LD/oejF9gjDx/amGzsLhtUqPgFkUgaV0FBXizQEshrEEyd/gT
         Dmn/l95+W89UNeHNQxBV1GLYT+52RW2eVpAGHaC3ND6WF3QZcSrEfIwTXkfHhWOuJZZW
         yWnfIYAgmj/8OmYqvzpvPyrHFDaIoFv0Zl6sXBJKla5Mhbz334/D/Vh4lXFba5XLonWL
         qe8XXrvOsg6bHkcLAuMjKmAFAcMkxSdXTW4yafhhMb0IMf8Yg87rQysEqjiwNM6E/fha
         /2kw==
X-Forwarded-Encrypted: i=1; AFNElJ+xX15P51Sbu3mHVAo5Rhqqt1AnLkgSiNpqgmx12QpDXtxX8gYc9TweE7M1GUCOxK6IpYRUuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwaZ2Ud1YgHkM2qXZo3ueLly9CdZbViLqbHUxGn4Vh/MNnWkdEJ
	UWddhEneXMsZyGe5/JdG8XPX6hjIFNZI0QgjITqa5Im9DX7Y/AX9yXQlQEoqdFZLbacRfhtDRj1
	SEuRdu1eII5pTehTX7a76G1Dwp/3XFeujdrBatTZ7tP0N46FgcjlD016slOR2tt8TxshJ
X-Gm-Gg: AeBDiesRGMA12rZk6FPSBINy7wzv/+1GlfW87FEDWTAMABzppAO7RCqnGVSiB1ECuGs
	YgeKdRRzGwold+wqHq3/K5P5Wyn/rnDPGtWntyZUiUBAMdBcdJAp1F5T/kOoiY+OTCm8j+qMN3V
	5eD53KxumWNYKV8wjSo+hz87NfG9KTUfWwVRnwY5tSg1wN/oRt5MMQW6GuWpPOzwdlXb0rYChEL
	GBS6Wr12zF5zK9cXxpqAFT0O8sv4oYJI4B7WBrFP3stGD7dSGthX5yiu3Dm/iDvN4c3emVlaLgP
	zvtRN+Es5Ywq9ffUxZmr2fvSIYZTSZGtTJEsQPZWPlTQ/w1F0i9vMdcSG2rBAAV+/2A3PFUCNCo
	DfkDiciBuIl5UMqc0ZLzJc8wDKw57yP27rYue8I7VGno4YK7DzZTe3NsVF4tD3IbCKH0uHXmdt2
	Q=
X-Received: by 2002:a05:7301:1698:b0:2d9:94b4:a1c7 with SMTP id 5a478bee46e88-2e4788390cdmr1619186eec.15.1776434705553;
        Fri, 17 Apr 2026 07:05:05 -0700 (PDT)
X-Received: by 2002:a05:7301:1698:b0:2d9:94b4:a1c7 with SMTP id 5a478bee46e88-2e4788390cdmr1619091eec.15.1776434704692;
        Fri, 17 Apr 2026 07:05:04 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce440sm2231261eec.14.2026.04.17.07.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 07:05:04 -0700 (PDT)
Date: Fri, 17 Apr 2026 22:04:59 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
        Bibek Kumar Patro <quic_bibekkum@quicinc.com>,
        Ninad Naik <quic_ninanaik@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Fix fastrpc compatible in ACTLR
 client match table
Message-ID: <aeI-Cxf8nE8PH2WD@QCOM-aGQu4IUr3Y>
References: <20260416152652.958229-1-shengchao.guo@oss.qualcomm.com>
 <yel34g6ugumgqcuhe33pzaaxqvmjcdakdg22wb53oq2snpbb5v@6wfisbcwzyvs>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yel34g6ugumgqcuhe33pzaaxqvmjcdakdg22wb53oq2snpbb5v@6wfisbcwzyvs>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE0MSBTYWx0ZWRfX/W/RAelWJkfu
 RmBL1miY2SwIw20gqzHiFB6WFUzMyknSulr9pPtWlg4VHreUu0zH0tL7P1fyfz1zt3vBXWQeTUv
 6e2kLFrE1kO/4+MzcBM23t6XHDCzZ7Ddlw7Y1NujxxrL7kEH1mbiiwYBwOpSWFWWTsan12pcYeH
 XJSvxlW+0LqyLFsWMl/tVM+OvSpr/De4+YmE6v14iCQsNjOOV/guGKfthJ9QplLxjQnHLNPaV3k
 ZMP4QrkThwU11gbBdH5hKgP2UtZOjN22l7Mh0jeu74KS5O4ivd6YY1i3gtYlMFpQ8xH3XuemrL9
 +uALOUO61iTX6FnKSF/AUFRFufKYmcFgvJhspixwKESy5K12rOz3s9ZbKG5Y8zkkg8hkApm2sxS
 5YSVFoqTXDodfO4nN/0+fVC1uLlVD/nfdF9u0OKW1iAiDldS3tUeCAdntBzBzVaR7LPOaTLvB7F
 /H6THTlkORxAHy3tKBg==
X-Authority-Analysis: v=2.4 cv=BZPoFLt2 c=1 sm=1 tr=0 ts=69e23e12 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HBlysRB72iAwEyOw3cYA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: TF1OfS1RxZDQy4ttqf_hUROKI3Lu7lGf
X-Proofpoint-GUID: TF1OfS1RxZDQy4ttqf_hUROKI3Lu7lGf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170141

On Fri, Apr 17, 2026 at 04:19:14PM +0300, Dmitry Baryshkov wrote:
> On Thu, Apr 16, 2026 at 11:26:52PM +0800, Shawn Guo wrote:
> > The qcom_smmu_actlr_client_of_match table used "qcom,fastrpc" as the
> > compatible to configure ACTLR for fastrpc SMMU clients.  However, the
> > "qcom,fastrpc" compatible identifies the fastrpc transport (glink)
> > device, which does not have an iommus property and thus never attaches
> > to the SMMU directly.
> > 
> > The actual SMMU clients are the per-channel compute context bank (CB)
> > devices, which use the "qcom,fastrpc-compute-cb" compatible and each
> > carry their own iommus property.  Replace the compatible string so that
> > ACTLR prefetch and caching settings are applied to the right devices.
> > 
> > Fixes: 3e35c3e725de ("iommu/arm-smmu: Add ACTLR data and support for qcom_smmu_500")
> > Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> 
> https://lore.kernel.org/r/20260408130825.3268733-1-bibek.patro@oss.qualcomm.com

Ah, thanks Dmitry!  I should have searched the list first.

Shawn
