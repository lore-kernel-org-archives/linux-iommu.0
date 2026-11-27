Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788450;
	b=lxKR3mHbZtKS+3DgDYX8kPS42dpnQ4GX3MsbhW+sGem3PE2VTCDhOXSmxHQIB7SkYR47
	 3QP7gGq5b3CHy8D80NJ4VxUbpiRQu6UrFgYOPC5yxV71Lhgnt0n98A7MbeqedteUmNNXh
	 i36K4vHL+YN3QBc/br+4z+HuSDf/X2Dc09ebidD4JCMHfRimcxyZSHe189dMV1NqwCsFL
	 vmQxrQO/O8nhuDHLQ3RoDMVI8pgznqrfruQfxLl9at1sbWetKpC7/UqPdB8aKFmEIr9dn
	 s3v1XhOO1qRdkBKM8EJqN/bd+sS89z+5X5IhNeojPwdidPL3S3n26m8JxHq+8d7bMxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788450;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=YfbNWHn/IWj+x0bqlZdsPj/C6tp7qzwGnV511Fr7BTo=;
	b=eIzSjRFv0OIpgJC7czjzYHV+RhyKR1m/glTUJqD/TE2+mFMxexdlqYtS80bEE8L/EsjV
	 ze4YgsOkOM1qKBmCENOKisnMNiECdNds5zWA69lqAf1manLod87FzpS92JFra245wWpyp
	 iF3a2hG1zxJ6ZFCFdoRNgWcHvQ0m9pjKYfMDn5fmuaf9UNMMxuFQL2Qiow1AvKOpkloWO
	 7+SvlJ2o43oHujV+dIchXY1wnlUeOHlDdh5T8b6NlekxyRAfJD+XjhVJR02jfTbeKwVh4
	 AT5nJDMOR/nxUXjiPfL+ufdcDlDek0KcPijDT2VzKSgB+XbOSPAtJlJyfWcYQQ3V/zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bMe7A6H7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kBTngGBw;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3473606A335
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 14:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3473606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bMe7A6H7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kBTngGBw
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1Kc5685979
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 14:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YfbNWHn/IWj+x0bqlZdsPj/C6tp7qzwGnV511Fr7BTo=; b=bMe7A6H7rINkNX6B
	tJyA9vfBd9gPTs1oO/dYBnZpI3HzGyk7uzG12g2E88LZkqyOjF+LQiFT2XHonoe2
	zNkZnVcZxmGmWfXAgNOH5iTo7w/m5scnVAqaPbLWGXoSUxYoKL+smb2QWB6c05m7
	GD7Tu1rnekQv4hKH9gO06IDsoFiX9WN6OKmKrWD9kiRJfbVeYAqpcrQqR6Qp6Z62
	BDxYiLfTLKvNCTiWYZFe3oGrmfM6x/ef59MjmJshz8mCBFx061w1XR6iou0D7G5w
	HyBBSR+3St9M9O4cItvHhIkz79YUml+ZeRma1O+wPVpool7OBLn9QOJ9gKxu4kiA
	usJXlw==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u49basn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 14:07:29 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-4ad62d600beso1226975fac.2
        for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 06:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795788448; x=1796393248; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YfbNWHn/IWj+x0bqlZdsPj/C6tp7qzwGnV511Fr7BTo=;
        b=kBTngGBwBV0OD/gE0m7Ksb7aQCZmSmOZVt5j7AFUYdXXKUgIKechHc68baeK+fFGDc
         QUf+3XuH756bO5SHzF4FiG/mxbAQHU1acUi4H63I6O7sgaJyu2BRxvDI+/CPDUNZaLb9
         au2PYP+1G5opcsKuVX5WibRpGagGXWwaORvzJ06V4xv1UnuxqqG+vY52ii0aeGdjpN3h
         v09ciG5cDSVtjRwXcYmSxXV0/2hkLk2uCeln7VSkE5tawAvOQYZnb4sh87hxiMUbuCaC
         pYI/Jx+2xFWtddbUSmUr+C/tSQ5FI2Dw29GEqIkPbTDXxDs/+AA/eD2u1cR/JUlK0vmt
         ikew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795788448; x=1796393248;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YfbNWHn/IWj+x0bqlZdsPj/C6tp7qzwGnV511Fr7BTo=;
        b=KPwmQoyQ6w1hyJ50eDU2848TXmbBzyaWzziRZJuoY5SHEJkFEF9AjSCN33HkbjMH3N
         sHc1QxUMqhTz/Q9N8ajqpWNqZ1vhq0HHAwvHy3D+HdewbHnxQ91T2Q1vIONkP46PglZy
         3JjJgrKruQX5zLVxM9FKwtACTwmkpz2dZTJy10fPUt1wrJtNXcsBWX8+hIKmvxH2nksy
         bFrVTO1ff9v2FjZhRtI1wZTyfgba2ilGGMXG2K17RiFrMHqZgXS8/HxKfYepJ4AnMLOa
         c4hDwyLlAPDowTbH4mbNq35Pyhpfb5iG6YzK739mbfjQ7AQhLwNhe0F7GFgVLB/bB030
         tiUg==
X-Forwarded-Encrypted: i=1; AL+hErGbYbz0FKXWkg5dw96vit0aOTniDDOzKp0nshx93jRYHnq4l7oVWwinYziHIBUh1udQjxDxBA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+cMukOw3TNF/gdkxkSs7cNnNjdrMhqcfMdeUjLvgEgmgR+fwfx
	psuQi0M9doiG4a3I2I9HryptBanUUQJeuzTzuaCYP+MeXyJLzpPXTCTESMt5yiTUykUqk2XCpZq
	1d1t3nz4gdlM7//cejfPYscA2kDNjaKT3YKSb36xI/PMVPI3M9Qq/hCr8fg==
X-Gm-Gg: AZFdTZcDPJ4m+YnBrs3RLK11yEDLh4csHM/Z/NXuURMGM5bH64mDBBSyiRpV9ppim3e
	S/j1H3zbdIs/mEdc9X4wDf9wtQpsd48khIs8PPSOS716AhoHCvhZFnYcOU8P0oNqczG1MxW3q1l
	nJFo0It7c2cKM9RSi8YG8T4ovBC56EoJLxPOYd2qsQOLdnNERRfhbGJaP8a4AHF99/UhMjRPMuc
	tc/WD4l20p5rTTRrLICn/6rTxlQyNG1AOjXho2VTrNmUSESQDiOZy9YpZ27+X5LPSoDipIPp9ac
	ANrdhVe7+FuTPleOKT5S0JX42UPHrOvUKILXVaVq8AMdKvv2a+4iICfUu+9sIhLE4Vurpk0733o
	qZqV5Rr8X70xvAdiz9z8TjALbXaileHhRKwSgHeJFXhwCWriRA9+Qv5sF4BiTvwoPpuEAzI8=
X-Received: by 2002:a05:6820:c0db:10b0:6d9:f62c:2698 with SMTP id 006d021491bc7-71b392f5007mr22283698eaf.1.1795788448194;
        Fri, 27 Nov 2026 06:07:28 -0800 (PST)
X-Received: by 2002:a05:6820:c0db:10b0:6d9:f62c:2698 with SMTP id 006d021491bc7-71b392f5007mr22283631eaf.1.1795788447720;
        Fri, 27 Nov 2026 06:07:27 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd0776edsm6211739e87.73.2026.11.27.06.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 06:07:26 -0800 (PST)
Message-ID: <da7b034f-d1e5-4e37-bdf2-22364d5c045c@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:07:20 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/14] arm64: dts: qcom: Add initial Halliday dtsi
To: Stanislav Aleksandrov <lightofmysoul@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>,
        Stanley Jhu <stanleyjhu@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org
References: <20261125-halliday-dts-v3-0-5c8311c0b70b@gmail.com>
 <20261125-halliday-dts-v3-13-5c8311c0b70b@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261125-halliday-dts-v3-13-5c8311c0b70b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Qv1pw63E38WWrg4MaarMwxGao7Gw-qHm
X-Proofpoint-ORIG-GUID: Qv1pw63E38WWrg4MaarMwxGao7Gw-qHm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX0pOQ7AqQNzdD
 BN8fUNpcSOMH9n94wP2ZyVNdK3f4ZlIInFBc46RVOet2UjpwCNjFEUJdQIoLFVrt9ibBBjYvFtN
 iuOUxCkGEWm+GR/irWknHOS3nfevm+Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX48mm0fhSQ0Kn
 Ocu+FIOKoVGzwYX7xygeoB5h961p0G+XVJMkIftNfXMlQeTjHzg/EhlvFS7tG63oa8FvBVW1Yx/
 mZpPm7ZPDkI3QgChkzNlbSTiIF4D7Oig1URJX/49CXDXLaKPH/KTmYAhmMoJ33e9RjFyJLvtD4B
 JKBhFNpl1AB1ZX1roS6rUgGc/2T1Kj44Z2QXrlc5kkOkAOQ9ry8m90MikSu4dWT6SWqkkXRzSze
 aZMrf72wOU/LRY6iWF4z/bDPx6PvsxnDLM9EAmui9K3CxEnkBktrfW9QmlTKQkzwBHrvJv7OMez
 CXEYnWmeBpsjJ4fvz8Fxpvr8Ox2yM7/zuXlJkmPxvdUN+CE4+w3/LBkKsOwhMtusoJm4tf7QnDz
 IVMSj+jD+pqEhklHBPD/F4wkHjkl1FgylRybdyohMr6uAvLNPWxOAAmcJp5IaodOuGZDO3mEJkQ
 /qvIojN9flzheexW9Iw==
X-Authority-Analysis: v=2.4 cv=A875rKWG c=1 sm=1 tr=0 ts=6b098ea1 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=pIfNyjNAQl_vEFP8Sf4A:9 a=QEXdDO2ut3YA:10
 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270056

On 11/25/26 4:43 AM, Stanislav Aleksandrov wrote:
> Add the device tree for the Qualcomm Halliday SoC
> (SXR2250P / Snapdragon XR2+ Gen 2).
> 
> It describes the CPUs with their idle states, cpufreq and OPP tables,
> the GIC and the PDC, the timers, SCM, SMEM, RPMh with its clocks, power
> domains and interconnects, TLMM, GCC, SPMI, the apps SMMU, USB, UFS
> with ICE, TSENS with the thermal zones and the PMU.
> 
> Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
