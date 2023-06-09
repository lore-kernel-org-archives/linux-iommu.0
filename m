Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D6379E5
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 12:57:07 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3598YoIl019492;
	Fri, 9 Jun 2023 12:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=XDap/RLx90TpKRtS3FCfuiDB5INUakMPRohKQfJaizA=;
 b=AzeBbD79DKXc1phU/BvpLv9LPeMHpS/uEJfAPAIGKU2HqugPrdch0aT+J11g4WKesn4t
 OsUcnTnCkRtmW5hSA149Kfe4pyyl5evMsROsEfhh1awIcs6XBzfIYUZKMm5vVZfaPvqS
 cVcJCK2wddjd6FsGGWSo51+bD3+rxl4KQfi/02sMENo5OOFNPbmFqE3vg4B2IKmi8JD4
 SHkzU6e3Ax3zsZDz+doqJ9npVSNRlhIr303oiw0QPqPogAVDLwnghHmJZbCrHoQzW9cg
 BTqttEHJt/ToLN0FF2d9yopHFKVTTKxSEwZmORZMKQyT0W4+jnOpHev10AHsiTgImKC1 nw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3t70h47a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jun 2023 12:56:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359CufQA010963
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Jun 2023 12:56:41 GMT
Received: from hu-ppareek-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 9 Jun 2023 05:56:35 -0700
Date: Fri, 9 Jun 2023 18:26:31 +0530
From: Parikshit Pareek <quic_ppareek@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg
 Roedel" <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        Adam Skladowski <a39.skl@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <devicetree@vger.kernel.org>,
        "linux-kernel @ vger .
 kernel . org Prasanna Kumar" <quic_kprasan@quicinc.com>,
        Shazad Hussain
	<quic_shazhuss@quicinc.com>
Subject: Re: [PATCH 0/3] arm64: dts: qcom: sa8775p: Add interconnect to SMMU
Message-ID: <20230609125631.GA29252@hu-ppareek-blr.qualcomm.com>
References: <20230609054141.18938-1-quic_ppareek@quicinc.com>
 <79206b05-674b-1f6c-6eb1-ed45e6bd5637@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <79206b05-674b-1f6c-6eb1-ed45e6bd5637@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZhsxboR9byCRtdwLQRqycz4m3RQZPuhl
X-Proofpoint-ORIG-GUID: ZhsxboR9byCRtdwLQRqycz4m3RQZPuhl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_08,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090109

On Fri, Jun 09, 2023 at 10:52:26AM +0200, Konrad Dybcio wrote:
> 
> 
> On 9.06.2023 07:41, Parikshit Pareek wrote:
> > Some qcom SoCs have SMMUs, which need the interconnect bandwidth to be
> > This series introduce the due support for associated interconnect, and
> > setting of the due interconnect-bandwidth. Setting due interconnect
> > bandwidth is needed to avoid the issues like [1], caused by not having
> > due clock votes(indirectly dependent upon interconnect bandwidth).
> 
> [1] ???

My bad. Intended to mention following:
https://lore.kernel.org/linux-arm-msm/20230418165224.vmok75fwcjqdxspe@echanude/

Regards,
Parikshit Pareek
> 
> Konrad
> > 
> > Parikshit Pareek (3):
> >   dt-bindings: arm-smmu: Add interconnect for qcom SMMUs
> >   arm64: dts: qcom: sa8775p: Add interconnect to PCIe SMMU
> >   iommu/arm-smmu-qcom: Add support for the interconnect
> > 
> >  .../devicetree/bindings/iommu/arm,smmu.yaml   | 22 +++++++++++++++++++
> >  arch/arm64/boot/dts/qcom/sa8775p.dtsi         |  4 ++++
> >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c    | 16 ++++++++++++++
> >  3 files changed, 42 insertions(+)
> > 

