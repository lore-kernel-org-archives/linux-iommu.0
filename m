From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Tue, 29 Jan 2019 20:24:36 +0000
Message-ID: <20190129202429.GL10108@mellanox.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com> <20190129193250.GK10108@mellanox.com>
 <20190129195055.GH3176@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190129195055.GH3176@redhat.com>
Content-Language: en-US
Content-ID: <7B9013D8E8AFBE418AC181CA1F1B161F@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Glisse <jglisse@redhat.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 29, 2019 at 02:50:55PM -0500, Jerome Glisse wrote:

> GPU driver do want more control :) GPU driver are moving things around
> all the time and they have more memory than bar space (on newer platform
> AMD GPU do resize the bar but it is not the rule for all GPUs). So
> GPU driver do actualy manage their BAR address space and they map and
> unmap thing there. They can not allow someone to just pin stuff there
> randomly or this would disrupt their regular work flow. Hence they need
> control and they might implement threshold for instance if they have
> more than N pages of bar space map for peer to peer then they can decide
> to fall back to main memory for any new peer mapping.

But this API doesn't seem to offer any control - I thought that
control was all coming from the mm/hmm notifiers triggering p2p_unmaps?

I would think that the importing driver can assume the BAR page is
kept alive until it calls unmap (presumably triggered by notifiers)?

ie the exporting driver sees the BAR page as pinned until unmap.

Jason
