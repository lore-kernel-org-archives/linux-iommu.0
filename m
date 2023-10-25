Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CA0F50C
	for <iommu@lists.linux.dev>; Wed, 25 Oct 2023 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vo9uwHAk"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PDQ3pE011914;
	Wed, 25 Oct 2023 16:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=mriEVODwMmqGlFPhZP7OYi+cBWE1ycXr0W5zwFMUH+g=;
 b=Vo9uwHAk0ksi6bMEeA98bWmjXHCQ/GY/JwQTCJLfLDR4YV6zDqzHA/VpenpkxMIsiYc5
 uplVQjrW2dJutWz1W7tRVN1thyYN+lU9UHbcVCZUtg8llj+fDQ+It0FO9DW9/75ASDiB
 PVtD3rxmdZKL1e87/Kt8/N87AMbsItlvTalAsit2Ian+KRTEJ7xLu/q6lQjKdCjDuluA
 az9q7wGJnObyME6YtEgOk9a61Ng2sglM3wo8Wm8CY4M9VzagEB254uFeQSJiY1/7ei95
 ejUaQEo3yGI3AYpXFk75GPR2pbd8SQYdYCapsJC/bah+LUAmrJGn16XhK1Vowba6Sq4k rw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txtw1hhg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Oct 2023 16:37:04 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39PGb3Fb011646
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Oct 2023 16:37:03 GMT
Received: from quicinc.com (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 25 Oct
 2023 09:37:02 -0700
Date: Wed, 25 Oct 2023 09:37:01 -0700
From: Guru Das Srinagesh <quic_gurus@quicinc.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <agross@kernel.org>,
        <vkoul@kernel.org>, <quic_gurus@quicinc.com>, <conor+dt@kernel.org>,
        <quic_rjendra@quicinc.com>, <abel.vesa@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <iommu@lists.linux.dev>, <quic_tsoni@quicinc.com>,
        <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/3] dt-bindings: firmware: qcom,scm: document SCM on
 SC8380XP SoCs
Message-ID: <ZTlELVl/F28rfphf@quicinc.com>
Mail-Followup-To: Sibi Sankar <quic_sibis@quicinc.com>,
	andersson@kernel.org, konrad.dybcio@linaro.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
	vkoul@kernel.org, conor+dt@kernel.org, quic_rjendra@quicinc.com,
	abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, iommu@lists.linux.dev,
	quic_tsoni@quicinc.com, neil.armstrong@linaro.org
References: <20231025140640.22601-1-quic_sibis@quicinc.com>
 <20231025140640.22601-4-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231025140640.22601-4-quic_sibis@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SvJ-7QYkW5KQtPk2rOnInGaEHm9fo-3a
X-Proofpoint-GUID: SvJ-7QYkW5KQtPk2rOnInGaEHm9fo-3a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_05,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=439
 lowpriorityscore=0 clxscore=1011 impostorscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250143

On Oct 25 2023 19:36, Sibi Sankar wrote:
> Document scm compatible for SC8380XP SoCs.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>

Reviewed-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
