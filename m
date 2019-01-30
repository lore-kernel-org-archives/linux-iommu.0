From: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is
 encrypted
Date: Wed, 30 Jan 2019 08:44:27 +0100
Message-ID: <20190130074427.GA29516@lst.de>
References: <87zhrj8kcp.fsf@morokweng.localdomain> <87womn8inf.fsf@morokweng.localdomain> <20190129134750-mutt-send-email-mst@kernel.org> <6c68f7f7-1b28-6eba-9b8b-2c32efac9701@redhat.com> <20190129213137-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190129213137-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@linux.ibm.com>, Paul Mackerras <paulus@ozlabs.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ram Pai <linuxram@us.ibm.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 29, 2019 at 09:36:08PM -0500, Michael S. Tsirkin wrote:
> This has been discussed ad nauseum. virtio is all about compatibility.
> Losing a couple of lines of code isn't worth breaking working setups.
> People that want "just use DMA API no tricks" now have the option.
> Setting a flag in a feature bit map is literally a single line
> of code in the hypervisor. So stop pushing for breaking working
> legacy setups and just fix it in the right place.

I agree with the legacy aspect.  What I am missing is an extremely
strong wording that says you SHOULD always set this flag for new
hosts, including an explanation why.
