Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AABA30101F
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773091015; cv=none; b=REzUPhMfy6MNVVXY+mnuUbbOPRMzxqR/odlV4nkWvAc8zMHrBeogMPwx1+uazNfbcLL/VF8LtLjvltPCLCMbSosx1PFXeHYDM3Y93xYr8QnIpFbw47lOHBAb+a4Fv7kfDSHoJ0yExa35e273Je1XAsgm0PDmfjIdLoYv8r14w18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773091015; c=relaxed/simple;
	bh=9Vi9h/QCYvk5FMh7uKEmgwQ6HQwUbzQlnoVmcbt27Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aa7y20fhbWrc6ZHjvhx2msIR6C2w3OBDrK5sYNwQl4jVnVWU8yRYyxnD22RBQitW03VEJoIjsmW0z0HIPmIahnhHcTLPlkiZRMJAwOVSQYt42zcz3sReTk3Jze0BSJ3yN9Yc+LEta2r5KoZ1eg1gXq8DgUkj5QKN4ukt4lXIB1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eYrTi12b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q+0H3oBt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eYrTi12b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q+0H3oBt"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HC0Zg744355
	for <iommu@lists.linux.dev>; Mon, 9 Mar 2026 21:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KLgWRaioXqeIrwHgYBcxPqE/
	kg4Fe+2f2o7A+PfgTZw=; b=eYrTi12bsFRg+Ep63Gvyrpkz6qz+XZZnxJnhHzZ8
	Afqkljn6AGFqwUNG6Hi9uCb6ZzQda58iRJHt3K5YZu6fE5lb/rlDs3LPJDnuIy9X
	R2Y9ER606cwX+ZHgCY8VFLE+xAxUWo2O4Thd+KKh+iYlFQhrYQ0g6GO+JQptJ4KE
	6f0gsKaivSPOXL1lrK/xqQc3elp326ygArdomugL7e78pyCIveo8V0I+Gp/yH752
	qn3L1fJOi+1y8gGG02UGdrOgFKCLS1JmoihvFsIZX4/Br1ShuSsjy4BmL2Iv75+1
	0Iz/BPpRhzYykPy9UUlKCrzFisiTC2PnI1DfQMHXc4YBKg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cstsaagrh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 09 Mar 2026 21:16:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd77e5e187so1390005685a.1
        for <iommu@lists.linux.dev>; Mon, 09 Mar 2026 14:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773091012; x=1773695812; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KLgWRaioXqeIrwHgYBcxPqE/kg4Fe+2f2o7A+PfgTZw=;
        b=Q+0H3oBt1kCSy2kHTSfBkIPJgQ0+ZmYr3jSqIZ5iZJKQprylCWKLiVCnyblsRaOoWW
         nr67sJMj34bTH2Ox/8EEUZHTYzEEUOLRqkdsxkdND6GpTdN+rNkWM7aRDf1Yh70UOO+o
         OvqXS/IvlQ0ue8pZ9pr9m4dFtnHyRmMbHp+O1imK8lH9yRtLGVBZCpgTl3Zt3nP3WFV5
         Xcd7Rs6BLGnYptJ2rrWr/G55F29/I0qSR+wnRmknpVvC6jiHpA0mEpuAll7XGZ+SbVuX
         D8lgspXppBu+tPtQu0Z3mK7bheMVIllKvfqOGGuzh/AK98XPjd0wnf8A9U0hLCdFndIc
         /j7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773091012; x=1773695812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLgWRaioXqeIrwHgYBcxPqE/kg4Fe+2f2o7A+PfgTZw=;
        b=mx37K9ZqtGd28vejZzfPfTlQ7256ROGG9xVNoypQD+5D/I22SWpmT3lLn0jtrYw37F
         pb/aVahDqoFceal8Nw+Y3TibKhVjF8xkBeO7TN/81cHiV3FrVgX+nvYbdh4y4tYqer3e
         6y+/4XaOhY82Q3da4M1xQxTi5R4MtSBcm+EKwyp5oWfR+IXS5rnGdj23whkCbFyQKf7u
         l/YAG4mMOOB1dJp8fo1tJqbjzMfNqLen/3/hY2MzHaDYeRCgS8sWMsoxMaAhi4jC2WJV
         DMfm9DD/1/SzVBz5OcMG0KT1IMckMryhZVKf+kP8ZfL2QZwFfKm67Qyj3P/oB9apMipE
         //FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnSVZK8+A5M6evraRown4i3gmkZ/+27K07iyiWqieQxm9vYZ459QUeM8nxoMp4dKc08Zjavg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8GdV4g9n+59EgAR4Q9LO3KabGBcWiylxR8tamDE1PeiR9uLFa
	mPxdk0sBlf1AfnsHnHq/NAQSVwSBP2Ua/u1QAhxtZlX4Malq42ct0VClL+OpPAppmFonPeM6/fT
	xPQtX0qZgV/9dPgUuRx6y3gAGBPUCLVp4bw8sYTkDypw3/T3xMIi+Yg+PEg==
X-Gm-Gg: ATEYQzyHcCp87AjI+UJ5wO8dNazn1op+t018yUaVc1oPPjqqlskFpyVOyNqC35PqbpD
	3f0GGUenyRmj7jSOmUYlr+WsVxcVHrdVtYf3Jnbi9K5TP4RxYeZTTzMv9d1PvKfvPTPiFiIdRev
	liN2JzTKHHaxnTeRq3S/e1wfYAjO9D8ioUZdii3LNtNPnBZAJUEywZGIwSTGiMS1h7sv27afcMb
	J+Hx7dFnQIL9lZAl0S1yoWeyLYLVXai1JEDoO1R1mEB2Jjt2x3bNo/hfX58eptEyXdAK7yXg04A
	aSWGwRjKTvvJ6Wr7fyu4vwCLpgMoNXHzJ7tyRKrVOiDr+BtzRTriSo1XuOOPu+purO7w7wVyA9l
	1zgsT9hrOqfDNIx3bUNNa8QX76Ij02HziC/bbpc16a/FCUHjm6Sk2TdwZo6NK+vrdvizanKJIvE
	Uy7QMs3lQUwkO4UxJoFWjtj+cT3AaHvXWqxrQ=
X-Received: by 2002:a05:620a:2946:b0:8cb:3d7a:c009 with SMTP id af79cd13be357-8cd6d4b5029mr1566975485a.78.1773091012377;
        Mon, 09 Mar 2026 14:16:52 -0700 (PDT)
X-Received: by 2002:a05:620a:2946:b0:8cb:3d7a:c009 with SMTP id af79cd13be357-8cd6d4b5029mr1566971885a.78.1773091011890;
        Mon, 09 Mar 2026 14:16:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d01cbfasm2323612e87.14.2026.03.09.14.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:16:50 -0700 (PDT)
Date: Mon, 9 Mar 2026 23:16:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Cc: Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
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
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, imx@lists.linux.dev,
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v10 1/3] of: Add convenience wrappers for of_map_id()
Message-ID: <3plcdobbd6teiluzijzk33yepbpsur24tnmjr32sco7a4loptm@xmzmsaurvmvj>
References: <20260309-parse_iommu_cells-v10-0-c62fcaa5a1d8@oss.qualcomm.com>
 <20260309-parse_iommu_cells-v10-1-c62fcaa5a1d8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-parse_iommu_cells-v10-1-c62fcaa5a1d8@oss.qualcomm.com>
X-Proofpoint-GUID: l6yOGHDkvCNtGKKqwMWUnTdqfFqpsnUM
X-Authority-Analysis: v=2.4 cv=I+Vohdgg c=1 sm=1 tr=0 ts=69af38c5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=7CQSdrXTAAAA:8
 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=5ndfpk7zZlG9lj9R3R4A:9
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE4OCBTYWx0ZWRfXwryTIozGwML/
 vAVSWmryifpfCnkT91t3tOaYE5Bn701Zl4ZUwcgQ9/i28j2/HBGxShUt6LlQB5GMRb2cfUuQEWh
 rRqiCDbpZaVF+blWfQKPCMuFSwI9kL31DH/bsBUi9i763ULz6Mp5qDVRQcfyWbOj/V8jTXu8jiD
 5Gu1VCIxCuASlpUsR9/bMrxSAfiUVWwmB8aPvW3egvVth8OggM7NuHeLNcyYpUR011tXpQ4MlJO
 jcZdylR1b4aRgLAZNyGJQhM18glXn3OGAA8OI9QWg5CZYVRHM/xjPAUetH2KHaivsUPUXebmug2
 Ldw2TaCjsaLt8bjhNGXMn3jhrRHMFVU20FH1ORYEagCfh/iXGu8Yc5o0LVjzzl2LHz30nQpmNt2
 OzK7m0nz6CkObMyLDU3NuAwArQnH7vWIc28FxsNqueLv+gsDLtzZUNyy0rGtGK2h/GsVQPuYgIU
 EfcXhUAAwqh0FR2BQ4w==
X-Proofpoint-ORIG-GUID: l6yOGHDkvCNtGKKqwMWUnTdqfFqpsnUM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090188

On Mon, Mar 09, 2026 at 01:03:37AM +0530, Vijayanand Jitta wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> Since we now have quite a few users parsing "iommu-map" and "msi-map"
> properties, give them some wrappers to conveniently encapsulate the
> appropriate sets of property names. This will also make it easier to
> then change of_map_id() to correctly account for specifier cells.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> ---
>  drivers/cdx/cdx_msi.c                    |  3 +--
>  drivers/iommu/of_iommu.c                 |  4 +---
>  drivers/irqchip/irq-gic-its-msi-parent.c |  2 +-
>  drivers/of/base.c                        | 36 ++++++++++++++++++++++++++++++++
>  drivers/of/irq.c                         |  3 +--
>  drivers/pci/controller/dwc/pci-imx6.c    |  6 ++----
>  drivers/pci/controller/pcie-apple.c      |  3 +--
>  drivers/xen/grant-dma-ops.c              |  3 +--
>  include/linux/of.h                       | 18 ++++++++++++++++
>  9 files changed, 62 insertions(+), 16 deletions(-)
> 
> +
> +/**
> + * of_map_msi_id - Translate an ID using "msi-map" bindings.

Which ID are we talking about wrt. MSI interrupts?

> + * @np: root complex device node.
> + * @id: device ID to map.
> + * @target: optional pointer to a target device node.
> + * @id_out: optional pointer to receive the translated ID.
> + *
> + * Convenience wrapper around of_map_id() using "msi-map" and "msi-map-mask".
> + *
> + * Return: 0 on success or a standard error code on failure.
> + */
> +int of_map_msi_id(const struct device_node *np, u32 id,
> +		  struct device_node **target, u32 *id_out)
> +{
> +	return of_map_id(np, id, "msi-map", "msi-map-mask", target, id_out);
> +}
> +EXPORT_SYMBOL_GPL(of_map_msi_id);

-- 
With best wishes
Dmitry
