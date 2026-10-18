Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A733EAC84
	for <iommu@lists.linux.dev>; Sun, 18 Oct 2026 20:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792356621; cv=none; b=iR0HxYsnBFsvS0Vz9ori6oVlh2K5dpgXO+tdr2P4JSk20OQ8iszcDUhyu7tusJFPSDxkG12gTHI6dGc9RJHuu2bTFtDXJyS4h8QF9w12IbemvxQ31eFbccxJa1ouZl4bBeCNJASaEeo/3nrKZFhr3g/A9aq5ybs7UPEoo1o38rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792356621; c=relaxed/simple;
	bh=lggYG3UIDLXk68ELUMdJZsGAmWEaotCE/D1HZh4Dk6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJ9OG4y+M/erulaeinY3qKelKKbgyW7sRmQPdGxv/JRd9PuGxzTIkWnpME7j45V+y1p1PWmIObtWZ+iQgM9yNyqzIRH8Lut3pGExkUodaEudMB6UawaQkD1dVNctPxA5Cl2VlQFcq7OMycoJOmgFOrgozA0zQsIqNE0X11Pu4/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=alPDUBmX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ayQYLo7D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="alPDUBmX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ayQYLo7D"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69IKBbe21766655
	for <iommu@lists.linux.dev>; Sun, 18 Oct 2026 20:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qjeya0IdQ3BzmDbZDR5yncWIDXEvsfN30Jepiufy56k=; b=alPDUBmXZj67otSF
	nWir/HmgR0gxkaq9xp6Blsw7Nya0qwRi1CBwOiPBMf0eMHnvVwQDhl5fdH4Ag/UL
	LaA8KFy8Wj+qLHgKRVIP1Vaxj6VWDxhQbs/9tJnAiWfvyUhr368UuawqW8vnG7SS
	ODCoO1dfucNZky2JVCE+IGAt/BYrSW+aLK/ICn9DQhApMT18Nskfb3r3TgXgPuBo
	i4Mh/KCxROcs6gibcBeRmDPwcBiuc2DKpMOd0sHQ9sFwPi2U7Fuw6qzBziDRZlgC
	Ki6jYeOX2lv6KKFD+Le25U9cMmGYoDBfzyQMugtnw0hiLx3KyPh61BlFrHw6PvCv
	yYg+Bw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbxqfv5gr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 18 Oct 2026 20:50:20 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f2005ce21so272113585a.3
        for <iommu@lists.linux.dev>; Sun, 18 Oct 2026 13:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792356619; x=1792961419; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qjeya0IdQ3BzmDbZDR5yncWIDXEvsfN30Jepiufy56k=;
        b=ayQYLo7DTBILoTDnVnRFKNIkItLF9//N2sN7+fJJW6XlJvLYr/hfrNdfBqgqteyTTh
         Oryxh8Z6G1yvIyFlSul+HphyCwwl+nI0Nw2Z0mVCsdvV3yGgQXSsi1ngeKJA+/OcPFW1
         NiwOhIwPOL8dPh18foTumhCKb0s1y+fIEZI98h4uK1jri+JEx/imXRoR75XdGHhRCN4o
         KeFtbU7wHcCby1dM99MV1sp9PBxa7J3klZIXshKNkjEwFbgreTAGUSAbJLU4xde0pdpn
         zoFp5PcZ+P5vTMWq97LCf5Q0EeNjFmwi4jnWUmz9Ojyk9MgXpaAWiqqMO6JueamQhhzj
         X4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792356619; x=1792961419;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Qjeya0IdQ3BzmDbZDR5yncWIDXEvsfN30Jepiufy56k=;
        b=FaG0/Nee6ksJxNflkrnJX+Y0+hh2bPIDq/6pLdIkdCq4FlnNh0dnIqSXb8+yH9Xi/Z
         vKeuNTlpCHSv75xsWYKdMHbK4wR9VAf8tB4Xo4oGP9IupbXLuM0QCAD67PF/QkX74utM
         olf4s/9pkPf+vywqM+iKZv1rSMtmWMkG8XubdyzDFoG7XLwGIOigeFqOKyVgvye/pZvB
         yQ1nUgNY6M7J2pQgblghcZbvmzMai/7eogwqn+7RfeGIxctt4xAdgId5xVC58rnYHrhu
         lRzNbNu2054Uh9ffjOsuydZ9+SU6g3tymZdIhZEybDl8PeiexSOKj0IMzDDIzbTVCadC
         WD1g==
X-Forwarded-Encrypted: i=1; AKwUvBx/woruapcCVNbtck5FqnNMHpYojiubu5E39363ZNQ+6R7M+JzK8myDTrYAlRAmKKrqzYAAzg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJfv1W/y5K7VxXfnIRl5nf7eUzZ/C8Vz7q5yf8o3WSzgGtqQbAw
	8v0Ufcpe6R3NPR57HlSgBsq3IcCU29fabsFEpksUXQoq8CxULDVpAsYye4qutZ7UFU5w+GONl/q
	jb6JZLkkJTQT88VKRghm6DiwytbdLIMH6SJWjkmFMkQtYHjtezh96nGRxr+K0FMKq8Q==
X-Gm-Gg: AYBFou13nvhK7PFsjybH1yBr0KDrCa6ce6B5/xwPrZTCuW78EcSnrUo2ika5EcaZ0mn
	e1UDO54F9/RdRa+iVE6Kv4Ox/SXdBm7X/QtUZsAQbPOIIwNmhlJT1M4h5Xo2UOegN9kM805ZL+H
	uiHKuazHTQdakFnoKAo99optCaCYfb3ZoRbH0g/X6irH29IHAuTSdd7hDYMDI9uQFRchfKpTPtt
	KVNuec2INVv0focki6NJDf2w7ECkzxG5tMQ5GEhntMK6cf3WvZnZLCjUIXdlbW6h+q/QxL1dlLW
	qoxVdY9DAVfJw7ZtDCHuAkyt7MyeHcv/yJI8N4pdtb90avxXKPiYemGz9BNUKCaU+dgdY8ygfje
	x1dzjjJU7bJM3vPyY45jkuE+qde3uhuHfbPbCJUBiw7wuH54cA8ccuW8EKX0tdjbJ2VKvnM+WYb
	QjV5e8vlOQ5b93
X-Received: by 2002:a05:620a:1a0b:b0:93e:e2a4:b0fe with SMTP id af79cd13be357-93f29dad8fbmr992434485a.66.1792356619156;
        Sun, 18 Oct 2026 13:50:19 -0700 (PDT)
X-Received: by 2002:a05:620a:1a0b:b0:93e:e2a4:b0fe with SMTP id af79cd13be357-93f29dad8fbmr992430785a.66.1792356618645;
        Sun, 18 Oct 2026 13:50:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a63a2edsm1669525e87.68.2026.10.18.13.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 13:50:16 -0700 (PDT)
Date: Sun, 18 Oct 2026 23:50:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: =?utf-8?Q?Micha=C5=82?= Szczepaniak <m.szczepaniak.000@gmail.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/12] iommu: qcom_iommu: implement support for instances
 on MSM8974
Message-ID: <svmk5fixazvuzkkug3mvay72kah2kf73iptrrsc5tmjtqmpp6e@4663g2h5qumr>
References: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
 <1a469aa9-e4c2-4d13-b544-104f4065a14a@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a469aa9-e4c2-4d13-b544-104f4065a14a@gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA4MyBTYWx0ZWRfX0zjlhdN3zZ2q
 qIC6iNvjY3Cnnc+gaQmziYCfXo1S2skz9RNiokcrVirR+1tn96ofXQOwv80q24/iJiNItJq7q76
 8s+qVs37nhJj+wsBz98jiYWmtTODcWc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA4MyBTYWx0ZWRfX1OnOIi2JC1CD
 S5LvfUVECc4ODS1j49CxuwIyKyM75FA0RiGdfHjoQD7E7+ftZl5Yu2Jl4PNfjXrwy7HYXZ+Uod/
 z3fbhH3g3cIIBkKUzKd+VD8PUU10jM9pbQVD6lpx2wGdmQ+RL99b8v5wfs8kYJCwCizc6X3Jx2I
 OnM8NZXxGv8vH0fH9GRuvOVCI9/48uU5JgR41cQIE/Kut8keQfcF2vIJbvHLYOcKiJQys06nPbI
 BcHkw6zTjn+R5zlRZGWyASUly6kKhfbRiFL1fI9Vw+w9aseZdtL3wF0Z5sWr9S/2NfBiNPekgkC
 0ieAi9dkYtbCCfcz20Om/ULaI1Q+WgNMoEmONwG+YjpqZ5zEM+FhACxK03q+NU3ZZWpiyW1Fbdw
 KAt1DObC99gDVdAfPiGRokQiasK3X7uHporpd5joft2lwfBC5qt40n2waWtwoy/pHo6Ql+j4SPL
 /BcKWHJrum7RIFOp51Q==
X-Proofpoint-ORIG-GUID: KJvyQhYzIV29vP9kzIb3wPv2SjSXEsWA
X-Proofpoint-GUID: KJvyQhYzIV29vP9kzIb3wPv2SjSXEsWA
X-Authority-Analysis: v=2.4 cv=RYMFmFtv c=1 sm=1 tr=0 ts=6ad5310c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=KAcPb9uwQpV6Y9LkPCcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610180083

On Thu, Oct 15, 2026 at 09:59:44PM +0200, Michał Szczepaniak wrote:
> On 09/08/2026 22:15, Dmitry Baryshkov wrote:
> 
> > Qualcomm MSM8974 platform has five SMMU instances, used by display, GPU,
> > Venus, VFE (camera) and JPEG encoder. Each of them follows ARM SMMU v1
> 
> Hi Dmitry,
> 
> sorry to barge in but I just wanted to let you know that I 
> gave this series a try on the Motorola Moto X 2014 (victara,
> MSM8974PRO-AC, PM8941 + PM8841) on top of v7.3-rc7 with the
> msm8974-mainline patches and "clk: qcom: mmcc-msm8974: add
> GENPD_FLAG_NO_STAY_ON".
> 
> Display (command mode panel) works through the MDP IOMMU. The GPU
> works too: the Sailfish OS compositor renders on freedreno (Mesa
> 25.1.8) through the GPU IOMMU, and I don't see the reboot reported
> on FP2. I tried 3D acceleration, and it works without issues.
> 
> Hope that helps!

Could you please reply to the driver patches with the Tested-by tags?

-- 
With best wishes
Dmitry
