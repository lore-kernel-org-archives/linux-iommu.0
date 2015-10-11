From: Gleb Natapov <gleb@scylladb.com>
Subject: Re: [RFC PATCH 2/2] vfio: Include no-iommu mode
Date: Sun, 11 Oct 2015 12:23:03 +0300
Message-ID: <20151011092303.GA19867@scylladb.com>
References: <20151009182228.14752.99700.stgit@gimli.home>
 <20151009184110.14752.53531.stgit@gimli.home>
 <561A19DE.8040302@scylladb.com>
 <20151011115503-mutt-send-email-mst@redhat.com>
 <561A25D5.6020906@scylladb.com>
 <20151011091954.GA27451@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151011091954.GA27451@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Avi Kivity <avi@scylladb.com>, Alex Williamson <alex.williamson@redhat.com>, avi@cloudius-systems.com, corbet@lwn.net, bruce.richardson@intel.com, linux-kernel@vger.kernel.org, alexander.duyck@gmail.com, gleb@cloudius-systems.com, stephen@networkplumber.org, vladz@cloudius-systems.com, iommu@lists.linux-foundation.org, hjk@hansjkoch.de, gregkh@linuxfoundation.org
List-Id: iommu@lists.linux-foundation.org

On Sun, Oct 11, 2015 at 12:19:54PM +0300, Michael S. Tsirkin wrote:
> > But since you must pass the same value to open(), you already know that
> > you're using noiommu.
> > 
> > >VFIO_IOMMU_MAP_DMA, VFIO_IOMMU_ENABLE and VFIO_IOMMU_DISABLE
> > >will probably also fail ...
> > >
> > 
> > Don't you have to call MAP_DMA to pin the memory?
> 
> Well check it out - the patch in question doesn't implement this ioctl.
> In fact it doesn't implement anything except CHECK_EXTENSION.
> 
> And this makes sense to me: MAP_DMA
> maps a virtual address to io address, and that doesn't
> work for the dummy iommu.
> 
> You can pin memory using many other ways, including
> mlock and hugetlbfs.
> 
mlock() does not pin memory.

--
			Gleb.
