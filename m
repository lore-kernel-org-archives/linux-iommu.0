Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4AF48BD5E;
	Thu,  8 Jan 2026 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767867960; cv=none; b=iFSIgESXr2ulwGmTSMOEFrrLAVSarg7U2xhthbDmhX4+veTtH8vyxgdnrjZut1ZfrK2TrforukZCAETIqjbU2YhDFcfF8MzvoedehGTnBkk1hhPLruaXqRZgAydsDoRYIL7lHK4Fa25G/BLYqg7uk6nMlaBnVruJ7S1P4RoUsgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767867960; c=relaxed/simple;
	bh=tio7lPbRXMBd4S/l2G0FC6cIx286giy8rsEXua8toYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B383BdLSSFEvFdbgwJfwaGDRgaQ7RBKhnuqJy1pDbunMpfLG4B3IPxKEikv1Gne2LNR5vI2Smp/97BR+VK3Q/sh4+Y6vRUu5NAd1tMeAWxASC1qUNebwboDYuJuitKItOrcIWBYhNU7gDMJJTwoJPX+oGW7QMDIDXTlVXN1k434=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=poTUQ1EK; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="poTUQ1EK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=WV4iPlf6+EUUy0AJ0TT4+d4hbinMgXqzclEzTr0ojro=; b=poTUQ1EK5x/nCC
	DA9bgPjFPu3SROX+ZcBk/bnhAle1uLSn81HP11RiSLtt345+q2NMN9bE2df0vczThX9EktQn+Gam8
	51Pg2Q2/ZA7AzfpXhpJZwsx5ddgef75+DhE4RGj3sjw26EiOGQpSRWnNLfJAeNuPSskY87MV6OGQa
	Q69yWbbU2/CrqGJBk0E2UaKiK88JZiyYehXa4uptMtO3qG4uLYD+ea34ZWDg8InxHAGRTzbEmO4wc
	F3NLjPHHOQ5479vXBXFbPhBlApTBNSQYg6pNXmjwsUUgr2xZPflqU10iMwYFyyzYz2djwRxu/2cD9
	KSUZUy637eW+re9wSSEQ==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vdnD5-00AVEF-2M; Thu, 08 Jan 2026 10:25:43 +0000
Received: from ben by rainbowdash with local (Exim 4.99.1)
	(envelope-from <ben@rainbowdash>)
	id 1vdnD4-00000000yTY-3LOl;
	Thu, 08 Jan 2026 10:25:42 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: robin.murphy@arm.com,
	will@kernel.org,
	suravee.suthikulpanit@amd.com,
	joro@8bytes.org,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] iommu/amd: define 'amd_ivhd_dev_flags_list' in header
Date: Thu,  8 Jan 2026 10:25:41 +0000
Message-Id: <20260108102541.232459-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

The 'amd_ivhd_dev_flags_list' is used in the amd_iommu_types.h
header but not defined, so add the definition to remove the
following sparse warning:

drivers/iommu/amd/init.c:182:1: warning: symbol 'amd_ivhd_dev_flags_list' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/iommu/amd/amd_iommu_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 320733e7d8b4..2ccb629e3243 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -454,6 +454,7 @@ extern bool amdr_ivrs_remap_support;
 #define for_each_pdom_dev_data_safe(pdom_dev_data, next, pdom) \
 	list_for_each_entry_safe((pdom_dev_data), (next), &pdom->dev_data_list, list)
 
+extern struct list_head amd_ivhd_dev_flags_list;
 #define for_each_ivhd_dte_flags(entry) \
 	list_for_each_entry((entry), &amd_ivhd_dev_flags_list, list)
 
-- 
2.37.2.352.g3c44437643

