Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4BC44BCBB
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381055; cv=none; b=rF3xsKRj301LbMKRh0RTv6rwzX2WyxgaSjSSs+tEkaPMWxr6R7tC6ckioDu/ogsxvjP683ZEbXiKvAp8xpVjD6Xjk+42tETbugOw14AS4t/2MLPsH4G2+vVkWt/7YPmFttlbpOf/fQ/iAbqS+zNmkUbQam39ROB4TG5Iy7fcmUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381055; c=relaxed/simple;
	bh=ldxgjdBrYYeVXaUnxUUU/B4GwN76WLx+xuzOSN74aEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7gePCUfqvnx6EAy2JM7hm1CFLl2w8viJnmot57zI5OjRwP4htfi4JOhcyqVe7oPNKHP1yHqiKBPOOIZ2ir7Xs3EF1YSZequ8FPlNa+El8/EsnV2G4I5MzzW8RhF+f2fhhZyHgDmJ5/SUB3eSJgfntZQNUG85dgrPUWXxHTgBjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WgPUl3+4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H1ZZJKSC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WgPUl3+4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H1ZZJKSC"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SA2toh984983
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 12:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cAZoI+HEz2rp+EzYdEX3uozy
	F0yBJpjpXc9xmiJV/pY=; b=WgPUl3+4aDAoeH7Sq59lei5hhbH3zHqoLlqRAslg
	T/FigfBneLbUj1F/qCCk8DXIcx6j0juHPkbozwmSb0w4kufUHloVNhW0naABMSuY
	5I6gZ5QP2Wy3Aa/NRAgqBdnpAXFiEu2NyJmdHo6EutUd89ZvcqSyIcshEjKpKkVo
	Q7urZ97JR4dQCzRkX0pMKbGIfzXiJnO7e8HqNi2/eeGu+DOLui8B/J0kNP2g2U2p
	01vikdClhMGASoG5HBr37hLAdPmmJqZQhNSKbFfdnqukbPyvzw5ZWXkcj8u3qJ6A
	yX9l8GMZWnr3MZZ6rWcLuyfcbsd+2Vk0UiK/Vtl+8QSv9g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dttt2rmvt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 12:57:31 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2d889997495so30343250eec.0
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 05:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777381050; x=1777985850; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cAZoI+HEz2rp+EzYdEX3uozyF0yBJpjpXc9xmiJV/pY=;
        b=H1ZZJKSC1dB2fno6SD1yR/d2yvZIZrVVpDpDNBV7CcdRcZomLsIVG8E/ksFCraKfJt
         S1wO+NxxXNlvxqvpP+Tgg7p5RFeZkkF3OMk5M0gCZn4tiJXg6KziQfhLLxvCZXPVzAvk
         Y99jdWLUxoeIGRL24aNVnNyoezOIFA32R7XCwYP0MuecMl88hnHkhF/Tz6tAmoqwdrxw
         cD6KDanbM+uEMzHhhcRGyOU9FIcOJsA1HKFT+cHOpwy9L57HCB39jOFpVNth/9f+jHeB
         mF9hsUqvWbu5eNuEgtOh9jVc1lOIUNEmZ2+8werDvCzMQmsa9+bfapvzqRbKLsNKOzJV
         UzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777381050; x=1777985850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAZoI+HEz2rp+EzYdEX3uozyF0yBJpjpXc9xmiJV/pY=;
        b=i4IiywXR+jSwFGfdiS6Q10vG1f3Y/eK/CmbDHVYbYnywQ5vSVIye0zEySm4pM7jBkx
         ixpCTFMQ5sXeQ5iLHA19lWDRuWbjRcDThJ67G/+VMQmP7HBaO7y/YWv4jC2VYJv+LDcS
         T2AQjnbW9ZLR9I3WhaCjDabAtOYDYSoiA0o1gT5tFzWOhtPVYTeoNFvhQq6iYjjNC+77
         lyaO1HPXrh+rVSA+mAe6S3aT/4rJMflqZhduPKVAoEv1lh6RPPnAVQ8Vz2fl60h6unB9
         k+pdQMkWK1j5ZiW3kNL81c26eb3Cq2PbvlDr+5JWOYC/Ca1Hzo9MB9ahweZixj7MPPkU
         qGHw==
X-Forwarded-Encrypted: i=1; AFNElJ9VitMEb11oHU+3NbRZlZMCQj4Q+qpe3G3u4hDgz62uhKg5uHRtd05W3YCbmVHyFy+YreIyaA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1Mzdtq/j500MRPEDYgHTICZ93RTC5VQU5ha2P1LVMzRTH2pPa
	+Jchwlap/hG1SuLCG53VMsPw5/F4l1Xqh1VIXhtxeMyAn9mx/MnW7zNANPtsd4w7WpG3Oak+JEL
	Xk5hqeJG0wbq5uPPdGNq75J9s0tB3hnHYG2q0zFKj5jZ7NCMMYDW7OOHNvQ==
X-Gm-Gg: AeBDietgTrJbi8i9tDzb8iD3V9PIziQZh5U0seXWl/HtrYiCxeco5e2Ib7LyEPNPXXT
	7wsFn1HZMvf+MswPRFjJPwb0AyXKhNlNrplnz/75+BnMy2eYMaZGY9mzITkMK7L8AUNyl2FxkZC
	wDL5WHpohe/dgVHaBMe11EJ77eiofcr9abxeKcuZigQKMCEz4EAQ0amoa9PMmEscgyuXWrLs4Dc
	ya3C8fUy19uNXoS/ZnAwtKAL7oJk2G1FuANUqYSkBIMP1RrlIiXzKNc726cb6+RRVgsMLqFFUpI
	l1m8Q7wzNqrnZPzPkiNKIUQLnHcoYnb3MJlavYfFw1jUnf8HnV4HLGtKdcS2SAKFWMVbecAXJhm
	Bea4/pLEMatjbGCpPMILb9DTxbJW18ncysbcZVX47Zhsf5xG74hcj0r4x8ZVl8AEz0CyI4e+emB
	Q=
X-Received: by 2002:a05:7300:3b06:b0:2e1:f72:3f18 with SMTP id 5a478bee46e88-2ed09fe6f94mr1542607eec.1.1777381050190;
        Tue, 28 Apr 2026 05:57:30 -0700 (PDT)
X-Received: by 2002:a05:7300:3b06:b0:2e1:f72:3f18 with SMTP id 5a478bee46e88-2ed09fe6f94mr1542577eec.1.1777381049572;
        Tue, 28 Apr 2026 05:57:29 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed0a0cea01sm2118609eec.18.2026.04.28.05.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 05:57:29 -0700 (PDT)
Date: Tue, 28 Apr 2026 20:57:23 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: Add compatible for Qualcomm
 Nord SoC
Message-ID: <afCus0_JslMgwdlg@QCOM-aGQu4IUr3Y>
References: <20260427011728.231026-1-shengchao.guo@oss.qualcomm.com>
 <20260428-tricky-magic-koala-b21fed@quoll>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-tricky-magic-koala-b21fed@quoll>
X-Authority-Analysis: v=2.4 cv=HbIkiCE8 c=1 sm=1 tr=0 ts=69f0aebb cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=Jwcvy59Mha0-J4ocVUkA:9 a=CjuIK1q_8ugA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: q1gWeJo6D-ZPDsHUBqUhc_Fsz4Td4o__
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEyMCBTYWx0ZWRfX6zI/bAJMM5sB
 KqobkFqkMu0WKRPKlDtFyI+MH17gFZCF5xvgyBs5S39x7XiCLa6rurL8+m+3wJBFlISIKiw8b7t
 r7NaO26/fSSCTRf6ohswhPLr0wUoOH2PmtQALyi4RqFz57nd8TIJXikaBxAbFUGcOXba11IACyj
 ByNQinl2TT9mlc9B90jyZXqDjBgx0oe89l8yfehcqxlbU9hv7htWFO/ZNp9HV+/aCWt1ZmqTkLU
 q1q6JsvSwZJbP52na5k2PyzjzszaE/iqPvoIzP0YZiCCHOXq1XlOfio64Fe+c6vb8aZ40PqCwDb
 dmq6i8Q/TQRQDbpWjFL9VUV/D38kFGWnRsDWL4taKHA1g16MeC/i2WWZ5VPf/YyoERewDkjN0lL
 D7GErDUj4hBESVmFGLEU+fjEyl63cml2D9jGXMKEEOVOnOPwEcd1+3znNugmm8I0yEodLR7bc1Z
 Trh3I3wy9ywaVvs2kGg==
X-Proofpoint-GUID: q1gWeJo6D-ZPDsHUBqUhc_Fsz4Td4o__
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280120

On Tue, Apr 28, 2026 at 08:20:35AM +0200, Krzysztof Kozlowski wrote:
> On Mon, Apr 27, 2026 at 09:17:28AM +0800, Shawn Guo wrote:
> > Document APPS SMMU on Qualcomm Nord SoC which is compatible with
> 
> What is APPS?

Should be APSS.  Thanks for spotting it!

> 
> > 'qcom,smmu-500'.
> 
> What is qcom,smmu-500? And which one? Adreno or not-Adreno? Please do
> not add any obvious parts to commit msg.

Will drop it.

Shawn
