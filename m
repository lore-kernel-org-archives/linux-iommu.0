Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64192D9EC2
	for <iommu@lists.linux.dev>; Sun,  1 Mar 2026 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772362771; cv=none; b=ZxyCYu5jDw6y9SmV5loduPUC/kD7Rc2xZqW3eJbd47TIKGEcztNZIVfV5jXz/sDpPiJPDWX76/XJM9SOBo8U8OP6m7ZJme6tuFROjYo9cRV0OG4pXn1ahy16YCFSvNyeaV5O+DYnWw3K9xxiBX1bhMgHIGnQw7MOVn36NuRchmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772362771; c=relaxed/simple;
	bh=ma5KFEqHslgRuuIwDm092krRisjxb/PVQ/WF+lX7RAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnTvmqHKFZ4Bd9Ew9XxbkWfw6GTnPwdxwVyCII5PRaMzk9AvFHR+6hPAFYMvyvjQ7MUJPtv0Txdiaeo1oZKPR8ZmwRVU2VyjbKdXM2QRjPrhygVQTFvF0J4sRyxcJYrfm2HsQKsuGZXFuoKx/j4tVCimG+mypBIUZ8EetJMQrUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZbRtpKNV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HhZem0dd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZbRtpKNV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HhZem0dd"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6216bEjl860810
	for <iommu@lists.linux.dev>; Sun, 1 Mar 2026 10:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tWvbzoSirp2+/mfj208EVtuC
	kSsURTVI0XL++QIzXe8=; b=ZbRtpKNVrLZlATBeln8U+o1HVMJ1NJFODQD2g1Xt
	5zqmD26FEi7oT89X6dB/3Kf0XkkF6A8sXLJiy6k2cdCfTElYXz+CjMK5FIy3AQPe
	xpwFsAEbry2aIJz+ovYfTdhNnokCCupYZNrBBmfiE6N5iXxEnaecxqJfkBq7jA6g
	atxv+7P2SKJ+CThu9PnqyE+e14r5zyxB6+fChJWyb7bmsbhO1nbIl9sdXtyQ92aF
	9NNtP7wU75FlG/y0oxLuqIE1sXvncry7ovuFrwD64sbYiUvq0bz1X2QeTCCuTyIj
	PQrXowySKFMO/mebdHFA3zvBB6060oQ2+M3ZZuPrtLkY+g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cmgbar8dw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 01 Mar 2026 10:59:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb3b0d938dso3401668985a.2
        for <iommu@lists.linux.dev>; Sun, 01 Mar 2026 02:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772362768; x=1772967568; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tWvbzoSirp2+/mfj208EVtuCkSsURTVI0XL++QIzXe8=;
        b=HhZem0dd/R4S3YLBZ9tRzqRxNuw7hyWtdXsFx7LKL8zOicob2fW5NNWkFb46AUiWMB
         W+Gu41dNQM7q5n/wF/Li+/AwuhOCTQBAmBvaIp5rePUtJ8urkDg880g/Eo1E9V7fDxAm
         BpfWhS/NFif5wlUjLZ4lvnfJKu5esqYhnXSrr4aycSTClHpxniGrZ7kHySACwMCirxii
         WH2K9TPvzYvCB4hmk34rcbZnq5EgLzHDVddziaL5r22cTWJJeSAKBdTwBF0Zs9ejNKhe
         45hdj5RbV5BiaeuWf2UYTMo+Vzg5pzTqqpVWJ//nSuvdXMYI/FjJEdD7Yk3jOTMmGbVS
         HRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772362768; x=1772967568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWvbzoSirp2+/mfj208EVtuCkSsURTVI0XL++QIzXe8=;
        b=fVYhYZA6H9B0nJYF4FDMdTVZKnqKZBNE36d3Awvz50tT4Dt2jzNNkGFOOtUPTD4Frk
         LRfTKZV8mEkFLMXCj6YSmdsuE3TRnRgGn5HIC7Jnj6WCV9fRc+bG9cagaUkUcrkXsFvk
         J63Bq60SoGax0tRdxehadc05EjwpN34KHjgH9ZaeQwtSnj50XpCDODCiUXkwqgVHHLpq
         9jMh+a3jXHa8yxMY6pNtnjLirfNLG0Ua4ZDE9gLCDIr85W9gFK492SrjhVWJvcannwWt
         tR9jGZhntu26ConAsQaxDGt1MNesXc/WHU2iyK0FRYREw6XVa++OH4SoID2vQnGsjiMX
         IdDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzxiqG1gSS9N/5SH+2fbJJQOKXfuArQfbaU4utA2o+BZMl934XmSm8FebV0AYGjE5Cgm1MAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuFji61AnzCk3Cy7Md44x5idT7ek5TQW8OkLcJGjp0NPyzD4ll
	fJjsyQuIHIAhl8fLiKzh4zqTF+lNYyHAqmsEuYKZyFu393l8R+ip0QCkDrgXN0WXLDpdhoy4pwK
	WsknyAeKahy5HSQ36WTm4DgXx6Ml506bFefksYHfZzetTANdbr4oJ+dWIXA==
X-Gm-Gg: ATEYQzxK9Q6WASuWdLxoyNPIesQttAF6dIy/rsCuKGVaIh8SnNWTL98QhGF7WeDhbWF
	tK6vwGmj8TPFkb7tXjsWMpGWW/T9CWlXISRQanVWjCNarvIlWObuTBZsWkjTNvyu/NJhFN2SFr3
	1aM8iHQT1lvwoKPtwATxPEQF/WJm+dZ5IJz54AvJzmaL65qDr0ngl2flwXenjwxNMw5EfQtoQyc
	JRzbQxukCuW+wNchDcjvv50RXHXSXVDDe//B8ptvfhKcTZ/tV59D7bngXq5kakvrtIqTszI0FVU
	bNl367L0ISijNdoWcUEia1rwa3JISi8/bzWXUm0iB++XQYbuge2iqcq+FwDe1ukozWt8VwiXjSG
	p9ttBaoaWVncAPJMRMdpV8HEp/+4DRd81B8b3Src21jRbziPiUYfyiHydo9Asc3RNj1IOYOaLsC
	FXgD/0LTerO6URjrwIlohRllPtH3ImOfA4D7A=
X-Received: by 2002:a05:620a:3949:b0:8c7:1b3f:7d0c with SMTP id af79cd13be357-8cbc8e55216mr1090397085a.16.1772362767979;
        Sun, 01 Mar 2026 02:59:27 -0800 (PST)
X-Received: by 2002:a05:620a:3949:b0:8c7:1b3f:7d0c with SMTP id af79cd13be357-8cbc8e55216mr1090393285a.16.1772362767407;
        Sun, 01 Mar 2026 02:59:27 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a116de019esm872280e87.3.2026.03.01.02.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 02:59:26 -0800 (PST)
Date: Sun, 1 Mar 2026 12:59:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Cc: Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, imx@lists.linux.dev,
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Subject: Re: [PATCH v9 2/3] of: factor arguments passed to of_map_id() into a
 struct
Message-ID: <bo5kb53hrzvl6e5mctvnpqluobdgbpq4x3m5ca7mwtfnl53npw@7axqsph2vyqd>
References: <20260301-parse_iommu_cells-v9-0-4d1bceecc5e1@oss.qualcomm.com>
 <20260301-parse_iommu_cells-v9-2-4d1bceecc5e1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301-parse_iommu_cells-v9-2-4d1bceecc5e1@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAxMDA5OCBTYWx0ZWRfX5loWIO62xl4j
 7H+qHxHa2W2j08zHc5n1UvQU7L/jPlbymQ6hShLNs9i+jGYigXzM8UEIU2T0DKm5kbgnEmIkNDs
 a5V1QxB2I5is38K4GFIcb/lKkna1XHU4ZooHOv0SFu8KT7uS2pSnzlU5TH92DfwVlvL2wx7NjdI
 ehdjU0zs3CkyelrgtF+gd9H17yzCtc3RwnicDjkiSlcbg9OItebxeGaJ4Hy39lsXAmZt6cm/1mO
 Xv2ojPpgEPJ4b6HC+JGq55j5xOhF8z3d/tDtApJWB6ZrUt8WoajC9xTEwvELefopwM31kt6iMIy
 DNaUrmiMX2tzcRqL9yxhMcqn7NWinQg06qbw7WukmcP9STrvAZbzk5s5uzCQDUGj4lv3s+OE1Bo
 sjP0IhhbH8C8NtYajJkp9vLWqyqUq3H81e/2jYPF+uqdTSFuKXctXtNjzJD2mJpnqiP+JlltTvP
 efKdYeSFrwvv+ULh0lQ==
X-Authority-Analysis: v=2.4 cv=QfVrf8bv c=1 sm=1 tr=0 ts=69a41c10 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=Dq95N7oyZucg39lo86YA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: IzOWdrY2hzjPEn5fFO1WTy3F1AQNQCnC
X-Proofpoint-GUID: IzOWdrY2hzjPEn5fFO1WTy3F1AQNQCnC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-01_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603010098

On Sun, Mar 01, 2026 at 02:04:20PM +0530, Vijayanand Jitta wrote:
> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> 
> Change of_map_id() to take a pointer to struct of_phandle_args
> instead of passing target device node and translated IDs separately.
> Update all callers accordingly.
> 
> Subsequent patch will make use of the args_count field in
> struct of_phandle_args.
> 
> Suggested-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> ---
>  drivers/iommu/of_iommu.c              |  2 +-
>  drivers/of/base.c                     | 37 +++++++++++++++++------------------
>  drivers/pci/controller/dwc/pci-imx6.c |  8 +++++++-
>  drivers/pci/controller/pcie-apple.c   |  4 +++-
>  drivers/xen/grant-dma-ops.c           |  2 +-
>  include/linux/of.h                    | 21 +++++++++++++-------
>  6 files changed, 44 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index a0937b7b3c4d..e1d4b37d200d 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -755,6 +755,7 @@ static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_d
>  {
>  	u32 sid, rid = pci_dev_id(pdev);
>  	struct apple_pcie_port *port;
> +	struct of_phandle_args iommu_spec = { .args_count = 1 };

Hmm, I didn't notice this. Parsing functions are expected to ignore
of_phandle_args before the parsing. So passing .args_count = 1 is
strange.

>  	int idx, err;
>  
>  	port = apple_pcie_get_port(pdev);

-- 
With best wishes
Dmitry
