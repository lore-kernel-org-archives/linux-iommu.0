Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793612805;
	b=4LWG4HzZbPX/OboLZAJBB/f0LB9L2IhAN6+ocaHDfY+b897fO7gsPb9RjSXN2CPnJ1AA
	 UbqPp1d9jaFwi59QrS3Fh0KLAskyUt3Acw0ubsTWV53JEn9faUHts40Tz12vY/x2YPtnW
	 myG4HzWNCYDGpRWwY79GZJIMHilu7KS8GadkgWZvayBqdggwsRh4QuRPaI2HBe4jOlIVt
	 7KyzwFEp8oZOmFASjYTcInyLmonMneLTkWvaPnKLcA3nVoPQONeKeZZzlIluJTnvoaPpH
	 9QqHUEbHDZ+5M8zVkD7pQ09TE1DRVH2D+7dKLP6rwyweP9ZPHTfWBYWZrRSv9bniZug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612805;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=JX0UDfE2BLYBOQa71ajvS7Kz4Yisvd/Cl2QJBj5sKnk=;
	b=iCnL6zoqsYx1/J2uvBDTL5w7rcIwaql1O0l6WdZCX44i+YvRAu1yOOxK/xmcouYS276q
	 ybOOs/0UmEYyNimQhmRR4AqXdue5ybHa7QrWc/2oM/3e4z3bf5BqnONJoLBE8IgoyyBrn
	 uWM5r0D/SYYT4K402nSM8GR1DR71wuWfRfey8+PTus0+HE2HLer8BvJx27oo4qCqgiV9A
	 6zabIY9epymXlXKGO+qyv3MR+bVHjCaQnQTxszFQQqOEoV5qWQn53PtBmhBX3K4f2EwjI
	 5GNF18iQ777Z1ixzTDsI6c8v5popYakBaLrbolXGqZ5C19QF6TXTL4tWrMIteYKTnFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XiFHV0BW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jBJvMU5I;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73CF606A331
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 09:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D73CF606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XiFHV0BW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jBJvMU5I
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29AQmR3086616
	for <iommu@lists.linux.dev>; Mon, 2 Nov 2026 09:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JX0UDfE2BLYBOQa71ajvS7Kz4Yisvd/Cl2QJBj5sKnk=; b=XiFHV0BWymHOnOSJ
	L5CIiFfEbbxeMZBbp+OurSVw3H4tFAEof8W0HtHYt1nN5zxF34dTDqLRM7aMFmOV
	659auF767JgzjXGYfmiXAwi7lN3VtajsSGb2ImUWD5MBsdZCZaODoaGEjevdw/LP
	BGWG7J+ce3rNewtPacFuxeiM64M7UZRgo5qMKgOCFqCf1/DDJzxrGR6e4oHGZD7g
	7sIMJLyUMJe0n5zHxMLhRdrY+rI+/Y14Sy00686LO6KFWTy0n4s6ckiweooPWR+k
	vFyNt4dALNRT/wg2HxZymuCklN9DJaGdKoL8bVPM/ND4P4P8THW1/OLFiiKLaDfB
	uviAHg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpka61695-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 02 Nov 2026 09:46:43 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-536540909e5so8277501cf.2
        for <iommu@lists.linux.dev>; Mon, 02 Nov 2026 01:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793612803; x=1794217603; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JX0UDfE2BLYBOQa71ajvS7Kz4Yisvd/Cl2QJBj5sKnk=;
        b=jBJvMU5IIOqW5o/QU3nHnu9hV+UHYhUJRPQSnq8F2emBx1GEexnfXNyGpWfHaTefW+
         lyS8eSIvC0ZojqSGNTybvcL59BgRuJw+ZE8LYEL7/CP1S6CF3ENoE+eorC8xT3doll03
         KQeJZfv/7MaBlcsCahMhPKWlS8ZR7O7brx0FOfJD7Bhixrr0YG7JwdWr+OzcPT73G6Tg
         AortHFgTqtAuwqjk65817t6KW9xDJQCFJ97v4xDs2qhOaHFH2lUBPPmRiHiBUYifQqU4
         FjQF+N7SMcODVqpMBgN4ATe+iZxgCNJD1MI9pQVw1s0Aj0dvgJOtF9l5fCWTQWjL6tnG
         ABZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793612803; x=1794217603;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JX0UDfE2BLYBOQa71ajvS7Kz4Yisvd/Cl2QJBj5sKnk=;
        b=QIjZJckwbhbFLjswLv8WEZEYDEZMDBGkq8l4gi1lt2B0GtLNgw3L5KnpOLe7Q+2Beg
         pzoSXd9XnuOt0kjqUHSPD+T1zbAo/xeDTYRv5dz3Q1v8dQA+FuU1ycsjjID1suKP5ny9
         /BNIodxFEfd/ltw+1/aXnQiutcV9BvHT2Ua601ePeXcYpyVAPjYpE3LqABLFtYeMQATr
         mCtgS7fWgR5h0eUEwo4YyfQzBnVH4c75y8dMYD1FBl1QrMV6NstPQKcMdMFjjayrWjTt
         mPn5tIMkfDl15AwgR583db6sSZ9cD8MsGrFb9C7Jk//iDIOAPbPKXrvgdcbKxqmWrD2D
         3v3A==
X-Gm-Message-State: AFq9FYJSINtKl600u1Ou/V13eQS3/2K7NH7jh8AC+dipMKRHQX0E5VGZ
	W7Ph1i8xK1Nd1zbAQ9ZDVBZB4mn2gNJofYA+QhsO4IkuqoMeMsdLqZfwlqLU96GilgUb9/erSYn
	lCel5g3BzaCPS6uItzAB31iVRsaPdwckyvRxU2hZRP93s8iL+cIYMJzTFIA==
X-Gm-Gg: AYBFou23yBTeUrIFzZdVA/m/wm3u8t79kZ1iZsl8gw17qWJAbUnrBZYXBjoHCcTuxCs
	VIm7jKgkZiXKtT+mQyC7Ywgh53fQ7GXPs3tt2NFr6Z51NZVRLV3sm1f6qCnhNGLgI1Jqaycsy09
	XljLDAVkxH1RC8ReTsdjGGECCMrpWUxqX351Er6SdR5a9Li4g9hCVrEwqeI7/+s53Szlpzq0xlZ
	Ofw2nvh6ai10VUwHNNpikbdqc4pr0DytjINs/7Rme3cd1qrATFDfcLkOJWuesnYJNuJmpfKANAw
	cx1qLGiklcm2Etzy8gaf04rb6FICT/QUXhfXlO+61Fx5W58nhfMAw1q44dx8FuAUxe+W7Md/aQK
	60+3cQ9MFuOapP7olFSJdejDjAdi1+NisvPv1+Ln0LggAElODIUj5PJvoQxJkVM+G3MkH0dE=
X-Received: by 2002:a05:620a:85a:b0:936:2f59:dfe4 with SMTP id af79cd13be357-9442135f71cmr1707617885a.0.1793612802970;
        Mon, 02 Nov 2026 01:46:42 -0800 (PST)
X-Received: by 2002:a05:620a:85a:b0:936:2f59:dfe4 with SMTP id af79cd13be357-9442135f71cmr1707613985a.0.1793612802474;
        Mon, 02 Nov 2026 01:46:42 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe5006dsm362069166b.64.2026.11.02.01.46.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 01:46:41 -0800 (PST)
Message-ID: <798f1e79-1771-49b8-9d4d-705b013255e4@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 10:46:39 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iommu/qcom: Use identity default domains for the MSM
 GPU and display
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261031-msm-smmu-identity-v1-0-a2a70580eebd@oss.qualcomm.com>
 <20261031-msm-smmu-identity-v1-2-a2a70580eebd@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261031-msm-smmu-identity-v1-2-a2a70580eebd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: NdDCj8wS2JeoJjk6uPSBCA2sZQ4voC4O
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzOCBTYWx0ZWRfXyR4s9hhWZHM2
 r2zLKvaspG+tv3GLJ89gjFM8XKCQ5ya4godIhmGZ2kFFCDRIMve94v6WfjuurHfEAgWMJ8aMvWg
 EeT248WeDlkrd5HvzG7W/NQ5flVHi40=
X-Authority-Analysis: v=2.4 cv=ZbyIpcVA c=1 sm=1 tr=0 ts=6ae85c03 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=d7qithtI8vA-lzetqicA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzOCBTYWx0ZWRfX6xT8lfyLzP3w
 x5NDoxwGTmTDsvBf/Dddr/AMKa6aI30l8B8ieFIH+rW3gRcx0HZCxmVeB/s44Z131vWSrZEfYOd
 vO+VkT0IcLHnmhZPTtDzoDTf9jKQGPBWVSZWB988wcXPs4Jz6bC6qWl7maw0kHAdkwT4bqa0ARG
 ypJ5apRKroszwlmvl5UXYNRjFGCTLs0wvLued6BFCQbGJclVS2wwueMy7pZ6GbgBHRsu/HBlaR+
 K36DpQCZWWihlGlwLEie6G3fGRHxE0LJVN36b6s68Za/Ng5J2L7v2rfUnfs0Oae7Q5uj1dkxUnx
 LhlOhd6Mx6TvcX0WqkDSQ6REIkYysX+uyd4uY1kvYkVDS+Sbpk5o8gh/t27QHyHQhLzMtqN54c/
 pPLnC33/eOCKJ3ypkcTD1D3aAWiyFW3qJbTeAVW5k/FprgeYRqKLjkb27n+1vXW1AxZW0KauN8z
 SNxKqX5k7nlMYUMBfng==
X-Proofpoint-GUID: NdDCj8wS2JeoJjk6uPSBCA2sZQ4voC4O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020038

On 10/30/26 11:04 PM, Dmitry Baryshkov wrote:
> drm/msm writes the addresses dma_map_sgtable() returns for the DRM
> device into its own page tables, so they have to be physical addresses,
> i.e. the device must not use iommu-dma. qcom_iommu has no
> def_domain_type, so the MDP5 and Adreno devices do get iommu-dma, the
> buffers end up mapped at IOVAs of the unused default domain and the
> db410c GPU fails to start.
> 
> Use identity default domains for these devices, as arm-smmu-qcom does.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
