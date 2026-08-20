Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D01385D6E
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 07:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787212029; cv=none; b=M6elshIJrPP5tgTyHOQ5B6LiyrrRjUd3Ypb53W2U9jINk9tN0WberyJIO1irmtyoO/UxEN7+mEgS4Yi4Ff4+550++1oDBo8KvwSqWMUl/mGfF3ZEd+XjE5SsvHNW+nHlLiWs+wtVIJgF+S2mVGyGxXy/v3ryuu+Y5+FsLKypj0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787212029; c=relaxed/simple;
	bh=iR4tB0fiVZKGoE4zYBYm9nHM8yujg8vehtjMdIX+LeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UziVV9M5ofyuL16LahWWsZLosJiMFgv2bPDcMmlkftzCf5Ko0s31eu4A2OnwVxYbWMAEQDSJiziWe5Y78tSbI96VRV6DoWsOXwupsW+FgayoD3t5RceTn33fnV+PaUtfSgupPnRXgRxPFIxswykueyHS8l09daLb3KFsN/w10Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=agAReysm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VEtA+bZ0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="agAReysm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VEtA+bZ0"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K6BJuZ1988439
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 07:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FWemyG4N4ylx8AJN2NYbSRutWHMPkhp+MiTGTIekUm4=; b=agAReysmKjIortik
	PpCcf6FrLsBAFvE0L36aRTnWYqI+2R+0kYuY77jU6VmYzah32kclW2u3mzNnW8OX
	M4+9abOckXZ1aVh+cheNvogAjrVtl5op3ScbA0oxs18pLFQwmFZE6u51IDK3nA0V
	AG+BpfPw/uMiNl8Yigark5SmCr0wq6OIJNBtOFYchSOdgDrWOYtfRm0wgHhG8P0F
	Nd7f2l8UBeQtWDILlHMdk5SsvsbCe5cdm/C7McjEZwwhXr74nCvTNoZUMehQUS8C
	CGb+yjf1tzdvKdaGaJCxvSQ0UEV5ECe7kaMsaZgJrhH0B1p1NOSSnOcAR84qe4Wt
	87Yieg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5esj3r87-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 07:47:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52ce64c41efso32368691cf.3
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 00:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787212026; x=1787816826; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FWemyG4N4ylx8AJN2NYbSRutWHMPkhp+MiTGTIekUm4=;
        b=VEtA+bZ0HcSFRPNZq/4V+c/FWPTDWw5XJAiwW52hqRLXadD0jFTp3/h8RRj6pVSy0f
         W4mwXfqwO/pFd/X41RfhgUP7MzypZ4fUzcJS+0/4GoVFDkJiz5N8d3H7H8kBwV7K29HX
         SGN68CvWwPkjegqd/XL/AVCqKn7qw7XNywF3wK0dWYcYX7APlnOBT0OLMwRHsangKi6E
         RnuMuuQpbqeDOnA/CU8sLXO3KhiFL2md/XqeuWS0V+IApNfOVHHN4IKiOQYDw02OkZMX
         7B7Yy2mbB2ovDcWctKxUrc5x/IAQnur5tsXgjpcUbUctCvRXRHE2A+68bI9L8I/FVitx
         1S9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787212026; x=1787816826;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FWemyG4N4ylx8AJN2NYbSRutWHMPkhp+MiTGTIekUm4=;
        b=TgGqJAqx0JMkm3OWgkGctbCUnME9z1Ox+VO6rsGqXJdC54M4qoXGiZsio5Pok+fNqn
         GiaZEcjxB7ihETNdJ7IW9K4D4+2/orb09Wdim7m8RbI41F2crZVQrTHwCyAc0e/oOyKw
         sTc5C/c/2ghGMeBomUYz3SWNyBrx2t9n8j/qlxB201BXcBzUhXzKcwWOaAIZJpNfmo5y
         udu/RPXARTvH+gjP3fe5W1DFhq58Pez+jkpJy0oLNkNwJnnxa/clbTk5+D/hODAKH0S4
         ASZeLFZUxv+CLlpXD06YOrH2qpSOVGNg1mXUeOzWkD8/h8uU0KY3Dmq9z6aijULjR3HU
         cQHA==
X-Forwarded-Encrypted: i=1; AHgh+RpcdAoFET1PPqf9594DKMhEjFpCP7raX0HR9QPrUm0uWzJfK1iyn9X2yZ2RuzSKEwwjfOIQrQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOKuyf78q84qGmithnhcj1VnSpJA2yAhjfydtUp0Rca5fs87zy
	dRLgD0tTiXxDgvswer2eTjuLZuAJjBR2FH9BPqJlkfmN8PLJEFqZUL2AYxKlXV+NDvD64HX3ZvE
	g0H/f2u+YLR/aEwUH+HSAkj0mtqMo78ssaFIngHOTZNUqtdfDKGhBG2BMbA==
X-Gm-Gg: AR+sD10OuXh8tCKOrbVYbMS+dGOUBzZJW2y4fOFHl2eEsBC/Hs10wI2sQ8tru+dqIPJ
	MEfCxC//urNeZO76JzDYU32/cwNg5DADN9ODQoSZ7gG1uvhzD/Xrb2zSpegWbrmWc7zH+FpzFG+
	2sAGWz1bvWZAxlbzWu6ck8jYaRQ8DEvwuE4m+vq2LvqqHtSX/sZZJ7PthLixveunsnE8dHufklf
	Ewp8N5F8Z9GVezUEA54+1FRpoaa8hoQdItquEzsyG6RFNDqSxduBLL7x1Zx4wu2INHUa0TQ/Y+x
	J9tR8cL9C5YKMcXvEV/MDS88LQbvAuUEI5HSF+ce8RKcW4otPjIfObFDoDn7240HNCzV27TWXY/
	bBNGdO+2WZg9Joo0Sv0CTk3Xgmvzp
X-Received: by 2002:a05:622a:2b4b:b0:51c:a70:5ed with SMTP id d75a77b69052e-52dd5c9313dmr98105151cf.30.1787212026504;
        Thu, 20 Aug 2026 00:47:06 -0700 (PDT)
X-Received: by 2002:a05:622a:2b4b:b0:51c:a70:5ed with SMTP id d75a77b69052e-52dd5c9313dmr98104821cf.30.1787212026125;
        Thu, 20 Aug 2026 00:47:06 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0dd5fcsm133844445e9.14.2026.08.20.00.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 00:47:05 -0700 (PDT)
Message-ID: <0f8f3d24-41ec-4878-8182-c805c7db7c23@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 09:47:02 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/12] dt-bindings: npu: rockchip: add
 rockchip,rk3576-rknn-core
To: "Rob Herring (Arm)" <robh@kernel.org>, Jiaxing Hu <gahing@gahingwoo.com>
Cc: linux-kernel@vger.kernel.org, tomeu@tomeuvizoso.net,
        p.zabel@pengutronix.de, ulfh@kernel.org, will@kernel.org,
        conor+dt@kernel.org, chaoyi.chen@rock-chips.com,
        dri-devel@lists.freedesktop.org, zhangqing@rock-chips.com,
        linux-arm-kernel@lists.infradead.org, joro@8bytes.org,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        krzk+dt@kernel.org, alchark@flipper.net, ogabbay@kernel.org,
        royalnet026@gmail.com, diederik@cknow-tech.com, robin.murphy@arm.com,
        heiko@sntech.de
References: <20260817113603.1436067-1-gahing@gahingwoo.com>
 <20260817113603.1436067-5-gahing@gahingwoo.com>
 <178709455518.1014304.1443906758035976924.robh@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <178709455518.1014304.1443906758035976924.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0-P3kmcWUAD63wfvZP9tlzkgBPX_G-Nm
X-Authority-Analysis: v=2.4 cv=EaL4hvmC c=1 sm=1 tr=0 ts=6a86b0fb cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=9GNsruGHAAAA:8 a=EUspDBNiAAAA:8 a=SdGosrV6Qt3YffhYJa8A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=gf-oSkQAjqHFJRp-GQfY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA1NSBTYWx0ZWRfXxY1LElFKlOST
 Lm8MYQ8tdlHikNDZvN3PjqRAymb8KJEyle+h/ymgz8E1k+hYyqkiT+L3CATaaDXjFi6sY5e0gwj
 s20lu9bfPyG4QDNWJou15pzvmYMkSiOoeWCApijueGUNqTq9VUb0+c7OGXhjrNOAEz2XEx9wGop
 r94UMmg4zvv1DiVDww4LWQllUG3LuSMrUZ4ucLuqn5rglZt8Psw2vfN82G+j6HrrDVmSYiqk8Eo
 lPIq41e1N2nC7CUq8W060pXYqNnGmc3MYDtloye8eCLq/ZyQ5HHYNBN+VOMj/oneLTKtmLGECCb
 9697Ybg+ENTbuPXvm7P7psrshxJFnkmbPexyebWLfrnVWBadPpotKGZPuQmXoulVLtAUTcinpUd
 a+VIxtr7BuXM3fAcMot5l9cuVMfmW46wuDSnATmcNO4u7Pq9yJwulXY2KXrsT1/gvFBIBafTezs
 caxdQcaVkK+iQsg+8fA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA1NSBTYWx0ZWRfX4OFTPxA29xVw
 LHIk3bx24XWS/H1XmzQP+Xp8PQbH1oWL3ZGG21LtnYfEEMpSZK3LRnpB4RipDuTi9prRd2RM+WE
 44iqsFTEHSDe+nZcx7zL4RZV3kUUJnk=
X-Proofpoint-ORIG-GUID: 0-P3kmcWUAD63wfvZP9tlzkgBPX_G-Nm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200055

On 19/08/2026 01:09, Rob Herring (Arm) wrote:
> 
> On Mon, 17 Aug 2026 23:35:55 +1200, Jiaxing Hu wrote:
>> The RK3576 NPU has two cores of the same RKNN block the RK3588 binding
>> already describes, but it wires them up differently: two extra CBUF
>> clocks, two power domains per core, and a single reset instead of two.
>> It also has no NPU SRAM supply.
>>
>> Widen the property ranges to cover both, then pin each SoC back to its
>> own shape in allOf so nothing loosens for RK3588, and keep sram-supply
>> required for rockchip,rk3588-rknn-core only.
>>
>> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> ---
>>  .../npu/rockchip,rk3588-rknn-core.yaml        | 47 +++++++++++++++++--
>>  1 file changed, 44 insertions(+), 3 deletions(-)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml: Unresolvable reference: /schemas/input/qcom,spmi-haptics.yaml#
> 
> doc reference errors (make refcheckdocs):
> Documentation/translations/pt_BR/process/security-bugs.rst: :doc:`regular path submission </../../../process/submitting-patches>`
> Documentation/translations/zh_CN/how-to.rst: Documentation/translations/zh_CN/xxx.rst
> arch/arm/xen/enlighten.c: Documentation/devicetree/bindings/arm/xen.txt

Most likely false positive due to other things in the kernel broken.

But just in case - be sure you tested the bindings.

Best regards,
Krzysztof
