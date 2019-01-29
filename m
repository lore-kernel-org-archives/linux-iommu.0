From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Tue, 29 Jan 2019 13:43:02 -0700
Message-ID: <b3264844-2c04-6c34-f1e7-6b3bf9849a75@deltatee.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com>
 <c2c02af7-1d6f-e54f-c7fb-99c5b7776014@deltatee.com>
 <20190129194418.GG3176@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190129194418.GG3176@redhat.com>
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Glisse <jglisse@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Jason Gunthorpe <jgg@mellanox.com>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org



On 2019-01-29 12:44 p.m., Jerome Glisse wrote:
>> I'd suggest [1] should be a part of the patchset so we can actually see
>> a user of the stuff you're adding.
> 
> I did not wanted to clutter patchset with device driver specific usage
> of this. As the API can be reason about in abstract way.

It's hard to reason about an interface when you can't see what all the
layers want to do with it. Most maintainers (I'd hope) would certainly
never merge code that has no callers, and for much the same reason, I'd
rather not review patches that don't have real use case examples.

Logan
