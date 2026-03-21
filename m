Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B4A36BCE6
	for <iommu@lists.linux.dev>; Sat, 21 Mar 2026 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774090759; cv=none; b=bV3tYVK91pXHYcvNSeZ/MlHUQ1US2VBC+cEL/07loEROpdZBKHP8Rt2UR8+kdQvb0O0CRgWfdUSlYzmrRuf00Kec7dm2G4NnS9G2bBa5TNpIUh1BpMzS2VbjR2Ai9/GHiIKgYS+fykNBodxPlf36NZZz7P1DxwBDhzTljWWfpbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774090759; c=relaxed/simple;
	bh=oc5WkNqCy/A1ZMlCqMNl+PwNkswKb8F1QykuWKKvPjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PDudZZmZavDqngaxEGMe+ghGnpl6iNSFMVG0fsW0nOAsQHjyCrL0/u/wPKBkZCBJFzzRdrKR98NqL9eCXJUVcNmkH1AOKJgP1+wnOr8Y1bR+E/L9uXHsSjWpSJ+najxnovMuBITng/qh9kcAqlcsvCbExQhuQ3Jx4Wxz/cGVXdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=qP/rt8T4; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="qP/rt8T4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1774090683;
	bh=5UYvm7SKnEX+dwjNa5GIV2F3g4KnPjsZWopc+nS7RnQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=qP/rt8T4Gxf4DFxxJltXvyhsjrwcwr/dk5Wen925zEyubduOS5VfU1UyqazPeTSwf
	 k5jLZfjy2JBT0kICzEZTxUW4izvbdSRcQVUp7Zck8vHDj/ALhCMj6jEAvNyLmIHW95
	 r8FoekBwiPq/WInZ9JKhJb2Sq4RfQ4gxKwDboMYA=
X-QQ-mid: zesmtpgz5t1774090681t100d5038
X-QQ-Originating-IP: x4yQ3dglik2jVY3Ozfa+0DZ9LZVUApjoBLBIX6ABsbU=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 21 Mar 2026 18:57:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10936887261093389238
EX-QQ-RecipientCnt: 12
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: jgg@ziepe.ca,
	kevin.tian@intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	kexinsun@smail.nju.edu.cn,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg
Subject: [PATCH] iommufd: update outdated comment for renamed iommufd_hw_pagetable_alloc()
Date: Sat, 21 Mar 2026 18:57:59 +0800
Message-Id: <20260321105759.6832-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: OKia5IbrI/csEJxPh/5kPtZGiHw6i40dUgZxCBKwNoTNMk2aIe3hkyIH
	JYtMg+wlMuBFyTUHebrf/7PSrEGO6DWu9MGZyVpu1DRUNdg2xrZG+nzA+ZvV409KY5PP0xi
	eCo7FYMBOeB7nOBVhRVq479lhkjxSxzKJJLCkTNeu8fvUPObEmjBj0NE2Af93CWVYBkBGWJ
	nhzqsfImqoKoBesLAMU0giLy5C4POjv5UOFOygV34Yz5LvRq5RXM3vNAmlaScFLhI0dx1jm
	rksgkmJq7sQrCGwAOowkjNZYE5cM5N9pra50pnIhCmaglJPw3EZnih9je4YESkJQkWdJIDw
	9iybSPMtTtNcqHj3yRBFSZA6uy9FnPZQoswKiJ9cChUExKLpbJsIhH5UWrgU8HCIpOS0kQ7
	NqULTXH9mbE8hDMjVIpqmGhzr3qIeptDV77Gb3OA6VX+6AlHxhbfnVcqkkdeRMxUDJLr+27
	qCmWeXMl6qKUWnXs9zZWMgpaysPUAVMeo/kxd6m9O1ljcfoCkyKhj+J+vCG8oJFxK2IotQJ
	N1ev6wy9dwa+KeNd0shX3KF5m9hNstcK5MSL9F63qU0At99UU0iXskBrx87VftlF1yjCZ9c
	uThn7E1keNkPwO1r1J9zm5SvrPAb5iT6DBdbxWhn1L3/fpxzHGmSSRzfq1Tj1oF0/Jm7eZa
	dLbByZZ9Wi8rKVaN7vLtKRE3snn+tK0mHk8ernz2FiDD+L6bzFbiF5XufYvRV6Qk9PBKmqV
	M2PNj9CoS23bKW58jE56iTQh39MqRflopcWHTCv2mcAUQ2kUIb9b5NDGu9vQtv0Ms41eFVt
	lxmoO1rv2/FnEB599wDkNYSfPoOcOFm5HH0ZL1Teas+2mcTc47xg6oH13OIQUtPidvZu6sl
	eype1VTMKIuQ9rw0o5OwKo5+1fiUXpKGvRZ5FdgHzhqy7GfygKZ3WnzEZXTf92kQ4o/QxTw
	A7uEE2OJQQULtsFQLpRghWLTrfVAyQG9MiSkLvDzNCuskTuKxFBeR/rxl553yKEhaPtX7fF
	OYDTmxPiRkyzpGLfMBgra/JiouUUdZGbUJXP5rGaWt3fH57l29t9bGM1nYiebglUEnz02sO
	G1DO0JGOIgcdXgcDy2RqcQ=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

The function iommufd_hw_pagetable_alloc() was renamed to
iommufd_hwpt_paging_alloc() by commit 89db31635c87
("iommufd: Derive iommufd_hwpt_paging from
iommufd_hw_pagetable").  Update the stale reference in
iommufd_device_auto_get_domain().

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 drivers/iommu/iommufd/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 344d620cdecc..2ae06372d63c 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -866,7 +866,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev, ioasid_t pasid,
 {
 	/*
 	 * iommufd_hw_pagetable_attach() is called by
-	 * iommufd_hw_pagetable_alloc() in immediate attachment mode, same as
+	 * iommufd_hwpt_paging_alloc() in immediate attachment mode, same as
 	 * iommufd_device_do_attach(). So if we are in this mode then we prefer
 	 * to use the immediate_attach path as it supports drivers that can't
 	 * directly allocate a domain.
-- 
2.25.1

