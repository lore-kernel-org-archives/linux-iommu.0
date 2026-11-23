Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462760;
	b=L9nJOqZYKX2cUd0vfh43uW1dIs2/5cGnh36vDaDTId8DbCI2pQoSv+fDRWFDYppJbbqA
	 VnRuGh/LTYYa7/xX6YfV1fRUN3BX3TCgTaX0RyxuBIadzNBfkmMAZ1nHHQxG48lbX/k2w
	 zgUsj9BmSpyzRbUmfNDLq657X8DSSr/pH9iwMgQQyESjeuRIyYZF/hSkd6BgRBn3LSZTq
	 XbkQxXVcJzfDa+HrPIH6ei3rnL6Bf8NDGP/80XoktHRnfOOM5UUfATaLG8BItsD3oTvgs
	 cbMWm8qUKRBPd5v9B1rEaLuMkd1nzaceqz32SPraBioLf4AkrbumLSVnF+ri0DPilfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462760;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=kRPbPFA5UaW8RQT7bD0uzKcSu4cYs79Tdy4dHl7KdtY=;
	b=4GEkB0Yp5pIX3bCKraEFnb9F9ef+aSZiJznXcS/jdYqOmTd5jcfSmRylnd9Ctc2yZNF6
	 zSynBy1W173HDa9BZ3Ls85JBuhgERkX2gDJRuqC02SnuUW6kGz86c3PIM8di4m4BUFlUV
	 oj7Fn+78UZaagQR3CD2n4ZKo6RhycR7N+V5UKE1QMsg3K1LwnDhLLmuBP3UOsSJesJzwa
	 v/YJUjm8laoRAcZOKrqc0+9L1hBmHCB4WazkzuOnEpJK9qGewNr7SJ9a1enp2p0dYTwsY
	 8ajKD1VrKPYnwBSd8RgavUn7+Frv8BMKULVBc2UUQQ6wRPIPU2vjywgjDdRROl7lyfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NWbkcHLj;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=abNDMKgh;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C9A606A32C
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4C9A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NWbkcHLj;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=abNDMKgh
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANJ1nQe3211961
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kRPbPFA5UaW8RQT7bD0uzKcS
	u4cYs79Tdy4dHl7KdtY=; b=NWbkcHLjy/t72kbbZhxphVhgOotRbFVZeU3gmCf7
	MN8hsmw5vSfH1vrzmSar6UKjUi2kZXsP4XJEtLLIfhEXufqXDoBjseO7zFUYImsa
	Z18VgkFxTBZdnwTX88duQ+/f+ZqAsJwa+rQFrjqD5T4oY1RBfXKRHbyOLQ1HhUip
	wxbUSarHXgl+um7Ebg/v0fdx6Ne9OkXeRNMZRxBkzWrOfUvxmuPxPGQv1Zljr4HK
	dUxXxyTFvIuK2oCAlur7cEHXq6+Bs25PBRpP0X3n8+zHIuluxSePyvqTeTV+emcr
	lNYGpEWZ9RiPpyXitzqqaBSR1IKk7k0ONubHxyRP5zwjbQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4u9nr52g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:39:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f37c94ceeso793941685a.1
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 11:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795462757; x=1796067557; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kRPbPFA5UaW8RQT7bD0uzKcSu4cYs79Tdy4dHl7KdtY=;
        b=abNDMKghIkIPz5zuM3XmliUU3dEA7c+AP548tKvqDY7n9QRKyUrfsb7C70b2I2f0yV
         N4cl74Of/4fMB11CkNPmWwvgtYBIfEEPWM0E3biEtt9Piz+YpD+dFb8CKDviZMcs551I
         D0MAmOZyzda+JmsFMqIBuBu2xd0w/dnvvjACDwN6mKmYHnwWkTzubQ8NN7qBebk4cTmH
         mzSchEw179AffrwY21Jkr4g4WNnkU3GhbLoezSpOxIz/fTs/mNEUcmDiW1EqTqvjsHzY
         0RuoYRKsYlhGKTJPhfu7kPlGdzejUVc+6vHsxOaFUtdv9tLsFf0pmrPSAQOkBJtFVJwc
         M4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795462757; x=1796067557;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kRPbPFA5UaW8RQT7bD0uzKcSu4cYs79Tdy4dHl7KdtY=;
        b=ReLRwsVzm9xg6M3gM83YV5AleIkCBhAxZc2qk1iIAwUr3HMToPDyqqgKbdgu7gspFJ
         mr0eJK6FHHBhpegItxuleJWRY/UNSQzOhM1fiWdVMUUUklTJ+nAyWJNSyUqUaj44rt5q
         4NNwH6uy7FFZxNaG3A4/CW/Ek4hqBYRuL9EmzyAFS65WKmqObcVRtssijjFdH0vIBrP4
         vF2nlZGVE0JJVzFE39CjjzCzGxvT8+/nCXcBxGrZx5j3Xt/hKlPZ8raSDkFPx160/VQ5
         cBGQ7/DpPr1Pis0VLkT7UZME36i6g25McIjggSgfveRbLnlyyIt9tW+YpIFcyE+GajYh
         FDLA==
X-Forwarded-Encrypted: i=1; AL+hErEvEJQRSSynUbcsDLldvxUu9uLIiQQr/9ERpkWYCOFG30D1hB/IIx07ADEW1JV5PzYqtttI4g==@lists.linux.dev
X-Gm-Message-State: APuU4Z/ugfUQi9v7R/v5Hj+/bpmY8w3RbZIk3OQrwDVBsPO65AkfK/sr
	WJwxujYQ6ANu4WTm/4gSkY8mzRHkosI/Ecqd9+PqtZ/mE5rmnXXU6svzBvXgf18aRSA07lWTY1T
	a/g5mA7CZXxPdbt3FSVoSReGEpHTWtm4n6ycaVWdC2b1yXQL0JdM38CzfJA==
X-Gm-Gg: AZFdTZdlzjvJCLzfJi64xyar1bwFNP6F8784mBMxqedx3JFpMRp169a+eXrW/zZsQPN
	7xxkZeRgubGdPs80NndgB/9taK6yeRt/U3CkHIAnnZ9D6cEMtZ0GKru8i7UYBozOVBvK8SK3ka+
	aqvd6LlBFCOtKQ3PiVX7oyYIDO5TKfimpUFQS9GWAosAra8viKBtv7bX22Dnm/JClH8La5z49lh
	NyjanAc4yRv6l2oZLTPZVLY99iT9+CYUltJCX3JcXu1h4Y+UkgDLUN+kbEDFssW3Z60Q15diPe+
	1TIJ2N1SzmExoZ5GUj4SbNjtUKh86euiCzY6Yc7z6mXCo+phm6D9vdtTYQjWJZnjXhfb5vm24Mq
	3kTqFm9KObuJxmI4eHxuLz3dOz5Hr9fKgoAMV/DbMbW1V7a7TtnxwphJcmDwVYIjX
X-Received: by 2002:a05:620a:258b:b0:93e:6e6a:b686 with SMTP id af79cd13be357-949b36034f8mr2389699485a.29.1795462757034;
        Mon, 23 Nov 2026 11:39:17 -0800 (PST)
X-Received: by 2002:a05:620a:258b:b0:93e:6e6a:b686 with SMTP id af79cd13be357-949b36034f8mr2389694385a.29.1795462756273;
        Mon, 23 Nov 2026 11:39:16 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm550952365e9.13.2026.11.23.11.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:39:15 -0800 (PST)
Date: Mon, 23 Nov 2026 21:39:14 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH RESEND v4 05/20] arm64: dts: qcom: monaco: Add GEM_NOC
 interconnect for adreno SMMU
Message-ID: <eyx32yhvf2rk27k74vlordcvqvfzugbq22kjju7mijwccltgkc@jbez65qjij5f>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
 <20261120-smmu_interconnect_addition-v4-5-be30526391d9@oss.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-smmu_interconnect_addition-v4-5-be30526391d9@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfXyhiwnqCPInm8
 E74yFH/6qqDjTGIXJ/rjoPq90YpBrMauBGXznIRq2jJD3U4vupOZoV+YQhU5cuS05orbS4BhGvC
 sWogppt1PgypHw7CEB+tfe2Oi6Y0HDB8mfkMH6CujVmTClMsrUIOhlL0A4tmWaxi1se0TAshw8K
 ebhKssPGGDJ59cHdytEME2emkw+phHDqI2HubfQA9ZFUv/vaTwTNfo00E+VHQYzoC21hkPazmFN
 aspCP0Si6ESTfTBpbXY9iXigrwb1tne4QBvQ5b52q6APrymIOonqDYCYHFCl6e+eq+QFOuZMMZ+
 9Bk677WzKSDG2DR2+Pao90rUPaRQdMl7LpRuB9ZMqeUKj3Ou70Xa36whv/ZufWn0NFoqkZEdIbG
 LcWKgUD+JkV4rWsurFt8x4ilabT766eUrwL42I3FpouXMX50KjSEy1FUg7nZQH9mfv5EaabvthJ
 X4sTPzq339msq6gvN8A==
X-Proofpoint-GUID: vXm-u_3pvw6iJ1EaQQfHYSBy6meZR2P6
X-Authority-Analysis: v=2.4 cv=f4ndl+yM c=1 sm=1 tr=0 ts=6b049665 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=LikcBPw_WjS6U_9SOOMA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: vXm-u_3pvw6iJ1EaQQfHYSBy6meZR2P6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfXzYLkc02xJknH
 Jxl3/WodhLWtJUrpmFKXe2ZpEkSXUqGd6neGUEIdjwoprQtpMfLZ6Uz+hDH1dPINsmmnkrnDthF
 bpQbFNGDyplFDW2tgG+W8lNJbej6DL0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230078

On 26-11-20 19:11:36, Bibek Kumar Patro wrote:
> On Monaco platforms, the Adreno SMMU requires a bandwidth vote on
> the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
> are accessible. Without this vote, the SMMU may become unreachable,
> leading to intermittent probe failures and runtime issues.
> 
> Add the required interconnect to ensure reliable register access.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
