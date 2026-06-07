Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D453D32BF44
	for <iommu@lists.linux.dev>; Sun,  7 Jun 2026 21:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780869114; cv=none; b=mndzdRf07eLksWIiLk0dhUFINZ8TciPXLpsC17KZ+2FeXnIyAws0Om/NLfCDbhFo1Nsl3xgrW5n/QvQ+ThVxjFCCEGoksxDy1qEaPtPno/yCP5kgLZh8buaUABO/7sgtC3//38mesnjHxrah6iQCzE+rVnap6zmysrax2i3qxKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780869114; c=relaxed/simple;
	bh=PJIHbeqTJsIe0PZwZEkydMC+Kjr73lehc/ylb/OIGBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXkup9Vq6wQ3q4gcfAs2usmziu9blXuydNEKbwHE9VCyIeCB+0bzjmyfwFptqeEUmHQZm+PP1cOM0BI9BiTjpDhnSksq4+QolL778n9kbMpf4suUQVfRxg2cS4Yci/6JG04h1HuWQD328L8dDLkMIWP/BATSyXk55nerO8wx6WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iFYQQzJ0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FeTtz7C9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iFYQQzJ0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FeTtz7C9"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657EkITh846044
	for <iommu@lists.linux.dev>; Sun, 7 Jun 2026 21:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rKDkQFtFQoRGgaiav3QWTOql
	+e2ZOVLUtvHFYymj/iY=; b=iFYQQzJ0q1l5Z3ghS2HW47KRQtbTEC3jmw/v2qB8
	YMcNMTP3ZPDsMAUQ1Zob4kt325WqrlRpiKEPgWtRM3YS73XSGj+TYTL6W/Mwi7EE
	VoeU2iO7mWYHtZjMkHCxCTUUHTt9GHAGASFnutanY2TRqNe45Zfwmupy+TMFDv4s
	EU4dOiI2+pmu8iR8hRlOs/pi+rWidkxF6kG5VoFe9qXHPAd1fI/K5KN/6hpV4ydx
	eNW416mGNWEUKN2xU0qzqFD/+Vj9ApabEJKk3pNwkM0f4Fz7JZcTVSqv9UsWIHPs
	MGWGbr70AYCFefBRXIIYR1bD7ccuNiiz4hKXJWUbTk9Apw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em9k3n81p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 21:51:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5176d949c58so98073621cf.0
        for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 14:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780869112; x=1781473912; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rKDkQFtFQoRGgaiav3QWTOql+e2ZOVLUtvHFYymj/iY=;
        b=FeTtz7C9YpiwsGtJBSBpRUq86PYpagGCN5HwzzG6BK2GYckQwjX1LRreO3UPutfB8x
         9bGFKVooidq65mFi9pcO2I862770Qs9zhPv7yXP6KN5l1bvrIRE5juLErbZGxiZHd3mM
         NAQH+IMD8TLfWxAEOpVgbMHy76oxjXVGwPdpeO3Fzjvo048BvsPJ/KWG79+5nTrVkjZD
         R51aoCMqu18RPhJY1Fqz8UvI7S+ku039vOBytXfzwzDwpzENisPJNkMAUyH4FLYxe6FQ
         Cw25bTvXxa5nfFrDCWH2kx+Jqn9q+euIybUs/UzDPovgwspwsY7YngZYyQq+gxgMpNSV
         euPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780869112; x=1781473912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKDkQFtFQoRGgaiav3QWTOql+e2ZOVLUtvHFYymj/iY=;
        b=Q7Jv3NFvv6vpnB4+HkxNbGdWFSGPYGy/NnqHdp4qmNoP+ET7VWtmsi1FzcmF+WDi98
         Hm7fdAAN5+4CfLEbxUnMUifKvGnPB2O4PQcaDk6ovf4mDCTDs1autPyAmsqyd8NWZ0QQ
         C0LMrbvTht2U6ym1dvRZoYEZV+VHRLsD9ttZRnwwEYxPsp+1fQ9WiBFBcg1RfQCy3RUi
         BRPqkn8esATYxS99lOII5nU9W1kWKVgDfzNrQogpx9MckGprYuJea6MvvE0//IVbzU81
         sDXsIukwwj3oXakRNfLKYHPftTwgJuJE0lvOKmS86GWY7NQRGyIivYM2bGaRb5lFsiBO
         iXIw==
X-Forwarded-Encrypted: i=1; AFNElJ8OquZS0WkkBdfQSIqqoGoA89zd9fwR5ruVelYQfnWdL5t/ljp9dGouxqyLsCEwCa5jr1nxFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpLOY7hVld8Y8C6b532FAK88rh5Y6NHvwc9RB9fiJnxRs/hwPa
	OTUWxajLvO1NWkQOk2mfsF4JnzM5TD0RWuLazS0C7aINAquxxOMJL4S2nnNySCUFwoMLkeVg2q8
	wifKQ2X1FI+mZogideg9BOTvXaY7wugmN57z6pwQE/QmbqrPQrmLKnggn7w==
X-Gm-Gg: Acq92OEJ0Dow7CiQ8bjdSshcPzG8xj7HVpJL4t2MHDGFVIpENWQjqesmd6ntRfeW6l4
	LXVVN6dKUNAnn6GY0x7XAs1o5FmTkA1n/uHZ08Bf1oq9Rz0/piJ1z2tGfIkP/HAjmzT0Oynuvxq
	L1Ge0IwrhhX62OanyNBfVZ7BGgyOlmQbSmd6PRCpPjAxHJQaMsy6aJS78tz4MRAvcuEfSIuaz1i
	ezLi7QKr6vg+pJKuDNQc2o8/BNdF/EK0eQlAvf5qJy5R4XbOYJ6qM4F8rKAW4bOckf0p+x4TBel
	l2q8+AjCFnvAWt7njexZNsIDoRviVDeq/3zsV/xdAjq/I0oekHWkJXoQJL2eSDdNVU3kb0bvS52
	v/YoK7DUMHWEoJkUYFVb22PeHKiaa98gc+46co9TqfgnHbqhPEUNT4+WZ0UM9H93gksVIpegq4N
	9jVNDQwxpxrLYWzsrkxP2MLpBmOd6JUISF1wF/VhcDlA5XbQ==
X-Received: by 2002:a05:622a:251b:b0:50d:e471:2d1e with SMTP id d75a77b69052e-51795afe590mr192005011cf.35.1780869112109;
        Sun, 07 Jun 2026 14:51:52 -0700 (PDT)
X-Received: by 2002:a05:622a:251b:b0:50d:e471:2d1e with SMTP id d75a77b69052e-51795afe590mr192004861cf.35.1780869111756;
        Sun, 07 Jun 2026 14:51:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac2d6282sm41201931fa.30.2026.06.07.14.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 14:51:49 -0700 (PDT)
Date: Mon, 8 Jun 2026 00:51:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 12/12] arm64: dts: qcom: glymur-crd: Enable iris video
 codec node
Message-ID: <mjmfhowcfc4vc4h4fbpf2psblnhgbwwt5qmmfb2fnkfaunexyl@c5rwjftmnlx4>
References: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
 <20260603-glymur-v7-12-afaa55d11fe0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-glymur-v7-12-afaa55d11fe0@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDIxOSBTYWx0ZWRfX1p782ald3N9j
 XUWLyf0ExM+IkjvmXjwvOR1lqV53Hn2cosgt1nuh0Rx6jt8jv8+GXqX93hXkvQxjSHa+rgHW0Ld
 4t/o8eso5bIk4mqffWxxqImV+T92p9HmrZa8hAxUfhJzb9+eenRHVQfJd2qE12yTqLWzq6WtV9P
 mSm+PEjFDiqUMlnKctbQSHiKZFRiDwocZVti6mOpbKcfroujVIt1fdUho70sPRUZRGtaJ2+AB0F
 3nWFWvokBBcqAcZfWm5jWhKLrx9bmGGSW85YkKOR2XfvTQ5pTlFumHWPmDUGfAftwQ/4kxml3sJ
 msXT3Vt/1MAlWNRF09jnQL+z9Xcx+b7QTYP7dTOy4XKC4RVuxQgE0L40mz3v0/WrEGgp2MBKtWn
 WVC7qfZ5o7aFhkdA+TZ7O4/wBbOPFDDO9Ckm4yNgRKmzVZmlU4oncfLTFjsMadCv29T7f7uih8b
 3JhoQySTzWbPprvlzMw==
X-Proofpoint-ORIG-GUID: gr9il1klVkxbe7auo2mrXYmCw8fljeZ6
X-Proofpoint-GUID: gr9il1klVkxbe7auo2mrXYmCw8fljeZ6
X-Authority-Analysis: v=2.4 cv=TIB1jVla c=1 sm=1 tr=0 ts=6a25e7f8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=MCItce8SuK6p_Dj8i7MA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070219

On Wed, Jun 03, 2026 at 07:48:50PM +0530, Vishnu Reddy wrote:
> The iris hardware block is described in the glymur SoC DTSI, and enabling
> it here allows the media iris driver to probe and use the video codec
> functionality.
> 
> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur-crd.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
