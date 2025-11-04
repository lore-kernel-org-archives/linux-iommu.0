Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8FE126BF7;
	Tue,  4 Nov 2025 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246301; cv=none; b=fi2jYsYeiLZgwjo/vGOvhOFx923BH8z2B3i5kqe3x6XfoOSxohmdjkX4eWjgPx+F84X5SzV6qJavRFLr+/rWk0Nofc2gJCyXaKu9UBhEc51V+6FvI+ZZ8SgjlQ+HZtvFo5xoqHIV1NJ3CimC6o085gk1n3KMu/+khhrIjJ+AO0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246301; c=relaxed/simple;
	bh=EesQ3bFoQ5Ph6pZID6R9UNOsCPL2UTmohrwUZnSHI6A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kVxFO+/6VjW070hzVKezSzGmUPFc9XkrU4mV3TwYcKzylCSwIZf6J4uhoKCG1Y+awDNXn5aVDE5TlyhM8zafIEAV1GbU5FeLr5g3vnPIrJI+Xen4d1IbW/B5E3dE497gHK2F8cN3qSRYLu6RucmusmLotlwA/EPmBSuAekmczr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DF5M1Unu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DF5M1Unu"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A48hLhM1538238;
	Tue, 4 Nov 2025 08:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Jt4lK+CPz1gtcXBaDXA3tX2ufOGhU8GLCqX
	kVtS1k2M=; b=DF5M1UnuAMbytWKrq/Nsto/bSBwZEWgzswcMlQ7LPy+Z9zJclaT
	RyqkBlRzfKybrnsFqsbHfhm5zoSrhyrYZ3Bvow+DufEPYwoZjvXutsWgbd0rbchQ
	gfTQTSzEcguSBFBBqi5JJ5QD/16trDW4FT3J3c427dvRB7lEHqmAe8hj9NFU+PN6
	2rD66Z3nsqyJ/bPXNAcB9NLFBP5NqsCyE3cAp7nxVza2BPp6GgR7cU65aRTTGOdB
	AGaKxz0dOUOMlX+26cRkvZZcScu9CZxQA2DzeJVt6Iq4ZoA+gYBIP8N5TJAuAFyF
	+NgQJR1chPIvJ83dgffxAm0VaSCEoe2Tumg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6xjqtrwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 08:51:30 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A48pR6n016362;
	Tue, 4 Nov 2025 08:51:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a5b9m5518-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 08:51:27 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A48pQct016289;
	Tue, 4 Nov 2025 08:51:27 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-charante-hyd.qualcomm.com [10.213.97.134])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 5A48pQKc016279
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 08:51:26 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 389980)
	id E36EE5D8; Tue,  4 Nov 2025 14:21:25 +0530 (+0530)
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, saravanak@google.com,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Subject: [PATCH 0/6] of: iommu-map parsing for multi-cell IOMMU
Date: Tue,  4 Nov 2025 14:20:59 +0530
Message-Id: <cover.1762235099.git.charan.kalla@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VfHWfc601M9CURiVakfOnH6jbyf0P8dN
X-Proofpoint-ORIG-GUID: VfHWfc601M9CURiVakfOnH6jbyf0P8dN
X-Authority-Analysis: v=2.4 cv=criWUl4i c=1 sm=1 tr=0 ts=6909be93 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=bhF1DWh9lIbAOyNiJEUA:9 a=TjNXssC_j7lpFel5tvFf:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA3MSBTYWx0ZWRfX4blLMNUMg8a1
 7aB4471UpTl5EhCoNATH97hm0asJRuPbYqK2OoM2rTa13an7UcK/E9hlWYK3qz2M2of+cWh102M
 0j2XfllRnKkEaRxHJykID5Mmc8IXcBX0wp2gDQM7sKgRyyUFo2Bsv9CVvRXGubNHFR3K1JqesBy
 aGA1tdLDsCHtSGUYv1r3F0Ev3cWhp4ik/S7KSkt0x1b9FlThcopiBqK6wm2zszJ+mGANGDUbayt
 HdBMbvbvT4gJdbvSyB6NZWlr7ESiCmJ1pfSzr0l6D1O3ePvqD/eY63qpUz2mk3cRlQicFGmoIXH
 +EbBO2UuComDXGIjr8FcIZHJdWETmjgGGUa9w7A6tFUMYjjAxc0vRBANgENw5zEUKmIkar+kXit
 VZWk33SeW+s8B1a+CbX1ze5zjR3XhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040071

The iommu-map property has been defined for the PCIe usecase and has
been hardcoded to assume single cell for IOMMU specification, ignoring
the #iommu-cells completely. Since the initial definition the iommu-maps
property has been reused for other usecases and we can no longer assume
that the single IOMMU cell properly describes the necessary IOMMU
streams. Expand the iommu-map to take #iommu-cells into account, while
keeping the compatibility with the existing DTs, which assume single
argument. 

Unlike single iommu-cell, it is complex to establish a linear relation
between input 'id' and output specifier for multi iommu-cells. To handle
such cases, rely on arch-specific drivers called through
of_iommu_xlate() from of_iommu layer, aswell it is expected the 'len'
passed is always 1. In the of_iommu layer, the below relation is
established before calling into vendor specific driver: 

a) For platform devices, 'rid' defined in the iommu-map tuple indicates
a function, through a bit position, which is compared against passed
input 'id' that represents a bitmap of functions represented by the
device.

b) For others, 'rid' is compared against the input 'id' as an integer
value.

Thus the final representation when #iommu-cells=n is going to be,
iommu-map = <rid/functionid IOMMU_phandle cell0 .. celln len>;, where
len = 1.

The RFC for this patch set is found at [2].

The other motivation for this patchset is the below usecase.
USECASE [1]:
------------
Video IP, 32bit, have 2 hardware sub blocks(or can be called as
functions) called as pixel and nonpixel blocks, that does decode and
encode of the video stream. These logical blocks are configured to
generate different stream IDs.

With the classical approach of representing all sids with iommus= end up
in using a single translation context limited to the 4GB. There are
video usecases which needs larger IOVA space, like higher concurrent
video sessions(eg: 32 session and 192MB per session) where 4GB of IOVA
is not sufficient.

For this case, each functionality is represented in the firmware(device
tree) by the 'rid' field of the iommu-map property and the video driver
creates sub platform devices for each of this functionality and call
into IOMMU configuration. Each rid(function id) in the dt property
indicates the bit that can be associated by the driver passed input id.

Example: 
iommu {
	#iommu-cells = 2;
};

video-codec@foobar {
	compatible = "qcom,video";
	iommus = <&apps_smmu 0x1234 0xca>;
	iommu-map= <0x1 &iommu 0x1940 0x0 0x1>,
               <0x1 &iommu 0x1941 0x0 0x1>,
               <0x2 &iommu 0x1942 0x0 0x1>,
               <0x4 &iommu 0x1943 0x0 0x1>,
               <0x4 &iommu 0x1944 0x0 0x1>;
};

video-driver:
#define PIXEL_FUNC	   (1)
#define NON_PIXEL_FUNC	   (2)
#define SECURE_FUNC	   (4)

case1: All these functionalities requires individual contexts.
Create 3 subdevices for each of this function and call
of_dma_configure_id(..,id), id = 0x1, 0x2, 0x4.

Case2: Secure and non-secure functionalities require individual
contexts. Create 2 subdevices and call of_dma_configure_id(..,id), id =
0x3(bitmap of pixel and non-pixel), 0x4 (secure).

Credits: to Dmitry for thorough discussions on the RFC patch and major
help in getting the consenus on this approach, to Konrad & Bjorn for
offline discussions and reviews, to Robin for his inputs on IOMMU front,
to Bod, Rob and Krzysztof for all valuable inputs.

[1] https://lore.kernel.org/all/20250627-video_cb-v3-0-51e18c0ffbce@quicinc.com/
[2] https://lore.kernel.org/all/20250928171718.436440-1-charan.kalla@oss.qualcomm.com/#r

Charan Teja Kalla (6):
  of: create a wrapper for of_map_id()
  of: introduce wrapper function to query the cell count
  of: parse #<name>-cells property to get the cell count
  of: detect and handle legacy iommu-map parsing
  of: add infra to parse iommu-map per IOMMU cell count
  of: use correct iommu-map parsing logic from of_iommu layer

 drivers/iommu/of_iommu.c |  59 +++++++--
 drivers/of/base.c        | 269 +++++++++++++++++++++++++++++++++++----
 include/linux/of.h       |  19 +++
 3 files changed, 314 insertions(+), 33 deletions(-)

-- 
2.34.1

