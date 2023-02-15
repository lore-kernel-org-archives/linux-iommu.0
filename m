Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106677B
	for <iommu@lists.linux.dev>; Wed, 15 Feb 2023 00:14:46 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F03JEI021693;
	Wed, 15 Feb 2023 00:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=ddsdczJhsXsfiJeJX5z9f8r0qYEreyvU3Fkv3xiBW7U=;
 b=axmiYSFWwvA+mQe7GdE9MklsPpVvKcsEpu/YOJlAyWlQG3t0gUMFlevFak+fy9KJWyO2
 vipG0l+rERuvVSVAsIvjwwaM8uDGXBiuddq+NKBMGP0+0d6ULcpvA01jcrMOhEcpRBbB
 A7gXsZwTG7IIw4HlH3BpwCxMQz8m+AYfWqp0qweTWlAcnExRs/wrysgjfOLEm0hI6gXd
 8dgQnLwcCZMD4p7PhsN52kmN1DmnCozVlDOheDpgKxQqFMq2NlrrxQu+Adz/8ik284Jl
 yYF3pyQJLtrWNuAcJ6N35aUFdwL0s35t490V/xtAI5r9SBWmDIHo4NeHy8c/WkkzoFv4 RQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nr661adpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Feb 2023 00:14:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31F0EcV4017882
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Feb 2023 00:14:38 GMT
Received: from hu-cgoldswo-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 16:14:38 -0800
Date: Tue, 14 Feb 2023 16:14:30 -0800
From: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
        <iommu@lists.linux.dev>, <quic_tingweiz@quicinc.com>
Subject: Re: [PATCH] iommu: Fix potential concurrent free issue
Message-ID: <20230215001402.GA22222@hu-cgoldswo-sd.qualcomm.com>
References: <1676358214-25732-1-git-send-email-quic_zhenhuah@quicinc.com>
 <2f1e67de-645d-2da9-d46c-d37d28ddc03b@arm.com>
 <6e1b0bea-00d9-6aeb-2d0a-a8fd4650e389@quicinc.com>
 <9687190c-eb3b-f72a-d2a7-964ccd640f8c@arm.com>
 <8fe546b5-2cac-7f52-d875-c66c4458996a@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8fe546b5-2cac-7f52-d875-c66c4458996a@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: R8onNx53jYDsHqaVjgM37EQfX3XwhdFu
X-Proofpoint-GUID: R8onNx53jYDsHqaVjgM37EQfX3XwhdFu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_16,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=914
 mlxscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 clxscore=1011 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302150000

On Tue, Feb 14, 2023 at 11:05:22PM +0800, Zhenhua Huang wrote:

> >>
> >>Yes, Robin. The change you provided are with same purpose. I was using
> >>5.10 kernel.
> >
> >Aha, I did note in that commit that it appeared theoretically possible to
> >hit the same race on older kernels, but I hadn't fully realised that even
> >a single bus_set_iommu() call could effectively race with its own
> >notifier, if a new device was added to the bus at just the right time
> >while the initial bus_iommu_probe() walk was still running. Nice find!
> >
> >Off the top of my head, I don't *think* there should be any major issue
> >with backporting 01657bc14a39 beyond its nominal fixes tag, if you need
> >it.
> 
> Nice for me, will pick the fix. Thanks very much.
> 
> >
> >Thanks,
> >Robin.
> >

Actually Robin, could we get this backported to 5.10, 6.1 and 5.15?
We've only observed the issue on 5.10 and 6.1 (after a recent eruption
in occurences), but we also use 5.15.

Thanks,

Chris.

