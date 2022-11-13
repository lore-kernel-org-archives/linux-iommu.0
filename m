Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2A82F5F
	for <iommu@lists.linux.dev>; Sun, 13 Nov 2022 20:34:02 +0000 (UTC)
Message-ID: <20221113201935.776707081@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1668371635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=7MxnopjDUQ1bdcA7I42+FS4FruEBgUMrTam7b1hHOfY=;
	b=GD7AYqNO+9zs89yvH9A3kuIe3BFCbmfyUX9bM5DxoGC2/9W9NdipMWcwOhTl9Pifdc0yCX
	EDhvw2y+NoWqtlUiYz9FJqPR9CQny0Z12KgZ1d5E+TGqMmHlGz7MsPwC8U14oZBCtfjm6E
	REU/mFYEcZcwcS0BNroWm8KMYTtPidN5lfjTpV++dxwqsHCUccIX2hT1SqgjPzktYZ+lG4
	iELCXsN4rAiDDZdNSxbOCmhU6ODxCoqh5FpA0V3jZkg/TqabJcXckbAakEpN9zUH++JIo7
	t5Thzi4kcs9WVGg3Y1kptNIVVOv3RRInTTR/1b4TKFM82gG7b4uRm+PuDFV7Hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1668371635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=7MxnopjDUQ1bdcA7I42+FS4FruEBgUMrTam7b1hHOfY=;
	b=TOAACLZw9M5uSJ1ngz5jOUvHAmnmW+licTR7ipmgh8VxLfj/M9NIf4LtBb5fWxUDQ+jAKO
	PNfZNRVVBs7etJCQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
 Lee Jones <lee@kernel.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 linux-ide@vger.kernel.org,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org,
 Stuart Yoder <stuyoder@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 Simon Horman <simon.horman@corigine.com>,
 oss-drivers@corigine.com,
 Roy Pledge <Roy.Pledge@nxp.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 kvm@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev
Subject:
 [patch 00/10] genirq/msi: Treewide cleanup of pointless linux/msi.h includes
Date: Sun, 13 Nov 2022 21:33:54 +0100 (CET)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

While working on per device MSI domains I noticed that quite some files
include linux/msi.h just because.

The top level comment in the header file clearly says:

  Regular device drivers have no business with any of these functions....

and actually none of the drivers needs anything from msi.h.

The series is not depending on anything so the individual patches can be
picked up by the relevant maintainers. I'll mop up the leftovers close to
the merge window.

Thanks,

	tglx
