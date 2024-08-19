Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E47161924
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068370; cv=none; b=dxunevt2T4A6APNNe1fQIxVMmyTmK9X+seVSkJ9/L6mOVwR3vWs2ZI3V5HXPXID28cft9NsKp4f2SGLjuB2OeO5NM9YYRN9QIjqRLOBrIo7acvnurYOI/xsCYe/jWEiiGluSKDWAb7fanbLSruWwDOytcpHgGGjK6288uuhiL9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068370; c=relaxed/simple;
	bh=HXHXYtgPrNuhj+hk6RpbYzOeN2bFS4O5kzcnf99uKUg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bav4V6aGMWi3e+CLJH5XISujqnt8dhanyiSRHimpIIhR9oTYWLsQ+F4FmZgfVfqIYNROcxjJ37bHWtFFV/Fr9Dmi98GfwamgS7saHw+zrJfQNBnmND/cDyvawfqN1bkfa5xLTkIqps6zgFlRgUmbKak7cuEeSPFpOmEIbpE/9Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WnWCC0qHmzpTP8;
	Mon, 19 Aug 2024 19:51:19 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 80DFF1400CD;
	Mon, 19 Aug 2024 19:52:47 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Aug
 2024 19:52:46 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <jgg@ziepe.ca>, <kevin.tian@intel.com>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 3/8] iommufd/selftest: Make dirty_ops static
Date: Mon, 19 Aug 2024 20:00:07 +0800
Message-ID: <20240819120007.3884868-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

The sparse tool complains as follows:

drivers/iommu/iommufd/selftest.c:277:30: warning:
	symbol 'dirty_ops' was not declared. Should it be static?

This symbol is not used outside of selftest.c, so marks it static.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/iommu/iommufd/selftest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 04293b20e20c..7464c24764cd 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -274,7 +274,7 @@ static int mock_domain_read_and_clear_dirty(struct iommu_domain *domain,
 	return 0;
 }
 
-const struct iommu_dirty_ops dirty_ops = {
+static const struct iommu_dirty_ops dirty_ops = {
 	.set_dirty_tracking = mock_domain_set_dirty_tracking,
 	.read_and_clear_dirty = mock_domain_read_and_clear_dirty,
 };
-- 
2.34.1

