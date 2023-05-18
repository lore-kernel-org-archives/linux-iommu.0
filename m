Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2AE11CA8
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 13:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NrwaDXndPVrlGW4jqCyf20MCAXo0YJy7aoO3FDItFxI=; b=lh9YNaJgqjsQ4ABDzfBXPDYhnF
	0rgvGegVpdV31RoZMvM9hbEbN94AXBXG4zrc9vSce86yoaAY93okWrN31ceblBj4ur0q1+YmfM6Hg
	v2JiJP+oecPzr+HP7G86rf0eM/dmlMOfuhqIhS4tMRcj+JGXLecrE0QZepRPPoZJwkQxnA+j3FdZt
	RlxkFpSPRj7ljl509O3DDGybPMxj20tGTo404+biDFXzMLHmhd46mUIWs42T8tBhOx2EJsaRBCXG2
	KFhN7YElPvMIUpYDvbAlPmwYYGOnFHuhw97nSyrLo0FGUtm5W07Q29cDo0EwumNuBftywhBKx3uyT
	dshNqNvg==;
Received: from [2001:4bb8:188:3dd5:1149:8081:5f51:3e54] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1pzduN-00D6T3-0S;
	Thu, 18 May 2023 13:43:07 +0000
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
Subject: [PATCH 4/4] swiotlb: unexport is_swiotlb_active
Date: Thu, 18 May 2023 15:42:53 +0200
Message-Id: <20230518134253.909623-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518134253.909623-1-hch@lst.de>
References: <20230518134253.909623-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Drivers have no business looking at dma-mapping or swiotlb internals.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index af2e304c672c43..9f1fd28264a067 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -921,7 +921,6 @@ bool is_swiotlb_active(struct device *dev)
 
 	return mem && mem->nslabs;
 }
-EXPORT_SYMBOL_GPL(is_swiotlb_active);
 
 #ifdef CONFIG_DEBUG_FS
 
-- 
2.39.2

