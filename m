Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F013714F;
	Mon,  9 Oct 2023 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfb/PFt1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA41DC433C7;
	Mon,  9 Oct 2023 18:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696875871;
	bh=GX827MInhdg+9mFXDOrIyDM25nqfnAIqJdLH+cnFaYc=;
	h=Date:From:To:Cc:Subject:From;
	b=kfb/PFt1GOw5zC7CWQpYjFj1PXHizJBGvSfYLfMzu1Fu153G6IibmU7pIiE36MWaz
	 Wq5Mbd63mgNvyj381SHoYS/kgRDRAwW4svc1+EjTpZytGPUC6BnHmjhe/1TbQKluOd
	 lJwEvwm99bGucNKSkxo8yjWenMOkgH1X/PTJSUNlhE85Jmh4tatu/HsNRN2tGkdr8f
	 n//Ox8QHbqjDlpowcP8WVokEry8qPiiQFpPH/FDZZnxgZuHZUJw0iYZbRVLeH7Bc6P
	 33Axz2LTWi6+hZU7n2PdSHI6Q19g4MdzRer4+pDnB+9NDTvZrWNKAMdz3katFpP7Xh
	 pO6IoFkkMbihA==
Date: Mon, 9 Oct 2023 12:24:27 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] iommu/virtio: Add __counted_by for struct
 viommu_request and use struct_size()
Message-ID: <ZSRFW0yDlDo8+at3@work>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

While there, use struct_size() helper, instead of the open-coded
version, to calculate the size for the allocation of the whole
flexible structure, including of course, the flexible-array member.

This code was found with the help of Coccinelle, and audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/iommu/virtio-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 17dcd826f5c2..379ebe03efb6 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -85,7 +85,7 @@ struct viommu_request {
 	void				*writeback;
 	unsigned int			write_offset;
 	unsigned int			len;
-	char				buf[];
+	char				buf[] __counted_by(len);
 };
 
 #define VIOMMU_FAULT_RESV_MASK		0xffffff00
@@ -230,7 +230,7 @@ static int __viommu_add_req(struct viommu_dev *viommu, void *buf, size_t len,
 	if (write_offset <= 0)
 		return -EINVAL;
 
-	req = kzalloc(sizeof(*req) + len, GFP_ATOMIC);
+	req = kzalloc(struct_size(req, buf, len), GFP_ATOMIC);
 	if (!req)
 		return -ENOMEM;
 
-- 
2.34.1

