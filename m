From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 1/5] pci/p2p: add a function to test peer to peer
 capability
Date: Tue, 29 Jan 2019 13:24:48 -0700
Message-ID: <83acb590-25a5-f8ae-1616-bdb8b069fa0f@deltatee.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-2-jglisse@redhat.com>
 <CADnq5_N8QLA_80j+iCtMHvSZhc-WFpzdZhpk6jR9yhoNoUDFZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADnq5_N8QLA_80j+iCtMHvSZhc-WFpzdZhpk6jR9yhoNoUDFZA@mail.gmail.com>
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>, Jerome Glisse <jglisse@redhat.com>
Cc: linux-mm <linux-mm@kvack.org>, Joerg Roedel <jroedel@suse.de>, "Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felix Kuehling <Felix.Kuehling@amd.com>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@mellanox.com>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, Christian Koenig <christian.koenig@amd.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org



On 2019-01-29 12:56 p.m., Alex Deucher wrote:
> On Tue, Jan 29, 2019 at 12:47 PM <jglisse@redhat.com> wrote:
>>
>> From: Jérôme Glisse <jglisse@redhat.com>
>>
>> device_test_p2p() return true if two devices can peer to peer to
>> each other. We add a generic function as different inter-connect
>> can support peer to peer and we want to genericaly test this no
>> matter what the inter-connect might be. However this version only
>> support PCIE for now.
>>
> 
> What about something like these patches:
> https://cgit.freedesktop.org/~deathsimple/linux/commit/?h=p2p&id=4fab9ff69cb968183f717551441b475fabce6c1c
> https://cgit.freedesktop.org/~deathsimple/linux/commit/?h=p2p&id=f90b12d41c277335d08c9dab62433f27c0fadbe5
> They are a bit more thorough.

Those new functions seem to have a lot of overlap with the code that is
already upstream in p2pdma.... Perhaps you should be improving the
p2pdma functions if they aren't suitable for what you want already
instead of creating new ones.

Logan
