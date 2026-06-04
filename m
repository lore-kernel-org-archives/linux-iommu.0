Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA0643637D
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577676; cv=none; b=fJb9InTcmnhn5GYo+kqZ2fL7GCAlhBTLZLwM9To8Kv2KVohXga2olyUjebycqSkwA1P1zl5gAovFlbyT9Sf4E+5+kn6gT0dREXxWFz4+Gn1kYwq1E2GwkJd2lpxjIl4KUGxZVFbS8Epy9WGIShPohR4nw7WIWWuSu9mNrZ+Kljo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577676; c=relaxed/simple;
	bh=OwWhwAotVQH3rsSdXQRsQBZTEa3eqgdHd5bY8AdLu44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=du3V0yOit7ATdyehO/You8fN/PVCBEwZ7eNdO1owSpopgF8nSdZQA+ZuEv2FEPXexKltGLJm/NLAb9QoTJ3nZaXDKWK1ADTdIedwVcwCqi9rrQtnr+laPcbRu6sy62ce+ky6NXluuQLwnvGuQAvkZKyMg8mz4Mdjh3Si+C9q23w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nydNX8LJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P/GIfo98; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nydNX8LJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P/GIfo98"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654BYxKh994674
	for <iommu@lists.linux.dev>; Thu, 4 Jun 2026 12:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=y1M+AD0HzgLHXiH1WXXCQCSg
	tLsSzH+qDPseKkIaoiE=; b=nydNX8LJLy0aABXqeGgQ/D/uwwN5k/oQ5EQpOyWA
	rHV0yg6xamAmp8Xiu7C/tWRX0AUPrPeVD5w2tzaJQ85lKH/jGZ3BOH4oD25DpxJU
	7xCkntxHLwbMQx0KDXdSeDVi6uPRq3ChwAzq3OAj8HcV7aNzQKipF/uFcHZt2um/
	1k5mguRhB2LaVYXGfhvv9jPK0C2Wi5L64R5wd/Bck+8FjsxCWT1wzjdi0MVF32SP
	dIvxb/7pLRmUjCZqOZKD56zUG9Y1IfTdVWUhSCcLh/lMf7d5Qo60Tu60lP6oH+st
	rmcwapviYznuh+b+4RgRwUU3uWEeszhkZHDtcFmMOza8DQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek374sky7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 12:54:34 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6751db2792dso345179137.3
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 05:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780577673; x=1781182473; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y1M+AD0HzgLHXiH1WXXCQCSgtLsSzH+qDPseKkIaoiE=;
        b=P/GIfo98rh604pAZ3m436c2Gn1O3IH7Q0fvuXJVKk5RWjYdAhmD6NeLtAIa7lvFCGl
         IYdvN+CET+vUcODKcoLm0aXOn7athm0I1yESlW/3dluiroOZ6YXJ8Y3badcQ7RehlaKB
         0tC/xs0s/fhfe0MoZUH+z4k0nWSXu6WRddv9A9g8EouV4T9Fa1tHuPBelipQ/sqdcFKm
         AMh5Qutqx/lq4pxAexqCXf0XF7RQykpdnryaTURAC//n1k0gR/8xuecbeRVaX7YAXCqA
         PulSCyvyR8mbz7TEvAuC/t00ppoyWIgTpeZpe+W14WZWYAfelSQ7aqLDytn9dV2kb0To
         Rxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780577673; x=1781182473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1M+AD0HzgLHXiH1WXXCQCSgtLsSzH+qDPseKkIaoiE=;
        b=hEZgTKRiRWU4x8g+3apJrY4NH2s6kNbeG4CQCTRN3s47+NQadxV+quCZ/GFB3Sie3v
         nL9+PPMzFg4+79SDXnHOqwb5yg93ESgm4kgz/T2fXJ3lcMs3Xn4GZCpIfINOJaUU2OBi
         RfLDJUQ5zb8GCdENdVfGfsS5lsdDMOLkPJObjZzND5n5bqBBjHHKpdBIP4E32Pcxti+P
         fhbn921872+uXHdZVCz5Sj7kDq7y2x4TH3Oz+ZEz19a9SSjKvgOs6BHvfkanHETqIyk7
         9+LuYJsIe/e+dM3oaJjofCZmYGME89uVuVl4nw2rUUV1+uWNnHSxbGrePCPWBJwmnlqJ
         h/AQ==
X-Forwarded-Encrypted: i=1; AFNElJ/iZKSCkWamkS1f8zek4tr/5+xO79ffzXJ6ykd4SU+jEiwJdGAxfQ6EcODnSsPIJ76PiiBQMA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw52ncVckMbB6xQG7m//p7b0WSEFQ9nKxCOIXsi9C4meTTsKSes
	5SUuNcN9qcB/zTuK/q5I6n0QaFwm431YHrIWA/dER/l4RgFvxGx5ZoZFAPMwl5zUJ/XV+FR5BkR
	dnxmw/Cyrz/PUFEU4JqJ5o5ltiTuqXZn75e/F6zJ+2SKw4SCxcOX8XYK4WA==
X-Gm-Gg: Acq92OHfseiVzcvoAAtiDaOeOZz0ji36LWy2UsOKxAqNaCRKBQkUq277TuSy/mk/XWM
	XBxuXAKrHMa9i758xtoPus2FB6pxVh0sBpO5oAvMoqKDz1crumSGdmO/mPKhYG/6pYMLZxeXh64
	SjUWik6/dLfOR4acsLFxNl/Xhq2tF+zaGnmZDTYaonO8YADdZiK1mDgufRYxTdzbptTeq8XfEzL
	gaFaeI33qyTvt+rMTTpajDca8c5dYMoUFBdj4cSKEngt67voudV9nl+Oy4H1n/M9REc34t1encH
	XVxbxlctCebCZ49BvCJJ9UfnD8WF/TZkUkd5jRmokIrgJJIaWBhv2k45QxGxqhN8q2wJBu9lCJn
	B+imFxpu9UDbWIHKc1MTXRv5nJUOdwb0vxiMbOaYBZShxjqp4b5AJOh+ok2QqZ3gRVMqQlRkyRD
	7rG1/iVutyeu3ruK5f2Kvp8hfHYQ9dglIBYVcewV4K23+Rnw==
X-Received: by 2002:a05:6102:554c:b0:6c3:1bcd:31dd with SMTP id ada2fe7eead31-6ec2a218ccemr4587370137.6.1780577673388;
        Thu, 04 Jun 2026 05:54:33 -0700 (PDT)
X-Received: by 2002:a05:6102:554c:b0:6c3:1bcd:31dd with SMTP id ada2fe7eead31-6ec2a218ccemr4587359137.6.1780577672874;
        Thu, 04 Jun 2026 05:54:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac2ed9eesm16343671fa.40.2026.06.04.05.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:54:31 -0700 (PDT)
Date: Thu, 4 Jun 2026 15:54:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] arm64: defconfig: Enable ILI7807S DSI panel driver
Message-ID: <wn2tfhmskrlf6ewusqt3uv7xg62fl6h2qz4qz5dyf2az3vumxd@dhphx5seowr5>
References: <20260604-shikra-display-v2-0-b3c1b2b67edc@oss.qualcomm.com>
 <20260604-shikra-display-v2-2-b3c1b2b67edc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604-shikra-display-v2-2-b3c1b2b67edc@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEyNCBTYWx0ZWRfX+hsJpDnfDkAj
 85CtxyX5T3YyaS9xNaLqB4rKazuYJw3dvIEb6ic1mWotx1rcfEjotYEDAOPBiHt923Edoz4IHva
 sSS4MekpIf2r5f5U9HYUkCW9lEHyB7/SVeyalvLGSu/CjwBn1Uxo+5zkBUDUpr74YCYFD+nf9Ql
 M1aEvY0Exx/5g0eV/VzqRU/9yKajCppR+SkWll8Rx/DDJ9IDJ2bm6rRjyTX3m9ZbbfMpe5p8Fr+
 Vgb91ZvOZ5SkKPVg44TdEzzVRCviRvR65Ib1yOOHEnRm0WrPtHlLUw3rjV0mzImyw/MmI1H6PQk
 dMTvKS1fKgGWMg/IjQ/P/iifBp6eObYchPhC7DN01rwFfqE4T45tpgBq6iokrjTzfAbR+yUX4pp
 +EZCmjrQY7hbWiQZVFNNGI/AIKGbX40IwQF8s5dUGFggymraIL3jAnrvHXD7NQncKZ17aIHRL3B
 7XTh6JCY9cfeN9c/5Kw==
X-Proofpoint-GUID: s9rjF0h1PXT6nG_x1W0lbPrwrHvRHoAc
X-Proofpoint-ORIG-GUID: s9rjF0h1PXT6nG_x1W0lbPrwrHvRHoAc
X-Authority-Analysis: v=2.4 cv=eJsjSnp1 c=1 sm=1 tr=0 ts=6a21758a cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=oNl6jLlcSFQHEdJXP8oA:9 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606040124

On Thu, Jun 04, 2026 at 06:00:48PM +0530, Nabige Aala wrote:
> Enable the ILI7807S 1080x1920 video-mode DSI panel driver as a module,
> used on the Shikra CQM EVK board.
> 
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 

Move it to the series adding corresponding panel driver.

-- 
With best wishes
Dmitry
