Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452471;
	b=5aIBbZKiiDZ4KBN8ZZdpy5eEc5dRdgbqkaXZVDFU2PS1k01wO7bkE/CSCZ1MyMVMR4ZS
	 LfEtpTsj4CgzBGq+B7szOUlBaUY0QB4l82Kct8oTp6Z4iYbTBAUBWAqHTjR+MAAO5We5H
	 IjInRxBrkwV3y+WfSerApn3W6opUMprXt/mXnVGwLREM9Oqf9BvPkkplQBWL7RrzqYGel
	 G7SetX+SbqRzYWrlzKCCqWOV8rGl37gtrfN0AFOdg5ePoXhmyiyNJ4NYBYd7jYJ8NpKON
	 Law6Zspq5vMKTtq96Dp0thMf0kxmD80gLyf4iitmeY4yDK9YytQte2B74N0sJjSOWMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452471;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7ytdFkLkeLcyVoJxpOipmWCYZtcUKYbCmGV4i9PFBK0=;
	b=4rlhlV1WPNeHQR6nsc6uO/VJOmtO1yFRP2f+8vI8KsLUntxSXTTwDvYf9H0R5/I57ZVt
	 UAqMKMn0itvxtuwzhJMk/TCq6zkrEtAdctkA401fi6V21TNRKTH+MIpM50qPTVCDNH4S8
	 jKhIeqUqvlY63lIznh86IQKlWQqss4qh7x/2Doa46sY6I4h32zy26evk7/Sb9c9sU0QVK
	 22VUact8TTkZtMJxvNMJ+ppZR5x8ye9kSSh9JoxQTIKdZi9VkZFQkbQgTzvjzura+yf0L
	 0UdXTHnwYGFK8PXooSU2tZGsQfEuvNujf+tH2Gom9vzkPPWzzq8GG+EViEA37/xftsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=nlrltakY;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEBD606A336
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 03:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDEBD606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=nlrltakY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=nlrltakYwm2yZQ7p3iItJW6CyUFEt4Y5HOP3LOwpE5O+DsrhPacu1phD64u1UlU9G8vlAmqmZMNYi
	 PGLJQLj6sCLxmxktFMmczaNgaBHGSLQ2EHBJ2RlXrjPTAc0M7lrbOv1NeHBYfpzjDlYfJT4I6uNY6w
	 YUoPzYxFJm/1DLUs=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26af52bf3f6b-18ed4;
	Thu, 12 Nov 2026 11:01:07 +0800 (CST)
X-RM-TRANSID:2ee26af52bf3f6b-18ed4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [25.255.2.225] (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36af52bf2d93-ef12e;
	Thu, 12 Nov 2026 11:01:07 +0800 (CST)
X-RM-TRANSID:2ee36af52bf2d93-ef12e
From: Jiahao Xu <xujiahao@cmss.chinamobile.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com,
	Jiahao Xu <xujiahao@cmss.chinamobile.com>
Subject: [PATCH] iommufd: reject mapping an iommufd file into an IOAS
Date: Thu, 12 Nov 2026 10:59:45 +0800
Message-ID: <20261112105945.285526-1-xujiahao@cmss.chinamobile.com>
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

iopt_map_file_pages() takes the fd passed to IOMMU_IOAS_MAP_FILE and, for
every file that is not a dma-buf, stores a reference to it in the pages
of the new mapping:

	iopt_map_file_pages()
	  iopt_alloc_file_pages()
	    pages->file = get_file(file)

iopt_release_pages() drops that reference only when the iopt_pages is
destroyed, which for a file mapping happens while the iommufd file is
being torn down.

Nothing validates what kind of file the fd refers to, so userspace can
pass the iommufd file itself, or two iommufd files whose IOASs map each
other.  The reference graph then contains a cycle:

	struct file (/dev/iommu) -> iommufd_ctx -> iommufd_ioas
	  -> io_pagetable -> iopt_area -> iopt_pages -> get_file(file)

Closing the fd drops no reference at all: the file's refcount cannot
reach zero while the iommufd_ctx it owns still holds a reference to it,
so iommufd_fops_release() never runs and the iopt_pages, the IOAS, the
iommufd_ctx and the struct file are all leaked.  kmemleak reports the
leak at the file allocation site ("memory leak in path_openat"), while
the holder stack of the same report shows the reference being taken
through iommufd_ioas_map_file() -> iopt_map_file_pages() ->
iopt_alloc_file_pages().

Reject an iommufd file before the reference is established, as Christian
Brauner suggested when the report was discussed ("this should either
reject based on file->f_op == &iommufd_fops").  iommufd_ctx_from_file()
already performs exactly that comparison against the static iommufd_fops
and is part of the public iommufd interface, so the check needs neither a
new symbol nor a new export and the fix fits in one file.  The extra
context reference it returns is dropped again immediately.

The check must not be placed after iopt_alloc_file_pages(): on an IOAS
with no attached domain the mapping can succeed without pinning
anything, so the reference is handed over to the iopt_area and the cycle
already exists, with no sensible place left to unwind it.

Limitations: this only rejects iommufd files.  A vfio device fd that is
bound to the same iommufd also holds an iommufd_ctx reference
(iommufd_ctx_from_fd()) and mapping such an fd can still build a cycle,
as Brauner pointed out.  This is also not the general validation of
which files may be mapped (memfd/shmem/hugepage) that Jason Gunthorpe
asked for in order to keep the memfd_pin_folios() decision on the mm
side.  Both remain to be addressed separately.

Fixes: f4986a72d6e4 ("iommufd: Add IOMMU_IOAS_MAP_FILE")
Reported-by: syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7666ed2c3d42196bf7e3
Link: https://lore.kernel.org/all/20260904-clown-zersplittern-sequenz-987f972a607b@brauner/
Signed-off-by: Jiahao Xu <xujiahao@cmss.chinamobile.com>
---
 drivers/iommu/iommufd/io_pagetable.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 5ac736cf5..fca14b012 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -510,11 +510,26 @@ int iopt_map_file_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
 		}
 	} else {
 		struct file *file;
+		struct iommufd_ctx *file_ictx;
 
 		file = fget(fd);
 		if (!file)
 			return -EBADF;
 
+		/*
+		 * Mapping an iommufd file would create a reference cycle:
+		 * file -> iommufd_ctx -> ioas -> iopt -> iopt_pages -> file.
+		 * The get_file() below can then never be released, since the
+		 * context that owns the file can never be destroyed.  Reject it
+		 * before the reference is transferred to the pages.
+		 */
+		file_ictx = iommufd_ctx_from_file(file);
+		if (!IS_ERR(file_ictx)) {
+			iommufd_ctx_put(file_ictx);
+			fput(file);
+			return -EINVAL;
+		}
+
 		pages = iopt_alloc_file_pages(file, start_byte, start, length,
 					      iommu_prot & IOMMU_WRITE);
 		fput(file);
-- 
2.43.0


