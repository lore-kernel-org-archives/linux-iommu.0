Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B172F8EAE
	for <iommu@lists.linux.dev>; Sun,  7 Jun 2026 21:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780869094; cv=none; b=sU6lNr9LWexJvYuekqXLM4utRYmfW6YZIJ9khZqTy3YyBiaCd3cI+lT6bUe0QkQvVIUEepb1MQg3ODymfAUxnj1rbdTE7fmWTC30j5WKC1CWS0HkaTfY0TBe3qaPZlILdlh5BI/Bb0zWw7YsLMxyU1UJWOrhi5+gTTh6USFcs80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780869094; c=relaxed/simple;
	bh=edLZ8uhQuKqBdIAaOjfP7+qTUTBXc0nm+ittUNfLiTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPfXq7LiziNBNEVK1fG0NHYiVf0tZUthfxz0RXlJxOKHpVI1lxdzrczpBlGjClOtRUzzZHReyBefWrrWmslfvla8fmTODpJIbMBbg56vQ7qDvbfzPdp6ntJTkyALZmbF1g6ltYg7L3LzpXOey4MqkQ+l9ArREv8Th55RZ8jwZWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IZqwIg8n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i4Z74lmw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IZqwIg8n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i4Z74lmw"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657El1uU827191
	for <iommu@lists.linux.dev>; Sun, 7 Jun 2026 21:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kL4uGyBdMmTU3mHM0gxMbXkp
	tGR//tYoNlap+YM2MTs=; b=IZqwIg8npnVkf8v8GvUXbVRgBP3Gkfx9uD3hbDoJ
	Retmir+wGFu39VogcCtFp3tEMXIi1F/GUcszVMMpXOwvI0cI7HGAUdaQ4XtC55Oh
	y1Vjq0qkk2Yfgs9/JuxVWNqXBWpoRgtJkjnTb67rJRlT/1rcQ3sEFe4D9/CkeZVa
	lpNcVjKK95P0YvhSPbx78/UHNBeIODeXdFqInNlBHcNDZ9YZmOsBjW0oI0upCrL+
	oPU95ujpa7TXhZA1ImkT6Ro/VMAxtwQPtOyeEQ5C7XnaPGNfuAC8MKM4TVw7Tr/T
	Qjd+egllB6ba6jdL07GK+jYqsgFHU7H3wil+2LljqfTEow==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embx6cs3h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 21:51:31 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6cfd2a26ab0so1543787137.2
        for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 14:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780869091; x=1781473891; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kL4uGyBdMmTU3mHM0gxMbXkptGR//tYoNlap+YM2MTs=;
        b=i4Z74lmwIMAbkFwsH2mpshL8VHwb2tQCycX2d8wdBVIEwADBT6udHiA9LMEjNnefdC
         icxQaLnKCtosOCJqON6+qmEsQArv5SCIjcoNhB2K2vZJ4UJm7AlXfTp/Z9NKPuTfOOiW
         U+4HoO9h0cgk1rqSMGKFuNRxbn77gYDuocM0ABY3kO5IEN+NAFCfv95+gXqDLOXntAR2
         L0FxKeQnuJT7gNbVgk9LO/5oLS2Pgeq7blXMLDXj/nKrWn+zgR7UF0sqoEDhpbX6hD+G
         HYqxfnnLIvzUopHX/jArRaNLiIuDn5YP28ViKzD58qiEUNB0PbrLG59aJaL0cygMa08F
         +0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780869091; x=1781473891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kL4uGyBdMmTU3mHM0gxMbXkptGR//tYoNlap+YM2MTs=;
        b=UZAM9KzcVSISAsNxjvDL+BK5tLeACeDXgH3ThXdpbNPn7frg+RgHq01C9UKo7poSdO
         TWUfTRgizDrkGmZNoWRQO1PkM4Mz64dSNue1i4YpuKTM3Y5TcndisovVlsDmWr6vyfld
         ogONOE35RgcnJ2bdhY2kYmqAewjPmyCjNh2+35xGVXObsoJpfHIkEcgkG8UMgWw0hjxq
         sR41vPXRgUFjrkZit94i1BF47eYW6Zz2dCMmtwpuo0dxg61vx+YKsrjEag6FtXuGumqf
         BkMRJDBOQbBkFvSj+RYZB2DiXvELpqT/XFmr58V0MY5hUjNCyPzmGjsoexkBc6v6gfJA
         zFWg==
X-Forwarded-Encrypted: i=1; AFNElJ/mlnOq2axHGm060BPdK6hQLsQo4sK6oSJXx0wDRjX5oKmCWIVqyoHQ+9Q/xOKSpkAFAy+dIA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxf9BpjDLOuRhSR062T2aIpRmoAJahGhkhYEwXeW9rm+GeOeZ2b
	KaGzEPqm1P20bpzG+EoZ2e75QkrLCav4a/VFCo1TqRb66g9tFOPOgErOIqhJe69VT2QfEE87EGy
	BotXIC/Aw2Kc+eH/uTWDvutjVXaiMa/wYD5U00qRkuZ9cAg67MJ8fY8fYag==
X-Gm-Gg: Acq92OE7N48YsGbbIvEEv8bEENNkwPdp+9LxqqLTl3joWQdXRKTRT4qvQbhQeOuyzwf
	I+gezBGaxPtfdE2ZITVLfZleeMVd3MH5LrrGRluVVQW9619GI6x0dS00S2Hc58ysEVb+p4cAnNj
	EE27yMPSLRIZLD/gvkV+htV6WrmgoPbl8bJ785NI4T6gl0oSGLEbs+EreD0teAvoj5ArTaaJFum
	ZXFqkeA0p3U+jMr664BXZvVuJTDbbFGmcGCj7ROu7y/lFQFVYbT7s9EPQ6mhJw2/uelMAB+2KBr
	4q3+niSIxk2NGDA0VMdlNcMgBFqKkHK1rFYAAbdmKWh8DOhonGojWD1cx0jUl0R9B5prBObEQ5a
	uEzrUiwywpi7Mld07d15Iq7M05xWJJ/ProYnDOdGvjYiVzMREk505U+Mvi2DtEEqZohDmjc1vAv
	LQ7597Ik/IlAeUt9L8VqDFw49bjEyZ+6jqnyuNE3nPcGluXQ==
X-Received: by 2002:a05:6122:32c6:b0:575:3b9e:db3e with SMTP id 71dfb90a1353d-5ac4ee8f0c8mr5682691e0c.1.1780869090940;
        Sun, 07 Jun 2026 14:51:30 -0700 (PDT)
X-Received: by 2002:a05:6122:32c6:b0:575:3b9e:db3e with SMTP id 71dfb90a1353d-5ac4ee8f0c8mr5682683e0c.1.1780869090547;
        Sun, 07 Jun 2026 14:51:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b985ed4sm3272128e87.55.2026.06.07.14.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 14:51:28 -0700 (PDT)
Date: Mon, 8 Jun 2026 00:51:25 +0300
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
Subject: Re: [PATCH v7 11/12] arm64: dts: qcom: glymur: Add iris video node
Message-ID: <wvja7ehdremygql3hdmvgoixi4p6j2ohb3rx4bwj42h2qpe47l@76yknh4en2q2>
References: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
 <20260603-glymur-v7-11-afaa55d11fe0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-glymur-v7-11-afaa55d11fe0@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=cvmrVV4i c=1 sm=1 tr=0 ts=6a25e7e3 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=xYufHl49NKEuV1FEiosA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDIxOSBTYWx0ZWRfX/69Kh0tLTuIO
 PTYSNV8CdU+nY70eJiMIAhCwsYwqBkB3Mq8+ojF2JNLX597ujoCmygNnKqf0WqIkkV851vPsxc3
 pl0Pc9CdBcDvkwh4gaB2bUe6ZUCU7Ygmbel6Q9aAgvMNFovEmLIeXC3V+JXxLsaeaAFPvjbwY3S
 2DgtpifOjoypX1wNR3z9oB/ZHM2ZtKDx+nqbwAQmwIwdfQe4Vy2NYQv7Wo6MO8SAtPkOxrKi0kv
 JKafnfHKb+4modxsValFNc4q7VojtziVVtCU1WEFvsJoF8tkE04h2NF2zOTJkv7rXGcUGY0Hc4D
 MRvVUNHSohFC8u2SU6/s1dbxfjOTjFgdsD7vL6qUeA4GmYwATOHUFYNNZBhM+07MXidlS5VOuAn
 Hmb216Qx7ChhXpPpL+Jk7YXNknJKV9tvrVMBTbfv60x625jU+NgKgvLbnJRNfLTpvsZ3VhjhBGX
 8ufyxTi8568EvZGCwLw==
X-Proofpoint-GUID: QZ8HCkrYl9zJkhMhKNptOlDknx-NYutr
X-Proofpoint-ORIG-GUID: QZ8HCkrYl9zJkhMhKNptOlDknx-NYutr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070219

On Wed, Jun 03, 2026 at 07:48:49PM +0530, Vishnu Reddy wrote:
> Add iris video codec to glymur SoC, which comes with significantly
> different powering up sequence than previous platforms, thus different
> clocks and resets.
> 
> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur.dtsi | 118 +++++++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
