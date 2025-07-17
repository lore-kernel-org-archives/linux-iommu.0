Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FE02AE96
	for <iommu@lists.linux.dev>; Thu, 17 Jul 2025 01:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752714231; cv=none; b=N5SwPz7ooXLcot19/OfyVAYj3AozZ6LyebBwNR/6tuaOBBXhAwr2iT7tLYxZuA1OAZuS4J5k/4/KYBeYdPVan99VoLQ0r5AYJKhx0oinr5AloAgzLMIrlCAqH0Dyu53EtUb8GjQHtth4DPoG4oGdrTWD6n2n1JjRxEFIOit8s/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752714231; c=relaxed/simple;
	bh=r7KBEe/U1rHOla01d//g2fAxzBm5HnT8XVj9/Cuyqu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ITU0RmXZ4E8FDj8xoDKm+US4SHf+aI8bXPyBnVSlyaDNHLdZgFJYJgg9iOYMtBdBEw0McCwi6xvYCRiOGl+NjwRmwBJ621uOKbqxbF0u7pG4eSGieRMABy55orLP50ad0jlyQJw4a/gdIFMvMbh7CM9GUxCf92areWPaZP4YW5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZ9Ebeyf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZ9Ebeyf"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45629703011so2791475e9.0
        for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 18:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752714227; x=1753319027; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sscvi53gVDM4UOp6lMcVQ4uaKrceVNglNU+jEsJsRcY=;
        b=KZ9Ebeyf8ju3ffhL25ahn5eOzPEay7yPrVSDPZthsBYPSU9QGxFtoyc0roY085G3IM
         GWV3TTIZqN/uDwcAJjP/cRVe/9pU02zXBL2kj0USF4cI7G+w34jGa0BcX9NoIbaHeKJP
         gz+lzorGqB9ZTtgeCwL+gArwNvSIyJ8sfpiVxukRX58uqdksQIHu0FkrmRypKsKvxywv
         pWKLAm9sTEmPcHbuwYHs5+9aDRq36hrOcHjcbkkZTfFm+yEQtRU0tJ1O3S87QqmXkIuG
         4kTvY3ei7y1xvWlaOlW70kpxulLNjm5m8y1OJ8ZRtTz15Ez8ydETKK1G+urXzc325iTW
         0z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752714227; x=1753319027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sscvi53gVDM4UOp6lMcVQ4uaKrceVNglNU+jEsJsRcY=;
        b=j1y+1DW9HEU8+5jqpxMRXeZm3b2GMc7aTZRjFLxbXqKMJdCdNdaCp67miHYyBxDsNT
         ZxRBn16GDjcQ91AURqg7i4KZ54IW8J6IEVC2BSoqOZmDxoHODklPuhtAeuGlVeCZe2Tu
         6uPZJQ66lkqrihVyONoMnhm5pS9fh9imLIxHXvEg0+s6oTnYDoQUn+QodFGR/OEB1WeG
         +CdP8pUjPosX/PzTOr3DmX86E+nEPENfb6BS4l6PO0ZM1k/ny0FY4c/GSDTBuLdFxmcD
         tD/cKSEpJ7c7Dhkf+OTgdyywIqgi/8sZ8saGfUgP2QqzVG3J2yPxNWX7A0zBp7MrEoe3
         sN9A==
X-Forwarded-Encrypted: i=1; AJvYcCUPgqSygvgxr12Gwe8iHop+Hqx9+KOmsOAbYAEJVvfopZ0uQBi6gTHU7saOERfUB76v/yRUEg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyz2oD92fFbwujORj4RLh50x0QQQChfXN0gBxIWwEZku8UoVUdo
	jGJKxXJ86Z7/RRjAAoTPb3WcOaKkOzTZJ4I9d6tKWqxvsG0/FAvjBbf/JSH6jqyC
X-Gm-Gg: ASbGncth1S4j2kqVZBnO44VZK8K72obSW60pk5AzFJMzHG8A3QAC3VCKqb34Ho4NJQf
	W+hff/fX0FmVBoJac3X1q94kKtFBtlxrUkLMvuYq8e3cgoMox3ne1KI6BExYaQ2JKm0X5if655G
	p4ILrWYqYJeWdt13K8l8DxW5WjfCZF2WlQWkV4AUSxJ+Ms+W2BHrELm4UDnCMu+Fqg3q0EXYFHS
	k2hDphM34A+NQKLEP9EH31dyUNB6zDyckelisGEJnckyNLYutdvSZkNchZCXJ1m0i16JdPrhU5l
	OHVK3hUOgFpr+8h7yCOO7FWfd68LN+nvxXtPgyoSK9FaGyVSB9jGrH4Pou2fsG5kV/6uJ83e1MT
	4io1iIrRchYpRL8MiWq6MXQ==
X-Google-Smtp-Source: AGHT+IFOgLZETh8Ec/9h9BgSa32GB4DdT5xGpUYmcL3HY81MNy2vA3E521MJaU8PzthhUPDX8qDx+A==
X-Received: by 2002:a05:6000:400e:b0:3a4:f7ae:77e8 with SMTP id ffacd0b85a97d-3b60dd6a91cmr4297940f8f.15.1752714227303;
        Wed, 16 Jul 2025 18:03:47 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e269a0sm19070592f8f.86.2025.07.16.18.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 18:03:46 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 85079420A818; Thu, 17 Jul 2025 08:03:41 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>
Cc: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Will Deacon <will@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Ashish Kalra <Ashish.Kalra@amd.com>,
	=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] iommu/amd: Wrap debugfs ABI testing symbols snippets in literal code blocks
Date: Thu, 17 Jul 2025 08:03:31 +0700
Message-ID: <20250717010331.8941-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6987; i=bagasdotme@gmail.com; h=from:subject; bh=r7KBEe/U1rHOla01d//g2fAxzBm5HnT8XVj9/Cuyqu8=; b=kA0DAAoW9rmJSVVRTqMByyZiAGh4SciiGSIRre2rNT1nmAv1l5NSQWz9aASgtyY9q/mCAYTqt 4h1BAAWCgAdFiEEkmEOgsu6MhTQh61B9rmJSVVRTqMFAmh4ScgACgkQ9rmJSVVRTqMe+wD/c3ep 8NeeT5p0fbdqd1ZGfdaNFgpyFwSvxjGWhSwueuwA/iinJIJLLzIwBLecFt/9F+PdVvVNsjn+7Vm BUFMVxCgL
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Commit 39215bb3b0d929 ("iommu/amd: Add documentation for AMD IOMMU
debugfs support") documents debugfs ABI symbols for AMD IOMMU, but
forgets to wrap examples snippets and their output in literal code
blocks, hence Sphinx reports indentation warnings:

Documentation/ABI/testing/debugfs-amd-iommu:31: ERROR: Unexpected indentation. [docutils]
Documentation/ABI/testing/debugfs-amd-iommu:31: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
Documentation/ABI/testing/debugfs-amd-iommu:31: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]

Wrap them to fix the warnings.

Fixes: 39215bb3b0d9 ("iommu/amd: Add documentation for AMD IOMMU debugfs support")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20250716204207.73869849@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/ABI/testing/debugfs-amd-iommu | 125 +++++++++++---------
 1 file changed, 71 insertions(+), 54 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-amd-iommu b/Documentation/ABI/testing/debugfs-amd-iommu
index c14b1620aec171..5621a66aa6936a 100644
--- a/Documentation/ABI/testing/debugfs-amd-iommu
+++ b/Documentation/ABI/testing/debugfs-amd-iommu
@@ -6,12 +6,14 @@ Description:
 		MMIO register offset for iommu<x>, and the file outputs the corresponding
 		MMIO register value of iommu<x>
 
-		Example:
-		$ echo "0x18" > /sys/kernel/debug/iommu/amd/iommu00/mmio
-		$ cat /sys/kernel/debug/iommu/amd/iommu00/mmio
+		Example::
 
-		Output:
-		Offset:0x18 Value:0x000c22000003f48d
+		  $ echo "0x18" > /sys/kernel/debug/iommu/amd/iommu00/mmio
+		  $ cat /sys/kernel/debug/iommu/amd/iommu00/mmio
+
+		Output::
+
+		  Offset:0x18 Value:0x000c22000003f48d
 
 What:		/sys/kernel/debug/iommu/amd/iommu<x>/capability
 Date:		January 2025
@@ -21,12 +23,14 @@ Description:
 		capability register offset for iommu<x>, and the file outputs the
 		corresponding capability register value of iommu<x>.
 
-		Example:
-		$ echo "0x10" > /sys/kernel/debug/iommu/amd/iommu00/capability
-		$ cat /sys/kernel/debug/iommu/amd/iommu00/capability
+		Example::
 
-		Output:
-		Offset:0x10 Value:0x00203040
+		  $ echo "0x10" > /sys/kernel/debug/iommu/amd/iommu00/capability
+		  $ cat /sys/kernel/debug/iommu/amd/iommu00/capability
+
+		Output::
+
+		  Offset:0x10 Value:0x00203040
 
 What:		/sys/kernel/debug/iommu/amd/iommu<x>/cmdbuf
 Date:		January 2025
@@ -35,24 +39,26 @@ Description:
 		This file is a read-only output file containing iommu<x> command
 		buffer entries.
 
-		Examples:
-		$ cat /sys/kernel/debug/iommu/amd/iommu<x>/cmdbuf
+		Examples::
 
-		Output:
-		CMD Buffer Head Offset:339 Tail Offset:339
-		  0: 00835001 10000001 00003c00 00000000
-		  1: 00000000 30000005 fffff003 7fffffff
-		  2: 00835001 10000001 00003c01 00000000
-		  3: 00000000 30000005 fffff003 7fffffff
-		  4: 00835001 10000001 00003c02 00000000
-		  5: 00000000 30000005 fffff003 7fffffff
-		  6: 00835001 10000001 00003c03 00000000
-		  7: 00000000 30000005 fffff003 7fffffff
-		  8: 00835001 10000001 00003c04 00000000
-		  9: 00000000 30000005 fffff003 7fffffff
-		 10: 00835001 10000001 00003c05 00000000
-		 11: 00000000 30000005 fffff003 7fffffff
-		[...]
+		  $ cat /sys/kernel/debug/iommu/amd/iommu<x>/cmdbuf
+
+		Output::
+
+		  CMD Buffer Head Offset:339 Tail Offset:339
+		    0: 00835001 10000001 00003c00 00000000
+		    1: 00000000 30000005 fffff003 7fffffff
+		    2: 00835001 10000001 00003c01 00000000
+		    3: 00000000 30000005 fffff003 7fffffff
+		    4: 00835001 10000001 00003c02 00000000
+		    5: 00000000 30000005 fffff003 7fffffff
+		    6: 00835001 10000001 00003c03 00000000
+		    7: 00000000 30000005 fffff003 7fffffff
+		    8: 00835001 10000001 00003c04 00000000
+		    9: 00000000 30000005 fffff003 7fffffff
+		   10: 00835001 10000001 00003c05 00000000
+		   11: 00000000 30000005 fffff003 7fffffff
+		  [...]
 
 What:		/sys/kernel/debug/iommu/amd/devid
 Date:		January 2025
@@ -63,19 +69,26 @@ Description:
 		interrupt remapping table and device table.
 
 		Example:
-		1.
-		$ echo 0000:01:00.0 > /sys/kernel/debug/iommu/amd/devid
-		$ cat /sys/kernel/debug/iommu/amd/devid
 
-		Output:
-		0000:01:00.0
+		1.
+		  ::
+
+		    $ echo 0000:01:00.0 > /sys/kernel/debug/iommu/amd/devid
+		    $ cat /sys/kernel/debug/iommu/amd/devid
+
+		  Output::
+
+		    0000:01:00.0
 
 		2.
-		$ echo 01:00.0 > /sys/kernel/debug/iommu/amd/devid
-		$ cat /sys/kernel/debug/iommu/amd/devid
+		  ::
 
-		Output:
-		0000:01:00.0
+		    $ echo 01:00.0 > /sys/kernel/debug/iommu/amd/devid
+		    $ cat /sys/kernel/debug/iommu/amd/devid
+
+		  Output::
+
+		    0000:01:00.0
 
 What:		/sys/kernel/debug/iommu/amd/devtbl
 Date:		January 2025
@@ -84,12 +97,14 @@ Description:
 		This file is a read-only output file containing the device table entry
 		for the device ID provided in /sys/kernel/debug/iommu/amd/devid.
 
-		Example:
-		$ cat /sys/kernel/debug/iommu/amd/devtbl
+		Example::
 
-		Output:
-		DeviceId             QWORD[3]         QWORD[2]         QWORD[1]         QWORD[0] iommu
-		0000:01:00.0 0000000000000000 20000001373b8013 0000000000000038 6000000114d7b603 iommu3
+		  $ cat /sys/kernel/debug/iommu/amd/devtbl
+
+		Output::
+
+		  DeviceId             QWORD[3]         QWORD[2]         QWORD[1]         QWORD[0] iommu
+		  0000:01:00.0 0000000000000000 20000001373b8013 0000000000000038 6000000114d7b603 iommu3
 
 What:		/sys/kernel/debug/iommu/amd/irqtbl
 Date:		January 2025
@@ -98,17 +113,19 @@ Description:
 		This file is a read-only output file containing valid IRT table entries
 		for the device ID provided in /sys/kernel/debug/iommu/amd/devid.
 
-		Example:
-		$ cat /sys/kernel/debug/iommu/amd/irqtbl
+		Example::
 
-		Output:
-		DeviceId 0000:01:00.0
-		IRT[0000] 0000000000000020 0000000000000241
-		IRT[0001] 0000000000000020 0000000000000841
-		IRT[0002] 0000000000000020 0000000000002041
-		IRT[0003] 0000000000000020 0000000000008041
-		IRT[0004] 0000000000000020 0000000000020041
-		IRT[0005] 0000000000000020 0000000000080041
-		IRT[0006] 0000000000000020 0000000000200041
-		IRT[0007] 0000000000000020 0000000000800041
-		[...]
+		  $ cat /sys/kernel/debug/iommu/amd/irqtbl
+
+		Output::
+
+		  DeviceId 0000:01:00.0
+		  IRT[0000] 0000000000000020 0000000000000241
+		  IRT[0001] 0000000000000020 0000000000000841
+		  IRT[0002] 0000000000000020 0000000000002041
+		  IRT[0003] 0000000000000020 0000000000008041
+		  IRT[0004] 0000000000000020 0000000000020041
+		  IRT[0005] 0000000000000020 0000000000080041
+		  IRT[0006] 0000000000000020 0000000000200041
+		  IRT[0007] 0000000000000020 0000000000800041
+		  [...]

base-commit: 4ba382d42e2dd8294311fd4ee1ad446c8e5585aa
-- 
An old man doll... just what I always wanted! - Clara

