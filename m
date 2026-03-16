Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299C43ECBDA
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 19:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690176; cv=none; b=Fe4m/c8XPmsbuMooYTSiCr197y7Assz3c8sT4+vWlfAZtZZsaLQ6dXOaFaOLHcHQSREphLDNdecvqaZb2LwznNtOPstEBQBe0+2UPPLribAVnwpAUqlTVkNEVPXHpra4vICsV1ygcWDyNso1oHHaJIKeY8w2aN6un5f5UMohO+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690176; c=relaxed/simple;
	bh=8pKSoyetPXKpNKLPG0IjYbFaZYicC2/GSi26W65ckfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKJz+kcNja1pXUYqxN1GiHjJvq9LQ9CmpZ/fsPJ6z4NhF0mE3keohNdSHUdUfPJMMApzw5/YUn9nXvjLSJYADeeufH/7rp8FMU6Cx2BlKN8AWol7SF6qFVFkHNf4bz36QiL6d+51mxq5jwR5cGaGmIlgDxD+/jZy+o+PhI3H5h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TZMBzrho; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ITvNcFzz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TZMBzrho";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ITvNcFzz"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GE8CUA2375304
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 19:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+cnQIkFDXwporw30NasLf4kS
	q8rzFR+Uzt/PemH3SE8=; b=TZMBzrho1ZI9j3MecyDJMrQhyfYnbp7F+HbgPg7R
	mqfG+xh/rvJqlW2mwKsCyVLwfzrC53QO8yBljjCYZZZjYabFv0bm9U5n4/bMcabq
	YF91ns+etwVEXWpgUnVfpVioCHWVnw7Cx0EpIQWBBbaQQV+X0Z4FCLk/ECUB2gu9
	IFz9s4XLYnswCOPX/A5G3JbjNPfwmH51uRI3xjMeiVaFLgWnjFPeSppW8kGt/5db
	2TR/0eQePYHL75VvPioyDrfUy4lTd5GC02JHxagrRGm3bXDSnk3HmHyicFSh+ZvW
	B756UKaOFmyJet8cUhVlEyPQtuuFGVvOCTwZLpwxvLTArw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxkby182s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 19:42:54 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-899eacb58a5so527960006d6.1
        for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 12:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773690173; x=1774294973; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+cnQIkFDXwporw30NasLf4kSq8rzFR+Uzt/PemH3SE8=;
        b=ITvNcFzz1Hy8oKLBV+DUeoBO70/Hdt3ASrKfc+vw0cZSwrDjFAN6sek3OaY8soITvS
         RLcJLbbIABeOO2tAS/nnQaEJ/Y20BIh0SMWwkuI31S55SsSc76BMPUqFp6AsXfoGCUSm
         lImaPpuaNcESNiuMzd5I8R/IcBp3f1Zu+zvEGPVmcplWGclhHc6zW8TNYFGjQ+JqWDbN
         Abxjp/y7tA7WakB8p6IOgrJYWykAul6g5LJ2Jt6QHtd3TZYUPAat8FgqZKHkmWD+sECu
         9HiRcvl7tRpP4E0LvVWTwJzzB7x4wCS+O7C4Ut9n8KF6vNOcawkeEq5mHttLnQcrG7cd
         uXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773690173; x=1774294973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cnQIkFDXwporw30NasLf4kSq8rzFR+Uzt/PemH3SE8=;
        b=he4gmbgqwynzuhKeOwvRgqPTi+5WJqI0jwGJWa0m4KWlKCUfaF9H9Aya53fOKGsjPy
         ppqkc6gW5v2aACypgFalLZbrlsVG4we3Zt2Qm0PxBU4B88kSbyeqgOvb+9HegJPa8i/l
         jUxUzAVXPEkbqBUjKm+R2Ahfhqm8VBwynsXZtR8a5TXUzyyZSDDh5ey9/cMwLUIbrYxW
         UuuJPSXdQHMY6cRpc6cb/0ZXvSlPV3Qz4qXAZBAGEtgSu+0QM6VWvxwQawFppqUuwnLy
         QIbUeg6mh8NN84EoTCuMt1Qq4BWTnZsYVj6XI8h4WWW8o3I1KyqJ7wPvx/BC0FkvtoEu
         Jwxg==
X-Forwarded-Encrypted: i=1; AJvYcCWrrNxdsYTonhSSg/APsWwxTpr+A6pPA4kzo89kEQxyQy01Lk8koMTDSa8SP8Bfx3CIkj6Zxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyimkEIWIIowMnriQznEXF65h8mxwu3sr/CQEyvpSG9OFrA3MBE
	jnwt2/7iLIC6wpix293UmyzfbOSV0ZXFZ0XbPbTaHjpBAFaEeUNob2eosYDpaERJhtKt7QrbrdD
	aF+l8PzcND3Aaygbhw2caRmzkKNlDwkKD+eX8JOiM3WNnCrh+RIonWu2MRA==
X-Gm-Gg: ATEYQzzkg2Jv1fw1QNq0c9KE/YuNYIDjwu0UciW+qSznrqfkLGro9DOnKNXtclYXLyg
	IIi9iI6R2E39+mdJm3pmW45TRvKuuzKl3Gh1rh41Vr6yi4ZTYI8EN8heBo0kDNEpYfETPj/6pmz
	pkipQeYTCs09I3AbwHqcr5l922Ir6WnpECTLRA7r+rqbgTV9kMsf0PMwBmwVKlJj2W9b8WZQWjh
	ZKGDxt4HIpnq1UXbYhj/G/ShtAJWrTVtx2wGiwUyiWk5fgG0T7ZsUVrOdrls3U3pKwZA6ML8L0Z
	PUgGYKDihr8OiZjE8gIrsrg4//MO6g5fLoqQg+EPvtVOW0iuXGteGY6+iy+LBDTYY2A7c19+y1z
	brkFUWCCp5La09PgtIleKCMtKkurulb4QkGOOxWOROwtVZVq2q8hdTL5hKWzqSCLGzUS/7E7iMP
	bSxZu3TgS1BQOGHZY78oY9p0/MDCdw3XSvIUM=
X-Received: by 2002:a05:620a:28cc:b0:8cb:72b2:2a14 with SMTP id af79cd13be357-8cdb5a4b8f1mr1825087585a.16.1773690173100;
        Mon, 16 Mar 2026 12:42:53 -0700 (PDT)
X-Received: by 2002:a05:620a:28cc:b0:8cb:72b2:2a14 with SMTP id af79cd13be357-8cdb5a4b8f1mr1825082085a.16.1773690172393;
        Mon, 16 Mar 2026 12:42:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a155f33be6sm3676665e87.7.2026.03.16.12.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 12:42:51 -0700 (PDT)
Date: Mon, 16 Mar 2026 21:42:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Marc Zyngier <maz@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2] of/iommu: support multiple iommu-map entries per
 input ID
Message-ID: <z4eqsfnxiprfktxi5g7miqqukhjsqqbivs4jqmox6r75x6pbyd@hgtkiy3ltyzu>
References: <20260315-iommu_multi_map-v2-1-51b98cb79331@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315-iommu_multi_map-v2-1-51b98cb79331@oss.qualcomm.com>
X-Proofpoint-GUID: rl_dt1Q9a8xqcmGtFLWIuDfxIfk2Mtpe
X-Proofpoint-ORIG-GUID: rl_dt1Q9a8xqcmGtFLWIuDfxIfk2Mtpe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE1OCBTYWx0ZWRfX5O82Z2a8jiRt
 1QNktjXFXv6/DHLSNy1B/NMsZQyiJXK/qFwMfw12KTvIgIftauF852XwpoTsHgKWRvqrI6s+K6N
 ZusNjW9DiXsFJOX2XxxxZoEf6GYFqPnxBwEChfooBe9c9FN2x2b6mZpw+lpf4ulr8ELDepzw1lZ
 ksC1jFdZVKfQJM0xBksGu2295Cl9qf7+WBIOGn5xB9cfAyOYLE0UfWbBijAs7eFYzDOm6FBNxmO
 YQtmfeeDP/mzNilsQ4x8IwLVUxKg18bDSc1f5WOz977A7cnNZPWelc8z0E8csG8NLoAIB7a+NtM
 /BTzIWz+BqjyK8b/LpivUZQHw3G7KOo79eJh4KFLbO7tsu4En6j7OD1j7EedtSjhNTM9M463kRg
 vrUe15JqOrbX7qd8pjcuLA6EYcC/C+suwSQidjAzGZZZkx4KD2kMCJeKNIv+k6U5vAs3bCyBkKQ
 DjZNu6fQKDjyVL6CX8w==
X-Authority-Analysis: v=2.4 cv=ZpLg6t7G c=1 sm=1 tr=0 ts=69b85d3e cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=b47Md4NF8ZsVKqcXDakA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160158

On Sun, Mar 15, 2026 at 10:37:43PM +0530, Vijayanand Jitta wrote:
> When multiple mappings are present for an input ID, linux matches
> just the first one. There is a usecase [1] where all the mappings
> are to be maintained in parallel for an iommu-map entry of a same
> input id.
> 
> Add a next_offset iterator parameter to of_map_iommu_id() and
> refactor of_map_id() internals into a static helper to carry it.
> Update of_iommu_configure_dev_id() to loop over all matching
> entries to support this case. All other callers pass NULL and
> are unaffected.
> 
> [1] https://lore.kernel.org/all/20250627-video_cb-v3-0-51e18c0ffbce@quicinc.com/
> 
> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> ---
> On Qualcomm kaanapali, the VPU hardware has multiple internal blocks
> that generate different stream IDs for the same input ID. The device
> tree encodes them as separate iommu-map entries sharing the same input
> ID:

Vijayanand, even I would not understand what you mean here. What is the
"input ID". Please describe the issue _exactly_, which blocks, what do
they genrate and when.

> 
>   iommu-map = <0x100 &apps_smmu 0x1940 0x1>,
>               <0x100 &apps_smmu 0x1a20 0x1>, ...
> 
> This requires multiple iommu-map entries per device.
> of_iommu_configure_dev_id() currently stops at the first match,
> so only one stream ID gets registered with the IOMMU.
> 

-- 
With best wishes
Dmitry
