Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AF41D79B2;
	Wed,  4 Sep 2024 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455893; cv=none; b=rryD6evKYKDUwzpz62eG0oVovMOfxNtXEMj413FC15gKFED+n6jusD+E86G62t0bwk38/7jkDJXUvhEL7gATqbaL1KU7+XMyFY3XKJfaTLA4Gh1cRvR4M63ILMPRaAum6oYilbaS3neMkDZN4vLXUbZ7lBx4SamvfxooLBpZ5AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455893; c=relaxed/simple;
	bh=DahTmE+cw2GuBIr/HQoJZM14WQAlTGLxnm0oWWFYEwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lw+Z6rCydvrKr+GDKagTZ9p0YR/vM117XX3a46ACQx2Xq3WyZr2eWG0sKcx/VNty7KCZhBjHRH3O9GrUsjtM51iE4YrFh3ZDNcmV0Sik3604g+dq9JS8y3oOKxmA5aZ7/TKdZokYi6gaws8+M4INbE3zB9rKOtWOUJFwgOKqmIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyviVQ3P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyviVQ3P"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6369C4CEC9;
	Wed,  4 Sep 2024 13:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725455892;
	bh=DahTmE+cw2GuBIr/HQoJZM14WQAlTGLxnm0oWWFYEwE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fyviVQ3PMdptRUY4nYPnRxRIktYFE2Qk/a4SLu0y9jP6eV2J4+P04A+/sB1DWwpML
	 455u2U13Z/+ZgxdOr8LhIR1I9IDsw+03tos3Qy36UlgsMzmEbvRNb9zEtgMZZrHK0n
	 p/aOGr779kY4bUjzCcLcJl47h99iQUMzaT5FSsHrh2Ao3pkLT1Z2QnbLhWO8Uwyd9g
	 amqQ9GeQl9r8MQ/EkI2QSVitOtGiM38pWXz7MFnsq+nE9WPqXU+KfMy+X39SfGHRpa
	 xjZ8NCBDY7RC+cAZw7WhBJwAUU6AE2kyece8s1m9FFHAMIxtAdLVMaB5H2Akk84fLg
	 pCRdWzHELbRoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93F6CD4849;
	Wed,  4 Sep 2024 13:18:12 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Wed, 04 Sep 2024 15:17:13 +0200
Subject: [PATCH 2/6] iommu/vt-d: Remove the pasid present check in
 prq_event_thread
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-jag-iopfv8-v1-2-e3549920adf3@samsung.com>
References: <20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com>
In-Reply-To: <20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com>
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
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGbYXhC3rVks+YQxMld3lqz3PtEbzx3YP/0tv
 SlyGftf39WU5YkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJm2F4QAAoJELqXzVK3
 lkFPT/AL/Rh3zXdT5UQaqGGi3xhl12hEX+DL8xYzus7bNkXGZIArVREL9Ww4N4fULNqSIcCJ46y
 EJUdiCBblIo79ZpC+jI45GUI8KDkChndRmfyHuwEzJC7mCuoHuShJff4c2xVFsjE4858NTA5pnV
 hA+wxIXDBRYNOt0e+Br+BAmbiyVRQ5bN259pkoqZ0nG6fQ4f+iKXen1Dsc10gr8BV+3xgxDf/eX
 YmEIKUO/135r3JdqWkCp6ixA1eAwcEFqMcdYbLVhT/o6Fe1d0slIhx/1KILIMPXcSAQ2WtuFwSz
 zkpx+VHDG7IH2RMAn+Hsq/mbTgBWDUmGJ64K8GWGmbnx0IF/IKpTkvQdDYLC342KrfZFByeUmEG
 6mBeA8HC/9L3n6/5E7iPlvItL/aWmYzHJKyjQokz2Ipxwqy5a0uGbqrQBVze9Q8axKTvclOZL1Q
 R+/islwVuLf4Wycl7PJQ0tDt1nZDninu9SQOJnLzF5qVDxbwZbqlmAZv5s4qoC9LBr0pJZYzC96
 Hs=
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


