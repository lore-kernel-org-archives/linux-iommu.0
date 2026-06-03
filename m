Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918343D331C
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489767; cv=none; b=pdJdZUHnR815eQa3X+bg1b1RnTqlADsjJrEmYyP1zIQwEZb0o/LVmYu+VG6YRG1/ZmaJACo/hq26R8x5xL28W7HkBSDxU3KFrnbyECqaBEue/RITI52TfzVa9FeLYfC87+qTejYolF6V2xwzFApXmxEz/Fuv/0hFaC+J7VgsQP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489767; c=relaxed/simple;
	bh=YMiHS7/GWiUf2GISl0uQrQVtiU37t172Bh0fR91tIQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFzQksuUz2WtM9S0v/R2dtiHf/kvGcEBUlarEMQo/oPjauj2HDgc2Q8S9B4HF3T4LuUWuvh+T19ZW2AE144vYrJepVayhvI9PvWr4FfOL3Fk9Ej61aNj1tBOzhBKAPEeu6nqTYi8YhG8Xs92yNmXrcSz9bKBWDhOneqy47CbEiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=onqXhhsv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DwEgU/vT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="onqXhhsv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DwEgU/vT"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536RR9Z873897
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 12:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hMVk5w7oqbwOYmWzM+P1isNL2MH+1xWEAtw1PbLIu5k=; b=onqXhhsvHEFM3HWw
	klqBCjujNpHOAxiBAz3lOekrKdUWlpZCX63ui863WkH9Hb1M7/9MHQhvYud1fdIe
	EgWNFWRky8+f9bvFo4EJIhxkV06mCcDyhaI4hvwY9sJtqeGXqMpOb7EupJX3/Ydy
	gutLLmjCK29oBYSaoCHx+tD+81aGYPHBwBlB3havGfh0KVPszovtB5sG/8wfj1eg
	Q7D63DJxomJvO7Zi4S/A5ynmnTuqE4H4errGdBPlbeDk7W/ya33tJVViM72f6IpI
	LwZo9C0MM/sepb+9WTmk92+SC4xllUgc+ujq5zCo20J1fxpm7y2tpRZhp1ZO2i1a
	h2GVdQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ej6a9kdw7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 12:29:24 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6e989ee116aso236556137.0
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 05:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780489764; x=1781094564; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hMVk5w7oqbwOYmWzM+P1isNL2MH+1xWEAtw1PbLIu5k=;
        b=DwEgU/vTyJQry/49MrsmSf3+S23qfuFZ+0Ad6qtgxf3bwLKNv1wmOSD0yihh5+6/st
         ls1jpGHA+sJMb5KbL3bLhPOEwXmDcmwZ6E8+N/iINAarZkcR6rt8sJLB1nAZ8Yy2x2jo
         OBCskvDnH5AhrRZcvG67ViBO2iIepv4K5obuuLPe8GRsBZG7WTq3S+48CTZCi9DPQqtk
         7Yj9xZyDu8Ixogq58ekSaPNenzcQCgM41HngAxOXe/MgZ2Oqo8SQGpypOFZl9Ke9EI29
         gALvq4mskH4x5ibVmHJOWJ45Xrt2zueuRu/GT/JOufYxEXJV8TSYrmz/5AGc1+EuIRQa
         MaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780489764; x=1781094564;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMVk5w7oqbwOYmWzM+P1isNL2MH+1xWEAtw1PbLIu5k=;
        b=WbQze3BTnTARJ6KLXarGu15EFsqaX8Hyl6IApTDoAnp+xmUY1Zp8ul7pzjAosZFgpZ
         CV5J+IAEg6PqyJsLh7proqFA1Dx+ToZTUAEx+wrJf5ksKKka75ZLAOGG/NZ8FTliLHhj
         Xb/VkthfiTHmyPcuC8RTQu96cYBDf86t/rE9N54kN2q7kCIR9esqLDwodQj+2CmNZDJR
         o5AAiSGXIqAQ7vI05DPgHgwQrpSgPMgbt8QVPAbW8V1Pzc8IroTC44oMNrQix02tTQ5Z
         CZ6io247znuISPgGbFKfcELRLKxJ2RgY2VZzXkSXO06XIh4xZ947U+B71IfnX/ytMNN7
         9llQ==
X-Forwarded-Encrypted: i=1; AFNElJ8I5OU9519x00yIz+VhOwv0F0PRxrVGYLS8UDFIlm80Y+jOsxO78ZVZcbDephxdKrDfd3MnqQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyF4/4ZADrGRY6mk8es9OZ+DSrcHw+wsui02zzLZJzexFVY0bUr
	+p8Tt/jSwRh9Y35iZ5xE5bGMsDnXFnkpUZd1PyA+6WI32y+5j5ALX8KPjv7UhBN8yUS9C3X49nR
	DGMFymgjhlSdkmWHmXAVMrRRW5F9kA0G4/0Hr/zt8UKp7D7M4eLg9a5zGgQ==
X-Gm-Gg: Acq92OEwH5EHvTSkdojpXiP+51h/mrR3Zfwps5ua99iy/L4+J0c9Ls93UvhOvFTVrw6
	9md58wff+rpcZnGCa8ZwADGOY3xlm3DNT5NxgCfce07bbJoyaKt2WXJf0UfxiNWA2D62EAF+8IX
	Km+V0X9Ir0/71SKRqJdY1tuYA4xQJfdHXo6wZ3X5qN2BsuCJOBQ+n2PiKfAqAjCRhfvYQjX4MI4
	gpuvJ9JtzlIc+0iIHXZ960XgayjLkzumgBpNgmX7rQOeQwy85VU4OIbICxzdymW+PMydM57hhgX
	y3w2wSs86rvn8e0A/yndKiWu1RnAf07vYFUHYZRuDT0YQgZMKwWx8iEVuGzYcLLUUa0Evc5RJ4Y
	HTjhUA8o/UgLiJm8Rsdl+W1mizkSUiaJj+d46Dr2G0bOeIF6ZYvaUTEo0bjL23fnKhPqUk/dzY/
	4d/6h8gRnNOVf2OIaDricSwmF386UrV7DA+1+2q6KHh+46kQ==
X-Received: by 2002:a05:6102:5812:b0:632:29a5:2b28 with SMTP id ada2fe7eead31-6ec2b17b508mr1292410137.6.1780489763591;
        Wed, 03 Jun 2026 05:29:23 -0700 (PDT)
X-Received: by 2002:a05:6102:5812:b0:632:29a5:2b28 with SMTP id ada2fe7eead31-6ec2b17b508mr1292387137.6.1780489763242;
        Wed, 03 Jun 2026 05:29:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b99c11csm620669e87.78.2026.06.03.05.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 05:29:22 -0700 (PDT)
Date: Wed, 3 Jun 2026 15:29:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: MINETTE Alexandre <contact@alex-min.fr>
Cc: David Heidelberg <david@ixit.cz>, Linus Walleij <linusw@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        iommu@lists.linux.dev, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 3/8] pinctrl: qcom: Register functions before enabling
 pinctrl
Message-ID: <thj65jrvef3z3dmn5f52jplewrjgklomc5s32grktsjejs72sw@npk26yx2hpf7>
References: <20260519-mainline-send-v1-sending-v3-0-3dd7aa125353@alex-min.fr>
 <20260519-mainline-send-v1-sending-v3-3-3dd7aa125353@alex-min.fr>
 <CAD++jLm=BxHsPJ4rgqwY8SvaefZUO+Pfv8E8xizqPsdJZw5weA@mail.gmail.com>
 <298550eb-1bdf-4d7c-8111-8b8f0b5dc056@app.fastmail.com>
 <4b797a3f-01c9-4b02-be98-7b82099c2e0e@ixit.cz>
 <48cfedcb-a9f5-402e-9973-f5c175fd2740@app.fastmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48cfedcb-a9f5-402e-9973-f5c175fd2740@app.fastmail.com>
X-Proofpoint-GUID: Xg9fOffRNO8taVZ-qslkBAcO27Bz3CHW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDExOSBTYWx0ZWRfX5EhQrukiQKFC
 Fw/bU1YBSonVjsKRL/NADHn3aaqpw1y7svMJTrLiMr/vO3u2faCBo0vCIRqFYEdetzW1vEgS93T
 hudgXMtOBDVJTb4PrGjF0HDmdZFcgHzGf6rvpYEN2+HyoBQ9HQ60q2FlxINCTJXctuqboqnvbfb
 7KdDeWrfmrrfqATAli5Clmc0xrhCdlD7YAJtxSGbJULjKiQoyfMRnnSuyVcbF79BvcddyHG8myM
 PS66hKAlF+7cob7NmjUI+LLsXLH3HyW8swKAM50+8HcsXWHRXfBPLA2vT+/PyorFATVJt3ciClD
 YMYsxpw6Cv8XvlaWsjMzLULUkO1mzMQjrmfBOtJw052tb0tj/IN+ku7mbIw3UU3tqaAv1y2v0Cc
 rsw7OeiPT+PR7el42FkWw9U/7mOKmnSl8xfDFOmjnVjrm4Sn/MRcSaR1wSTC92bjqWQTjk0HO5n
 BvuenJm+1G3Ows6d4UQ==
X-Authority-Analysis: v=2.4 cv=I/9Vgtgg c=1 sm=1 tr=0 ts=6a201e24 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=JV3oGrjsAGRtxPpt7K8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: Xg9fOffRNO8taVZ-qslkBAcO27Bz3CHW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030119

On Wed, Jun 03, 2026 at 10:58:24AM +0200, MINETTE Alexandre wrote:
> Thanks David.
> 
> I initially considered adding a Fixes: tag, but I do not have a commit I
> can point to. This looks like a latent ordering issue in the
> Qualcomm pinctrl probe path and could have happened at any time until now. 
> 
> The failure became visible on APQ8064 boards such as this jflte, and I also
> have a report that the same change helps flo/deb, but I do not want to
> add a misleading Fixes tag as we don't really know which commit really triggered the race condition.

But there are no gpio-hogs on Nexus7/flo. 

> -- 
>   MINETTE Alexandre
>   contact@alex-min.fr
> 
> Mar 19 mai 2026, à 23:03, David Heidelberg a écrit :
> > On 19/05/2026 10:48, MINETTE Alexandre wrote:
> >> Thanks a lot Linus!
> >> 
> >> This patch is required for my Samsung Galaxy S4 GT-I9505 to boot but I also
> >> have confirmation from another contributor that the same pinctrl patch
> >> helped boot the ASUS Nexus 7 (2013), codenamed flo, which is also based
> >> on APQ8064.
> >> 
> >
> > Hello Alex,
> >
> > if what you wrote about asus-flo/deb is true, then this patch should have 
> > `Fixes: ` tag, as I remember it was booting with few limited patches ~5 years 
> > back then (only one serious was hack for proper clock bringup).
> >
> > David
> >
> > -- 
> > David Heidelberg

-- 
With best wishes
Dmitry
