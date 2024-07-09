Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6F3143752
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514399; cv=none; b=QW14rAT/we0oo/bFUOJSJmb2VtZVL7uPxJlr6afusct12F0a3eHUzyVf4DHiTa04Vs0xMZjmkQcTTEjkZ8RiqzX3ELGMO5dzZge5kjTmiAN7XR9OgFgNBZJNG4134H+Egbl8F+nUBibDjh0xvxtJDrpEYZ9QrCZbDfxr04bS4S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514399; c=relaxed/simple;
	bh=vkjIMBQ2d7r635VRmVXqQ1KG74/KSKzpfKZVLwEMNEk=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=OqDTXL1lwVLjSAxBiiNT7U8+hg4SQNm7Ajyp8IlcJy3MFAwK8jKrVK7kK71pp2OBBGg258CqlngMxJ7LHpISP5PyKQ6mx9Wqgw4cOL2lLMq2Ib5cGMXMEqMUOuT+veU6nQ6oSt6iY/gw1ytCUFPwZKy7mHuTny6yEmENQqRyPY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ATU46Bb7; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ATU46Bb7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1720514382; bh=U/0YlKC/F7rGuTvsRqHI6wsPqQee5vosvz17TaKzvFc=;
	h=From:To:Cc:Subject:Date;
	b=ATU46Bb7yiARbn4oZqwPTA7mHhlyIlL7feklLKkN/nqDPMlrSwqJNdKwR8nnZ20Tv
	 ZSZLVecGxXIHWu/2+lT1q3bM5x6p4Hjc6qcxrsNfukq3gF/DIYHIZ0o5Jz04WEgDEC
	 RE4s5V0ubp1/3CJK9pr4Vh2EIMBQRrLdovSkEl7A=
Received: from cyy-pc.lan ([240e:379:225e:9b00:b588:778:1f25:bdbe])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 84F1CCF2; Tue, 09 Jul 2024 16:33:15 +0800
X-QQ-mid: xmsmtpt1720513995tljfulh3y
Message-ID: <tencent_5E4637BE7BC1256D39C73ADCA118BD908507@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8uL2HVuJBhrc2zAVCXYqfSPwHYj62qWb+qslMUIDbV9iV10zUPH
	 95MtuFCze5+eXMx1sO3Slave2zPHVzzR4DPgdm56wJgIrzfS3mvm/4Y6/iUYW3LJdK49RS9koOa+
	 QSLcFhE6449nsojnTLk/fdvm7DMryjNZJfbdCvqsM6s7So8ACXdj7SXTkhyPVrjMUw4Tc52z+fmK
	 iafwUNfni0U6ovzhQsurnRIpZEzZqjucSF6XveP1mXgiXPLfPcw89XeHHTbq2Ig79mxQkaBYkPFP
	 8z9fj8KdVFfaGk1y2qTvtvvhwauW0/QZv6t39TG37aR2Mze4FjeyfZgYknLwkXUY5jEudjYIEFNA
	 aNFuMi9bmubSvzSm/IxoFJNKWINDNQ4AeGIFJE/UzuYe5vc7sJZSolC+X2rQq4cAT92BMiIKdXxt
	 jKXLrixsCo8+xjfQjUSYb5s5Hu1xdo9nfVGzlMhyV0d+7HUuYd/9mkjQVN8rieLwfwH+pWhSTC5A
	 2OicUuySMPreplf6LdFHhTBDqi5aRh4ZWx2z/mExGq/ZEQIfpsSMHPKtVSs56L0uUcFBeVbhUXHS
	 yvpS/RxQlACyvtnPm9sL1AHTQ1wOYccjE9Tt8+0jh4koVHW5xYjUguDKXhkVP62nACPVVxoyFfjc
	 /Da3f8jOfJ9KjsdPz63BeeUBKxV0HXrm8Paif9qe+9koOpKJcGqr3Pew6Qb9RWIVfMgKyYZtjQnZ
	 MhlNE4zzg9iWY/3/ygFTESXmnfqHNvlEevQrR9dLo4f3CfoTniDKskOg7IDfZWe6GyUhS4K5LVfO
	 d75oOtc53EmZmVAwIh/5DPrfOutk4NBHUBoLGWS6ZiGRjepxXOnC09X4jnlrEdzUt+MhpORNISNQ
	 tQjbPHZ4OaCKyIfnJ3mGBynadzt3OjrV2I0zSAhVll7nVIlf6E3W57vw/u2tgAT5lQ1QI01rBUJf
	 0YGJToFxSc1oA1AIG5R0nCn15KPorsHomUxPo0cjNLaiC3HwYx8ziIyPjgatabu3hoL2bzt+k=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Yangyu Chen <cyy@cyyself.name>
To: iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH -fixes] dma-direct: only reference arch_dma_set_uncached symbol when usable
Date: Tue,  9 Jul 2024 16:32:48 +0800
X-OQ-MSGID: <20240709083248.3945303-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arch_dma_set_uncached symbol is only used when the architecture
provides it. However, many architectures do not provide it, and the
code currently relies on compiler optimization to cut the unnecessary
code. When the compiler fails to optimize it, the code will reference
the symbol and cause a link error. I found this bug when developing
some new extensions for RISC-V on LLVM.

This patch adds a check to avoid the reference to the symbol when it is
not provided.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 kernel/dma/direct.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4d543b1e9d57..cdf3616a6def 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -293,9 +293,14 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 
 	if (set_uncached) {
 		arch_dma_prep_coherent(page, size);
+#ifdef CONFIG_ARCH_HAS_DMA_SET_UNCACHED
 		ret = arch_dma_set_uncached(ret, size);
 		if (IS_ERR(ret))
 			goto out_encrypt_pages;
+#else
+		dev_err_once(dev, "BUG: set_uncached set but arch doesn't have dma_set_uncached\n");
+		goto out_encrypt_pages;
+#endif
 	}
 
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
-- 
2.45.2

