Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C713D3CCFD2
	for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781177544; cv=none; b=My2bJCh1UFKIq7ggqVVlLw84GxHL7FCCJEN6BG1yHCFIUGLdXt/i8xcyivQNzlJLKqX3QNwIq4Qe59z8HjdNjaukudO7vYHQAAtkALqezjl1LhdHjGk7uCqnIxNvTU3jn7GjIHwBE17ZpbW6DV6AwFjeBLSdCrL+pi5iRG/K+8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781177544; c=relaxed/simple;
	bh=0StIhegVocrr0UB01yU+UcOspZ1FBVgbSkPGYjz3Acs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VneW/AzxbiD1NnHPM7zVsJcYGEb2TOiapsHNdjN9yQu5oc71MqCQ/mLEwTtSOJmUqgpLeQryuMsAEhqmO8iv3zevMzKp8OdIJaVlneHKMD8W7idRCr/vC3GCz+Cg69z5nr0YJUdya2NEJ0WcR/wHjh3IPxFOKLJpNoksMHCWkUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YKmGp2w4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T520GXhl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YKmGp2w4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T520GXhl"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B9xJ7K2890244
	for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 11:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yLBwXK7+oD6+XlBvQMPqJDwpfaAh9nMZFyst4JItm4k=; b=YKmGp2w4Uw9sd1Lv
	n2/3v+0Fvg+ZGtp4HTspljqxGNIj9yWFgrPQFEJ8L1HtgcHfEFzcoHO7RWeqJfB7
	p/SavtBwi/Aw6c3XmHPakqA9zb4wXeTQbm8P8nYzdLjckTD9F3qRmTrIR7wvLh62
	/+nV0ddbYvknnbcX7Mt0lKLT2nYfyhoRdg8sNdBOP2FJ8KineipZeIE0Xd5rQ5Nt
	1cEpcMoBvrPdKLg/Ml9jotWen3SSuIdKSpTNhA2qZfmwPiL7v7s6jUg++lSS1mqM
	jqVNVnQXFfaf/OGMCxj/LHjL/nJcfNTIzLZbSEDwck1vR/gx6x3pg76ISaqBo9ip
	GRez7w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe79k49g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 11:32:21 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5176ff55dc2so13766151cf.2
        for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 04:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781177541; x=1781782341; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yLBwXK7+oD6+XlBvQMPqJDwpfaAh9nMZFyst4JItm4k=;
        b=T520GXhlVTuCJYSmwkp1f4hB4dlnC8G5HSkLxUoD7b15AyMoqt4c1RZy+DOxu5mUsM
         3tTWQzyf0Xey3hO3XDDrXiIDXoVOyEkaC7+lpJD4/aOOiYcF97qNWiN1FLD0p57tSlbX
         hbfBq3XvE8EtMoC/7gbKLGcq/I/Uow9T9O7U6GR9MBNC7REShH1Z9qeKAKqDjWdIndRk
         may7nkeE/0p//L5pgHaSxwwoOxzcmZkUFcINru9FwpNLZWOsb94riHhN4w1a3gcH+xIo
         aIJ9yQJEb5dT+0nJia4IGZgmRuFra+qI+i5+Hc7FY7RC3FG6B+1lfTM17HYRR/lPeXbS
         LrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781177541; x=1781782341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLBwXK7+oD6+XlBvQMPqJDwpfaAh9nMZFyst4JItm4k=;
        b=j23cpROLSjQGJOprJ+iQnSBJ73GWnsrYiVJaPq6CAR9ezsr8OiMat/J4wqt2vdOb8q
         UTwJdD9UWsCsxgUbx6NfyBG+EsifLmAO4zrPu9TG152Zx6MhClxA/qKkkH6fkV4Y0uZD
         /i25KOawQtZY2uyuYNtPJ9Nu64RinRVObCxoHg2Hna0iNK92UobKAbxXFDRQghlE1OXQ
         ca4uydqSHBc8UD3HXXgtKM2IPAKs8oJ1l7LsuIJA7MuQsxAoC95ErOpYU8CoIclDqZmO
         euDbF8524KPbuNNB/sQsu72OpYqtYl8/X6dSFNQifFZuPfE0YDQAjK2vyCzf4k7eRmY6
         wfvw==
X-Forwarded-Encrypted: i=1; AFNElJ8hWEH8wI7GdUOj1RhfhBfkeXL5LmHrQpZxIdcP6wE2x8ragwTgTlsbWL3SEeRFCv8uORtboA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKJrZtT9vpukW07NfukEQmbHXMSmSOVKArJeaMZmunvVR9Wfbf
	ENAYJEd2xoe++Jo9ziEaVP9VG2FKuKa5UhJhSshj4GIai5Ht2fKAQZPVWHovjUUVKMUjxWEApKO
	2/rA/k6L6AVMsMLJXvzOnOmjFs2+7HaWMY1UkNpGcKinc5axySM2SDqCJ4A==
X-Gm-Gg: Acq92OGmuToLlOzmQjwNg1HstL0FLKzMCCMyiUQogrXLnD+01+xizUvrZRYNHxhKXFo
	EdcwqgHjenr0byvwokizVBcb3xFHt6CeexZLQuiruRnn3kMpDjdbeDk1j8C4EzudByDEDDoKwxV
	fCk/BIvSUpZ2AFogwJi4LGbtDSgnqykpwFuchtzAZoMx9DZB7RmB53wMIH2mi1tAOGa2YOCd9IB
	Jk8vbdnX+Cj6OTMizRVpjg2FbfnO257CtHq/rTdkugx4PebddRL8VLm1PdDq+cJP3+5z3u8SbxZ
	Ni4VLElZZfuWi+NEaYy8oO6014dzmmrDZe1YED1efXla9oAPUWGsrdoFf/YKbMMUNs09jaloCtQ
	t0FQWeZKlcFbjYv/WA23ff813+dcinu+RiVQNbj1h12C+ApG7EuZYwNx+
X-Received: by 2002:a05:622a:1f18:b0:50b:2875:5782 with SMTP id d75a77b69052e-517ee2375f4mr20213911cf.6.1781177540998;
        Thu, 11 Jun 2026 04:32:20 -0700 (PDT)
X-Received: by 2002:a05:622a:1f18:b0:50b:2875:5782 with SMTP id d75a77b69052e-517ee2375f4mr20213461cf.6.1781177540438;
        Thu, 11 Jun 2026 04:32:20 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfcb0f14cbdsm52606966b.2.2026.06.11.04.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 04:32:19 -0700 (PDT)
Message-ID: <b6fd22ee-a063-4af7-b21a-5f6268c65b07@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 13:32:16 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] pinctrl: qcom: Register functions before enabling
 pinctrl
To: contact@alex-min.fr, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Guru Das Srinagesh
 <linux@gurudas.dev>,
        Linus Walleij <linusw@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        iommu@lists.linux.dev, phone-devel@vger.kernel.org
References: <20260519-mainline-send-v1-sending-v3-0-3dd7aa125353@alex-min.fr>
 <20260519-mainline-send-v1-sending-v3-3-3dd7aa125353@alex-min.fr>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260519-mainline-send-v1-sending-v3-3-3dd7aa125353@alex-min.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: T1-BCDc14qzrGelOdCeRRJ6MehuVxgN9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExNSBTYWx0ZWRfXyps7lv8Gs9u8
 77i3zXFttE68NeV1xkfrIaK2y8cixZslCGq6Y4fG0Z2nPDmfAPNkBLc9uwRI/XaluAagT4Ko0gX
 rGQix2mIRhWhXzdTQTUAQaegqwrXduVgqXacOoEjpN2diU3+MJh7ZutG3yKPBzOeEijyWYc92iC
 S0FiDh3RrfNBVzvKH9qcvTSk/Jeqt80HRrT0ylu4uRhDmLr2Is0CnDVZv0n2izuqMN7mXINZN95
 1dIvpjSD8vyfOx8vvOiqTfRo6iQbJe5D6epjxGY41op9TFWGjAwqr96F5y1P7/qV7GkMk5qL72m
 2fjjIoMNBSQSdsdy/qT2xcPYHDLGjeaWtMRZnkPlIyXRxkgg1DZk02LZy+qP4X1nu4eCVXTf5k9
 yByVBaU35v3Qw7xlPE1XJyxlfQ0dGuZA2EsqH8/UJsfl038Ey/nycIK18hrFFCeCO1J4l+45C1f
 5tTIM3tLUMvvb1dNdxQ==
X-Proofpoint-GUID: T1-BCDc14qzrGelOdCeRRJ6MehuVxgN9
X-Authority-Analysis: v=2.4 cv=fbydDUQF c=1 sm=1 tr=0 ts=6a2a9cc5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=lq5VANsAAuRygiiSL6QA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExNSBTYWx0ZWRfX6KElQZTunIu8
 E5d7BnM9Ld/oAIRPdk6nJ5Guw+S+7arREtWnJqOS3Sv1swqC0+HPaUq/4PStRXizO49BmNuZF1K
 U3rZl3eZG53oGjsGj6W4bSYBByAmKJc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110115

On 5/19/26 9:16 AM, Alexandre MINETTE via B4 Relay wrote:
> From: Alexandre MINETTE <contact@alex-min.fr>
> 
> pinctrl consumers can request states while the pinctrl core enables the
> controller. On Qualcomm pinctrl drivers this can happen before the SoC
> function list has been registered, which leaves the function table
> incomplete during state lookup.
> 
> On APQ8064 this can fail while claiming pinctrl hogs:
> 
>    apq8064-pinctrl 800000.pinctrl: invalid function ps_hold in map table
>    apq8064-pinctrl 800000.pinctrl: error claiming hogs: -22
>    apq8064-pinctrl 800000.pinctrl: could not claim hogs: -22
> 
> Register Qualcomm pinctrl with devm_pinctrl_register_and_init(), add the
> SoC pin functions, and only then enable the pinctrl device.
> 
> Signed-off-by: Alexandre MINETTE <contact@alex-min.fr>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
