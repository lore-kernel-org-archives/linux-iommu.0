Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAC3128819
	for <iommu@lists.linux.dev>; Wed,  8 Oct 2025 07:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759910009; cv=none; b=J7f1oP0nMou8W3GpDzwq06qX2cB5Hgze5uAngKAmxA9FU8VK+0wxHJmmZN4IS/ryGDk1lCHk3FjeIOW7J3MDWIlJpY0D+4r2b6n/CplPoqQGEYtmzpxSQImbmOYVaY2T9kVjw35rL1iqSh3CL2ZuDmnefIsch6a+oTHQWVVgnto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759910009; c=relaxed/simple;
	bh=J0vin9G4M7B3OG2kiAsyEa99zFFAtW6G2CoPlAm8g04=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=fmiV8qX47rjEsRAzy3IAY3p4Ys4ke/lxpFsKQEUTcg/32PLENEjsm2KNO16dN0PMj/yGD2DjKiq/JRSVjc1BVIHMNJOE4eeu9fBYBoflj2xYr97smXpfJFuiZCdO/nYMcjTPKfsGACqM1MRTuSCTbZUagtI3bELpXLuW+kVowC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=IJiiAozG; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="IJiiAozG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1759909996; bh=P7IvDczGiyfEhMXQssu7tGF5fwkZRWsiDziHUa3DUmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IJiiAozGjSl7BH0Zbel/1ug65azUBRR93u6SKzoW2pQFtcH0SL1zAMIWbSVe42Kfx
	 2xgEcNkQkxV4tkP8t85Bqd9wF6pJ/Gs86yELHsvn1HytgKpAnrn5torBQ4HyDSY2ij
	 qvIxli8ss93LpxEjD/0JB+rA5Dxv+2xrRCRT2yOk=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszb20-1.qq.com (NewEsmtp) with SMTP
	id D46A284A; Wed, 08 Oct 2025 15:53:06 +0800
X-QQ-mid: xmsmtpt1759909986t1jgwmg6v
Message-ID: <tencent_E46183A88440D77C977DA6CBD37DC362A905@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIeAg4IKih4f886w/ZvHqayDqcqGD5QSFnRrcO1knjmCq7Yc0nhfQ
	 qCyKcnQdYpG7zLDX6FGAVeYqg9/FBeCfKiqowu6oyhwmkYYuknOM2GOgJe+ez46NlG9XXoit3ngR
	 k8zll7UfE8sxeA9QZ+dyH2fes93J/IN+vNxZdB6kXj33p9dWxzph8fzkIjh6LYrSmT0xcmD+7nsd
	 RvKAk1YLrNUBlJZTeKEmQsglgtlrrdEE0x/JUN2V+2NxJ7Cv7eIchyJ2RHtQqFIyPtwIzlhZQTnb
	 5EOon0YOOZGR/QdxOAJO6s9L9HiP/w1AuH6b8oWIWyma6BQB7jKzt071olJQ/LvjqbFL69JB6Sqs
	 Tlw5x/vXkyNbdTtLWoL8oIjOcm7kpqLyQEq1Mcety9jNK4W9K0XUtc02rTKs1Yefi69UHk8QCmRE
	 udK1KKQaqsiMsyWWAlOPIMz2SZCKzgj6EsvRNmt/j1db1Ghd7W+o0wGvYs2RjulreOD6yVslppmj
	 ViUyUd7GePZpRTOEMfCChvYFEoYOqVIsJWeF2ryUKywzwLutcZMKnAX6F/vS9EUdqSaKF/yQ4bRN
	 VFp8yR+fbaSZ1LVJG7XlV0Q7uXqDnV72l9q7CCfZjVkGNY+bptuXcSWhddssdc5wItOFimjwz0t4
	 uepbBYWz9obTGWz8udCGLyXhEo+/ZEcswTVVe+XiNBMh237SDzYk/g/T+eTp8noCgoz78UYbnTBJ
	 MA6AzCZVl3C4zo5eGoXlAHX9WpMN+mU1BFZXoPP2wuzGfL3WI3QoHGwXl+rMn+bpHzcqgQSXq0su
	 xZnLNoplBsZAy+D2jVoc9BFC+owdHii4GWwj6XOidxcRPj4E9NHn2MFD8+ZR31ZsrQEC/vpilGrH
	 NNwOpYBHr3ilEbGR9L61Ghff6rLjomBsVwp+oNkbAc70u+Ey95NjlbVH6SkxidUM8bRgzIPhXWfC
	 /SlfI/FXHWvIPkX35PDSQx5Yb4D3xOgq60194rZ1wSpqYP0lEloA==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+093a8a8b859472e6c257@syzkaller.appspotmail.com
Cc: iommu@lists.linux.dev,
	jgg@ziepe.ca,
	joro@8bytes.org,
	kevin.tian@intel.com,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	syzkaller-bugs@googlegroups.com,
	will@kernel.org
Subject: [PATCH] iommufd: Prevent the use of nil data
Date: Wed,  8 Oct 2025 15:53:07 +0800
X-OQ-MSGID: <20251008075306.1443836-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68e5a30d.050a0220.256323.002e.GAE@google.com>
References: <68e5a30d.050a0220.256323.002e.GAE@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The division exception occurs because:
The denominator bitmap->bitmap is 0, which is derived from the nil value
of bitmap->data passed in by the reproducer.

Before calling iova_bitmap_alloc() to allocate iter, add a check for a
null value in data to avoid the division exception.

syzbot reported:
divide error in iova_bitmap_alloc

Call Trace:
 <TASK>
 iommu_read_and_clear_dirty drivers/iommu/iommufd/io_pagetable.c:543 [inline]
 iopt_read_and_clear_dirty_data+0x271/0x4c0 drivers/iommu/iommufd/io_pagetable.c:603
 iommufd_hwpt_get_dirty_bitmap+0x1c3/0x340 drivers/iommu/iommufd/hw_pagetable.c:485

Reported-by: syzbot+093a8a8b859472e6c257@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=093a8a8b859472e6c257
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/iommu/iommufd/io_pagetable.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index c0360c450880..9ddaed95e79f 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -540,6 +540,9 @@ iommu_read_and_clear_dirty(struct iommu_domain *domain,
 	if (!ops || !ops->read_and_clear_dirty)
 		return -EOPNOTSUPP;
 
+	if (!bitmap->data)
+		return -EINVAL;
+
 	iter = iova_bitmap_alloc(bitmap->iova, bitmap->length,
 				 bitmap->page_size,
 				 u64_to_user_ptr(bitmap->data));
-- 
2.43.0

