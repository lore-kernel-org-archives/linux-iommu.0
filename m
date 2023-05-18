Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70641125A0
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 13:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=piFrG5IdL4hzL74U9vzU8Q8FkrcebDa8Lvd7CJSzX1k=; b=CsnQ9kgCBYwe6gnaRylmDTM7Wg
	VjmAGMjJNouFmojoa2PViZy7KmCYkXfDItlxSiGdMRAKa4u6bzwnXH4xPbITOvKi46E/e8j1923vR
	u9Qj20fH+4Jugzi8umtd5H2NCKBNNKBIBV0dxSh72+mq7t83yJrzFx7FLxqhbec1O5OZi/yVN98fM
	bMfK/BLvhmvFSMgRRzB1zl6hg7RjhlcD4Ba8FO3xlDIUmySBgiGGVXbnu2ZFgjv2AQpplWQ2Swsa/
	jUTX+NHAV9OEu62r3wgbLMxWNseWs9tNZ5xv/HXPufF4KzJy/mSF0tCwCSPpD5y/XE2Ohl7NFw+0f
	4i0qXJRg==;
Received: from [2001:4bb8:188:3dd5:1149:8081:5f51:3e54] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1pzduC-00D6Qd-2E;
	Thu, 18 May 2023 13:42:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ben Skeggs <bskeggs@redhat.com>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>
Cc: xen-devel@lists.xenproject.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org
Subject: unexport swiotlb_active
Date: Thu, 18 May 2023 15:42:49 +0200
Message-Id: <20230518134253.909623-1-hch@lst.de>
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

Diffstat:
 arch/x86/include/asm/xen/swiotlb-xen.h |    6 ------
 arch/x86/kernel/pci-dma.c              |   28 ++++------------------------
 drivers/gpu/drm/nouveau/nouveau_ttm.c  |   10 +++-------
 drivers/pci/xen-pcifront.c             |    6 ------
 kernel/dma/swiotlb.c                   |    1 -
 5 files changed, 7 insertions(+), 44 deletions(-)
