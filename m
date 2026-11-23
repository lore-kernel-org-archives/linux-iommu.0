Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462774;
	b=IouefohiTHQ6G/B4CMAuoKjEdnOPW6SETXT76RZDnjsu0CpQw+mYnXv8cHxzgAF4gjZK
	 d+jk+Jf/vyrjIXgUQjPQ/PwormauqZFRnHYXJq2jzeTss5pZirxGQGiQ2Bs072j3sPW0y
	 oCgXyobj89COQ9rw4uaJsoKdGUh59QCTMnEjHePtlecYG3nLwV6unwE4eheqmYMa3LX3D
	 g792j/ELsxD43rRZ/LEupsDd+5Lzv+sIZQvUI+fQIvTlXWfZKUWIRiCCFuBFOor3SFqrO
	 Hh0VqwbFnA9E6FQthfug+ZbAJ1qSjuBQ3CMOBy8MoEvTUuauFz1gw18Qgl28lrR8lTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462774;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=haNVO7gOhf5Ym+jj9U2IyzMeC+mkDIqkrVpNRPXkmrU=;
	b=qR5FGQT52r3Axg2U/L2anIVzagXqAk8CkoHXFvdaxju6DFmyc0yPEZC7aYa3pJJ8R/KN
	 96F4N2VQQX+0dwRP9rk8C8YlH1E0syJYAGZkPvwGa92PGClRtPMz6M5k6Q9YXL0/lyv0V
	 6h/7HNxVEE5h6amhYviL7jlX4FtW0ZJDxioArjZybCMEmENOs7AWUmu0zN5zbQA4wVxmx
	 vYm+OmMFsMZv3v3mVVF4pFQ7O/gge5CiWarsuPRxRH/oi04YY6Qptw+dMjRx9/TJ6MYEo
	 M5MkIU6GMwB50nRqYBkIYquqCQ5rU9o7aXBac46oayhvC96iYJFkZZZ/BisPI2h2axw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=in87BECI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L8GYoEcx;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B587606A31A
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B587606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=in87BECI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L8GYoEcx
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGGnO03730225
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=haNVO7gOhf5Ym+jj9U2IyzMe
	C+mkDIqkrVpNRPXkmrU=; b=in87BECI0Pt/FGjGRSYHFDOIJgcNMkkMvbu0rUft
	DqhKb6u4B2ZYJRTDxBc9WD/Zvm0ZaeQ4iYKNhz2DzckJaq72V1QP8O9WFsvTx/Bh
	H9kbwok7Qk8WkJRlkini1eybC70UD5x3qLWr56ftt4+OfxvqrQjWWFKhLLewkIyY
	VC40bA9TDydeNbA+7/zn4SslVwPKq1E6oI2Mb6blc/SB5J6xfY3ecMLcKqyHzX4J
	PLxB7TcTxv2GyskIqpACXevEXNkZp8ZUCDwrEXqKJGfiWbBhlvV8JMqpne2xaHlD
	eSuSAs5vXrkJWTnp7Lzy1pPDv2kABXG6A79WJzgClOAyJQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fyd3628-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:39:33 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f33438950so657123685a.1
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 11:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795462772; x=1796067572; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=haNVO7gOhf5Ym+jj9U2IyzMeC+mkDIqkrVpNRPXkmrU=;
        b=L8GYoEcx/mcWxBAHBlNJRYgiLmQxs3GuO1THsmV2feePiFM0MX/M9rv4PHhzqa6fWE
         149YQOS9EQ8oIj1Yb+IMnZ91Qjoqak3Ixnq+JUZo+vQit5iaYVxKJXXzxz9F0fAKOKzZ
         iql6KLipoLcnSyfxmB+OvDGZUCII3i0fg9A+BmtXy4ObUQKmBMNc+6HpZLPbKI8C7UoU
         E8WySvcRLyOBP+5FA8POjX4UC3z/HWAQqcJh5WbeX9qioQjr9xTEFcbZxeJnbB9iYRjV
         +8ytM9GHz1BTAEaMPbFebq9e8sMXbT5Mrt0/+r3179FoTSx1RV630VkxemL637wLAe36
         +WHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795462772; x=1796067572;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=haNVO7gOhf5Ym+jj9U2IyzMeC+mkDIqkrVpNRPXkmrU=;
        b=fWRvbb3Cgr/5DQ1zUfvWCBvsIGZEhkaSg2+gpIWd1f18gGrWooEgykXbuvFZ4Fgd1h
         4kDNaul/T7Wp9E2DVZoLfhafIrSx1godp9deOLBpZ+B1llq9EXhVLs9BVZqSJNwZIgGo
         cP1n+gD6NzXOtN3DJxAGBfsRe4Xckw9BK9O14ICkT7cgC4aEMElthPNnOgrwy/v3LV40
         dIa0YpnRhkMdnPMYM4wMyrCLYMPHe5TUFP9QDKgDCsd6C8Lwg3MCa4mqHvdp4nd6oXpB
         05esGjtxwy/m9GD0rct877PJdk/Lg1hLQ0UMyxMh2VOtIzsnAh+biIpKT88RXzUAvUuy
         dAmw==
X-Forwarded-Encrypted: i=1; AL+hErFjnXxmXJF0DmbEzJYPkj7YR8E9HTzTXUCNpArCw5IYh9bMW2J4lY3opXBMbquPQHKjjPsm+Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z933DlKzQa7juHfx0cnUOdRajZ9G8WhnERUbiECAQP/Ii7blWpE
	lcNT3rckTjfS/eYR95jSKaWA2cZAkfFDoxdu/i7ilzHoT2x34M4J5sUdxhzAfpDurGgJArDLyBS
	kXYWjTq2BeBBgO2yqFAAwlettNNs/roSxwI1snUKh0tFBfjoRX+LNz6ZT2A==
X-Gm-Gg: AZFdTZeRTxFcV6A0RsgsYTb8qHPX77/+I/WrNOB4qnk6mc8iXsBMY/RJR0v7hHm7Q8B
	prDWVqZABmCn6dHYIvGazIsiVI2KkZECtnAX189E1r/3b1erfuGrooZu4HxmJ0mJtXMPaOpMZMY
	Q/s7sD1G06t9hGFNCd1xu/lJXzEi+vIQ3CmezcLHRusahhv8qP+2mLDpFetJ0iF43C6CQDWAiyo
	y7UZTAaupATfUv/XOkk2gkb913/cp1wIp/ZnhMPYdxIo6bKCMc8vveoWcRAtJZscQ7SfB8JcdVt
	CvD0I+I13HymZPU93mIMH6GXCCbxuUWsI2qxMLAaVPi65xMx9N0HT0nNnNmGS3Q4lSURIfKPhrv
	FH3pB+6XleVi8eK6Fuk4TG41hJqm58U+s+MHXZCnFlcHh7PQjZw+kPPLtc+dPa2A0
X-Received: by 2002:a05:620a:4403:b0:949:7750:6bd1 with SMTP id af79cd13be357-949ba9c26cemr2181774185a.47.1795462772424;
        Mon, 23 Nov 2026 11:39:32 -0800 (PST)
X-Received: by 2002:a05:620a:4403:b0:949:7750:6bd1 with SMTP id af79cd13be357-949ba9c26cemr2181767885a.47.1795462771705;
        Mon, 23 Nov 2026 11:39:31 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm550971745e9.13.2026.11.23.11.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:39:31 -0800 (PST)
Date: Mon, 23 Nov 2026 21:39:29 +0200
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
Subject: Re: [PATCH RESEND v4 06/20] arm64: dts: qcom: talos: Add GEM_NOC
 interconnect for adreno SMMU
Message-ID: <frzrzvk6blfodotve5lndlqj23qpefqzedq4qeafv6o6fsayad@7o4bskhjiun4>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
 <20261120-smmu_interconnect_addition-v4-6-be30526391d9@oss.qualcomm.com>
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
In-Reply-To: <20261120-smmu_interconnect_addition-v4-6-be30526391d9@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: pj1H2dlU41JMd_CYG-oXlxY0ysdwLGw8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX8kKxStan+HOZ
 5VLfj7KQm2Yagu0UQ+nzmDjsBJ3jEwgPf+9vwL0a+28V+NjFZL2e6i4Fy4/KMK9Hj5Js+LObW8u
 PAbE1DReZh3dScizBNKt0ofL34pz+5++c+pDx2gVqAfTGQlgbraHPXvf8o3En/4ZjGVg5oni+Hz
 LH3+oGtHCiEA4SJBQ5b3+UY194GVAtvIVjtGqanYKZ2bk6+clduWAPyUvMb8xrDUbstmn+kjN9Z
 p77m0zTYYCmREvpRB1+fq8OV8QtyQ8A5LJ4pb7ET0PSarZFe9PYhgJ5L1LwHhbxZbUOhnrAsR0g
 MyMopfN8+m3CVawOzU6eDhVRXhGBuG4Ocpw3jdASh6xFsbHlsQfyn7UqAoudmJK28txLJ5B6asA
 NDC3qZtZ1DFqbQuEg9Fs84ugkhuw3wEBy/Kf8ejnYAwUEqBmm5r5uCVxCwxwX/I61RFE/2gRNj+
 Gm1y17iS37EBHE5FEbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfXx79LCVC6gi04
 21tRaDS91nLMuh8eX4d4akeAfyFvtbPzG2C7jEDP6T2Ca8bDWaNlmuIM8yu7RReYQU9Nlnzd3Q0
 5D/frhYkyd6R4p9bLcVcIIEDZ/UCqrY=
X-Proofpoint-GUID: pj1H2dlU41JMd_CYG-oXlxY0ysdwLGw8
X-Authority-Analysis: v=2.4 cv=Aol7T+9P c=1 sm=1 tr=0 ts=6b049675 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=PLo3hsA5cR1DE-V2qI0A:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230078

On 26-11-20 19:11:37, Bibek Kumar Patro wrote:
> On Talos platforms, the Adreno SMMU requires a bandwidth vote on
> the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
> are accessible. Without this vote, the SMMU may become unreachable,
> leading to intermittent probe failures and runtime issues.
> 
> Add the required interconnect to ensure reliable register access.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
