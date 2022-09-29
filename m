Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD707A47
	for <iommu@lists.linux.dev>; Thu, 29 Sep 2022 14:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5FBC433D6;
	Thu, 29 Sep 2022 14:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664461929;
	bh=+CMzqfKQBFDlTPBluCEbkfHV9J5CITs8KfGeq6Svh0U=;
	h=From:To:Cc:Subject:Date:From;
	b=r1GVqZuHnBHPflK7bfh++hH6TdU0WxVd/vXT7zjr7kDdH6LQBw1yROjrgUnm+4lna
	 rFlbxCyDpRbBdqGxe0tPGq5C3MwE+n8MQGI4HxfzHEYL2IFds9vITX4nJiHkeTOyyf
	 7vXgK8swzz4AgbzXtQrPFcnIrv73yD3D2RO+lrhyYnuQU2Sgqwcufv6X1a93c46H7C
	 m4NTbwMfe0EYnp4IrfPTKPjUlHQN6amjuZLFc9kcyJBkfe1OTXoeVdArU4W2jpcA5M
	 SAnhgdtDxrYL66Afb3WDDdwgWHyEfvtCAu1nQ9s/6z/lKyD8KHYywFBAgoeNCjHmuc
	 l5hW+ZBnahCbQ==
From: broonie@kernel.org
To: Marc Zyngier <maz@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <jroedel@suse.de>,
	Frank Li <Frank.Li@nxp.com>,
	Will Deacon <will@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: linux-next: build failure after merge of the irqchip tree
Date: Thu, 29 Sep 2022 15:31:48 +0100
Message-Id: <20220929143149.126145-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

After merging the irqchip tree, today's linux-next build (arm64
defconfig) failed like this:

/tmp/next/build/drivers/irqchip/irq-imx-mu-msi.c:14:10: fatal error: linux/dma-iommu.h: No such file or directory
   14 | #include <linux/dma-iommu.h>
      |          ^~~~~~~~~~~~~~~~~~~

Caused by commit

  841e6e9f2bc95baff ("irqchip: Add IMX MU MSI controller driver")

interacting with

  f2042ed21da7f8886 ("iommu/dma: Make header private")

I have reverted the driver for today.
