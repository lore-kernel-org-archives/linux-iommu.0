Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B380218ADC
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 07:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744009362; cv=none; b=TrC6fRyT8Ou0IuLryM2a5YXi3f2181xj2Hp13Oo2Z8Vq7NXKUQj2WuM4l/NUDXoJ+GwbotwYxTRtNHJufM+jphaDQ4ykrflio+Jw8j0QkViNJHB3EVKHrwX7YXmrFuMyStDxRPpjGv9vevvYKUtncMoJap8F082wbc7oHVCBCyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744009362; c=relaxed/simple;
	bh=TipMqh+jY419M0FE6C4EHb3IMR85PPT/ksOHSlta85g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OHHQjTFUtUjwdM8cvaH3ZOgPuQyKC/jjXGle3bUPYaHv0vQGNnMzVSZFM0KNyj9NfH1wb1jVaYe3cw+AbvIXX7w18FBxblOC8jANfcOe29+QHzOteOCR+5MaRQXXaEQMD60ZrGJ3uA3Iq5YZWiwXcmW1afWtLOy98nKUcu/6Ju4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jQoTMxYl; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jQoTMxYl"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5376Y2we029135;
	Mon, 7 Apr 2025 07:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=+adpAbdYLs38FhIOhHdHbujyLz8AT
	wIWgf4obfGpmRM=; b=jQoTMxYlqIcteVWGaWm1r26NeCS3RKwwnBNdRH+M46bBP
	1UBkf3dJpt8Mw9A6paGffkR77pU48DDM34rKXHWv5j4QH4AoaxuTZ9wyfB+GShzV
	axZLyW1LTBc2o8z9x5vId3NLACJHCngnpBSshSCOMf++JxvDuOVUmzwTM0EoxupG
	/QBBS9JvBUVL9KZ8cR+wwGxFpwdrOjhGLIdcnLESL5e5bUJkHbGPu71lJuMNe/37
	fFhZxHKCpNA6hh08VwSiieqIZuSmmLnEXl1iUKRWZW6pXqFYk/ydcCVL6sqXmpiX
	QH+6vrUL8q6ZAxRuqU/P989XIunIooVOwzTtdmeFw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tu419x6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 07:02:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5376xIaw022221;
	Mon, 7 Apr 2025 07:02:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45tty84vca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 07:02:36 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53772acD006938;
	Mon, 7 Apr 2025 07:02:36 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 45tty84vc4-1;
	Mon, 07 Apr 2025 07:02:36 +0000
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: jgross@suse.com, sstabellini@kernel.org, boris.ostrovsky@oracle.com
Cc: harshvardhan.j.jha@oracle.com, xen-devel@lists.xenproject.org,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        stable@vger.kernel.org
Subject: [PATCH 5.15.y 0/1] Manual Backport of 099606a7b2d5 to 5.15
Date: Mon,  7 Apr 2025 00:02:34 -0700
Message-ID: <20250407070235.121187-1-harshvardhan.j.jha@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_02,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504070049
X-Proofpoint-ORIG-GUID: Q2Uymo_6DJ_OZukhNcrNtCGTNFIBlZA4
X-Proofpoint-GUID: Q2Uymo_6DJ_OZukhNcrNtCGTNFIBlZA4

The patch 099606a7b2d5 didn't cleanly apply to 5.15 due to the
significant difference in codebases.

I've tried to manually bring it back to 5.15 via some minor conflict
resolution but also invoking the newly introduced API using inverted
logic as the conditional statements present in 5.15 are the opposite of
those in 6.1 xen/swiotlib.

Harshvardhan Jha (1):
  xen/swiotlb: relax alignment requirements

 drivers/xen/swiotlb-xen.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

-- 
2.47.1

