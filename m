Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795783280;
	b=YFqkhf2xgvPp7Lr6SteevuyFzy/IESahZP8CT0nsNh+lWu7nQj8Li9rmlurmUFfiqnTC
	 0X2qUOtD+qOuX7AnnxQQBejsWFZNqoYxAPzZKQ75Jp24fXi6ssbgXnZslwstUyW1x84+a
	 YCrHJ9sAH+UTo+PbDNFIE7auJcghdN4jxE5bhnHXI1UxoKyAloo39OQO+P6evrndoGZdo
	 rALOf0VBAjOiycpp8WpUmuORA3gUBdY6UfZCZDvJMCRIfcJdwBuAi3dxf+2xFB7cRTrgv
	 jJUQDlVE0vuZ1P9OpBMb73aCZ5S2kopErscHbJMKSwyCq43wSxRyornNI+DR9FLJIxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795783280;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=21wwXPUWNXnpO7MEvgC88mCJTsCmkOMu2Rh/aIjZfeA=;
	b=OjJh6Z0nyGdbNJuPiT/aq1W8KnqQSaX/CjFeHD+8s15+8t0b2yN0WSEvsk4AS0xlSbq2
	 KPsOAMnZdWSAyBrSHerYmhklep+mbCD+u5xqYSzsHORCq6qNeVuBtEZylCA3CjMab183w
	 wMn651t/vIo9Khtylha5eFw2ifTMrReqHxbdNyd9GX6301ZBA7s/ijZ/vHDrAhQtsxvZV
	 RZiJuzLIoQ3hI1LkpC2+2owEdrhgE59QjuqS4BYJWul7kpFf79OSyPGrVlr+sh24jUodI
	 k6nz0fuvKX1f1qHltHGZE/lJ+r478AQQS9mJaqjSiiQEdgdchMf+zeIf6fR1gm3EaSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UwtlwXbU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LMqOZ9ab;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EFD606A336
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 12:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25EFD606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UwtlwXbU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LMqOZ9ab
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARApFfp2906668
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 12:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	21wwXPUWNXnpO7MEvgC88mCJTsCmkOMu2Rh/aIjZfeA=; b=UwtlwXbUzcwW4iI6
	hSK5ad+HFd/+LYW/fiw1EDNV8nDTBBJmMejo3/qPeWqAnAfb/gBvTp020QIvbkWJ
	2VATnaKNOoa8+APXE/rXKdilHmVdEmCCERYpBFi2Btvw5U/G27VHDc3Xcgj9VUP7
	fbI1uj5gyWF0hF2tzOBXTJPCjXyjIcs1PUaNE0R3YJ+hEf1Hg1gzEiFP2prZ/cNx
	xbdDguTT0krxp26OPzDuEeNf4NkOFhjXDf4iGLtrDhv0+jB8j+VoT72k1JLWeSJD
	A+afRBX8eRb0k5++huxb/J9hnFPnrzshqHJnQWVXUdV9u8/OD7Wu3hB3WIkpQKan
	migdWQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6rf93hh3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 12:41:19 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33713e5e6daso12583762eec.0
        for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 04:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795783279; x=1796388079; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=21wwXPUWNXnpO7MEvgC88mCJTsCmkOMu2Rh/aIjZfeA=;
        b=LMqOZ9ab21jltgzqtP24jJQft4MCtSYNgr+6txmjugHY6r1Cr5xo0LYgmyikT5pNzT
         7QXjub+NSeDcNjlHB+Ec2DjdrkLw+OWo60dfEH2eSFjaIOEhBKR7e4jvKwZXw0foyDL5
         U+O172RX+Hz3WYf/AAeh2v6QaHqZW/F3VIRSENjbZTAi5h5W82slmfNS7TTg7T+MmnUI
         vEUoxWpghYWsKpSEvTiDtSSvtc4RTkWlgmt0JU16Trdjr0QknP9eooBB+XUNqT7f2ifm
         yFAziIXK2mPxYJlk2cM5qRKSwrygnl968amQrXgzfWrqfU2gGfTHwisrzOQGM6pQ/qWo
         Sz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795783279; x=1796388079;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=21wwXPUWNXnpO7MEvgC88mCJTsCmkOMu2Rh/aIjZfeA=;
        b=A6iI+Gfoum9lLAUq4POa5Kye3KqCan+Y2iMZzSn6G9R8mEql2nUxpRd3UKdtB27uR4
         zW5qVqaIJWY5C3UyIH8cehAFoS7etCVZf5rvaBLDWc8y6+rnhjSwxs3RuOthcMuT2LB3
         bdrWBg9As4LEvqv3cc6xpCb1bmaLPsW6+zJJscB3id3MO5d2Go/SETRUTSMHm1jMm+IB
         axuw6GtOGTuhtzM/0MUbk7BcGZ9mGPOp7cnU2dCqqmvs/a7WFuILvWgBrcq60sLwdLKh
         RaFZ+W7MEYHWxnNbRuEWIhTXKGRYPgNK5981FalwOpDRa0glYdlpsXPdHhkaESy39yD6
         HQEg==
X-Forwarded-Encrypted: i=1; AL+hErFbaHCGr43xpygDNTGXU8DCR9XeiJpF1Nh5Ky0OuZD2usv0IQ8tk28lgMBcqeoh8DLH5+n2xw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9eFWZ0lR8BaJXHH9l1PSshM2box4hAiYeF5oVoykIhasa66bhe
	4995oDGgSZFBZGalp0bA40nOYj8QnF0b3tmtZZOV+p9/V935QxMdQ2yAvAQZwrsIdE5NioxIHrG
	V6Jx0mZiCWRXwqxEvXAnMfJPQk12BXsxDFyMm0SIc2s1JpYmkzi0ALmxbng==
X-Gm-Gg: AZFdTZdEEYRUx1dOfTw95PZjs2963n4eOSJCfSU+gCvPtPOzTEBkd0nHqVrdiUNVpy+
	lR2xH3c89D13H7j21VZpVQHtopZHc+C0fYbtc044083awKjFYKJjaAmy/ztR9vkxRN4/Vea1/Ft
	OG4X6A33ULPZahhQyY4i+O1kvS8zdMKHItFk6H1HE07Uh/WGslRDJGJh5dismlocWg6ZNS03Abk
	kM5FdPY1Rt60SQZcj/0Uf8/eeCk1BS5JBVzUAvGeu4MolL41TxKUyQWnqfgcFW1NedXWg4Pydha
	RBqOyysras27AuwInK37M/s3Q6qE3/wMeABdDmSCfyJp403UuOpWUk52V6eVAsB07niBNpAk/SF
	FFTuBFzehmu0usGTllhmevTw8AHHlRUehvZrlAwuTA+TT8DYsRJCtc91A15zJFdoVajjJiRlHKG
	E4m8Xg2w==
X-Received: by 2002:a05:7301:160c:b0:382:c1cf:163b with SMTP id 5a478bee46e88-38571419d38mr22800261eec.32.1795783278688;
        Fri, 27 Nov 2026 04:41:18 -0800 (PST)
X-Received: by 2002:a05:7301:160c:b0:382:c1cf:163b with SMTP id 5a478bee46e88-38571419d38mr22800239eec.32.1795783278184;
        Fri, 27 Nov 2026 04:41:18 -0800 (PST)
Received: from [10.206.111.23] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm82044382eec.26.2026.11.27.04.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 04:41:17 -0800 (PST)
Message-ID: <fdc9fdd9-1b76-440f-94d6-c6c982884878@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 18:11:09 +0530
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
Subject: Re: [PATCH 1/4] media: venus: use dma_iova_size() to check the
 reserved IOVA size
To: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sibi Sankar
 <sibi.sankar@oss.qualcomm.com>,
        Honglei Huang <honghuan@amd.com>, prakash.gupta@oss.qualcomm.com,
        Alex Williamson <alex@shazbot.org>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>, stable@vger.kernel.org
References: <20261127115849.2780625-1-m.szyprowski@samsung.com>
 <CGME20261127115859eucas1p1ae20b01eec39080daf19dbd71aba10e9@eucas1p1.samsung.com>
 <20261127115849.2780625-2-m.szyprowski@samsung.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20261127115849.2780625-2-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YWNyOnQ71f99tvkvZ-rqJVUe6cfLH032
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1MCBTYWx0ZWRfX6qhYVfKCUstw
 Bj47Mm92hfcSYf/fZZUmCObWFoMnviEs87Mb7k+j+ws+jwMUE6SDxX4zks1S3qWGdhb+YWweHZK
 vAePta8OzBrr3cVukbAHGKObAoJmZCSjfBwxJj/LkK4TgP4eXId1o3p30sREOcEIRILKy7tBX5i
 I3/xO/OzRxIGYVcykozkAMiQh+SudjEouY6/7liFFBDp/JxOdQpkqOejpdzzw7Jw+nfoPx17MU+
 sn+so0mUemj5ZIzbHXBYANf2n+6qX1FG72cWe5EppnIOYsz0F2cTCHUMvwH1ShTPXrdOeUAGV3i
 WrcO41RQ3taxCgt7Zrx5lgiLfqGwr0ig4t6oRgw10WZgO8jNy9pkDK4tUsEKw6qt0MvB7HWpx9P
 fEm+dR3hdyJaQL/wVMMckFuTUSe2Ar0qPssCEzvIGXS1ZMrUd8MbcvJmPemVr2cx4G4g71ojrnt
 IARdP5EeIFtOnV/z63w==
X-Authority-Analysis: v=2.4 cv=cpkOAF4i c=1 sm=1 tr=0 ts=6b097a6f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=EUspDBNiAAAA:8 a=umoC_DmSGuEwgYlhGCYA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1MCBTYWx0ZWRfX7DXoywySjnzj
 i6ycwlaPrbfaEDRENXoT/QZ2PJMdOxbOKLlq+R9ySR4qO1wvq3YTkwRX4+XBnMUerL0MJudunG3
 YxE/xTvnnY/Kk29DZOysyeai+pLNZzU=
X-Proofpoint-GUID: YWNyOnQ71f99tvkvZ-rqJVUe6cfLH032
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270050


On 11/27/2026 5:28 PM, Marek Szyprowski wrote:
> The IOVA reservation code compares dma_iova_state::__size directly with
> the requested chunk size. __size is internal to the DMA IOVA API and may
> carry flags in its upper bits, so use the dma_iova_size() accessor
> instead.
> 
> Fixes: 953439251b59 ("media: venus: Fix iova allocation from restrict region")
> Cc:stable@vger.kernel.org # v7.4+
> Signed-off-by: Marek Szyprowski<m.szyprowski@samsung.com>
> ---
>   drivers/media/platform/qcom/venus/core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

