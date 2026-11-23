Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462909;
	b=uUUWe1LBq1UFm22/GhF5jF76vd1fxNg0KKsRF8TS2kh1X1viYQM7thKfNxVmSXq/2yr5
	 ZH8czu9mXo5VgtHsQm/br5faW4Asf58CuJoaRJJ/ctvxAKqo2zht5JVBVcFhOK0Ap5fe4
	 9pjL7qeEnNI25B190mGl/nylIKcXuEJO+A4s5s7IPt3hdN/wE34AFO55wQBjVbGJ0Vdau
	 ZxDJNjUnBqutbBRr54GTbIJK4UDq/Jm+I1EW8ttwaoAjefCoMwX3HQNVmbKnX6qt4hlkE
	 QpSFb84BlqLrBOZn36eMb/cnWo4z6KTAMZjhRx6mP03FNvvJHXaUifnVFHhLfBtdbXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462909;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fhajorqknMVWTu/OeYgSDpH4HYLQIjY1Z2rYoHbqGco=;
	b=DB0sVmnwzfHu6sKLYOew2Kvxr4wiItwkh3LTyeFMvbkYWKiK6L4rcgcy6/Y8sSp7qPaw
	 cpzYF6CE2+TcPK913rrW08mag4KIiYt1NNN93mUBxQ0Dvrp2Bu9nk21Pv7O7TNTE8SlvJ
	 FVM9VdNEykIrItv5aBAodyz31w5ajv5rgG5WZpo/ZYTCZYN+jAUZR0lG5G5W6CpdYIEud
	 i4aKM5kZmqvPPIbp7yNvkS6v7knM3ts5mHheI/5SBRNnB1YqVv+f90tGLWmG3vv99CDk3
	 rI0Sm7fsrsOpGttrTHi4AVqmDx81wUJrLGIzZWeXa0U/WqSI0LO+FEDzpPh26i7c4jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a1IV8A8d;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JDlk6qGn;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA3E606A31A
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EA3E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a1IV8A8d;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JDlk6qGn
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANJNKhO3440246
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fhajorqknMVWTu/OeYgSDpH4
	HYLQIjY1Z2rYoHbqGco=; b=a1IV8A8daf95qZ2Odpglrdwrbg8g+pmFIBoDfUk1
	Q0hFEqYN75XFdqNfo6dwlXNLnzXuupGJiWHsupkEx++C6a609ZowOUiGrbl0OMw+
	+prfpJWpQqZOjBBYexySVC9ukblS8varamMvEPEeiLra1Bc6qe4McaS/VoBMJr6R
	a227v4puWMSArvQL7YtxaqByK60q22kvzZePpGbI0wRB0Y+9hCH6vmhL5r8Vxc8w
	QAVi+U6rMANRi3mpcjSXrcg6gUfgGfjaZL2WHPia4wVEI6qDoz8NoVMASTBNyd/C
	FAB6qw4wqzzbccvlfLftF8PZQNn90/71gkTIJ3qNNB43Ag==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ukr82fu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:41:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9496ff065bcso514018585a.3
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 11:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795462908; x=1796067708; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fhajorqknMVWTu/OeYgSDpH4HYLQIjY1Z2rYoHbqGco=;
        b=JDlk6qGnJi6B5w0TF2dMqz8QiHyGNxRsP9wl5AkhXq/FJs+znzhGOJt6vGCxa0kbF/
         b1dTbTqKnQhN6+eN3LB/WPp2QBoMgAqh4VH5P4waBFLDpnWkTKW9eRFi3ulEI7qQJaxR
         nHn1+VD6XYSAfijeouT+32MKNAjhYJakIerDvjbNrCaC5hbu5GqpOQD5qKRoZd9TGZJF
         0We2qeQb1nU2lm3U4sDMf3XiFii4iVDdepZqSj7p9fYjMwhILt76Rb0boR6aA7BVaYV3
         JBNz5NvWTJw6Z8kqwwd25zq5TY0HMVKPVv68eKY2EVB/YzzvWclpJIfkskgE1V5bCsd4
         B1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795462908; x=1796067708;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fhajorqknMVWTu/OeYgSDpH4HYLQIjY1Z2rYoHbqGco=;
        b=SoPwswRIsAbVitjeMr6m1tdEBq5zmdKeKki3n05zs4O8nzv7JAAWp9G1e4BXmyWZuT
         T+bV4xZ/28E6vz+ECI+By/NK+xBER2PaDHtlB8DLQhX2sa5TEYaJsxq3bwcdyxsvuEGg
         kItF67oOZYQryGf4wfl1PX84w92xmMIuonAtZe9dJ3GtGtfwfXBdXU4pTRX2vJPSIxOT
         zZoRBbGD7qRCF3V4B4aJ/hSbEDG+4NjFrI5SPLQHg58M89eEVAycSZTRHZtr/JPHJgJ7
         Cq+aBrMTJNuQ5tOD5wgolEkDKV9u1Oz7trY+rVMydRHzJlJCLYyosD7AFNusMyfGWexI
         /BNg==
X-Forwarded-Encrypted: i=1; AL+hErF/2G275sW+qovWP6KyzRz45k8oJF+EgICemBJFbCESshYTeE81rb/nHK/UsKU/+AIz3D0u2Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z+/u2C76oHWz9ySZWUpCGl9QUZH7avn28D7oD2VmlYOAsyNf9yQ
	JTZ199gIgcs7nU6OmY8uXpLN6lA72vSZSUNXViOg31p2ueI3tUTB7ZzR6eV7SurD+cK0cmdrzMe
	U1PCQZHeaNJ/BIvhy+NxRRFUxnbzNELpzj91iIKCmYpC9LQ216pwlJuS+XA==
X-Gm-Gg: AZFdTZctXche7a/u6pGdLw2MrBX3iPydU/OzlBPQ6ngFCQQraQ1LLP0XkCiZLP/icN8
	qULo5Bd0BT5JuFoHJbMOqaU6BfTxdymZ4Lnta0Iqvugfj87/uvZehDklfbMuyZwkbA9v8P/c86d
	pJPLMB4PGvtGqD/tNfPp/mGu+xDmo3lpajZ6ThdiRCJZoqadl5deIwnG7YlmoRGmipk1XjdMbsl
	6pLMP0iruMw4kgFsIwBfGmOUwt4QF54PRQuEdQgHtfSPs7q/kgUuHA+DIbnoV9YY5uOM6Z+h2fM
	0B30oFDxPoPv/Mls/QNGMy6gpiR2WoFJc4B+0CAq6hsW5tpdxGLmuXu9TChfnW7m8yFdYf0OAxW
	LhhJKX01Cbsyjtb4k2JsrbnbGV0lePryLO62tvPcd+iBeoAwn9w1XbH5s3ze6c0Zm
X-Received: by 2002:a05:620a:132b:b0:949:52b7:468a with SMTP id af79cd13be357-949ba9e0e0bmr2222151685a.51.1795462907745;
        Mon, 23 Nov 2026 11:41:47 -0800 (PST)
X-Received: by 2002:a05:620a:132b:b0:949:52b7:468a with SMTP id af79cd13be357-949ba9e0e0bmr2222144485a.51.1795462907102;
        Mon, 23 Nov 2026 11:41:47 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884ab091sm535153725e9.11.2026.11.23.11.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:41:46 -0800 (PST)
Date: Mon, 23 Nov 2026 21:41:45 +0200
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
Subject: Re: [PATCH RESEND v4 15/20] arm64: dts: qcom: hamoa: Add GEM_NOC
 interconnect for adreno SMMU
Message-ID: <q6s4lgilunj3pikw44icbwuwq3cdlk47uw4lg7iyww6eaolzie@vaux3olznlsr>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
 <20261120-smmu_interconnect_addition-v4-15-be30526391d9@oss.qualcomm.com>
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
In-Reply-To: <20261120-smmu_interconnect_addition-v4-15-be30526391d9@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX4H4hc2GlyVeO
 WVmzzd4nvpCSehkDuzaKmCZQm260MpJboJ3rFeWNUDAW1JlUV+8M9EyZJPKmAwE/ZIAUli8tSMm
 SKSqeVPrc8EJXhqtpj9iyFH8MzpwLeE=
X-Proofpoint-ORIG-GUID: xM_dwM2GDk12r5W6wiMC6XgNwBaOKD4a
X-Authority-Analysis: v=2.4 cv=M+rYuCws c=1 sm=1 tr=0 ts=6b0496fc cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=GtCB4xAyANLfO_zL0oUA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX8Nr38LUqGqC7
 2bjCq04ek0VC7hbImSb0//s/JJhXknKvjyFQLL26c0oSfPaUKntemYYNbVXemXVpACqsmGKovCY
 GDVzAOM9GUMvlCw18D9OwJPI9F3XeZgsfagkIY552KMjv+1OxZoyioCSPakV188WEYLPOdmzIrf
 ODFr3IBkiLEEZQ3Kon8x0h//meWZTWphdEtoU7jrjZqYzcBAKAr3l04Wu18WNWrdZsNifz+bR0p
 d2KFUwU7SfjhXsjI6MOP+w2W922Uk6dd5IS7gRG7erHjrV1f0LQxxWhnhaSPowDFxmeRzEL1cNT
 fidFI8JsgNzYPiJ3Ka67bVxSOqp9fc5XpqjHEVlyg56dIY/Mmd7LpbLyNoLZiSeqJSL8sS/0vBo
 r+rixITr8S3mDOW4QcChl+stp78f0tOJ6l2u1yENmWbDGYCjhd9d19MB1i4QSvSOsQxllPGsPUs
 EBg0KQfqhOSlRcxKIAA==
X-Proofpoint-GUID: xM_dwM2GDk12r5W6wiMC6XgNwBaOKD4a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230078

On 26-11-20 19:11:46, Bibek Kumar Patro wrote:
> On X1E80100 the Adreno SMMU GPU TCU is a separate hardware block with a
> dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
> interconnect bandwidth vote, the GEM_NOC path to DDR can be left
> unvoted during sleep/wakeup transitions, causing intermittent SMMU
> register access failures.
> 
> Add the required interconnect to ensure reliable register access.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
