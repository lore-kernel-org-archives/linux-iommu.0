Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462726;
	b=XgSx+R2+YI+rCR06JkO/iw0QQ4794jdBSK2FPpeLoUL+9dJRx1exQjowdMKr8EOJ1I36
	 2gYLJeo5mhJmwpz0mnWkfBEKzc6HncwxXVJBi6KZ3ErsGE0XwIQtjuEJyKR2vTt56PLOe
	 NigqkRygdhW4RK8o5y7Y7MmuoTGgj9U3/XIHH4fQlbWfk6gFFCTNn9djJpBGgaFBXRyxr
	 /VhANZPO1L2MEITUnoE4KJ6+oAuinGQB1j8kib3y/n4GPPk75vJNZrokSf+L2HzsExvXk
	 hAGLA0cK/EixYT03vlNpRKlVqPl+K6vOrYYwSCgLl7zo7ckAx2f8UgT8TG2+nTuKIWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462726;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=woJtGyolaPSm3epuc0oRfWRqEJQCl2Rjtu6xIFO48pU=;
	b=PL/iUGyWSWudJCaovP0XXP/PvEM6sWgTJFSHJWBcdG9NzMzukn1tdru2LSt+iuvgHTQH
	 23kZKkH+9ZQIz9XrkjATvNXs9icf8jjZZAGl9c34f7CtKlPQzaYSiQ++w1X3t8lQMXIdd
	 61SGU7WfdHZ4kjR2/d1H1lsTRkQwkf2nYgUvzkyWL3x02zoYHSbK4mXUy0lfbN1MMcygw
	 nef7Zh+RhU054IYTJbqBkl8l6IjFN5G0kWebql7rWMxZP97gmn4N/vxwIkFdsBOrn6VZV
	 t1BVgOp4PzxZoODP8QogzQjQudQNJWpOEuORUdHomoWRiiVnwmGE3yOzqn7VZnCMRDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=evvI6gG1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cO6kwYCl;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E67D60A2616
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E67D60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=evvI6gG1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cO6kwYCl
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGH3k11093800
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=woJtGyolaPSm3epuc0oRfWRq
	EJQCl2Rjtu6xIFO48pU=; b=evvI6gG16yb0OpXZQ8sODJiJeD0hRonbIqh306ra
	xuLTFM1G8GcuFl5y7nIH8r9yXtxvkwhHASzlgE6xaS4oG5AvC0h0LygXzvXc8zHs
	SPtx8lVyt3KLLINiWrVUc3SWNGPGP8Ia8/Fr6QI4Gu2LXcgOQmYcM3dluIFr/HOk
	w2x+kcsvx9+s4QYNcgmsXdAbIOJK6Abh/CRHGjaPbrlBiyGsfl8C83R9/Lu4taHo
	GmUfF6iaB67NjLe7g2TWT4Cto8mNG7lzX75auIKcCEWD7unPWTRFOXO7JuwsSSX0
	knEpQgDNcmvdSk9UaI3Y+/JVHd8woyrD3gV42U8MQ4/WYw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ma0t2dd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:38:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-949dc497896so178767285a.0
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 11:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795462724; x=1796067524; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=woJtGyolaPSm3epuc0oRfWRqEJQCl2Rjtu6xIFO48pU=;
        b=cO6kwYClcMioVKPOlkJ23vUVpTMKyBBpAjqucHh4Fw0oFlEhoqrfCe/Jp5Zq/Ad3Sh
         xKIrKodOY1RbVtUhL/p5n4U4rE2vFLUKSYKEMqcF8zhxAJtXq1eI8dHxeDO07T/2DRvY
         ddxqHiiKLPljVrxe+APv+vDqKwgYu/cDIOwMvJ2QnpVHbJlkyYp/SQRgWSO02V3ofei8
         QVrYM/7j2LPZ2AGSLtY2riuffMwE2wI0FjAYI1SEXIEpEBhhyPUITKy6fsApDgjuN05n
         cwY5x4+1Xf6B4qp3TRrnxjt/EDT+0BSIGOL6n9Ezb0FRLELZX56dAHMO3AZOC4e0kvNY
         txxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795462724; x=1796067524;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=woJtGyolaPSm3epuc0oRfWRqEJQCl2Rjtu6xIFO48pU=;
        b=KuLJiKxu1vORBkdfJR/ng/TuMH+/tlnvo4GWcNjc5V8rZOdgmHZoVv30OwLZk+3EV/
         tBj3XoSkq1FN8K8kkXXXWPAZqXitEZ+lFjHN1M+wZf4LUHOImbX7RzcvlXSpi1kYNnH7
         /QWSc9F06W1Jq3TkjCYasorJNHoGUa9+YWKgt2wiQYzH7GK7DditKkHbAl8bGYFO5sij
         ESpp+7+sW5KeEkIz/nWQbU1iwDuIcdPNhez5oeEntKdbU6p1ctdezT/gs1mX89XMYQ2j
         NOraekMwErORBJKqpRxwymLANpXkNZoe4UuMEQiCvs7iSFe4EkqoZIh4Lq5zeEE5fVLp
         /ckQ==
X-Forwarded-Encrypted: i=1; AL+hErHfLmYcVCSlfGIx7rCtA877HevaMuC25NH+uEz8xxg0yNhJAQsI10mcrFLUlTFWtkxAa+uCmA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8ZCIdihRIJyQgCDLOEyyBJjhI+q7h3BGPtRyHbiZMTedt5FuP0
	a0WIy23PqWio+7iUsMdgcOjHcywhh0J4v4wNokYduHqpnkUROg5R2VWOuzxtAVe2BWkcMo8ASMV
	vVFD2jEW2dbpFYFIzO+LeNFd2Vuyz8N9p9QnB2kdIEqj/W3ZkHotWqBz2gQ==
X-Gm-Gg: AZFdTZcni7mLWvu7NJqgDepU0FVgAQjHKpJ41yJjzxK/g2eG4yec6DmQZVv0gU/CMse
	iBjfCFtai0F9dlC0FxLIsIS4Qit6Ov1YyjvVJeD90Qw4yb+mqh6JIXoax3KVvzWsExzqzEO1r8S
	NbA9T6eet/tULH8FmLd8lJzZHPI8pMHshzQrMMbpNY415/4bO/bRdW0K8h0c6RVVIppvH2pYOch
	rQOcMtn/4NVockL8hnBGPatOcgyI2Yjl1DkoARt06GDVlDCvewTovilGmqb3mwHqYBlFAX6r7kY
	dB8nhEZvoO/Md1ZJ1Y813zFPzf3Nmy09x14VslhDjZ/Y3XuFXRuoRCMBBqqWdS5akwSjw8MsxzN
	J0O1mhIEhglRZ34HB4czDi8YBtLjq40DaBEdHwHTipeO55l90uTfmILMz4G3O5bVa
X-Received: by 2002:a05:620a:454c:b0:93e:c12c:fbcd with SMTP id af79cd13be357-949bac7665amr2007144985a.73.1795462723820;
        Mon, 23 Nov 2026 11:38:43 -0800 (PST)
X-Received: by 2002:a05:620a:454c:b0:93e:c12c:fbcd with SMTP id af79cd13be357-949bac7665amr2007138285a.73.1795462723165;
        Mon, 23 Nov 2026 11:38:43 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb989e3sm24078327f8f.52.2026.11.23.11.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:38:42 -0800 (PST)
Date: Mon, 23 Nov 2026 21:38:40 +0200
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
Subject: Re: [PATCH RESEND v4 04/20] arm64: dts: qcom: lemans: Add GEM_NOC
 interconnect for adreno SMMU
Message-ID: <xadzsuftq6la6asx4r3cdknho3hbjljpkrqr4iblwowbz4fhrc@yt2dbeff5d63>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
 <20261120-smmu_interconnect_addition-v4-4-be30526391d9@oss.qualcomm.com>
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
In-Reply-To: <20261120-smmu_interconnect_addition-v4-4-be30526391d9@oss.qualcomm.com>
X-Proofpoint-GUID: uzrWuxwf31yDjLJYz110nOc9m2UtZEQp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX63mkh2Zr+DXO
 n1vdSGDvH1Gu+E4vs5mAoaXe2RP53XqACn0VyScav+wZG28tMjw2/zZxWJ9+fibJ540A8nxfbo3
 fY4w33MJeaJqq7wHRCvbw0PDV0W+U0U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX1cEKWHXHV2Hy
 4RF/CDvqgEqa93jO3TnOJ2y1Ed+OKPNy7LeuOQjRdqHWSMLpPDwahn+dnVEuYU6VGR7uubQ6Kf5
 RWOsINnf2fDqZ5FXBi9eSnbbCZ3OPFqZqboxj45Q5let07cTnVTe3orx+7gvQBgittz61vCi3bT
 xovWhse+NT8VuWBZZoY/hhgmQmtMfLHTebSb4MjfPlO9Z370zlWLHRYnvxhL7hA9jL5c/2eg2YH
 8u0PyZQKSs/BonHSyLtU399aExQA8XW/cMebjTrDavk1c9IAPCy4AoBfw9Af3/dwyXMEm0cnmzw
 R/XdA4cuYlE+2OHQRDIvb7CYIGTiI3VFunKVVWD9CqgQIcos8PXk1EaggbDAj5vzNEQW1lpsV7+
 TbKmgqVgKpo+w/sSQCgN8mmk95nZuFMVKWZbCcvUkMNxxzuN3R6equgzLJz5ibbpSf1pL4TJrVE
 cbEjMGeWBuurLYBIPmw==
X-Authority-Analysis: v=2.4 cv=Yr+a1IYX c=1 sm=1 tr=0 ts=6b049645 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=umFhNDnhut0qF75FkN0A:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: uzrWuxwf31yDjLJYz110nOc9m2UtZEQp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230078

On 26-11-20 19:11:35, Bibek Kumar Patro wrote:
> On Lemans platforms, the Adreno SMMU requires a bandwidth vote on
> the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
> are accessible. Without this vote, the SMMU may become unreachable,
> leading to intermittent probe failures and runtime issues.
> 
> Add the required interconnect to ensure reliable register access.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
