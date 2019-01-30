From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Wed, 30 Jan 2019 20:11:19 +0000
Message-ID: <20190130201114.GB17915@mellanox.com>
References: <20190129215028.GQ3176@redhat.com>
 <deb7ba21-77f8-0513-2524-ee40a8ee35d5@deltatee.com>
 <20190129234752.GR3176@redhat.com>
 <655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
 <20190130041841.GB30598@mellanox.com>
 <bdf03cd5-f5b1-4b78-a40e-b24024ca8c9f@deltatee.com>
 <20190130185652.GB17080@mellanox.com> <20190130192234.GD5061@redhat.com>
 <20190130193759.GE17080@mellanox.com>
 <db873687-ff80-4758-0b9f-973f27db5335@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <db873687-ff80-4758-0b9f-973f27db5335@deltatee.com>
Content-Language: en-US
Content-ID: <1D7345561BF5804A8CD6EDF49CF98303@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jerome Glisse <jglisse@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 30, 2019 at 01:00:02PM -0700, Logan Gunthorpe wrote:

> We never changed SGLs. We still use them to pass p2pdma pages, only we
> need to be a bit careful where we send the entire SGL. I see no reason
> why we can't continue to be careful once their in userspace if there's
> something in GUP to deny them.
>=20
> It would be nice to have heterogeneous SGLs and it is something we
> should work toward but in practice they aren't really necessary at the
> moment.

RDMA generally cannot cope well with an API that requires homogeneous
SGLs.. User space can construct complex MRs (particularly with the
proposed SGL MR flow) and we must marshal that into a single SGL or
the drivers fall apart.

Jerome explained that GPU is worse, a single VMA may have a random mix
of CPU or device pages..

This is a pretty big blocker that would have to somehow be fixed.

> That doesn't even necessarily need to be the case. For HMM, I
> understand, struct pages may not point to any accessible memory and the
> memory that backs it (or not) may change over the life time of it. So
> they don't have to be strictly tied to BARs addresses. p2pdma pages are
> strictly tied to BAR addresses though.

No idea, but at least for this case I don't think we need magic HMM
pages to make simple VMA ops p2p_map/umap work..

Jason
