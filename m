Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561451D6C7F;
	Fri, 13 Sep 2024 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726227927; cv=none; b=KGUgdnQZfSj9JSvVAEJzfchpaiAGoLL/fkOX4TY+/ZO7xZFlZKJFGvBB04f3E2kP8megNqiyN65YtWbXY3XSPMAxR9UbsS+x85CgMIXty3W5slLIWTZ2dreOabKKMPx/u/SYQUIyKXnkjthvRomoE31AaXbcz27K3/mE+3hyBI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726227927; c=relaxed/simple;
	bh=DahTmE+cw2GuBIr/HQoJZM14WQAlTGLxnm0oWWFYEwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qUTKX3hY34ZLs6251f/Y0JVsuk2MmXFczJKt5jwZeUOyyYf0cq5omEi3EfGOxcUNYw/ACTZ/oSTd+FSvpRsbQP25zCci5oF0inugkE2wL/N4GXQXvcXN/aGxRNFVRWST0+LLPPm5uV7rRX6vZiuImUvt96tls+NH9oU0FIdkTp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Izfu183/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Izfu183/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04F44C4CECE;
	Fri, 13 Sep 2024 11:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726227927;
	bh=DahTmE+cw2GuBIr/HQoJZM14WQAlTGLxnm0oWWFYEwE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Izfu183/5sWNJrfrJ1ZtmUtzrPErMGl1O+c/LknMeS8OlbBuuOJ/7fFFxKR/5DfiV
	 j8atQc1wRfjUApO57T0zrKOaBBg75K+eKfsMPHXt0ZKheipx2Qu03ZtoB6+vLcwzaW
	 sMsElbbYQH2gdY1XYPPkrdpD3FLkGBXAWVWJLxplSIvXjHPbtG4JtfGT11uyUlFxXK
	 W7Dj//cBRfB68Cw0bP+D7O6iy6fK9pU4rj+4c9XnUbmPz1xH0D4QNRzqrVxT3Ovb9Z
	 Jk4+a+N+NLptXDvjSL+VAD8/zA7arngNLDqa7umop8TqOZZz8pDjXmrRFI3cfwS9nG
	 SSwcx7n7J8Ylg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC174FA3749;
	Fri, 13 Sep 2024 11:45:26 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Fri, 13 Sep 2024 13:44:48 +0200
Subject: [PATCH v2 2/5] iommu/vt-d: Remove the pasid present check in
 prq_event_thread
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-jag-iopfv8-v2-2-dea01c2343bc@samsung.com>
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
In-Reply-To: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
To: David Woodhouse <dwmw2@infradead.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Joel Granados <j.granados@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.15-dev-00a43
X-Developer-Signature: v=1; a=openpgp-sha256; l=1351;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=FD3UiP6NJxmTUYvjmWxZFWuSigYaHG1wzRA5qCg/pTc=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGbkJdKBW+Hs+8Tf0NKrmnye3XUlNDJ2kjEZ1
 4HK8I/1yWanyYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJm5CXSAAoJELqXzVK3
 lkFPVAML/ikXS0WO+qqt2AG+iyoNq2202M14ymCKCshpnxQOjHqAo/0YJjL12DrZtDth6XLYECv
 7mR7q0ja0t1DwzlAlFYHZT7oEIiGaj8PL+AJIQRaBf8uWeF6LoqyCXUuXaDKY1PLK45k6ofc+7i
 +lODsB2m5dz0/+00aMZstqPiIWy5g0fh4+JSyqPXcaj6jVP8AfSL5Faj5LxXOUl5drqxGARy7rQ
 UJK1S85W10Yz/+0VKxFWfyBX6sU47uxAoXQvv5bQHpMdAW6DhY0DXH8bAp2B0+ZKkc0V266Zt/l
 NYkDBNkEQIYpuqgXSvX20GBGUlV6ptzXyTUxLECORrdqbPdjKKY3w2B39SLmlL0FdDD12J/7tfs
 YRkslIr7c8BBKIf+M58a72X2jwE3Nsmfxwjzcsx6yaHwJYfffeeQLh2/HOlah9QD6kfLfhWaHzA
 +Lr2Is7psM2PK1ZPH2of/r+NCmySmAwGXAe/fQQJtYG0skZF332oFIX60K12h1Jfdpr2FkgSnu8
 DU=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Klaus Jensen <k.jensen@samsung.com>

PASID is not strictly needed when handling a PRQ event; remove the check
for the pasid present bit in the request. This change was not included
in the creation of prq.c to emphasize the change in capability checks
when handing PRQ events.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/iommu/intel/prq.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
index 3376f60082b5..5f2d01a9aa11 100644
--- a/drivers/iommu/intel/prq.c
+++ b/drivers/iommu/intel/prq.c
@@ -221,18 +221,12 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		req = &iommu->prq[head / sizeof(*req)];
 		address = (u64)req->addr << VTD_PAGE_SHIFT;
 
-		if (unlikely(!req->pasid_present)) {
-			pr_err("IOMMU: %s: Page request without PASID\n",
-			       iommu->name);
-bad_req:
-			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
-			goto prq_advance;
-		}
-
 		if (unlikely(!is_canonical_address(address))) {
 			pr_err("IOMMU: %s: Address is not canonical\n",
 			       iommu->name);
-			goto bad_req;
+bad_req:
+			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
+			goto prq_advance;
 		}
 
 		if (unlikely(req->pm_req && (req->rd_req | req->wr_req))) {

-- 
2.43.0


