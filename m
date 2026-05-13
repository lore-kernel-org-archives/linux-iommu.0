Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90EA3A75A0
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 19:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778699279; cv=none; b=YuvuBfbXsXD4hjzcvGcehenG2cl5sKiVu6N6gWNhZ/Pl1/U0ndbqRmVDTM2heIYmMm6Px6WHP3+PzgBVCkJGuaQAdymXIELcXHTjHrAmUIgSS09MGPEgrlBuAO7Tij3Cl8dLWvbRVkcmqYP9ndVyHMRBT3t8ILLQnHLTKZWlNq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778699279; c=relaxed/simple;
	bh=rP5DMFJrroN5qwFkuBbgahMxhxpOb/p8Gem6JT5QYAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DH534cwZKcPgO8UxGSDx55FaNhu09FvT5QduAA1GtVSGxGhkZi6frE28+o0cvckK1pQnfiaULOo/abMI+mhodtJ+KK3vyA0SzapekylGHCg6JF12Pnw/BQHm2IGkJoZjtlWohspc1+WaRrRkq3B0BkjUxTPfRpedc8qfMiyrFW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dPl6PecK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ifbmwfmo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dPl6PecK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ifbmwfmo"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DIoMqR2965196
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 19:07:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/9qkEUAUseFc28c2cInwM3q7BXTfGwgQErHvPZw8/HM=; b=dPl6PecKBMqiBLpG
	MP6QcHNgD04r4Ws0rbnogeVB5TDymGe1ND+pLxzdwT3UZm35xL+mo/sCWpMyGTqb
	BY0zsY7epr7dmw98LCF5I0W/6Ij7jEFN/3LepYISW/TbIt/IbMUUfm0NmIIUXSEl
	z9EEqr6aV7jXNn18QYlxnt+kos6OSIHNGYCW635E4KcfJwbbGfyYMrFsmwmoyGrx
	87UzHzEwQgZB4zeb6+GLEdfGs+3TYsrsuwyhjALSh09so0SJplQfZrZY78p9LL8M
	qUKwCKpNW4zVJHAWk1tjqoL7E/tsQyIqh0fyMYZNhzEJi0SZCt0eu6hWkXLlVehB
	AunEDQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4ma5b0v3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 19:07:56 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-95d25cc8f5bso10186312241.3
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 12:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778699276; x=1779304076; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/9qkEUAUseFc28c2cInwM3q7BXTfGwgQErHvPZw8/HM=;
        b=IfbmwfmoSBAFA5HaiYZWkK8OcwFL0rkT6dxlH/5lnpwFqyA0hNszZ+WdJ8NBQEHjp2
         0j6HWcL+6cf9vI0GByBmSWYd270j9b7sY9lmDEQukdUdcuVRdQegusNrMxPBpDHhEQRb
         pJ/b3nX16nVjyzZyojLom1cwY01QB9at8u1TI/0rF1dmj4bxfG1WSFbjhMdKO1FgTEXF
         L7vw22M2GoxsrFp0/hcUoh2aS0R9f3vYAEv5khvtyVdLyZBeD2vRHOB6rcDLDNtzEtW9
         9JC9c2G9UoVC4Zbrd1hjfQKit1YLPtQxnEeKaqkdP9wLDigapkw4DCU1vRklKwoN3JGg
         gL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778699276; x=1779304076;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9qkEUAUseFc28c2cInwM3q7BXTfGwgQErHvPZw8/HM=;
        b=C8i2sCyt3kmsfA7s86gL8Cf5Mt80Eo1Uia//nbFlcYPdlsc9oIyYFSa3hjBHE3BTVw
         urTNhXCFbwnL+1KRWsH3HmalXknJ2a3tPg3p5Gd9WWW0HIQbBkWCNEKjHsm+hwoqp+ZT
         /eKPZJ4zM9n0a9V+1xyyIxdrcQ3d3UrppsuM3szOOJVX/Y2inuZFpgw3Glvvui0rpYiX
         YCC+58UWybKFgEHuekde3V+GHL/OJDCIrd3qzbMUpPOjYQI1CheCf0RSXG8u7Vrt0DTM
         KRDMeUQd4mXwbpVnzkZ01pM5kc1FUdWRLdwj+Pn5mw98HEjaEWrOXtnddxZLE2UYGeIN
         IHxw==
X-Forwarded-Encrypted: i=1; AFNElJ98+gl6Y3HXxSYHmt0GKTsc++kioGeS8cd3zSUgYAneuqhu3t/Cy4ttDZclNCWys1ovFF2tOA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywu3zKZlRpzsC5lnNRarTBsabzfC9Ii2ILAExZhAr6OLhpclDtR
	LDDorxGD1hRc0d9jJZLWEZ5dZdasQ/OB+ef4mkeQgpmmGlNU5zkHfqVcNsGqS5hYCyHR1AVq9dQ
	gSbf4n8ETMB8uyYQxcbdEqhtUsjN4PAPAQQFbIGcIobeVCKIVz+zNCwBjnA==
X-Gm-Gg: Acq92OE2w8K2JqU2in8tCJWwE7ttMch19khtWG+rEPI6f7zox9+PDqoZ/y5qEcsGPvB
	ZMevIxaAs4QhwhH/je5hBD+lXCVdzFgl/iOQdXBjmJ/xwg6/OqaumBzFbeRcGl6P61j51EyUmJz
	lAmrFf3fusiQ8BToB8lVBoNyPIRl9NRm5TCQ+lqska/nY0rpmPquCJvtwDQ8WvTupjVRURKmDuh
	vyVgOkDC0k+hlkVC88dsbHPLonTaC0rXDfo9E3znaQ+UDLQrKMhipDKapceYRuBA7pHYocvbTMr
	bOKE8oflaaYwkWIHvKOu5QMigpLV1HX+63R5kX94VxzfajtpUvuHqUhm7oMgJlzCk5A++U/FuMk
	pVaBpHhlR2wwDBndleu8RaVf9cFKTtSZunm+DCCM74l9h6lP6TB4i589nKuhMr8PnKTyv6x74Ao
	07jNkL5BjoImGmT5fusMGji1RrsOY6EsKzzWM=
X-Received: by 2002:a05:6102:549f:b0:635:420c:9b00 with SMTP id ada2fe7eead31-63773f151bamr2884976137.10.1778699275523;
        Wed, 13 May 2026 12:07:55 -0700 (PDT)
X-Received: by 2002:a05:6102:549f:b0:635:420c:9b00 with SMTP id ada2fe7eead31-63773f151bamr2884937137.10.1778699275067;
        Wed, 13 May 2026 12:07:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8b6b2e8d9sm3394683e87.51.2026.05.13.12.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 12:07:53 -0700 (PDT)
Date: Wed, 13 May 2026 22:07:52 +0300
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
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 04/14] dt-bindings: media: qcom,venus: Remove clock,
 power-domain, and iommus from common schema
Message-ID: <6xq6fchqaiaexdqygrbnjyyayavj5qbllufevkaodgayfq4qdt@tuc6qgci2et5>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-4-7fbb340c5dbd@oss.qualcomm.com>
 <35zfskmyogpazxy7wsw2jg36fvpnnc7hng23j4heq2jy5ookai@q7d2vl7nn7ck>
 <fc188af5-ec7e-bebb-2654-62312d79e60f@oss.qualcomm.com>
 <kdbo5d2wibjfnchfw7xn3wcgcp5r6ff7pw3ibkpbqzjgfhkovp@v4er4hdiytks>
 <f1fe6e8c-9a16-3103-fbe8-de772bc4728a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1fe6e8c-9a16-3103-fbe8-de772bc4728a@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4OSBTYWx0ZWRfX9WVwv1r6Qjm6
 OgnLfrTyk5WIsghqeQwiUo5xygh8eKg/5mHO/iwS6li3QNLmQFz89ueDTDCyubH1uc13kcQUMdo
 dlGmiwFg1gwV9KL9SOSc3MQ7ZVyPdOEWtDia+wV8q+DUiBn3w6KERed77SjxEv5ySrJ3PTpF2mj
 mJB97MxcGtENzONCGOqH8/FPUpO3ZjRs8AbbIkFv87Lb8VEgmpw8B67LC4BG/ZBK5XpfS6NdtBA
 jBdbLQUT5D+nnStu3zWWSY2ZUgS/ZDKdlujnTwAebqTTOvHwsTWpKszYASSuV85hH5CchLdKo2N
 tfi9S9+ASJ7XiI+GOoSebzZzNZAqwHGQSRNURRzBR5d9mdAVSwa2jclCOOIrf8RFYsod8vwLGHY
 1n8P6D5FkDVENUxMWnsWWh6o1f37nBJNyUqdqIcb6yrNCbciwStjTWLCGtNrYtAMCZJGUrw7tnR
 m/iRVJjOCkG3VnlSV8g==
X-Proofpoint-ORIG-GUID: EgLJedr1mQ6u-D-A2idqZxvNQDW1PSpk
X-Authority-Analysis: v=2.4 cv=TJZ1jVla c=1 sm=1 tr=0 ts=6a04cc0c cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=YeIv4oy5NbOGZ5o2UJYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: EgLJedr1mQ6u-D-A2idqZxvNQDW1PSpk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130189

On Thu, May 14, 2026 at 12:24:16AM +0530, Vishnu Reddy wrote:
> 
> On 5/13/2026 6:59 PM, Dmitry Baryshkov wrote:
> > On Sat, May 09, 2026 at 10:34:15PM +0530, Vishnu Reddy wrote:
> >> On 5/9/2026 12:52 AM, Dmitry Baryshkov wrote:
> >>> On Sat, May 09, 2026 at 12:29:53AM +0530, Vishnu Reddy wrote:
> >>>> The common schema defines minItems and maxItems for clocks, power-domains,
> >>>> and iommus. This suggests that the number of these resources can vary,
> >>>> while in reality they are fixed constraints per platform.
> >>> It really doesn't. It provides common definitions, while individual
> >>> platform schemas tighten those.
> >> If a new platform requires more resources than the current maxItems listed in
> >> the common-schema (e.g.,Glymur due to its dual vcodec core design), we need
> >> to keep bumping maxItems in the common schema every time a new platform exceeds
> >> the previous limit. That makes the common schema a moving target driven by
> >> platform specific.
> >>
> >> I am fine with increasing maxItems in the common schema instead of removing.
> >> I can set it to a reasonable value (for example, up to 20) so that it
> >> accommodates future platforms without frequent changes. Anyway, each platform
> >> schema must define fixed constraints, since clocks and power-domains are
> >> mandatory per platform.
> >>
> >> Could you please let me know which one you would prefer going forward?
> > Just touch venus-common when new platform requires bigger lists.
> 
> In the v3 series, I followed same approach — bumping maxItems in venus-common
> schema to accommodate the Glymur platform while keeping fixed constraints in
> the Glymur-specific schema:
> https://lore.kernel.org/all/20260428-glymur-v3-2-8f28930f47d3@oss.qualcomm.com/
> 
> I'm fine with bumping it only when a new platform requires it.
> However, I'd like to understand your preference a bit more:
> 
> Would you prefer setting it to a slightly larger value (e.g., ~20) upfront, so
> that it accommodates a few future platforms without needing frequent changes to
> the common schema?
> Or
> would you rather we bump it conservatively each time a new platform exceeds the
> current limit?
> 
> I'm fine with either way — just wanted to align on the preferred approach before
> the next revision.

The latter one is the most typical approach.

> 
> >>>> Remove these constraints from the common schema. Each platform specific
> >>>> schema already defines its own exact fixed constraints for these
> >>>> properties. Additionally, remove these from the required list and update
> >>>> all schemas that reference this common schema.
> >>>>
> >>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> >>>> @@ -64,10 +44,7 @@ properties:
> >>>>  
> >>>>  required:
> >>>>    - reg
> >>>> -  - clocks
> >>>> -  - clock-names
> >>>>    - interrupts
> >>>>    - memory-region
> >>>> -  - power-domains
> >>> Do we expect the platforms with Venus / Iris not having either clocks or
> >>> power domains.
> >> All Venus / Iris platforms have clocks and power-domains. These removed from here
> >> and added in each platform schema.
> > This is a sign that this is wrong.
> >
> >>>>  
> >>>>  additionalProperties: true
> >>>>
> >>>> -- 
> >>>> 2.34.1
> >>>>

-- 
With best wishes
Dmitry
