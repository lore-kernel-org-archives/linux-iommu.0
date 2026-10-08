Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6470491585
	for <iommu@lists.linux.dev>; Thu,  8 Oct 2026 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454772; cv=none; b=rKkydl2b31UtV4CMIIxiFtUVH2rqTGthItgzVS0xt5oTFNYHpooqqVJRoQZHcP4f9BO8BJ1Sgne6gSicBadhwHnmzaP77nt/Sm/86MFNuSzElUWYN2D+LH9w8t/prmt//oUCLTrR1iIeqlL2GQZPpY3lB1SlZ5wuU6LYrHt6H78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454772; c=relaxed/simple;
	bh=Q+U7N1X2iZ8frTocNg8k7yx0PelE5xfCMhY0GDGx7nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIGOcJAj1DAkpSwmuUH2mYFOm4kseoZAf6tkCKE5gthXcSyf4Hv/t2lZV8+Rw6m9fWeZ7Q9ZKAYtiiuwD8EJtkZX70EbZgjYXjzZW9tiLBi+XrdkvwG/Cy/kccesWajtB7iYnpLnOQ9chPsVsXpJBEOSRe1lxaksJ0S6GIGa0jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lp7fiQ4V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DRgjILAZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lp7fiQ4V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DRgjILAZ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987K9u92560087
	for <iommu@lists.linux.dev>; Thu, 8 Oct 2026 10:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=S92mSD6nzFAHFvI5wGu0aDKr
	kCuwEVmxByGF5utkGRw=; b=Lp7fiQ4VcAu1MS6PlRHXbvCKrkUUV0yUBUzrQNNP
	Derk7SJx0BYRNygC7aa1r6/C2uL5O4e7cMxEAGvcM9NCjxWgKQnm8nNyU/KC6DUf
	HsvWN4GufGZnQBXYvcttPcNjH2V92q/zTXtk1lJKnHro1tLt6jcV89iGrcwazIOG
	RYenwL2Ds/aDSBwody4KZKqm+hcDOHHt7zYcYOpXvFIODh3UvaUINc4QCtcZHOmz
	w+qj0IiUY+KW+1z+XjtL7bP8SIxG0H1B5MEr3nrw6zX/c3sEOuToEXyktOg5Z5fJ
	+21GIyE2m2DHkU4RqA4SF3TSWXTRp3SVwiPnIRLilrNa9A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe82c6p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 08 Oct 2026 10:19:28 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91961d4b31bso101499586d6.0
        for <iommu@lists.linux.dev>; Thu, 08 Oct 2026 03:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791454768; x=1792059568; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S92mSD6nzFAHFvI5wGu0aDKrkCuwEVmxByGF5utkGRw=;
        b=DRgjILAZhGmWHbTN3EMD5ZxNaWrbOJ0z1EtVKZfsjDX+vmDZk13yvk06T7RldVXOFX
         92RX65xQYS/15j7CUdOjk67F1DBuC9+MKd9GpEmYqX5wETccXBMjuicfGmcgs46KMqLe
         dCLoaOnBVZFj3KUMtOaOG+q6PyKjTOZW8ZIDCKqrS/490QLNhkFl/0/mQUAZGcll97cG
         Zl/xTcc7ueHAd+necjbKQfkgLJe6Wa44pBBwBujoNMSNFe3EvIM9AmPCFmgXwKnbKpRY
         NZ38b7s/skEkjuKnOXjLkiidWhFjMUdFg0IvOjD73sEV/Sjk+deoaEQIzNAfyUR+g2Yi
         I6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791454768; x=1792059568;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S92mSD6nzFAHFvI5wGu0aDKrkCuwEVmxByGF5utkGRw=;
        b=lpj4xQVhSs3dkEmaiO0+vuGAND/fPDhXz7qPKFIDlNA7oK7U/p/8t/qC8rXK54TJNH
         TflxvLH3a68vrCSZ7RXbXWBsBGuOd554nOFi3SCtz5G/+OaIdU7Hkt7eETS5jzp576Nn
         giscLWJn3rmh0qexTPSv4g0dAcwtW2VKni517Mu/CxvTPA7JK6FpvL1ZBviwTrNUBgMQ
         IvEjg9pZrwJfkQpAmvDtwqwdQEuEo6cuVTWpGVIfscVvKX+9pskme1VuDd9DGtzoRzZd
         ZhAQkGhiAx/NN7/zEmi5k3z7wIpbg1xjSCMpUUf78f1WddFFO762XcBq+8dh50daz9yi
         Hp3A==
X-Forwarded-Encrypted: i=1; AKwUvBzMOJF5oGwuIqzq73GjPpnFAsURfqxVq7esRdwyQv2YFYV2R+Xa6M5WHU6AAeMPB4r283DwHg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLROeV75x8C8OsV4WC0tyUIEHu3upJkfqd7uF+ECDisWzFOxmC1
	xC+MKWZOltznnZg9pmuU+7LHeS57ngfrAOxqIjnL6/aL1dUDIMMaIVcKaOb1RgBbedIMjZbXqny
	yQ3odd8aR8mgjKI4DRctwfyGzzTI6Yy0/SgZid5KK/aa2x93z8pmdEkLm+A==
X-Gm-Gg: AYBFou1znMRhudggm8omLA4JQZz0wcYsnu3dF91hyy4JdafuWGYfcVBspEVbVlxFyc9
	0My6QDGetTFGKSpXR0oNCG/Cs6t2tWPUmoJEfJxj7A5j+H4W//KHTtDD5VXpwq71Ijk1YASta2f
	HVxoRniKzCUpyhFiUcBvYmO/v9zRbK7Ketgjf6iQelawAk21PN+V5Ja0S/G/QvjVk8MaUNqDDHR
	VnJdmj+6irV6qa9gBNy+Vdx0tSLSwj8hUdS/TN+bP7rFjOLvCCXUHLRdf/81Naq7ZGff/Ywy6Ay
	5lc+E8i+JjmnpmgNiXFeqPGhuVS7AyQoq6UKB8diCyQuYOfFrmZ7XosnDnDRIuqvwNO+DoQCqIj
	qyHetLZC1/Oo4KAXSfZODjhBsVXYz1MRypeEkRXYU21IqCqmai2PvsZYJyVUuFzhrGref1jy5FJ
	N5mh/7Y1FDvcll
X-Received: by 2002:a05:6214:f0e:b0:90c:b843:d679 with SMTP id 6a1803df08f44-9199784318amr96341956d6.29.1791454767975;
        Thu, 08 Oct 2026 03:19:27 -0700 (PDT)
X-Received: by 2002:a05:6214:f0e:b0:90c:b843:d679 with SMTP id 6a1803df08f44-9199784318amr96341536d6.29.1791454767485;
        Thu, 08 Oct 2026 03:19:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a9a1d756f3sm16832381fa.25.2026.10.08.03.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:19:26 -0700 (PDT)
Date: Thu, 8 Oct 2026 13:19:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Abel Vesa <abelvesa@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v5 11/13] arm64: dts: qcom: monaco: Add Iris context bank
 subnodes
Message-ID: <tokbngwltq6n5aeu6tcl7hgbpfugxcipptbj4a2tkpinlr4vxs@vlilcuxjtt5k>
References: <20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com>
 <20260926-vpu_iommu_iova_handling-v5-11-0322ca5dc10c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926-vpu_iommu_iova_handling-v5-11-0322ca5dc10c@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA0MCBTYWx0ZWRfX95OUSgYTnaH0
 VBMYdQe51E4oFJtaP/kU17hcPwxcaHj+RZbCX/o3t7ONTJ4SDZjLVDA9OmHMAMr4r1dPN+k/dYh
 +ravAqxghNcoqi1vsRP3Hk4dhPjurqhZPxOIndjBVq1Lq+Qcd7niLZ+ktzbq8iECenZhUXFeGD3
 ZD0CKwVTy48Z+WaILuNI9mQFtuB9EXqVFSHhyjhTEZURohampHOWA368tf4UitGPyOmw5QKleQU
 c+vGpxqcBDg/dWVyJMWd7MGz3Z2BH//4QQwd1hKElXwg7ZJNy5P6l7Vy1NfAKbR+MsklrKaClNh
 6F1274u+N/Wm4IQvqipVbPWwOOvWVAXkjU5yv8BcGGthcaCbmKqV61y5fheaDF//ATBgnGY4xWk
 6O5/ycbxTED5q756tL0yVtL2ktrDMnkJmo1f2EIo/UTWDgcsP8KAky/PbkZ6ZAGEaRIp+KpHqnN
 +7dEzMT0uvMGTQmB7+Q==
X-Proofpoint-GUID: BDuoST_uqH2xqQ9cK4utBe2bklWBtMot
X-Proofpoint-ORIG-GUID: BDuoST_uqH2xqQ9cK4utBe2bklWBtMot
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA0MCBTYWx0ZWRfX8es73MFSZSyC
 ivjeRg6JfyW+0ISFjx8gVuCdNWLf1Dn4ZlZXiuvQm/88zbxUJz/iCzt9TP8dA4cO13TiT84ZJLB
 0ShsIPsdmOzUFz2lNNQ9za7StjzYub4=
X-Authority-Analysis: v=2.4 cv=MPT1C8Zl c=1 sm=1 tr=0 ts=6ac76e30 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=G2U8quZLHxfXJRKprjwA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080040

On Sat, Sep 26, 2026 at 12:04:10PM +0530, Vikash Garodia wrote:
> The VPU issues DMA through several SMMU streams, and the hardware does
> not give every stream the same addressable range. The non-pixel stream
> cannot address the low 600MB of IOVA space, while the pixel stream can
> address the full range:
>     +-----------------------------------------------------------+
>     | non-pixel stream addressable range (600 MB - 3.5 GB)      |
>     | 0x25800000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+
>     | pixel stream addressable range (0 - 3.5 GB)               |
>     | 0x00000000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+
> A single "iommus" property on the video-codec node puts every stream in
> one IOMMU domain sharing one IOVA allocator, so nothing restricts a
> non-pixel buffer to avoid 0 to 600MB. Once an allocation lands below
> that boundary the hardware faults, which shows up as unhandled SMMU page
> faults and spontaneous reboots:
> https://gitlab.freedesktop.org/drm/msm/-/work_items/100
> 
> Given that the address range restriction is for specific VPU stream, it
> should be ideally be moved to that stream. To achieve the same, a subset
> of streams is now represented as subnodes, so that each can be
> associated with its respective addressable range. The design was discussed
> and agreed by mainatiners here
> https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org
> 
> In the past, this limitation was addressed with an iommu-map approach,
> with the iris driver dynamically creating the devices. That approach
> was later concluded to be a hack to avoid having subnodes, and was NAKed
> by the iommu maintainers. It was discussed in detail here:
> https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org/
> 
> The video-codec node includes address-cells, size-cells and dma-ranges
> to declare 1:1 mapping for DMA translation to the parent.
> 
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/monaco.dtsi | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
