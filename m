Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462858;
	b=AHOuBrc8BTb9EtujBWU0SYqCfToauu0axzsDs19ZgWgj8pfDk9FcgH6EioybSFWr9YOK
	 +VtEeME2BIYtFX1RoD5tpzRfV1Hpp+uKtlLof3rAi9j2Kj+Ice4fIzY+CODU66fsWKaGx
	 81qmSoKqCEYRlw3M0QhmKNExWP/sYcoaZSyRUdYVedjGzqQKWeptXZ/lsPATmycq5x64N
	 AgZsV7Z4ZRbfFm3ebaYCGB9mcAiCMRRvDBO7VC57/nEWbWU8KRlOEvjSK/nDogQdthXy8
	 ayUis7yc5BBNZC3tF9bzjGzpKFsYJn97i+dECgSyF1uBZROot/hxphlwAvw69v5ga2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462858;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=shYVcCkI7WsAel14qoPcI2k2hO7EaXLkaVqcGNDiH2M=;
	b=cIJDBjxwjAQMBiLp0Gbl5ltdrOhB5yq5gOiu5DqWSewRtBkTwHkePa/uSPoMnwKDEqMY
	 JTdCTrfmO51HpS3Ka9HiPEdSwD7FjHFxW3qSr5zDZQc4FPAHVTqrhtxSW63rpPi8WezUp
	 Yxjx4LYQvB1IMk4tvGELo6JwurKZqw62iNvG9tp60uoXsKIK8gVHz+aKWypRB0bKhrxRe
	 s4SMOkF9LZ9A9mgiSBgnWjiFzgmF72eBd7eylPROncSK8UdWgUAm7nGMkv6T80oTukvJ1
	 JU0XsqyEILtvWi/xqbzi0JEbxSRETEJwKfzyAPgLKeR2e87vPOvqMfIGCKW1eMFupgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Bn/+2yNK";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JdJk4FCY;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DD2606A31F
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8DD2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Bn/+2yNK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JdJk4FCY
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGGxui2340306
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=shYVcCkI7WsAel14qoPcI2k2
	hO7EaXLkaVqcGNDiH2M=; b=Bn/+2yNKAWCbEFLfimFQervj6gTXuixll8020nAT
	iotFPwlivvF47lcIPwxH/WlQ+Z08mMI/Z6+PoUKgv/dh6U+T/Ee+dd9bYCPmCfR7
	kKfncRVAAaMkzYYe5xUW5UkbJ3fyuvZj8QsyEzZPW9lG7yOvhFq5tP69wgj5UvYw
	wpMhAiscc2j8PSZXoIVLpjE402kbi2lpAjYUHHvRaeO0bMWGH6bfCD1/X3G/dD9R
	r5NuxTqh+KH2xuY9jyWJvh1Clh9FQGtf4OEKaSLi6v4JEQ04uxTPX8h0YxxlVe+V
	oPCtpFZHnBp0AR69T1p7QzlVSavOI1V39/uqhLuWxHUQrQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4exx3bbh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:40:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93909014c85so695909285a.0
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 11:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795462856; x=1796067656; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=shYVcCkI7WsAel14qoPcI2k2hO7EaXLkaVqcGNDiH2M=;
        b=JdJk4FCYJ+VgqoqSa3ptSYr0DiKhP/vnPaPVrULjNAz93Bc57KX8hX7/cxavTr3A7c
         Cm5jzKiPuBR8i0xx++RcxQEwikIJhsbANICvJCaHpPVyy632NG+LATrvaSE2yQ8ljAjz
         /Phck00UNHHDAS7TcgpMdDE6Y0P9c4NbUXl/a1Le6I1DxauZH7boPWn8iEH7XCyyFMN6
         VkrQDa42ZqZ0DFTrPJTY0CTJcH6l+Ou8oPf79brozqit16MlyH7JuzrBGl8EU8VHP8+S
         Ma64u1yWykpFVvfzrAgTyrxZMcE5kQoaxPpRkLI1zMh4AK/7JgjGkvejbBz7m8WEhLX+
         4fVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795462856; x=1796067656;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=shYVcCkI7WsAel14qoPcI2k2hO7EaXLkaVqcGNDiH2M=;
        b=ZUW9ZzALtviWfrPDh/zTqbSo6hLi8ZYhRy4PvNpzNBggcn0MWOHlANmQCPz4p9dBhd
         /+/h4u3IcRTV+HRKSQ/BUte6c9X5apQm1QKJcuFbHnODGbKxTsRNKm/aBMZaMGCs5B9I
         29dk5+KHCJiN2cRdbceeQANtDEm85gfEhcgAnmBHlakLP3LYYBrJKW/H+IWA8WaBN5w8
         KE+k5Wo+/9eWoWo3img6TK5Ghv1ewb6ouhMHbHR50J0gm4KbXIRZxZVQ6L6EifuKeiAZ
         9cLqqil/gyY7eqaxpIMF6k4fpDm/vDZO7bEjd52IkGXiyjxhBpGbQ4Fq6wlZOQqWWigv
         qZXA==
X-Forwarded-Encrypted: i=1; AL+hErH0twdg+uhy/YXLjBt1n//l6K83I0ZLWAPiipiU9Llzrk/WZvwyNaSdH8gSox6NUqECG4x0rw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Dv9a/AFUazOY8YZgAgdLG8MqTyhA61vpcfzZoj2dTASk/c4XJ
	UWkr4L+9l9V1cN5JcF8/wz6zzgvVI4S54GtWBY36/LVAXqlYwya3pKDUelV97BK/JrXlw3/zRjT
	rOsFNd9+qipEydnQRprV6g85LnlTR2zItPuZyXaw9fvCslz4qCrVW7c3MdA==
X-Gm-Gg: AZFdTZdObmgc3T6TOuYyCbZScanvZmy8fWE+2pTllMq9wcqdVchcZhm99uEnPC1Be0U
	9ODvMnvDFe0zSlEtLAqdc8jLA0Ad7Ur1ubO8Ef8+E0uIEHrL/SuYIyTtEd1sguesZEGxMDqUBL8
	Rr1Hdiv5C3a+b4dAS4dVxR+UwVpSQu5bJHTEb49NRZh0/apyK8QxDsQc9BfJaBv5RbvlIPTH8at
	9r8ZTvZ6I8ug7VaY2s1cbOHVhBczFkAIPhTpU+oD7ZhR5iLhvyT9qBh9wggHQzhvejUTb+J63K0
	pf4+69Nzevp+8KroZE4DeVXZJaUqnE/V8nCdNa81jlLmfcNdNmHouV7b6fcYe7glxuvg/Ds57+k
	Mlq3PwcWF1zbkDUDTTZ7QhEmfu91QXNsy5f1yuXdGMamDJtETzjX5zOnrebgk6wIF
X-Received: by 2002:a05:620a:4388:b0:946:6:129d with SMTP id af79cd13be357-949ba9e8dfbmr2179923185a.54.1795462856121;
        Mon, 23 Nov 2026 11:40:56 -0800 (PST)
X-Received: by 2002:a05:620a:4388:b0:946:6:129d with SMTP id af79cd13be357-949ba9e8dfbmr2179917785a.54.1795462855516;
        Mon, 23 Nov 2026 11:40:55 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm511746015e9.13.2026.11.23.11.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:40:54 -0800 (PST)
Date: Mon, 23 Nov 2026 21:40:53 +0200
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
Subject: Re: [PATCH RESEND v4 11/20] arm64: dts: qcom: sc8280xp: Add GEM_NOC
 interconnect for adreno SMMU
Message-ID: <cdf3mpbifvj56nbr54w3yc4ddshsgbbecfox2vp7vsp3bv2v6v@kjedaxblfiou>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
 <20261120-smmu_interconnect_addition-v4-11-be30526391d9@oss.qualcomm.com>
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
In-Reply-To: <20261120-smmu_interconnect_addition-v4-11-be30526391d9@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=FKKOVOos c=1 sm=1 tr=0 ts=6b0496c9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=jAy75CqWmSRsgNc4pWAA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: lJE2_3D0OovojJA7dvMZLNCYfLF4A7VZ
X-Proofpoint-GUID: lJE2_3D0OovojJA7dvMZLNCYfLF4A7VZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfXzMDKrgbJE0QG
 lhH8KFbug1RJEUXSErDIWZdYAq4+fWY8AHVE4x3SoFyoI1IE5sc95Nw9M6YFTC7ydXq9PoJgV4l
 M/UkK5zBsA2G50ujQJwAsLywmYdFYLU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX5y8fod+Ddfpr
 A0rSi1TkHcTxzgpA/8kGZEIZ8o6WM5WnXDXLWkLhIJkRfnqsfbvKTIjc+qoQhWfoZ8S/l3/Exdk
 J9gbpyx9e68wHX1qGDLG6Wz1pK7AB6Ps4T44ZsO49UPzlCX7vUvC04sfzIiAHTu28oLqnEoKwjs
 AvdTzemXjZ1fzcSHWq48015ZQAOhJCSy0dGoOi2kKGHh23MWWG7Toj0YvA8uRFIepKDtp3+6eYA
 z/giCKTAVUzPeIuG1H+A51LxllFHvd5OXzplrkvkAlNLHHEiIRo9NCbviE3fApibM/J7tdOofbC
 xzy62BpVyOIZ7b3KOgXkW69rD5sKeGEQzxJ8+XoE1inD6v5+/5jOmY647EYMsT6Qnh3Bj2HK6sH
 yWZfrjY+k/UkG2S31SwkAK7eGieKC2INWaMM8bDR2RCJCnP5v8KD2FY4IGB0RWyRoiJiJ95z1Tx
 FrRn4aEzvoozBuHEZqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230078

On 26-11-20 19:11:42, Bibek Kumar Patro wrote:
> On SC8280xp the Adreno SMMU GPU TCU is a separate hardware block with a
> dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
> interconnect bandwidth vote, the GEM_NOC path to DDR can be left
> unvoted during sleep/wakeup transitions, causing intermittent SMMU
> register access failures.
> 
> Add the required interconnect to ensure reliable register access.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
