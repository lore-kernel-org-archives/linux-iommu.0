Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB454594A
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537580; cv=none; b=sPxCCzwkhJnIFcMeRAFB6ygExvX8xk4VYWV8lEEhKOm0ylgHCmLY9dPkNJwcqAg30s1ETXcZFSJSEzNnMEL2C7BuMX/uaIRcXzNaUgsJIVE/u1F3woSrbLh9FOoj4ZHBgPC/YrCRp38b6+MyNDj6dQ4KMjyEv75nECYiAA/lNfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537580; c=relaxed/simple;
	bh=60/4QCKBm8Kw4gb1Fh7/h1kSgnHAMVzMuoS45ceXLmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJEh31e5YvtXdJZzvpZCqhsci1lL5N4w9zDS2QiIdTu1SnznUS5M3bLrS0JJYmVCl3vtQ2RKtSluL4Joa55ztyP3yrbjwsge2QfjQg/SnjENENrARbfMRmNmK/ftEYgtLxljHgJ9qr7DMVSXBTak2lE5tMur2kStXWcDvo4GRJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=mn8UmAQv; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="mn8UmAQv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1784537518;
	bh=O0+XfrWrjunasPiJVkecVNu9A20y/7zq5HttrgxIaag=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=mn8UmAQv8qGRSxTjGnmzY2EcF43RM/c5IFnofmtR9pPHvDEvKZrETflbogcnY797H
	 qOf9xH14CSV97uAjyprzhj6sfti93XtsQlzPk3xS9pQ2GIU44lPZobNGmivaX1WNhM
	 zAdQ/wvi7Y/XFHx+GDw3a6xo/Z2YHOqZhsj4MoRk=
X-QQ-mid: zesmtpsz6t1784537509td2e005ca
X-QQ-Originating-IP: FlVjMpjpHjtzc2fX2D2lwijbUkXh3/9QBZlnaFVyyJk=
Received: from hepeiyang-vm.wu.lxd ( [218.94.142.195])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 20 Jul 2026 16:51:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17723403362331073114
EX-QQ-RecipientCnt: 9
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: joro@8bytes.org,
	will@kernel.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com
Cc: robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	baolu.lu@linux.intel.com,
	Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [PATCH v3 0/2] iommu/iommufd: Fix IOPF group ownership UAF
Date: Mon, 20 Jul 2026 16:50:15 +0800
Message-ID: <B0FDD4C32AC66FCD+20260720085017.3998878-1-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <B474F106872C2E5C+20260718043239.3898247-1-peiyang_he@smail.nju.edu.cn>
References: <B474F106872C2E5C+20260718043239.3898247-1-peiyang_he@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OBlwWD/GWDEowrpQgblrcE6C+NuWWIVp1j/zRGNAsQ+IJtBwos4hsf0n
	X/e8PgxWvf1dVIhqFsIl/EELa5/+GgSsvVW4HxFVcgPvSDGYvPtXvnvnfVdv1i7Gxj9Wjuf
	nyg2ZAEwT0+iwUXmzzjabjAjukwysfcqRIifca9VCGf57l7c3zYvizBRztrwJ8IvaByhaa7
	zm8rJra5pW5LWvLWXWYnl7NpZaXdrCbtnMxkQtmLtw2D/ctJR7BM5P7y4YDUq3iTOCbgKel
	eB+Gw9eZTRZfFNKimz8+sYZGYzd/mnFVSl04YyKYJw2kEwuVjxuUwEy9Pqjp7vetJBJ5OA8
	6VZfoTUC3Ua0ltpOfgL9kiEgJt92AwSFY5ssEIKe6ix5wp2eeU7U6QANPh5GOb/vCqH3UTa
	MvovKtT9lIE0qSmbvXxv5n35dtgwortMfEF75f6Ja3FK+3szZC6+/BzW6rv86g3sChf9fng
	VLNOZl+cJ9YvlpIBNCNPc1pKJIvgV1ELNfRTWedyDt3W0ijf0Z9hj/EctT8FgwyE3Q1hJkJ
	E1+ka0VzITiP3rID/lMTuPqTbinTqH6Yb9aXPkjhdLCejbWRMCu6o2JuEyUStON4EDf5OUb
	BzQ7yFZY+c6yhzheauKwvyTQsKteavqDxPwYeDlka0zuscxjRQeR+mIayweH2RmmWnvwWl0
	lzlQAJlAocABi8Ib3nduQdrg5JF/Tls42t2KVxyhC8Jm1/U/2Rb+sTDDGR5wV9c6hm0YGGl
	G03U6NOr9hGCOoquu4m7G4QuK38cooW75tMdK/Gjte127uy8xhQoCVQO2D1GS5g/GY5/w1G
	Qgd53I7c/YIA1X2yuSqQByRLhsF+MQrVmu8wSivkG0BtmLOP7b/xRwzUP79kIVbHnP//nr6
	PXbndbAb+c/DtVG8qBkzx1HJ50YyAA9ji3roysTrPjFmOkMCiOMzCXoU/KW+uzTNv3JwXf/
	Dpfa/se4CssukocIsJU/SsxV7sr7Cm5CFc3vOHUWs8KTvSv2VE+dUSjG9y0O0J2fgRG76Ug
	GCVWVoG1rQGieE2k+SnzzwYSADIW713aalOSilslnK6EirIU21
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

This series fixes a UAF caused by an IOPF group being owned both by the
generic pending list and IOMMUFD's userspace fault queues:

  1/2 Minimum fix: dequeue accepted groups before IOMMUFD queues them
      for userspace response, then remove the check on list_empty()
      in iopf_group_response().

  2/2 Refactor: make iopf_group_response() free the group as well
      after responding.

Changes in v3:
  - split the v2 patch into a minimum UAF fix and a follow-up cleanup
    (suggested by Kevin)

Changes in v2:
  - simplify the fix by moving group freeing into iopf_group_response()
    (suggested by Kevin)
  - rename iopf_group_take_ownership() to iopf_group_dequeue()
    (suggested by Kevin)
  - drop changes in iommufd_hwpt_replace_device (suggested by Kevin)
  - rebase to 12f16a37f298

Peiyang He (2):
  iommu/iommufd: Fix IOPF group ownership UAF
  iommu: Make iopf_group_response() free groups

 drivers/iommu/io-pgfault.c     | 83 +++++++++++++++++++++-------------
 drivers/iommu/iommu-sva.c      |  1 -
 drivers/iommu/iommufd/eventq.c |  7 +--
 include/linux/iommu.h          | 10 ++--
 4 files changed, 59 insertions(+), 42 deletions(-)


base-commit: 12f16a37f2982028e21919466401179647f603c7
-- 
2.43.0
