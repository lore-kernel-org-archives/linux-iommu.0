Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD551940B0;
	Thu, 28 May 2026 05:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779947186; cv=none; b=j+UxHBWKJKbv8QFSQ5L7OyE/aNsYW+r7aVqmtCubZ0E7jCQXbvpwVPqREOQuqSUs9WlOveEyxGKHHpDYkYvnQiafqwNBA0krVcP+E2jHxAMjVbvnUsl1TxDgvLRXjDBsTbjA6mGN4pDz9V2WmpVgkh39V3uSzKRPR+wiiuRypNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779947186; c=relaxed/simple;
	bh=vRplcPPetVrP41t9VSybTHS8jAdvhvc/utVsjAH6HOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rfppKuwa2tm3viw/k0wy1fdgAbFTjDPI8lJE5hp6NH89b5n8qDba/WW7c2K6IQA5dG9Vv3P9uPK7GkJCaIKMPNlSUzfNElpuoQeGjYYjJr/M1FZ2Pehtfl9vVIEMZAliAUcvc+uJLYDLvrDwiT2QuqdmFbTc1PmO8+KnKIhxHbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xVlWgDX/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xVlWgDX/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=PjXuJQaHKPAZNAO+ZnE/uu4HDeWWeRJ7hBGHk01iNq0=; b=xVlWgDX/8ECEyuaGDngqYtcU02
	AkQ11NX0Mo7KeR4uIjQglim7quo5/a1Ab3B8BQh1yj6pM3R0p9BmzezSZ+cU3YUjZFKCvpzeq+dAM
	9BN5eQV92rsm7SYZ5baZXI8ODI9MDc+BfCZt2pkwYbfhltpvAP2oWnYEC6N0qvwBrXoF6B1Ll5I5L
	gpnkEK34ol/joGNBygbsgGsaXFp0WgU1Xo3wVZ735edkoP7C7eDnk6YdENi/G24Nv+cRmC1/eOKsY
	Y0TrSpqZyV4FvewmMmsJU6QC87BdiuyfrDLYQynLgi/gQmvW6AiMUNyunPWkMm1CaJKkxtpJ7Mxz2
	k60FLnAA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSTZN-000000059ys-1IH7;
	Thu, 28 May 2026 05:46:13 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH] iommu: Documentation: rearrange, update kernel-parameters
Date: Wed, 27 May 2026 22:46:11 -0700
Message-ID: <20260528054611.1524937-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add text for some undescribed iommu= parameters (merge, nomerge,
biomerge, panic, nopanic, pt, nopt). Add "usedac" and its description.
Add that iommu=pt is equivalent to iommu.passthrough=1
and that iommu=nopt is equivalent to iommu.passthrough=0.

Move the PPC/POWERNV heading & its option "nobypass" to a separate
area since the current "iommu=" applies only to X86 (according to
its heading).

Unindent the AMD GART IOMMU options heading to make it stand out.
Also add its kconfig symbol name to be explicit about what these
options apply to.

Make sure that the IOMMU options that are listed under AMD Gart
HW IOMMU-specific options are only for that product; i.e., add "force"
there and move "merge", "nomerge", and "panic" to the general IOMMU
options area.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
NB: Wording suggestions welcome.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev
Cc: Borislav Petkov <bp@alien8.de>

 Documentation/admin-guide/kernel-parameters.txt |   48 +++++++++-----
 1 file changed, 32 insertions(+), 16 deletions(-)

--- linux-next-20260527.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-next-20260527/Documentation/admin-guide/kernel-parameters.txt
@@ -2548,23 +2548,41 @@ Kernel parameters
 			Don't force hardware IOMMU usage when it is not
 			needed. (default).
 
+		merge
+			Do scatter-gather (SG) merging. Implies "force"
+			(experimental).
+
+		nomerge
+			Don't do scatter-gather (SG) merging.
+
 		biomerge
+			Do scatter-gather (SG) merging. Implies "force"
+			(experimental). [same as "merge"]
+
 		panic
+			Always panic when IOMMU overflows.
+
 		nopanic
-		merge
-		nomerge
+			Don't panic on IOMMU overflows.
+
+		pt
+			Use passththrough mode by default
+			(Equivalent to iommu.passthrough=1)
+
+		nopt
+			Use translated mode for DMA by default
+			(Equivalent to iommu.passthrough=0)
 
 		soft
 			Use software bounce buffering (SWIOTLB) (default for
 			Intel machines). This can be used to prevent the usage
 			of an available hardware IOMMU.
 
-		pt
-		nopt
-		nobypass	[PPC/POWERNV]
-			Disable IOMMU bypass, using IOMMU for PCI devices.
+		usedac
+			Use the DAC on VIA PCI bridge
+			(default: disable the VIA PCI bridge DAC)
 
-		AMD Gart HW IOMMU-specific options:
+	    AMD Gart HW IOMMU-specific options: (CONFIG_GART_IOMMU)
 
 		<size>
 			Set the size of the remapping area in bytes.
@@ -2572,6 +2590,9 @@ Kernel parameters
 		allowed
 			Overwrite iommu off workarounds for specific chipsets
 
+		force
+			Overwrite iommu off workarounds for specific chipsets
+
 		fullflush
 			Flush IOMMU on each allocation (default).
 
@@ -2582,21 +2603,16 @@ Kernel parameters
 			Allocate an own aperture over RAM with size
 			32MB<<order.  (default: order=1, i.e. 64MB)
 
-		merge
-			Do scatter-gather (SG) merging. Implies "force"
-			(experimental).
-
-		nomerge
-			Don't do scatter-gather (SG) merging.
-
 		noaperture
 			Ask the IOMMU not to touch the aperture for AGP.
 
 		noagp
 			Don't initialize the AGP driver and use full aperture.
 
-		panic
-			Always panic when IOMMU overflows.
+	iommu=		[PPC/POWERNV]
+
+		nobypass
+			Disable IOMMU bypass, using IOMMU for PCI devices.
 
 	iommu.forcedac=	[ARM64,X86,EARLY] Control IOVA allocation for PCI devices.
 			Format: { "0" | "1" }
