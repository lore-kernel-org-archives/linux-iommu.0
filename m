Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795056735;
	b=SqApMW3IbNHP0wSit+YfE/woqG3bgZm7WIkXz9WHfIqqdLDbn8B71RNYcRCP8n7OXine
	 kEBhd5lfkiyHiGeey9nf59Jud+Spx9HGp5TDmu8Q8YsqRs8Ea/2Esfq8QZxVC/uAe7BeY
	 2+w1zZYLVz9JfVhhPGShvlXOelEAO8qTdKZR4zUgHR6TbPDDa8324VkM0+eIDiZYtRE7M
	 eTw+iOiVIqPi6k3dcg8vLTOQvCHtek24RA+Bj6OSXPYVOKJY4TlAHR+/V2sVec75PNnte
	 CbUAY3sjHKwNbKY+FjmVJiZPfHHZS85QM1RY0JTz4QVahdJ0pMV57qONrtXXMTubyZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795056735;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4NdHmfe8yI77qDKx7cyN5pAzKdZzXmgNff3sue1UTXU=;
	b=d4IgizBRHujey+mOijZU4ObvNkWewuGdqkTUhtVThsq21EhRwoWwDi06Bafgq+RN3TPo
	 p63d+MbIcNQX0APpKnZ86lG3Vo9nghW3OpymsjnrgElSrIoASb/HvP/OikUkNG/T0UP90
	 KdtM7xK0aF0wVWYhTuKqMzh/SpY52LngaUwJn4XZewkE6G9r8HtaJEJz1tY/gsSctrRd9
	 twX3IfIsFGg78eGsDdBPhUWCqukbKTWj3XheOqhpG8xRkhl+Hk7QcHETIu3obNEhBbj23
	 zPY/8P6+LzT4ux04FVWM1LFfEiZ337XViA6mQnKUrVrPr+7TUV2I/OcZhvFq6m3d+XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=rItD+Bs3;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730CF606A330
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 02:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 730CF606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=rItD+Bs3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=rItD+Bs3Ba485YEI+up8kA+1rzBWyGIGyh7av54OD1yf4np/gZgO8lHGsArvngO1h/9auzoXJRdbi
	 Iu1JWt2xFX/JfKKKmlibolX65qaTWfE4PWXAaXSj/eHoddKssemRmiC4tG8Jna3HvkSKL30v6jlTGP
	 lhQs/8LJIBZKwnPQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86afe64434ca-b8b77;
	Thu, 19 Nov 2026 10:51:47 +0800 (CST)
X-RM-TRANSID:2ee86afe64434ca-b8b77
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [25.255.2.225] (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36afe6441bb2-05c83;
	Thu, 19 Nov 2026 10:51:47 +0800 (CST)
X-RM-TRANSID:2ee36afe6441bb2-05c83
From: Jiahao Xu <xujiahao@cmss.chinamobile.com>
To: Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, David Hildenbrand <david@kernel.org>, John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Samiullah Khawaja <skhawaja@google.com>,
	syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com, Jiahao Xu <xujiahao@cmss.chinamobile.com>
Subject: [PATCH 2/2] iommufd: only hold references to files memfd_pin_folios() can pin
Date: Thu, 19 Nov 2026 10:44:17 +0800
Message-ID: <20261119104417.459962-1-xujiahao@cmss.chinamobile.com>
In-Reply-To: <20261119104417.312237-1-xujiahao@cmss.chinamobile.com>
References: <20261119104417.312237-1-xujiahao@cmss.chinamobile.com> <20261119104417.312237-1-xujiahao@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iopt_map_file_pages() stores a reference to the file passed to
IOMMU_IOAS_MAP_FILE in the iopt_pages of the new mapping:

	iopt_map_file_pages()
	  iopt_alloc_file_pages()
	    pages->file = get_file(file)

iopt_release_pages() drops that reference only when the iopt_pages is
destroyed, which for a file mapping happens while the iommufd file is
being torn down.  Nothing restricts which file can be passed, so
userspace can map the iommufd file itself, or a vfio device fd bound to
the same iommufd, both of which own an iommufd_ctx reference.  The
reference graph then contains a cycle and the file, the iopt_pages, the
IOAS and the iommufd_ctx are all leaked; kmemleak reports it as
"memory leak in path_openat" with the holder taken through
iopt_map_file_pages().

Reverse the test instead of trying to enumerate the files that own an
iommufd_ctx: accept only the files that memfd_pin_folios() is able to
pin, which is exactly the set of files the mapping can be built from.
memfd_pin_folios_supported() reports that set, so the same test can run
here before the reference is handed to iopt_pages.  dma-bufs are
unaffected: they are taken by the dma_buf_get() branch above and never
reach the file branch, and iopt_pages holds the dma_buf there, not a
struct file.

Fixes: f4986a72d6e4 ("iommufd: Add IOMMU_IOAS_MAP_FILE")
Reported-by: syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7666ed2c3d42196bf7e3
Signed-off-by: Jiahao Xu <xujiahao@cmss.chinamobile.com>
---
v3:
 - Call the new memfd_pin_folios_supported() helper instead of shmem_file().
   shmem_file() became an out-of-line function in mm/shmem.c that is not
   exported, so calling it from iommufd.ko failed at modpost with
   "symbol 'shmem_file' undefined!".  Reported by Jason Gunthorpe.
v2: https://lore.kernel.org/all/20261117093244.652569-1-xujiahao@cmss.chinamobile.com/
v1: https://lore.kernel.org/all/20261112105945.285526-1-xujiahao@cmss.chinamobile.com/
---
 drivers/iommu/iommufd/io_pagetable.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 5ac736cf5..ab43e656d 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -515,6 +515,18 @@ int iopt_map_file_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
 		if (!file)
 			return -EBADF;
 
+		/*
+		 * iopt_pages keeps a reference to the file until the mapping is
+		 * destroyed, so only accept the files memfd_pin_folios() is able
+		 * to pin.  Any other fd, in particular one that itself owns an
+		 * iommufd_ctx (iommufd, vfio, ...), would put the file into a
+		 * reference cycle with this iommufd and never be released.
+		 */
+		if (!memfd_pin_folios_supported(file)) {
+			fput(file);
+			return -EINVAL;
+		}
+
 		pages = iopt_alloc_file_pages(file, start_byte, start, length,
 					      iommu_prot & IOMMU_WRITE);
 		fput(file);
-- 
2.43.0


