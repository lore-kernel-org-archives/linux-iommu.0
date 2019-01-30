From: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Wed, 30 Jan 2019 08:52:56 +0100
Message-ID: <20190130075256.GA29665@lst.de>
References: <20190129174728.6430-1-jglisse@redhat.com> <20190129174728.6430-4-jglisse@redhat.com> <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com> <20190129191120.GE3176@redhat.com> <c2c02af7-1d6f-e54f-c7fb-99c5b7776014@deltatee.com> <20190129194418.GG3176@redhat.com> <b3264844-2c04-6c34-f1e7-6b3bf9849a75@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b3264844-2c04-6c34-f1e7-6b3bf9849a75@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jerome Glisse <jglisse@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Jason Gunthorpe <jgg@mellanox.com>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 29, 2019 at 01:43:02PM -0700, Logan Gunthorpe wrote:
> It's hard to reason about an interface when you can't see what all the
> layers want to do with it. Most maintainers (I'd hope) would certainly
> never merge code that has no callers, and for much the same reason, I'd
> rather not review patches that don't have real use case examples.

Yes, we should never review, nevermind merge code without users.
We had one example recently where this was not followed, which was HMM
and that turned out to be a desaster.
