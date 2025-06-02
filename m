Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5076F1B0412
	for <iommu@lists.linux.dev>; Mon,  2 Jun 2025 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748863995; cv=none; b=BlXAVLabMvXodHlARgtOMURZ5hTrG0UoLsq5DSMOe9fzUG6p7FuFelqbFuwBIZmGBMUpgEAUAEPz7x+mFqtMdENJdlZsakgOuCHacyms5mNSV1TP64LCsB0b05hggHlNSr/CFX8WeZ/722EGMwD3gZHaKg65uWDmvZHlQw4Ip+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748863995; c=relaxed/simple;
	bh=uMHqd426JlHkNXmDkOIxDveuSETJsD8fKkkCiCSzJUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nq3Ma3tAmyubVJ8gMKGmYrRcRBzsc0jf19p6xmnPGh0Ljifg5xv+fez/FuU9q2Vr+H0EgMDLHRMvCLnP7wUETOsJviAN0jmm3gt6vZeGRNVQb1wkx8X9D3g0RxHuQTSeNef/jzRIPhdp7wkHM9OBnhpzgLP/sqTc8TVcIcrua7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y94lSI5a; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y94lSI5a"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5525umN9005801;
	Mon, 2 Jun 2025 11:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=/vrCB2lmg2R3iKH+4Uwt19KHyOhC+
	iMk6uA4rOe3q4A=; b=Y94lSI5a6a2VspzMaNb0XQi8eXM/gfX6H3pkVDvhPLTzv
	5WpMO3BD/BQlibNYyUf3/UhrZ7u6PtmcBtJcnB9iStFve2EV6dn7ONQ/Ujakzt46
	ezffkg2ywPFxMl4BiA1zmKxPQ+2kW/AUDs2DnJBjmVzGhoeS8UxztTtKzKwaUcQ5
	pSz23lNbH6ZfX2wmbGnP+jfvLBGnqmY7pvADuK990SRXs9wfb3B7vffaOgkGZccy
	Vv8gQKSZdxyvXIKK2Eux2pCxXLP89TqqZIjoMHcaDDOZUqARqomxC4Td9bh4NAe0
	3YxTqQknZ3xB36osaarx2mjUpbifzYH5pcXdaY/Sg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ysnctcnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 11:33:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5529mSOh030588;
	Mon, 2 Jun 2025 11:33:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr77uuja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 11:33:10 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 552BXAUj020033;
	Mon, 2 Jun 2025 11:33:10 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46yr77uuhu-1;
	Mon, 02 Jun 2025 11:33:09 +0000
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: jgross@suse.com, sstabellini@kernel.org, boris.ostrovsky@oracle.com
Cc: harshvardhan.j.jha@oracle.com, xen-devel@lists.xenproject.org,
        iommu@lists.linux.dev, stable@vger.kernel.org
Subject: [PATCH 5.4.y 0/1] Manual Backport of 099606a7b2d5 to 5.4
Date: Mon,  2 Jun 2025 04:33:07 -0700
Message-ID: <20250602113308.3475836-1-harshvardhan.j.jha@oracle.com>
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
 definitions=2025-06-02_05,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506020099
X-Authority-Analysis: v=2.4 cv=Jdu8rVKV c=1 sm=1 tr=0 ts=683d8bf7 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6IFa9wvqVegA:10 a=lNF16g9DOHChzQpZLYMA:9 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDEwMCBTYWx0ZWRfXxqXNfMl9KVkx JdK844gffey5z34nf8j/Kxd06rEHB2abD0GC7Npv+TXxrsNGfEke3NrPC3mjMwQiXeCoxl3aPLC TiphMJwSjyER1e2NRsUCi+IncTgsQa+4G/KcQiNeqXlTNe6oJEb76XYZzj8C3UMy7wPeFAEmlL2
 Scg5mwi37GfKbYvxOeT3JaxcZLOAiAtdLZ+4iMp00F8DyVywyQAHB0QPvOtIkAcpc76lPGMPkq5 oSxUizTJOscqAWnKgdlaoSrCH9bu9vtS11CfqdC2wKNZv05WcpbzXJGuxLJ9mZmJ7UG9Mwqw7aR F/HsNAVWMYvQHmn5Dsah8hnhuMETtoUAMeqCcSi4QLZExOr+tRMoKis/NLRqx7XacUWI8o2SN64
 TwOmMjd66kh5iSVPE5BI9meIMAoKvq3fD8TkEw9Zid69RUOdvaCkd1xYgo2/xMPhK+EcBSiq
X-Proofpoint-GUID: W_CYE281bNe4V2F4hhYOrMuU4d0TiXBg
X-Proofpoint-ORIG-GUID: W_CYE281bNe4V2F4hhYOrMuU4d0TiXBg

The patch 099606a7b2d5 didn't cleanly apply to 5.4 due to the
significant difference in codebases.

I've tried to manually bring it back to 5.4 via some minor conflict
resolution but also invoking the newly introduced API using inverted
logic as the conditionals present in 5.4 are the opposite of those in
6.1 xen/swiotlib.

Harshvardhan Jha (1):
  xen/swiotlb: relax alignment requirements

 drivers/xen/swiotlb-xen.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

-- 
2.47.1

