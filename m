Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FA3231852
	for <iommu@lists.linux.dev>; Wed, 21 May 2025 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747817525; cv=none; b=FyPpQvlNdXDYDtfePEexkPa+ZhF+Kkk/0IFOVd2lApz9u1+P69YiERzMLi68Q9kpqgaJP3UQFcNn5tBRG4tuyeGuiG/8RhO1mitE4Hhk7fEEPLIwkEDArmnjbyuLE+QH+N63WBIm8zrYhOA0kkboMMAD62Sih2TGtSCcetqDrew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747817525; c=relaxed/simple;
	bh=jB4nCt7Z0gWD+wh6PSkjO6o6UVMXIPdej+zQdqt9pEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RE/uwpdgd7mwsuGx0hPDfauv88eV1Hrbo3y/D8Ecj7DQu1NwiNOO8V5pRolnBZkmrOyDHKNbe2wZH3jvGd5Qk9uxLgUQnbA5w7YHchvYaVp6bIIwiAmFzfXFk8IvVUSonsZeWNBRjW5X/UUZjetNwZIpCLM5kLni57ceHxjbd4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I++XWayz; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I++XWayz"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L8SorW026372;
	Wed, 21 May 2025 08:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=As9JDv7IWpzCSGWcv7pVzMu79+syJ
	SOzE0AhtTJB65E=; b=I++XWayzFyWrJYK66Tzza35MAfJ2CaKGttV9QI7/oxUtB
	l375Oby7JSFX8L+pFaFh3mgavZH7T4L/fC3lZapPqGUSBuvTiblnNQFSJvD6fx8g
	aCXvEvtCVeUqRY8qlN0H99lfFXD7R2gbQyMfbmS6I4mTwQJOgSp7lmzsw6uVh1IM
	xp49ycZ38GX5vbrQT+RuBfYzaRT1Y3YP5fgwH9MnyQobbSt7rZJ9qigo1mN3W1pt
	kHsgEH2/Ctpxv7xjZZbFvv7HfgS2N0iFiscJlR1LpeKfDjErF6NjVChCWXC5yRj0
	N9ladLl1FeEpFhqdlOIfwUhdtjwq4iB9HPjSLlt+Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sahbg660-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 08:51:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54L7sbuL034540;
	Wed, 21 May 2025 08:51:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rwepjaqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 08:51:46 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54L8pjuh027328;
	Wed, 21 May 2025 08:51:46 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46rwepjaq9-1;
	Wed, 21 May 2025 08:51:45 +0000
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: jgross@suse.com, sstabellini@kernel.org, boris.ostrovsky@oracle.com
Cc: harshvardhan.j.jha@oracle.com, xen-devel@lists.xenproject.org,
        iommu@lists.linux.dev, stable@vger.kernel.org
Subject: [PATCH 5.15.y v3 0/1] Manual Backport of 099606a7b2d5 to 5.15
Date: Wed, 21 May 2025 01:51:43 -0700
Message-ID: <20250521085144.1578880-1-harshvardhan.j.jha@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505210086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA4NyBTYWx0ZWRfXzIBt0qr/N4Qv vtKmnRNDXYddRLaThAtraoQY5Ts2KnLUq+9lkUMOUS44CD+Qp/QiSGM3q6I+To4yk87t8eX7CnI GaRj7y7bh864o3LN6+1XB8IF4dAzADcrcrtYfvEtO2ln0IgtNpSaD+Pz8VwmismULbC+zQUHmkb
 EEjrSvqLfHLYNr2e4MddNio5O/N/zFwAm/Jd+2Wesq2q9eeQC1AUGykwTs7xOLz5nvDlrSUrl+N nPtJx2Kb3Y+U3U45Wy4V1YOKqGoVRdpoTIiKUqXOxxgH+gCiRqB8O5h7yPhZeUr+Isa5q6kqX3O zmvu/DlXSRqoHEkinOS3KLO9tSX5byTdJowoj5V9lLPh34seiyMOAXGV/0Z4WUe1JNXtzM4Rnsf
 k6gVseQRX90J2GCS+j4ZnqRCT9QkAP0oXo0PJsSVGkDJrZhzqMep+z3ixRPVT2ZgmSEiDTob
X-Authority-Analysis: v=2.4 cv=VY/3PEp9 c=1 sm=1 tr=0 ts=682d942d b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=dt9VzEwgFbYA:10 a=rs8Xjf8ku5-kuHtvfxMA:9 a=zZCYzV9kfG8A:10 cc=ntf awl=host:13206
X-Proofpoint-GUID: dthhuNeQH1ofGErp_6-Hlq4B32MpNnHS
X-Proofpoint-ORIG-GUID: dthhuNeQH1ofGErp_6-Hlq4B32MpNnHS

The patch 099606a7b2d5 didn't cleanly apply to 5.15 due to the
significant difference in codebases.

I've tried to manually bring it back to 5.15 via some minor conflict
resolution but also invoking the newly introduced API using inverted
logic as the conditional statements present in 5.15 are the opposite of
those in 6.1 xen/swiotlib.

v2 of this patch was added and dropped due to some issues in testing.
However, after further verification this version seems to be right as
is.

I kindly request Juergen's ack specifically before this is added to
stable queue as this patch differs quite significantly compared to the
original.

Changes in v2:
Include correct upstream SHA in the commit message

Changes in v3:
Patch remains the same, however further verification and testing was
done.

Harshvardhan Jha (1):
  xen/swiotlb: relax alignment requirements

 drivers/xen/swiotlb-xen.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

-- 
2.47.1

