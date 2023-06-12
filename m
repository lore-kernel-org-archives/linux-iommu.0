Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADDB19E79
	for <iommu@lists.linux.dev>; Mon, 12 Jun 2023 14:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=f6jpt7lo8djdkscLPVrkqv8ySzbiCW/dI5HE2X2RneY=; b=D++FS2n3NbokanCiRHuXrRYJFB
	1O4lDTnE+D1HQHO2AKpMGQ9+FQIFYTJSb0lQt3XrPAm08Tq6mnTZq+kgtFT44f8tGewYEwfIZHO/h
	YBgrsdTbfjZ9Y1XMZSrXDLROWWaZstFQitWpEw7rmifT7IYuYN6djDb3d/YRnetzhSJJqpJELxqq2
	czIJi68GIT2zYuBVMka5Tl6uYHkD99z8M5hudtG6z1deEZxdxZHfnXeCQXVwyr8sGMxDTDg/oQrBa
	qITv89Zql2Si0e2SXoNmdtiN/FNHvISQbH03beP0rj+2N5MP2tb9B/fKR/5zmT67+j6MAscZFdmih
	9rBheVNA==;
Received: from 2a02-8389-2341-5b80-8c8c-28f8-1274-e038.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8c8c:28f8:1274:e038] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q8iUN-004I84-13;
	Mon, 12 Jun 2023 14:25:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: xen-devel@lists.xenproject.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: unexport swiotlb_active v2
Date: Mon, 12 Jun 2023 16:25:39 +0200
Message-Id: <20230612142542.111581-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this little series removes the last swiotlb API exposed to modules.

Changes since v1:
 - add a patch from Juergen to export if the e820 table indicates Xen PV
   PCI is enabled
 - slightly reorganize the logic to check if swiotlb is needed for
   Xen/x86
 - drop the already merged nouveau patch

Diffstat:
 arch/x86/include/asm/xen/swiotlb-xen.h |    6 ------
 arch/x86/kernel/pci-dma.c              |   29 +++++++----------------------
 arch/x86/xen/setup.c                   |    6 ++++++
 drivers/pci/xen-pcifront.c             |    6 ------
 include/xen/xen.h                      |    6 ++++++
 kernel/dma/swiotlb.c                   |    1 -
 6 files changed, 19 insertions(+), 35 deletions(-)
