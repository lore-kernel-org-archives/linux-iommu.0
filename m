Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719797;
	b=FVKK7XST3+1f8FkABTX/LPWeMR8I+TFoiGzdEA9nwC+YkJJ1rfjCBSnITWEvIl1SJGIM
	 qwPiBmCeB8UWdHH2uC4+E9qQlt15haP+zdVyGk1ThmNs0wpjcUZGmsFS7fHvQXDL409LH
	 WE97PUlMfJEy/j7N/Kmk9+6X1RYVQ1msviLmLW5M+QRNilwrh8TcrDj2IYQ5SxwPOMVFQ
	 qQXuMLK4Q0VmVwAF8dPtSaiMmlRuBsAglXDQcGmBOPaLb/JrN+mp/L1/FG4a3XQP3vlBw
	 +76w6Jtzikm9qgjTqDOXkzFJ0bla5dIChF7uHtrQLxfIu9IaxVRc3gMlM1Lb3z72SXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719797;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RzAwmn1KqONWs6eIlRenG+fOoEFpFouVi0Vep/WmIJw=;
	b=4LWOfHp1BTQX/RMKT4B1M8FYDrGlEfdgwC0OxPzg41rZnzXzeoTHm3mggYTi4ZYFyrdz
	 Az86cmCCC8F5kXaoOp+H2uL/A+VFWmBHhIcUGnCSRukGUQmls2/rxLpJTu048tGWTTsDT
	 gDgnWnTxnEnD290vnCnuD4ZMOqItqIBPxYZMmYC8W1UtT6x7m2IT63etTXNmgSBrDnbDx
	 es9mwVw5smdEKYDUoTIvZkWAYyCeLME6TQh5nADg7ZLxXA7LZkWEYwIqy6ttpVzaHIFOp
	 xHiWNdAsnY/se5ElxjsqTkX/aMCq3ZeryrL5YrRGDcG766JhHEmSIOypbqZ5StrVJ3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OiaEb7tp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L88Qthnv;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D329606A326
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 15:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D329606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OiaEb7tp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L88Qthnv
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3E9qXJ4103896
	for <iommu@lists.linux.dev>; Tue, 3 Nov 2026 15:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RzAwmn1KqONWs6eIlRenG+
	fOoEFpFouVi0Vep/WmIJw=; b=OiaEb7tpyJlOXnQBKO5HXYHqU2QXQBLRj5DN2s
	J9m43VarO96/fhzBkqOF99pH/jp7CWtEd/7gB5g1obL/Bic81XJYCHaohzZ9l0xA
	L+lHtvzwMr0+EZwyBMpRGgDIamcU52pS6xKLVo3lnjqY/CW7vfFF70dfPu663YXp
	nY084CVXXX7M9tr1eG+Gk3Tld4uOjtgbHBopSwWz5AZc5phqE6SM5BQbwlZG3sXK
	wSM+nWcVUYuiimzvXkGUneVvCBHfi8DB1N11earN6dSoaSAKuDC8svxOHbUS+GIA
	Ic/5z2TXwadvdM0rxALUyXhXU2bc3F9NRqopaWEGqbBOcIRQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq76daudd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 03 Nov 2026 15:29:56 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-351788121cfso2264850eec.0
        for <iommu@lists.linux.dev>; Tue, 03 Nov 2026 07:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793719796; x=1794324596; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RzAwmn1KqONWs6eIlRenG+fOoEFpFouVi0Vep/WmIJw=;
        b=L88QthnvZVs8Yov0RmsVEeQnjedqANxxYq/TtwFY/lxTeus+wW5CqCzF6S9L6hq8F5
         Tm+rcXkS0ug8ztAXZNzJ+drE4CRSIYtoCKRSVXfg8fcpdlVHxhbML8D5Wa/kzyL8PgYs
         gJTMXzdYbPqWXSE9xRCCX95I/DTkMYgdMK3R/MQGbsJFwD/rOrxg488nSVcYi3qDDClH
         RFLpk9Ub6sEvxV29h0h6CKGWKTS1rqdZXQya7iW3QYegaTNfpQZSRDxt0sdA6tswGBEf
         BNMWQ1VaKWCjKH5I6U30sPGbcU9DaJCf2H+fCVDl+nuoP17gD8jKLOan9XWG5dUPG0oq
         wQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719796; x=1794324596;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RzAwmn1KqONWs6eIlRenG+fOoEFpFouVi0Vep/WmIJw=;
        b=fvR2x0wWcdty6D7MEGmhnx7nasD8XIH2xE4MMGACrPf1cSUCOOdK6N250VyLfeR5t5
         SBB/37pRqnjBC4MVoKCs+sbmyzEYcFBPli5QBGJuHcZVqqOe//GtgzCItLWB/7QT9q8x
         0h5E0b2FGJCoCVLmyHTofRCw5ia4loQMNx72JbQn30/x7qiNxzXcGKoU+bhALeulTL1C
         D5Qok9d+qcjWixqtANrYPkujn5BF0hsgxUa2yGQ9xD7vDBrNFf3xgFVuwDqpekVTvANJ
         v1Xw4Izh+WzhZSSLFlDAluskc/66JQnmcG+SlFIBm/xoe0H1OTLKm9gl52sztp/yH6Xu
         nevA==
X-Gm-Message-State: APuU4Z88PvsuQ1BeYCXOnX3ky6dgfVPcsEKV5HpaN9obgG2Ekjfg+eyZ
	5qw02it+plXHtN/vz7HAMopLy/AttmCovRVCLGSu0oGsBiSWpDuEX/ZPdFEzHwHwgXfefni9UqL
	xO9KA+mP/7fLhVTQ8dGdOrzm4oBIV5wYx+3ztlZL8Dad+3A/8KUUT6FUhvg==
X-Gm-Gg: AYBFou2HIgP6rV7OnFehPbqwegT5U6ygFu++xvUT+LCmSHzxkHqJnxz0T/3EU6yAo07
	ndMAz/ntnYTMcCo4m/b8/ta+qBkUcBRulLeDDXmwo6RL5lQdqAuyUkiYkXpwwfLz47uObHFg1QE
	mob1PUk1dIraW9xBTQQv5cQ71LS2paIWwCoPo52eNroI4j5HCVCqPmoAQDnMOdVsavclioXKS7F
	RYJv2YhCpVgl5TZQCL13aBbwj32FNgm2ahgg9fSl/VsijKeiDSOXPUzhFSK8Q87OBcBjz7GA+vE
	w+EeT9dP/S5fSc3mT63o368Abe/U7r2ykT2SJU8GPmAugj1FTFpsF7u0bTA+IlO6zdxegVCG8Hx
	nowENYgNPRca65X26yqnicJcBg8C2rd0FSgPQNt5EEyuogFwiIJmaDOQ01F/ejCTPwWZAxRnjEy
	qwR+hxrKvv
X-Received: by 2002:a05:693c:409c:b0:36a:30b:5dce with SMTP id 5a478bee46e88-36a423a3232mr23680632eec.19.1793719795228;
        Tue, 03 Nov 2026 07:29:55 -0800 (PST)
X-Received: by 2002:a05:693c:409c:b0:36a:30b:5dce with SMTP id 5a478bee46e88-36a423a3232mr23680576eec.19.1793719794488;
        Tue, 03 Nov 2026 07:29:54 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a426681aesm59888302eec.1.2026.11.03.07.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:29:54 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Subject: [PATCH v6 0/2] of_iommu: add support for "iommu-ranges"
Date: Tue, 03 Nov 2026 20:59:31 +0530
Message-Id: <20261103-add_iommu_ranges-v6-0-361f3921a133@oss.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANv96WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHQUlJIzE
 vPSU3UzU4B8JSMDIzNDQwNj3cSUlPjM/Nzc0vgikHSxrqmJZXKacVqSgYWZuRJQW0FRalpmBdj
 I6NjaWgCSac2bYgAAAA==
X-Change-ID: 20261103-add_iommu_ranges-549cf3fb0867
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, devicetree@vger.kernel.org,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793719787; l=1715;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=52kUfvJEjuAQ68NM7IfYjdmCWi0NnQFqIUoegHkYmd0=;
 b=DsGcdPC6bbyZcgbXI+x+d2nTQHP/P17/5VsA0eTxp/IopXFAyFXAhN7bSJu6be09Ke2TJ33KG
 Y8u+E7u3GIUD4nBNAz680SfcfPFwpr+6GDGk0YC9/7/b9OlbVEMWgCm
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=KJTPn1Fo c=1 sm=1 tr=0 ts=6ae9fdf4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7TpIluchohn6vR-9VeIA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2MSBTYWx0ZWRfX3GhoWH34iO5C
 8BbxtK/I8ZnObawgnL6dj/56QqK7poIn8OLdZ4sM9mKm72GUIvnrZ1TIY27qPlhITXFgZ3o8+DD
 A/7evnvKKEPzZYN7LbCltXkfXgcjnl4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2MSBTYWx0ZWRfX4yrHib9+0/Kc
 9b3D/6iVnBArgMzCBcfsO2jzn595dUcS8swjm4kLojof+YFxduZ8WtOu1qbGQ8hdzUuiTlCNwcU
 Gp/bBfx3LrGIRtw60NShegpSPK/1vwDbDM7h65YIx7WtSqCEPUg/i5dPS7RY1cUnLKUiWOToJcT
 +h7s82rkU7I7gydx4NHJTEagdg1tlPyESi+1LV8Z1e7GOc1iEYYdv0qC2za4/syRntdUVyC9tY5
 cRywrfT1wrlvT9vSGzN2gPu1/vYUsNo2Z0yuXbBKxmZ4GHLNh7SEOS3aZRRjhxm6P1RWf2jmu9l
 +Cc9ydOhIBILKw1QuXmgt7HzLuZ90eqw95ZovsRG2qfCdd9WK38te/ZsYDyuhkZzDWp0fJ7fTYq
 Eh+Xqe9+J5AcehOnwbSaCa0k6xPkR6U1CNnCTjG8v74kzHwoTpwQVZdtIRaxBXWHXGT/SsJPjyl
 imrMkbjPY9697vlPnXg==
X-Proofpoint-GUID: WmrQFeM6lkzOvfqcl6pjvDmSyIanCBwY
X-Proofpoint-ORIG-GUID: WmrQFeM6lkzOvfqcl6pjvDmSyIanCBwY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030061

The series adds support for recently introduced property 
"iommu-ranges". It adds the required checks to error out for cases 
which are not following the schema definition.

Iommu-ranges was defined in schema with this PR
https://github.com/devicetree-org/dt-schema/pull/207

The patch series is being posted as revision v6, since the patches 
were initially part of the media series [1]. The patches are moved out 
to get review comments from iommu reviewers, which was otherwise looking 
as a media seris. Happy to move this back to media series if anyone have 
any concerns. 
[1] 
https://lore.kernel.org/linux-media/20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com/

Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
Changes in v6:
- Addressed sashiko comments.
- Addressed comment from Bryan.
- Link to v5: https://lore.kernel.org/all/20260926-vpu_iommu_iova_handling-v5-4-0322ca5dc10c@oss.qualcomm.com/

---
Vikash Garodia (2):
      iommu: use resource_size_t for reserved region length
      of: Add support for "iommu-ranges" on a device node

 drivers/iommu/amd/iommu.c    |   2 +-
 drivers/iommu/intel/iommu.c  |   2 +-
 drivers/iommu/iommu.c        |   2 +-
 drivers/iommu/of_iommu.c     | 138 +++++++++++++++++++++++++++++++++++++++----
 drivers/iommu/virtio-iommu.c |   2 +-
 drivers/of/address.c         |   2 +-
 include/linux/iommu.h        |   4 +-
 include/linux/of_address.h   |   2 +-
 8 files changed, 135 insertions(+), 19 deletions(-)
---
base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
change-id: 20261103-add_iommu_ranges-549cf3fb0867

Best regards,
-- 
Vikash Garodia <vikash.garodia@oss.qualcomm.com>

