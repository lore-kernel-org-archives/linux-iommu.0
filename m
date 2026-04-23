Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506653C1404
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979428; cv=none; b=ZIH1rAf1SkXigl199SQzYZHMoJe46fZeQq+8b+pvT8/M/qTnu9vYd44YM1ux7r4ugLpnkpuQU5q53bq8tT+Vsp1IE6zlWploxJBsC0HfPvcUnNsyMqsKG8DnUMCsalcvIH6Fcd1zk2Nn8eNvedZoFNsYASAHN4Lj0KqDT+ptbhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979428; c=relaxed/simple;
	bh=TAk9N0onkf1LhiBL762i+SXrkfm+35fT9FFl7hPmejg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dd0R3EvzVAtzeu4ZHNjG45PszP+M+cHMQNMhu+UsY666ybxzNXABiiQjE9nvl8QyfrBygXTQ0xmDpKDpynzeSEs914sYT3H/2NvrM7Rug1Mv+M4x2/g8xbgq6vOQ4j+sXomXmPQVPPtZhts1/2lNtFWqnuToUTx1vd3gG6MvgQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uRIhEbge; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uRIhEbge"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2e8bba2e6so100401515ad.1
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 14:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979420; x=1777584220; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4E3v8P9Bgd+PvGMRS8uoO/TIv3RrWRtb2HfczKdNV9k=;
        b=uRIhEbgeiwZWMrkdXDn4izqq+RsydG/rAQFLx9scimHDOfiurBOsag6vcdnjBG78oW
         oGUlILnMTmp/h28Im8PR9pklZI3jVNZt4y/JjwmP9tBKUwDRkBEaCPX+yEva1ni2zEqT
         JVQEaQEQTS2OmN7j3dHAl5Lr5wfzcFFxg5Nj8GbQq0j0fORS96cDvpFVptx0MAHjVGiZ
         DrvY72AsVt5OELvygeaWb4nXKUI5/AonEaZkBPfr/vGYVhG17C2aNdP0UdNJd2uaflwF
         +xaaGDlz9KrG9Y84lnyPO3uc7S0CbxjUz6Xf0HQHtO4v4455/eg/15iALaBP5oU2AWSW
         dvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979420; x=1777584220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4E3v8P9Bgd+PvGMRS8uoO/TIv3RrWRtb2HfczKdNV9k=;
        b=Tt92lSWS7gO1JdMDzYL72ujuNsOpq4giAwvobeaV1Cx6Tyilnk6ANYoZUL6ZeCt3FB
         RY2j7/YsWulCDo+UuhmEnRABi1pGKTCF/fj9DnwpBxCe7ZSFgp4fpUVwpkF9Y2KGh9+0
         6SCjx3IM38TS81Ey1vBQfuVkmuZvXj/SAPdFyCmj1g+Vgx+XhNukBcKHCW4y82BA2+Xr
         XkaY5sps8TQ/GZw1kommLUy+MNenNHh+aR2yoTuncQP8C46r1KPYlipBVckSQ11PF3fD
         TR9TVaomxsO6f9PEv+afjXm1qo+kqUSN/9atYpGLFpz5wC1LmMVapRpjzzULRlfAMd0V
         2Q5A==
X-Gm-Message-State: AOJu0YzawM4E+xavz6nGWVOxClHE1zdakQgc+AbX0MzNc2Rl3AM5q/XN
	2ar90S30ERjEFbg+lAFgppJv08j+9Vlfi5xrnYyJk4OZancndRbOaG4CTU0fdo7igmP881th2X0
	stoF3N7DXGdFUgDFbHukcV74tArVXqIwMCCfTKQpFelHFSpn24TgkIEsTKLvPJj4JcykuTdcYBp
	zoLn6Xym++skrcv98CHGqCXGu6MZyqQ2iUbxVjgJ2G74irSg==
X-Received: from plon6.prod.google.com ([2002:a17:903:1a86:b0:2b2:c9d2:11fd])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2984:b0:2b0:4f9a:b794 with SMTP id d9443c01a7336-2b5f9fd146amr301151585ad.37.1776979419527;
 Thu, 23 Apr 2026 14:23:39 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:23:15 +0000
In-Reply-To: <20260423212316.3431746-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212316.3431746-12-dmatlack@google.com>
Subject: [PATCH v4 11/11] Documentation: PCI: Add documentation for Live Update
From: David Matlack <dmatlack@google.com>
To: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add documentation files for the PCI subsystem's participation in Live
Update.

These documentation files are generated from the kernel-doc comments
in the PCI Live Update source code. They describe the File-Lifecycle
Bound (FLB) API, the device tracking API, and the specific policies
applied to preserved devices (such as bus number inheritance and bus
mastering preservation).

Signed-off-by: David Matlack <dmatlack@google.com>
---
 Documentation/PCI/index.rst           |  1 +
 Documentation/PCI/liveupdate.rst      | 23 +++++++++++++++++++++++
 Documentation/core-api/liveupdate.rst |  1 +
 MAINTAINERS                           |  1 +
 4 files changed, 26 insertions(+)
 create mode 100644 Documentation/PCI/liveupdate.rst

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 5d720d2a415e..23fb737ac969 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -20,3 +20,4 @@ PCI Bus Subsystem
    controller/index
    boot-interrupts
    tph
+   liveupdate
diff --git a/Documentation/PCI/liveupdate.rst b/Documentation/PCI/liveupdate.rst
new file mode 100644
index 000000000000..04c9b675e8df
--- /dev/null
+++ b/Documentation/PCI/liveupdate.rst
@@ -0,0 +1,23 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+===========================
+PCI Support for Live Update
+===========================
+
+.. kernel-doc:: drivers/pci/liveupdate.c
+   :doc: PCI Live Update
+
+PCI Preservation ABI
+====================
+
+.. kernel-doc:: include/linux/kho/abi/pci.h
+   :doc: PCI File-Lifecycle Bound (FLB) Live Update ABI
+
+.. kernel-doc:: include/linux/kho/abi/pci.h
+   :internal:
+
+See Also
+========
+
+ * :doc:`/core-api/liveupdate`
+ * :doc:`/core-api/kho/index`
diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index 5a292d0f3706..d56a7760978a 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -70,3 +70,4 @@ See Also
 
 - :doc:`Live Update uAPI </userspace-api/liveupdate>`
 - :doc:`/core-api/kho/index`
+- :doc:`PCI </PCI/liveupdate>`
diff --git a/MAINTAINERS b/MAINTAINERS
index 94af31837375..42dbac2c2ed3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20564,6 +20564,7 @@ Q:	https://patchwork.kernel.org/project/linux-pci/list/
 B:	https://bugzilla.kernel.org
 C:	irc://irc.oftc.net/linux-pci
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
+F:	Documentation/PCI/liveupdate.rst
 F:	drivers/pci/liveupdate.c
 F:	include/linux/kho/abi/pci.h
 
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

