Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FEF3C6608
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779039002; cv=none; b=lt22qRjvwyVMXvhp6sVDBekCJTY1IWTzrRPpEdkdRdt3dJxfxNMdK6gG1CrRNHJDrgme2CxfhfkVYsSuZAByM3uER2B6K+664gFgFK0uDgF5aCmfyMDxksNwbhx0BP5BrIN4EKuVDR66c7M7WkaEk+EbpxKnUGLrD6ESINH00RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779039002; c=relaxed/simple;
	bh=6py1zoHaVdRk/ukIHqAdD7V61Ikdrr3sm0apl9nG3Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INqqxfU+h575Lwlq6DWL4n3OJSaHnAsNZCA91QcvvJTR1Q8nHwq1Img3JwnJ1rd/SNGYKGMel2MYATEJJ4KojFDgDKPf2P8BfmRq1duPDeCDmfgfjSmyrD+4287OFgUzydpmnoMhDZBiw3gXNPh/G+esMUQrs9v1FfUgDpJvKko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a2zaxeiV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K25vewlK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a2zaxeiV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K25vewlK"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64GNvF1H970086
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 17:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JpdeiS1uA+pl00HV/TMDS+WW
	ayMzmhtr2xGT+L36+54=; b=a2zaxeiVGVoq4L/MfYoLpjoCw8rrZVrcuElfi8G4
	ZPiOY9VgXyJAAtkRo0RXWEk/6IcJuerIyGVgycOF7bkTaYBUqRrS8B6xab2MYQO0
	+o/Tvg5gLaE3cd5d616BX0HBzo8TSFV7/klc1j6cWjoP3ogVWVPxE0dmRkGqnQDh
	CG+AqgeZqzE6Wvif5h/Mu9wREMoemT3V2TKxVBs3MCuLzrNHYgVo7ofLsVDyNf5n
	yYNqLXqc/+mU3QoWIQ9bxcQZJwo+QyiojF9HK8lYGVq+GEC1pF0rPmBMZRhLS1Vb
	fVHd5DOmWDWql7Um+Dwrmw4Z7As9t3zr0DtTWb8y7cxjdg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6hv7u6h8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 17:29:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d890580e1so38343571cf.3
        for <iommu@lists.linux.dev>; Sun, 17 May 2026 10:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779038998; x=1779643798; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JpdeiS1uA+pl00HV/TMDS+WWayMzmhtr2xGT+L36+54=;
        b=K25vewlKSprFyGv8qC2hXsAOTOttBp3Ny4CSu5sLLLNbtFN4aR36lJG+j/VOrdQsap
         S3QnVPeFH69pUWme+Jw25iMce+V9TafLYBK5wymVdSWnUMS3jNcQCxUNyAu0vUD9tepL
         dCIELHsLt3Hqf0uCLo9yM+xwa3ZcRYYkhN9XoJirsfTDjIup/XSmUugkSIL/z2DWslyC
         VlMiv4t10NxqBSKZjUCPbsqgpBkJGghzwYhoogWFVVkUNbZ5M+F2oHkRdKytuJazl0cH
         UgqyljyYSqHU4GPybi9FUU5VJb7fFi3u9KBlepuMNfdUwirdgI1n8tW5s+TWo0i/1xtV
         6Vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779038998; x=1779643798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JpdeiS1uA+pl00HV/TMDS+WWayMzmhtr2xGT+L36+54=;
        b=j/nSztFvSuOKZzCn29bFPELr20uMGmTQVscH39BCAyTfXnChLRF4OPHGhQHbm0CQcD
         2DylTSMdLejAoC2GASaSVspH+R5SvE5pCp+X0Zjy74AbnnAIM3G8RhT0EfiqxKauGI8I
         HS2TqQpK7ATJpam3H9xp5YQmUikZenpC0IIDhWv7p27ODNv6MCOahWJpYg/BLIaW92WJ
         GRpvIU+Qdyn/UmgtZrcwQl8NfHHPL3h9l6KIDPZBlNdWMwnaD1y6RXjRv5i5SDTZ+l9G
         E9d2vVp3X5fFXclXegUVDzDccNwaAzkE6lKkOKm/LqzVhfxfWlYIcg0Cth7jR2qCufbo
         /alg==
X-Forwarded-Encrypted: i=1; AFNElJ/jkWe+mJ8woJLKXbE4Jos0zj1AVYzW3911Elom8n3cNkhSzGpJmIJnpqaDepYqkfpK/xyO2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQiZMV55b8HMloptNjvTqzjwOikpeO3S8wd2uE0/KczNiQg6fU
	25wqPC1aomtMWPfOtMEm03b+ED++KlFr6OqXms76c/xvhS9QNgS9v2bi1gHaySHU+xt6HGRdlFX
	+S7BkKd0Rx3vejvezopFTR/fp4GMJJxCR34CjFEVcWb6Eb9iV7KQvxnlcxg==
X-Gm-Gg: Acq92OFvaF0llOmzKU5oy0cJ5nSxFTkkOIU0SH3Ay9zlqdG69Qtoc+4veuWfzMXYiWn
	FSzW6dxca014EhIlh8lFDoya7FXmuwJvi0116HGreSlE2pWngMAi9HSgCFc5qn4eFYAm850Xo4l
	eQtuRkd+KWQnUIag3DuOhM46BVIeacUKuGV9i/laOrDBzD0oEprFBeh2shyUA8p5swT4JwDU/Ms
	3jvW3fWmZkfRW40TdX+/Y2UT2KM7eHeLprr2gYb0I+x0nL97c4t3CcaBMJRE97dC0EXzFX69Cx4
	/pdiF91PrtYBnLW/RyuVwTNuIudQhybVZO74E365cORC68dlx0vK9YSxqf10UbGBC3DEGMjV+/3
	aE+Z0plkvRm1F1mPiUbuCdUg1cevg0Qqe/kJHZcZRnuL01UEDDTwHfGKKB7SREmQ/T7cJqWRphW
	inMKTvpDWFqmNQC6FLGZKwvO07IgxeSptuQBE=
X-Received: by 2002:a05:622a:6bc6:b0:50f:b3d2:6ee1 with SMTP id d75a77b69052e-5165a1eadf4mr127697031cf.31.1779038998101;
        Sun, 17 May 2026 10:29:58 -0700 (PDT)
X-Received: by 2002:a05:622a:6bc6:b0:50f:b3d2:6ee1 with SMTP id d75a77b69052e-5165a1eadf4mr127696841cf.31.1779038997655;
        Sun, 17 May 2026 10:29:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395882c4683sm6281841fa.13.2026.05.17.10.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 10:29:55 -0700 (PDT)
Date: Sun, 17 May 2026 20:29:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 03/14] media: iris: Fix VM count passed to firmware
Message-ID: <izj6zy7c4ec2cjbsznkaxa4q3hupwteqprjzpajjquwchwa227@mplk7d7uccz7>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-3-7fbb340c5dbd@oss.qualcomm.com>
 <zfh3hb4gowxejxeip3l24jub2z3xh26pzl5xmjhjos634c6e3u@y26yubeb7v33>
 <11c63862-5e8b-9f3a-5479-706e672879a5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11c63862-5e8b-9f3a-5479-706e672879a5@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE4OCBTYWx0ZWRfX68eRK8bCwnca
 5b3AxtxdCgTeUFkPZyw5gWsyLZRkRYlVj29LGZ6nEHajcWBek/Nl82HZ4cc2Q29AmsidrbxhNIt
 jaBn5TBOGliuewbiNaKgvO3fRVGxIOGorOqmenAsIr3+EXyAMn8jO44OsJIp/MtQRaWXfO/4Je3
 s8zQdHqXAIMfHEyUW8Ez24KbKgpFDizcZKykfsTQrYfuNqjcNpLmcr+zocIy6Ccpy51ITc+ExTx
 wzGInNPAXK3AePAv82NRf/6GQ5Udyx1g9e/9JarPW4Xcm4hvNPozc0WUNq8wFg/OTaGiyqQ0YqS
 4foYKfhYXmru20TwtpK9j9Pwiw8CyUyieYkI6m6b5xESyEQTixEE4qsYs4rHanrLzEiw7Sp66hy
 lJpsFXrP1e/hkUCfaHNv6Byp2zL9i3kRKr8XnXHg4L43KEdmFx6k/B/2ewgu8DvO8h0xSIJlQq3
 Pf3IpHFcMA0MVpY3DQQ==
X-Authority-Analysis: v=2.4 cv=a8oAM0SF c=1 sm=1 tr=0 ts=6a09fb17 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=oM8CjG1BZR9KsnUa8EkA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: IcNLo8wD5wlLuksX9o-2UDTxyAqHnr6G
X-Proofpoint-GUID: IcNLo8wD5wlLuksX9o-2UDTxyAqHnr6G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170188

On Fri, May 15, 2026 at 04:48:44PM +0530, Vishnu Reddy wrote:
> 
> On 5/9/2026 12:50 AM, Dmitry Baryshkov wrote:
> > On Sat, May 09, 2026 at 12:29:52AM +0530, Vishnu Reddy wrote:
> >> On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
> >> the number of virtual machines (VMs) and internally adds 1 to it. Writing
> >> 1 causes firmware to treat it as 2 VMs. Since only one VM is required,
> >> remove this write to leave the register at its reset value of 0. This does
> >> not affect other platforms as only Glymur firmware uses this register,
> >> earlier platform firmwares ignore it.
> > The explanation is pretty suspicious. I can see this write in venus
> > sources too and it was added in the initial submission, dating 2017. The
> > driver targeted two platforms, MSM8916 and MSM8996, so this write
> > predates Glymur pretty much.
> 
> Thank you for the historical context! I checked with the firmware team and
> confirmed that this register is not read by any of the platform firmwares
> currently supported in the Iris driver. Regarding MSM8916 and MSM8996, those
> are not supported in the Iris driver.

So, which platforms actually needed that register? The "currently
supported" is not strong enough. We are bringing in Agatti support and
support for SM8150 and SDM845 is in discussion. I would not be surprised
if we end up porting other older platforms too. So, you are changing the
historical behaviour. You need to document the applicability of the
change.

> 
> >> Fixes: abf5bac63f68 ("media: iris: implement the boot sequence of the firmware")
> >> Cc: stable@vger.kernel.org
> >> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> >> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> >> ---
> >>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >>

-- 
With best wishes
Dmitry
