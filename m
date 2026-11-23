Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462924;
	b=FNG2e1mvNPXmQJ3Hr3CZ4AgppKgRMTqmc/qG9aKkZqP1HQCO8J8PRbrfFFCHDjH7kRjq
	 kFxBSkHvOuBz0cBtUEjquyFhIj35UDZ7yUuVTBAlBFXbEOFnj8wplND9wLn3ZrErbTXuY
	 l2zJQV+cgX1hy7h0IdjTCG+N7CWCTlhAcLCD3PFm5omR2bEU3VO4RIodTPREFdtWlRxyK
	 /MVtzeKvNdeFEKotdqwSsmTodVECdobAxLciYXszh2/BKNc/1ByUGiuciP98Fad8bx9Wa
	 QMFrGQDXrXaHAHjJq6ZgmzU4w0OcpSz00dBM6L60rQbo23Ub5xEVUDTA71KNxfVpbRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462924;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ZP1stIFjrR21WZH3nap4hGQwnj0u77S9FayUUaRW8Zk=;
	b=f7B+1t8dzBQYO0E5GYcYwxZa3bNv+W7W4Wry0H3Kn5jqsIbBhuVEYEMl1ygumlZtf1oL
	 v3BU6o4pWVt1wV8zo97r0ZHoS8H4T/uJC+G+LXQRW+zL0TyQ0nBxEQoATbxpH945tccsD
	 Axg2iKo06zqEhgBgmtcyjxe3ED4AifDqSa5EC65FuUO4X8a4QLihupbHG9Ag1ddTnwOeR
	 I7oPJwWF+Pmb7QT8v7MWN2zu1Jz98B8wzl8p+O7HSXuCzJ8pokLC0TZeAnjl5L6Bm2xQj
	 xBTlhB6lfLppvhamaramF65odQgh4R5fRfOhmCw4CmOtU9+dUeAXjEeVqdbfPLKJ3Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cgl6mHPa;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="bzam//In";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206B2606A321
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 206B2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cgl6mHPa;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bzam//In
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGGniV1861241
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZP1stIFjrR21WZH3nap4hGQw
	nj0u77S9FayUUaRW8Zk=; b=Cgl6mHPaapfmVqEjDLCoi8m8UoIOCaiyU+o1IE4m
	/brL+hrT4eMFEVrdu5g2E8AWyTIONXkiLJXkzjFCPkqHfyKKMyuusXmsJMvmPcVc
	9tzlRSPqI7h8JdbaXm2s6AtA+HO6uPEF7d3IeWN52ptz+Ih/XsauATIF0nFB1K8/
	74Gsm0ztzlG/3knvjkac/GG6YM6E+R3nMjGCMfJeRc633jdP7LXCuHY72+AQiIcG
	0bZkDCzy4gUsrciYDgWOXmim8RD+l3i/HUrZ01tGVh5Cp8WlAtKCQU4GzuXYdzk3
	mAQ979y3apdgKqm4o2DkGIyUccv1kL/Ki0wm7APq1OiERg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g9a34dq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:42:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb7f9bb86so738986985a.2
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 11:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795462921; x=1796067721; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZP1stIFjrR21WZH3nap4hGQwnj0u77S9FayUUaRW8Zk=;
        b=bzam//InRTMXYBtbQcU4hofek0SVkZX9vtjtFk/3DSGAz07uchHmYfwionu49jUsyB
         GYnwzy3SsV1q6UdYZ/ud9o55oeAmqg5/oQHzEDjV5EXKjv6O/9u5UIPb5kt5C3dAPFU6
         K0VzmKcwlyXACFrNIcFdUncNT50jDe8IvxDcIFgqzoSaFBALNC7fwnFT3N8YIK10dyUm
         uyPGp9SIREZuEt20LJH51XiQIOnhexlMvYjpk3A+/4b5dgEmhxD59wetnSpjjPJjIJJw
         y1DOLXF2xYzKN3B0oLScbIe6+4wpukem6GVCJBmoIysbyBVkpWB/3CWBXVhxEinF36WS
         oY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795462921; x=1796067721;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZP1stIFjrR21WZH3nap4hGQwnj0u77S9FayUUaRW8Zk=;
        b=yof9058CAa67pP45ixmGn/mLu4vCFFBz8xTFydgFBd/xpWfBIXHzk8+VLfQDXKpu0M
         Y299w4Ej1NaNGao/lnmlxSU7+0QO88SN+jsHJwdIWKbfCq4rtjAHTFMoN3zzJstOlf01
         DjkUEJw+R7VbRPdkvjubc6gceDqoaD5LKqz/jmFNrtqaXeJ1oXYsVMIirYNIbzqeAihC
         pcJAUUUwiqJI0J0ZjhX+exezekgK64sDtTRc4nRUG/hDjsSOnzjrBrguAbWhaohqjetP
         w6LIae/v8Y+eeOY3SbW7jpEcRoBqbLuL3LP/MkhEWRN5XmyjCkHGAX7p+o/5NdQjsOV/
         t2bQ==
X-Forwarded-Encrypted: i=1; AL+hErH6Gl1naYeOHTkgkejuMJvrIsLj0AISOVH6Eyksg3xkXIHl9Gbbj8oEoyy9kR0128rV9k8bWg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/N34fd+JPc8OvEEVH1owoL3yqHbDd+1eCdIPo1CZwiiWy6p2uQ
	IfljPGT3QU7ytIOLtzkSsGPBY+cLdpCXg92gkhl3Dy3DgmOedjE7O2lngyXZ0GcuQFoU84AVqUv
	EyikBJn4dIR4ldfKmepm/xs2pslyDeAhZ+cKKHq627ZPzTo1qVvp5CP0HCQ==
X-Gm-Gg: AZFdTZcGTsGIc0F8mpZeCQqNkYvjC/BjFfpBREpvqMtuxuy52mjXTNzXa/K1ZdJqXRI
	jiWhy2RJeS0WwLjr2SN6ArPTukqCv76vMCE6D0jk2M2LRVFPf6QzHHhOLY7P6MqD87Pn7HInaB8
	y7SW7n8C7KLkWtrHD6weC80EZUaaymweV8OmXRN1pNhZItH/bK2D2ZiSakd43EuJts5cFqGiBhv
	9zDRki94RQSfw1RLrQMuWEfAJmApqAR2jp9a+w0QjndBo69lkAAdIxFSrFglBM55Qo/SvhTde8l
	Mnwj9pM+aSOY2VJhlW4t1K0gyWqsqMIrW9G5kfoZEFhbNmQVBEuKHMVBolO5lTlY4awTSDjLamh
	xivRCiyDriCzpqc94aaLKhRJ0FMWI1ksW3f0ZWxPWAwoFSqVLSufajQa9ccX/AP4I
X-Received: by 2002:a05:620a:2b4d:b0:93e:b0c3:388d with SMTP id af79cd13be357-949ba80fa24mr1912904485a.11.1795462921254;
        Mon, 23 Nov 2026 11:42:01 -0800 (PST)
X-Received: by 2002:a05:620a:2b4d:b0:93e:b0c3:388d with SMTP id af79cd13be357-949ba80fa24mr1912899285a.11.1795462920551;
        Mon, 23 Nov 2026 11:42:00 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d1bsm24938335f8f.8.2026.11.23.11.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:41:59 -0800 (PST)
Date: Mon, 23 Nov 2026 21:41:58 +0200
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
Subject: Re: [PATCH RESEND v4 16/20] arm64: dts: qcom: kaanapali: Add GEM_NOC
 interconnect for adreno SMMU
Message-ID: <4ktoys4kreu45oyhzovmdc3pryzcynecdwqczuzjjppqqaqlca@m4flgwzgfpqn>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
 <20261120-smmu_interconnect_addition-v4-16-be30526391d9@oss.qualcomm.com>
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
In-Reply-To: <20261120-smmu_interconnect_addition-v4-16-be30526391d9@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX/qUL3a1Zwkkn
 CUuZMl2hYDiroPVAZhQJKIElV/a7nmsOozM1Yj7HBiP8DqAZvn59fyXBQJREjoyGya3KibdzFAz
 PbaRWc5MKLrSks6ZHegO0+O1TX47Fv0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX2D3v3adfBfFb
 k53E/52M7qWmTO15zYFWCP2fUMy5zfA2EwCY18NQ+bRkwWY6oLj7WYFKesfitZxL51Nr7wW9Foj
 BGFSVYi7d3yBUPqJiBNCCzPcI1rR+gDUhwD22sWYferI7hDsjYRO06zzHIwhuaSKsxvfrOX4DY/
 56ayTMyuok/IPTUndK5Tude//pxNb6kNFXUbW1x+0YapL1rttOfChwzzYWxJL1CZMsYWDgKbs+3
 dc4EoSwVpCEqyMPakBNLlcwbKsis0KaYSlzBZv++5G3X+jEzrg6yPAvnVSAM1wB5Y65pNjeKVSQ
 xHt3aDTjSqyCSXneqXXlpnAtsPNkMvgOXCt2FQMmQmM5G89MaMvuFfOCIWFKf3Bka3fQ3rv/YQI
 17FapnPKZ9YY8KOPeMaDlpIXvRfbfdIrNVMWZYepy7MuagtEpI3aICszs9lL6MfG7KT/ZUcHUqq
 0WX/fq+5+5XeBTeiZMw==
X-Proofpoint-ORIG-GUID: HTXF6SLF1czY5VQm5k6wrk3WBh9TEhJr
X-Authority-Analysis: v=2.4 cv=cYJHPXDM c=1 sm=1 tr=0 ts=6b04970a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=qO984ec2hPs5we56H4QA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: HTXF6SLF1czY5VQm5k6wrk3WBh9TEhJr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230078

On 26-11-20 19:11:47, Bibek Kumar Patro wrote:
> On Kaanapali the Adreno SMMU GPU TCU is a separate hardware block with a
> dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
> interconnect bandwidth vote, the GEM_NOC path to DDR can be left
> unvoted during sleep/wakeup transitions, causing intermittent SMMU
> register access failures.
> 
> Add the required interconnect to ensure reliable register access.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
