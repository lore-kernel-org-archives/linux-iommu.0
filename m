Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AC23BAD91
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979411; cv=none; b=dEinkp8LHZUtN9HhSkL+yi6nnl3C3oNbYcmITTwDt+XHwviKC4tP9N62GZ6qJ87LirAgdgc60/aK6Z6m5Oxmj9v3MH8Ai3Rxk4AoUhR4vclToo8PARzr0YfZvQXazYUN4ILAx4vuIv41q+zFQORRkrgqLa5zNZryhMOF+iZEP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979411; c=relaxed/simple;
	bh=dE5Wu3i/3oTCNIY4DxPIO1WQs74yLAprf78sku84Hgk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tYCnxZiBXpUIcdK4fE1rzfHmXddgmRAZv4VknpNXoVBMDL+L7CiXgOh0KYANDKsSgHra+L8eieEJE+kmgM+YvibEnL4GFEDk3HcyYgLN2aJWwv8JzbRil253H+xCEdBz5GxfVsezkyBfsme5I1ckJefrIBy4tB8nE/xG6/3mpE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NlVeGdBy; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NlVeGdBy"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c798ace3e03so2427181a12.0
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 14:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979407; x=1777584207; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cA/8iRDD7lhVYHGAuqnc3aBzPoZ7lUU2DgL4E3vJPEc=;
        b=NlVeGdByxVxwfe4Aw6oLSf0Ge6huJhRZi1P7G3O+pO0/e+rhWE6/ce5GKhJKMhMy9W
         BcnVmBPn5sn8wKyAkSeYazB9MPivoy0ccZlJ/nCpzrsLeu/O6xB1k2TRSK+nclTxLHcp
         Owt/FCwPry/LrWcypk3b0nAaojVFitH8d0WSD9ggp5vwEXsm+xIHNz6pktvf9GyLd7BX
         3Ac8fTVfG3l2qPrTnePcZVPoz+ca1RZRxlzphIFUNnR5lowXOPhkBaUGmWYyry+ce9HC
         8Q5w0U37C2di6K6NFvyQMLn11xjJF0qQk1YfytCnQVZGWJo5z9LkVZyi9fJrkrgMHpSQ
         YWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979407; x=1777584207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cA/8iRDD7lhVYHGAuqnc3aBzPoZ7lUU2DgL4E3vJPEc=;
        b=j10NIRQ5u2i8L2YybV0lXqwIOLy5Xw/20FypJCoHla28ufPWTmAUF98L+4TGthyPJ0
         KSzgYolcUsOtuBbRnW9N2ktHKCEC7LYsJmGpKuUk8B5PkHNG6y0bs/q0AW4h612oLrib
         iLM7sUjG0aTjHJaGYZSeicnKIn3P6RwEYjtzCeRXqIN+BCiY+1hmp29nsbXoADi/30s/
         99OPkqVy8n+F6k45EwJX6eWAd3oGrEVzs1dnNWPlepO0EUWq49N+HHcjO10Bg3ZD+dZb
         qgJudLTZLCayV7Db/ze2Tz1DQit8wYC+cw9SUBbRdznrLvwfwBORiFbwUC+FQQ86aKTB
         Nu5A==
X-Gm-Message-State: AOJu0Ywxcg68H8yMJ7W1gVOLF4jHKinILwSk0S7wvuNoz6vb2H3nHe3e
	pM4dDEmoYUqJZ8FjVZqq+EQ8grWpAxgDV/faiaAn+B2TqflvwhAJHSpkrH3PqdMYxq985mYpgh1
	VDg3r6oezjDcvetYG0BNmRhwaTpxSy63sCbQfTpp4idIJ+zRZrgGHTerACRQ2a2KLZ9Dpmb4bac
	yWlbkwOhi4DxMpyur+OYofjuqFTHhdjDoVEVsastIWJzdS2w==
X-Received: from pgjm19.prod.google.com ([2002:a63:fd53:0:b0:c79:7f30:5d18])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3399:b0:398:7982:21df with SMTP id adf61e73a8af0-3a08d687673mr31625673637.9.1776979406884;
 Thu, 23 Apr 2026 14:23:26 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:23:08 +0000
In-Reply-To: <20260423212316.3431746-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212316.3431746-5-dmatlack@google.com>
Subject: [PATCH v4 04/11] PCI: liveupdate: Document driver binding responsibilities
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

Document how driver binding works during a Live Update and what the PCI
core expects of drivers and users. Note that this is only a description
of the current division of responsibilities. These can change in the
future if we decide.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index e616cecc37c8..c0a30d16d9b8 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -77,6 +77,22 @@
  * preserved. These may be relaxed in the future:
  *
  *  * The device cannot be a Virtual Function (VF).
+ *
+ * Driver Binding
+ * ==============
+ *
+ * In the outgoing kernel, it is the driver's responsibility to ensure that it
+ * does not release a device between pci_liveupdate_preserve() and
+ * pci_liveupdate_unpreserve().
+ *
+ * In the incoming kernel, it is the driver's responsibility to ensure that it
+ * does not release a preserved device between probe() and
+ * pci_liveupdate_finish().
+ *
+ * It is the user's responsibility to ensure that incoming preserved devices are
+ * bound to the correct driver. i.e. The PCI core does not protect against a
+ * device getting preserved by driver A in the outgoing kernel and then getting
+ * bound to driver B in the incoming kernel.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

