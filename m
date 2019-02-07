From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/5 v6] Fix virtio-blk issue with SWIOTLB
Date: Thu, 7 Feb 2019 09:46:13 +0100
Message-ID: <20190207084613.GW32526@8bytes.org>
References: <20190131163403.11363-1-joro@8bytes.org>
 <20190205155133-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190205155133-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jfehlig@suse.com, jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de, Thomas.Lendacky@amd.com
List-Id: iommu@lists.linux-foundation.org

Hi Michael,

On Tue, Feb 05, 2019 at 03:52:38PM -0500, Michael S. Tsirkin wrote:
> On Thu, Jan 31, 2019 at 05:33:58PM +0100, Joerg Roedel wrote:
> > Changes to v5 are:
> > 
> > 	- Changed patch 3 to uninline dma_max_mapping_size()
> 
> And this lead to problems reported by kbuild :(

Hmm, I didn't get any kbuild emails for this series. Can you please
forward it me so that I can look into it?

> BTW when you repost, can I ask you to pls include
> the version in all patches? Both --subject-prefix
> and -v flags to git format-patch will do this for you.

Will do, thanks.


Regards,

	Joerg
