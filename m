Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9306390223;
	Fri,  4 Sep 2026 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513487; cv=none; b=sdT4BBfNYdhaq12A+bO8nNRmX9PgGIHxgE0enIPlNw/Wf2daLl8NvTDj6PYDoVet9e0DmlFJZO7FZOE2C7StjIwYszyjGBRpoiG8cCYswpZ9wtfY5mFIt5TgIWSRVpH8yLkBNXyOjc9SqodPS6SlUBIZ17d2GeruadPRlzctIao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513487; c=relaxed/simple;
	bh=p6zl3Bx/+fnwLMl9e4fYDAZXOxRfDOkLjFX7Wt3HU5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWnxcHGxCylzdMrKmZT7gAM1SM7TP8SRdK+qDgBwq0I9CRe9XhwGXTXBdcHuxCwgD8ka+um3sLhNfUf8Ax1AOotLJmd0iYKgyr6yYC9yiBHsITilicxQVsHx73j/CEtyVxYBmJmepZHF60ZaSM2aqTbT1//HJ3Hv4Ns9a2SRNww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msPE+bn4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msPE+bn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B601F00A3D;
	Fri,  4 Sep 2026 09:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788513486;
	bh=cHhZHi6z+RSI3UZ4dgvRXgLL51JFkNACGRRjgYWd8pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=msPE+bn4xnUWqrFS5CextPHonQgDG0lpeWlbSh8pgXApoO4p18HJZI7zB8iuBYjPD
	 ly1LKonR50bcBIK8fyv8H7EKs01v6S0N9/yLCy0sUiYyEu0QeOS1B+N9fjQ5ALeitB
	 AjXtYvOvRlhzqSodPcR75CHjVPW3hRMm0/jhTrGnPd/oMGqp/D6azfQdtlN3xpWejM
	 VXnh0XA6x5MII5z/qLzqr/thWg4yN9b35qqI733TNWWVnQrxbCp5uGFpTf1XY1zGYc
	 /yBuZnv31NkwRvXM3s9iNYZmcSnAE/gInqCk2mKvsEuiDE+FJ+jvBBWTU6vnt2MP34
	 GHQ0bdZeHHLWQ==
Date: Fri, 4 Sep 2026 11:18:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev
Subject: Re: [syzbot] [fs?] memory leak in path_openat (4)
Message-ID: <20260904-clown-zersplittern-sequenz-987f972a607b@brauner>
References: <6a8efe2e.1d9ded08.62e62.00b2.GAE@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a8efe2e.1d9ded08.62e62.00b2.GAE@google.com>

On Wed, Aug 26, 2026 at 07:54:38AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    26260251022f Merge tag 'livepatching-for-7.3' of git://git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1196a179580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6c1b5958b2d1207f
> dashboard link: https://syzkaller.appspot.com/bug?extid=7666ed2c3d42196bf7e3
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139f7179580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0f75e7622b1f/disk-26260251.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2bbff9fd7b60/vmlinux-26260251.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/95d733004907/bzImage-26260251.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com

#syz set subsystems: iommufd

This seems to be a reference cycle in iommufd. path_openat() and
alloc_empty_file() is just the place where the file is allocated.

The reproducer does:

  r0 = openat$iommufd(AT_FDCWD, "/dev/iommu", 0, 0)      /* → fd 4 */
  ioctl$IOMMU_IOAS_ALLOC(r0, 0x3b81, {size=0xc})         /* → ioas_id 1 */
  ioctl(r0, 0x3b8f, "2800...0400000000...0010")          /* IOMMU_IOAS_MAP_FILE */

So that last payload can be decoded as:

  iommu_ioas_map_file: size=40, flags=R|W, ioas_id=1, fd=4, start=0, length=0x1000

So fd is r0 itself which is the iommufd fd which is handed back to IOMMU_IOAS_MAP_FILE.

That causes a cycle:

iopt_map_file_pages() does fget(fd) without worrying what it calls it
on. So that does iopt_alloc_file_pages() which takes a long-term reference in pages->file = get_file(file)

The reference is dropped in iopt_release_pages() in fput(pages->file)
from the IOAS teardown. That in turn runs from iommufd_fops_release().

TL;DR:

  struct file(/dev/iommu)->private_data-> ictx->objects->ioas->iopt->area->iopt_pages
          ^                                                                    ^
          |____________________________ get_file() ____________________________|

Closing the fd does nothing. The hex dump shows the same pattern btw:

  - obj1 struct file @ ffff88812811f9c0, obj2 its LSM blob
  - obj3 iommufd_ctx @ ffff88811161cd80, first word = ffff88812811f9c0 → ictx->file is obj1
  - obj5 xa_node, its ->array = ffff88811161cd88 = &ictx->objects
  - obj4 iommufd_object: shortterm_users=1, users=1, type=4, id=1 → the IOAS with ioas_id == 1 from the repro
  - obj6 iopt_pages, kref == 1

Likely caused by f4986a72d6e4 ("iommufd: Add IOMMU_IOAS_MAP_FILE")

Afaic,t, this should either reject based on file->f_op == &iommufd_fops.
But iiuc there's other cycles that can be formed.
For example, via a vfio device fd that's bound to the iommufd. It holds an iommufd_ctx reference via iommufd_ctx_from_fd().
So mapping a bound but unattached vfio fd builds the same cycle.

So probably this should do validation what type of file can actually be
used like shmem and hugepage file.
