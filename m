Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF643191CE;
	Thu, 16 Jul 2026 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215036; cv=none; b=cJqdnnbTsZhzyXENvOelZQY6jhRncflCIbiS6+u3KBDgiiqPh/x3GkZH1c0b+bRr3gmUOek/oMEqu6xaLt3xH9tqetWkWvDYFWE3KVRN3KhOW/su3Ny1wCRNKvTlYEhv3bjD/m7+cAxMStHXhjTBX0529Cfesjan/RxROqIfYWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215036; c=relaxed/simple;
	bh=WXbAlKnSzuKzSG5uA2tXLu0mvst5mEQG51/R0yyEOsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHiVU97lUr+M7ZgEHoI03M71OEJJmCLaDTccd9lR3pGrnNlcoqFCX9YwIpeDGgob9ISSHlKJmCzmElasYjbiujdB5hEZyTgtCI98LwMS9PrcSojRmCCvU+tFr27xPcjP6lcHGyXhKGyxpp6xUsrDswGATwQ41bTTHXTLMLghBVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AjCpaaG8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AjCpaaG8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=I36zes5J1OBHNIkYSgvnduT5T8HFGBEcGRVQg15PSEI=; b=AjCpaaG8ZlH7o1ACCuMzTe9dB5
	lzoHB4aavR1XoMNcl5eqOw+QFWK0zLi3QRYgd4RWD9tgSp4nkMreUuAfO0evEwJKed1RNjEY82QWK
	IxrA8+H6Tks+qEqRt+BWS5Geb6SX2veRS/pn7G+jswM4oCkVUclO8D2bzQpRQyZsr9/pmOrMgiSnH
	aCnooDMoHAXOcsQReou4P2Bv94UHtd0NI3dGPHfRMOsBXMkxZn7uYXGZRBw6CoC77K0AAQ2akDOFL
	wLTBVeTzH990/256HpHQZlIJHvl73faz1uia6lZXfm9KgidBNxgAXwbZRRBNRRf68zq0kOn5FvZsJ
	IloqYmJQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkNpj-00000002l0G-2ZXB;
	Thu, 16 Jul 2026 15:17:07 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wkNpj-000000012t6-1JXK;
	Thu, 16 Jul 2026 16:17:07 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Tycho Andersen <tycho@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Connor Williamson <connordw@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zhou Yuhang <zhouyuhang@kylinos.cn>,
	Zi Li <zi.li@linux.dev>,
	Dan Williams <djbw@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Colin Ian King <colin.i.king@gmail.com>,
	connordw@amazon.co.uk,
	graf@amazon.de,
	fgriffo@amazon.co.uk,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [RFC PATCH 05/11] iommufd: Look up private-interconnect phys via exporter symbols
Date: Thu, 16 Jul 2026 10:31:25 +0100
Message-ID: <23bae967aa2bf38b7696c5cbcdf003cf43e98358.1784194290.git.dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
References: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The dma-buf phys-map dispatch used by iommufd's IOMMU_IOAS_MAP_FILE path
currently knows only about the VFIO PCI exporter (looked up via
symbol_get(vfio_pci_dma_buf_iommufd_map)).  Widen the dispatch so
additional exporters can advertise the same well-known symbol name
convention and have their dma-bufs mapped without an explicit iommufd
dependency in each exporter's module.

For now the dispatch tries the sample guest_memfd provider's exporter
first, then falls back to VFIO PCI, both via symbol_get.  This mirrors
the pattern the in-tree comment already flags:

	"iommufd and vfio have a circular dependency.  Future work for a
	 phys based private interconnect will remove this."

The eventual formal negotiated dma_buf_ops op that returns phys plus a
memory-type descriptor will subsume both of these lookups.  The next
patch plumbs the memory type through iommufd; a follow-up will convert
the symbol lookups to the negotiated op.

Based on a proof-of-concept by Connor Williamson <connordw@amazon.com>

Signed-off-by: David Woodhouse (Kiro) <dwmw@amazon.co.uk>
---
 drivers/iommu/iommufd/pages.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 03c8379bbc34..2d4ea41460fd 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1470,6 +1470,26 @@ sym_vfio_pci_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
 	if (rc != -EOPNOTSUPP)
 		return rc;
 
+	/*
+	 * Prototype: try the sample gmem provider's dma-buf exporter.  This
+	 * mirrors the vfio-pci private-interconnect hook, and (like it) is
+	 * meant to be replaced by a formal negotiated exporter op returning
+	 * phys for iommufd.
+	 */
+	{
+		extern int gmem_provider_dma_buf_iommufd_map(
+			struct dma_buf_attachment *, struct phys_vec *);
+		typeof(&gmem_provider_dma_buf_iommufd_map) gfn;
+
+		gfn = symbol_get(gmem_provider_dma_buf_iommufd_map);
+		if (gfn) {
+			rc = gfn(attachment, phys);
+			symbol_put(gmem_provider_dma_buf_iommufd_map);
+			if (rc != -EOPNOTSUPP)
+				return rc;
+		}
+	}
+
 	if (!IS_ENABLED(CONFIG_VFIO_PCI_DMABUF))
 		return -EOPNOTSUPP;
 
-- 
2.54.0

